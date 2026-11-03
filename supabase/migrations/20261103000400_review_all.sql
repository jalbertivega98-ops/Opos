-- Aprobar y publicar TODO lo pendiente con un solo clic de la persona titular
-- (DEC-006, petición de joel 2026-11-03). Cada pregunta sigue pasando por el
-- guardián de estados y queda auditada; además se publican los packs y
-- simulacros en borrador que se alimentan de esos temas (config.topic_prefix)
-- y ya tienen preguntas suficientes. El contenido de prueba no se toca.

create or replace function public.content_status_counts()
returns table (status public.content_status, flagged boolean, total bigint)
language sql stable security invoker set search_path = '' as $$
  select q.status, q.review_note is not null, count(*)
    from public.questions q
   where q.is_test = false and q.topic_id is not null
   group by 1, 2
$$;
revoke execute on function public.content_status_counts() from anon, public;
grant execute on function public.content_status_counts() to authenticated;

create or replace function public.review_all_batch(p_include_flagged boolean default false)
returns jsonb
language plpgsql security invoker set search_path = '' as $$
declare
  v_slug text;
  v_published int := 0;
  v_products int := 0;
  v_p record;
begin
  if not public.is_owner() then
    raise exception 'Solo la persona titular puede aprobar o publicar por lotes' using errcode = '42501';
  end if;

  for v_slug in
    select distinct t.slug from public.topics t
      join public.questions q on q.topic_id = t.id
     where q.is_test = false and q.status in ('draft', 'needs_review', 'approved')
     order by t.slug
  loop
    perform public.review_topic_batch(v_slug, 'approved', p_include_flagged);
    v_published := v_published + public.review_topic_batch(v_slug, 'published', p_include_flagged);
  end loop;

  -- packs y simulacros en borrador que ya tienen contenido publicado
  for v_p in
    select p.id, p.type, p.config from public.products p
     where p.status = 'draft' and p.is_test = false and p.config ? 'topic_prefix'
       and p.type in ('question_pack', 'mock_exam')
  loop
    if (v_p.type = 'question_pack'
          and exists (select 1 from public.product_items i
                        join public.questions q on q.id = i.question_id
                       where i.product_id = v_p.id and q.status = 'published'))
       or (v_p.type = 'mock_exam'
          and (select count(*) from public.questions q
                 join public.topics t on t.id = q.topic_id
                where q.status = 'published' and q.is_test = false
                  and t.slug like (v_p.config->>'topic_prefix') || '%'
                  and (v_p.config->>'locale' is null or q.locale::text = v_p.config->>'locale'))
              >= (public.mock_config(v_p.config)->>'questions')::int) then
      update public.products set status = 'published' where id = v_p.id;
      v_products := v_products + 1;
    end if;
  end loop;

  perform public.log_admin_action('content.publish_all', 'questions', null,
    jsonb_build_object('questions', v_published, 'products', v_products,
                       'include_flagged', p_include_flagged));
  return jsonb_build_object('questions', v_published, 'products', v_products);
end $$;
revoke execute on function public.review_all_batch(boolean) from anon, public;
grant execute on function public.review_all_batch(boolean) to authenticated;

-- Packs que se llenan solos: respetan también config.locale si existe
-- (los packs de Mossos son solo en catalán).
create or replace function public.tg_questions_autopack()
returns trigger language plpgsql security definer set search_path = '' as $$
declare
  v_slug text;
begin
  if new.status = 'published' and old.status is distinct from 'published' and new.topic_id is not null then
    select slug into v_slug from public.topics where id = new.topic_id;
    insert into public.product_items (product_id, position, question_id)
    select p.id,
           coalesce((select max(position) from public.product_items where product_id = p.id), 0) + 1,
           new.id
      from public.products p
     where p.type = 'question_pack' and p.config ? 'topic_prefix'
       and v_slug like (p.config->>'topic_prefix') || '%'
       and (p.config->>'locale' is null or p.config->>'locale' = new.locale::text)
       and p.is_test = new.is_test
    on conflict do nothing;
  end if;
  return null;
end $$;

update public.products
   set config = config || '{"locale":"ca"}'::jsonb
 where slug in ('mossos-ambit-a-guia-2026', 'mossos-ambit-b-guia-2026', 'mossos-ambit-c-guia-2026')
   and not config ? 'locale';
