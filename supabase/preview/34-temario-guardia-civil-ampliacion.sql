-- Guardia Civil, ampliación con todo el temario oficial: 430 preguntas y fichas (ONU, tortura, UE, organismos internacionales, Defensa, Servicios Centrales, historia, CCN-CERT, topografía, contrabando, código aduanero, inglés, ortografía y gramática): preguntas en BORRADOR con cita literal de la fuente oficial y fichas de estudio.
-- Generado: bash scripts/content/preview-sql.sh content/guardia-civil (solo los archivos nuevos) supabase/preview/34-temario-guardia-civil-ampliacion.sql. Idempotente.
begin;
-- Lote gc-01b-naciones-unidas-dh_carta_onu-v1 (13 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Carta de las Naciones Unidas (texto completo)', 'https://www.un.org/es/about-us/un-charter/full-text', 'web_oficial'::public.source_kind, 'Naciones Unidas (un.org)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-01b-naciones-unidas', 'Tema 1. Derechos humanos (II): Carta de las Naciones Unidas, sus órganos, DUDH y Consejo de Derechos Humanos') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-01b-naciones-unidas' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 7 de la Carta de las Naciones Unidas, ¿cuál de los siguientes es uno de los órganos principales de las Naciones Unidas?', 'El art. 7 de la Carta enumera seis órganos principales: Asamblea General, Consejo de Seguridad, Consejo Económico y Social, Consejo de Administración Fiduciaria, Corte Internacional de Justicia y Secretaría. El Consejo de Derechos Humanos es un órgano creado por la Asamblea General en 2006.', 'gc_01b_naciones_unidas', (select id from public.topics where slug = 'gc-01b-naciones-unidas'), 1, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/un-charter/full-text'), 'Art. 7 Carta ONU', 'Se establecen como órganos principales de las Naciones Unidas: una Asamblea General, un Consejo de Seguridad, un Consejo Económico y Social, un Consejo de Administración Fiduciaria, una Corte Internacional de Justicia, una Secretaría.', null, 'd06405e45ba63aeea8be5614913710ddf4ba0ac83d80e9fc1eee5ef797f8942e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd06405e45ba63aeea8be5614913710ddf4ba0ac83d80e9fc1eee5ef797f8942e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Consejo de Derechos Humanos.', false), ('B', 'El Comité de Estado Mayor.', false), ('C', 'El Consejo de Administración Fiduciaria.', true), ('D', 'La Oficina del Alto Comisionado para los Derechos Humanos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 9 de la Carta de las Naciones Unidas, ¿cuántos representantes puede tener como máximo cada Miembro en la Asamblea General?', 'El art. 9 dispone que la Asamblea General está integrada por todos los Miembros y que ninguno podrá tener más de cinco representantes. En el Consejo de Seguridad y en el Consejo Económico y Social cada miembro tiene un representante (arts. 23 y 61).', 'gc_01b_naciones_unidas', (select id from public.topics where slug = 'gc-01b-naciones-unidas'), 2, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/un-charter/full-text'), 'Art. 9 Carta ONU', 'La Asamblea General estará integrada por todos los Miembros de las Naciones Unidas. Ningun Miembro podrá tener más de cinco representantes en la Asamblea General.', null, '04eaa9722d2728222cf2032c752221ea9a362322a375d93377c6c8717d36b263', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '04eaa9722d2728222cf2032c752221ea9a362322a375d93377c6c8717d36b263')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Uno.', false), ('B', 'Cinco.', true), ('C', 'Tres.', false), ('D', 'Diez.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 18 de la Carta de las Naciones Unidas, las decisiones de la Asamblea General en cuestiones importantes se tomarán por:', 'El art. 18 exige dos tercios de los miembros presentes y votantes para las cuestiones importantes (paz y seguridad, elección de miembros no permanentes del Consejo de Seguridad y del ECOSOC, admisión, suspensión y expulsión de Miembros, presupuesto…); las demás se deciden por mayoría de los presentes y votantes.', 'gc_01b_naciones_unidas', (select id from public.topics where slug = 'gc-01b-naciones-unidas'), 2, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/un-charter/full-text'), 'Art. 18 Carta ONU', 'Las decisiones de la Asamblea General en cuestiones importantes se tomarán por el voto de una mayoria de dos tercios de los miembros presentes y votantes.', null, '34ddb85ceec7551902dbda236c3edad4d6e27bf84b9e05b32eef19c9041ef4e4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '34ddb85ceec7551902dbda236c3edad4d6e27bf84b9e05b32eef19c9041ef4e4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Mayoría de dos tercios de los miembros presentes y votantes.', true), ('B', 'Mayoría simple de los miembros presentes y votantes.', false), ('C', 'Mayoría de tres quintos de todos los Miembros de la Organización.', false), ('D', 'Unanimidad de los miembros permanentes del Consejo de Seguridad.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Conforme al artículo 19 de la Carta de las Naciones Unidas, el Miembro que esté en mora en el pago de sus cuotas no tendrá voto en la Asamblea General cuando la suma adeudada sea igual o superior al total de las cuotas adeudadas por:', 'El art. 19 fija el umbral en las cuotas de los dos años anteriores completos, aunque la Asamblea General puede permitir votar al Miembro si la mora se debe a circunstancias ajenas a su voluntad.', 'gc_01b_naciones_unidas', (select id from public.topics where slug = 'gc-01b-naciones-unidas'), 3, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/un-charter/full-text'), 'Art. 19 Carta ONU', 'no tendra voto en la Asamblea General cuando la suma adeudada sea igual o superior al total de las cuotas adeudadas por los dos años anteriores completos.', null, '468ced0330be4dd5590cab8ce18a03d35ebf3db6cf93a1702e556c8e1ae4effd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '468ced0330be4dd5590cab8ce18a03d35ebf3db6cf93a1702e556c8e1ae4effd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El año anterior completo.', false), ('B', 'Los tres años anteriores completos.', false), ('C', 'Los cinco años anteriores completos.', false), ('D', 'Los dos años anteriores completos.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 23 de la Carta de las Naciones Unidas, el Consejo de Seguridad se compondrá de:', 'El art. 23 establece quince miembros: cinco permanentes (China, Francia, la entonces URSS, Reino Unido y Estados Unidos) y diez no permanentes elegidos por la Asamblea General.', 'gc_01b_naciones_unidas', (select id from public.topics where slug = 'gc-01b-naciones-unidas'), 1, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/un-charter/full-text'), 'Art. 23 Carta ONU', 'El Consejo de Seguridad se compondrá de quince miembros de las Naciones Unidas.', null, '9af804315ce7d8dcc9b1b898c5d30a75807c108165ce94d4e7717c21ecdcf24e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9af804315ce7d8dcc9b1b898c5d30a75807c108165ce94d4e7717c21ecdcf24e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Once miembros de las Naciones Unidas.', false), ('B', 'Quince miembros de las Naciones Unidas.', true), ('C', 'Cinco miembros permanentes y cinco no permanentes.', false), ('D', 'Cincuenta y cuatro miembros de las Naciones Unidas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 23 de la Carta de las Naciones Unidas, los miembros no permanentes del Consejo de Seguridad:', 'El art. 23 fija un mandato de dos años para los diez miembros no permanentes y prohíbe la reelección inmediata para el periodo subsiguiente.', 'gc_01b_naciones_unidas', (select id from public.topics where slug = 'gc-01b-naciones-unidas'), 2, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/un-charter/full-text'), 'Art. 23 Carta ONU', 'Los miembros no permanentes del Consejo de Seguridad serán elegidos por un periodo de dos años. […] Los miembros salientes no serán reelegibles para el periodo subsiguiente.', null, '16e531ebb1e0cdc3359b61a8b4794de03a078657d0245bf153f45ee2da42e04c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '16e531ebb1e0cdc3359b61a8b4794de03a078657d0245bf153f45ee2da42e04c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Son elegidos por un periodo de dos años y los salientes no son reelegibles para el periodo subsiguiente.', true), ('B', 'Son elegidos por un periodo de tres años y pueden ser reelegidos una sola vez.', false), ('C', 'Son elegidos por un periodo de cuatro años y se renuevan por mitades.', false), ('D', 'Son elegidos por un periodo de dos años y pueden ser reelegidos de forma inmediata.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 27 de la Carta de las Naciones Unidas, las decisiones del Consejo de Seguridad sobre cuestiones de procedimiento serán tomadas por:', 'En cuestiones de procedimiento basta el voto afirmativo de nueve miembros; en las demás cuestiones se exigen nueve votos afirmativos que incluyan los de todos los miembros permanentes (art. 27).', 'gc_01b_naciones_unidas', (select id from public.topics where slug = 'gc-01b-naciones-unidas'), 3, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/un-charter/full-text'), 'Art. 27 Carta ONU', 'Las decisiones del Consejo de Seguridad sobre cuestiones de procedimiento serán tomadas por el voto afirmativo de nueve miembros.', null, '043f06f688865fe9f1ebea74151c629c28fe422dff5669d0600d94f29136c87e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '043f06f688865fe9f1ebea74151c629c28fe422dff5669d0600d94f29136c87e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El voto afirmativo de nueve miembros, incluidos los votos afirmativos de todos los miembros permanentes.', false), ('B', 'La mayoría de dos tercios de los miembros presentes y votantes.', false), ('C', 'El voto afirmativo de nueve miembros.', true), ('D', 'El voto afirmativo de diez miembros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 4 de la Carta de las Naciones Unidas, la admisión de nuevos Miembros se efectuará por decisión de:', 'El art. 4 atribuye la admisión a la Asamblea General a recomendación del Consejo de Seguridad; el mismo esquema rige para la suspensión (art. 5) y la expulsión (art. 6).', 'gc_01b_naciones_unidas', (select id from public.topics where slug = 'gc-01b-naciones-unidas'), 2, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/un-charter/full-text'), 'Art. 4 Carta ONU', 'La admisión de tales Estados como Miembros de las Naciones Unidas se efectuará por decisión de la Asamblea General a recomendación del Consejo de Seguridad.', null, '9f40fa750f82ab806b2c98fb8919820c46486f33353a52505b9bbc86b3d028d6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9f40fa750f82ab806b2c98fb8919820c46486f33353a52505b9bbc86b3d028d6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Consejo de Seguridad a recomendación de la Asamblea General.', false), ('B', 'El Secretario General con el consentimiento del Consejo de Seguridad.', false), ('C', 'La Asamblea General por mayoría simple, sin intervención del Consejo de Seguridad.', false), ('D', 'La Asamblea General a recomendación del Consejo de Seguridad.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 6 de la Carta de las Naciones Unidas, el Miembro que haya violado repetidamente los Principios contenidos en la Carta:', 'El art. 6 prevé la expulsión por la Asamblea General a recomendación del Consejo de Seguridad para el Miembro que haya violado repetidamente los Principios de la Carta.', 'gc_01b_naciones_unidas', (select id from public.topics where slug = 'gc-01b-naciones-unidas'), 2, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/un-charter/full-text'), 'Art. 6 Carta ONU', 'Todo Miembro de las Naciones Unidas que haya violado repetidamente los Principios contenidos en esta Carta podrá ser expulsado de la Organización por la Asamblea General a recomendación del Consejo de Seguridad.', null, 'a1ea82038a75fb56f087631e4774f35a3c70db45917a495098c698ba66513c59', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a1ea82038a75fb56f087631e4774f35a3c70db45917a495098c698ba66513c59')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Podrá ser expulsado por el Consejo de Seguridad sin intervención de la Asamblea General.', false), ('B', 'Podrá ser expulsado de la Organización por la Asamblea General a recomendación del Consejo de Seguridad.', true), ('C', 'Podrá ser expulsado por la Corte Internacional de Justicia a instancia de cualquier Miembro.', false), ('D', 'Solo podrá ser suspendido en sus derechos, pero nunca expulsado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 61 de la Carta de las Naciones Unidas, el Consejo Económico y Social estará integrado por:', 'El art. 61 fija en cincuenta y cuatro los miembros del ECOSOC, elegidos por la Asamblea General (antes de la reforma eran veintisiete). Cuarenta y siete es la composición del Consejo de Derechos Humanos.', 'gc_01b_naciones_unidas', (select id from public.topics where slug = 'gc-01b-naciones-unidas'), 2, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/un-charter/full-text'), 'Art. 61 Carta ONU', 'El Consejo Económico y Social estará integrado por cincuenta y cuatro Miembros de las Naciones Unidas elegidos por la Asamblea General.', null, 'ca7b57a963cef3f4a66ec9a7b6afa1e69dc0f4df71de4047e763227844cc110f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ca7b57a963cef3f4a66ec9a7b6afa1e69dc0f4df71de4047e763227844cc110f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Veintisiete Miembros de las Naciones Unidas elegidos por la Asamblea General.', false), ('B', 'Cuarenta y siete Miembros de las Naciones Unidas elegidos por la Asamblea General.', false), ('C', 'Quince Miembros de las Naciones Unidas elegidos por el Consejo de Seguridad.', false), ('D', 'Cincuenta y cuatro Miembros de las Naciones Unidas elegidos por la Asamblea General.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Conforme al artículo 61 de la Carta de las Naciones Unidas, ¿cuántos miembros del Consejo Económico y Social se eligen cada año y por qué periodo?', 'El art. 61 dispone que dieciocho miembros del ECOSOC se eligen cada año por tres años y que los salientes son reelegibles para el periodo subsiguiente (a diferencia de los miembros no permanentes del Consejo de Seguridad).', 'gc_01b_naciones_unidas', (select id from public.topics where slug = 'gc-01b-naciones-unidas'), 3, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/un-charter/full-text'), 'Art. 61 Carta ONU', 'dieciocho miembros del Consejo Económico y Social serán elegidos cada año por un periodo de tres años. Los miembros salientes serán reelegibles para el periodo subsiguiente.', null, 'f6f020c84bd980dc82ac5178de3069dfb9ec7eaa9ca9160b9c4997f624281758', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f6f020c84bd980dc82ac5178de3069dfb9ec7eaa9ca9160b9c4997f624281758')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dieciocho miembros, por un periodo de tres años.', true), ('B', 'Veintisiete miembros, por un periodo de dos años.', false), ('C', 'Dieciocho miembros, por un periodo de dos años.', false), ('D', 'Nueve miembros, por un periodo de tres años.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 92 de la Carta de las Naciones Unidas, el órgano judicial principal de las Naciones Unidas es:', 'El art. 92 define a la Corte Internacional de Justicia como órgano judicial principal de la ONU; su Estatuto, basado en el de la antigua Corte Permanente de Justicia Internacional, forma parte integrante de la Carta.', 'gc_01b_naciones_unidas', (select id from public.topics where slug = 'gc-01b-naciones-unidas'), 1, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/un-charter/full-text'), 'Art. 92 Carta ONU', 'La Corte Internacional de Justicia será el órgano judicial principal de las Naciones Unidas', null, '3b036b7520b01cfe72730f8aac59b33d6075c39a035751bcfe409bb03488dc12', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3b036b7520b01cfe72730f8aac59b33d6075c39a035751bcfe409bb03488dc12')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Corte Penal Internacional.', false), ('B', 'El Tribunal Europeo de Derechos Humanos.', false), ('C', 'La Corte Internacional de Justicia.', true), ('D', 'La Corte Permanente de Justicia Internacional.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 97 de la Carta de las Naciones Unidas, el Secretario General será nombrado por:', 'El art. 97 dispone que el Secretario General, más alto funcionario administrativo de la Organización, es nombrado por la Asamblea General a recomendación del Consejo de Seguridad.', 'gc_01b_naciones_unidas', (select id from public.topics where slug = 'gc-01b-naciones-unidas'), 1, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/un-charter/full-text'), 'Art. 97 Carta ONU', 'El Secretario General será nombrado por la Asamblea General a recomendación del Consejo de Seguridad. El Secretario General sera el más alto funcionario administrativo de la Organización.', null, 'b803ef8a007c34c8a8f276e4d0b04bd47af1312993c9bf055a5705242171dcf0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b803ef8a007c34c8a8f276e4d0b04bd47af1312993c9bf055a5705242171dcf0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Consejo de Seguridad a recomendación de la Asamblea General.', false), ('B', 'La Asamblea General a propuesta del Consejo Económico y Social.', false), ('C', 'La Asamblea General a recomendación del Consejo de Seguridad.', true), ('D', 'El Consejo de Seguridad por unanimidad de sus miembros permanentes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-01b-naciones-unidas-dh_cdh_onu-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Información previa al Consejo de Derechos Humanos', 'https://www.ohchr.org/es/hr-bodies/hrc/about-council', 'web_oficial'::public.source_kind, 'Oficina del Alto Comisionado de las Naciones Unidas para los Derechos Humanos (ohchr.org)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-01b-naciones-unidas', 'Tema 1. Derechos humanos (II): Carta de las Naciones Unidas, sus órganos, DUDH y Consejo de Derechos Humanos') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-01b-naciones-unidas' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la información oficial del ACNUDH, el Consejo de Derechos Humanos de las Naciones Unidas:', 'El Consejo de Derechos Humanos es el principal órgano intergubernamental de la ONU en materia de derechos humanos; lo creó la Asamblea General en 2006, sustituyó a la Comisión de Derechos Humanos y se reúne en la Oficina de la ONU en Ginebra.', 'gc_01b_naciones_unidas', (select id from public.topics where slug = 'gc-01b-naciones-unidas'), 1, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/hr-bodies/hrc/about-council'), 'Consejo de Derechos Humanos (OHCHR)', 'Creado en 2006 por la Asamblea General, se encarga de reforzar la promoción y protección de los derechos humanos en todo el mundo. […] El Consejo de Derechos Humanos sustituyó a la antigua Comisión de Derechos Humanos de las Naciones Unidas.', null, '10dde2913c8d9852ddb261536c0d11df4460018cad2cdb65eb3d2628d4ae7f72', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '10dde2913c8d9852ddb261536c0d11df4460018cad2cdb65eb3d2628d4ae7f72')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Fue creado en 1946 por el Consejo Económico y Social como órgano principal de la ONU.', false), ('B', 'Fue creado en 1993 por la Conferencia Mundial de Derechos Humanos de Viena.', false), ('C', 'Fue creado en 2006 por la Asamblea General y sustituyó a la antigua Comisión de Derechos Humanos.', true), ('D', 'Fue creado en 2006 por el Consejo de Seguridad y tiene su sede en Nueva York.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la información oficial del ACNUDH, ¿cuántos Estados miembros forman el Consejo de Derechos Humanos y quién los elige?', 'El Consejo está formado por 47 Estados miembros elegidos directa e individualmente por mayoría de los 193 Estados de la Asamblea General; los escaños se distribuyen entre los cinco grupos regionales.', 'gc_01b_naciones_unidas', (select id from public.topics where slug = 'gc-01b-naciones-unidas'), 2, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/hr-bodies/hrc/about-council'), 'Consejo de Derechos Humanos (OHCHR)', 'El Consejo de Derechos Humanos está formado por 47 Estados miembros elegidos directa e individualmente por mayoría de los 193 Estados de la Asamblea General de la ONU.', null, '87c6b30ed141aeabc853aa495fc27b8ba219d438d5871ef7268dd4e728092c72', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '87c6b30ed141aeabc853aa495fc27b8ba219d438d5871ef7268dd4e728092c72')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '54 Estados, elegidos por el Consejo Económico y Social.', false), ('B', '47 Estados, elegidos por el Consejo de Seguridad a propuesta del Alto Comisionado.', false), ('C', '15 Estados, elegidos por la Asamblea General por mayoría de dos tercios.', false), ('D', '47 Estados, elegidos directa e individualmente por mayoría de los Estados de la Asamblea General.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la información oficial del ACNUDH sobre el Consejo de Derechos Humanos, señale la respuesta correcta:', 'Las elecciones al Consejo de Derechos Humanos son anuales: cada año se renueva un tercio de los miembros; cada mandato dura tres años y no se pueden encadenar más de dos consecutivos.', 'gc_01b_naciones_unidas', (select id from public.topics where slug = 'gc-01b-naciones-unidas'), 3, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/hr-bodies/hrc/about-council'), 'Consejo de Derechos Humanos (OHCHR)', 'Las elecciones se celebran cada año. Los escaños se distribuyen equitativamente entre los cinco grupos regionales de la ONU, y cada año se renueva un tercio de los miembros. Cada miembro tiene un mandato de tres años. Su mandato está limitado a dos mandatos consecutivos.', null, 'dc5dd3b2f835a4e329d07f9463c1755472cebeaea4fa1ae09513abdd9895cf18', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'dc5dd3b2f835a4e329d07f9463c1755472cebeaea4fa1ae09513abdd9895cf18')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cada miembro tiene un mandato de tres años, limitado a dos mandatos consecutivos, y cada año se renueva un tercio de los miembros.', true), ('B', 'Cada miembro tiene un mandato de dos años, sin posibilidad de reelección inmediata.', false), ('C', 'Cada miembro tiene un mandato de cuatro años y los miembros se renuevan por mitades cada dos años.', false), ('D', 'Cada miembro tiene un mandato de tres años, renovable sin límite, y las elecciones se celebran cada tres años.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-01b-naciones-unidas-dh_dudh-v1 (4 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Declaración Universal de los Derechos Humanos', 'https://www.un.org/es/about-us/universal-declaration-of-human-rights', 'web_oficial'::public.source_kind, 'Naciones Unidas (un.org)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-01b-naciones-unidas', 'Tema 1. Derechos humanos (II): Carta de las Naciones Unidas, sus órganos, DUDH y Consejo de Derechos Humanos') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-01b-naciones-unidas' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la página oficial de las Naciones Unidas, la Declaración Universal de los Derechos Humanos fue proclamada por la Asamblea General:', 'La DUDH fue proclamada por la Asamblea General en París el 10 de diciembre de 1948, mediante la resolución 217 A (III). La Carta se firmó en San Francisco en 1945 y los Pactos internacionales se adoptaron en Nueva York en 1966.', 'gc_01b_naciones_unidas', (select id from public.topics where slug = 'gc-01b-naciones-unidas'), 1, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/universal-declaration-of-human-rights'), 'Introducción DUDH (un.org)', 'la Declaración fue proclamada por la Asamblea General de las Naciones Unidas en París, el 10 de diciembre de 1948 en su (Resolución 217 A (III))', null, '1e858e9ca1245bb73247385037b15bcb6c6e5a32bafb3f2d2892cd669de26d14', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1e858e9ca1245bb73247385037b15bcb6c6e5a32bafb3f2d2892cd669de26d14')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En París, el 10 de diciembre de 1948.', true), ('B', 'En San Francisco, el 26 de junio de 1945.', false), ('C', 'En Nueva York, el 16 de diciembre de 1966.', false), ('D', 'En Ginebra, el 10 de diciembre de 1948.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 14 de la Declaración Universal de los Derechos Humanos, en caso de persecución, toda persona tiene derecho a:', 'El art. 14.1 DUDH reconoce el derecho a buscar asilo y a disfrutar de él en cualquier país; según el art. 14.2 no puede invocarse frente a una acción judicial originada por delitos comunes o por actos opuestos a los propósitos y principios de la ONU.', 'gc_01b_naciones_unidas', (select id from public.topics where slug = 'gc-01b-naciones-unidas'), 2, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/universal-declaration-of-human-rights'), 'Art. 14 DUDH', 'En caso de persecución, toda persona tiene derecho a buscar asilo, y a disfrutar de él, en cualquier país.', null, '0b202145e17eae74fe72ca9cc9f3fbf736ab3a0b05e4f5736370d7fc5688ff1e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0b202145e17eae74fe72ca9cc9f3fbf736ab3a0b05e4f5736370d7fc5688ff1e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Obtener asilo en el país que elija, que estará obligado a concederlo.', false), ('B', 'Buscar asilo, y a disfrutar de él, en cualquier país.', true), ('C', 'Obtener la nacionalidad del país que le acoja.', false), ('D', 'Buscar asilo únicamente en un país limítrofe con el suyo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 26 de la Declaración Universal de los Derechos Humanos, ¿qué instrucción será obligatoria?', 'El art. 26.1 DUDH establece que la educación debe ser gratuita al menos en la instrucción elemental y fundamental, que la instrucción elemental será obligatoria y que la técnica y profesional habrá de ser generalizada.', 'gc_01b_naciones_unidas', (select id from public.topics where slug = 'gc-01b-naciones-unidas'), 2, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/universal-declaration-of-human-rights'), 'Art. 26.1 DUDH', 'La educación debe ser gratuita, al menos en lo concerniente a la instrucción elemental y fundamental. La instrucción elemental será obligatoria.', null, '83cf01bf08e420daa9eececdc19c5d3919c50c825888cbd8867b9041c98d884d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '83cf01bf08e420daa9eececdc19c5d3919c50c825888cbd8867b9041c98d884d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La instrucción elemental y la técnica.', false), ('B', 'La instrucción elemental y la secundaria.', false), ('C', 'La instrucción técnica y profesional.', false), ('D', 'La instrucción elemental.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 29 de la Declaración Universal de los Derechos Humanos, en el ejercicio de sus derechos toda persona estará solamente sujeta a las limitaciones:', 'El art. 29.2 DUDH exige que las limitaciones estén establecidas por la ley y respondan únicamente al respeto de los derechos ajenos y a las justas exigencias de la moral, el orden público y el bienestar general en una sociedad democrática.', 'gc_01b_naciones_unidas', (select id from public.topics where slug = 'gc-01b-naciones-unidas'), 3, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/universal-declaration-of-human-rights'), 'Art. 29.2 DUDH', 'toda persona estará solamente sujeta a las limitaciones establecidas por la ley con el único fin de asegurar el reconocimiento y el respeto de los derechos y libertades de los demás, y de satisfacer las justas exigencias de la moral, del orden público y del bienestar general en una sociedad democrática.', null, '467250774d0ca94deb7670b36342064b9c7ec9d8b7bb4c51dea9d18fad69446e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '467250774d0ca94deb7670b36342064b9c7ec9d8b7bb4c51dea9d18fad69446e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Que acuerde el Consejo de Seguridad para el mantenimiento de la paz y la seguridad internacionales.', false), ('B', 'Establecidas por la ley con el único fin de asegurar el reconocimiento y el respeto de los derechos y libertades de los demás, y de satisfacer las justas exigencias de la moral, del orden público y del bienestar general en una sociedad democrática.', true), ('C', 'Que establezca cada Estado por razones de seguridad nacional, sin necesidad de ley.', false), ('D', 'Que declare la Asamblea General en situaciones de emergencia pública.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-01c-tortura-carta-ue-defensor-dh_cat-v1 (8 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Convención contra la tortura y otros tratos o penas crueles, inhumanos o degradantes (Nueva York, 10 de diciembre de 1984). Instrumento de ratificación, BOE núm. 268, de 9 de noviembre de 1987', 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1987-25053', 'web_oficial'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado (BOE-A-1987-25053)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-01c-tortura-carta-ue-defensor', 'Tema 1. Derechos humanos (III): Convención contra la tortura y Protocolo facultativo, Carta de Derechos Fundamentales de la UE y Defensor del Pueblo (ROF y Mecanismo Nacional de Prevención)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-01c-tortura-carta-ue-defensor' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 1 de la Convención contra la tortura y otros tratos o penas crueles, inhumanos o degradantes (1984), para que exista tortura a los efectos de la Convención, los dolores o sufrimientos graves deben ser infligidos:', 'El art. 1.1 exige intencionalidad, una finalidad (información o confesión, castigo, intimidación o coacción, o discriminación) y la intervención de un funcionario público o persona en ejercicio de funciones públicas, directa o por instigación, consentimiento o aquiescencia. No son tortura los dolores derivados únicamente de sanciones legítimas.', 'gc_01c_tortura_carta_ue_defensor', (select id from public.topics where slug = 'gc-01c-tortura-carta-ue-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1987-25053'), 'Art. 1.1 Convención contra la tortura', 'CUANDO DICHOS DOLORES O SUFRIMIENTOS SEAN INFLIGIDOS POR UN FUNCIONARIO PUBLICO U OTRA PERSONA EN EL EJERCICIO DE FUNCIONES PUBLICAS, A INSTIGACION SUYA, O CON SU CONSENTIMIENTO O AQUIESCENCIA. NO SE CONSIDERARAN TORTURAS LOS DOLORES O SUFRIMIENTOS QUE SEAN CONSECUENCIA UNICAMENTE DE SANCIONES LEGITIMAS', null, '7ed2d31bc8672aced9ee3621c64669881253feff87c8a46978d76b7fd0e093d8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7ed2d31bc8672aced9ee3621c64669881253feff87c8a46978d76b7fd0e093d8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por cualquier persona, sea o no funcionario público, siempre que actúe con ánimo de obtener una confesión.', false), ('B', 'Exclusivamente por miembros de las Fuerzas Armadas o de los cuerpos de policía.', false), ('C', 'Por un funcionario público, aunque sean consecuencia únicamente de sanciones legítimas.', false), ('D', 'Por un funcionario público u otra persona en el ejercicio de funciones públicas, a instigación suya, o con su consentimiento o aquiescencia.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 2 de la Convención contra la tortura, ¿puede invocarse la orden de un funcionario superior o de una autoridad pública como justificación de la tortura?', 'El art. 2.3 excluye la orden superior como justificación de la tortura, y el art. 2.2 tampoco admite circunstancias excepcionales como el estado de guerra, la inestabilidad política interna o cualquier otra emergencia pública.', 'gc_01c_tortura_carta_ue_defensor', (select id from public.topics where slug = 'gc-01c-tortura-carta-ue-defensor'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1987-25053'), 'Art. 2.3 Convención contra la tortura', 'NO PODRA INVOCARSE UNA ORDEN DE UN FUNCIONARIO SUPERIOR O DE UNA AUTORIDAD PUBLICA COMO JUSTIFICACION DE LA TORTURA.', null, '164669469e1dd9f3fdc6788fb1fc1de89c0b6f2b33c6532d1e3c3a3f86e91dca', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '164669469e1dd9f3fdc6788fb1fc1de89c0b6f2b33c6532d1e3c3a3f86e91dca')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sí, si la orden consta por escrito.', false), ('B', 'No, en ningún caso.', true), ('C', 'Sí, en estado de guerra o amenaza de guerra.', false), ('D', 'Sí, cuando el subordinado no tuvo oportunidad de negarse a cumplirla.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 15 de la Convención contra la tortura, una declaración que se demuestre que ha sido hecha como resultado de tortura:', 'El art. 15 establece la regla de exclusión de las declaraciones obtenidas mediante tortura, con la única excepción de su uso contra el acusado de tortura para probar que se formuló la declaración.', 'gc_01c_tortura_carta_ue_defensor', (select id from public.topics where slug = 'gc-01c-tortura-carta-ue-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1987-25053'), 'Art. 15 Convención contra la tortura', 'NINGUNA DECLARACION QUE SE DEMUESTRE QUE HA SIDO HECHA COMO RESULTADO DE TORTURA PUEDA SER INVOCADA COMO PRUEBA EN NINGUN PROCEDIMIENTO, SALVO EN CONTRA DE UNA PERSONA ACUSADA DE TORTURA COMO PRUEBA DE QUE SE HA FORMULADO LA DECLARACION.', null, 'd327305ebf7354e6a810d4438006b3b7c0d341d5d5546146ef4ce0e6f56a3444', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd327305ebf7354e6a810d4438006b3b7c0d341d5d5546146ef4ce0e6f56a3444')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Podrá ser invocada como prueba si es ratificada posteriormente ante el juez.', false), ('B', 'Solo carecerá de validez en los procedimientos penales, no en los administrativos.', false), ('C', 'No podrá ser invocada como prueba en ningún procedimiento, salvo en contra de una persona acusada de tortura como prueba de que se ha formulado la declaración.', true), ('D', 'Podrá ser invocada como prueba si existen otros indicios que la corroboren.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 17 de la Convención contra la tortura, el Comité contra la Tortura estará compuesto de:', 'El art. 17.1 compone el Comité de diez expertos que ejercen sus funciones a título personal, elegidos por los Estados Partes con una distribución geográfica equitativa. Dieciocho es la composición del Comité de Derechos Humanos del PIDCP.', 'gc_01c_tortura_carta_ue_defensor', (select id from public.topics where slug = 'gc-01c-tortura-carta-ue-defensor'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1987-25053'), 'Art. 17.1 Convención contra la tortura', 'EL COMITE ESTARA COMPUESTO DE DIEZ EXPERTOS DE GRAN INTEGRIDAD MORAL Y RECONOCIDA COMPETENCIA EN MATERIA DE DERECHOS HUMANOS, QUE EJERCERAN SUS FUNCIONES A TITULO PERSONAL.', null, '5d3f29fcbc2c62758193bfd859455f72209d410819117a0cd7cb5cdaa9f9484f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5d3f29fcbc2c62758193bfd859455f72209d410819117a0cd7cb5cdaa9f9484f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Diez expertos de gran integridad moral y reconocida competencia en materia de derechos humanos.', true), ('B', 'Dieciocho expertos elegidos por la Asamblea General.', false), ('C', 'Veinticinco expertos designados por el Consejo de Derechos Humanos.', false), ('D', 'Cinco expertos nombrados por el Secretario General de las Naciones Unidas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 17 de la Convención contra la tortura, los miembros del Comité contra la Tortura serán elegidos por:', 'El art. 17.5 fija un mandato de cuatro años con posible reelección; en la primera elección, el mandato de cinco miembros expiró a los dos años, designados por sorteo.', 'gc_01c_tortura_carta_ue_defensor', (select id from public.topics where slug = 'gc-01c-tortura-carta-ue-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1987-25053'), 'Art. 17.5 Convención contra la tortura', 'LOS MIEMBROS DEL COMITE SERAN ELEGIDOS POR CUATRO AÑOS. PODRAN SER REELEGIDOS SI SE PRESENTA DE NUEVO SU CANDIDATURA.', null, '653cd9931553cc9971f5db200309bd828f64b519d7cebb2a0e1670197976773e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '653cd9931553cc9971f5db200309bd828f64b519d7cebb2a0e1670197976773e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Seis años, sin posibilidad de reelección.', false), ('B', 'Dos años, y podrán ser reelegidos una sola vez.', false), ('C', 'Nueve años, sin posibilidad de reelección.', false), ('D', 'Cuatro años, y podrán ser reelegidos si se presenta de nuevo su candidatura.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 18 de la Convención contra la tortura, el reglamento del Comité dispondrá que constituirán quórum:', 'El art. 18.2 prevé que seis miembros constituyen quórum y que las decisiones se toman por mayoría de votos de los miembros presentes. La fórmula «la mitad más uno» es la del Subcomité para la Prevención (art. 10.2 del Protocolo facultativo).', 'gc_01c_tortura_carta_ue_defensor', (select id from public.topics where slug = 'gc-01c-tortura-carta-ue-defensor'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1987-25053'), 'Art. 18.2 Convención contra la tortura', 'A) SEIS MIEMBROS CONSTITUIRAN QUORUM. B) LAS DECISIONES DEL COMITE SE TOMARAN POR MAYORIA DE VOTOS DE LOS MIEMBROS PRESENTES.', null, '171e5b032c4a1e198dedc758dfdf21478c44d04f90b8d74b511a98f25f66c709', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '171e5b032c4a1e198dedc758dfdf21478c44d04f90b8d74b511a98f25f66c709')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Seis miembros.', true), ('B', 'Cinco miembros.', false), ('C', 'Dos tercios de los miembros.', false), ('D', 'La mitad más uno de sus miembros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Conforme al artículo 19 de la Convención contra la tortura, tras el primer informe, los Estados Partes presentarán al Comité informes suplementarios:', 'El art. 19.1 obliga a presentar un primer informe dentro del año siguiente a la entrada en vigor para el Estado y, después, informes suplementarios cada cuatro años, siempre por conducto del Secretario General.', 'gc_01c_tortura_carta_ue_defensor', (select id from public.topics where slug = 'gc-01c-tortura-carta-ue-defensor'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1987-25053'), 'Art. 19.1 Convención contra la tortura', 'LOS ESTADOS PARTES PRESENTARAN AL COMITE, POR CONDUCTO DEL SECRETARIO GENERAL DE LAS NACIONES UNIDAS […] A PARTIR DE ENTONCES, LOS ESTADOS PARTES PRESENTARAN INFORMES SUPLEMENTARIOS CADA CUATRO AÑOS', null, '4c69071b4253e627dc2cf44f0b888380970ff8af86c7907347408aaf5bd3ac7d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4c69071b4253e627dc2cf44f0b888380970ff8af86c7907347408aaf5bd3ac7d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cada año, directamente al Comité.', false), ('B', 'Cada dos años, por conducto del Consejo Económico y Social.', false), ('C', 'Cada cuatro años, por conducto del Secretario General de las Naciones Unidas.', true), ('D', 'Cada cinco años, por conducto del Consejo de Derechos Humanos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 22 de la Convención contra la tortura, el Comité considerará inadmisible toda comunicación individual que:', 'El art. 22.2 declara inadmisibles las comunicaciones anónimas, abusivas o incompatibles con la Convención; además, solo se admiten respecto de Estados que hayan reconocido esa competencia del Comité (España lo hizo al ratificar).', 'gc_01c_tortura_carta_ue_defensor', (select id from public.topics where slug = 'gc-01c-tortura-carta-ue-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1987-25053'), 'Art. 22.2 Convención contra la tortura', 'EL COMITE CONSIDERARA INADMISIBLE TODA COMUNICACION RECIBIDA DE CONFORMIDAD CON EL PRESENTE ARTICULO QUE SEA ANONIMA, O QUE, A SU JUICIO, CONSTITUYA UN ABUSO DEL DERECHO DE PRESENTAR DICHAS COMUNICACIONES, O QUE SEA INCOMPATIBLE CON LAS DISPOSICIONES DE LA PRESENTE CONVENCION.', null, '0bffe9571357ea2cc7c1e3fea5733b8516746cd538bd6136734294b1752fa382', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0bffe9571357ea2cc7c1e3fea5733b8516746cd538bd6136734294b1752fa382')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se presente por medio de un representante de la víctima.', false), ('B', 'Sea anónima, constituya un abuso del derecho a presentarla o sea incompatible con la Convención.', true), ('C', 'Se refiera a hechos ocurridos fuera del territorio del Estado denunciado.', false), ('D', 'Se dirija contra un Estado que haya hecho la declaración del artículo 22.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-01c-tortura-carta-ue-defensor-dh_cdfue-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Carta de los Derechos Fundamentales de la Unión Europea (DOUE C 202 de 7.6.2016)', 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016P/TXT', 'web_oficial'::public.source_kind, 'Unión Europea · EUR-Lex (DOUE C 202 de 7.6.2016)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-01c-tortura-carta-ue-defensor', 'Tema 1. Derechos humanos (III): Convención contra la tortura y Protocolo facultativo, Carta de Derechos Fundamentales de la UE y Defensor del Pueblo (ROF y Mecanismo Nacional de Prevención)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-01c-tortura-carta-ue-defensor' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 1 de la Carta de los Derechos Fundamentales de la Unión Europea:', 'El art. 1 abre el título I (Dignidad) con la inviolabilidad de la dignidad humana. El derecho a la libertad y a la seguridad está en el art. 6 y la igualdad ante la ley en el art. 20.', 'gc_01c_tortura_carta_ue_defensor', (select id from public.topics where slug = 'gc-01c-tortura-carta-ue-defensor'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016P/TXT'), 'Art. 1 Carta de los Derechos Fundamentales de la UE', 'La dignidad humana es inviolable. Será respetada y protegida.', null, '993f8ccf50ecd778a340572497be77e2ab6114960fc80838245bb4df56d4901a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '993f8ccf50ecd778a340572497be77e2ab6114960fc80838245bb4df56d4901a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La libertad es el valor superior del ordenamiento de la Unión.', false), ('B', 'La dignidad humana es inviolable. Será respetada y protegida.', true), ('C', 'Toda persona tiene derecho a la libertad y a la seguridad.', false), ('D', 'Todas las personas son iguales ante la ley.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 2 de la Carta de los Derechos Fundamentales de la Unión Europea, en relación con la pena de muerte:', 'El art. 2 de la Carta reconoce el derecho a la vida (apartado 1) y prohíbe condenar a muerte o ejecutar a nadie (apartado 2), sin excepciones.', 'gc_01c_tortura_carta_ue_defensor', (select id from public.topics where slug = 'gc-01c-tortura-carta-ue-defensor'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016P/TXT'), 'Art. 2.2 Carta de los Derechos Fundamentales de la UE', 'Toda persona tiene derecho a la vida. 2. Nadie podrá ser condenado a la pena de muerte ni ejecutado.', null, '6fbf1f63f80cc8ccabb32ca8f04f55e8d1f55db156b39db696b3a9376f246d2b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6fbf1f63f80cc8ccabb32ca8f04f55e8d1f55db156b39db696b3a9376f246d2b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Nadie podrá ser condenado a la pena de muerte ni ejecutado.', true), ('B', 'Solo podrá imponerse en tiempo de guerra.', false), ('C', 'Solo podrá imponerse por los delitos más graves y en virtud de sentencia firme.', false), ('D', 'Cada Estado miembro decide si la mantiene en su legislación penal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 43 de la Carta de los Derechos Fundamentales de la Unión Europea, el Defensor del Pueblo Europeo puede conocer de los casos de mala administración en la actuación de las instituciones, órganos u organismos de la Unión, con exclusión de:', 'El art. 43 reconoce a todo ciudadano de la Unión y a toda persona física o jurídica que resida o tenga su domicilio social en un Estado miembro el derecho a acudir al Defensor del Pueblo Europeo, excluyendo solo al TJUE en sus funciones jurisdiccionales.', 'gc_01c_tortura_carta_ue_defensor', (select id from public.topics where slug = 'gc-01c-tortura-carta-ue-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016P/TXT'), 'Art. 43 Carta de los Derechos Fundamentales de la UE', 'con exclusión del Tribunal de Justicia de la Unión Europea en el ejercicio de sus funciones jurisdiccionales.', null, '25a2fd4aa038c0985789b51ea393a80a3ad4ae1414b02d04767c29a3a7766d5f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '25a2fd4aa038c0985789b51ea393a80a3ad4ae1414b02d04767c29a3a7766d5f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Parlamento Europeo en el ejercicio de su función legislativa.', false), ('B', 'La Comisión Europea en el ejercicio de su función ejecutiva.', false), ('C', 'El Tribunal de Justicia de la Unión Europea en el ejercicio de sus funciones jurisdiccionales.', true), ('D', 'El Banco Central Europeo en el ejercicio de la política monetaria.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-01c-tortura-carta-ue-defensor-dh_opcat-v1 (4 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Protocolo facultativo de la Convención contra la tortura y otros tratos o penas crueles, inhumanos o degradantes (Nueva York, 18 de diciembre de 2002). Instrumento de ratificación, BOE núm. 148, de 22 de junio de 2006', 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2006-11128', 'web_oficial'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado (BOE-A-2006-11128)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-01c-tortura-carta-ue-defensor', 'Tema 1. Derechos humanos (III): Convención contra la tortura y Protocolo facultativo, Carta de Derechos Fundamentales de la UE y Defensor del Pueblo (ROF y Mecanismo Nacional de Prevención)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-01c-tortura-carta-ue-defensor' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 1 del Protocolo facultativo de la Convención contra la tortura (2002), el objetivo del Protocolo es establecer:', 'El Protocolo facultativo crea un sistema preventivo de visitas periódicas a lugares de detención, a cargo del Subcomité para la Prevención (órgano internacional) y de los mecanismos nacionales de prevención.', 'gc_01c_tortura_carta_ue_defensor', (select id from public.topics where slug = 'gc-01c-tortura-carta-ue-defensor'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2006-11128'), 'Art. 1 Protocolo facultativo', 'El objetivo del presente Protocolo es establecer un sistema de visitas periódicas a cargo de órganos internacionales y nacionales independientes a los lugares en que se encuentren personas privadas de su libertad', null, '64c142a7a6e5b17d0ec19f1b471b8f859b3d6eb461bc2c99889e36a3f95b6545', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '64c142a7a6e5b17d0ec19f1b471b8f859b3d6eb461bc2c99889e36a3f95b6545')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un tribunal internacional para juzgar los delitos de tortura.', false), ('B', 'Un procedimiento de comunicaciones individuales ante el Comité contra la Tortura.', false), ('C', 'Un fondo de indemnización para las víctimas de tortura.', false), ('D', 'Un sistema de visitas periódicas a cargo de órganos internacionales y nacionales independientes a los lugares en que se encuentren personas privadas de su libertad.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 5 del Protocolo facultativo de la Convención contra la tortura, el Subcomité para la Prevención estará compuesto de diez miembros, número que aumentará a veinticinco:', 'El art. 5.1 prevé diez miembros iniciales y veinticinco tras la quincuagésima ratificación o adhesión. La vigésima ratificación es la que determinó la entrada en vigor del Protocolo (art. 28).', 'gc_01c_tortura_carta_ue_defensor', (select id from public.topics where slug = 'gc-01c-tortura-carta-ue-defensor'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2006-11128'), 'Art. 5.1 Protocolo facultativo', 'El Subcomité para la Prevención estará compuesto de diez miembros. Una vez que se haya registrado la quincuagésima ratificación del presente Protocolo o adhesión a él, el número de miembros del Subcomité para la Prevención aumentará a veinticinco.', null, '84a0f17992b1d4d0f62681593658fc775d3aaa84695ba5420e3d3fd732f6f1ba', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '84a0f17992b1d4d0f62681593658fc775d3aaa84695ba5420e3d3fd732f6f1ba')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una vez registrada la quincuagésima ratificación del Protocolo o adhesión a él.', true), ('B', 'Una vez registrada la vigésima ratificación del Protocolo o adhesión a él.', false), ('C', 'Cuando lo decida la Asamblea General por mayoría de dos tercios.', false), ('D', 'Una vez registrada la centésima ratificación del Protocolo o adhesión a él.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 17 del Protocolo facultativo de la Convención contra la tortura, cada Estado Parte mantendrá, designará o creará uno o varios mecanismos nacionales independientes para la prevención de la tortura:', 'El art. 17 fija el plazo de un año. Según el art. 24, el Estado puede aplazar sus obligaciones de las partes III o IV por un máximo de tres años, prorrogables dos más.', 'gc_01c_tortura_carta_ue_defensor', (select id from public.topics where slug = 'gc-01c-tortura-carta-ue-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2006-11128'), 'Art. 17 Protocolo facultativo', 'Cada Estado Parte mantendrá, designará o creará, a más tardar un año después de la entrada en vigor del presente Protocolo o de su ratificación o adhesión, uno o varios mecanismos nacionales independientes para la prevención de la tortura a nivel nacional.', null, '6411c5472fd6050fca82728fe5e6040adc690fd45217fab869a805e93fcdf3a4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6411c5472fd6050fca82728fe5e6040adc690fd45217fab869a805e93fcdf3a4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A más tardar seis meses después de la entrada en vigor del Protocolo o de su ratificación o adhesión.', false), ('B', 'A más tardar un año después de la entrada en vigor del Protocolo o de su ratificación o adhesión.', true), ('C', 'A más tardar tres años después de la entrada en vigor del Protocolo o de su ratificación o adhesión.', false), ('D', 'En el plazo que fije el Subcomité para la Prevención en su primera visita.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 30 del Protocolo facultativo de la Convención contra la tortura, en materia de reservas:', 'El art. 30 prohíbe cualquier reserva. Distinto es la declaración del art. 24, que permite aplazar temporalmente las obligaciones de las partes III o IV.', 'gc_01c_tortura_carta_ue_defensor', (select id from public.topics where slug = 'gc-01c-tortura-carta-ue-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2006-11128'), 'Art. 30 Protocolo facultativo', 'No se admitirán reservas al presente Protocolo.', null, '98b37b37699c3e00a0b92eebedba49c4d1cfd09d50f35ca6ab851995c4a4dcc5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '98b37b37699c3e00a0b92eebedba49c4d1cfd09d50f35ca6ab851995c4a4dcc5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se admitirán reservas salvo a la parte IV, sobre mecanismos nacionales de prevención.', false), ('B', 'Se admitirán reservas formuladas en el momento de la ratificación.', false), ('C', 'No se admitirán reservas al Protocolo.', true), ('D', 'Las reservas requieren la aprobación del Comité contra la Tortura.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-01c-tortura-carta-ue-defensor-rofdp-v1 (5 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Reglamento de Organización y Funcionamiento del Defensor del Pueblo (6 de abril de 1983) (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1983-10613', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-01c-tortura-carta-ue-defensor', 'Tema 1. Derechos humanos (III): Convención contra la tortura y Protocolo facultativo, Carta de Derechos Fundamentales de la UE y Defensor del Pueblo (ROF y Mecanismo Nacional de Prevención)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-01c-tortura-carta-ue-defensor' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 1 del Reglamento de Organización y Funcionamiento del Defensor del Pueblo, ¿quién ejercerá en España las funciones de Mecanismo Nacional de Prevención de la Tortura previstas en el Protocolo facultativo?', 'El art. 1.2 ROFDP atribuye al Defensor del Pueblo las funciones de Mecanismo Nacional de Prevención de la Tortura, que da cuenta de su actividad a las Cortes Generales y al Subcomité para la Prevención de la Tortura de la ONU.', 'gc_01c_tortura_carta_ue_defensor', (select id from public.topics where slug = 'gc-01c-tortura-carta-ue-defensor'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1983-10613'), 'Art. 1.2 ROF Defensor del Pueblo', 'El Defensor del Pueblo ejercerá las funciones de Mecanismo Nacional de Prevención de la Tortura, previstas en el Protocolo facultativo de la Convención contra la tortura', null, '283f26081c124b127091ae77186638381e54e4c5e9373adf86ac41be5a70ceeb', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '283f26081c124b127091ae77186638381e54e4c5e9373adf86ac41be5a70ceeb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Defensor del Pueblo.', true), ('B', 'El Ministerio del Interior.', false), ('C', 'El Consejo General del Poder Judicial.', false), ('D', 'La Fiscalía General del Estado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 19 del Reglamento de Organización y Funcionamiento del Defensor del Pueblo, el Consejo Asesor del Mecanismo Nacional de Prevención estará integrado por:', 'El art. 19.2 ROFDP compone el Consejo Asesor con los Adjuntos como miembros natos y un máximo de 10 Vocales; lo preside el Adjunto en quien se deleguen las funciones del Mecanismo (art. 19.3).', 'gc_01c_tortura_carta_ue_defensor', (select id from public.topics where slug = 'gc-01c-tortura-carta-ue-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1983-10613'), 'Art. 19.2 ROF Defensor del Pueblo', 'El Consejo Asesor estará integrado por los Adjuntos del Defensor del Pueblo, como miembros natos, además de por un máximo de 10 Vocales.', null, '8f3236e0cfadbcfcd6d2d18caf11042e3a47fd97b988190b95c0872d02759c38', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8f3236e0cfadbcfcd6d2d18caf11042e3a47fd97b988190b95c0872d02759c38')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Defensor del Pueblo, que lo preside, y un máximo de 12 Vocales.', false), ('B', 'Los Adjuntos del Defensor del Pueblo y un máximo de 5 Vocales.', false), ('C', 'Los Adjuntos del Defensor del Pueblo, como miembros natos, además de por un máximo de 10 Vocales.', true), ('D', 'Un máximo de 10 Vocales designados por las Cortes Generales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 20 del Reglamento de Organización y Funcionamiento del Defensor del Pueblo, los Vocales del Consejo Asesor del Mecanismo Nacional de Prevención serán designados:', 'El art. 20.1 ROFDP fija cuatro años con renovación por mitades cada dos; la designación y el cese corresponden al Defensor del Pueblo (art. 20.3).', 'gc_01c_tortura_carta_ue_defensor', (select id from public.topics where slug = 'gc-01c-tortura-carta-ue-defensor'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1983-10613'), 'Art. 20.1 ROF Defensor del Pueblo', 'Los Vocales del Consejo Asesor serán designados para un período de cuatro años y se renovarán por mitades cada dos.', null, 'e90a7d425e519fed5d89018927f199c7bf11bcae1bac9cac46c865929628559d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e90a7d425e519fed5d89018927f199c7bf11bcae1bac9cac46c865929628559d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Para un período de cinco años, coincidente con el mandato del Defensor del Pueblo.', false), ('B', 'Para un período de dos años, renovable una sola vez.', false), ('C', 'Para un período de cuatro años y se renovarán en su totalidad.', false), ('D', 'Para un período de cuatro años y se renovarán por mitades cada dos.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Conforme al artículo 21 del Reglamento de Organización y Funcionamiento del Defensor del Pueblo, el Consejo Asesor del Mecanismo Nacional de Prevención se reunirá:', 'El art. 21.1 ROFDP exige un mínimo de dos reuniones anuales; a sus sesiones pueden asistir personal del Defensor del Pueblo, representantes de organismos internacionales de derechos humanos u otras personas convocadas por su Presidente.', 'gc_01c_tortura_carta_ue_defensor', (select id from public.topics where slug = 'gc-01c-tortura-carta-ue-defensor'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1983-10613'), 'Art. 21.1 ROF Defensor del Pueblo', 'El Consejo Asesor del Mecanismo Nacional de Prevención se reunirá, al menos, dos veces al año.', null, '47d57277b682e9b544462e5494427eca259722651ad7c4eb7cc050d9da0d0e38', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '47d57277b682e9b544462e5494427eca259722651ad7c4eb7cc050d9da0d0e38')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al menos, una vez al año.', false), ('B', 'Al menos, dos veces al año.', true), ('C', 'Al menos, una vez al trimestre.', false), ('D', 'Al menos, una vez al mes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 19 del Reglamento de Organización y Funcionamiento del Defensor del Pueblo, en el Consejo Asesor del Mecanismo Nacional de Prevención actuará como secretario:', 'El art. 19.6 ROFDP atribuye la secretaría del Consejo Asesor al Secretario General de la Institución; la presidencia corresponde al Adjunto en quien se deleguen las funciones del Mecanismo, sustituido por el otro Adjunto (art. 19.3).', 'gc_01c_tortura_carta_ue_defensor', (select id from public.topics where slug = 'gc-01c-tortura-carta-ue-defensor'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1983-10613'), 'Art. 19.6 ROF Defensor del Pueblo', 'Actuará como secretario el Secretario General de la Institución.', null, 'd89cdbb777d052f972aa20ddc56a273631575b477b8003cb86c88ad4857feb92', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd89cdbb777d052f972aa20ddc56a273631575b477b8003cb86c88ad4857feb92')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Adjunto Segundo del Defensor del Pueblo.', false), ('B', 'El Vocal de menor edad.', false), ('C', 'El Vocal designado a propuesta del Consejo General de la Abogacía de España.', false), ('D', 'El Secretario General de la Institución.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-03b-prevencion-age-guardia-civil-prlage-v1 (10 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto 67/2010, de 29 de enero, de adaptación de la legislación de Prevención de Riesgos Laborales a la Administración General del Estado (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2010-2161', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-03b-prevencion-age-guardia-civil', 'Tema 3. Prevención de riesgos laborales (II): RD 67/2010 (AGE) y RD 179/2005 (Guardia Civil)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-03b-prevencion-age-guardia-civil' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 6 del Real Decreto 67/2010, de adaptación de la legislación de prevención de riesgos laborales a la Administración General del Estado, el Comité de Seguridad y Salud se reunirá:', 'El art. 6.5 RD 67/2010 fija la periodicidad trimestral del Comité de Seguridad y Salud, que se reunirá además siempre que lo solicite alguna de las representaciones, y le permite adoptar sus propias normas de funcionamiento.', 'gc_03b_prevencion_age_guardia_civil', (select id from public.topics where slug = 'gc-03b-prevencion-age-guardia-civil'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2010-2161'), 'Art. 6.5 RD 67/2010', 'El Comité de Seguridad y Salud se reunirá trimestralmente y siempre que lo solicite alguna de las representaciones en el mismo.', null, '66676c78cdb038918706980cc481b51b337284048dab81d0f92921ad807af395', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '66676c78cdb038918706980cc481b51b337284048dab81d0f92921ad807af395')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Trimestralmente y siempre que lo solicite alguna de las representaciones en el mismo.', true), ('B', 'Mensualmente y siempre que lo solicite la Administración.', false), ('C', 'Semestralmente y siempre que lo solicite la mayoría de sus miembros.', false), ('D', 'Anualmente, con carácter ordinario, y en sesión extraordinaria cuando lo acuerde su presidente.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el Real Decreto 67/2010, los responsables técnicos de prevención en el ámbito correspondiente pueden participar en las reuniones del Comité de Seguridad y Salud:', 'El art. 6.4 RD 67/2010 permite participar con voz pero sin voto a los delegados sindicales que no sean delegados de prevención, a los asesores sindicales y a los responsables técnicos de prevención, que por ello no pueden formar parte del Comité como representantes exclusivos de la Administración.', 'gc_03b_prevencion_age_guardia_civil', (select id from public.topics where slug = 'gc-03b-prevencion-age-guardia-civil'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2010-2161'), 'Art. 6.4 RD 67/2010', 'En las reuniones del Comité de Seguridad y Salud podrán participar, con voz pero sin voto, los delegados o delegadas sindicales del centro de trabajo que no sean además delegados o delegadas de prevención, los asesores sindicales, en su caso, y los responsables técnicos de prevención en el ámbito correspondiente.', null, 'b5209c88bea8ff30db4edd37b4a3d4a651621ce541ca3deda2a9206a26390b78', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b5209c88bea8ff30db4edd37b4a3d4a651621ce541ca3deda2a9206a26390b78')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Con voz y voto, como representantes de la Administración.', false), ('B', 'Con voto pero sin voz.', false), ('C', 'Con voz pero sin voto.', true), ('D', 'Solo como observadores, sin voz ni voto.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Qué norma derogó expresamente el Real Decreto 67/2010, de adaptación de la legislación de prevención de riesgos laborales a la Administración General del Estado?', 'La disposición derogatoria única del RD 67/2010 deroga el RD 1488/1998, que había sido la primera norma de adaptación de la prevención de riesgos laborales a la AGE. El RD 39/1997 y el RD 179/2005 siguen vigentes.', 'gc_03b_prevencion_age_guardia_civil', (select id from public.topics where slug = 'gc-03b-prevencion-age-guardia-civil'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2010-2161'), 'Disp. derogatoria única RD 67/2010', 'Queda derogado el Real Decreto 1488/1998, de 10 de julio, de adaptación de la legislación de prevención de riesgos laborales a la Administración General del Estado', null, '7f6e6e218e5d4ca86c43703df932ba982d163d4af00980378eef12f198196033', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7f6e6e218e5d4ca86c43703df932ba982d163d4af00980378eef12f198196033')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Real Decreto 39/1997, de 17 de enero, Reglamento de los Servicios de Prevención.', false), ('B', 'El Real Decreto 179/2005, de 18 de febrero.', false), ('C', 'La Ley 31/1995, de 8 de noviembre, de Prevención de Riesgos Laborales.', false), ('D', 'El Real Decreto 1488/1998, de 10 de julio.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 6 del Real Decreto 67/2010, con carácter general se constituirá un único Comité de Seguridad y Salud en cada uno de los centros de trabajo del Anexo I siempre que dichos centros cuenten con:', 'El art. 6.2 RD 67/2010, en línea con el art. 38.2 de la Ley 31/1995, exige un Comité de Seguridad y Salud en los centros de trabajo del Anexo I con 50 o más empleados públicos.', 'gc_03b_prevencion_age_guardia_civil', (select id from public.topics where slug = 'gc-03b-prevencion-age-guardia-civil'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2010-2161'), 'Art. 6.2 RD 67/2010', 'se constituirá un único Comité de Seguridad y Salud en cada uno de los centros de trabajo que se recogen en el Anexo I de este Real Decreto, siempre que dichos centros de trabajo cuenten con 50 o más empleados públicos', null, '307663172fccd737cfcd3f356ff2d06ed2026c91503013b35de33452058d2169', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '307663172fccd737cfcd3f356ff2d06ed2026c91503013b35de33452058d2169')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '25 o más empleados públicos.', false), ('B', '50 o más empleados públicos.', true), ('C', 'Más de 100 empleados públicos.', false), ('D', '250 o más empleados públicos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el Real Decreto 67/2010, el órgano específico de participación y negociación de las organizaciones sindicales en materia de prevención de riesgos laborales en la Administración General del Estado es:', 'El art. 4.2 RD 67/2010 configura la Comisión Técnica de Prevención de Riesgos Laborales, dependiente de la Mesa General de Negociación de la AGE, como órgano específico de participación y negociación sindical en esta materia; su presidencia corresponde a la Dirección General de la Función Pública (art. 11.a).', 'gc_03b_prevencion_age_guardia_civil', (select id from public.topics where slug = 'gc-03b-prevencion-age-guardia-civil'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2010-2161'), 'Art. 4.2 RD 67/2010', 'La Comisión Técnica de Prevención de Riesgos Laborales, dependiente de la Mesa General de Negociación de la Administración General del Estado, regulada por el artículo 36.3 de la Ley 7/2007, de 12 de abril, del Estatuto Básico del Empleado Público, será el órgano específico de participación y negociación de las organizaciones sindicales en materia de prevención de riesgos laborales', null, 'c67e071b2da4f2d99dfb8fe2d43b71b90ce92f2adb31fa4c26888f073a6340dd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c67e071b2da4f2d99dfb8fe2d43b71b90ce92f2adb31fa4c26888f073a6340dd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Comité de Seguridad y Salud de cada Departamento ministerial.', false), ('B', 'La Comisión Nacional de Seguridad y Salud en el Trabajo.', false), ('C', 'La Comisión Técnica de Prevención de Riesgos Laborales, dependiente de la Mesa General de Negociación de la Administración General del Estado.', true), ('D', 'El Grupo Técnico de Prevención de Riesgos Laborales de cada Delegación del Gobierno.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 67/2010, los servicios de prevención mancomunados deberán contar con, al menos:', 'El art. 7.4 RD 67/2010, remitiéndose al RD 39/1997, exige a los servicios de prevención mancomunados al menos tres especialidades; al servicio de prevención propio le exige como mínimo dos (art. 7.3).', 'gc_03b_prevencion_age_guardia_civil', (select id from public.topics where slug = 'gc-03b-prevencion-age-guardia-civil'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2010-2161'), 'Art. 7.4 RD 67/2010', 'los servicios de prevención mancomunados deberán contar con, al menos, tres especialidades o disciplinas preventivas.', null, '5e3c1b923374244879d3f113d2dab4d394572e3a67c55b863d1edba5992e3c8b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5e3c1b923374244879d3f113d2dab4d394572e3a67c55b863d1edba5992e3c8b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres especialidades o disciplinas preventivas.', true), ('B', 'Dos especialidades o disciplinas preventivas.', false), ('C', 'Cuatro especialidades o disciplinas preventivas.', false), ('D', 'Una especialidad, que será necesariamente la de medicina del trabajo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 10 del Real Decreto 67/2010, el control periódico externo al que debe someterse cada sistema de prevención en el ámbito de la Administración General del Estado corresponde:', 'El art. 10.1 RD 67/2010 encomienda el control periódico externo de los sistemas de prevención al INSHT (hoy Instituto Nacional de Seguridad y Salud en el Trabajo), sin perjuicio de las competencias de la Inspección de Trabajo y del Consejo de Seguridad Nuclear y de la regulación específica de Guardia Civil, Policía y Fuerzas Armadas.', 'gc_03b_prevencion_age_guardia_civil', (select id from public.topics where slug = 'gc-03b-prevencion-age-guardia-civil'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2010-2161'), 'Art. 10.1 RD 67/2010', 'cada sistema de prevención deberá someterse a un control periódico externo cuya realización corresponderá al Instituto Nacional de Seguridad e Higiene en el Trabajo', null, '53fc56fe93840d7915b492165ba96024e01d0e889077b556f9d6c79b04cc5d9a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '53fc56fe93840d7915b492165ba96024e01d0e889077b556f9d6c79b04cc5d9a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A la Inspección de Trabajo y Seguridad Social.', false), ('B', 'A la Dirección General de la Función Pública.', false), ('C', 'A la Comisión Técnica de Prevención de Riesgos Laborales.', false), ('D', 'Al Instituto Nacional de Seguridad e Higiene en el Trabajo.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Conforme al artículo 7 del Real Decreto 67/2010, se deberá crear un servicio de prevención propio en los servicios centrales de los Departamentos ministeriales y de los Organismos públicos que cuenten con:', 'El art. 7.3.a) RD 67/2010 fija los umbrales de 500 empleados públicos (o de 250 a 500 con actividades del anexo I del RD 39/1997). La cifra de 2.000 empleados se refiere a la posibilidad de crear Comités de Seguridad y Salud propios en organismos autónomos (art. 6.2.a).', 'gc_03b_prevencion_age_guardia_civil', (select id from public.topics where slug = 'gc-03b-prevencion-age-guardia-civil'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2010-2161'), 'Art. 7.3.a) RD 67/2010', 'En los servicios centrales de los Departamentos ministeriales y de los Organismos públicos que cuenten con más de 500 empleados públicos, y en aquellos que tengan entre 250 y 500 empleados públicos y desarrollen alguna de las actividades incluidas en el anexo I del Real Decreto 39/1997', null, '49eeab9cfae56a5d3cf5084a09dc413a93c0d20c4b372bd9b0125851166ccde8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '49eeab9cfae56a5d3cf5084a09dc413a93c0d20c4b372bd9b0125851166ccde8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Más de 250 empleados públicos, o entre 50 y 250 si desarrollan alguna de las actividades del anexo I del Reglamento de los Servicios de Prevención.', false), ('B', 'Más de 500 empleados públicos, o entre 250 y 500 si desarrollan alguna de las actividades del anexo I del Reglamento de los Servicios de Prevención.', true), ('C', 'Más de 1.000 empleados públicos, o entre 500 y 1.000 si desarrollan alguna de las actividades del anexo I del Reglamento de los Servicios de Prevención.', false), ('D', 'Más de 2.000 empleados públicos en el total de sus dependencias en la provincia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 67/2010, el servicio de prevención propio de un Departamento u organismo público habrá de contar, como mínimo, con:', 'El art. 7.3 RD 67/2010, in fine, exige al servicio de prevención propio un mínimo de dos especialidades, desarrolladas por expertos con la capacitación del capítulo VI del RD 39/1997; los mancomunados necesitan tres (art. 7.4).', 'gc_03b_prevencion_age_guardia_civil', (select id from public.topics where slug = 'gc-03b-prevencion-age-guardia-civil'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2010-2161'), 'Art. 7.3 RD 67/2010', 'Dicho servicio de prevención habrá de contar, como mínimo, con dos de las especialidades o disciplinas preventivas previstas en el artículo 34 del Real Decreto 39/1997, de 17 de enero', null, '7ac19bfa94a51837928e035188a9029c0b6fcda8742db1c3d7183829d5ceb381', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7ac19bfa94a51837928e035188a9029c0b6fcda8742db1c3d7183829d5ceb381')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres de las especialidades o disciplinas preventivas previstas en el artículo 34 del Real Decreto 39/1997.', false), ('B', 'Las cuatro especialidades o disciplinas preventivas previstas en el artículo 34 del Real Decreto 39/1997.', false), ('C', 'Dos de las especialidades o disciplinas preventivas previstas en el artículo 34 del Real Decreto 39/1997.', true), ('D', 'La especialidad de medicina del trabajo y otra más a elección del Departamento.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 5 del Real Decreto 67/2010, el tiempo que los Delegados de Prevención dediquen a las reuniones del Comité de Seguridad y Salud:', 'El art. 5.6 RD 67/2010 imputa al crédito horario el tiempo ordinario de desempeño de funciones (sin créditos añadidos por ser Delegado de Prevención), pero considera tiempo de trabajo efectivo sin imputación las reuniones del Comité de Seguridad y Salud, las convocadas por la Administración en esta materia y ciertas visitas.', 'gc_03b_prevencion_age_guardia_civil', (select id from public.topics where slug = 'gc-03b-prevencion-age-guardia-civil'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2010-2161'), 'Art. 5.6 RD 67/2010', 'Será considerado, en todo caso, como tiempo de trabajo efectivo, sin imputación al crédito horario, el correspondiente a las reuniones del Comité de Seguridad y Salud', null, '23db0a4df87529911b707741d2ecf9efde28ace4ac87867f678aceb3bdf635d4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '23db0a4df87529911b707741d2ecf9efde28ace4ac87867f678aceb3bdf635d4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se imputa al crédito de horas mensuales retribuidas que les corresponda como representantes.', false), ('B', 'Se imputa a un crédito horario adicional propio de los Delegados de Prevención.', false), ('C', 'No se considera tiempo de trabajo y debe recuperarse.', false), ('D', 'Se considera tiempo de trabajo efectivo, sin imputación al crédito horario.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-03b-prevencion-age-guardia-civil-prlgc-v1 (10 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto 179/2005, de 18 de febrero, sobre prevención de riesgos laborales en la Guardia Civil (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2005-3241', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-03b-prevencion-age-guardia-civil', 'Tema 3. Prevención de riesgos laborales (II): RD 67/2010 (AGE) y RD 179/2005 (Guardia Civil)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-03b-prevencion-age-guardia-civil' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 13 del Real Decreto 179/2005, sobre prevención de riesgos laborales en la Guardia Civil, ¿cuál de los siguientes es uno de los órganos de prevención que se constituyen en la Dirección General de la Guardia Civil?', 'El art. 13.2 RD 179/2005 enumera como órganos de prevención el Servicio de Prevención, la Sección de Prevención de Zona, la Oficina de Prevención de Comandancia y otras unidades.', 'gc_03b_prevencion_age_guardia_civil', (select id from public.topics where slug = 'gc-03b-prevencion-age-guardia-civil'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2005-3241'), 'Art. 13.2 RD 179/2005', 'a) Servicio de Prevención. b) Sección de Prevención de Zona. c) Oficina de Prevención de Comandancia. d) Otras unidades.', null, 'ba6b4d2fb60f63c00c9a8d19223cf931228139249ffb73325ca0d44ee8111250', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ba6b4d2fb60f63c00c9a8d19223cf931228139249ffb73325ca0d44ee8111250')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Oficina de Prevención de Comandancia.', true), ('B', 'El Comité de Seguridad y Salud de Comandancia.', false), ('C', 'La Junta de Prevención de Puesto.', false), ('D', 'La Delegación de Prevención de Compañía.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Entre los principios generales de la acción preventiva en el ámbito de las funciones propias del Cuerpo de la Guardia Civil, el artículo 3 bis del Real Decreto 179/2005 recoge el de:', 'El art. 3 bis RD 179/2005 (añadido por el RD 67/2026) incluye, entre otros, evitar los riesgos, combatirlos en su origen, adaptar el puesto al personal, tener en cuenta la evolución de la técnica y priorizar la protección colectiva sobre la individual.', 'gc_03b_prevencion_age_guardia_civil', (select id from public.topics where slug = 'gc-03b-prevencion-age-guardia-civil'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2005-3241'), 'Art. 3 bis RD 179/2005', 'f) Priorizar la protección colectiva sobre la individual.', null, 'afe142b3d9764e0178ea546d088117dd74e5beb3ae2218e734abf292615c8b5d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'afe142b3d9764e0178ea546d088117dd74e5beb3ae2218e734abf292615c8b5d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Priorizar la protección individual sobre la colectiva.', false), ('B', 'Priorizar la protección colectiva sobre la individual.', true), ('C', 'Adaptar el personal al puesto de trabajo.', false), ('D', 'Sustituir la formación por instrucciones escritas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 2 del Real Decreto 179/2005, las misiones de carácter militar que se encomienden a la Guardia Civil:', 'El ámbito de actividades del RD 179/2005 comprende las misiones de la LO 2/1986 de Fuerzas y Cuerpos de Seguridad; las misiones de carácter militar quedan sujetas a sus normas específicas (art. 2.b).', 'gc_03b_prevencion_age_guardia_civil', (select id from public.topics where slug = 'gc-03b-prevencion-age-guardia-civil'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2005-3241'), 'Art. 2.b) RD 179/2005', 'Las misiones de carácter militar que se encomienden a la Guardia Civil se regirán por sus normas específicas.', null, '069a4693b78dc0a474b252638b3c289802b2ae0578b8aae89aae618732ffb840', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '069a4693b78dc0a474b252638b3c289802b2ae0578b8aae89aae618732ffb840')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se regirán por sus normas específicas.', true), ('B', 'Se regirán por este real decreto, con las adaptaciones que dicte el Ministro de Defensa.', false), ('C', 'Se regirán por la Ley 31/1995, de Prevención de Riesgos Laborales, sin especialidades.', false), ('D', 'Se regirán por el Real Decreto 67/2010, de adaptación a la Administración General del Estado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 179/2005, en su redacción vigente, ¿qué órgano analizará y valorará las propuestas efectuadas por el personal en virtud del principio de participación?', 'Tras la modificación por el RD 696/2022, el art. 14 RD 179/2005 atribuye al Consejo de la Guardia Civil (art. 54.4 LO 11/2007) el análisis y valoración de las propuestas que el personal dirige a los órganos de prevención (art. 8).', 'gc_03b_prevencion_age_guardia_civil', (select id from public.topics where slug = 'gc-03b-prevencion-age-guardia-civil'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2005-3241'), 'Art. 14 RD 179/2005', 'El Consejo de la Guardia Civil, según lo dispuesto en el artículo 54.4 de la Ley Orgánica 11/2007, de 22 de octubre, reguladora de los derechos y deberes de los miembros de la Guardia Civil, analizará y valorará las propuestas efectuadas en virtud del principio de participación', null, '82145cf3d1b8c190ecb2428244b22d82b804946df1becc38b69d403a0b7dcc90', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '82145cf3d1b8c190ecb2428244b22d82b804946df1becc38b69d403a0b7dcc90')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Consejo Superior de la Guardia Civil.', false), ('B', 'El Servicio de Prevención de la Dirección General de la Guardia Civil.', false), ('C', 'La Inspección de Personal y Servicios de Seguridad.', false), ('D', 'El Consejo de la Guardia Civil.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 15 del Real Decreto 179/2005, las funciones de inspección y control externo de las actividades de los órganos de prevención de la Guardia Civil corresponden a:', 'El control interno corresponde a cada órgano de prevención respecto de los que dependen de él; el externo, a la Inspección de Personal y Servicios de Seguridad de la Secretaría de Estado de Seguridad, a la que el Servicio de Prevención remite copia de su memoria anual (art. 15).', 'gc_03b_prevencion_age_guardia_civil', (select id from public.topics where slug = 'gc-03b-prevencion-age-guardia-civil'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2005-3241'), 'Art. 15 RD 179/2005', 'La Inspección de Personal y Servicios de Seguridad de la Secretaría de Estado de Seguridad realizará las funciones de inspección y control externo de las actividades de los órganos citados en el párrafo anterior.', null, 'd5621c25288097ad939bf5a29286890a3d554d86a138d7d0a7fbc66a26f36f13', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd5621c25288097ad939bf5a29286890a3d554d86a138d7d0a7fbc66a26f36f13')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Inspección de Trabajo y Seguridad Social.', false), ('B', 'El Instituto Nacional de Seguridad e Higiene en el Trabajo.', false), ('C', 'La Inspección de Personal y Servicios de Seguridad de la Secretaría de Estado de Seguridad.', true), ('D', 'El Servicio de Prevención de la Dirección General de la Guardia Civil.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 6 del Real Decreto 179/2005, los reconocimientos de vigilancia de la salud del personal de la Guardia Civil serán realizados por:', 'El art. 6 RD 179/2005 (redacción del RD 67/2026) atribuye los reconocimientos a la Sanidad de la Guardia Civil o a un servicio de prevención ajeno contratado; los resultados se comunican por medios electrónicos a cada interesado.', 'gc_03b_prevencion_age_guardia_civil', (select id from public.topics where slug = 'gc-03b-prevencion-age-guardia-civil'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2005-3241'), 'Art. 6 RD 179/2005', 'Estos reconocimientos serán realizados por la Sanidad de la Guardia Civil o bien, mediante la contratación de un servicio de prevención ajeno.', null, '4e9841040f398173f2479bea7dfb7ce7919a05dbb4e05d455ed207d6cbd691ea', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4e9841040f398173f2479bea7dfb7ce7919a05dbb4e05d455ed207d6cbd691ea')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Sanidad Militar exclusivamente.', false), ('B', 'La Sanidad de la Guardia Civil o bien, mediante la contratación de un servicio de prevención ajeno.', true), ('C', 'Las mutualidades a las que esté adscrito el personal.', false), ('D', 'Los servicios públicos de salud de la comunidad autónoma de destino.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Conforme al artículo 16 del Real Decreto 179/2005, si existen discrepancias con la propuesta de requerimiento formulada por la Inspección de Personal y Servicios de Seguridad, ¿quién dictará la resolución procedente sobre la propuesta de requerimiento definitivo?', 'Ante discrepancias, la Inspección de Personal y Servicios de Seguridad puede elevar una propuesta de requerimiento definitivo al Secretario de Estado de Seguridad, que resuelve previos los informes que estime oportunos (art. 16, último párrafo).', 'gc_03b_prevencion_age_guardia_civil', (select id from public.topics where slug = 'gc-03b-prevencion-age-guardia-civil'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2005-3241'), 'Art. 16 RD 179/2005', 'la Inspección de Personal y Servicios de Seguridad podrá elevar una propuesta de requerimiento definitivo al Secretario de Estado de Seguridad, quien, previos los informes que estime oportunos, dictará la resolución procedente.', null, 'ac89640521c231599791dd1228126b655f09559d6709a6c577377c9cb5b9d64b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ac89640521c231599791dd1228126b655f09559d6709a6c577377c9cb5b9d64b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Director General de la Guardia Civil.', false), ('B', 'El Ministro del Interior.', false), ('C', 'El jefe del Servicio de Prevención de la Dirección General de la Guardia Civil.', false), ('D', 'El Secretario de Estado de Seguridad.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 12 del Real Decreto 179/2005, el personal de la Guardia Civil deberá informar de cualquier situación que, por motivos razonables, pueda suponer un riesgo para la seguridad y la salud:', 'Entre las obligaciones del personal, el art. 12.c) RD 179/2005 impone informar de inmediato y por conducto regular al personal designado para actividades de protección y prevención.', 'gc_03b_prevencion_age_guardia_civil', (select id from public.topics where slug = 'gc-03b-prevencion-age-guardia-civil'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2005-3241'), 'Art. 12.c) RD 179/2005', 'c) Informar de inmediato, por conducto regular, al personal designado para realizar actividades de protección y de prevención, acerca de cualquier situación que, por motivos razonables, pueda suponer un riesgo para la seguridad y la salud.', null, '433b2ce3ed442cef0c816eb8ff2f18776f05348df65725ecffe065c8a91912c3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '433b2ce3ed442cef0c816eb8ff2f18776f05348df65725ecffe065c8a91912c3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En el plazo de 24 horas, directamente al Consejo de la Guardia Civil.', false), ('B', 'Por escrito y en el plazo de tres días, a la Inspección de Personal y Servicios de Seguridad.', false), ('C', 'De inmediato, por conducto regular, al personal designado para realizar actividades de protección y de prevención.', true), ('D', 'Al final del servicio, al jefe de la unidad, que lo trasladará al Servicio de Prevención.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 16 del Real Decreto 179/2005, la Dirección General de la Guardia Civil podrá formular alegaciones a la propuesta de requerimiento de la Inspección de Personal y Servicios de Seguridad en el plazo de:', 'Del traslado de la propuesta de requerimiento al Director General, a través del Servicio de Prevención, se abre un plazo de 30 días hábiles para alegaciones; si no se formulan, la propuesta adquiere automáticamente carácter definitivo (art. 16).', 'gc_03b_prevencion_age_guardia_civil', (select id from public.topics where slug = 'gc-03b-prevencion-age-guardia-civil'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2005-3241'), 'Art. 16 RD 179/2005', 'que podrá formular alegaciones en el plazo de 30 días hábiles desde su notificación.', null, 'db02180bc094eef762fbf45db12b93f235fcda3e9148cdcf544e2c500eb8ce4f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'db02180bc094eef762fbf45db12b93f235fcda3e9148cdcf544e2c500eb8ce4f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '15 días hábiles desde su notificación.', false), ('B', '30 días hábiles desde su notificación.', true), ('C', '10 días naturales desde su recepción.', false), ('D', 'Dos meses desde su notificación.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 6 del Real Decreto 179/2005, ¿quiénes serán informados de las conclusiones de los reconocimientos médicos en relación con la aptitud del interesado para el desempeño del puesto de trabajo?', 'La información médica de carácter personal se limita al personal médico y autoridades que llevan a cabo la vigilancia de la salud, pero el mando de nivel Comandancia o similar y sus órganos de prevención conocen las conclusiones sobre aptitud o sobre la necesidad de mejorar las medidas de protección (art. 6).', 'gc_03b_prevencion_age_guardia_civil', (select id from public.topics where slug = 'gc-03b-prevencion-age-guardia-civil'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2005-3241'), 'Art. 6 RD 179/2005', 'los que ostenten el mando de unidad nivel Comandancia o similar y sus órganos de prevención serán informados de las conclusiones que se deriven de los reconocimientos efectuados en relación con la aptitud del interesado para el desempeño del puesto de trabajo', null, '57bb4a81f6a4a0a93a222aea967a383ab18be5418ea0c439f4a976b6a8450287', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '57bb4a81f6a4a0a93a222aea967a383ab18be5418ea0c439f4a976b6a8450287')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los que ostenten el mando de unidad nivel Comandancia o similar y sus órganos de prevención.', true), ('B', 'Todos los mandos de la cadena jerárquica del interesado, hasta el nivel de Puesto.', false), ('C', 'La Jefatura de Personal, para su anotación en el historial profesional.', false), ('D', 'El Consejo de la Guardia Civil, oídas las asociaciones profesionales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-05b-tratados-ue-eu_tfue_actos-v1 (7 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Tratado de Funcionamiento de la Unión Europea (versión consolidada), arts. 2-6 (competencias), 288-292 y 296-297 (actos jurídicos) y 300-307 (órganos consultivos)', 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016E/TXT', 'web_oficial'::public.source_kind, 'Unión Europea · EUR-Lex (DOUE C 202 de 7.6.2016)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-05b-tratados-ue', 'Tema 5. Derecho de la Unión Europea (II): principios, competencias, actos jurídicos y órganos consultivos (TUE y TFUE)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-05b-tratados-ue' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 3 del Tratado de Funcionamiento de la Unión Europea, ¿en cuál de los siguientes ámbitos dispone la Unión de competencia exclusiva?', 'El art. 3.1 TFUE enumera las competencias exclusivas: unión aduanera, normas sobre competencia para el mercado interior, política monetaria de la zona euro, conservación de los recursos biológicos marinos (pesca) y política comercial común. Medio ambiente y energía son compartidas (art. 4.2) y la protección civil es de apoyo (art. 6).', 'gc_05b_tratados_ue', (select id from public.topics where slug = 'gc-05b-tratados-ue'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016E/TXT'), 'Art. 3.1 TFUE', 'La Unión dispondrá de competencia exclusiva en los ámbitos siguientes: a) la unión aduanera;', null, '4150f45081c0094373ddada5935f55524b0d1eb8c77b57b6c9976e821c08477c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4150f45081c0094373ddada5935f55524b0d1eb8c77b57b6c9976e821c08477c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El medio ambiente.', false), ('B', 'La energía.', false), ('C', 'La protección civil.', false), ('D', 'La unión aduanera.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 4 del Tratado de Funcionamiento de la Unión Europea, es un ámbito de competencia compartida entre la Unión y los Estados miembros:', 'El art. 4.2 TFUE incluye entre las competencias compartidas el mercado interior, la política social, la cohesión, la agricultura y pesca, el medio ambiente, los consumidores, los transportes, las redes transeuropeas, la energía, el espacio de libertad, seguridad y justicia y la salud pública. La política comercial y la monetaria (euro) son exclusivas (art. 3) y la cultura es de apoyo (art. 6).', 'gc_05b_tratados_ue', (select id from public.topics where slug = 'gc-05b-tratados-ue'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016E/TXT'), 'Art. 4.2 TFUE', 'j) el espacio de libertad, seguridad y justicia;', null, '25e434a0b155b183a186ce22339a276129a458aca8fee62f61d4b6f025dc754c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '25e434a0b155b183a186ce22339a276129a458aca8fee62f61d4b6f025dc754c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El espacio de libertad, seguridad y justicia.', true), ('B', 'La política comercial común.', false), ('C', 'La política monetaria de los Estados miembros cuya moneda es el euro.', false), ('D', 'La cultura.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Tratado de Funcionamiento de la Unión Europea, en materia de protección civil la Unión dispone de:', 'El art. 6 TFUE incluye la protección civil (letra f) entre los ámbitos de acciones de apoyo, coordinación o complemento, junto a la salud humana, la industria, la cultura, el turismo, la educación y la cooperación administrativa. En ellos los actos de la Unión no pueden armonizar las legislaciones nacionales (art. 2.5).', 'gc_05b_tratados_ue', (select id from public.topics where slug = 'gc-05b-tratados-ue'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016E/TXT'), 'Art. 6 TFUE', 'La Unión dispondrá de competencia para llevar a cabo acciones con el fin de apoyar, coordinar o complementar la acción de los Estados miembros. […] f) la protección civil;', null, '2d82a923b589d5fd0cdf32088df40bcb5148785f5d80fd2a83e3eeefe62e5a30', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2d82a923b589d5fd0cdf32088df40bcb5148785f5d80fd2a83e3eeefe62e5a30')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Competencia exclusiva.', false), ('B', 'Competencia para llevar a cabo acciones con el fin de apoyar, coordinar o complementar la acción de los Estados miembros.', true), ('C', 'Competencia compartida con los Estados miembros.', false), ('D', 'Ninguna competencia, al ser una función esencial reservada a los Estados miembros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 288 del Tratado de Funcionamiento de la Unión Europea, el acto jurídico que obliga al Estado miembro destinatario en cuanto al resultado que deba conseguirse, dejando a las autoridades nacionales la elección de la forma y de los medios, es:', 'El art. 288 TFUE: el reglamento tiene alcance general y es obligatorio y directamente aplicable; la directiva obliga en cuanto al resultado; la decisión es obligatoria en todos sus elementos (para sus destinatarios, si los designa); recomendaciones y dictámenes no son vinculantes.', 'gc_05b_tratados_ue', (select id from public.topics where slug = 'gc-05b-tratados-ue'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016E/TXT'), 'Art. 288 TFUE', 'La directiva obligará al Estado miembro destinatario en cuanto al resultado que deba conseguirse, dejando, sin embargo, a las autoridades nacionales la elección de la forma y de los medios.', null, '85c71693854c7d981d03d5c44b06287a4fec746add32d5b9eebd7d85e0ab6224', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '85c71693854c7d981d03d5c44b06287a4fec746add32d5b9eebd7d85e0ab6224')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El reglamento.', false), ('B', 'La decisión.', false), ('C', 'La directiva.', true), ('D', 'La recomendación.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 290 del Tratado de Funcionamiento de la Unión Europea, un acto legislativo podrá delegar en la Comisión los poderes para adoptar:', 'El art. 290 TFUE regula los actos delegados: no legislativos, de alcance general, que completan o modifican elementos no esenciales; los elementos esenciales quedan reservados al acto legislativo. Los actos de ejecución se rigen por el art. 291 TFUE.', 'gc_05b_tratados_ue', (select id from public.topics where slug = 'gc-05b-tratados-ue'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016E/TXT'), 'Art. 290.1 TFUE', 'Un acto legislativo podrá delegar en la Comisión los poderes para adoptar actos no legislativos de alcance general que completen o modifiquen determinados elementos no esenciales del acto legislativo.', null, '77af9bad5417d8c353bf6dec5a0a9293e6e0b4e0612558b9b5e37a79459ec2ce', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '77af9bad5417d8c353bf6dec5a0a9293e6e0b4e0612558b9b5e37a79459ec2ce')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Actos legislativos que regulen los elementos esenciales de un ámbito.', false), ('B', 'Actos de ejecución que establezcan condiciones uniformes de ejecución en todos los Estados miembros.', false), ('C', 'Actos legislativos de alcance particular que modifiquen cualquier elemento del acto legislativo.', false), ('D', 'Actos no legislativos de alcance general que completen o modifiquen determinados elementos no esenciales del acto legislativo.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según los artículos 301 y 302 del Tratado de Funcionamiento de la Unión Europea, el número de miembros del Comité Económico y Social y la duración de su mandato son:', 'El art. 301 TFUE limita el Comité Económico y Social a 350 miembros (composición fijada por el Consejo por unanimidad a propuesta de la Comisión) y el art. 302 fija un mandato de cinco años renovable. Los dos años y medio corresponden al mandato del Presidente y de la Mesa (art. 303).', 'gc_05b_tratados_ue', (select id from public.topics where slug = 'gc-05b-tratados-ue'), 3, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016E/TXT'), 'Arts. 301 y 302 TFUE', 'El número de miembros del Comité Económico y Social no excederá de trescientos cincuenta. […] Los miembros del Comité serán nombrados para un período de cinco años. […] El mandato de los miembros del Comité será renovable.', null, 'f450abe34382cfcc4fb53652ab33296c01171317c2f9e8755b522b791b59ebc0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f450abe34382cfcc4fb53652ab33296c01171317c2f9e8755b522b791b59ebc0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No más de trescientos cincuenta miembros, nombrados para un período de dos años y medio renovable.', false), ('B', 'No más de trescientos cincuenta miembros, nombrados para un período de cinco años renovable.', true), ('C', 'No más de setecientos cincuenta miembros, nombrados para un período de cinco años no renovable.', false), ('D', 'No más de doscientos veintidós miembros, nombrados para un período de cuatro años renovable.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 304 del Tratado de Funcionamiento de la Unión Europea, cuando el Parlamento Europeo, el Consejo o la Comisión fijen al Comité Económico y Social un plazo para la presentación de su dictamen, ese plazo:', 'El art. 304 TFUE fija un plazo mínimo de un mes desde la notificación al Presidente del Comité; vencido sin dictamen, puede prescindirse de él. El art. 307 TFUE establece la misma regla para el Comité de las Regiones.', 'gc_05b_tratados_ue', (select id from public.topics where slug = 'gc-05b-tratados-ue'), 3, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016E/TXT'), 'Art. 304 TFUE', 'Si lo estimaren necesario, el Parlamento Europeo, el Consejo o la Comisión fijarán al Comité un plazo para la presentación de su dictamen, que no podrá ser inferior a un mes a partir de la fecha de la notificación que, a tal fin, se curse al Presidente. Transcurrido el plazo fijado sin haberse recibido el dictamen, podrá prescindirse del mismo.', null, '20e82268143833e2cc0fa1eb20e01a52cb5fe664200ebcb20e0eed76acf00ecf', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '20e82268143833e2cc0fa1eb20e01a52cb5fe664200ebcb20e0eed76acf00ecf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No podrá ser inferior a un mes a partir de la notificación al Presidente; transcurrido sin dictamen, podrá prescindirse del mismo.', true), ('B', 'No podrá ser inferior a tres meses; transcurrido sin dictamen, se entenderá emitido en sentido favorable.', false), ('C', 'No podrá ser superior a quince días; transcurrido sin dictamen, se suspenderá el procedimiento.', false), ('D', 'No podrá ser inferior a dos meses; transcurrido sin dictamen, deberá consultarse al Comité de las Regiones.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-05b-tratados-ue-eu_tue_princ-v1 (13 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Tratado de la Unión Europea (versión consolidada), títulos I y II (arts. 1-12) y arts. 49-50', 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016M/TXT', 'web_oficial'::public.source_kind, 'Unión Europea · EUR-Lex (DOUE C 202 de 7.6.2016)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-05b-tratados-ue', 'Tema 5. Derecho de la Unión Europea (II): principios, competencias, actos jurídicos y órganos consultivos (TUE y TFUE)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-05b-tratados-ue' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 1 del Tratado de la Unión Europea, el Tratado de la Unión Europea y el Tratado de Funcionamiento de la Unión Europea:', 'El art. 1 TUE dispone que la Unión se fundamenta en el TUE y en el TFUE («los Tratados»), que ambos tienen el mismo valor jurídico y que la Unión sustituye y sucede a la Comunidad Europea.', 'gc_05b_tratados_ue', (select id from public.topics where slug = 'gc-05b-tratados-ue'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016M/TXT'), 'Art. 1 TUE', 'La Unión se fundamenta en el presente Tratado y en el Tratado de Funcionamiento de la Unión Europea (en lo sucesivo denominados «los Tratados»). Ambos Tratados tienen el mismo valor jurídico.', null, 'e766a7295c91cc92cc3ba265e80cc6836739939d0ea02f6e65c69235d2471dad', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e766a7295c91cc92cc3ba265e80cc6836739939d0ea02f6e65c69235d2471dad')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tienen distinto valor jurídico: prevalece el Tratado de la Unión Europea.', false), ('B', 'Tienen distinto valor jurídico: prevalece el Tratado de Funcionamiento de la Unión Europea.', false), ('C', 'Tienen el mismo valor jurídico.', true), ('D', 'Tienen el valor jurídico que fije cada Estado miembro conforme a sus normas constitucionales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Conforme al artículo 2 del Tratado de la Unión Europea, la Unión se fundamenta en los valores de respeto de la dignidad humana, libertad, democracia, igualdad, Estado de Derecho y:', 'El art. 2 TUE enumera los valores de la Unión: dignidad humana, libertad, democracia, igualdad, Estado de Derecho y respeto de los derechos humanos, incluidos los de las personas pertenecientes a minorías. La economía social de mercado aparece en el art. 3.3 TUE como medio para el desarrollo sostenible, no como valor.', 'gc_05b_tratados_ue', (select id from public.topics where slug = 'gc-05b-tratados-ue'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016M/TXT'), 'Art. 2 TUE', 'La Unión se fundamenta en los valores de respeto de la dignidad humana, libertad, democracia, igualdad, Estado de Derecho y respeto de los derechos humanos, incluidos los derechos de las personas pertenecientes a minorías.', null, '76e1f2ac407aa747af08272b6684cdf7274b5f70ac5701750b858efd8f7f7171', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '76e1f2ac407aa747af08272b6684cdf7274b5f70ac5701750b858efd8f7f7171')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Respeto de los derechos humanos, incluidos los derechos de las personas pertenecientes a minorías.', true), ('B', 'Respeto de la soberanía nacional de los Estados miembros.', false), ('C', 'Economía social de mercado altamente competitiva.', false), ('D', 'Primacía del Derecho de la Unión sobre el Derecho nacional.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 4 del Tratado de la Unión Europea, la seguridad nacional:', 'El art. 4.2 TUE obliga a la Unión a respetar las funciones esenciales del Estado (integridad territorial, orden público y seguridad nacional) y precisa que la seguridad nacional sigue siendo responsabilidad exclusiva de cada Estado miembro.', 'gc_05b_tratados_ue', (select id from public.topics where slug = 'gc-05b-tratados-ue'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016M/TXT'), 'Art. 4.2 TUE', 'Respetará las funciones esenciales del Estado, especialmente las que tienen por objeto garantizar su integridad territorial, mantener el orden público y salvaguardar la seguridad nacional. En particular, la seguridad nacional seguirá siendo responsabilidad exclusiva de cada Estado miembro.', null, 'fab958c88a555c81d5271abe9bebd5941b06b2ab592e61fe43b7989722d44131', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'fab958c88a555c81d5271abe9bebd5941b06b2ab592e61fe43b7989722d44131')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Es una competencia compartida entre la Unión y los Estados miembros.', false), ('B', 'Es una competencia exclusiva de la Unión en el marco del espacio de libertad, seguridad y justicia.', false), ('C', 'Corresponde al Consejo Europeo, que fija sus orientaciones generales.', false), ('D', 'Seguirá siendo responsabilidad exclusiva de cada Estado miembro.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 5 del Tratado de la Unión Europea, la delimitación de las competencias de la Unión se rige por el principio de:', 'El art. 5.1 TUE distingue: la delimitación de las competencias se rige por el principio de atribución; su ejercicio, por los principios de subsidiariedad y proporcionalidad. La cooperación leal se recoge en el art. 4.3 TUE.', 'gc_05b_tratados_ue', (select id from public.topics where slug = 'gc-05b-tratados-ue'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016M/TXT'), 'Art. 5.1 TUE', 'La delimitación de las competencias de la Unión se rige por el principio de atribución. El ejercicio de las competencias de la Unión se rige por los principios de subsidiariedad y proporcionalidad.', null, 'c60b9529f1ec25cb4bef9d8d49f613b483029397337f846eaae7bef0d645f4c2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c60b9529f1ec25cb4bef9d8d49f613b483029397337f846eaae7bef0d645f4c2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Subsidiariedad.', false), ('B', 'Atribución.', true), ('C', 'Proporcionalidad.', false), ('D', 'Cooperación leal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 5 del Tratado de la Unión Europea, ¿quiénes velarán por el respeto del principio de subsidiariedad con arreglo al procedimiento establecido en el Protocolo sobre la aplicación de los principios de subsidiariedad y proporcionalidad?', 'El art. 5.3 TUE encomienda a los Parlamentos nacionales velar por el respeto del principio de subsidiariedad conforme al Protocolo; el art. 12.b) TUE reitera esta función.', 'gc_05b_tratados_ue', (select id from public.topics where slug = 'gc-05b-tratados-ue'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016M/TXT'), 'Art. 5.3 TUE', 'Los Parlamentos nacionales velarán por el respeto del principio de subsidiariedad con arreglo al procedimiento establecido en el mencionado Protocolo.', null, 'b826f6b2af3e86db6c5347612df5c19de52b5919fba1f8e384d6749965a222bd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b826f6b2af3e86db6c5347612df5c19de52b5919fba1f8e384d6749965a222bd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Comité de las Regiones.', false), ('B', 'El Tribunal de Cuentas.', false), ('C', 'El Consejo Europeo.', false), ('D', 'Los Parlamentos nacionales.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 5 del Tratado de la Unión Europea, el principio en virtud del cual el contenido y la forma de la acción de la Unión no excederán de lo necesario para alcanzar los objetivos de los Tratados es el principio de:', 'El art. 5.4 TUE define la proporcionalidad: contenido y forma de la acción de la Unión no excederán de lo necesario. La subsidiariedad (art. 5.3) decide si la Unión debe intervenir en ámbitos que no son de su competencia exclusiva.', 'gc_05b_tratados_ue', (select id from public.topics where slug = 'gc-05b-tratados-ue'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016M/TXT'), 'Art. 5.4 TUE', 'En virtud del principio de proporcionalidad, el contenido y la forma de la acción de la Unión no excederán de lo necesario para alcanzar los objetivos de los Tratados.', null, '19e5375f1733c2d32dd319fc24329de024388985b1d5245325987a15ebfc8dc0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '19e5375f1733c2d32dd319fc24329de024388985b1d5245325987a15ebfc8dc0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Proporcionalidad.', true), ('B', 'Subsidiariedad.', false), ('C', 'Atribución.', false), ('D', 'Cooperación leal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 6 del Tratado de la Unión Europea, la Carta de los Derechos Fundamentales de la Unión Europea:', 'El art. 6.1 TUE reconoce los derechos, libertades y principios de la Carta (2000, adaptada en Estrasburgo en 2007) con el mismo valor jurídico que los Tratados, y precisa que sus disposiciones no ampliarán las competencias de la Unión.', 'gc_05b_tratados_ue', (select id from public.topics where slug = 'gc-05b-tratados-ue'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016M/TXT'), 'Art. 6.1 TUE', 'La Unión reconoce los derechos, libertades y principios enunciados en la Carta de los Derechos Fundamentales de la Unión Europea de 7 de diciembre de 2000, tal como fue adaptada el 12 de diciembre de 2007 en Estrasburgo, la cual tendrá el mismo valor jurídico que los Tratados.', null, '5d424ff32c355aed2f1773cbf8dabdb416c208692fcf3b9b65267656003bcdd0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5d424ff32c355aed2f1773cbf8dabdb416c208692fcf3b9b65267656003bcdd0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tendrá el valor de una declaración política sin efectos jurídicos vinculantes.', false), ('B', 'Tendrá el mismo valor jurídico que los Tratados.', true), ('C', 'Tendrá el mismo valor jurídico que los reglamentos de la Unión.', false), ('D', 'Ampliará las competencias de la Unión en materia de derechos fundamentales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 7.1 del Tratado de la Unión Europea, la constatación de la existencia de un riesgo claro de violación grave por parte de un Estado miembro de los valores del artículo 2 corresponde:', 'El art. 7.1 TUE (riesgo claro de violación grave) exige propuesta motivada de un tercio de los Estados miembros, del Parlamento Europeo o de la Comisión, y decisión del Consejo por cuatro quintos con aprobación del Parlamento. La violación grave y persistente (art. 7.2) la constata el Consejo Europeo por unanimidad.', 'gc_05b_tratados_ue', (select id from public.topics where slug = 'gc-05b-tratados-ue'), 3, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016M/TXT'), 'Art. 7.1 TUE', 'A propuesta motivada de un tercio de los Estados miembros, del Parlamento Europeo o de la Comisión, el Consejo, por mayoría de cuatro quintos de sus miembros y previa aprobación del Parlamento Europeo, podrá constatar la existencia de un riesgo claro de violación grave por parte de un Estado miembro de los valores contemplados en el artículo 2.', null, '5dc670cda3ea1ddb4b03ee224050f6bfbf849f85d85d7f2e5d1d8e4401a98df9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5dc670cda3ea1ddb4b03ee224050f6bfbf849f85d85d7f2e5d1d8e4401a98df9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Consejo Europeo, por unanimidad y previa aprobación del Parlamento Europeo.', false), ('B', 'Al Consejo, por mayoría cualificada y previa consulta a la Comisión.', false), ('C', 'Al Consejo, por mayoría de cuatro quintos de sus miembros y previa aprobación del Parlamento Europeo.', true), ('D', 'Al Parlamento Europeo, por mayoría de dos tercios de los votos emitidos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Conforme al artículo 7.2 del Tratado de la Unión Europea, la existencia de una violación grave y persistente por parte de un Estado miembro de los valores contemplados en el artículo 2 podrá ser constatada por el Consejo Europeo:', 'El art. 7.2 TUE atribuye la constatación al Consejo Europeo por unanimidad, a propuesta de un tercio de los Estados miembros o de la Comisión (no del Parlamento) y previa aprobación del Parlamento Europeo. Después, el Consejo puede suspender derechos por mayoría cualificada (art. 7.3).', 'gc_05b_tratados_ue', (select id from public.topics where slug = 'gc-05b-tratados-ue'), 3, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016M/TXT'), 'Art. 7.2 TUE', 'El Consejo Europeo, por unanimidad y a propuesta de un tercio de los Estados miembros o de la Comisión y previa aprobación del Parlamento Europeo, podrá constatar la existencia de una violación grave y persistente por parte de un Estado miembro de los valores contemplados en el artículo 2', null, 'c875d5fac1fb81c9bb72bddbdd175dad52bfa2f9d408116a3c09cb55be258137', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c875d5fac1fb81c9bb72bddbdd175dad52bfa2f9d408116a3c09cb55be258137')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por mayoría cualificada, a propuesta del Parlamento Europeo y previa consulta a la Comisión.', false), ('B', 'Por mayoría de cuatro quintos, a propuesta motivada de un tercio de los Estados miembros, del Parlamento Europeo o de la Comisión.', false), ('C', 'Por unanimidad, a propuesta del Tribunal de Justicia y previa aprobación del Consejo.', false), ('D', 'Por unanimidad, a propuesta de un tercio de los Estados miembros o de la Comisión y previa aprobación del Parlamento Europeo.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 9 del Tratado de la Unión Europea, la ciudadanía de la Unión:', 'El art. 9 TUE: es ciudadano de la Unión toda persona que tenga la nacionalidad de un Estado miembro; la ciudadanía de la Unión se añade a la nacional sin sustituirla.', 'gc_05b_tratados_ue', (select id from public.topics where slug = 'gc-05b-tratados-ue'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016M/TXT'), 'Art. 9 TUE', 'Será ciudadano de la Unión toda persona que tenga la nacionalidad de un Estado miembro. La ciudadanía de la Unión se añade a la ciudadanía nacional sin sustituirla.', null, 'b7112ce0779babf263b23a718807c5b42494a4ff02b7aa80ef84b24604cdbff6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b7112ce0779babf263b23a718807c5b42494a4ff02b7aa80ef84b24604cdbff6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sustituye a la ciudadanía nacional de los Estados miembros.', false), ('B', 'Corresponde a toda persona que resida legalmente en un Estado miembro.', false), ('C', 'Se añade a la ciudadanía nacional sin sustituirla.', true), ('D', 'Se adquiere tras cinco años de residencia en la Unión.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 11 del Tratado de la Unión Europea, la iniciativa para invitar a la Comisión Europea a que presente una propuesta de acto jurídico puede tomarla un grupo de al menos:', 'El art. 11.4 TUE regula la iniciativa ciudadana europea: al menos un millón de ciudadanos de la Unión que sean nacionales de un número significativo de Estados miembros; los procedimientos se fijan conforme al art. 24 TFUE.', 'gc_05b_tratados_ue', (select id from public.topics where slug = 'gc-05b-tratados-ue'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016M/TXT'), 'Art. 11.4 TUE', 'Un grupo de al menos un millón de ciudadanos de la Unión, que sean nacionales de un número significativo de Estados miembros, podrá tomar la iniciativa de invitar a la Comisión Europea, en el marco de sus atribuciones, a que presente una propuesta adecuada', null, 'd94fac9790c8d17494e9f19de8c4fd87027e1730de158ec20c4c93154b82bbff', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd94fac9790c8d17494e9f19de8c4fd87027e1730de158ec20c4c93154b82bbff')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un millón de ciudadanos de la Unión, nacionales de un número significativo de Estados miembros.', true), ('B', 'Quinientos mil ciudadanos de la Unión, nacionales de al menos siete Estados miembros.', false), ('C', 'Un millón de ciudadanos de la Unión, con independencia de su nacionalidad.', false), ('D', 'Dos millones de ciudadanos de la Unión, nacionales de un tercio de los Estados miembros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 50 del Tratado de la Unión Europea, si no entra en vigor un acuerdo de retirada, los Tratados dejarán de aplicarse al Estado miembro que se retira:', 'El art. 50.3 TUE fija el cese de aplicación de los Tratados en la fecha de entrada en vigor del acuerdo de retirada o, en su defecto, a los dos años de la notificación al Consejo Europeo, prorrogables por unanimidad del Consejo Europeo de acuerdo con el Estado afectado.', 'gc_05b_tratados_ue', (select id from public.topics where slug = 'gc-05b-tratados-ue'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016M/TXT'), 'Art. 50.3 TUE', 'Los Tratados dejarán de aplicarse al Estado de que se trate a partir de la fecha de entrada en vigor del acuerdo de retirada o, en su defecto, a los dos años de la notificación a que se refiere el apartado 2, salvo si el Consejo Europeo, de acuerdo con dicho Estado, decide por unanimidad prorrogar dicho plazo.', null, '58a2d5e42264f920fdd4848873c89ff75c1333f2ece7ec17b05ffc3c47babb26', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '58a2d5e42264f920fdd4848873c89ff75c1333f2ece7ec17b05ffc3c47babb26')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al año de la notificación de su intención al Consejo, salvo prórroga decidida por mayoría cualificada.', false), ('B', 'A los dos años de la notificación de su intención al Consejo Europeo, salvo prórroga decidida por unanimidad por el Consejo Europeo de acuerdo con dicho Estado.', true), ('C', 'A los dos años de la notificación, sin posibilidad de prórroga.', false), ('D', 'A los tres años de la notificación de su intención a la Comisión, salvo prórroga decidida por el Parlamento Europeo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 49 del Tratado de la Unión Europea, el Estado europeo que solicite el ingreso en la Unión dirigirá su solicitud al Consejo, que se pronunciará:', 'El art. 49 TUE: la solicitud se dirige al Consejo, que decide por unanimidad tras consultar a la Comisión y con aprobación del Parlamento Europeo por mayoría de sus miembros; las condiciones de admisión se fijan en un acuerdo ratificado por todos los Estados contratantes.', 'gc_05b_tratados_ue', (select id from public.topics where slug = 'gc-05b-tratados-ue'), 3, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016M/TXT'), 'Art. 49 TUE', 'El Estado solicitante dirigirá su solicitud al Consejo, que se pronunciará por unanimidad después de haber consultado a la Comisión y previa aprobación del Parlamento Europeo, el cual se pronunciará por mayoría de los miembros que lo componen.', null, '2a8179a488440058c4741292b8df4a7baac9d78ef34fc79effda9953fdc7911a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2a8179a488440058c4741292b8df4a7baac9d78ef34fc79effda9953fdc7911a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por mayoría cualificada, después de haber consultado al Parlamento Europeo y previa aprobación de la Comisión.', false), ('B', 'Por unanimidad, previa aprobación del Parlamento Europeo por mayoría de dos tercios de los votos emitidos.', false), ('C', 'Por unanimidad, después de haber consultado a la Comisión y previa aprobación del Parlamento Europeo, que se pronunciará por mayoría de los miembros que lo componen.', true), ('D', 'Por mayoría de cuatro quintos, previa consulta al Consejo Europeo y a los Parlamentos nacionales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-06a-instituciones-internacionales-eu_tue-v1 (4 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Tratado de la Unión Europea (versión consolidada), arts. 13-19', 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016M/TXT', 'web_oficial'::public.source_kind, 'Unión Europea · EUR-Lex (DOUE C 202 de 7.6.2016)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-06a-instituciones-internacionales', 'Tema 6. Instituciones internacionales (I): ONU, Consejo de Europa, Unión Europea y OTAN') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-06a-instituciones-internacionales' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 14 del Tratado de la Unión Europea, el número de diputados del Parlamento Europeo:', 'El art. 14.2 TUE fija un máximo de 750 diputados más el Presidente, con representación decrecientemente proporcional, un mínimo de 6 y un máximo de 96 escaños por Estado miembro.', 'gc_06a_instituciones_internacionales', (select id from public.topics where slug = 'gc-06a-instituciones-internacionales'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016M/TXT'), 'Art. 14.2 TUE', 'Su número no excederá de setecientos cincuenta, más el Presidente. La representación de los ciudadanos será decrecientemente proporcional, con un mínimo de seis diputados por Estado miembro. No se asignará a ningún Estado miembro más de noventa y seis escaños.', null, 'e005b1380ba67db2724faec3f2c54797913cf2b083ef89d4d11b795cb202e260', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e005b1380ba67db2724faec3f2c54797913cf2b083ef89d4d11b795cb202e260')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No excederá de setecientos cincuenta, más el Presidente, con un mínimo de seis y un máximo de noventa y seis escaños por Estado miembro.', true), ('B', 'No excederá de setecientos cincuenta, incluido el Presidente, con un mínimo de cuatro escaños por Estado miembro.', false), ('C', 'No excederá de setecientos, más el Presidente, con un máximo de noventa y seis escaños por Estado miembro.', false), ('D', 'No excederá de setecientos cincuenta, más el Presidente, con un mínimo de seis y un máximo de ochenta escaños por Estado miembro.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 14 del Tratado de la Unión Europea, los diputados al Parlamento Europeo son elegidos por sufragio universal directo, libre y secreto para un mandato de:', 'El art. 14.3 TUE fija un mandato de cinco años; los dos años y medio corresponden al mandato del Presidente del Consejo Europeo (art. 15.5 TUE).', 'gc_06a_instituciones_internacionales', (select id from public.topics where slug = 'gc-06a-instituciones-internacionales'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016M/TXT'), 'Art. 14.3 TUE', 'Los diputados al Parlamento Europeo serán elegidos por sufragio universal directo, libre y secreto, para un mandato de cinco años.', null, '0e5c2598729736e848b7ac683b09b9f93011fd15d5ef0267c91d20b8e8b2514f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0e5c2598729736e848b7ac683b09b9f93011fd15d5ef0267c91d20b8e8b2514f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cuatro años.', false), ('B', 'Seis años.', false), ('C', 'Cinco años.', true), ('D', 'Dos años y medio.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 15 del Tratado de la Unión Europea, el Presidente del Consejo Europeo es elegido:', 'El art. 15.5 TUE: el Consejo Europeo elige a su Presidente por mayoría cualificada para dos años y medio, renovable una sola vez, y puede ponerle fin por el mismo procedimiento en caso de impedimento o falta grave.', 'gc_06a_instituciones_internacionales', (select id from public.topics where slug = 'gc-06a-instituciones-internacionales'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016M/TXT'), 'Art. 15.5 TUE', 'El Consejo Europeo elegirá a su Presidente por mayoría cualificada para un mandato de dos años y medio, que podrá renovarse una sola vez.', null, '2584a5fc4f38299a8c7ce08840f7c140ade878cb58a4cc969776dc15dcbee9a8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2584a5fc4f38299a8c7ce08840f7c140ade878cb58a4cc969776dc15dcbee9a8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por el Parlamento Europeo, por mayoría absoluta, para un mandato de cinco años.', false), ('B', 'Por el Consejo Europeo, por unanimidad, para un mandato de dos años y medio no renovable.', false), ('C', 'Por el Consejo Europeo, por mayoría cualificada, para un mandato de dos años y medio renovable una sola vez.', true), ('D', 'Por rotación semestral entre los Estados miembros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 16.4 del Tratado de la Unión Europea, a partir del 1 de noviembre de 2014 la mayoría cualificada en el Consejo se define como un mínimo de:', 'El art. 16.4 TUE exige el 55 % de los miembros (al menos 15) que representen al menos el 65 % de la población; la minoría de bloqueo requiere al menos cuatro miembros.', 'gc_06a_instituciones_internacionales', (select id from public.topics where slug = 'gc-06a-instituciones-internacionales'), 3, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016M/TXT'), 'Art. 16.4 TUE', 'A partir del 1 de noviembre de 2014, la mayoría cualificada se definirá como un mínimo del 55 % de los miembros del Consejo que incluya al menos a quince de ellos y represente a Estados miembros que reúnan como mínimo el 65 % de la población de la Unión.', null, 'fcc1b942eb39b683000f6ee0ea3cdaea1f79bfe8843aa91702feb732b69a1820', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'fcc1b942eb39b683000f6ee0ea3cdaea1f79bfe8843aa91702feb732b69a1820')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 65 % de los miembros del Consejo, que represente a Estados miembros que reúnan como mínimo el 55 % de la población de la Unión.', false), ('B', 'El 55 % de los miembros del Consejo, que incluya al menos a quince de ellos y represente a Estados miembros que reúnan como mínimo el 65 % de la población de la Unión.', true), ('C', 'El 55 % de los miembros del Consejo, que incluya al menos a doce de ellos y represente como mínimo el 60 % de la población de la Unión.', false), ('D', 'Dos tercios de los miembros del Consejo, que representen como mínimo el 65 % de la población de la Unión.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-06a-instituciones-internacionales-oi_coe_estatuto-v1 (5 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Estatuto del Consejo de Europa (Londres, 5 de mayo de 1949), Instrumento de Adhesión de España (BOE núm. 51, de 1 de marzo de 1978)', 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1978-5972', 'web_oficial'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-06a-instituciones-internacionales', 'Tema 6. Instituciones internacionales (I): ONU, Consejo de Europa, Unión Europea y OTAN') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-06a-instituciones-internacionales' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 11 del Estatuto del Consejo de Europa, la sede del Consejo de Europa es:', 'El art. 11 del Estatuto (hecho en Londres el 5 de mayo de 1949) fija la sede en Estrasburgo.', 'gc_06a_instituciones_internacionales', (select id from public.topics where slug = 'gc-06a-instituciones-internacionales'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1978-5972'), 'Art. 11 Estatuto del Consejo de Europa', 'La sede del Consejo de Europa es Estrasburgo.', null, 'a5a3303c8a9a9fac15a045f336aaa3e1b00688210f3bb7acda54273c582710a9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a5a3303c8a9a9fac15a045f336aaa3e1b00688210f3bb7acda54273c582710a9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Bruselas.', false), ('B', 'Estrasburgo.', true), ('C', 'Londres.', false), ('D', 'Luxemburgo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 12 del Estatuto del Consejo de Europa, los idiomas oficiales del Consejo de Europa son:', 'El art. 12 establece como idiomas oficiales el francés y el inglés; los reglamentos internos del Comité de Ministros y de la Asamblea determinan cuándo pueden emplearse otros.', 'gc_06a_instituciones_internacionales', (select id from public.topics where slug = 'gc-06a-instituciones-internacionales'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1978-5972'), 'Art. 12 Estatuto del Consejo de Europa', 'Los idiomas oficiales del Consejo de Europa son el francés y el inglés.', null, '480c3919cab7f5219dc9c85da502792878733ca2c6919946f43007b11c5d34c3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '480c3919cab7f5219dc9c85da502792878733ca2c6919946f43007b11c5d34c3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El francés y el inglés.', true), ('B', 'El francés, el inglés y el alemán.', false), ('C', 'El inglés, el francés y el español.', false), ('D', 'Todas las lenguas oficiales de los Estados miembros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 1 del Estatuto del Consejo de Europa, ¿qué asuntos no son de la competencia del Consejo de Europa?', 'El art. 1.b) incluye la acción conjunta en los campos económico, social, cultural, científico, jurídico y administrativo y la salvaguardia de los derechos humanos; el art. 1.d) excluye la defensa nacional.', 'gc_06a_instituciones_internacionales', (select id from public.topics where slug = 'gc-06a-instituciones-internacionales'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1978-5972'), 'Art. 1.d) Estatuto del Consejo de Europa', 'd) Los asuntos relativos a la defensa nacional no son de la competencia del Consejo de Europa.', null, 'c66baf80779882b38bb591e7abef7295387eb670fbb1dc2ef9d853ceab3fc49e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c66baf80779882b38bb591e7abef7295387eb670fbb1dc2ef9d853ceab3fc49e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los asuntos relativos a los derechos humanos y las libertades fundamentales.', false), ('B', 'Los asuntos de carácter cultural y científico.', false), ('C', 'Los asuntos de carácter jurídico y administrativo.', false), ('D', 'Los asuntos relativos a la defensa nacional.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 14 del Estatuto del Consejo de Europa, los representantes de cada Miembro en el Comité de Ministros son:', 'Cada Miembro tiene un representante con un voto en el Comité de Ministros, que es su Ministro de Asuntos Exteriores (puede designarse un suplente). Los representantes en la Asamblea, en cambio, los elige cada Parlamento (art. 25).', 'gc_06a_instituciones_internacionales', (select id from public.topics where slug = 'gc-06a-instituciones-internacionales'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1978-5972'), 'Art. 14 Estatuto del Consejo de Europa', 'Cada Miembro tendrá un representante en el Comité de Ministros y cada representante tiene un voto. Los representantes en el Comité son los Ministros de Asuntos Exteriores.', null, 'd4912de38b4604147aef0c35480cea8dea8c801dcb8320ad54fd50db2708882e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd4912de38b4604147aef0c35480cea8dea8c801dcb8320ad54fd50db2708882e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los Jefes de Estado o de Gobierno.', false), ('B', 'Los Ministros de Justicia.', false), ('C', 'Miembros de los Parlamentos nacionales elegidos por estos.', false), ('D', 'Los Ministros de Asuntos Exteriores.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 20 del Estatuto del Consejo de Europa, las resoluciones del Comité de Ministros para invitar a un Estado a convertirse en Miembro o Miembro asociado (artículos 4 y 5) requieren:', 'El art. 20.c) exige mayoría de dos tercios de los representantes con derecho a participar en las sesiones para las resoluciones de los arts. 4 y 5; la unanimidad (art. 20.a) se reserva a otras cuestiones importantes y la mayoría simple (art. 20.b) a las de reglamento interno y régimen financiero y administrativo.', 'gc_06a_instituciones_internacionales', (select id from public.topics where slug = 'gc-06a-instituciones-internacionales'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1978-5972'), 'Art. 20.c) Estatuto del Consejo de Europa', 'c) Las resoluciones del Comité, adoptadas en cumplimiento de los artículos 4 y 5, requerirán una mayoría de los dos tercios de los representantes con derecho a participar en las sesiones del Comité.', null, '9ae10094b0a1f0ee45cf7c5933e6b35c5f3fddb886688253301e687bfbeb5a03', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9ae10094b0a1f0ee45cf7c5933e6b35c5f3fddb886688253301e687bfbeb5a03')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La unanimidad de los votos emitidos.', false), ('B', 'Una mayoría de los dos tercios de los representantes con derecho a participar en las sesiones del Comité.', true), ('C', 'La mayoría simple de los representantes con derecho a formar parte del Comité.', false), ('D', 'Una mayoría de tres quintos de los votos emitidos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-06a-instituciones-internacionales-oi_onu-v1 (5 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Naciones Unidas · Órganos principales', 'https://www.un.org/es/about-us/main-bodies', 'web_oficial'::public.source_kind, 'Organización de las Naciones Unidas (web oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-06a-instituciones-internacionales', 'Tema 6. Instituciones internacionales (I): ONU, Consejo de Europa, Unión Europea y OTAN') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-06a-instituciones-internacionales' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de las Naciones Unidas, ¿cuál de los siguientes NO es uno de los seis órganos principales de la ONU?', 'Los órganos principales, todos establecidos por la Carta en 1945, son la Asamblea General, el Consejo de Seguridad, el Consejo Económico y Social, el Consejo de Administración Fiduciaria, la Corte Internacional de Justicia y la Secretaría. El Consejo de Derechos Humanos no figura entre ellos.', 'gc_06a_instituciones_internacionales', (select id from public.topics where slug = 'gc-06a-instituciones-internacionales'), 1, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/main-bodies'), 'ONU, órganos principales', 'Los principales órganos de las Naciones Unidas son la Asamblea General, el Consejo de Seguridad, el Consejo Económico y Social, el Consejo de Administración Fiduciaria, la Corte Internacional de Justicia y la Secretaría de la ONU.', null, '565563b05df44179befd4f231c2e1c71c0e0eb3110d0e5a5e439d99cf87ab404', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '565563b05df44179befd4f231c2e1c71c0e0eb3110d0e5a5e439d99cf87ab404')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Consejo de Administración Fiduciaria.', false), ('B', 'La Corte Internacional de Justicia.', false), ('C', 'El Consejo Económico y Social.', false), ('D', 'El Consejo de Derechos Humanos.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de las Naciones Unidas, el Consejo de Seguridad cuenta con:', 'El Consejo de Seguridad tiene 15 miembros (5 permanentes con derecho de veto y 10 no permanentes); los 54 miembros corresponden al Consejo Económico y Social.', 'gc_06a_instituciones_internacionales', (select id from public.topics where slug = 'gc-06a-instituciones-internacionales'), 1, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/main-bodies'), 'ONU, Consejo de Seguridad', 'Cuenta con 15 Miembros (5 permanentes y 10 no permanentes). Cada uno tiene un voto, aunque los cinco permanentes cuentan con el poder del veto.', null, '6389b3ad34d9c3ae3bff9cd5bb0062270f1157c9eae239e6e1b8f4616845a561', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6389b3ad34d9c3ae3bff9cd5bb0062270f1157c9eae239e6e1b8f4616845a561')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '15 miembros: 10 permanentes y 5 no permanentes.', false), ('B', '15 miembros: 5 permanentes y 10 no permanentes.', true), ('C', '20 miembros: 5 permanentes y 15 no permanentes.', false), ('D', '54 miembros elegidos por la Asamblea General.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la web oficial de las Naciones Unidas, los miembros del Consejo Económico y Social:', 'La Asamblea General elige a los 54 miembros del ECOSOC para períodos superpuestos de tres años.', 'gc_06a_instituciones_internacionales', (select id from public.topics where slug = 'gc-06a-instituciones-internacionales'), 2, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/main-bodies'), 'ONU, Consejo Económico y Social', 'La Asamblea General elige a los 54 Miembros del Consejo para períodos superpuestos de tres años.', null, 'bdf34437f78c83c6090d6f681ba2e4a55a3ee6da30d55d6020c763bc9fcdf98e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'bdf34437f78c83c6090d6f681ba2e4a55a3ee6da30d55d6020c763bc9fcdf98e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Son 54, elegidos por el Consejo de Seguridad para períodos de cinco años.', false), ('B', 'Son 15, elegidos por la Asamblea General para períodos de dos años.', false), ('C', 'Son 54, elegidos por la Asamblea General para períodos superpuestos de tres años.', true), ('D', 'Son todos los Estados Miembros, que se reúnen cada año en septiembre.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de las Naciones Unidas, ¿cuál es el único de los seis órganos principales de la Organización que no se encuentra en Nueva York?', 'La Corte Internacional de Justicia, órgano judicial principal de la ONU, tiene su sede en el Palacio de la Paz de La Haya (Países Bajos) y es el único órgano principal que no está en Nueva York.', 'gc_06a_instituciones_internacionales', (select id from public.topics where slug = 'gc-06a-instituciones-internacionales'), 2, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/main-bodies'), 'ONU, Corte Internacional de Justicia', 'Su sede está en el Palacio de la Paz en la Haya (Países Bajos). Es el único de los seis órganos principales de la Organización que no se encuentra en Nueva York.', null, 'f1000e930ba81f77a98d0f20286f9bc3e7ed53a39096490f293d4e0f0bfcaf15', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f1000e930ba81f77a98d0f20286f9bc3e7ed53a39096490f293d4e0f0bfcaf15')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Corte Internacional de Justicia, con sede en el Palacio de la Paz de La Haya.', true), ('B', 'La Secretaría, con sede en Ginebra.', false), ('C', 'El Consejo Económico y Social, con sede en Viena.', false), ('D', 'El Consejo de Administración Fiduciaria, con sede en Ginebra.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de las Naciones Unidas, el Consejo de Administración Fiduciaria suspendió sus operaciones:', 'El Consejo supervisaba 11 Territorios fideicomisados administrados por 7 Estados Miembros; en 1994 todos habían alcanzado la autonomía o la independencia y suspendió sus operaciones el 1 de noviembre de ese año.', 'gc_06a_instituciones_internacionales', (select id from public.topics where slug = 'gc-06a-instituciones-internacionales'), 3, 'es', true, (select id from public.sources where url = 'https://www.un.org/es/about-us/main-bodies'), 'ONU, Consejo de Administración Fiduciaria', 'En 1994, todos los Territorios fideicometidos habían obtenido la autonomía y la independencia, por lo que el Consejo de Administración Fiduciaria suspendió sus operaciones el 1 de noviembre de ese año.', null, 'f6e609165cc05f971d088d1d0349838669b6eaf457a78b0d2d6cf024c20ec518', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f6e609165cc05f971d088d1d0349838669b6eaf457a78b0d2d6cf024c20ec518')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En 1945, el mismo año de su creación.', false), ('B', 'El 1 de noviembre de 1984, por decisión del Consejo de Seguridad.', false), ('C', 'El 1 de noviembre de 1994, cuando todos los Territorios fideicomisados habían obtenido la autonomía o la independencia.', true), ('D', 'En 2006, al ser sustituido por el Consejo de Derechos Humanos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-06a-instituciones-internacionales-oi_otan_tratado-v1 (6 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Tratado del Atlántico Norte (Washington, 4 de abril de 1949), Instrumento de Adhesión del Reino de España (BOE núm. 129, de 31 de mayo de 1982)', 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1982-12535', 'web_oficial'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-06a-instituciones-internacionales', 'Tema 6. Instituciones internacionales (I): ONU, Consejo de Europa, Unión Europea y OTAN') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-06a-instituciones-internacionales' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 5 del Tratado del Atlántico Norte, un ataque armado contra una o contra varias de las Partes, acaecido en Europa o en América del Norte:', 'El art. 5 consagra la defensa colectiva: cada Parte, en ejercicio de la legítima defensa reconocida por el art. 51 de la Carta de la ONU, asistirá a la atacada; las medidas se comunican de inmediato al Consejo de Seguridad. Las consultas son el contenido del art. 4.', 'gc_06a_instituciones_internacionales', (select id from public.topics where slug = 'gc-06a-instituciones-internacionales'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1982-12535'), 'Art. 5 Tratado del Atlántico Norte', 'Las Partes convienen en que un ataque armado contra una o contra varias de ellas, acaecido en Europa o en América del Norte, se considerará como un ataque dirigido contra todas ellas', null, '7ddbae1f389f73ceced0a360e48e06b2070e7f8c6b6f60d95648804ca29e7c3c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7ddbae1f389f73ceced0a360e48e06b2070e7f8c6b6f60d95648804ca29e7c3c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se considerará como un ataque dirigido contra todas ellas.', true), ('B', 'Solo obliga a las Partes a consultarse entre sí.', false), ('C', 'Debe someterse primero a la Asamblea General de las Naciones Unidas.', false), ('D', 'Solo obliga a asistir a la Parte atacada si lo autoriza el Consejo de Seguridad.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'El Tratado del Atlántico Norte fue hecho:', 'El Tratado se firmó en Washington el 4 de abril de 1949. Londres, 5 de mayo de 1949, es la fecha del Estatuto del Consejo de Europa, y París, 23 de octubre de 1954, la del Protocolo de adhesión de la RFA.', 'gc_06a_instituciones_internacionales', (select id from public.topics where slug = 'gc-06a-instituciones-internacionales'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1982-12535'), 'Tratado del Atlántico Norte, lugar y fecha', 'Hecho en Washington el 4 de abril de 1949.', null, '430e38cb84402c87b33d190717a3af043face0d609b27dfe15640aa4fb978369', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '430e38cb84402c87b33d190717a3af043face0d609b27dfe15640aa4fb978369')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En Londres, el 5 de mayo de 1949.', false), ('B', 'En Bruselas, el 4 de abril de 1949.', false), ('C', 'En París, el 23 de octubre de 1954.', false), ('D', 'En Washington, el 4 de abril de 1949.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 10 del Tratado del Atlántico Norte, la invitación a otro Estado europeo para adherirse al Tratado requiere:', 'El art. 10 exige acuerdo unánime y el depósito del instrumento de adhesión ante el Gobierno de los Estados Unidos, que informa a las demás Partes.', 'gc_06a_instituciones_internacionales', (select id from public.topics where slug = 'gc-06a-instituciones-internacionales'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1982-12535'), 'Art. 10 Tratado del Atlántico Norte', 'Las Partes pueden, por acuerdo unánime, invitar a adherirse al Tratado a cualquier otro Estado europeo […] Cualquier Estado así invitado puede pasar a ser parte en el Tratado depositando su instrumento de adhesión ante el Gobierno de los Estados Unidos de América.', null, '0be0e79046d58af2ba125368daa664044474165cc09cd10f6812e58f7c73c202', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0be0e79046d58af2ba125368daa664044474165cc09cd10f6812e58f7c73c202')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El acuerdo de la mayoría de dos tercios de las Partes, con depósito del instrumento ante el Secretario General de la OTAN.', false), ('B', 'El acuerdo unánime de las Partes, con depósito del instrumento ante el Secretario General de las Naciones Unidas.', false), ('C', 'El acuerdo unánime de las Partes, y el Estado invitado deposita su instrumento de adhesión ante el Gobierno de los Estados Unidos de América.', true), ('D', 'La decisión del Consejo del Atlántico Norte por mayoría cualificada, con depósito del instrumento ante el Gobierno del Reino Unido.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Instrumento de Adhesión publicado en el BOE, el Tratado del Atlántico Norte entró en vigor para España el día:', 'España depositó su Instrumento de Adhesión el 30 de mayo de 1982 (BOE de 31 de mayo de 1982) y el Tratado entró en vigor para ella ese día conforme al art. 10. El 24 de noviembre de 1977 es la fecha de ingreso de España en el Consejo de Europa.', 'gc_06a_instituciones_internacionales', (select id from public.topics where slug = 'gc-06a-instituciones-internacionales'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1982-12535'), 'Tratado del Atlántico Norte, entrada en vigor para España', 'El presente Tratado entró en vigor para España el día 30 de mayo de 1982, fecha del depósito del Instrumento de Adhesión, de conformidad con lo dispuesto en el artículo 10.', null, '6c2f87f734a8d346fde3fa602eb3a9cab9d5e511b8f4c9bf698a64e152afd38e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6c2f87f734a8d346fde3fa602eb3a9cab9d5e511b8f4c9bf698a64e152afd38e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '24 de noviembre de 1977, fecha del depósito del Instrumento de Adhesión.', false), ('B', '30 de mayo de 1982, fecha del depósito del Instrumento de Adhesión.', true), ('C', '1 de enero de 1986, fecha de la adhesión a las Comunidades Europeas.', false), ('D', '12 de marzo de 1986, fecha del referéndum.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 13 del Tratado del Atlántico Norte, una Parte puede poner fin al Tratado en lo que a ella concierna:', 'El art. 13 permite la denuncia tras veinte años de vigencia, con efecto un año después de la notificación al Gobierno de EE. UU. Los diez años son el plazo a partir del cual cabe pedir la revisión del Tratado (art. 12).', 'gc_06a_instituciones_internacionales', (select id from public.topics where slug = 'gc-06a-instituciones-internacionales'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1982-12535'), 'Art. 13 Tratado del Atlántico Norte', 'Pasados veinte años de vigencia del Tratado, cualquier Parte podrá, en lo que a ella concierna, poner fin al Tratado, un año después de haber notificado su denuncia al Gobierno de los Estados Unidos de América', null, 'b2abe79267c3c69ff868d4cec0c98a6426bd2cfad302386ffa3a763931468bf4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b2abe79267c3c69ff868d4cec0c98a6426bd2cfad302386ffa3a763931468bf4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Pasados veinte años de vigencia, un año después de haber notificado su denuncia al Gobierno de los Estados Unidos de América.', true), ('B', 'Pasados diez años de vigencia, seis meses después de notificar su denuncia al Secretario General de la OTAN.', false), ('C', 'En cualquier momento, con efectos inmediatos desde la notificación al Consejo del Atlántico Norte.', false), ('D', 'Pasados veinte años de vigencia, dos años después de notificar su denuncia al Gobierno del Reino Unido.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 9 del Tratado del Atlántico Norte, el Consejo que establecen las Partes debía crear inmediatamente:', 'El art. 9 crea un Consejo en el que todas las Partes están representadas, organizado para reunirse rápidamente en cualquier momento, y le encarga establecer de inmediato un comité de defensa para aplicar los arts. 3 (capacidad de resistencia) y 5 (defensa colectiva).', 'gc_06a_instituciones_internacionales', (select id from public.topics where slug = 'gc-06a-instituciones-internacionales'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1982-12535'), 'Art. 9 Tratado del Atlántico Norte', 'El Consejo establecerá cuantos órganos subsidiarios puedan ser necesarios; y en especial establecerá inmediatamente un comité de defensa que recomendará las medidas apropiadas para la aplicación de los artículos tercero y quinto.', null, '33b7b5c503c435fcd1ffceaf6ccf97ae7d9ff3cfb0dd585ade295afee7eb5c3f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '33b7b5c503c435fcd1ffceaf6ccf97ae7d9ff3cfb0dd585ade295afee7eb5c3f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una Asamblea Parlamentaria con representantes de los Parlamentos nacionales.', false), ('B', 'Un Tribunal encargado de resolver las controversias entre las Partes.', false), ('C', 'Una Secretaría General con sede en Bruselas.', false), ('D', 'Un comité de defensa que recomendara las medidas apropiadas para la aplicación de los artículos tercero y quinto.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-06b-agencias-internacionales-oi_cepol-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Unión Europea · CEPOL: formación policial', 'https://european-union.europa.eu/institutions-law-budget/institutions-and-bodies/search-all-eu-institutions-and-bodies/european-union-agency-law-enforcement-training-cepol_es', 'web_oficial'::public.source_kind, 'Unión Europea (portal oficial european-union.europa.eu)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-06b-agencias-internacionales', 'Tema 6. Instituciones internacionales (II): INTERPOL, EUROPOL, EUROJUST, FRONTEX, CEPOL, FAO, FMI y OMS') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-06b-agencias-internacionales' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el portal oficial de la Unión Europea, la CEPOL, Agencia de la Unión Europea para la Formación Policial, tiene su sede en:', 'CEPOL, creada en 2005, tiene su sede en Budapest; desarrolla, ejecuta y organiza cursos de formación para la policía y otros funcionarios de las fuerzas y cuerpos de seguridad.', 'gc_06b_agencias_internacionales', (select id from public.topics where slug = 'gc-06b-agencias-internacionales'), 1, 'es', true, (select id from public.sources where url = 'https://european-union.europa.eu/institutions-law-budget/institutions-and-bodies/search-all-eu-institutions-and-bodies/european-union-agency-law-enforcement-training-cepol_es'), 'CEPOL, sede', 'Sede: Budapest (Hungría)', null, '3e9dbe11573d521622395a506f0388ff829fada327450dd386268e2c78503ea2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3e9dbe11573d521622395a506f0388ff829fada327450dd386268e2c78503ea2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Varsovia (Polonia).', false), ('B', 'Lyon (Francia).', false), ('C', 'Bruselas (Bélgica).', false), ('D', 'Budapest (Hungría).', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-06b-agencias-internacionales-oi_eurojust-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Unión Europea · Agencia de la Unión Europea para la Cooperación Judicial Penal (Eurojust)', 'https://european-union.europa.eu/institutions-law-budget/institutions-and-bodies/search-all-eu-institutions-and-bodies/eurojust_es', 'web_oficial'::public.source_kind, 'Unión Europea (portal oficial european-union.europa.eu)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-06b-agencias-internacionales', 'Tema 6. Instituciones internacionales (II): INTERPOL, EUROPOL, EUROJUST, FRONTEX, CEPOL, FAO, FMI y OMS') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-06b-agencias-internacionales' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el portal oficial de la Unión Europea, Eurojust es:', 'Eurojust es la Agencia de la Unión Europea para la Cooperación Judicial Penal; Europol es la de cooperación policial, Frontex la de la Guardia de Fronteras y Costas y CEPOL la de formación policial.', 'gc_06b_agencias_internacionales', (select id from public.topics where slug = 'gc-06b-agencias-internacionales'), 1, 'es', true, (select id from public.sources where url = 'https://european-union.europa.eu/institutions-law-budget/institutions-and-bodies/search-all-eu-institutions-and-bodies/eurojust_es'), 'Eurojust, denominación', 'La Agencia de la Unión Europea para la Cooperación Judicial Penal (Eurojust) facilita la coordinación judicial y la cooperación entre las autoridades nacionales prestando apoyo práctico a los fiscales en la lucha contra la delincuencia transfronteriza grave y el terrorismo.', null, '0ecc7c0aa9f8892a6e66678cd2e4d0b7e0bdbe490a2944c29a5cf05c8f71c1fd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0ecc7c0aa9f8892a6e66678cd2e4d0b7e0bdbe490a2944c29a5cf05c8f71c1fd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Agencia de la Unión Europea para la Cooperación Judicial Penal.', true), ('B', 'La Agencia de la Unión Europea para la Cooperación Policial.', false), ('C', 'La Agencia Europea de la Guardia de Fronteras y Costas.', false), ('D', 'La Agencia de la Unión Europea para la Formación Policial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el portal oficial de la Unión Europea, los miembros de Eurojust forman:', 'Eurojust actúa a través del Colegio, integrado por un miembro nacional de cada país. La Red Judicial Europea es una red cuya secretaría alberga Eurojust.', 'gc_06b_agencias_internacionales', (select id from public.topics where slug = 'gc-06b-agencias-internacionales'), 2, 'es', true, (select id from public.sources where url = 'https://european-union.europa.eu/institutions-law-budget/institutions-and-bodies/search-all-eu-institutions-and-bodies/eurojust_es'), 'Eurojust, Colegio', 'Miembros: Colegio de Eurojust, con un miembro nacional de cada país', null, '9d90abb8c2d52e4ef49c9a6d15ceaa77eb5096a7979b96d4123907f89a49d82a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9d90abb8c2d52e4ef49c9a6d15ceaa77eb5096a7979b96d4123907f89a49d82a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Consejo de Administración de Eurojust, con dos representantes de cada país.', false), ('B', 'El Colegio de Eurojust, con un miembro nacional de cada país.', true), ('C', 'La Red Judicial Europea, con un fiscal de enlace por cada tercer país.', false), ('D', 'El Comité Ejecutivo de Eurojust, con trece miembros elegidos por los Estados.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el portal oficial de la Unión Europea, ¿de cuál de las siguientes redes alberga Eurojust la secretaría?', 'Eurojust alberga las secretarías de la Red Judicial Europea, de la Red de Expertos Nacionales de Equipos Conjuntos de Investigación (Red ECI) y de la Red Europea de Cooperación contra el Genocidio. Las Oficinas Centrales Nacionales son de INTERPOL.', 'gc_06b_agencias_internacionales', (select id from public.topics where slug = 'gc-06b-agencias-internacionales'), 3, 'es', true, (select id from public.sources where url = 'https://european-union.europa.eu/institutions-law-budget/institutions-and-bodies/search-all-eu-institutions-and-bodies/eurojust_es'), 'Eurojust, secretarías de redes', 'También alberga las secretarías de la Red Judicial Europea (RJE), la Red de Expertos Nacionales de Equipos Conjuntos de Investigación (Red ECI) y la Red de Investigación y Enjuiciamiento del Genocidio, los Crímenes contra la Humanidad y los Crímenes de Guerra (Red Europea de Cooperación contra el Genocidio).', null, 'd9a9b8b3d3e1674e14ff1499100107c31ace0a62e751510a704be7d86d745009', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd9a9b8b3d3e1674e14ff1499100107c31ace0a62e751510a704be7d86d745009')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Red Europea de Prevención de la Delincuencia.', false), ('B', 'La red de Oficinas Centrales Nacionales.', false), ('C', 'La red de agentes de enlace de inmigración.', false), ('D', 'La Red Judicial Europea (RJE).', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-06b-agencias-internacionales-oi_europol-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Unión Europea · Europol: cooperación policial', 'https://european-union.europa.eu/institutions-law-budget/institutions-and-bodies/search-all-eu-institutions-and-bodies/europol_es', 'web_oficial'::public.source_kind, 'Unión Europea (portal oficial european-union.europa.eu)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-06b-agencias-internacionales', 'Tema 6. Instituciones internacionales (II): INTERPOL, EUROPOL, EUROJUST, FRONTEX, CEPOL, FAO, FMI y OMS') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-06b-agencias-internacionales' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el portal oficial de la Unión Europea, la Agencia de la Unión Europea para la Cooperación Policial (Europol) tiene su sede en:', 'Europol tiene su sede en La Haya (Países Bajos), igual que Eurojust. Lyon es la sede de la Secretaría General de INTERPOL y Varsovia, la de Frontex.', 'gc_06b_agencias_internacionales', (select id from public.topics where slug = 'gc-06b-agencias-internacionales'), 1, 'es', true, (select id from public.sources where url = 'https://european-union.europa.eu/institutions-law-budget/institutions-and-bodies/search-all-eu-institutions-and-bodies/europol_es'), 'Europol, sede', 'Sede: La Haya (Países Bajos)', null, '4ca70e8323c4927bbda60f6484729071617921a50b1f3abb08121adcd9394fe7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4ca70e8323c4927bbda60f6484729071617921a50b1f3abb08121adcd9394fe7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Bruselas (Bélgica).', false), ('B', 'Lyon (Francia).', false), ('C', 'Varsovia (Polonia).', false), ('D', 'La Haya (Países Bajos).', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el portal oficial de la Unión Europea, ¿en qué año se creó Europol?', 'La ficha oficial de Europol indica 1999 como año de creación; 2002 corresponde a Eurojust, 2004 a Frontex y 2005 a CEPOL.', 'gc_06b_agencias_internacionales', (select id from public.topics where slug = 'gc-06b-agencias-internacionales'), 2, 'es', true, (select id from public.sources where url = 'https://european-union.europa.eu/institutions-law-budget/institutions-and-bodies/search-all-eu-institutions-and-bodies/europol_es'), 'Europol, año de creación', 'Año de creación: 1999', null, '8c7c85665d84ab5b412b7bc38afbbd454448a67284f8cff3da98f965c8e8c0d5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8c7c85665d84ab5b412b7bc38afbbd454448a67284f8cff3da98f965c8e8c0d5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En 1999.', true), ('B', 'En 2002.', false), ('C', 'En 2004.', false), ('D', 'En 2005.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el portal oficial de la Unión Europea, ¿cuál de los siguientes servicios ofrece Europol?', 'Europol ofrece apoyo sobre el terreno a las operaciones policiales, una central de intercambio de información sobre actividades delictivas y un centro de conocimientos especializados. La coordinación de acciones penales es propia de Eurojust, el cuerpo permanente de Frontex y los cursos residenciales de CEPOL.', 'gc_06b_agencias_internacionales', (select id from public.topics where slug = 'gc-06b-agencias-internacionales'), 2, 'es', true, (select id from public.sources where url = 'https://european-union.europa.eu/institutions-law-budget/institutions-and-bodies/search-all-eu-institutions-and-bodies/europol_es'), 'Europol, servicios', 'apoyo sobre el terreno a las operaciones de las fuerzas y cuerpos de seguridad central de intercambio de información sobre actividades delictivas centro de conocimientos especializados en materia de aplicación de la ley.', null, '0694ef8052d2510a06acf56bb9002e9b2f28c09dc7e8dbb53dc823134a415df1', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0694ef8052d2510a06acf56bb9002e9b2f28c09dc7e8dbb53dc823134a415df1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La coordinación de las acciones penales de los fiscales nacionales mediante equipos conjuntos de investigación financiados por ella.', false), ('B', 'Una central de intercambio de información sobre actividades delictivas.', true), ('C', 'La vigilancia de las fronteras exteriores con su propio cuerpo permanente uniformado.', false), ('D', 'La impartición de cursos residenciales a funcionarios de las fuerzas y cuerpos de seguridad.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-06b-agencias-internacionales-oi_fao-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('FAO · Acerca de la FAO', 'https://www.fao.org/about/about-fao/es/', 'web_oficial'::public.source_kind, 'Organización de las Naciones Unidas para la Alimentación y la Agricultura (FAO, web oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-06b-agencias-internacionales', 'Tema 6. Instituciones internacionales (II): INTERPOL, EUROPOL, EUROJUST, FRONTEX, CEPOL, FAO, FMI y OMS') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-06b-agencias-internacionales' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la FAO, ¿a qué ciudad decidieron los Estados Miembros trasladar las oficinas de la Organización, adonde se mudaron en 1951?', 'La FAO nació en Quebec (Canadá) con sede temporal en Washington D.C.; tras la Conferencia General de 1949 se decidió el traslado a Roma, realizado en 1951.', 'gc_06b_agencias_internacionales', (select id from public.topics where slug = 'gc-06b-agencias-internacionales'), 1, 'es', true, (select id from public.sources where url = 'https://www.fao.org/about/about-fao/es/'), 'FAO, sede y miembros', 'Tras el quinto período de sesiones de la Conferencia General llevada a cabo en 1949, en la cual los Estados Miembros decidieron trasladar las oficinas de la FAO a Roma', null, '8fbe6bb341fb0601f7fe2b9857c03f0f4715e87abae9500c147e8f59de741bde', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8fbe6bb341fb0601f7fe2b9857c03f0f4715e87abae9500c147e8f59de741bde')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Roma.', true), ('B', 'Ginebra.', false), ('C', 'Nueva York.', false), ('D', 'Quebec.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la FAO, el Día Mundial de la Alimentación se celebra anualmente el:', 'La 20.ª Conferencia de la FAO decidió por unanimidad celebrar el 16 de octubre el Día Mundial de la Alimentación, fecha de fundación de la Organización. El 20 de mayo es el Día Mundial de las Abejas.', 'gc_06b_agencias_internacionales', (select id from public.topics where slug = 'gc-06b-agencias-internacionales'), 2, 'es', true, (select id from public.sources where url = 'https://www.fao.org/about/about-fao/es/'), 'FAO, Día Mundial de la Alimentación', 'Durante la 20.a reunión de la Conferencia de la FAO se decidió en forma unánime celebrar anualmente el Día Mundial de la Alimentación el 16 de octubre en honor a la fecha de fundación de la FAO.', null, 'de89bc983df39e9d8bcb2d8e9cd637b27c04ecdcd81b620209e2c226c549a0ee', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'de89bc983df39e9d8bcb2d8e9cd637b27c04ecdcd81b620209e2c226c549a0ee')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '16 de octubre, en honor a la fecha de fundación de la FAO.', true), ('B', '7 de abril, en honor a la entrada en vigor de la Constitución de la FAO.', false), ('C', '20 de mayo, en honor a la fecha de fundación de la FAO.', false), ('D', '1 de febrero, en honor a la primera sesión de la Conferencia de la FAO.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-06b-agencias-internacionales-oi_fmi-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Fondo Monetario Internacional · ¿Qué es el FMI?', 'https://www.imf.org/es/about/factsheets/imf-at-a-glance', 'web_oficial'::public.source_kind, 'Fondo Monetario Internacional (FMI, web oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-06b-agencias-internacionales', 'Tema 6. Instituciones internacionales (II): INTERPOL, EUROPOL, EUROJUST, FRONTEX, CEPOL, FAO, FMI y OMS') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-06b-agencias-internacionales' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial del Fondo Monetario Internacional, la idea de crear el FMI se planteó:', 'El FMI se ideó en la conferencia de Bretton Woods (julio de 1944), donde 44 países acordaron un marco de cooperación económica para evitar las devaluaciones cambiarias que contribuyeron a la Gran Depresión.', 'gc_06b_agencias_internacionales', (select id from public.topics where slug = 'gc-06b-agencias-internacionales'), 2, 'es', true, (select id from public.sources where url = 'https://www.imf.org/es/about/factsheets/imf-at-a-glance'), 'FMI, fundación', 'La idea de crear el FMI se planteó en julio de 1944 en una conferencia de las Naciones Unidas celebrada en Bretton Woods, cuando los representantes de 44 países acordaron establecer un marco de cooperación económica internacional', null, 'a5a7b64188376e112fd3823ee22b2f7f438cb484fcd2539fe10fb3e3040c6943', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a5a7b64188376e112fd3823ee22b2f7f438cb484fcd2539fe10fb3e3040c6943')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En junio de 1945, en la Conferencia de San Francisco que aprobó la Carta de las Naciones Unidas.', false), ('B', 'En 1929, tras el inicio de la Gran Depresión, en una conferencia celebrada en Ginebra.', false), ('C', 'En julio de 1944, en una conferencia celebrada en Washington con representantes de 51 países.', false), ('D', 'En julio de 1944, en la conferencia de las Naciones Unidas celebrada en Bretton Woods, con representantes de 44 países.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial del Fondo Monetario Internacional, la instancia máxima en su estructura organizativa es:', 'La Junta de Gobernadores es la instancia máxima y se reúne una vez al año con ocasión de las Reuniones Anuales del FMI y el Banco Mundial; el Directorio Ejecutivo (25 miembros) supervisa las operaciones cotidianas y el CMFI (25 gobernadores) lo asesora.', 'gc_06b_agencias_internacionales', (select id from public.topics where slug = 'gc-06b-agencias-internacionales'), 3, 'es', true, (select id from public.sources where url = 'https://www.imf.org/es/about/factsheets/imf-at-a-glance'), 'FMI, órganos de gobierno', 'La instancia máxima en la estructura organizativa es la Junta de Gobernadores, que está integrada por un gobernador y un gobernador suplente por cada país miembro', null, '8669773ec3c23ec734a91178fde1a36a13a76cfd6c1f3f1c47ee7d11de160124', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8669773ec3c23ec734a91178fde1a36a13a76cfd6c1f3f1c47ee7d11de160124')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Directorio Ejecutivo, integrado por 25 miembros que representan a todos los países miembros.', false), ('B', 'El Comité Monetario y Financiero Internacional, integrado por 25 gobernadores.', false), ('C', 'La Junta de Gobernadores, integrada por un gobernador y un gobernador suplente por cada país miembro.', true), ('D', 'La Dirección Gerente, asistida por cuatro subdirectores gerentes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-06b-agencias-internacionales-oi_frontex-v1 (3 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Unión Europea · Agencia Europea de la Guardia de Fronteras y Costas (Frontex)', 'https://european-union.europa.eu/institutions-law-budget/institutions-and-bodies/search-all-eu-institutions-and-bodies/frontex_es', 'web_oficial'::public.source_kind, 'Unión Europea (portal oficial european-union.europa.eu)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-06b-agencias-internacionales', 'Tema 6. Instituciones internacionales (II): INTERPOL, EUROPOL, EUROJUST, FRONTEX, CEPOL, FAO, FMI y OMS') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-06b-agencias-internacionales' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el portal oficial de la Unión Europea, Frontex, la Agencia Europea de la Guardia de Fronteras y Costas, tiene su sede en:', 'Frontex, creada en 2004, tiene su sede en Varsovia. Budapest es la sede de CEPOL y La Haya la de Europol y Eurojust.', 'gc_06b_agencias_internacionales', (select id from public.topics where slug = 'gc-06b-agencias-internacionales'), 1, 'es', true, (select id from public.sources where url = 'https://european-union.europa.eu/institutions-law-budget/institutions-and-bodies/search-all-eu-institutions-and-bodies/frontex_es'), 'Frontex, sede', 'Sede: Varsovia (Polonia)', null, '969371963322507e3d30e097aa070e939bc78e001baa72e17b7f140d15d1504c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '969371963322507e3d30e097aa070e939bc78e001baa72e17b7f140d15d1504c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Budapest (Hungría).', false), ('B', 'La Haya (Países Bajos).', false), ('C', 'Varsovia (Polonia).', true), ('D', 'Lisboa (Portugal).', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el portal oficial de la Unión Europea, el cuerpo permanente de Frontex es:', 'Con el cuerpo permanente, primer servicio uniformado de fuerzas de seguridad de la UE, Frontex se ha convertido en un brazo operativo de la Unión.', 'gc_06b_agencias_internacionales', (select id from public.topics where slug = 'gc-06b-agencias-internacionales'), 2, 'es', true, (select id from public.sources where url = 'https://european-union.europa.eu/institutions-law-budget/institutions-and-bodies/search-all-eu-institutions-and-bodies/frontex_es'), 'Frontex, cuerpo permanente', 'Con el cuerpo permanente, el primer servicio uniformado de fuerzas de seguridad de la Unión Europea, Frontex se ha convertido en un brazo operativo de la UE.', null, '08cd44323ea8b19fef0eb95be670c737a6c68dfd6059e8c6bc42aa98f88b1876', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '08cd44323ea8b19fef0eb95be670c737a6c68dfd6059e8c6bc42aa98f88b1876')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una red de oficiales de enlace de los Estados miembros sin uniforme propio.', false), ('B', 'Una unidad militar dependiente de la Política Común de Seguridad y Defensa.', false), ('C', 'El primer servicio uniformado de fuerzas de seguridad de la Unión Europea.', true), ('D', 'La unidad de formación de guardias de fronteras de la CEPOL.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el portal oficial de la Unión Europea, el SEIAV, que Frontex está aplicando junto con otras instituciones de la UE y 30 países europeos, es:', 'El SEIAV es un sistema de autorización de viajes para nacionales exentos de visado que refuerza la seguridad interior de la UE garantizando el cruce fluido de las fronteras.', 'gc_06b_agencias_internacionales', (select id from public.topics where slug = 'gc-06b-agencias-internacionales'), 3, 'es', true, (select id from public.sources where url = 'https://european-union.europa.eu/institutions-law-budget/institutions-and-bodies/search-all-eu-institutions-and-bodies/frontex_es'), 'Frontex, SEIAV', 'Frontex, junto con otras instituciones de la UE y 30 países europeos, está aplicando el SEIAV, un sistema de autorización de viajes para los nacionales exentos de la obligación de visado', null, 'aacf6d588c311980feea94de53c3a08b860909fcd0def4970b85d399ae401ab9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'aacf6d588c311980feea94de53c3a08b860909fcd0def4970b85d399ae401ab9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un sistema de intercambio de antecedentes penales entre Estados miembros.', false), ('B', 'Un sistema de autorización de viajes para los nacionales exentos de la obligación de visado.', true), ('C', 'La base de datos de pasaportes robados gestionada por INTERPOL.', false), ('D', 'Un sistema de vigilancia aérea de las fronteras marítimas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-06b-agencias-internacionales-oi_interpol-v1 (5 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('INTERPOL · ¿Qué es INTERPOL? y Comité Ejecutivo', 'https://www.interpol.int/es/Quienes-somos/Que-es-INTERPOL', 'web_oficial'::public.source_kind, 'Organización Internacional de Policía Criminal (INTERPOL, web oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-06b-agencias-internacionales', 'Tema 6. Instituciones internacionales (II): INTERPOL, EUROPOL, EUROJUST, FRONTEX, CEPOL, FAO, FMI y OMS') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-06b-agencias-internacionales' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de INTERPOL, las oficinas centrales de la Secretaría General de la Organización se encuentran en:', 'La Secretaría General, dirigida por el Secretario General, está formada por las oficinas centrales en Lyon, un complejo mundial para la innovación en Singapur y varias oficinas satélites. La Haya es la sede de Europol y de Eurojust.', 'gc_06b_agencias_internacionales', (select id from public.topics where slug = 'gc-06b-agencias-internacionales'), 1, 'es', true, (select id from public.sources where url = 'https://www.interpol.int/es/Quienes-somos/Que-es-INTERPOL'), 'INTERPOL, Secretaría General', 'Está formada por las oficinas centrales en Lyon, un complejo mundial para la innovación en Singapur y varias oficinas satélites en distintas regiones.', null, '207f92b9324299f4216b05e62bf2473a72a6686e29dec31ddc12c9a44dc95e25', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '207f92b9324299f4216b05e62bf2473a72a6686e29dec31ddc12c9a44dc95e25')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Haya.', false), ('B', 'Ginebra.', false), ('C', 'Lyon.', true), ('D', 'Singapur.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de INTERPOL, ¿qué órgano actúa en cada país como punto de contacto para la Secretaría General y para las demás oficinas de los otros países?', 'En cada país una Oficina Central Nacional (OCN), dirigida por funcionarios de la policía nacional y normalmente integrada en el ministerio responsable de las actividades policiales, es el punto de contacto con la Secretaría General y las demás OCN.', 'gc_06b_agencias_internacionales', (select id from public.topics where slug = 'gc-06b-agencias-internacionales'), 2, 'es', true, (select id from public.sources where url = 'https://www.interpol.int/es/Quienes-somos/Que-es-INTERPOL'), 'INTERPOL, Oficinas Centrales Nacionales', 'En cada país, una Oficina Central Nacional (OCN) de INTERPOL actúa como punto de contacto para la Secretaría General y otras OCN.', null, 'f961674e5812ba440b80fc42e235f63b4ece99a77ed2dfc624c4aa14fa5bef49', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f961674e5812ba440b80fc42e235f63b4ece99a77ed2dfc624c4aa14fa5bef49')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Unidad Nacional de Europol.', false), ('B', 'La Embajada del país ante la sede de INTERPOL.', false), ('C', 'El Comité Ejecutivo de INTERPOL.', false), ('D', 'La Oficina Central Nacional (OCN) de INTERPOL.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de INTERPOL, el sistema de comunicación protegido que conecta a todos los países miembros entre sí y con la Secretaría General se denomina:', 'INTERPOL conecta a todos sus países miembros mediante el sistema I-24/7, que también permite acceder en tiempo real a sus bases de datos. SIENA es la red de intercambio de Europol; SIS II es el Sistema de Información de Schengen y el SEIAV, el sistema de autorización de viajes en cuya aplicación participa Frontex.', 'gc_06b_agencias_internacionales', (select id from public.topics where slug = 'gc-06b-agencias-internacionales'), 2, 'es', true, (select id from public.sources where url = 'https://www.interpol.int/es/Quienes-somos/Que-es-INTERPOL'), 'INTERPOL, sistema I-24/7', 'Conectamos a todos los países miembros a través de un sistema de comunicación denominado I-24/7.', null, 'd5b01313c3fa1ab589c23342b4b5f9bbc16fcc347d37dd97e73ce806264b5ba9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd5b01313c3fa1ab589c23342b4b5f9bbc16fcc347d37dd97e73ce806264b5ba9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'I-24/7.', true), ('B', 'SIS II.', false), ('C', 'SIENA.', false), ('D', 'SEIAV.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la web oficial de INTERPOL, el órgano de gobierno de la Organización, que reúne a todos los países una vez al año para tomar decisiones, es:', 'La Asamblea General es el órgano de gobierno y se reúne una vez al año; el Comité Ejecutivo (13 miembros) supervisa la ejecución de sus decisiones y la Secretaría General coordina las actividades diarias.', 'gc_06b_agencias_internacionales', (select id from public.topics where slug = 'gc-06b-agencias-internacionales'), 2, 'es', true, (select id from public.sources where url = 'https://www.interpol.int/es/Quienes-somos/Que-es-INTERPOL'), 'INTERPOL, Asamblea General', 'La Asamblea General es nuestro órgano de gobierno y reúne a todos los países una vez al año para tomar decisiones.', null, '788984f136ce92e22f0773ad5ff1f14b052da8d9a9ce076ca91df03a854d1222', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '788984f136ce92e22f0773ad5ff1f14b052da8d9a9ce076ca91df03a854d1222')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Comité Ejecutivo.', false), ('B', 'La Asamblea General.', true), ('C', 'La Secretaría General.', false), ('D', 'El Consejo de Oficinas Centrales Nacionales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de INTERPOL, el Comité Ejecutivo está formado por:', 'El Comité Ejecutivo, elegido por la Asamblea General, tiene 13 miembros (Presidente, tres vicepresidentes y nueve vocales); el Presidente se elige por cuatro años y los vicepresidentes por tres, y se reúne tres veces al año.', 'gc_06b_agencias_internacionales', (select id from public.topics where slug = 'gc-06b-agencias-internacionales'), 3, 'es', true, (select id from public.sources where url = 'https://www.interpol.int/es/Quienes-somos/Que-es-INTERPOL'), 'INTERPOL, Comité Ejecutivo', 'Elegido por la Asamblea General, el Comité Ejecutivo está formado por 13 miembros incluyendo el Presidente de la Organización, tres vicepresidentes y nueve vocales.', null, '6b5a14ce5ab639b0a11453bae68e84a833d97d9c860c5e0980b25f712dd4974e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6b5a14ce5ab639b0a11453bae68e84a833d97d9c860c5e0980b25f712dd4974e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '13 miembros: el Presidente de la Organización, dos vicepresidentes y diez vocales.', false), ('B', '15 miembros: el Secretario General, cuatro vicepresidentes y diez vocales.', false), ('C', '13 miembros: el Presidente de la Organización, tres vicepresidentes y nueve vocales.', true), ('D', '9 miembros: el Presidente de la Organización, tres vicepresidentes y cinco vocales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-06b-agencias-internacionales-oi_oms-v1 (1 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Organización Mundial de la Salud · Acerca de la OMS y su Constitución', 'https://www.who.int/es/about', 'web_oficial'::public.source_kind, 'Organización Mundial de la Salud (OMS, web oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-06b-agencias-internacionales', 'Tema 6. Instituciones internacionales (II): INTERPOL, EUROPOL, EUROJUST, FRONTEX, CEPOL, FAO, FMI y OMS') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-06b-agencias-internacionales' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la Organización Mundial de la Salud, su Constitución, tratado constitutivo de la Organización:', 'La Constitución de la OMS se adoptó en 1946 y está en vigor desde 1948, año de fundación de la OMS; afirma que la salud es un derecho humano fundamental. El órgano decisorio es la Asamblea Mundial de la Salud.', 'gc_06b_agencias_internacionales', (select id from public.topics where slug = 'gc-06b-agencias-internacionales'), 3, 'es', true, (select id from public.sources where url = 'https://www.who.int/es/about'), 'OMS, Constitución y Asamblea Mundial de la Salud', 'La Constitución de la OMS, que fue adoptada en 1946 y está en vigor desde 1948, es el tratado constitutivo de la Organización.', null, '4bf1987ba0c64d9c9dea4685e92beb2e2c1787b08ec49bd12202de2eaa75b479', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4bf1987ba0c64d9c9dea4685e92beb2e2c1787b08ec49bd12202de2eaa75b479')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Fue adoptada y entró en vigor en 1945, junto con la Carta de las Naciones Unidas.', false), ('B', 'Fue adoptada en 1946 y está en vigor desde 1948.', true), ('C', 'Fue adoptada en 1948 y está en vigor desde 1950.', false), ('D', 'Fue adoptada en 1944 en Bretton Woods y está en vigor desde 1946.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-14b-ministerio-defensa-rddef-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto 205/2024, de 27 de febrero, estructura orgánica básica del Ministerio de Defensa (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-14b-ministerio-defensa', 'Tema 14. Estructura orgánica básica del Ministerio de Defensa (RD 205/2024)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-14b-ministerio-defensa' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 1 del Real Decreto 205/2024, de estructura orgánica básica del Ministerio de Defensa, el Ministerio, bajo la dirección de la persona titular del Departamento, se estructura en:', 'El art. 1.3 RD 205/2024 estructura el Ministerio en las Fuerzas Armadas, la Secretaría de Estado de Defensa, la Subsecretaría de Defensa y la Secretaría General de Política de Defensa. El CNI está adscrito al Ministerio (art. 1.4) y la Guardia Civil depende de su titular en los términos legales (art. 1.5).', 'gc_14b_ministerio_defensa', (select id from public.topics where slug = 'gc-14b-ministerio-defensa'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791'), 'Art. 1.3 RD 205/2024', 'a) Las Fuerzas Armadas. b) La Secretaría de Estado de Defensa. c) La Subsecretaría de Defensa. d) La Secretaría General de Política de Defensa.', null, 'e00388f9c93d4242b1dca09831c8376d2805701c79f968d8024c93be9c8fa712', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e00388f9c93d4242b1dca09831c8376d2805701c79f968d8024c93be9c8fa712')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las Fuerzas Armadas, la Secretaría de Estado de Defensa, la Subsecretaría de Defensa y el Centro Nacional de Inteligencia.', false), ('B', 'La Secretaría de Estado de Defensa, la Subsecretaría de Defensa, la Secretaría General Técnica y la Dirección General de Personal.', false), ('C', 'Las Fuerzas Armadas, la Secretaría de Estado de Defensa, la Subsecretaría de Defensa y la Secretaría General de Política de Defensa.', true), ('D', 'El Estado Mayor de la Defensa, la Secretaría de Estado de Defensa, la Subsecretaría de Defensa y la Guardia Civil.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el Real Decreto 205/2024, el Centro Nacional de Inteligencia:', 'El art. 1.4 RD 205/2024 adscribe el Centro Nacional de Inteligencia al Ministerio de Defensa con dependencia directa de su titular.', 'gc_14b_ministerio_defensa', (select id from public.topics where slug = 'gc-14b-ministerio-defensa'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791'), 'Art. 1.4 RD 205/2024', 'Está adscrito al Ministerio de Defensa, con dependencia directa de la persona titular del Departamento, el Centro Nacional de Inteligencia.', null, '4512ad2df8f3f5748a50ed08d1b424020a1a603c6ce9c1cf31d27971df187bea', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4512ad2df8f3f5748a50ed08d1b424020a1a603c6ce9c1cf31d27971df187bea')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Está adscrito al Ministerio de Defensa, con dependencia directa de la persona titular del Departamento.', true), ('B', 'Depende de la Secretaría General de Política de Defensa.', false), ('C', 'Está adscrito al Ministerio del Interior, a través de la Secretaría de Estado de Seguridad.', false), ('D', 'Depende del Jefe de Estado Mayor de la Defensa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 2 del Real Decreto 205/2024, el Jefe de Estado Mayor de la Defensa (JEMAD) tiene rango de:', 'El JEMAD tiene rango de secretario de estado y ostenta la representación militar nacional ante las organizaciones internacionales de seguridad y defensa (art. 2.2); los Jefes de Estado Mayor de los Ejércitos y la Armada tienen rango de subsecretario (art. 2.5).', 'gc_14b_ministerio_defensa', (select id from public.topics where slug = 'gc-14b-ministerio-defensa'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791'), 'Art. 2.2 RD 205/2024', 'El Jefe de Estado Mayor de la Defensa (JEMAD), con rango de secretario de estado', null, '1432dc4762eae37a9a217c380f5ea1951fd8913c8af53632bc63fa6e0bb22dba', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1432dc4762eae37a9a217c380f5ea1951fd8913c8af53632bc63fa6e0bb22dba')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Subsecretario.', false), ('B', 'Secretario de estado.', true), ('C', 'Director general.', false), ('D', 'Ministro.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 205/2024, la Unidad Militar de Emergencias (UME) depende orgánicamente de:', 'La UME depende orgánicamente de la persona titular del Ministerio de Defensa y está constituida de forma permanente (art. 2.6); en la conducción de operaciones militares el JEMAD ejerce sobre ella las competencias de la LO 5/2005.', 'gc_14b_ministerio_defensa', (select id from public.topics where slug = 'gc-14b-ministerio-defensa'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791'), 'Art. 2.6 RD 205/2024', 'La Unidad Militar de Emergencias (UME), que depende orgánicamente de la persona titular del Ministerio de Defensa, está constituida de forma permanente', null, 'e2f3514ea9f8a4cfbd561ae5869b310532a37bdfde340561892ce882f231da3e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e2f3514ea9f8a4cfbd561ae5869b310532a37bdfde340561892ce882f231da3e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Dirección General de Protección Civil y Emergencias del Ministerio del Interior.', false), ('B', 'La Subsecretaría de Defensa.', false), ('C', 'La Secretaría General de Política de Defensa.', false), ('D', 'La persona titular del Ministerio de Defensa.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el orden de precedencia de las autoridades superiores del Ministerio de Defensa establecido en el Real Decreto 205/2024, inmediatamente después de la persona titular del Ministerio figura:', 'La disposición adicional primera ordena: Ministro/a, JEMAD, Secretaría de Estado de Defensa, Subsecretaría, Jefes de Estado Mayor del Ejército de Tierra, de la Armada y del Ejército del Aire y del Espacio y, por último, Secretaría General de Política de Defensa.', 'gc_14b_ministerio_defensa', (select id from public.topics where slug = 'gc-14b-ministerio-defensa'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791'), 'Disp. adic. 1.ª RD 205/2024', 'a) Persona titular del Ministerio de Defensa. b) Jefe de Estado Mayor de la Defensa. c) Persona titular de la Secretaría de Estado de Defensa.', null, 'e51ab103ed8e7dbc34500e9220d69f84b31515ff28a08d7df88f65cd3e35cf4d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e51ab103ed8e7dbc34500e9220d69f84b31515ff28a08d7df88f65cd3e35cf4d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La persona titular de la Secretaría de Estado de Defensa.', false), ('B', 'La persona titular de la Subsecretaría de Defensa.', false), ('C', 'La persona titular de la Secretaría General de Política de Defensa.', false), ('D', 'El Jefe de Estado Mayor de la Defensa.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 1 del Real Decreto 205/2024, la Guardia Civil depende de la persona titular del Ministerio de Defensa:', 'El art. 1.5 RD 205/2024 remite la dependencia de la Guardia Civil respecto del Ministerio de Defensa a lo previsto en la LO 2/1986, la LO 5/2005, la LO 12/2007 y la Ley 29/2014.', 'gc_14b_ministerio_defensa', (select id from public.topics where slug = 'gc-14b-ministerio-defensa'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791'), 'Art. 1.5 RD 205/2024', 'La Guardia Civil depende de la persona titular del Ministerio de Defensa en los términos previstos en la Ley Orgánica 2/1986, de 13 de marzo, de Fuerzas y Cuerpos de Seguridad; en la Ley Orgánica 5/2005, de 17 de noviembre, de la Defensa Nacional; en la Ley Orgánica 12/2007, de 22 de octubre, del régimen disciplinario de la Guardia Civil, y en la Ley 29/2014, de 28 de noviembre, de Régimen del Personal de la Guardia Civil.', null, '6e0230aacd06cc86617bf8b990809ff51dfc4c891636004c2cfc058e965552c7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6e0230aacd06cc86617bf8b990809ff51dfc4c891636004c2cfc058e965552c7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En todo caso y para todas sus funciones, de forma compartida con el Ministerio del Interior.', false), ('B', 'En los términos previstos en la LO 2/1986, de Fuerzas y Cuerpos de Seguridad; la LO 5/2005, de la Defensa Nacional; la LO 12/2007, del régimen disciplinario de la Guardia Civil, y la Ley 29/2014, de Régimen del Personal de la Guardia Civil.', true), ('C', 'Únicamente en tiempo de guerra y durante el estado de sitio.', false), ('D', 'A través de la Subsecretaría de Defensa, que ejerce su mando directo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el Real Decreto 205/2024, los Jefes de Estado Mayor del Ejército de Tierra, de la Armada y del Ejército del Aire y del Espacio tienen rango de:', 'El art. 2.5 RD 205/2024 atribuye rango de subsecretario a los tres Jefes de Estado Mayor; el JEMAD tiene rango de secretario de estado (art. 2.2).', 'gc_14b_ministerio_defensa', (select id from public.topics where slug = 'gc-14b-ministerio-defensa'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791'), 'Art. 2.5 RD 205/2024', 'Los Jefes de Estado Mayor del Ejército de Tierra, de la Armada y del Ejército del Aire y del Espacio tienen rango de subsecretario.', null, 'c650e136e376ee1a36983abb74e7b5d4272df3a42715c583fe396b3d06434cb7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c650e136e376ee1a36983abb74e7b5d4272df3a42715c583fe396b3d06434cb7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Secretario de estado.', false), ('B', 'Director general.', false), ('C', 'Subsecretario.', true), ('D', 'Subdirector general.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 3 del Real Decreto 205/2024, ¿cuál de los siguientes órganos directivos depende de la Secretaría de Estado de Defensa?', 'De la Secretaría de Estado de Defensa dependen las Direcciones Generales de Estrategia e Innovación de la Industria de Defensa, de Armamento y Material, de Asuntos Económicos y de Infraestructura, y el CESTIC. La Secretaría General Técnica y la DG de Personal dependen de la Subsecretaría; la DG de Política de Defensa, de la Secretaría General de Política de Defensa.', 'gc_14b_ministerio_defensa', (select id from public.topics where slug = 'gc-14b-ministerio-defensa'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791'), 'Art. 3.3 RD 205/2024', 'a) La Dirección General de Estrategia e Innovación de la Industria de Defensa. b) La Dirección General de Armamento y Material. c) La Dirección General de Asuntos Económicos. d) La Dirección General de Infraestructura. e) El Centro de Sistemas y Tecnologías de la Información y las Comunicaciones.', null, '2312df20d84a54aea51c7a0093ca4d319f6c80598ff52bcec20ea2e58f69954c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2312df20d84a54aea51c7a0093ca4d319f6c80598ff52bcec20ea2e58f69954c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Dirección General de Asuntos Económicos.', true), ('B', 'La Dirección General de Personal.', false), ('C', 'La Secretaría General Técnica.', false), ('D', 'La Dirección General de Política de Defensa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 205/2024, ¿qué órgano asume las funciones de Oficial Jefe de la Información (CIO) del Ministerio de Defensa?', 'El art. 7.1 RD 205/2024 atribuye al CESTIC las políticas CIS/TIC, transformación digital y seguridad de la información, y dispone que su Director asume las funciones de CIO del Ministerio.', 'gc_14b_ministerio_defensa', (select id from public.topics where slug = 'gc-14b-ministerio-defensa'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791'), 'Art. 7.1 RD 205/2024', 'Su Director asume las funciones de Oficial Jefe de la Información (CIO) del Ministerio de Defensa.', null, '3ebc494c3953bd058f91fbeda6af8daafa9194d9b99d75f9926e7015c0ef88a0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3ebc494c3953bd058f91fbeda6af8daafa9194d9b99d75f9926e7015c0ef88a0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La persona titular de la Secretaría General Técnica.', false), ('B', 'El Director del Centro de Sistemas y Tecnologías de la Información y las Comunicaciones (CESTIC).', true), ('C', 'El Jefe de Estado Mayor de la Defensa.', false), ('D', 'La persona titular de la Dirección General de Estrategia e Innovación de la Industria de Defensa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 8 del Real Decreto 205/2024, ¿qué órganos directivos con rango de dirección general dependen de la Subsecretaría de Defensa?', 'El art. 8.5 RD 205/2024 sitúa bajo la Subsecretaría la Secretaría General Técnica y las Direcciones Generales de Personal y de Reclutamiento y Enseñanza Militar.', 'gc_14b_ministerio_defensa', (select id from public.topics where slug = 'gc-14b-ministerio-defensa'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791'), 'Art. 8.5 RD 205/2024', 'a) La Secretaría General Técnica. b) La Dirección General de Personal. c) La Dirección General de Reclutamiento y Enseñanza Militar.', null, '1f4426db3d77be87b1dd66a3b2cf6de1794860dcfcde94412ee7406017f2e6dd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1f4426db3d77be87b1dd66a3b2cf6de1794860dcfcde94412ee7406017f2e6dd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Secretaría General Técnica, la Dirección General de Personal y la Dirección General de Infraestructura.', false), ('B', 'La Dirección General de Personal, la Dirección General de Asuntos Económicos y la Dirección General de Política de Defensa.', false), ('C', 'La Dirección General de Reclutamiento y Enseñanza Militar, la Dirección General de Armamento y Material y el CESTIC.', false), ('D', 'La Secretaría General Técnica, la Dirección General de Personal y la Dirección General de Reclutamiento y Enseñanza Militar.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 205/2024, el organismo autónomo Instituto Social de las Fuerzas Armadas está adscrito a:', 'El art. 8.8 RD 205/2024 adscribe a la Subsecretaría el ISFAS, el Consejo de Personal de las Fuerzas Armadas, el Observatorio militar para la igualdad, el Consejo Superior del Deporte Militar y, administrativamente, el Arzobispado General Castrense.', 'gc_14b_ministerio_defensa', (select id from public.topics where slug = 'gc-14b-ministerio-defensa'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791'), 'Art. 8.8.a) RD 205/2024', 'Están adscritos a la Subsecretaría de Defensa: a) El organismo autónomo Instituto Social de las Fuerzas Armadas.', null, 'ffc5a9f3fac815cc9fe4bf26e88892e38e7a15bb35a4cbe6ea21ea5347277a66', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ffc5a9f3fac815cc9fe4bf26e88892e38e7a15bb35a4cbe6ea21ea5347277a66')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Secretaría de Estado de Defensa.', false), ('B', 'La Dirección General de Personal.', false), ('C', 'La Subsecretaría de Defensa.', true), ('D', 'La Secretaría General de Política de Defensa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 8 del Real Decreto 205/2024, la representación ordinaria del Ministerio de Defensa corresponde a:', 'El art. 8.3 RD 205/2024 atribuye a la persona titular de la Subsecretaría la representación ordinaria del Departamento; la Secretaría de Estado, el JEMAD y la Secretaría General de Política de Defensa solo la ostentan por delegación cuando se les encomiende.', 'gc_14b_ministerio_defensa', (select id from public.topics where slug = 'gc-14b-ministerio-defensa'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791'), 'Art. 8.3 RD 205/2024', 'La persona titular de la Subsecretaría de Defensa ostentará la representación ordinaria del Departamento', null, '55c603c30fe8a06878011e7a36e5595c5ef40a2537dc348a99e670f62c191f4e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '55c603c30fe8a06878011e7a36e5595c5ef40a2537dc348a99e670f62c191f4e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La persona titular de la Subsecretaría de Defensa.', true), ('B', 'La persona titular de la Secretaría de Estado de Defensa.', false), ('C', 'El Jefe de Estado Mayor de la Defensa.', false), ('D', 'La persona titular de la Secretaría General Técnica.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el Real Decreto 205/2024, la Intervención General de la Defensa depende funcionalmente de:', 'La Intervención General de la Defensa depende orgánicamente de la Subsecretaría (art. 8.7) y funcionalmente de la IGAE; ejerce el control interno de la gestión económico-financiera y la notaría militar (art. 13.1).', 'gc_14b_ministerio_defensa', (select id from public.topics where slug = 'gc-14b-ministerio-defensa'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791'), 'Art. 13.1 RD 205/2024', 'La Intervención General de la Defensa, dependiente funcionalmente de la Intervención General de la Administración del Estado', null, 'd05b62075257826a8546614fb1d73a7c2505d6d914bc5732f2685b3daa17691b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd05b62075257826a8546614fb1d73a7c2505d6d914bc5732f2685b3daa17691b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Intervención General de la Administración del Estado.', true), ('B', 'La Dirección General de Asuntos Económicos.', false), ('C', 'El Tribunal de Cuentas.', false), ('D', 'La Secretaría de Estado de Defensa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 15 del Real Decreto 205/2024, las agregadurías de defensa en las misiones diplomáticas de España en el exterior dependen de:', 'Dependen de la Secretaría General de Política de Defensa las agregadurías de defensa y los consejeros de defensa en las representaciones permanentes ante organizaciones internacionales (art. 15.9); del JEMAD dependen, en cambio, las representaciones militares en los organismos internacionales (art. 2.4).', 'gc_14b_ministerio_defensa', (select id from public.topics where slug = 'gc-14b-ministerio-defensa'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791'), 'Art. 15.9 RD 205/2024', 'Dependen de la Secretaría General de Política de Defensa las agregadurías de defensa en las misiones diplomáticas de España en el exterior', null, 'd35bba88a42a33335c3f69330871a8de0d55b4d5863013b530d23e94f8cb8640', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd35bba88a42a33335c3f69330871a8de0d55b4d5863013b530d23e94f8cb8640')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Jefe de Estado Mayor de la Defensa.', false), ('B', 'La Secretaría General de Política de Defensa.', true), ('C', 'La Subsecretaría de Defensa.', false), ('D', 'El Ministerio de Asuntos Exteriores, Unión Europea y Cooperación.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 205/2024, el Consejo Superior del Ejército de Tierra, el Consejo Superior de la Armada y el Consejo Superior del Ejército del Aire y del Espacio son:', 'El art. 17 RD 205/2024 los configura como órganos colegiados asesores y consultivos del Ministro/a y del JEM respectivo; las Juntas Superiores de los cuerpos comunes asesoran al Ministro/a y a la Subsecretaría (art. 18).', 'gc_14b_ministerio_defensa', (select id from public.topics where slug = 'gc-14b-ministerio-defensa'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791'), 'Art. 17 RD 205/2024', 'son los órganos colegiados asesores y consultivos de la persona titular del Ministerio de Defensa y del Jefe de Estado Mayor del ejército respectivo', null, '293f8e25bcd1a9c864abddac58048838807c41ee2cc21ee14932529bc753a786', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '293f8e25bcd1a9c864abddac58048838807c41ee2cc21ee14932529bc753a786')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Órganos directivos con rango de dirección general dependientes del Jefe de Estado Mayor de la Defensa.', false), ('B', 'Órganos colegiados asesores y consultivos de la persona titular de la Subsecretaría de Defensa.', false), ('C', 'Órganos de gobierno de la jurisdicción militar.', false), ('D', 'Órganos colegiados asesores y consultivos de la persona titular del Ministerio de Defensa y del Jefe de Estado Mayor del ejército respectivo.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 3 del Real Decreto 205/2024, ¿a qué órgano está adscrito el organismo autónomo Instituto Nacional de Técnica Aeroespacial «Esteban Terradas»?', 'El art. 3.6 RD 205/2024 adscribe a la Secretaría de Estado de Defensa el INTA, el Instituto de Vivienda, Infraestructura y Equipamiento de la Defensa y la Agencia Espacial Española.', 'gc_14b_ministerio_defensa', (select id from public.topics where slug = 'gc-14b-ministerio-defensa'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791'), 'Art. 3.6 RD 205/2024', 'Están adscritos a la Secretaría de Estado de Defensa el organismo autónomo Instituto Nacional de Técnica Aeroespacial «Esteban Terradas»', null, '9712fea85ecf900ffbb29314fa52d09416508bac70a7095a34c5e00fd6272517', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9712fea85ecf900ffbb29314fa52d09416508bac70a7095a34c5e00fd6272517')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A la Subsecretaría de Defensa.', false), ('B', 'Al Centro de Sistemas y Tecnologías de la Información y las Comunicaciones.', false), ('C', 'A la Secretaría de Estado de Defensa.', true), ('D', 'A la Dirección General de Reclutamiento y Enseñanza Militar.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 205/2024, las delegaciones de defensa en las comunidades autónomas y en las ciudades de Ceuta y Melilla dependen orgánicamente de:', 'El art. 8.9 RD 205/2024 hace depender orgánicamente de la Subsecretaría las delegaciones de defensa en las comunidades autónomas y en Ceuta y Melilla.', 'gc_14b_ministerio_defensa', (select id from public.topics where slug = 'gc-14b-ministerio-defensa'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791'), 'Art. 8.9 RD 205/2024', 'Las delegaciones de defensa en las comunidades autónomas y en las ciudades de Ceuta y Melilla dependen orgánicamente de la Subsecretaría del Departamento.', null, '4ccf792c795c17543648eac9b14870585b20c13e71aa7c80e0f592f2849c87d7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4ccf792c795c17543648eac9b14870585b20c13e71aa7c80e0f592f2849c87d7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Secretaría General de Política de Defensa.', false), ('B', 'La Subsecretaría del Departamento.', true), ('C', 'Las Delegaciones del Gobierno correspondientes.', false), ('D', 'La Secretaría General Técnica.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 12 del Real Decreto 205/2024, el cargo de Asesor Jurídico General de la Defensa es desempeñado por:', 'El Asesor Jurídico General es un general consejero togado en servicio activo (art. 12.5); el Interventor General de la Defensa, un general de división interventor (art. 13.3), y el Inspector General de Sanidad, un general de división del Cuerpo Militar de Sanidad (art. 14.3).', 'gc_14b_ministerio_defensa', (select id from public.topics where slug = 'gc-14b-ministerio-defensa'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791'), 'Art. 12.5 RD 205/2024', 'El cargo de Asesor Jurídico General es desempeñado por un general consejero togado, en situación de servicio activo', null, 'c200f89ae4082410520c73441c2a91869c29832f4b147838eda3a0fae61f9bb3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c200f89ae4082410520c73441c2a91869c29832f4b147838eda3a0fae61f9bb3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un general consejero togado, en situación de servicio activo.', true), ('B', 'Un general de división interventor, en situación de servicio activo.', false), ('C', 'Un Abogado del Estado designado por la Abogacía General del Estado.', false), ('D', 'Un general de división del Cuerpo Jurídico Militar, en situación de reserva.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el Real Decreto 205/2024, ¿a quién corresponde actuar como Secretario del Consejo de Defensa Nacional?', 'El art. 15.4 RD 205/2024 atribuye a la persona titular de la Secretaría General de Política de Defensa presidir la Comisión Interministerial de Defensa, actuar de Secretario del Consejo de Defensa Nacional y presidir la Comisión de Coordinación de la Actividad Internacional del Ministerio.', 'gc_14b_ministerio_defensa', (select id from public.topics where slug = 'gc-14b-ministerio-defensa'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791'), 'Art. 15.4.b) RD 205/2024', 'b) Actuar de Secretario del Consejo de Defensa Nacional.', null, '8707ee0a384c03a9e01e29488e1ab84006ab8ab74b88cfb30d06648b2a5829ea', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8707ee0a384c03a9e01e29488e1ab84006ab8ab74b88cfb30d06648b2a5829ea')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A la persona titular de la Subsecretaría de Defensa.', false), ('B', 'Al Jefe de Estado Mayor de la Defensa.', false), ('C', 'A la persona titular de la Secretaría General Técnica.', false), ('D', 'A la persona titular de la Secretaría General de Política de Defensa.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 205/2024, el Establecimiento Penitenciario Militar de Alcalá de Henares:', 'La disposición adicional cuarta mantiene su adscripción a la Subsecretaría con dependencia orgánica de la Secretaría General Técnica, cuyas funciones desarrolla la Subdirección General de Administración Periférica.', 'gc_14b_ministerio_defensa', (select id from public.topics where slug = 'gc-14b-ministerio-defensa'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791'), 'Disp. adic. 4.ª RD 205/2024', 'El Establecimiento Penitenciario Militar de Alcalá de Henares seguirá adscrito a la Subsecretaría de Defensa, con dependencia orgánica de la Secretaría General Técnica', null, '53ad49ae5fb3372a4d5caa55007564a96e37ddd5275a258d514ed9551b1d893e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '53ad49ae5fb3372a4d5caa55007564a96e37ddd5275a258d514ed9551b1d893e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Está adscrito a la Secretaría General de Instituciones Penitenciarias del Ministerio del Interior.', false), ('B', 'Depende orgánicamente de la Asesoría Jurídica General de la Defensa.', false), ('C', 'Sigue adscrito a la Subsecretaría de Defensa, con dependencia orgánica de la Secretaría General Técnica.', true), ('D', 'Depende orgánicamente del Jefe de Estado Mayor del Ejército de Tierra.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-15c-servicios-centrales-dggc-oscgc-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Orden PRE/422/2013, de 15 de marzo, estructura orgánica de los Servicios Centrales de la Dirección General de la Guardia Civil (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-15c-servicios-centrales-dggc', 'Tema 15. Estructura de los Servicios Centrales de la Dirección General de la Guardia Civil') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-15c-servicios-centrales-dggc' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Orden PRE/422/2013, por la que se desarrolla la estructura orgánica de los Servicios Centrales de la Dirección General de la Guardia Civil, la organización periférica de la Dirección General estará constituida por:', 'El art. 1.2 Orden PRE/422/2013 fija la organización periférica en Zonas, Comandancias, Compañías y Puestos; lo mismo establece hoy el art. 4.11 del RD 207/2024, de estructura orgánica básica del Ministerio del Interior.', 'gc_15c_servicios_centrales_dggc', (select id from public.topics where slug = 'gc-15c-servicios-centrales-dggc'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906'), 'Art. 1.2 Orden PRE/422/2013', 'La organización periférica de la Dirección General de la Guardia Civil estará constituida por las Zonas, las Comandancias, las Compañías y los Puestos.', null, '972318b1c67960208c52a017c65160f3a0f965101b4aaa36a1c93a7e3e83f882', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '972318b1c67960208c52a017c65160f3a0f965101b4aaa36a1c93a7e3e83f882')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las Regiones, las Zonas, las Comandancias y los Puestos.', false), ('B', 'Las Zonas, las Comandancias, las Compañías y las Secciones.', false), ('C', 'Las Delegaciones, las Comandancias, las Compañías y los Puestos.', false), ('D', 'Las Zonas, las Comandancias, las Compañías y los Puestos.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la Orden PRE/422/2013, ¿qué órganos colegiados están adscritos a la Dirección General de la Guardia Civil?', 'El art. 2 Orden PRE/422/2013 adscribe a la Dirección General el Consejo Superior de la Guardia Civil y el Consejo de la Guardia Civil, adscripción que mantiene el art. 4.2 del RD 207/2024.', 'gc_15c_servicios_centrales_dggc', (select id from public.topics where slug = 'gc-15c-servicios-centrales-dggc'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906'), 'Art. 2 Orden PRE/422/2013', 'Adscritos a la Dirección General de la Guardia Civil estarán el Consejo Superior de la Guardia Civil y el Consejo de la Guardia Civil', null, 'b3debc89ee3e11e5cdc8fcb60b18e958f497f5cb638655a45b0c49b80d6ab156', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b3debc89ee3e11e5cdc8fcb60b18e958f497f5cb638655a45b0c49b80d6ab156')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Consejo Superior de la Guardia Civil y el Consejo de Policía.', false), ('B', 'El Consejo Superior de la Guardia Civil y el Consejo de la Guardia Civil.', true), ('C', 'El Consejo de la Guardia Civil y el Consejo de Personal de las Fuerzas Armadas.', false), ('D', 'El Consejo Superior de la Guardia Civil y la Junta de Jefes de Estado Mayor.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Orden PRE/422/2013, la titularidad del Centro Universitario de la Guardia Civil corresponde:', 'El art. 4 Orden PRE/422/2013 configura el Centro Universitario de la Guardia Civil como centro universitario público dependiente de la Dirección General, cuya titularidad corresponde al Ministro del Interior.', 'gc_15c_servicios_centrales_dggc', (select id from public.topics where slug = 'gc-15c-servicios-centrales-dggc'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906'), 'Art. 4 Orden PRE/422/2013', 'con naturaleza de centro universitario público, cuya titularidad corresponde al Ministro del Interior', null, '7ff778d8cb778c179fe84b785d0bcc0429ac1488779e00e604912a3d25a3654a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7ff778d8cb778c179fe84b785d0bcc0429ac1488779e00e604912a3d25a3654a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Ministro del Interior.', true), ('B', 'Al Ministro de Defensa.', false), ('C', 'Al Ministro de Universidades.', false), ('D', 'Al Director General de la Guardia Civil.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Orden PRE/422/2013, ¿qué órgano sustituye al Director General de la Guardia Civil con carácter interino o accidental?', 'Corresponde a la Dirección Adjunta Operativa sustituir al Director General con carácter interino o accidental, también en el ejercicio de la potestad sancionadora disciplinaria (art. 5.1.e); así lo recoge también el art. 4.5.f) del RD 207/2024.', 'gc_15c_servicios_centrales_dggc', (select id from public.topics where slug = 'gc-15c-servicios-centrales-dggc'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906'), 'Art. 5.1.e) Orden PRE/422/2013', 'e) Sustituir al Director General de la Guardia Civil, con carácter interino o accidental, así como en el ejercicio de la potestad sancionadora', null, '4f1aedb255f8b7f44c03601e4a8b01693b472736df1b62d4beed587f8450f9de', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4f1aedb255f8b7f44c03601e4a8b01693b472736df1b62d4beed587f8450f9de')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Mando de Operaciones.', false), ('B', 'El Gabinete Técnico.', false), ('C', 'La Dirección Adjunta Operativa.', true), ('D', 'La Subdirección General de Personal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Orden PRE/422/2013, el órgano especializado de la Guardia Civil para la dirección técnica y ejecución de los servicios en los que participen Unidades dotadas de perros es:', 'El art. 8.2.d) Orden PRE/422/2013 atribuye al Servicio Cinológico y Remonta la dirección técnica de los servicios con perros, la evaluación de las unidades cinológicas y la gestión del ganado y animales útiles para el servicio.', 'gc_15c_servicios_centrales_dggc', (select id from public.topics where slug = 'gc-15c-servicios-centrales-dggc'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906'), 'Art. 8.2.d) Orden PRE/422/2013', 'd) Servicio Cinológico y Remonta. Órgano especializado de la Guardia Civil para la dirección técnica y ejecución de los servicios en los que participen Unidades dotadas de perros', null, '6240964837836977f9f5f6451be06b1076c8d2296a256d598c2e87187ab7f393', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6240964837836977f9f5f6451be06b1076c8d2296a256d598c2e87187ab7f393')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Servicio de Protección de la Naturaleza.', false), ('B', 'La Agrupación de Reserva y Seguridad.', false), ('C', 'El Servicio Cinológico y Remonta.', true), ('D', 'El Servicio de Montaña.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la Orden PRE/422/2013, el Servicio de Asuntos Internos tiene como misión:', 'El Servicio de Asuntos Internos investiga las conductas contrarias a la ética profesional (art. 17); la tramitación disciplinaria corresponde al Servicio de Régimen Disciplinario (art. 20.2.c), el seguimiento del Código de Conducta al Observatorio de Conducta Ética (art. 23 bis) y las operaciones peligrosas a la Unidad Especial de Intervención (art. 18).', 'gc_15c_servicios_centrales_dggc', (select id from public.topics where slug = 'gc-15c-servicios-centrales-dggc'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906'), 'Art. 17.1 Orden PRE/422/2013', 'El Servicio de Asuntos Internos tiene como misión investigar las conductas contrarias a la ética profesional del personal destinado en la Dirección General de la Guardia Civil', null, '86e442f38ddbae4558fc06121533eed980ec5546c5db2ef0acf208a1199b94bf', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '86e442f38ddbae4558fc06121533eed980ec5546c5db2ef0acf208a1199b94bf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tramitar, informar y proponer los asuntos relativos al régimen disciplinario de la Guardia Civil.', false), ('B', 'Centralizar el seguimiento y evaluación de la aplicación del Código de Conducta en la Guardia Civil.', false), ('C', 'Ejecutar las operaciones que por su peligrosidad o especiales características se le encomienden.', false), ('D', 'Investigar las conductas contrarias a la ética profesional del personal destinado en la Dirección General de la Guardia Civil.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Orden PRE/422/2013, el Gabinete Técnico de la Dirección General de la Guardia Civil:', 'El art. 3.2 Orden PRE/422/2013 configura el Gabinete Técnico, dependiente directamente del Director General, con nivel de Subdirección General y a cargo de un Oficial General; el art. 4.4 del RD 207/2024 mantiene ese nivel y esa jefatura.', 'gc_15c_servicios_centrales_dggc', (select id from public.topics where slug = 'gc-15c-servicios-centrales-dggc'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906'), 'Art. 3.2 Orden PRE/422/2013', 'Gabinete Técnico. Con nivel orgánico de Subdirección General, y a cargo de un Oficial General de la Guardia Civil, es el órgano de asistencia y apoyo del Director General', null, '5acc7c8715957a2ec1089fdb6f87e7fe9fad0340aa2ea197179b4df8ca406de4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5acc7c8715957a2ec1089fdb6f87e7fe9fad0340aa2ea197179b4df8ca406de4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tiene nivel orgánico de Dirección General y está a cargo de un Teniente General de la Guardia Civil.', false), ('B', 'Tiene nivel orgánico de Subdirección General y está a cargo de un Oficial General de la Guardia Civil.', true), ('C', 'Tiene nivel orgánico de Subdirección General y está a cargo de un funcionario civil del subgrupo A1.', false), ('D', 'Depende de la Dirección Adjunta Operativa y está a cargo de un Coronel de la Guardia Civil.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Orden PRE/422/2013, ¿de quién dependen la Unidad de Escolta del Director General y el Registro Central?', 'La Secretaría de Despacho es el órgano de asistencia y apoyo personal e inmediato al Director General; de su Jefe dependen la Unidad de Escolta del Director General y el Registro Central de la correspondencia oficial (art. 3.4).', 'gc_15c_servicios_centrales_dggc', (select id from public.topics where slug = 'gc-15c-servicios-centrales-dggc'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906'), 'Art. 3.4 Orden PRE/422/2013', 'Del Jefe de la Secretaría de Despacho dependen también la Unidad de Escolta del Director General y el Registro Central', null, '6b9e0127c21ccf67f2e32604af267226e44edd8ebd3cac214e6739894a668156', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6b9e0127c21ccf67f2e32604af267226e44edd8ebd3cac214e6739894a668156')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Del Jefe de la Secretaría de Despacho.', true), ('B', 'Del Jefe del Gabinete Técnico.', false), ('C', 'Del Jefe de la Jefatura de Unidades Especiales y de Reserva.', false), ('D', 'Del Jefe del Servicio de Protección y Seguridad.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la Orden PRE/422/2013, cuando las necesidades del servicio así lo aconsejen, la Sala de Operaciones y Servicios se activará como:', 'La Sala de Operaciones y Servicios depende orgánicamente del Jefe del Estado Mayor, recibe y transmite las novedades y órdenes del servicio diario y se activa como Centro de Crisis cuando es necesario (art. 7.2).', 'gc_15c_servicios_centrales_dggc', (select id from public.topics where slug = 'gc-15c-servicios-centrales-dggc'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906'), 'Art. 7.2 Orden PRE/422/2013', 'Cuando las necesidades del mismo así lo aconsejen, se activará como Centro de Crisis', null, '85c2b55352545e7f88b565762489a1d694d9585f28502d630e2b96c14851fa43', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '85c2b55352545e7f88b565762489a1d694d9585f28502d630e2b96c14851fa43')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Centro de Crisis.', true), ('B', 'Centro de Coordinación de vigilancia marítima de costas y fronteras.', false), ('C', 'Centro de Análisis y Prospectiva.', false), ('D', 'Puesto de Mando Avanzado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Orden PRE/422/2013, la unidad de la Guardia Civil especialmente concebida, preparada y organizada para la lucha contra elementos terroristas y la ejecución de operaciones que entrañen gran riesgo y requieran una respuesta rápida es:', 'El art. 8.2.b) Orden PRE/422/2013 define así la Unidad de Acción Rural; la Agrupación de Reserva y Seguridad es la principal Unidad de Reserva para la seguridad pública (art. 8.2.a) y la UCO investiga la delincuencia grave (art. 10.2.a).', 'gc_15c_servicios_centrales_dggc', (select id from public.topics where slug = 'gc-15c-servicios-centrales-dggc'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906'), 'Art. 8.2.b) Orden PRE/422/2013', 'b) Unidad de Acción Rural. Unidad de la Guardia Civil, especialmente concebida, preparada y organizada para la lucha contra elementos terroristas y la ejecución de operaciones que entrañen gran riesgo y requieran una respuesta rápida', null, '0acd0a020e47cfe8b398abdf69116eb645a786328408b34cd0fca31898830659', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0acd0a020e47cfe8b398abdf69116eb645a786328408b34cd0fca31898830659')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Agrupación de Reserva y Seguridad.', false), ('B', 'La Unidad de Acción Rural.', true), ('C', 'La Unidad Central Operativa.', false), ('D', 'El Servicio de Desactivación de Explosivos y Defensa NRBQ.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Orden PRE/422/2013, el órgano especializado de la Guardia Civil que dirige técnicamente y mantiene la operatividad del Sistema de Defensa NRBQ del Cuerpo es:', 'El art. 8.2.e) Orden PRE/422/2013 encomienda a este Servicio la prevención y actuación ante artefactos explosivos, incendiarios o NRBQ y la dirección técnica del Sistema de Defensa NRBQ de la Guardia Civil.', 'gc_15c_servicios_centrales_dggc', (select id from public.topics where slug = 'gc-15c-servicios-centrales-dggc'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906'), 'Art. 8.2.e) Orden PRE/422/2013', 'así como, para dirigir técnicamente y mantener la operatividad del Sistema de Defensa NRBQ de la Guardia Civil', null, 'cd912a40a362eb30777527b19a693f48b472c8b9848f61c2414ec4318fcd03fa', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'cd912a40a362eb30777527b19a693f48b472c8b9848f61c2414ec4318fcd03fa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Servicio de Protección y Seguridad.', false), ('B', 'El Servicio de Criminalística.', false), ('C', 'El Servicio de Desactivación de Explosivos y Defensa Nuclear, Radiológica, Biológica y Química (NRBQ).', true), ('D', 'El Servicio de Innovación Tecnológica y Seguridad de la Información.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la Orden PRE/422/2013, la unidad de la Jefatura de Policía Judicial que tiene como misión investigar y perseguir los asuntos relacionados con la delincuencia grave, nacional e internacional, es:', 'El art. 10.2 Orden PRE/422/2013 sitúa en la Jefatura de Policía Judicial la Unidad Central Operativa (delincuencia grave), la Unidad Técnica de Policía Judicial (asesoramiento técnico, análisis criminal e información) y el Servicio de Criminalística (técnicas científicas y pericias).', 'gc_15c_servicios_centrales_dggc', (select id from public.topics where slug = 'gc-15c-servicios-centrales-dggc'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906'), 'Art. 10.2.a) Orden PRE/422/2013', 'a) Unidad Central Operativa. Tiene como misión investigar y perseguir los asuntos relacionados con la delincuencia grave, nacional e internacional', null, '994a18d7ed5c9dce7a71756e7d701504d42fb76a333e03fa0afb40595a307f65', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '994a18d7ed5c9dce7a71756e7d701504d42fb76a333e03fa0afb40595a307f65')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Unidad Técnica de Policía Judicial.', false), ('B', 'El Servicio de Criminalística.', false), ('C', 'La Unidad Especial de Intervención.', false), ('D', 'La Unidad Central Operativa.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Orden PRE/422/2013, identificar personas en sucesos con víctimas múltiples es una misión de:', 'El Servicio de Criminalística aplica técnicas científicas para esclarecer los hechos penales, elabora informes periciales e identifica personas en sucesos con víctimas múltiples (art. 10.2.c).', 'gc_15c_servicios_centrales_dggc', (select id from public.topics where slug = 'gc-15c-servicios-centrales-dggc'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906'), 'Art. 10.2.c) Orden PRE/422/2013', 'identificar personas en sucesos con víctimas múltiples', null, '2a15b6d40a28f7f009a21a2a1ce06d251ef7ec9e2cc71877d19e857df7fc1246', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2a15b6d40a28f7f009a21a2a1ce06d251ef7ec9e2cc71877d19e857df7fc1246')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Unidad Técnica de Policía Judicial.', false), ('B', 'El Servicio de Sanidad.', false), ('C', 'La Agrupación de Reserva y Seguridad.', false), ('D', 'El Servicio de Criminalística.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la Orden PRE/422/2013, las Zonas de la Guardia Civil son:', 'El art. 14.1 Orden PRE/422/2013 sitúa las Zonas bajo la dependencia directa del Mando de Operaciones, sin perjuicio de sus relaciones funcionales con las áreas de personal y apoyo, como unidades de mando, coordinación e inspección en su territorio.', 'gc_15c_servicios_centrales_dggc', (select id from public.topics where slug = 'gc-15c-servicios-centrales-dggc'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906'), 'Art. 14.1 Orden PRE/422/2013', 'son las Unidades de mando, coordinación e inspección de todos los Servicios de la Dirección General de la Guardia Civil existentes en el ámbito territorial de cada una de ellas.', null, 'c15c5c000d4e13f01ac22a845ace805399238368765807b57add1e833fe3361c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c15c5c000d4e13f01ac22a845ace805399238368765807b57add1e833fe3361c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las Unidades de mando, coordinación e inspección de todos los Servicios de la Dirección General existentes en su ámbito territorial.', true), ('B', 'Órganos centrales con nivel orgánico de Subdirección General.', false), ('C', 'Unidades de reserva dependientes de la Jefatura de Unidades Especiales y de Reserva.', false), ('D', 'Órganos de coordinación dependientes de las Delegaciones del Gobierno.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Orden PRE/422/2013, la dirección del Museo y de la Biblioteca de la Guardia Civil corresponde a:', 'El Servicio de Estudios Históricos, dependiente de la Jefatura de Asistencia al Personal, recupera, conserva y estudia el fondo patrimonial de interés para la historia de la Institución y dirige el Museo y la Biblioteca (art. 22.2.f).', 'gc_15c_servicios_centrales_dggc', (select id from public.topics where slug = 'gc-15c-servicios-centrales-dggc'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906'), 'Art. 22.2.f) Orden PRE/422/2013', 'ejerciendo para ello la dirección del Museo y de la Biblioteca.', null, 'd864ee1645656235ac2760e75c2f01048b6c1db597c9a5e68ae0f45174aee89d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd864ee1645656235ac2760e75c2f01048b6c1db597c9a5e68ae0f45174aee89d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Oficina de Relaciones Informativas y Sociales.', false), ('B', 'El Servicio de Asuntos Generales.', false), ('C', 'El Servicio de Estudios Históricos.', true), ('D', 'El Centro de Análisis y Prospectiva.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Orden PRE/422/2013, ¿qué unidad encuadra a efectos administrativos al personal del Cuerpo de la Guardia Civil destinado en Interpol, Europol y SIRENE?', 'El art. 10.2.b) Orden PRE/422/2013 atribuye a la Unidad Técnica de Policía Judicial el encuadramiento administrativo del personal destinado en Interpol, Europol, SIRENE y demás órganos compartidos con agencias o cuerpos policiales nacionales y extranjeros.', 'gc_15c_servicios_centrales_dggc', (select id from public.topics where slug = 'gc-15c-servicios-centrales-dggc'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906'), 'Art. 10.2.b) Orden PRE/422/2013', 'Asimismo, encuadra a efectos administrativos al personal del Cuerpo de la Guardia Civil destinado en Interpol, Europol, SIRENE y demás órganos compartidos', null, '7e9cace47d509345ff6b7fab9502fa951a4622e5bd3395f5091ddc6beca76e3f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7e9cace47d509345ff6b7fab9502fa951a4622e5bd3395f5091ddc6beca76e3f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Secretaría de Cooperación Internacional.', false), ('B', 'La Unidad Técnica de Policía Judicial.', true), ('C', 'La Unidad Central Operativa.', false), ('D', 'El Servicio de Asuntos Generales.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la Orden PRE/422/2013, el control interno superior, dentro de la estructura orgánica de la Dirección General de la Guardia Civil, en materia de prevención de riesgos para la seguridad y salud del personal en el trabajo corresponde a:', 'El art. 22.2.d) Orden PRE/422/2013 encomienda al Servicio de Prevención el control interno superior en prevención de riesgos dentro de la Dirección General; el control externo corresponde a la Inspección de Personal y Servicios de Seguridad (art. 15 RD 179/2005).', 'gc_15c_servicios_centrales_dggc', (select id from public.topics where slug = 'gc-15c-servicios-centrales-dggc'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906'), 'Art. 22.2.d) Orden PRE/422/2013', 'd) Servicio de Prevención. Tiene como cometidos el control interno superior, dentro de la estructura orgánica de la Dirección General de la Guardia Civil, en materia de prevención de riesgos para la seguridad y salud del personal en el trabajo.', null, '7ed306f57e0012abad6cf72e8326a02dbba9b9281bce7893fe91cb9d67333eb1', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7ed306f57e0012abad6cf72e8326a02dbba9b9281bce7893fe91cb9d67333eb1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Servicio de Sanidad, dependiente de la Jefatura de Asistencia al Personal.', false), ('B', 'La Inspección de Personal y Servicios de Seguridad de la Secretaría de Estado de Seguridad.', false), ('C', 'El Servicio de Prevención, dependiente de la Jefatura de Asistencia al Personal.', true), ('D', 'El Servicio de Asuntos Generales, dependiente de la Jefatura de Personal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Orden PRE/422/2013, en su redacción vigente, el órgano responsable de centralizar las labores de seguimiento, impulso y evaluación de la aplicación del Código de Conducta en la Guardia Civil es:', 'El art. 23 bis, añadido por la Orden PJC/849/2024, crea el Observatorio de Conducta Ética de la Guardia Civil, dependiente del Subdirector General de Personal (art. 19.4.e).', 'gc_15c_servicios_centrales_dggc', (select id from public.topics where slug = 'gc-15c-servicios-centrales-dggc'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906'), 'Art. 23 bis Orden PRE/422/2013', 'El Observatorio de Conducta Ética de la Guardia Civil, con el nivel orgánico que se determine en la relación de puestos de trabajo, es el órgano responsable de centralizar las labores de seguimiento, impulso y evaluación de la aplicación del Código de Conducta en la Guardia Civil.', null, '1f222c287c1859137316824f29c55ad951ecd3c5112ff6423796a7b46a8a6b75', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1f222c287c1859137316824f29c55ad951ecd3c5112ff6423796a7b46a8a6b75')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Servicio de Asuntos Internos.', false), ('B', 'El Observatorio de Conducta Ética de la Guardia Civil.', true), ('C', 'La Unidad de Desarrollo y Talento.', false), ('D', 'La Secretaría Permanente para la Clasificación y Evaluación.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la Orden PRE/422/2013, en su redacción vigente, el Servicio de Historial Profesional depende de:', 'Tras la Orden PJC/598/2025, de la Jefatura de Personal dependen los Servicios de Gestión del Personal, de Retribuciones, de Régimen Disciplinario y de Historial Profesional (art. 20.2).', 'gc_15c_servicios_centrales_dggc', (select id from public.topics where slug = 'gc-15c-servicios-centrales-dggc'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906'), 'Art. 20.2.d) Orden PRE/422/2013', 'd) Servicio de Historial Profesional, responsable de recepcionar, integrar, controlar y gestionar la información que forma parte del Historial Profesional del personal de la Guardia Civil.', null, '3c28e9250824fcec9efb3c05364266e6253401ba6c4ed53db0a99646e9624d59', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3c28e9250824fcec9efb3c05364266e6253401ba6c4ed53db0a99646e9624d59')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Jefatura de Personal.', true), ('B', 'La Jefatura de Enseñanza.', false), ('C', 'La Secretaría Permanente para la Clasificación y Evaluación.', false), ('D', 'La Jefatura de Asistencia al Personal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con la Orden PRE/422/2013, la representación, en el ámbito de la Guardia Civil, de la Escuela Iberoamericana de Policía (IBERPOL) queda ubicada en:', 'El art. 21.4 Orden PRE/422/2013 (redacción de la Orden PJC/598/2025) ubica en la Jefatura de Enseñanza la representación de IBERPOL en el ámbito de la Guardia Civil.', 'gc_15c_servicios_centrales_dggc', (select id from public.topics where slug = 'gc-15c-servicios-centrales-dggc'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906'), 'Art. 21.4 Orden PRE/422/2013', 'En la Jefatura de Enseñanza queda ubicada la representación, en el ámbito de la Guardia Civil, de la Escuela Iberoamérica de Policía (IBERPOL).', null, '85b00c6486783aca020b2c96dd5c2e4ed3e456ee6c3c40517997f2d4f9b758d3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '85b00c6486783aca020b2c96dd5c2e4ed3e456ee6c3c40517997f2d4f9b758d3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Secretaría de Cooperación Internacional.', false), ('B', 'El Centro Universitario de la Guardia Civil.', false), ('C', 'La Jefatura de Policía Judicial.', false), ('D', 'La Jefatura de Enseñanza.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-15d-historia-guardia-civil-gc_historia-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Guardia Civil · Historia de la Guardia Civil (web oficial)', 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/', 'web_oficial'::public.source_kind, 'Guardia Civil (web oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-15d-historia-guardia-civil', 'Tema 15. Historia de la Guardia Civil') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-15d-historia-guardia-civil' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la Guardia Civil, la creación oficial de la Guardia Civil se produjo por Real Decreto de:', 'El Real Decreto de 28 de marzo de 1844 crea un «cuerpo especial de fuerza armada de Infantería y Caballería» con la denominación de Guardias Civiles; el definitivo decreto fundacional es el de 13 de mayo de 1844. El 9 de octubre de 1844 se aprueba el Reglamento para el Servicio y el 20 de diciembre de 1845 la Cartilla.', 'gc_15d_historia_guardia_civil', (select id from public.topics where slug = 'gc-15d-historia-guardia-civil'), 1, 'es', true, (select id from public.sources where url = 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/'), 'Historia, La Fundación (28/03/1844)', 'Así, el 28 de marzo de 1844, se produce el momento histórico de la creación oficial de la Guardia Civil cuando, por Real Decreto, se crea un “cuerpo especial de fuerza armada de Infantería y Caballería”', null, '6993713e403645a5b1a1bf876ce43bc2d143191210c8b6ed75d014cdf2b836be', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6993713e403645a5b1a1bf876ce43bc2d143191210c8b6ed75d014cdf2b836be')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '13 de mayo de 1845.', false), ('B', '28 de marzo de 1844.', true), ('C', '9 de octubre de 1844.', false), ('D', '20 de diciembre de 1845.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la Guardia Civil, ¿a quién se comisionó para organizar la nueva fuerza creada en 1844?', 'Se comisionó al mariscal de campo Francisco Javier Girón y Ezpeleta, II Duque de Ahumada. Su padre, el primer duque, había proyectado en 1820 la Legión de Salvaguardias Nacionales; Narváez presentó el decreto de 13 de mayo y Facundo Infantes fue el segundo director del Cuerpo.', 'gc_15d_historia_guardia_civil', (select id from public.topics where slug = 'gc-15d-historia-guardia-civil'), 1, 'es', true, (select id from public.sources where url = 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/'), 'Historia, La Fundación (Duque de Ahumada)', 'A los efectos de organizar esta nueva fuerza se comisiona al mariscal de campo D. Francisco Javier Girón y Ezpeleta, II Duque de Ahumada.', null, '8a77c27ea695fbfdb854aadb47ff1c37333bf23676d5d03d8366d26022ed8362', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8a77c27ea695fbfdb854aadb47ff1c37333bf23676d5d03d8366d26022ed8362')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al teniente general D. Pedro Agustín Girón y de las Casas, primer duque de Ahumada.', false), ('B', 'Al general D. Ramón María Narváez, Presidente del Gobierno.', false), ('C', 'Al mariscal de campo D. Francisco Javier Girón y Ezpeleta, II Duque de Ahumada.', true), ('D', 'Al general D. Facundo Infantes.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la Guardia Civil, el artículo más famoso de la Cartilla del Guardia Civil establece que la principal divisa del guardia civil es:', 'La Cartilla está presidida por el artículo que proclama que el honor es la principal divisa del guardia civil, que debe conservarlo sin mancha porque, una vez perdido, no se recobra jamás.', 'gc_15d_historia_guardia_civil', (select id from public.topics where slug = 'gc-15d-historia-guardia-civil'), 1, 'es', true, (select id from public.sources where url = 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/'), 'Historia, La Fundación (Cartilla)', '“el honor es la principal divisa del guardia civil; debe, por consiguiente, conservarlo sin mancha. Una vez perdido, no se recobra jamás”.', null, 'd9bf95a5bd9131f52057783e906476ce882649d0744e361f4f2c4a100f739385', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd9bf95a5bd9131f52057783e906476ce882649d0744e361f4f2c4a100f739385')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La disciplina.', false), ('B', 'La lealtad.', false), ('C', 'La abnegación.', false), ('D', 'El honor.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la Guardia Civil, ¿en qué año se declaró a la Virgen del Pilar patrona de la Guardia Civil?', 'La declaración de la Virgen del Pilar como patrona en 1913, el primer museo del Cuerpo (1921) y el estreno del himno (1 de agosto de 1922) son jalones de la tradición del Cuerpo durante el reinado de Alfonso XIII.', 'gc_15d_historia_guardia_civil', (select id from public.topics where slug = 'gc-15d-historia-guardia-civil'), 1, 'es', true, (select id from public.sources where url = 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/'), 'Historia, El Reinado de Alfonso XIII (patrona)', 'la declaración de la Virgen del Pilar como patrona de la Guardia Civil en 1913', null, '11cce7a28babd6173c6e64530d59c40cd2d9d903a1f5cd6b00007b6177d559f6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '11cce7a28babd6173c6e64530d59c40cd2d9d903a1f5cd6b00007b6177d559f6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En 1913.', true), ('B', 'En 1844.', false), ('C', 'En 1922.', false), ('D', 'En 1929.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la Guardia Civil, el tricornio, que se mostró en la presentación oficial del Cuerpo el 1 de septiembre de 1844, era un sombrero de tres picos de origen:', 'En la parada militar de presentación del 1 de septiembre de 1844 desfilaron 1.870 guardias con un sombrero de tres picos de origen francés: el tricornio, luego símbolo de la Guardia Civil.', 'gc_15d_historia_guardia_civil', (select id from public.topics where slug = 'gc-15d-historia-guardia-civil'), 1, 'es', true, (select id from public.sources where url = 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/'), 'Historia, La Fundación (tricornio)', 'un original sombrero de tres picos de origen francés: el tricornio', null, '7177c38c871948001bcc0324c8c8d6b17e0676e4af26d9ad2178a934497f3cf2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7177c38c871948001bcc0324c8c8d6b17e0676e4af26d9ad2178a934497f3cf2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Británico.', false), ('B', 'Italiano.', false), ('C', 'Francés.', true), ('D', 'Prusiano.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la Guardia Civil, el Servicio de Protección de la Naturaleza (SEPRONA) se creó en:', 'El SEPRONA se crea en 1988, en consonancia con la LO 2/1986; en 1959 se creó la Agrupación de Tráfico, en 1973 entraron en servicio los primeros helicópteros y en 1991 se creó el Servicio Marítimo.', 'gc_15d_historia_guardia_civil', (select id from public.topics where slug = 'gc-15d-historia-guardia-civil'), 1, 'es', true, (select id from public.sources where url = 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/'), 'Historia, La Transición y La Democracia (SEPRONA)', 'se crea en 1988 el Servicio de Protección de la Naturaleza (SEPRONA)', null, 'fd7331a68205e871a5be32baeb3d89bae0dbf8fd82ab35d27169b6b317451397', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'fd7331a68205e871a5be32baeb3d89bae0dbf8fd82ab35d27169b6b317451397')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1959.', false), ('B', '1988.', true), ('C', '1973.', false), ('D', '1991.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la Guardia Civil, el «auténtico decreto fundacional» de la Guardia Civil es el Real Decreto de 13 de mayo de 1844, presentado por:', 'El informe del Duque de Ahumada de 20 de abril de 1844 provocó la derogación del decreto de 28 de marzo y dio lugar al definitivo Real Decreto de 13 de mayo, presentado por Narváez.', 'gc_15d_historia_guardia_civil', (select id from public.topics where slug = 'gc-15d-historia-guardia-civil'), 2, 'es', true, (select id from public.sources where url = 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/'), 'Historia, La Fundación (RD 13/05/1844)', 'para dar lugar al definitivo Real Decreto de 13 de mayo, presentado por el Presidente de Gobierno y Ministro de la Guerra, D. Ramón María Narváez, auténtico decreto fundacional de la Guardia Civil.', null, '444bd8f7ed2080206eb3b29009f9d80d0bd6f3f46bb8423ff59071f299f153f8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '444bd8f7ed2080206eb3b29009f9d80d0bd6f3f46bb8423ff59071f299f153f8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'D. Ramón María Narváez, Presidente de Gobierno y Ministro de la Guerra.', true), ('B', 'El Duque de Ahumada, Inspector General de la Guardia Civil.', false), ('C', 'D. Juan Prim, Presidente del Gobierno Provisional.', false), ('D', 'El Ministro de la Gobernación.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la Guardia Civil, conforme al decreto de 13 de mayo de 1844, la Guardia Civil se compondría inicialmente de 14 jefes, 232 oficiales y 5769 guardias repartidos en:', 'La plantilla inicial se repartía en 14 Tercios (término de los Austrias), cada uno con compañías de Infantería y un escuadrón o sección de Caballería. Las Zonas se crean en 1926 y en 1933 había 19 Tercios en cinco Zonas.', 'gc_15d_historia_guardia_civil', (select id from public.topics where slug = 'gc-15d-historia-guardia-civil'), 2, 'es', true, (select id from public.sources where url = 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/'), 'Historia, La Fundación (organización inicial)', 'Inicialmente se compondrá de 14 jefes, 232 oficiales y 5769 guardias repartidos en 14 Tercios', null, '587d7062c7d11bb7e1f8625e0110650af5e2220b4872f4647b9c4b3273a9b25a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '587d7062c7d11bb7e1f8625e0110650af5e2220b4872f4647b9c4b3273a9b25a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '14 Zonas.', false), ('B', '19 Tercios.', false), ('C', '5 Zonas.', false), ('D', '14 Tercios.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la Guardia Civil, conforme a su organización fundacional, la Guardia Civil dependía del Ministerio de la Guerra en lo concerniente a su organización, personal, disciplina, material y percibo de haberes, y del Ministerio de la Gobernación en lo relativo a:', 'Desde su fundación la Guardia Civil tuvo doble dependencia: Guerra (organización, personal, disciplina, material y haberes) y Gobernación (servicio peculiar y movimiento).', 'gc_15d_historia_guardia_civil', (select id from public.topics where slug = 'gc-15d-historia-guardia-civil'), 2, 'es', true, (select id from public.sources where url = 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/'), 'Historia, La Fundación (doble dependencia)', '“del Ministerio de la Guerra en lo concerniente a su organización, personal, disciplina, material y percibo de sus haberes, y del Ministerio de la Gobernación en lo relativo a su servicio peculiar y su movimiento.”', null, '28f3953c74a8d7e63c759e6e996053f303e726cabac9ec0458d650b534cf0317', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '28f3953c74a8d7e63c759e6e996053f303e726cabac9ec0458d650b534cf0317')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sus ascensos y su régimen disciplinario.', false), ('B', 'Su armamento y acuartelamiento.', false), ('C', 'La formación de sus oficiales.', false), ('D', 'Su servicio peculiar y su movimiento.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la Guardia Civil, la primera misión internacional de la Guardia Civil tuvo lugar en 1847 en:', 'En 1847, con Portugal en guerra civil, una unidad de Caballería de la Guardia Civil patrulló y garantizó la seguridad ciudadana en Oporto.', 'gc_15d_historia_guardia_civil', (select id from public.topics where slug = 'gc-15d-historia-guardia-civil'), 2, 'es', true, (select id from public.sources where url = 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/'), 'Historia, La consolidación (primera misión internacional)', 'Una unidad de Caballería de la Guardia Civil se encarga de patrullar y garantizar la seguridad ciudadana en la ciudad de Oporto.', null, 'b62499070da792867d840bc506be0858c2f0d6bbeff7ce50e27e89b631992540', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b62499070da792867d840bc506be0858c2f0d6bbeff7ce50e27e89b631992540')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cuba, para combatir la insurrección de la Guerra de los diez años.', false), ('B', 'Marruecos, en el marco del Protectorado.', false), ('C', 'La ciudad de Oporto (Portugal), donde una unidad de Caballería patrulló y garantizó la seguridad ciudadana.', true), ('D', 'Lisboa (Portugal), como escolta de la familia real portuguesa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la Guardia Civil, la «Compañía de Guardias Jóvenes», antecedente del actual Colegio de Guardias Jóvenes «Duque de Ahumada», se creó por Real Orden de:', 'La Real Orden de 1 de abril de 1853 creó la Compañía de Guardias Jóvenes para dar amparo y educación a los huérfanos e hijos del Cuerpo y ayudar a formar nuevos guardias.', 'gc_15d_historia_guardia_civil', (select id from public.topics where slug = 'gc-15d-historia-guardia-civil'), 2, 'es', true, (select id from public.sources where url = 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/'), 'Historia, La consolidación (Guardias Jóvenes)', 'El 1º de abril de 1853, por Real Orden, se creará la “Compañía de Guardias Jóvenes” para dar amparo y educación a los huérfanos e hijos del Cuerpo y ayudar a la formación de nuevos guardias.', null, 'be4846d042002505142a410164ea39bec238f04dd2d8571e5db8b4c21db18d5c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'be4846d042002505142a410164ea39bec238f04dd2d8571e5db8b4c21db18d5c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '20 de diciembre de 1845.', false), ('B', '1 de abril de 1853.', true), ('C', '15 de octubre de 1844.', false), ('D', '12 de febrero de 1927.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la Guardia Civil, la Ley de 15 de marzo de 1940 supuso:', 'La Ley de 15 de marzo de 1940 suprimió el Cuerpo de Carabineros tras 111 años de servicio y atribuyó sus funciones a la Guardia Civil. La Guardia Rural la suprimió el Gobierno Provisional de Prim; la Agrupación de Tráfico es de 1959.', 'gc_15d_historia_guardia_civil', (select id from public.topics where slug = 'gc-15d-historia-guardia-civil'), 2, 'es', true, (select id from public.sources where url = 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/'), 'Historia, El Franquismo (Ley de 15/03/1940)', 'el 15 de marzo de 1940 se promulga una Ley fundamentada en dos pilares básicos: la supresión del Cuerpo de Carabineros, al que se pone fin tras 111 años de servicio ininterrumpido, y asunción de sus funciones por la Guardia Civil', null, '217e985fca21b4d53475de2325aa02f976b7bb8edd46fbd4fd46abc2043751e3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '217e985fca21b4d53475de2325aa02f976b7bb8edd46fbd4fd46abc2043751e3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La supresión del Cuerpo de Carabineros y la asunción de sus funciones por la Guardia Civil.', true), ('B', 'La creación de la Agrupación de Tráfico de la Guardia Civil.', false), ('C', 'La transformación de la Dirección General en Inspección General dependiente de Gobernación.', false), ('D', 'La supresión de la Guardia Rural y la asunción de sus funciones por la Guardia Civil.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la Guardia Civil, ¿en qué año se encomendó a la Guardia Civil la vigilancia del tráfico y del transporte por carretera, creándose la Agrupación de Tráfico?', 'En 1959, año del Plan de Estabilización, el aumento del tráfico rodado llevó a encomendar a la Guardia Civil la vigilancia del tráfico y a crear la Agrupación de Tráfico, punto de inflexión en la modernización del Cuerpo.', 'gc_15d_historia_guardia_civil', (select id from public.topics where slug = 'gc-15d-historia-guardia-civil'), 2, 'es', true, (select id from public.sources where url = 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/'), 'Historia, El Franquismo (Agrupación de Tráfico)', 'En este mismo año, dado el aumento del tráfico rodado que se produce como consecuencia del crecimiento económico, se encomienda a la Guardia Civil la vigilancia del tráfico y del transporte por carretera. Se crea la Agrupación de Tráfico de la Guardia Civil', null, '54f717c0fe6855e54004fab1cd6fc0ff51fa4e2797a0cb1d83d38b36157a92f5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '54f717c0fe6855e54004fab1cd6fc0ff51fa4e2797a0cb1d83d38b36157a92f5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En 1942.', false), ('B', 'En 1959.', true), ('C', 'En 1968.', false), ('D', 'En 1986.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la Guardia Civil, mediante Real Decreto de 4 de octubre de 1929 se concedió a la Guardia Civil:', 'La Gran Cruz de la Orden Civil de Beneficencia (1929) reconoció los actos humanitarios del Cuerpo y su carácter «benemérito». La Corbata de la Orden de la República se concedió el 12 de febrero de 1935.', 'gc_15d_historia_guardia_civil', (select id from public.topics where slug = 'gc-15d-historia-guardia-civil'), 2, 'es', true, (select id from public.sources where url = 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/'), 'Historia, El Reinado de Alfonso XIII (Orden Civil de Beneficencia)', 'En 1929 mediante Real Decreto de 4 de octubre, se concede a la Guardia Civil la Gran Cruz de la Orden Civil de Beneficencia', null, '8c387b266eb9ad8a0b36b77465eb8c71187a9bcdf51cae9af38baec32cac3a83', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8c387b266eb9ad8a0b36b77465eb8c71187a9bcdf51cae9af38baec32cac3a83')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Gran Cruz de la Orden Civil de Beneficencia.', true), ('B', 'La Corbata de la Orden de la República.', false), ('C', 'La Gran Cruz de la Orden del Mérito Militar.', false), ('D', 'La Medalla de Oro al Mérito en el Trabajo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la Guardia Civil, desde su entrada en servicio en 2005 la Guardia Civil participa en la Fuerza de Gendarmería Europea (EUROGENDFOR) junto con fuerzas de policía de naturaleza militar de:', 'EUROGENDFOR, instrumento de la política de seguridad y defensa de la UE, agrupa a la Guardia Civil con las fuerzas de policía de naturaleza militar de Francia, Holanda, Italia, Portugal y Rumania.', 'gc_15d_historia_guardia_civil', (select id from public.topics where slug = 'gc-15d-historia-guardia-civil'), 2, 'es', true, (select id from public.sources where url = 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/'), 'Historia, La Transición y La Democracia (EUROGENDFOR)', 'la Guardia Civil participa en la Fuerza de Gendarmería Europea (EUROGENDFOR) junto con fuerzas de policía de naturaleza militar: de Francia, Holanda, Italia, Portugal y Rumania.', null, '672e864e5a5ce6011f175bd3e864b227ab5a4dcf289b3e9abec562aa6d476839', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '672e864e5a5ce6011f175bd3e864b227ab5a4dcf289b3e9abec562aa6d476839')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Francia, Alemania, Italia, Portugal y Bélgica.', false), ('B', 'Francia, Italia y Portugal únicamente.', false), ('C', 'Francia, Holanda, Italia, Grecia y Polonia.', false), ('D', 'Francia, Holanda, Italia, Portugal y Rumania.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la Guardia Civil, el Reglamento para el Servicio de la Guardia Civil y el Reglamento Militar de la Guardia Civil se aprobaron, respectivamente, el:', 'El Reglamento para el Servicio (9 de octubre de 1844) fija obligaciones, facultades y el objeto de la Institución; el Reglamento Militar (15 de octubre), elaborado por el Ministerio de la Guerra, regula organización, ascensos y disciplina. La Cartilla es de 20 de diciembre de 1845.', 'gc_15d_historia_guardia_civil', (select id from public.topics where slug = 'gc-15d-historia-guardia-civil'), 3, 'es', true, (select id from public.sources where url = 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/'), 'Historia, La Fundación (reglamentos de 1844)', 'El 9 de octubre de 1844 se aprobaba el Reglamento para el Servicio de la Guardia Civil […] El Reglamento Militar de la Guardia Civil aprobado el 15 de octubre', null, '9f056b3e71c83f10d74a361220389bf1c0aaa5f37810a7100fda956f06f82994', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9f056b3e71c83f10d74a361220389bf1c0aaa5f37810a7100fda956f06f82994')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '15 de octubre de 1844 y 9 de octubre de 1844.', false), ('B', '13 de mayo de 1844 y 1 de septiembre de 1844.', false), ('C', '9 de octubre de 1844 y 15 de octubre de 1844.', true), ('D', '9 de octubre de 1844 y 20 de diciembre de 1845.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la Guardia Civil, el proyecto de la «Legión de Salvaguardias Nacionales», concebido en 1820 por el primer duque de Ahumada siendo Ministro de la Guerra, se inspiraba en:', 'El primer duque de Ahumada concibió la Legión de Salvaguardias Nacionales, inspirada en la Gendarmería Nacional francesa; no fue aprobada por las Cortes, pero inspiró a su hijo en la idea de la futura Guardia Civil.', 'gc_15d_historia_guardia_civil', (select id from public.topics where slug = 'gc-15d-historia-guardia-civil'), 3, 'es', true, (select id from public.sources where url = 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/'), 'Historia, Los inicios del Siglo XIX (Legión de Salvaguardias Nacionales)', 'la Legión de Salvaguardias Nacionales que, inspirada en la Gendarmería Nacional francesa, debería combatir la delincuencia y garantizar la libre circulación de bienes y personas.', null, 'e4e95d945426f21d675cd4d18e6c11576cf218f5d4d991a95ef6223d583c470a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e4e95d945426f21d675cd4d18e6c11576cf218f5d4d991a95ef6223d583c470a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Gendarmería Nacional francesa.', true), ('B', 'Los Carabineros Reales italianos.', false), ('C', 'La Policía Metropolitana de Londres.', false), ('D', 'La Milicia Nacional de las Cortes de Cádiz.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la Guardia Civil, tras la Sanjurjada de agosto de 1932 la Dirección General de la Guardia Civil:', 'La Sanjurjada hizo que la Dirección General, dependiente del Ministerio de la Guerra, se transformara en Inspección General dependiente de Gobernación. En 1933 lo que se transfirió a la Generalitat fue el control de la 5.ª Zona.', 'gc_15d_historia_guardia_civil', (select id from public.topics where slug = 'gc-15d-historia-guardia-civil'), 3, 'es', true, (select id from public.sources where url = 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/'), 'Historia, La Segunda República (Sanjurjada)', 'La conocida como Sanjurjada tiene como consecuencia que la Dirección General de la Guardia Civil dependiente del Ministerio de la Guerra se transforme en Inspección General para pasar a depender del Ministerio de Gobernación.', null, '0c874248a8e30184d3d1222d1c13ac580ffcb41b67c742e0d5ef5af1365140c3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0c874248a8e30184d3d1222d1c13ac580ffcb41b67c742e0d5ef5af1365140c3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se suprimió y sus funciones pasaron a la Guardia de Asalto.', false), ('B', 'Pasó a depender exclusivamente del Ministerio de la Guerra.', false), ('C', 'Se transfirió a la Generalitat de Cataluña.', false), ('D', 'Se transformó en Inspección General y pasó a depender del Ministerio de Gobernación.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la Guardia Civil, ¿en qué fecha se concedió al Instituto la Corbata de la Orden de la República?', 'Por decreto, el Gobierno concedió la Corbata de la Orden de la República el 12 de febrero de 1935 como recompensa colectiva. El 3 de julio de 1932 Cabanellas sustituyó a Sanjurjo como Director General y el 4 de octubre de 1929 es la fecha de la Gran Cruz de Beneficencia.', 'gc_15d_historia_guardia_civil', (select id from public.topics where slug = 'gc-15d-historia-guardia-civil'), 3, 'es', true, (select id from public.sources where url = 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/'), 'Historia, La Segunda República (Corbata de la Orden de la República)', 'concede al Instituto la Corbata de la Orden de la República el 12 de febrero de 1935', null, '55a5c27c7641778f8071be66c21a80a6add07bbf06da7f17afdb36af6c900d76', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '55a5c27c7641778f8071be66c21a80a6add07bbf06da7f17afdb36af6c900d76')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 14 de abril de 1931.', false), ('B', 'El 12 de febrero de 1935.', true), ('C', 'El 3 de julio de 1932.', false), ('D', 'El 4 de octubre de 1929.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial de la Guardia Civil, la figura del guardia civil auxiliar, como modalidad de voluntariado especial, se creó por:', 'El RD 3543/1981 creó el guardia civil auxiliar; el voluntariado se desarrolló desde 1982 hasta diciembre de 1993, con 22.201 jóvenes en 37 promociones.', 'gc_15d_historia_guardia_civil', (select id from public.topics where slug = 'gc-15d-historia-guardia-civil'), 3, 'es', true, (select id from public.sources where url = 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/'), 'Historia, La Transición y La Democracia (guardia civil auxiliar)', 'por Real Decreto 3543/1981, de 30 de octubre se crea la figura del guardia civil auxiliar, como una modalidad de voluntariado especial.', null, '68c59ee76c508520dbb4a5629f91238e7bdc222e094c5a405089c37cae6493c3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '68c59ee76c508520dbb4a5629f91238e7bdc222e094c5a405089c37cae6493c3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Ley Orgánica 2/1986, de 13 de marzo.', false), ('B', 'El Real Decreto-ley de 1988 sobre incorporación de la mujer a las Fuerzas Armadas.', false), ('C', 'El Real Decreto 3543/1981, de 30 de octubre.', true), ('D', 'La Ley Orgánica 11/2007, de 22 de octubre.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-16b-eficiencia-energetica-eu_dir_efic-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Directiva 2012/27/UE, relativa a la eficiencia energética (texto consolidado a 4.5.2023, capítulos I y II), derogada con efectos desde el 12.10.2025 por la Directiva (UE) 2023/1791 (versión refundida)', 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504', 'web_oficial'::public.source_kind, 'Unión Europea · EUR-Lex (DOUE L 315 de 14.11.2012 y modificaciones)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-16b-eficiencia-energetica', 'Tema 16. Eficiencia energética: Directiva 2012/27/UE (capítulos I y II)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-16b-eficiencia-energetica' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 1 de la Directiva 2012/27/UE, relativa a la eficiencia energética (en su última versión consolidada), los objetivos principales de la Unión en materia de eficiencia energética consisten en un aumento de la eficiencia energética:', 'El art. 1.1 de la Directiva 2012/27/UE (redacción de la Directiva (UE) 2018/2002) fija los objetivos principales: 20 % para 2020 y al menos 32,5 % para 2030. La Directiva 2012/27/UE fue derogada con efectos desde el 12 de octubre de 2025 por la Directiva (UE) 2023/1791 (versión refundida), aunque el temario oficial la sigue citando.', 'gc_16b_eficiencia_energetica', (select id from public.topics where slug = 'gc-16b-eficiencia-energetica'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504'), 'Art. 1.1 Directiva 2012/27/UE', 'que consisten en un aumento de la eficiencia energética del 20 % para 2020 y de al menos el 32,5 % para 2030', null, '5a63db56d6532145402f6f9b1dd9395eab8ad43646c2aeca377d59c37ee37a07', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5a63db56d6532145402f6f9b1dd9395eab8ad43646c2aeca377d59c37ee37a07')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Del 20 % para 2020 y de al menos el 32,5 % para 2030.', true), ('B', 'Del 20 % para 2020 y de al menos el 40 % para 2030.', false), ('C', 'Del 10 % para 2020 y de al menos el 20 % para 2030.', false), ('D', 'Del 32,5 % para 2020 y de al menos el 50 % para 2030.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 1 de la Directiva 2012/27/UE, ¿a la aplicación de qué principio contribuye dicha Directiva?', 'El párrafo tercero del art. 1.1 de la Directiva 2012/27/UE declara que contribuye a la aplicación del principio «primero, la eficiencia energética». (Directiva derogada desde el 12 de octubre de 2025 por la Directiva (UE) 2023/1791, que la refunde.)', 'gc_16b_eficiencia_energetica', (select id from public.topics where slug = 'gc-16b-eficiencia-energetica'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504'), 'Art. 1.1 Directiva 2012/27/UE', 'La presente Directiva contribuye a la aplicación del principio «primero, la eficiencia energética».', null, 'ed80c77b086f20c531c74ba1850e84bbfd37f35d304b47f49fa36b149e8a8381', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ed80c77b086f20c531c74ba1850e84bbfd37f35d304b47f49fa36b149e8a8381')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al principio «quien contamina paga».', false), ('B', 'Al principio de cautela.', false), ('C', 'Al principio de «no causar un perjuicio significativo».', false), ('D', 'Al principio «primero, la eficiencia energética».', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 1 de la Directiva 2012/27/UE, los requisitos que establece la Directiva:', 'El art. 1.2 de la Directiva 2012/27/UE configura sus requisitos como mínimos; los Estados pueden ir más allá con medidas compatibles con el Derecho de la Unión y deben notificarlas a la Comisión. (Directiva derogada desde el 12 de octubre de 2025 por la Directiva (UE) 2023/1791.)', 'gc_16b_eficiencia_energetica', (select id from public.topics where slug = 'gc-16b-eficiencia-energetica'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504'), 'Art. 1.2 Directiva 2012/27/UE', 'Los requisitos que establece la presente Directiva son requisitos mínimos y se entienden sin perjuicio de que cualquier Estado miembro mantenga o introduzca medidas más estrictas. Tales medidas deberán ser compatibles con el Derecho de la Unión. Cuando las disposiciones de la legislación nacional establezcan medidas más estrictas, los Estados miembros notificarán dichas disposiciones a la Comisión.', null, '2e83142ec8c1114bec8fe390a8f38dc638a8fd605deeabb1d3f89fbf07ba50a0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2e83142ec8c1114bec8fe390a8f38dc638a8fd605deeabb1d3f89fbf07ba50a0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Son requisitos máximos que los Estados miembros no pueden superar para no distorsionar el mercado interior.', false), ('B', 'Son requisitos mínimos, sin perjuicio de que los Estados miembros mantengan o introduzcan medidas más estrictas compatibles con el Derecho de la Unión, que deberán notificar a la Comisión.', true), ('C', 'Son requisitos de armonización plena, por lo que los Estados miembros no pueden introducir medidas distintas.', false), ('D', 'Son meras recomendaciones sin carácter vinculante para los Estados miembros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 2 de la Directiva 2012/27/UE, se entiende por «eficiencia energética»:', 'El art. 2.4 define la eficiencia energética como la relación entre la producción y el gasto de energía. Las demás opciones se aproximan a las definiciones de «ahorro de energía» (2.5), «consumo de energía primaria» (2.2) y «mejora de la eficiencia energética» (2.6). (Directiva derogada desde el 12 de octubre de 2025 por la Directiva (UE) 2023/1791.)', 'gc_16b_eficiencia_energetica', (select id from public.topics where slug = 'gc-16b-eficiencia-energetica'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504'), 'Art. 2.4 Directiva 2012/27/UE', '«eficiencia energética»: la relación entre la producción de un rendimiento, servicio, bien o energía, y el gasto de energía;', null, 'ac3d4a7c7d09c65912df038c7d0b44b7d4002923fafdd17599bb126530aa69c9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ac3d4a7c7d09c65912df038c7d0b44b7d4002923fafdd17599bb126530aa69c9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La cantidad de energía ahorrada antes y después de aplicar una medida de mejora.', false), ('B', 'El consumo interior bruto de energía, excluidos los usos no energéticos.', false), ('C', 'La relación entre la producción de un rendimiento, servicio, bien o energía, y el gasto de energía.', true), ('D', 'El aumento del ahorro de energía como resultado de cambios tecnológicos o de comportamiento.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A los efectos de la Directiva 2012/27/UE, ¿qué se entiende por «Administración central»?', 'El art. 2.9 de la Directiva define la Administración central por el alcance territorial de su competencia; los poderes adjudicadores corresponden a la definición de «organismos públicos» (art. 2.8). (Directiva derogada desde el 12 de octubre de 2025 por la Directiva (UE) 2023/1791.)', 'gc_16b_eficiencia_energetica', (select id from public.topics where slug = 'gc-16b-eficiencia-energetica'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504'), 'Art. 2.9 Directiva 2012/27/UE', '«Administración central»: todos los órganos administrativos cuya competencia se extiende a la totalidad del territorio de un Estado miembro;', null, 'fa3b34a77d40dbfa8c96a6a2edeb5a471ef246253fdbb9c24e9a2e2ba0017c51', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'fa3b34a77d40dbfa8c96a6a2edeb5a471ef246253fdbb9c24e9a2e2ba0017c51')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Todos los órganos administrativos cuya competencia se extiende a la totalidad del territorio de un Estado miembro.', true), ('B', 'Los poderes adjudicadores definidos en la Directiva 2004/18/CE.', false), ('C', 'Los órganos del Gobierno de un Estado miembro con sede en su capital.', false), ('D', 'Los organismos públicos que tienen en propiedad edificios con una superficie útil total superior a 250 m2.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la definición de «PYME» del artículo 2 de la Directiva 2012/27/UE, la categoría de microempresas, pequeñas y medianas empresas está constituida por las empresas que ocupan a menos de:', 'El art. 2.26 remite a la Recomendación 2003/361/CE: menos de 250 personas y volumen de negocios anual de hasta 50 millones EUR o balance general de hasta 43 millones EUR. Importa porque las empresas que no son PYME deben someterse a auditorías energéticas periódicas (art. 8.4). (Directiva derogada desde el 12 de octubre de 2025 por la Directiva (UE) 2023/1791.)', 'gc_16b_eficiencia_energetica', (select id from public.topics where slug = 'gc-16b-eficiencia-energetica'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504'), 'Art. 2.26 Directiva 2012/27/UE', 'la categoría de microempresas, pequeñas y medianas empresas está constituida por las empresas que ocupan a menos de 250 personas y cuyo volumen de negocios anual no excede de 50 millones EUR o cuyo balance general anual no excede de 43 millones EUR;', null, 'f0117ed100df25b3859364a734afb014de575f6fc79e4d75dce3d2121095291f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f0117ed100df25b3859364a734afb014de575f6fc79e4d75dce3d2121095291f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '500 personas y cuyo volumen de negocios anual no excede de 50 millones EUR o cuyo balance general anual no excede de 43 millones EUR.', false), ('B', '250 personas y cuyo volumen de negocios anual no excede de 50 millones EUR o cuyo balance general anual no excede de 43 millones EUR.', true), ('C', '250 personas y cuyo volumen de negocios anual no excede de 43 millones EUR o cuyo balance general anual no excede de 50 millones EUR.', false), ('D', '100 personas y cuyo volumen de negocios anual no excede de 10 millones EUR.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 2 de la Directiva 2012/27/UE, una «unidad de microgeneración» es una unidad de cogeneración con una potencia máxima inferior a:', 'El art. 2.39 define la unidad de microgeneración (potencia máxima inferior a 50 kWe); la «unidad de cogeneración a pequeña escala» es la de potencia instalada inferior a 1 MWe (art. 2.38). (Directiva derogada desde el 12 de octubre de 2025 por la Directiva (UE) 2023/1791.)', 'gc_16b_eficiencia_energetica', (select id from public.topics where slug = 'gc-16b-eficiencia-energetica'), 3, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504'), 'Art. 2.39 Directiva 2012/27/UE', '«unidad de microgeneración»: unidad de cogeneración con una potencia máxima inferior a los 50 kWe;', null, '2b8f2d5c2ededd399bcdb7e31fb835f275bf70c7ec97757fb0a477cb0c084489', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2b8f2d5c2ededd399bcdb7e31fb835f275bf70c7ec97757fb0a477cb0c084489')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1 MWe.', false), ('B', '500 kWe.', false), ('C', '50 kWe.', true), ('D', '20 MWe.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 2 de la Directiva 2012/27/UE, es «sistema urbano eficiente de calefacción y refrigeración» todo sistema urbano de calefacción o de refrigeración que utilice al menos:', 'El art. 2.41 fija los umbrales: 50 % renovable, 50 % calor residual, 75 % calor cogenerado o 50 % de una combinación. (Directiva derogada desde el 12 de octubre de 2025 por la Directiva (UE) 2023/1791.)', 'gc_16b_eficiencia_energetica', (select id from public.topics where slug = 'gc-16b-eficiencia-energetica'), 3, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504'), 'Art. 2.41 Directiva 2012/27/UE', '«sistema urbano eficiente de calefacción y refrigeración»: todo sistema urbano de calefacción o de refrigeración que utilice al menos un 50 % de energía renovable, un 50 % de calor residual, un 75 % de calor cogenerado o un 50 % de una combinación de estos tipos de energía y calor;', null, '99288208a3bb89af5b4640c9a62a0e57399c0d661f31fb0585f48e9daaf52935', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '99288208a3bb89af5b4640c9a62a0e57399c0d661f31fb0585f48e9daaf52935')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un 75 % de energía renovable, un 50 % de calor residual, un 50 % de calor cogenerado o un 75 % de una combinación de estos tipos de energía y calor.', false), ('B', 'Un 50 % de energía renovable, un 75 % de calor residual, un 50 % de calor cogenerado o un 50 % de una combinación de estos tipos de energía y calor.', false), ('C', 'Un 32,5 % de energía renovable, un 50 % de calor residual, un 50 % de calor cogenerado o un 32,5 % de una combinación de estos tipos de energía y calor.', false), ('D', 'Un 50 % de energía renovable, un 50 % de calor residual, un 75 % de calor cogenerado o un 50 % de una combinación de estos tipos de energía y calor.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 2 de la Directiva 2012/27/UE, la generación simultánea de energía térmica y de energía eléctrica o mecánica en un solo proceso se denomina:', 'El art. 2.30 define la cogeneración; el calor útil es el producido en un proceso de cogeneración para satisfacer una demanda económicamente justificable (art. 2.32). (Directiva derogada desde el 12 de octubre de 2025 por la Directiva (UE) 2023/1791.)', 'gc_16b_eficiencia_energetica', (select id from public.topics where slug = 'gc-16b-eficiencia-energetica'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504'), 'Art. 2.30 Directiva 2012/27/UE', '«cogeneración»: la generación simultánea de energía térmica y de energía eléctrica o mecánica en un solo proceso;', null, '5a7e954045fce3af71255ee93382bf6044998b023f4c3fcedb112a12f9349ebb', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5a7e954045fce3af71255ee93382bf6044998b023f4c3fcedb112a12f9349ebb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Microgeneración.', false), ('B', 'Calor útil.', false), ('C', 'Cogeneración.', true), ('D', 'Eficiencia global.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 3 de la Directiva 2012/27/UE, al fijar sus contribuciones orientativas nacionales para 2030 los Estados miembros tendrán en cuenta que el consumo de energía de la Unión en 2030 no deberá exceder de:', 'El art. 3.5 fija para 2030 el techo de 1 128 Mtep de energía primaria y/o 846 Mtep de energía final; las cifras de 1 483 y 1 086 Mtep corresponden al objetivo de 2020 (art. 3.1.a). Las contribuciones se notifican en los planes nacionales integrados de energía y clima. (Directiva derogada desde el 12 de octubre de 2025 por la Directiva (UE) 2023/1791.)', 'gc_16b_eficiencia_energetica', (select id from public.topics where slug = 'gc-16b-eficiencia-energetica'), 3, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504'), 'Art. 3.5 Directiva 2012/27/UE', 'En la fijación de esas contribuciones, los Estados miembros tendrán en cuenta que el consumo de energía de la Unión en 2030 no deberá exceder de 1 128 Mtep de energía primaria y/o de 846 Mtep de energía final.', null, '2087c8e3d3fc7d198f56263443bd1958251f40903c9cb3f9d5f01933f93f0529', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2087c8e3d3fc7d198f56263443bd1958251f40903c9cb3f9d5f01933f93f0529')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1 128 Mtep de energía primaria y/o 846 Mtep de energía final.', true), ('B', '1 483 Mtep de energía primaria y/o 1 086 Mtep de energía final.', false), ('C', '846 Mtep de energía primaria y/o 1 128 Mtep de energía final.', false), ('D', '1 086 Mtep de energía primaria y/o 846 Mtep de energía final.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 5 de la Directiva 2012/27/UE, a partir del 1 de enero de 2014, cada año deberá renovarse, para cumplir los requisitos mínimos de rendimiento energético, el siguiente porcentaje de la superficie total de los edificios con calefacción y/o refrigeración que tenga en propiedad y ocupe la Administración central:', 'El art. 5.1 («Función ejemplarizante de los edificios de los organismos públicos») impone renovar cada año el 3 % de esa superficie. El 1,5 % es la tasa de ahorro anual del art. 7.1.a). (Directiva derogada desde el 12 de octubre de 2025 por la Directiva (UE) 2023/1791.)', 'gc_16b_eficiencia_energetica', (select id from public.topics where slug = 'gc-16b-eficiencia-energetica'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504'), 'Art. 5.1 Directiva 2012/27/UE', 'cada uno de los Estados miembros se asegurará de que, a partir del 1 de enero de 2014, el 3 % de la superficie total de los edificios con calefacción y/o sistema de refrigeración que tenga en propiedad y ocupe su Administración central se renueve cada año', null, 'fc991f38fcfe9a39b10ee65cf01b465674100002cbab7a08516ec7f929342be1', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'fc991f38fcfe9a39b10ee65cf01b465674100002cbab7a08516ec7f929342be1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 1,5 %.', false), ('B', 'El 5 %.', false), ('C', 'El 10 %.', false), ('D', 'El 3 %.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Conforme al artículo 5 de la Directiva 2012/27/UE, el 3 % de renovación anual se calcula sobre la superficie total de los edificios de la Administración central con una superficie útil total de más de 500 m2, límite que bajó a partir del 9 de julio de 2015 a:', 'El art. 5.1 párrafo segundo rebaja el umbral de 500 m2 a 250 m2 a partir del 9 de julio de 2015; el mismo umbral rige para el inventario del art. 5.5. (Directiva derogada desde el 12 de octubre de 2025 por la Directiva (UE) 2023/1791.)', 'gc_16b_eficiencia_energetica', (select id from public.topics where slug = 'gc-16b-eficiencia-energetica'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504'), 'Art. 5.1 Directiva 2012/27/UE', 'Dicho límite bajará a 250 m2 a partir del 9 de julio de 2015.', null, 'be0904bd30e896fc04e7e23e0ea787a178efa3a1604c3b6a55e609ac67dfcf03', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'be0904bd30e896fc04e7e23e0ea787a178efa3a1604c3b6a55e609ac67dfcf03')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '300 m2.', false), ('B', '250 m2.', true), ('C', '100 m2.', false), ('D', '1 000 m2.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 5 de la Directiva 2012/27/UE, los Estados miembros podrán decidir no aplicar el requisito de renovación anual a:', 'El art. 5.2 permite excluir los edificios protegidos por su valor arquitectónico o histórico, los de defensa nacional (pero no los destinados solo a alojamiento ni las oficinas de las fuerzas armadas) y los lugares de culto. A los edificios con peor rendimiento se les debe dar prioridad (art. 5.1). (Directiva derogada desde el 12 de octubre de 2025 por la Directiva (UE) 2023/1791.)', 'gc_16b_eficiencia_energetica', (select id from public.topics where slug = 'gc-16b-eficiencia-energetica'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504'), 'Art. 5.2 Directiva 2012/27/UE', 'c) edificios utilizados como lugares de culto y para actividades religiosas.', null, '23d798bc3148b7c17e1957d38a4992cd21d2858dc3dd53759c6856accfc1913b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '23d798bc3148b7c17e1957d38a4992cd21d2858dc3dd53759c6856accfc1913b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Los edificios utilizados como lugares de culto y para actividades religiosas.', true), ('B', 'Los edificios de oficinas de las fuerzas armadas.', false), ('C', 'Los edificios destinados a viviendas sociales.', false), ('D', 'Los edificios de la Administración central con peor rendimiento energético.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 5 de la Directiva 2012/27/UE, si un Estado miembro renueva en un año más del 3 % de la superficie total de los edificios de la Administración central:', 'El art. 5.3 permite trasladar el exceso de renovación a cualquiera de los tres años anteriores o siguientes. El art. 5.4 permite contabilizar edificios nuevos que sustituyan a otros demolidos en los dos años anteriores. (Directiva derogada desde el 12 de octubre de 2025 por la Directiva (UE) 2023/1791.)', 'gc_16b_eficiencia_energetica', (select id from public.topics where slug = 'gc-16b-eficiencia-energetica'), 3, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504'), 'Art. 5.3 Directiva 2012/27/UE', 'Si un Estado miembro renueva en un año determinado más del 3 % de la superficie total de los edificios de la Administración central, podrá computar el exceso en el índice de renovación anual de cualquiera de los tres años anteriores o siguientes.', null, '233abcbb0f3d3e8373c134ffdfac23c952da8bf946b533c3f2a880f9c3d9fe9b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '233abcbb0f3d3e8373c134ffdfac23c952da8bf946b533c3f2a880f9c3d9fe9b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Podrá computar el exceso únicamente en el año siguiente.', false), ('B', 'Podrá computar el exceso en cualquiera de los cinco años siguientes.', false), ('C', 'Podrá computar el exceso en el índice de renovación anual de cualquiera de los tres años anteriores o siguientes.', true), ('D', 'No podrá computar el exceso, pues la obligación es estrictamente anual.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 6 de la Directiva 2012/27/UE, los Estados miembros garantizarán que las Administraciones centrales:', 'El art. 6.1 impone a las Administraciones centrales la adquisición de productos, servicios y edificios de alto rendimiento energético con los límites del anexo III; la obligación no se aplica a los contratos de suministro de equipo militar (art. 6.2). (Directiva derogada desde el 12 de octubre de 2025 por la Directiva (UE) 2023/1791.)', 'gc_16b_eficiencia_energetica', (select id from public.topics where slug = 'gc-16b-eficiencia-energetica'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504'), 'Art. 6.1 Directiva 2012/27/UE', 'Los Estados miembros garantizarán que las Administraciones centrales adquieran solamente productos, servicios y edificios que tengan un alto rendimiento energético, en la medida en que ello sea coherente con la rentabilidad, la viabilidad económica, la sostenibilidad en un sentido más amplio, la idoneidad técnica, así como una competencia suficiente', null, '2a358f0fa015f59c9a679d415b32c8cce0a9270458afb7f690afc54761c49ebe', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2a358f0fa015f59c9a679d415b32c8cce0a9270458afb7f690afc54761c49ebe')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Adquieran solamente productos con la etiqueta energética de clase A, sin excepciones.', false), ('B', 'Adquieran productos de alto rendimiento energético únicamente en los contratos de suministro de equipo militar.', false), ('C', 'Den preferencia a los productos de alto rendimiento energético solo cuando no supongan un coste mayor.', false), ('D', 'Adquieran solamente productos, servicios y edificios que tengan un alto rendimiento energético, en la medida en que sea coherente con la rentabilidad, la viabilidad económica, la sostenibilidad, la idoneidad técnica y una competencia suficiente.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 7 de la Directiva 2012/27/UE, desde el 1 de enero de 2021 hasta el 31 de diciembre de 2030 los Estados miembros (salvo Chipre y Malta) deberán conseguir cada año un nuevo ahorro equivalente al:', 'El art. 7.1.b) fija para 2021-2030 un nuevo ahorro anual del 0,8 % del consumo de energía final (0,24 % para Chipre y Malta); el 1,5 % de las ventas era la obligación del período 2014-2020 (art. 7.1.a). (Directiva derogada desde el 12 de octubre de 2025 por la Directiva (UE) 2023/1791.)', 'gc_16b_eficiencia_energetica', (select id from public.topics where slug = 'gc-16b-eficiencia-energetica'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504'), 'Art. 7.1.b) Directiva 2012/27/UE', 'b) la consecución de un nuevo ahorro cada año, desde el 1 de enero de 2021 hasta el 31 de diciembre de 2030, del 0,8 % del consumo anual de energía final, como promedio de los últimos tres años previos al 1 de enero de 2019.', null, 'ac25a5e0941d0c2ac025214962b081145568611f99bb978cd90558a5ab2f64ee', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ac25a5e0941d0c2ac025214962b081145568611f99bb978cd90558a5ab2f64ee')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1,5 % de las ventas anuales de energía a clientes finales, como promedio de los últimos tres años previos al 1 de enero de 2013.', false), ('B', '0,8 % del consumo anual de energía final, como promedio de los últimos tres años previos al 1 de enero de 2019.', true), ('C', '0,24 % del consumo anual de energía final, como promedio de los últimos tres años previos al 1 de enero de 2019.', false), ('D', '3 % del consumo anual de energía primaria, como promedio de los últimos cinco años.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 8 de la Directiva 2012/27/UE, las empresas que no sean PYME deben someterse a una auditoría energética como mínimo:', 'El art. 8.4 obliga a las empresas que no sean PYME a una primera auditoría a más tardar el 5 de diciembre de 2015 y, después, como mínimo cada cuatro años. (Directiva derogada desde el 12 de octubre de 2025 por la Directiva (UE) 2023/1791.)', 'gc_16b_eficiencia_energetica', (select id from public.topics where slug = 'gc-16b-eficiencia-energetica'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504'), 'Art. 8.4 Directiva 2012/27/UE', 'a más tardar el 5 de diciembre de 2015, y como mínimo cada cuatro años a partir de la fecha de la auditoría energética anterior.', null, '42a3833e3421e7bdb184a211989ebe92606ab556da7d3f74f78db8063b7a2d2b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '42a3833e3421e7bdb184a211989ebe92606ab556da7d3f74f78db8063b7a2d2b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cada año.', false), ('B', 'Cada cuatro años a partir de la fecha de la auditoría energética anterior.', true), ('C', 'Cada dos años.', false), ('D', 'Cada diez años.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 8 de la Directiva 2012/27/UE, quedan eximidas de la auditoría energética obligatoria las empresas que no sean PYME y que:', 'El art. 8.6 exime de la obligación del apartado 4 a las grandes empresas con un sistema de gestión energética o ambiental certificado por organismo independiente, siempre que incluya una auditoría energética conforme al anexo VI. (Directiva derogada desde el 12 de octubre de 2025 por la Directiva (UE) 2023/1791.)', 'gc_16b_eficiencia_energetica', (select id from public.topics where slug = 'gc-16b-eficiencia-energetica'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504'), 'Art. 8.6 Directiva 2012/27/UE', 'Se eximirá del cumplimiento de los requisitos establecidos en el apartado 4 a aquellas empresas que no sean PYME y que apliquen un sistema de gestión energética o ambiental —certificado por un organismo independiente con arreglo a las normas europeas o internacionales correspondientes—', null, '8f4f939f1983368a06ff4e9ba05836cf99c82cea8cb0bc687bc729e828776ea0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8f4f939f1983368a06ff4e9ba05836cf99c82cea8cb0bc687bc729e828776ea0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tengan un consumo de energía inferior al de la media de su sector.', false), ('B', 'Hayan celebrado un contrato de rendimiento energético con un proveedor de servicios energéticos.', false), ('C', 'Hayan sido auditadas en los diez años anteriores.', false), ('D', 'Apliquen un sistema de gestión energética o ambiental certificado por un organismo independiente que incluya una auditoría energética conforme a los criterios mínimos del anexo VI.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 9 quater de la Directiva 2012/27/UE, los contadores y repartidores de costes de calefacción ya instalados que no sean de lectura remota se dotarán de lectura remota o serán sustituidos, salvo que no resulte rentable, a más tardar:', 'El art. 9 quater exige que los contadores instalados después del 25 de octubre de 2020 sean de lectura remota (apartado 1) y que los ya instalados se adapten o sustituyan a más tardar el 1 de enero de 2027 (apartado 2), salvo que el Estado demuestre que no es rentable. (Directiva derogada desde el 12 de octubre de 2025 por la Directiva (UE) 2023/1791.)', 'gc_16b_eficiencia_energetica', (select id from public.topics where slug = 'gc-16b-eficiencia-energetica'), 3, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504'), 'Art. 9 quater.2 Directiva 2012/27/UE', 'Los contadores y repartidores de costes de calefacción que no sean de lectura remota pero que ya estén instalados se dotarán de lectura remota o serán sustituidos por dispositivos de lectura remota a más tardar el 1 de enero de 2027', null, 'ba82816fe153748cd6bb10946ddede0458a2ccf157be2ec1583c483e3c607e01', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ba82816fe153748cd6bb10946ddede0458a2ccf157be2ec1583c483e3c607e01')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El 1 de enero de 2027.', true), ('B', 'El 25 de octubre de 2020.', false), ('C', 'El 31 de diciembre de 2030.', false), ('D', 'El 1 de enero de 2025.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 38 de la Directiva (UE) 2023/1791, relativa a la eficiencia energética (versión refundida), la Directiva 2012/27/UE:', 'El art. 38 de la Directiva (UE) 2023/1791 deroga la Directiva 2012/27/UE con efectos desde el 12 de octubre de 2025; las referencias a la Directiva derogada se entienden hechas a la nueva según la tabla de correspondencias del anexo XVII. El 30 de junio de 2024 es la fecha de aplicación del art. 37 de la nueva Directiva (art. 39).', 'gc_16b_eficiencia_energetica', (select id from public.topics where slug = 'gc-16b-eficiencia-energetica'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504'), 'Art. 38 Directiva (UE) 2023/1791', 'Queda derogada con efectos a partir del 12 de octubre de 2025 la Directiva 2012/27/UE', null, '95c757bff8f5ced2b4bd2715175c8cac3e930969d72320ba8a1798862a913f68', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '95c757bff8f5ced2b4bd2715175c8cac3e930969d72320ba8a1798862a913f68')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Queda derogada con efectos a partir del 1 de enero de 2024.', false), ('B', 'Sigue en vigor en sus capítulos I y II y solo se derogan los demás capítulos.', false), ('C', 'Queda derogada con efectos a partir del 12 de octubre de 2025.', true), ('D', 'Queda derogada con efectos a partir del 30 de junio de 2024.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-17b-ciberseguridad-ccn-cert-ccn_cert-v1 (9 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('CCN-CERT · Sobre nosotros (Misión y Objetivos, Servicios, FAQ)', 'https://www.ccn-cert.cni.es/es/sobre-nosotros/mision-y-objetivos.html', 'web_oficial'::public.source_kind, 'Centro Criptológico Nacional, CCN-CERT (web oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-17b-ciberseguridad-ccn-cert', 'Tema 17. Ciberseguridad: CCN-CERT') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-17b-ciberseguridad-ccn-cert' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según su web oficial, el CCN-CERT es:', 'El CCN-CERT es la Capacidad de Respuesta a Incidentes de Seguridad de la Información del Centro Criptológico Nacional (CCN), creada en 2006 como CERT Gubernamental Nacional español.', 'gc_17b_ciberseguridad_ccn_cert', (select id from public.topics where slug = 'gc-17b-ciberseguridad-ccn-cert'), 1, 'es', true, (select id from public.sources where url = 'https://www.ccn-cert.cni.es/es/sobre-nosotros/mision-y-objetivos.html'), 'CCN-CERT, Misión y Objetivos', 'El CCN-CERT es la Capacidad de Respuesta a Incidentes de Seguridad de la Información del Centro Criptológico Nacional, CCN.', null, 'f1e38855fc80a5007fbe4753823257ce11f877d2ee44e6592334f21d73344136', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f1e38855fc80a5007fbe4753823257ce11f877d2ee44e6592334f21d73344136')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Capacidad de Respuesta a Incidentes de Seguridad de la Información del Centro Criptológico Nacional.', true), ('B', 'El Centro de Operaciones de Ciberseguridad de la Guardia Civil.', false), ('C', 'La Agencia de la Unión Europea para la Ciberseguridad en España.', false), ('D', 'El órgano de la Agencia Española de Protección de Datos encargado de las brechas de seguridad.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según su web oficial, el CCN-CERT se creó como CERT Gubernamental Nacional español en el año:', 'El CCN-CERT se creó en 2006 en el seno del CCN. 2002 es el año de la Ley 11/2002 del CNI, 2004 el del RD 421/2004 que regula el CCN y 2010 el del primer Esquema Nacional de Seguridad.', 'gc_17b_ciberseguridad_ccn_cert', (select id from public.topics where slug = 'gc-17b-ciberseguridad-ccn-cert'), 1, 'es', true, (select id from public.sources where url = 'https://www.ccn-cert.cni.es/es/sobre-nosotros/mision-y-objetivos.html'), 'CCN-CERT, creación', 'Este servicio se creó en el año 2006 como CERT Gubernamental Nacional español', null, '6e0f7ddbdb019b8d1bfe904c56690a2c32198ed6f67921c66157afaca504cfd0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6e0f7ddbdb019b8d1bfe904c56690a2c32198ed6f67921c66157afaca504cfd0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '2002.', false), ('B', '2004.', false), ('C', '2006.', true), ('D', '2010.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web del CCN-CERT, el término CERT proviene de las siglas en inglés de:', 'CERT significa Computer Emergency Response Team; también se conoce como CSIRT (Computer Security and Incident Response Team).', 'gc_17b_ciberseguridad_ccn_cert', (select id from public.topics where slug = 'gc-17b-ciberseguridad-ccn-cert'), 1, 'es', true, (select id from public.sources where url = 'https://www.ccn-cert.cni.es/es/sobre-nosotros/mision-y-objetivos.html'), 'CCN-CERT, FAQ (qué es un CERT)', 'El término CERT proviene de las siglas en inglés Computer Emergency Response Team', null, '00ff5fbd2af38962d5c0d2d511f16776d84e12fc50255a4d90ced14eaf9cee4b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '00ff5fbd2af38962d5c0d2d511f16776d84e12fc50255a4d90ced14eaf9cee4b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cyber Emergency Risk Team.', false), ('B', 'Computer Encryption and Recovery Team.', false), ('C', 'Computer Emergency Response Team.', true), ('D', 'Centre for Electronic Response and Tracking.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web del CCN-CERT, las Administraciones Públicas, en cumplimiento del Esquema Nacional de Seguridad, deben notificar al CCN-CERT los incidentes catalogados con un nivel de peligrosidad:', 'La FAQ del CCN-CERT (con remisión a la Guía CCN-STIC 817) establece la notificación obligatoria de los incidentes de peligrosidad Alto, Muy Alto y Crítico.', 'gc_17b_ciberseguridad_ccn_cert', (select id from public.topics where slug = 'gc-17b-ciberseguridad-ccn-cert'), 2, 'es', true, (select id from public.sources where url = 'https://www.ccn-cert.cni.es/es/sobre-nosotros/mision-y-objetivos.html'), 'CCN-CERT, FAQ (notificación obligatoria)', 'deben notificar al CCN-CERT todos aquellos incidentes que sean catalogados con un nivel de peligrosidad de Alto, Muy Alto y Crítico.', null, '32708dd58acb2eb60620175988c4a09a5e9449e76eab8d8c8f6eda58753158d0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '32708dd58acb2eb60620175988c4a09a5e9449e76eab8d8c8f6eda58753158d0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Bajo, Medio y Alto.', false), ('B', 'Únicamente Crítico.', false), ('C', 'Cualquier nivel, sin excepción.', false), ('D', 'Alto, Muy Alto y Crítico.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web del CCN-CERT, el primer CERT se creó en 1988 en:', 'El primer CERT nació en 1988 en la Universidad Carnegie Mellon, propietaria de la marca registrada, que autorizó al CCN-CERT a utilizarla.', 'gc_17b_ciberseguridad_ccn_cert', (select id from public.topics where slug = 'gc-17b-ciberseguridad-ccn-cert'), 2, 'es', true, (select id from public.sources where url = 'https://www.ccn-cert.cni.es/es/sobre-nosotros/mision-y-objetivos.html'), 'CCN-CERT, FAQ (primer CERT)', 'El primer CERT se creó en 1988 en la Universidad Carnegie Mellon, en Estados Unidos', null, '33dda000ee0226ac1af086b366d18317389b77d7572439077ea9162abf36f7b8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '33dda000ee0226ac1af086b366d18317389b77d7572439077ea9162abf36f7b8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Instituto Tecnológico de Massachusetts (MIT), en Estados Unidos.', false), ('B', 'La Universidad de Cambridge, en el Reino Unido.', false), ('C', 'La Universidad Carnegie Mellon, en Estados Unidos.', true), ('D', 'La sede de la OTAN en Bruselas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web oficial del CCN-CERT, en el caso de operadores críticos del sector público, la gestión de ciberincidentes la realizará el CCN-CERT en coordinación con:', 'Es competencia del CCN-CERT la gestión de ciberincidentes que afecten a cualquier organismo o empresa pública; si se trata de operadores críticos del sector público, en coordinación con el CNPIC.', 'gc_17b_ciberseguridad_ccn_cert', (select id from public.topics where slug = 'gc-17b-ciberseguridad-ccn-cert'), 2, 'es', true, (select id from public.sources where url = 'https://www.ccn-cert.cni.es/es/sobre-nosotros/mision-y-objetivos.html'), 'CCN-CERT, Misión (operadores críticos)', 'En el caso de operadores críticos del sector público la gestión de ciberincidentes se realizará por el CCN-CERT en coordinación con el CNPIC.', null, 'a8c45e5a8e2e9dc87ee10ce8b916e89b5bc63a353abd76faba8fadeb8078975f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a8c45e5a8e2e9dc87ee10ce8b916e89b5bc63a353abd76faba8fadeb8078975f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El CNPIC.', true), ('B', 'El INCIBE-CERT.', false), ('C', 'La Agencia Española de Protección de Datos.', false), ('D', 'El Mando Conjunto del Ciberespacio.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web del CCN-CERT, ¿a qué comunidad ofrece sus servicios el CCN-CERT?', 'El CCN-CERT presta servicio a las Administraciones Públicas, a los sistemas clasificados y a las empresas de interés estratégico, aunque buena parte de sus servicios (formación, informes, guías, herramientas) son de libre disposición en su portal.', 'gc_17b_ciberseguridad_ccn_cert', (select id from public.topics where slug = 'gc-17b-ciberseguridad-ccn-cert'), 2, 'es', true, (select id from public.sources where url = 'https://www.ccn-cert.cni.es/es/sobre-nosotros/mision-y-objetivos.html'), 'CCN-CERT, FAQ (comunidad)', '¿A qué Comunidad ofrece sus servicios CCN-CERT? Administraciones Públicas, sistemas clasificados y empresas de interés estratégico para el país.', null, 'd941abe1d51007590c96cafb21c8dec7f8378805ab47a8791c124ce36b1762c7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd941abe1d51007590c96cafb21c8dec7f8378805ab47a8791c124ce36b1762c7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Exclusivamente a la Administración General del Estado.', false), ('B', 'Administraciones Públicas, sistemas clasificados y empresas de interés estratégico para el país.', true), ('C', 'A ciudadanos, menores y empresas privadas de cualquier sector.', false), ('D', 'Exclusivamente a las Fuerzas Armadas y a las Fuerzas y Cuerpos de Seguridad del Estado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la web del CCN-CERT, ¿en qué capacidad de la OTAN participa el CCN-CERT, en la que los CERT de los países miembros analizan y comparten información sobre seguridad de la información?', 'El CCN-CERT participa en el NCIRC de la OTAN, en ENISA (UE), en el FIRST, en el Trusted Introducer de TERENA y en el EGC group, entre otros foros; solo el NCIRC pertenece a la OTAN.', 'gc_17b_ciberseguridad_ccn_cert', (select id from public.topics where slug = 'gc-17b-ciberseguridad-ccn-cert'), 3, 'es', true, (select id from public.sources where url = 'https://www.ccn-cert.cni.es/es/sobre-nosotros/mision-y-objetivos.html'), 'CCN-CERT, FAQ (foros internacionales)', 'NCIRC de la OTAN (NATO Computer Incident Response Capability), en las que los distintos CERTs de los países miembros de esta Organización analizan y comparten información sobre seguridad de la información.', null, 'c2c17a9589f51a8718c8f48eff409083268e883161088dbc562febe569ac579b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c2c17a9589f51a8718c8f48eff409083268e883161088dbc562febe569ac579b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'NCIRC (NATO Computer Incident Response Capability).', true), ('B', 'EGC (European Government CERTs).', false), ('C', 'FIRST (Forum of Incident Response and Security Teams).', false), ('D', 'ENISA (European Network & Information Security Agency).', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la página de Misión y Objetivos del CCN-CERT, sus funciones quedan recogidas en la Ley 11/2002, reguladora del Centro Nacional de Inteligencia, en el Real Decreto 421/2004 y en:', 'La página de Misión cita el vigente RD 311/2022 (Esquema Nacional de Seguridad), que sustituyó al RD 3/2010 aún mencionado en la FAQ. El RD 4/2010 es el Esquema Nacional de Interoperabilidad.', 'gc_17b_ciberseguridad_ccn_cert', (select id from public.topics where slug = 'gc-17b-ciberseguridad-ccn-cert'), 3, 'es', true, (select id from public.sources where url = 'https://www.ccn-cert.cni.es/es/sobre-nosotros/mision-y-objetivos.html'), 'CCN-CERT, Misión (normativa)', 'sus funciones quedan recogidas en la Ley 11/2002 reguladora del Centro Nacional de Inteligencia, el RD 421/2004 de regulación del CCN y en el RD 311/2022, de 3 de mayo, que regula el Esquema Nacional de Seguridad.', null, '1b8ee360774c94a42779b414b1c1bdce9449b2d50040f11ecffa0798df067cd8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1b8ee360774c94a42779b414b1c1bdce9449b2d50040f11ecffa0798df067cd8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Real Decreto 4/2010, de 8 de enero, que regula el Esquema Nacional de Interoperabilidad.', false), ('B', 'La Ley 6/2020, de 11 de noviembre, reguladora de determinados aspectos de los servicios electrónicos de confianza.', false), ('C', 'El Real Decreto 806/2014, de 19 de septiembre, sobre organización e instrumentos operativos de las TIC en la AGE.', false), ('D', 'El Real Decreto 311/2022, de 3 de mayo, que regula el Esquema Nacional de Seguridad.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-17b-ciberseguridad-ccn-cert-ccn_rd421-v1 (11 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto 421/2004, de 12 de marzo, por el que se regula el Centro Criptológico Nacional (BOE-A-2004-5051)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-5051', 'web_oficial'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-17b-ciberseguridad-ccn-cert', 'Tema 17. Ciberseguridad: CCN-CERT') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-17b-ciberseguridad-ccn-cert' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 2.3 del Real Decreto 421/2004, el Centro Criptológico Nacional queda adscrito:', 'El CCN queda adscrito al CNI, comparte con él medios, procedimientos, normativa y recursos, y se rige por la Ley 11/2002.', 'gc_17b_ciberseguridad_ccn_cert', (select id from public.topics where slug = 'gc-17b-ciberseguridad-ccn-cert'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-5051'), 'Art. 2.3 RD 421/2004', 'El Centro Criptológico Nacional queda adscrito al Centro Nacional de Inteligencia y comparte con éste medios, procedimientos, normativa y recursos', null, 'b2e7661325aa7a458599e8d4923c1d6cb8e5534aba81d95274e36cc432367bdd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b2e7661325aa7a458599e8d4923c1d6cb8e5534aba81d95274e36cc432367bdd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Ministerio del Interior.', false), ('B', 'A la Secretaría de Estado de Digitalización e Inteligencia Artificial.', false), ('C', 'Al Estado Mayor de la Defensa.', false), ('D', 'Al Centro Nacional de Inteligencia.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 1 del Real Decreto 421/2004, ¿quién es el Director del Centro Criptológico Nacional?', 'El Secretario de Estado Director del CNI es, como Director del CCN, la autoridad responsable de coordinar la acción de los organismos de la Administración que utilicen medios o procedimientos de cifra.', 'gc_17b_ciberseguridad_ccn_cert', (select id from public.topics where slug = 'gc-17b-ciberseguridad-ccn-cert'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-5051'), 'Art. 1 RD 421/2004', 'El Secretario de Estado Director del Centro Nacional de Inteligencia, como Director del Centro Criptológico Nacional (CCN)', null, 'c7b6b7b3fd54c2ae35adc0256fe2813130eb6066943a115e1e3758952fb3652d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c7b6b7b3fd54c2ae35adc0256fe2813130eb6066943a115e1e3758952fb3652d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Ministro de Defensa.', false), ('B', 'El Secretario de Estado Director del Centro Nacional de Inteligencia.', true), ('C', 'El Secretario de Estado de Seguridad.', false), ('D', 'El Jefe del Estado Mayor de la Defensa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según su disposición final segunda, el Real Decreto 421/2004, por el que se regula el Centro Criptológico Nacional, entró en vigor:', 'La disposición final segunda fija la entrada en vigor el día siguiente al de su publicación (BOE de 19 de marzo de 2004).', 'gc_17b_ciberseguridad_ccn_cert', (select id from public.topics where slug = 'gc-17b-ciberseguridad-ccn-cert'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-5051'), 'Disp. final 2.ª RD 421/2004', 'El presente real decreto entrará en vigor el día siguiente al de su publicación en el «Boletín Oficial del Estado».', null, '2ef7816cef48a327e468ed23daf87eb4b76e6228368b56ca87dbb0a9c9ca0845', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2ef7816cef48a327e468ed23daf87eb4b76e6228368b56ca87dbb0a9c9ca0845')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A los veinte días de su publicación en el «Boletín Oficial del Estado».', false), ('B', 'El día siguiente al de su publicación en el «Boletín Oficial del Estado».', true), ('C', 'Al mes de su publicación en el «Boletín Oficial del Estado».', false), ('D', 'El mismo día de su publicación en el «Boletín Oficial del Estado».', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 1 del Real Decreto 421/2004, el Director del Centro Criptológico Nacional es:', 'El art. 1 RD 421/2004 configura al Director del CCN como autoridad de certificación de la seguridad de las TIC y autoridad de certificación criptológica, y le encarga velar por la normativa de protección de la información clasificada en los sistemas de información y telecomunicaciones.', 'gc_17b_ciberseguridad_ccn_cert', (select id from public.topics where slug = 'gc-17b-ciberseguridad-ccn-cert'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-5051'), 'Art. 1 RD 421/2004 (autoridad de certificación)', 'En este sentido, el Director del CCN es la autoridad de certificación de la seguridad de las tecnologías de la información y autoridad de certificación criptológica.', null, 'b9584fcb470558e55c4e8dd65f619bbd6673326183ed952fe804ff7598364019', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b9584fcb470558e55c4e8dd65f619bbd6673326183ed952fe804ff7598364019')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La autoridad de control en materia de protección de datos de las Administraciones públicas.', false), ('B', 'El órgano de supervisión de los prestadores cualificados de servicios electrónicos de confianza.', false), ('C', 'La autoridad de gestión de las comunicaciones móviles gubernamentales.', false), ('D', 'La autoridad de certificación de la seguridad de las tecnologías de la información y autoridad de certificación criptológica.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 2.1 del Real Decreto 421/2004, el ámbito de actuación del Centro Criptológico Nacional comprende la seguridad de los sistemas de las tecnologías de la información:', 'El art. 2.1 delimita dos ámbitos: a) los sistemas TIC de la Administración con información electrónica que requiere protección y que incluyen medios de cifra, y b) los sistemas que tratan información clasificada.', 'gc_17b_ciberseguridad_ccn_cert', (select id from public.topics where slug = 'gc-17b-ciberseguridad-ccn-cert'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-5051'), 'Art. 2.1 RD 421/2004', 'a) La seguridad de los sistemas de las tecnologías de la información de la Administración que procesan, almacenan o transmiten información en formato electrónico, que normativamente requieren protección, y que incluyen medios de cifra. b) La seguridad de los sistemas de las tecnologías de la información que procesan, almacenan o transmiten información clasificada.', null, '86aed290b5105e81ddc31a36522176a8237529042780a3779fd83ad5ae3aa954', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '86aed290b5105e81ddc31a36522176a8237529042780a3779fd83ad5ae3aa954')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De la Administración que procesan, almacenan o transmiten información en formato electrónico que normativamente requieren protección e incluyen medios de cifra, y de los que procesan, almacenan o transmiten información clasificada.', true), ('B', 'De todas las empresas privadas que prestan servicios esenciales, exclusivamente.', false), ('C', 'De la Administración General del Estado, con exclusión de los que manejan información clasificada.', false), ('D', 'De los ciudadanos y empresas que lo soliciten, a cambio de una tasa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 2.2 del Real Decreto 421/2004, entre las funciones del Centro Criptológico Nacional figura:', 'El art. 2.2.c) atribuye al CCN constituir el organismo de certificación del Esquema nacional de evaluación y certificación de la seguridad de las TI, aplicable a productos y sistemas en su ámbito.', 'gc_17b_ciberseguridad_ccn_cert', (select id from public.topics where slug = 'gc-17b-ciberseguridad-ccn-cert'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-5051'), 'Art. 2.2.c) RD 421/2004', 'c) Constituir el organismo de certificación del Esquema nacional de evaluación y certificación de la seguridad de las tecnologías de información, de aplicación a productos y sistemas en su ámbito.', null, '21721cd0083d739978b0fb4446d855b1c20dc6bff90f1b00d5ecd9bf4c1a71fe', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '21721cd0083d739978b0fb4446d855b1c20dc6bff90f1b00d5ecd9bf4c1a71fe')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Expedir el Documento Nacional de Identidad electrónico.', false), ('B', 'Constituir el organismo de certificación del Esquema nacional de evaluación y certificación de la seguridad de las tecnologías de información.', true), ('C', 'Investigar y perseguir los delitos informáticos cometidos contra la Administración.', false), ('D', 'Imponer sanciones por incumplimiento del Esquema Nacional de Seguridad.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 2.2 del Real Decreto 421/2004, ¿a quién corresponde formar al personal de la Administración especialista en el campo de la seguridad de los sistemas de las tecnologías de la información y las comunicaciones?', 'El art. 2.2.b) encomienda al CCN formar al personal de la Administración especialista en seguridad de los sistemas TIC; también el art. 1 menciona entre las responsabilidades del Director del CCN formar al personal especialista.', 'gc_17b_ciberseguridad_ccn_cert', (select id from public.topics where slug = 'gc-17b-ciberseguridad-ccn-cert'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-5051'), 'Art. 2.2.b) RD 421/2004', 'b) Formar al personal de la Administración especialista en el campo de la seguridad de los sistemas de las tecnologías de la información y las comunicaciones.', null, 'ba661597aef5a8be6fd3f2ffd8b12d84ccfba17338bffc66890cf9d295831f63', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ba661597aef5a8be6fd3f2ffd8b12d84ccfba17338bffc66890cf9d295831f63')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Instituto Nacional de Administración Pública, en exclusiva.', false), ('B', 'A la Agencia Española de Protección de Datos.', false), ('C', 'Al Centro Criptológico Nacional.', true), ('D', 'Al Instituto Nacional de Ciberseguridad.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el preámbulo del Real Decreto 421/2004, la seguridad de los sistemas de información debe garantizar, respecto de la información que manejan:', 'El preámbulo indica que la seguridad no solo abarca la confidencialidad: debe garantizar la confidencialidad, disponibilidad e integridad de la información y la disponibilidad e integridad de los propios sistemas.', 'gc_17b_ciberseguridad_ccn_cert', (select id from public.topics where slug = 'gc-17b-ciberseguridad-ccn-cert'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-5051'), 'Preámbulo RD 421/2004', 'En consecuencia, la seguridad de los sistemas de información debe garantizar la confidencialidad, la disponibilidad y la integridad de la información que manejan y la disponibilidad y la integridad de los propios sistemas.', null, '56f8a7dd3c9a2c7eea81d85081986883d8635dfdc1ad74ec71cb8207668d3a7e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '56f8a7dd3c9a2c7eea81d85081986883d8635dfdc1ad74ec71cb8207668d3a7e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La confidencialidad, la disponibilidad y la integridad.', true), ('B', 'Únicamente la confidencialidad.', false), ('C', 'La autenticidad, la trazabilidad y el no repudio.', false), ('D', 'La confidencialidad y la legalidad.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el preámbulo del Real Decreto 421/2004, ¿qué precepto de la Ley 11/2002, reguladora del Centro Nacional de Inteligencia, confiere a su Secretario de Estado Director la responsabilidad de dirigir el Centro Criptológico Nacional?', 'La Ley 11/2002 encomienda al CNI la seguridad de las tecnologías de la información (art. 4.e) y la protección de la información clasificada (art. 4.f), y confiere a su Secretario de Estado Director la dirección del CCN (art. 9.2.f). El RD se dicta en virtud de su disposición final primera.', 'gc_17b_ciberseguridad_ccn_cert', (select id from public.topics where slug = 'gc-17b-ciberseguridad-ccn-cert'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-5051'), 'Preámbulo RD 421/2004 (Ley 11/2002)', 'a la vez que confiere a su Secretario de Estado Director la responsabilidad de dirigir el Centro Criptológico Nacional en su artículo 9.2.f).', null, '3857cf8d5fd9f6943d48c03be4cad3210fbd2e22d7a9301001f309f5cd78d592', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3857cf8d5fd9f6943d48c03be4cad3210fbd2e22d7a9301001f309f5cd78d592')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El artículo 4.e).', false), ('B', 'El artículo 4.f).', false), ('C', 'La disposición final primera.', false), ('D', 'El artículo 9.2.f).', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 2.2 del Real Decreto 421/2004, para el desarrollo de sus funciones el Centro Criptológico Nacional puede:', 'El art. 2.2.g) permite al CCN establecer relaciones y firmar acuerdos con organizaciones similares de otros países. El desarrollo reglamentario corresponde al Ministro de Defensa (disposición final primera).', 'gc_17b_ciberseguridad_ccn_cert', (select id from public.topics where slug = 'gc-17b-ciberseguridad-ccn-cert'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-5051'), 'Art. 2.2.g) RD 421/2004', 'g) Establecer las necesarias relaciones y firmar los acuerdos pertinentes con organizaciones similares de otros países, para el desarrollo de las funciones mencionadas.', null, '47ecb7ed85cf4a9adf5a1da2f338608d2e407d880454daf597c8cb0fd6242e7f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '47ecb7ed85cf4a9adf5a1da2f338608d2e407d880454daf597c8cb0fd6242e7f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Celebrar tratados internacionales en nombre del Reino de España.', false), ('B', 'Dictar reales decretos de desarrollo del Esquema Nacional de Seguridad.', false), ('C', 'Establecer las necesarias relaciones y firmar los acuerdos pertinentes con organizaciones similares de otros países.', true), ('D', 'Imponer a las empresas privadas el uso obligatorio de sus productos de cifra.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 2.3 del Real Decreto 421/2004, el personal del Centro Criptológico Nacional:', 'El personal del CCN está integrado orgánica y funcionalmente en el CNI y le es de aplicación la Ley 11/2002 y su normativa de desarrollo, especialmente el régimen estatutario.', 'gc_17b_ciberseguridad_ccn_cert', (select id from public.topics where slug = 'gc-17b-ciberseguridad-ccn-cert'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-5051'), 'Art. 2.3 RD 421/2004 (personal)', 'El personal del CCN estará integrado orgánica y funcionalmente en el Centro Nacional de Inteligencia, por lo que le serán de aplicación todas las disposiciones relativas al personal de éste', null, '68bf1f6ad9c060026c1fffa3d3b5bf8f28192b8a8b5228252cc8ab5dda58116b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '68bf1f6ad9c060026c1fffa3d3b5bf8f28192b8a8b5228252cc8ab5dda58116b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Es personal funcionario del Ministerio de Defensa, sujeto al régimen general de la función pública.', false), ('B', 'Está integrado orgánica y funcionalmente en el Centro Nacional de Inteligencia, y le son de aplicación las disposiciones relativas al personal de este, particularmente su régimen estatutario.', true), ('C', 'Es personal laboral contratado directamente por el Centro Criptológico Nacional.', false), ('D', 'Está integrado en el Ministerio del Interior, salvo su Director.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-18-topografia-ign_amigomapa-v1 (18 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Instituto Geográfico Nacional · Tu amigo el mapa (F. Aranaz del Río, 6.ª ed., 2019)', 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf', 'web_oficial'::public.source_kind, 'Instituto Geográfico Nacional (IGN-CNIG)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-18-topografia', 'Tema 18. Topografía') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-18-topografia' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según la publicación «Tu amigo el mapa» del IGN, la proyección UTM se desarrolla para husos de:', 'La UTM divide la Tierra en 60 husos de 6° (60 × 6° = 360°), numerados desde el antimeridiano (180°) hacia el este.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf'), 'Tu amigo el mapa, cap. 8', 'La proyección se desarrolla para husos de 6° de amplitud (numerados del 1 al 60 a partir del meridiano 180° hacia el este).', null, '6486f358f6933409969aa515ed03aa7506f758294c93664cebc98fe95b091fb2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6486f358f6933409969aa515ed03aa7506f758294c93664cebc98fe95b091fb2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '6° de amplitud, numerados del 1 al 60 a partir del meridiano de Greenwich hacia el oeste.', false), ('B', '6° de amplitud, numerados del 1 al 60 a partir del meridiano 180° hacia el este.', true), ('C', '3° de amplitud, numerados del 1 al 120 a partir del meridiano 180° hacia el este.', false), ('D', '10° de amplitud, numerados del 1 al 36 a partir del meridiano de Greenwich hacia el este.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'España queda comprendida en los husos UTM 28, 29, 30 y 31. ¿Qué huso abarca de los 6° W a los 0° (meridiano de Greenwich)?', 'Según el IGN, el huso 28 va de 18° a 12° W, el 29 de 12° a 6° W, el 30 de 6° W a 0° y el 31 de 0° a 6° E.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 3, 'es', true, (select id from public.sources where url = 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf'), 'Tu amigo el mapa, cap. 8', 'España queda comprendida en los husos 28 (de 18° a 12° W), 29 (de 12° a 6° W), 30 (de 6°W a 0°) y 31 (de 0° a 6°E).', null, '4d511d7b89e4640a944d8243d7ea3cfa636974a79b7ee09a5321a2521412b140', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4d511d7b89e4640a944d8243d7ea3cfa636974a79b7ee09a5321a2521412b140')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El huso 29.', false), ('B', 'El huso 31.', false), ('C', 'El huso 28.', false), ('D', 'El huso 30.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'A diferencia de la proyección cilíndrica de Mercator, la proyección UTM (Universal Transversa Mercator) utiliza:', 'La UTM usa un cilindro transversal (eje en el plano del ecuador), tangente a la Tierra en el meridiano central de cada huso; es una proyección conforme. El plano tangente en el centro de cada hoja corresponde a la antigua proyección poliédrica.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf'), 'Tu amigo el mapa, cap. 8', 'La proyección UTM (Universal Transversa Mercator) utiliza un cilindro colocado transversalmente, esto es, con su eje situado en el plano del ecuador.', null, '115e2d801480fe35e98c3c71b0c7d6f6dd6ae1828befa37cffa9ec283f4c4382', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '115e2d801480fe35e98c3c71b0c7d6f6dd6ae1828befa37cffa9ec283f4c4382')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un cono tangente a la Tierra en un paralelo, con su eje coincidente con la línea de los polos.', false), ('B', 'Un plano tangente en el centro de cada hoja.', false), ('C', 'Un cilindro colocado transversalmente, con su eje situado en el plano del ecuador.', true), ('D', 'Un cilindro con su eje coincidente con la línea de los polos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el IGN, ¿qué norma hizo reglamentaria la proyección UTM para el Mapa Topográfico Nacional, en sustitución de la antigua proyección poliédrica?', 'El IGN indica que el Decreto 2.033/1970 hizo reglamentaria la UTM para el MTN, sustituyendo a la proyección poliédrica, que tenía problemas de case entre hojas.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 3, 'es', true, (select id from public.sources where url = 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf'), 'Tu amigo el mapa, cap. 8', 'donde el Decreto 2.033/1970 la hace reglamentaria para el Mapa Topográfico Nacional, sustituyendo a la antigua proyección poliédrica.', null, '8c57f73e2bb5334399b4f7c0154988597b68c02933b90a5c9278ac4c7520197d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8c57f73e2bb5334399b4f7c0154988597b68c02933b90a5c9278ac4c7520197d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Decreto 2.033/1970.', true), ('B', 'El Real Decreto 1071/2007.', false), ('C', 'La Ley 7/1986, de Ordenación de la Cartografía.', false), ('D', 'El Decreto de 1875 que publicó la hoja 559 (Madrid).', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En un mapa a escala 1:50.000, una línea de un centímetro equivale en el terreno a:', 'A escala 1:50.000, 1 cm del mapa son 50.000 cm en el terreno, es decir, 500 metros.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf'), 'Tu amigo el mapa, cap. 9', 'Entonces, a una línea de un centímetro en el mapa le corresponde en el terreno una longitud de 50.000 veces un centímetro, es decir, 500 metros.', null, '6d45aa069e90e5b4187d91977ebe683ccbb12ce77a1d897b308666bcb115a101', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6d45aa069e90e5b4187d91977ebe683ccbb12ce77a1d897b308666bcb115a101')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '50 metros.', false), ('B', '500 metros.', true), ('C', '5 kilómetros.', false), ('D', '5.000 metros cuadrados.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el IGN, la primera hoja del Mapa Topográfico Nacional a escala 1:50.000 se publicó en 1875 y correspondía a:', 'La primera hoja del MTN50 (número 559, Madrid) se publicó en 1875; en la primera década del siglo XXI se completó la edición digital de las 1076 hojas.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 3, 'es', true, (select id from public.sources where url = 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf'), 'Tu amigo el mapa, cap. 23', 'La primera hoja de este mapa (número 559, Madrid) se publicó en el año 1875.', null, '7e22c1efad352d7c75b16f2f0f12ef41e22d6236f9dac7e8a8d1882537fd10b1', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7e22c1efad352d7c75b16f2f0f12ef41e22d6236f9dac7e8a8d1882537fd10b1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La hoja número 1, Cabo de Peñas.', false), ('B', 'La hoja número 999, Huelva.', false), ('C', 'La hoja número 777, Mérida.', false), ('D', 'La hoja número 559, Madrid.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En relación con el Mapa Topográfico Nacional a escala 1:25.000, señale la respuesta correcta:', 'El MTN25 tiene la misma distribución de hojas que el MTN50: cada hoja se divide en cuatro cuartos (I-IV) del mismo tamaño que una hoja del MTN50; se hace desde su inicio en UTM y con equidistancia de 10 metros.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf'), 'Tu amigo el mapa, cap. 24', 'cada hoja de esta serie va a dar origen a cuatro nuevas hojas de la serie 1:25.000, cuartos I, II, III y IV', null, '690c2649567f59c7c8118009fa35d6105c08f91a7fc60fb85d7ed4fb9ac0c98b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '690c2649567f59c7c8118009fa35d6105c08f91a7fc60fb85d7ed4fb9ac0c98b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cada hoja del MTN 1:50.000 da origen a dos hojas de la serie 1:25.000, llamadas mitades norte y sur.', false), ('B', 'Se realizó inicialmente en proyección poliédrica y después pasó a UTM.', false), ('C', 'Cada hoja del MTN 1:50.000 da origen a cuatro hojas de la serie 1:25.000, llamadas cuartos I, II, III y IV.', true), ('D', 'Mantiene la equidistancia de 20 metros entre curvas de nivel del MTN 1:50.000.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En las hojas del Mapa Topográfico Nacional 1:50.000, las curvas de nivel (altimetría) se representan en color:', 'En el MTN50 el siena se reserva a las curvas de nivel; el negro a límites, caminos, ferrocarriles, toponimia y orografía; el azul a la hidrografía y el verde a carreteras autonómicas de segundo orden, cultivos y zonas forestales.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf'), 'Tu amigo el mapa, cap. 23', '• Siena: curvas de nivel (altimetría).', null, 'd1e86417bfc464a86e432500e4366f1747870640ff30ba5d15ebd2239e4e5c75', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd1e86417bfc464a86e432500e4366f1747870640ff30ba5d15ebd2239e4e5c75')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Negro.', false), ('B', 'Verde.', false), ('C', 'Siena.', true), ('D', 'Azul.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En la España peninsular, el origen o nivel cero de las curvas de nivel se fija en:', 'Las curvas de nivel unen puntos de igual altura respecto de un origen, que en la España peninsular es el nivel medio del mar en Alicante; en los archipiélagos cada isla tiene su propio origen de altitudes.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf'), 'Tu amigo el mapa, cap. 32', 'En la España peninsular este origen, nivel cero, se fija en el nivel medio del mar en Alicante.', null, '264b50c200198487f6554a8ad9b0a4a8a8ee634454c2839a5b1370248a86ba89', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '264b50c200198487f6554a8ad9b0a4a8a8ee634454c2839a5b1370248a86ba89')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El nivel medio del mar en Cádiz.', false), ('B', 'La Puerta del Sol de Madrid.', false), ('C', 'El nivel medio del mar Cantábrico en Santander.', false), ('D', 'El nivel medio del mar en Alicante.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el Mapa Topográfico Nacional a escala 1:50.000, la equidistancia entre curvas de nivel es de:', 'La equidistancia es de 20 m en el MTN50 y de 10 m en el MTN25 (en zonas muy llanas se llega a representar curvas cada 5 m).', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf'), 'Tu amigo el mapa, cap. 32', 'En el Mapa Topográfico Nacional a escala 1:50.000 la equidistancia entre curvas de nivel es de 20 metros.', null, 'c653d385303ff76a743fd9000f8ec6a44fe8e640252a2e5385e2b4d4e14189c3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c653d385303ff76a743fd9000f8ec6a44fe8e640252a2e5385e2b4d4e14189c3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '10 metros.', false), ('B', '20 metros.', true), ('C', '5 metros.', false), ('D', '50 metros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según «Tu amigo el mapa», en el Mapa Topográfico Nacional las curvas maestras o directoras, trazadas más gruesas para facilitar la lectura del mapa, aparecen:', 'En ambas escalas (1:50.000 y 1:25.000) cada cinco curvas se traza una más gruesa: cada 100 m en el MTN50 (5 × 20 m) y cada 50 m en el MTN25 (5 × 10 m).', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf'), 'Tu amigo el mapa, cap. 32', 'En ambos casos cada cinco curvas de nivel se traza una más gruesa (curvas maestras o directoras)', null, '3e57a2dd04adb2f526a4cd7203d20b8829bb95c1634bda211eda11123e75e55c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3e57a2dd04adb2f526a4cd7203d20b8829bb95c1634bda211eda11123e75e55c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cada cinco curvas de nivel.', true), ('B', 'Cada diez curvas de nivel.', false), ('C', 'Cada dos curvas de nivel.', false), ('D', 'Solo en las cumbres y picos montañosos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Una señal de tráfico que indica una pendiente del 10 % significa que:', 'La pendiente se calcula dividiendo la diferencia de altura entre dos puntos (Δh) por la distancia entre ellos (D); un 10 % equivale a 10 m de desnivel por cada 100 m.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf'), 'Tu amigo el mapa, cap. 33', 'esto significa que por cada 100 metros que recorremos hemos ascendido o descendido, según sea la dirección de la marcha, 10 metros.', null, '35eb3de93e21da883b88f605ced3b6af62ed291dab31528f99e3da2db3235c4e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '35eb3de93e21da883b88f605ced3b6af62ed291dab31528f99e3da2db3235c4e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por cada 10 metros recorridos se asciende o desciende 100 metros.', false), ('B', 'La carretera forma un ángulo de 10 grados con la horizontal.', false), ('C', 'Por cada 100 metros recorridos se asciende o desciende 10 metros.', true), ('D', 'Por cada kilómetro recorrido se asciende o desciende 10 metros.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En la técnica del sombreado utilizada para dar sensación de relieve, el mapa se presenta como si fuera la fotografía de una maqueta iluminada oblicuamente con el foco luminoso situado hacia el:', 'El IGN explica que el sombreado simula una maqueta iluminada oblicuamente con el foco hacia el Noroeste.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 3, 'es', true, (select id from public.sources where url = 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf'), 'Tu amigo el mapa, cap. 33', 'El mapa presenta una percepción visual como si se tratase de la fotografía de una maqueta iluminada oblicuamente con el foco luminoso situado hacia el Noroeste.', null, 'b191a909d7a912d9e21ef05fa8b1a79a117a63798c5c09269284becad1bc6e23', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b191a909d7a912d9e21ef05fa8b1a79a117a63798c5c09269284becad1bc6e23')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Noroeste.', true), ('B', 'Sureste.', false), ('C', 'Sur.', false), ('D', 'Este.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'El ángulo que forman la dirección que indica la brújula (norte magnético) y el norte verdadero se denomina:', 'La declinación magnética es el ángulo entre el norte magnético y el norte verdadero o geográfico; varía con el lugar y con el tiempo, por eso el MTN indica su valor y su variación anual.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf'), 'Tu amigo el mapa, cap. 74', 'Sabemos que la dirección que nos indica la brújula (norte magnético) y el norte verdadero forman un ángulo (declinación magnética) que varía con cada lugar y con el tiempo.', null, '85184092e49a3a1991fe3bc62ca82e378d31bcdf137e122b724f977abd30d368', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '85184092e49a3a1991fe3bc62ca82e378d31bcdf137e122b724f977abd30d368')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Convergencia de meridianos, y es constante en todo el territorio nacional.', false), ('B', 'Declinación magnética, y es constante en cada lugar.', false), ('C', 'Acimut, y solo varía con la latitud.', false), ('D', 'Declinación magnética, y varía con cada lugar y con el tiempo.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el mapa geomagnético que publica el Instituto Geográfico Nacional, las isógonas son:', 'Las isógonas unen puntos de igual declinación magnética; las de igual altitud son curvas de nivel y las de igual presión, isobaras.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf'), 'Tu amigo el mapa, cap. 74', 'Mapa geomagnético de isógonas (líneas que unen los puntos de igual declinación magnética)', null, '5aa79bb454c38ab80e01fbaa03e98d1649453242fe5d22d55daf6801ddc7aeda', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5aa79bb454c38ab80e01fbaa03e98d1649453242fe5d22d55daf6801ddc7aeda')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las líneas que unen los puntos de igual altitud.', false), ('B', 'Las líneas que unen los puntos de igual declinación magnética.', true), ('C', 'Las líneas que unen los puntos de igual presión atmosférica.', false), ('D', 'Las líneas que unen los puntos de igual latitud.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En las hojas del Mapa Topográfico Nacional a escalas 1:50.000 y 1:25.000, el gráfico con los datos sobre la declinación magnética y su variación figura en:', 'Todas las hojas del MTN50 y MTN25 llevan en el margen inferior, zona central, un gráfico con la declinación magnética y su variación anual referidas al centro de la hoja, valores que pueden tomarse como medios para toda la hoja.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 3, 'es', true, (select id from public.sources where url = 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf'), 'Tu amigo el mapa, cap. 74', 'llevan en su margen inferior, zona central, un gráfico con datos sobre la declinación magnética y su variación referidos al centro de la hoja', null, '190e32ddd6f93e05a309b8217c86da6169f144fc34298a63e149a464377315a6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '190e32ddd6f93e05a309b8217c86da6169f144fc34298a63e149a464377315a6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El margen superior derecho, con valores referidos a la esquina noroeste de la hoja.', false), ('B', 'La carátula o portadilla, con valores referidos a la capital de la provincia.', false), ('C', 'El margen inferior izquierdo, dentro de la leyenda de usos del suelo.', false), ('D', 'El margen inferior, zona central, con valores referidos al centro de la hoja.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el IGN, la línea loxodrómica que describían los navíos en alta mar se caracteriza por:', 'La loxodrómica es la línea de rumbo constante, que corta a todos los meridianos con el mismo ángulo. Su utilidad en la navegación explica el éxito de la proyección de Mercator (1569), en la que se representa como una recta.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 3, 'es', true, (select id from public.sources where url = 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf'), 'Tu amigo el mapa, cap. 6', 'describían una línea denominada loxodrómica, que con un rumbo constante cortaba a todos los meridianos bajo el mismo ángulo y que en este tipo de proyección se transforma en una línea recta.', null, '9cfe424e167706aed5efc3a65b59eb6a060fd97a9f75e40d3837fe54bf70161d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9cfe424e167706aed5efc3a65b59eb6a060fd97a9f75e40d3837fe54bf70161d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Seguir un rumbo constante, cortando a todos los meridianos bajo el mismo ángulo; en la proyección de Mercator se transforma en una línea recta.', true), ('B', 'Ser el camino más corto entre dos puntos, por lo que en la proyección de Mercator se representa como un arco de círculo máximo.', false), ('C', 'Seguir siempre un paralelo, por lo que su rumbo es Norte o Sur.', false), ('D', 'Cortar a todos los paralelos en ángulo recto, por lo que es un meridiano.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el IGN, la información sobre el plano que no indica alturas se denomina planimetría; la información complementaria que señala altitudes sobre un plano de referencia es la:', 'El IGN explica que la planimetría es insuficiente y debe completarse con información altimétrica (altitudes sobre un plano de referencia, que en la península es el nivel medio del mar en Alicante).', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf'), 'Tu amigo el mapa, cap. 15', 'La información sobre el plano (planimetría) es insuficiente en la mayoría de los casos, por lo que es necesario disponer de una información altimétrica complementaria que nos señale altitudes sobre un plano de referencia.', null, 'b575c3cd7df2217e6eddb0a6855a1d0cb16ff3fd5a4ba684af3212b33f592313', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b575c3cd7df2217e6eddb0a6855a1d0cb16ff3fd5a4ba684af3212b33f592313')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Toponimia.', false), ('B', 'Batimetría.', false), ('C', 'Generalización.', false), ('D', 'Altimetría.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-18-topografia-ign_atlas-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Instituto Geográfico Nacional · Atlas Didáctico: La representación del territorio (ESO y Bachillerato)', 'https://educativo.ign.es/atlas-didactico/cartografia-bach/representacin_del_relieve.html', 'web_oficial'::public.source_kind, 'Instituto Geográfico Nacional (IGN-CNIG)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-18-topografia', 'Tema 18. Topografía') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-18-topografia' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En la medida de las coordenadas geográficas en el sistema sexagesimal, cada grado se divide en:', 'La latitud y la longitud se miden en grados, minutos y segundos de arco: cada grado tiene 60 minutos y cada minuto 60 segundos (p. ej., Alicante: 38º 20’ 43’’ N).', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 1, 'es', true, (select id from public.sources where url = 'https://educativo.ign.es/atlas-didactico/cartografia-bach/representacin_del_relieve.html'), 'Atlas Didáctico, Partes de un mapa (glosario: latitud)', 'Cada grado se divide en 60 minutos y cada minuto en 60 segundos.', null, 'd147eb365fbca0743f9bb3a4c57aef4578e650f5d98de2c0ce0aca4b5c8924f6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd147eb365fbca0743f9bb3a4c57aef4578e650f5d98de2c0ce0aca4b5c8924f6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '100 minutos, y cada minuto en 100 segundos.', false), ('B', '60 minutos, y cada minuto en 100 segundos.', false), ('C', '60 minutos, y cada minuto en 60 segundos.', true), ('D', '10 minutos, y cada minuto en 60 segundos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En la representación del relieve, los puntos que tienen una posición determinada y se representan con la indicación de su altitud numérica se denominan:', 'Los puntos acotados llevan su altitud (cota) en cifras; son la base del sistema de planos acotados. Las curvas maestras son curvas de nivel más gruesas y las tintas hipsométricas, colores por rangos de altura.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 2, 'es', true, (select id from public.sources where url = 'https://educativo.ign.es/atlas-didactico/cartografia-bach/representacin_del_relieve.html'), 'Atlas Didáctico, Representación del relieve', 'Puntos acotados. Son puntos que tienen una posición determinada y se representan con la indicación de su altitud numérica.', null, 'd3b17a96bfd9d274254fbfabadcbf8db0a9a5049aeeff429b1f9c3b562200f05', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd3b17a96bfd9d274254fbfabadcbf8db0a9a5049aeeff429b1f9c3b562200f05')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Vértices de proyección.', false), ('B', 'Puntos acotados.', true), ('C', 'Curvas maestras.', false), ('D', 'Tintas hipsométricas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-18-topografia-ign_conceptos-v1 (13 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Instituto Geográfico Nacional · Conceptos cartográficos (material didáctico, IGN & UPM-LatinGEO)', 'https://www.ign.es/web/resources/cartografiaEnsenanza/conceptosCarto/descargas/Conceptos_Cartograficos_def.pdf', 'web_oficial'::public.source_kind, 'Instituto Geográfico Nacional (IGN-CNIG)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-18-topografia', 'Tema 18. Topografía') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-18-topografia' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el material didáctico «Conceptos cartográficos» del Instituto Geográfico Nacional, la forma real de la Tierra es:', 'El IGN explica que la forma real de la Tierra es un geoide, cuya superficie irregular coincide con la de los mares en calma prolongada bajo los continentes; en cartografía se simplifica a un elipsoide o a una esfera porque su formulación matemática es conocida.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.ign.es/web/resources/cartografiaEnsenanza/conceptosCarto/descargas/Conceptos_Cartograficos_def.pdf'), 'Conceptos cartográficos, ap. 1.1', 'La forma real de la Tierra es un geoide cuya superficie irregular coincide con la que resultaría al prolongar por debajo de las superficies continentales, los mares y océanos en calma.', null, 'ab3617c8403ff45fdd174e42adbcc7c3861ccb1ad38132ede744b5ee2c559aa3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ab3617c8403ff45fdd174e42adbcc7c3861ccb1ad38132ede744b5ee2c559aa3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un geoide.', true), ('B', 'Un elipsoide de revolución perfecto.', false), ('C', 'Una esfera regular.', false), ('D', 'Un poliedro de veinte caras.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Una proyección cartográfica que mantiene los ángulos que forman dos líneas en la superficie terrestre se denomina:', 'La proyección conforme conserva los ángulos (por eso se usa en cartas de navegación); la equivalente conserva superficies, la equidistante distancias y la afiláctica no conserva ninguna de esas propiedades, aunque con deformaciones mínimas.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.ign.es/web/resources/cartografiaEnsenanza/conceptosCarto/descargas/Conceptos_Cartograficos_def.pdf'), 'Conceptos cartográficos, ap. 2.1.a', 'Una proyección cartográfica es conforme cuando mantiene los ángulos que forman dos líneas en la superficie terrestre. Este tipo de proyecciones se utilizan en cartas de navegación.', null, 'ca8e9a85f914ae039bc45df17a2eed5f261c808e7321a80b85b29a892014c77f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ca8e9a85f914ae039bc45df17a2eed5f261c808e7321a80b85b29a892014c77f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Equivalente.', false), ('B', 'Conforme.', true), ('C', 'Equidistante.', false), ('D', 'Afiláctica.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el IGN, las proyecciones equivalentes, que conservan en el mapa las superficies del terreno aunque las figuras dejen de ser semejantes, se utilizan generalmente en:', 'El IGN indica que la proyección equivalente conserva las superficies y se utiliza generalmente en mapas temáticos o parcelarios; las cartas de navegación usan proyecciones conformes.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.ign.es/web/resources/cartografiaEnsenanza/conceptosCarto/descargas/Conceptos_Cartograficos_def.pdf'), 'Conceptos cartográficos, ap. 2.1.b', 'Una proyección cartográfica es equivalente cuando en el mapa se conservan las superficies del terreno, aunque las figuras dejen de ser semejantes. Se utilizan generalmente en mapas temáticos o parcelarios.', null, '034ae1e1354cba32bcc2f86667520a796855c41191a13d834e5c5e871f83e1cc', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '034ae1e1354cba32bcc2f86667520a796855c41191a13d834e5c5e871f83e1cc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cartas de navegación.', false), ('B', 'Cartas astronómicas.', false), ('C', 'Mapas de las zonas polares.', false), ('D', 'Mapas temáticos o parcelarios.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Cómo se denomina la proyección cartográfica que no conserva ángulos, superficies ni distancias, pero cuyas deformaciones son mínimas?', 'Es la proyección afiláctica. Las conformes conservan ángulos, las equivalentes superficies y las equidistantes distancias; la gnomónica es un tipo de proyección plana según la posición del vértice.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.ign.es/web/resources/cartografiaEnsenanza/conceptosCarto/descargas/Conceptos_Cartograficos_def.pdf'), 'Conceptos cartográficos, ap. 2.1.d', 'Una proyección cartográfica es afiláctica cuando no conserva ángulos, superficies ni distancias, pero las deformaciones son mínimas.', null, '3e5fa777e7d189ca3bfe4d8d887ae40abaa21a473fd930f226d53a266921d2fa', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3e5fa777e7d189ca3bfe4d8d887ae40abaa21a473fd930f226d53a266921d2fa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Conforme.', false), ('B', 'Equidistante.', false), ('C', 'Afiláctica.', true), ('D', 'Gnomónica.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el IGN, ¿cuál de las siguientes es un ejemplo de proyección cónica?', 'El IGN cita como proyecciones cónicas las de Lambert y Bonne; Mercator y UTM son ejemplos de proyecciones cilíndricas, y la sinusoidal es una proyección modificada.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.ign.es/web/resources/cartografiaEnsenanza/conceptosCarto/descargas/Conceptos_Cartograficos_def.pdf'), 'Conceptos cartográficos, ap. 2.2.b', 'Son ejemplos las proyecciones de Lambert y Bonne.', null, '8187db82a8cc8c3459b4f3460c75c048601b87efa6c08e1ef0d2e6ee39d6912f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8187db82a8cc8c3459b4f3460c75c048601b87efa6c08e1ef0d2e6ee39d6912f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La de Mercator.', false), ('B', 'La UTM (Universal Transversa de Mercator).', false), ('C', 'La sinusoidal.', false), ('D', 'La de Lambert.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el material «Conceptos cartográficos» del IGN, la escala puede expresarse de tres formas distintas:', 'El IGN distingue la escala numérica (fracción), la gráfica (línea subdividida en segmentos) y la textual o literal (relación escrita); cualquiera de ellas basta para conocer la relación entre el mapa y la realidad.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.ign.es/web/resources/cartografiaEnsenanza/conceptosCarto/descargas/Conceptos_Cartograficos_def.pdf'), 'Conceptos cartográficos, ap. 3', 'La escala puede expresarse de tres formas distintas: numérica, gráfica y textual o literal.', null, 'c11410345f45a3fa0c484f72d428136a7436b9ebe3f174c2d45674790fa7711f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c11410345f45a3fa0c484f72d428136a7436b9ebe3f174c2d45674790fa7711f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Numérica, decimal y porcentual.', false), ('B', 'Numérica, gráfica y textual o literal.', true), ('C', 'Gráfica, hipsométrica y textual.', false), ('D', 'Numérica, angular y gráfica.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En la escala numérica, expresada mediante una fracción, el denominador indica:', 'En la escala numérica el numerador es la distancia medida en el mapa y el denominador la correspondiente en el terreno; así, 1:60.000.000 significa que una unidad del mapa equivale a 60 millones de unidades reales.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.ign.es/web/resources/cartografiaEnsenanza/conceptosCarto/descargas/Conceptos_Cartograficos_def.pdf'), 'Conceptos cartográficos, ap. 3.1', 'La escala numérica se expresa mediante una fracción que indica la relación entre la distancia medida de dos puntos en el mapa (numerador) y la correspondiente en el terreno (denominador)', null, '71ac4135e1ada5b9927d63c8fc9aaa758ccf9b13d8e6e1e01dc39d32fbad72cb', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '71ac4135e1ada5b9927d63c8fc9aaa758ccf9b13d8e6e1e01dc39d32fbad72cb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La distancia medida entre dos puntos en el mapa.', false), ('B', 'La equidistancia entre curvas de nivel.', false), ('C', 'La distancia correspondiente en el terreno.', true), ('D', 'El número de hoja del mapa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el IGN, se suelen denominar mapas de pequeña escala aquellos cuya escala es:', 'El IGN llama mapas de pequeña escala a los de escala menor de 1:100.000 (países, continentes...), y de gran escala a los de escala mayor de 1:10.000; a partir de 1:2.000 se habla de planos.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.ign.es/web/resources/cartografiaEnsenanza/conceptosCarto/descargas/Conceptos_Cartograficos_def.pdf'), 'Conceptos cartográficos, ap. 4.1', 'Se suelen denominar mapas de pequeña escala aquéllos cuya escala es menor de 1:100.000.', null, 'dc3b9212427b73cd2ad1eff399e5b72f5248659752b34b14276a023a3683c952', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'dc3b9212427b73cd2ad1eff399e5b72f5248659752b34b14276a023a3683c952')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Menor de 1:100.000.', true), ('B', 'Mayor de 1:10.000.', false), ('C', 'Menor de 1:2.000.', false), ('D', 'Igual o superior a 1:25.000.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el material «Conceptos cartográficos» del IGN, ¿a partir de qué escala se habla de planos, al no considerar la esfericidad de la Tierra?', 'El IGN indica que los mapas de gran escala son los de escala mayor de 1:10.000 y que se denominan planos a partir de 1:2.000, porque no se considera la esfericidad terrestre.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 3, 'es', true, (select id from public.sources where url = 'https://www.ign.es/web/resources/cartografiaEnsenanza/conceptosCarto/descargas/Conceptos_Cartograficos_def.pdf'), 'Conceptos cartográficos, ap. 4.1', 'Se denominan planos a partir de 1:2.000, al no considerar la esfericidad de la Tierra.', null, '9f13e1a465fb29bd0d00359b48e05a5b5a163060684e2c93904d1eab87dfb1db', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9f13e1a465fb29bd0d00359b48e05a5b5a163060684e2c93904d1eab87dfb1db')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A partir de 1:10.000.', false), ('B', 'A partir de 1:25.000.', false), ('C', 'A partir de 1:100.000.', false), ('D', 'A partir de 1:2.000.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el IGN, los elementos imprescindibles que deben aparecer en todos los mapas son:', 'El IGN señala que la escala (relación métrica entre mapa y realidad) y la leyenda (signos convencionales) son los elementos imprescindibles; los demás datos marginales pueden añadirse según las normas de cada serie.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.ign.es/web/resources/cartografiaEnsenanza/conceptosCarto/descargas/Conceptos_Cartograficos_def.pdf'), 'Conceptos cartográficos, ap. 5', 'Los elementos imprescindibles que deben aparecer en todos los mapas son: la escala utilizada y la leyenda.', null, '05f826f9c6a7203b9c22a1089e4bc6168fb13877033514d692bc653c03c74fd7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '05f826f9c6a7203b9c22a1089e4bc6168fb13877033514d692bc653c03c74fd7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La escala utilizada y la leyenda.', true), ('B', 'El título y la fuente.', false), ('C', 'La cuadrícula UTM y la toponimia.', false), ('D', 'La declinación magnética y la proyección.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En las hojas del Mapa Topográfico Nacional a escala 1:50.000 (MTN50), la cuadrícula de líneas horizontales y verticales se dibuja con una separación de:', 'A escala 1:50.000, 2 cm del mapa son 100.000 cm, es decir, 1 km; el marco y la cuadrícula permiten extraer las coordenadas de cualquier punto del mapa.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.ign.es/web/resources/cartografiaEnsenanza/conceptosCarto/descargas/Conceptos_Cartograficos_def.pdf'), 'Conceptos cartográficos, ap. 5.4', '[2] Cuadrícula de líneas horizontales y verticales, dibujadas con una separación de 2 cm (equivalente a un kilómetro en el terreno).', null, '8b82c4717cf53b3d30800d1baa1f7505cb5b9ca3294faa24f4d6c3b0b4824d1d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8b82c4717cf53b3d30800d1baa1f7505cb5b9ca3294faa24f4d6c3b0b4824d1d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '1 cm, equivalente a un kilómetro en el terreno.', false), ('B', '2 cm, equivalente a un kilómetro en el terreno.', true), ('C', '4 cm, equivalente a dos kilómetros en el terreno.', false), ('D', '2 cm, equivalente a 500 metros en el terreno.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En el MTN50, la leyenda que define todos los signos convencionales utilizados en el mapa se sitúa en:', 'La leyenda del MTN50 está en el margen inferior izquierdo y se divide en tres columnas: elementos lineales, símbolos puntuales y usos del suelo. En el margen inferior derecho van la toponimia y los vértices geodésicos.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 3, 'es', true, (select id from public.sources where url = 'https://www.ign.es/web/resources/cartografiaEnsenanza/conceptosCarto/descargas/Conceptos_Cartograficos_def.pdf'), 'Conceptos cartográficos, ap. 5.6', 'En el margen inferior izquierdo se sitúa la lista explicativa que define con detalle y sin lugar a equívoco todos los signos convencionales utilizados en el mapa. La leyenda se divide en tres columnas', null, '5e68149a1f1a05f481b0e556ec2c6b31d8c4c92737588561289886a59915521f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5e68149a1f1a05f481b0e556ec2c6b31d8c4c92737588561289886a59915521f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El margen inferior derecho, junto a la lista de vértices geodésicos.', false), ('B', 'La contraportada, junto al gráfico de hojas colindantes.', false), ('C', 'El margen inferior izquierdo, dividida en tres columnas.', true), ('D', 'El margen superior, junto al nombre de la hoja.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Las isolíneas que unen puntos de igual temperatura se denominan:', 'Si el valor constante es la altitud se habla de curvas de nivel; si es la temperatura, de isotermas, y si es la presión, de isobaras.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.ign.es/web/resources/cartografiaEnsenanza/conceptosCarto/descargas/Conceptos_Cartograficos_def.pdf'), 'Conceptos cartográficos, ap. 7.c', 'si el valor constante es la altitud se habla de curvas de nivel; si es la temperatura se denomina isotermas, y si los puntos de las isolíneas tienen igual presión se denominan isobaras.', null, 'c7a45d89bbb97ac37fb3475ec27a851ef8198c4b8d5819b36b5911c88542e719', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c7a45d89bbb97ac37fb3475ec27a851ef8198c4b8d5819b36b5911c88542e719')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Isotermas.', true), ('B', 'Isobaras.', false), ('C', 'Curvas de nivel.', false), ('D', 'Isógonas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-18-topografia-ign_descubre-v1 (5 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Instituto Geográfico Nacional · Descubre el Territorio: La brújula, El desnivel y La altitud (recursos educativos)', 'https://www.ign.es/recursos-educativos/descubre-territorio/brujula.html', 'web_oficial'::public.source_kind, 'Instituto Geográfico Nacional (IGN-CNIG)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-18-topografia', 'Tema 18. Topografía') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-18-topografia' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el recurso educativo del IGN «Descubre el Territorio», el ángulo entre el Norte (N) y la dirección de la marcha se denomina:', 'El acimut es el ángulo medido desde el Norte hasta la dirección a la que queremos dirigirnos; indica la dirección con más precisión que los puntos cardinales (Sur, Oeste, Suroeste...). La declinación es el ángulo entre el norte geográfico y el magnético.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.ign.es/recursos-educativos/descubre-territorio/brujula.html'), 'Descubre el Territorio, La brújula', 'El ángulo entre el Norte (N) y la dirección de la marcha es el acimut de la dirección a la que nos queremos dirigir.', null, 'ec90f05bb31d83bdd73b5bf4b229d583fc3847a39b51747274ebfc7e1f46a8a1', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ec90f05bb31d83bdd73b5bf4b229d583fc3847a39b51747274ebfc7e1f46a8a1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Declinación magnética.', false), ('B', 'Latitud.', false), ('C', 'Acimut.', true), ('D', 'Convergencia de meridianos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Para corregir con la declinación magnética el acimut leído en la brújula, según el IGN:', 'El IGN indica que con declinación Este (+) se resta y con declinación Oeste (-) se suma al valor de la brújula; los datos de declinación y su variación anual figuran en los márgenes de los mapas del IGN.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 3, 'es', true, (select id from public.sources where url = 'https://www.ign.es/recursos-educativos/descubre-territorio/brujula.html'), 'Descubre el Territorio, La brújula', 'Si la declinación es Este (+), hay que restar su valor al indicado en la brújula. Si es Oeste (-), hay que sumarlo.', null, '551af7574daaaa531d33a8748449e347e09b690a72e65dfd86181ee8f0638a9f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '551af7574daaaa531d33a8748449e347e09b690a72e65dfd86181ee8f0638a9f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Si la declinación es Este (+), hay que sumar su valor; si es Oeste (-), hay que restarlo.', false), ('B', 'Si la declinación es Este (+), hay que restar su valor; si es Oeste (-), hay que sumarlo.', true), ('C', 'Siempre hay que sumar su valor, sea Este u Oeste.', false), ('D', 'Siempre hay que restar su valor, sea Este u Oeste.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'En un mapa a escala 1:25.000 se miden 120 mm entre dos puntos. ¿Cuál es la distancia real entre ellos?', 'Por regla de tres: 1 mm del mapa equivale a 25.000 mm en la realidad, luego 120 mm × 25.000 = 3.000.000 mm = 3.000 m = 3 km.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.ign.es/recursos-educativos/descubre-territorio/brujula.html'), 'Descubre el Territorio, El desnivel', 'A una escala 1/25.000, si medimos 120 mm en el mapa: 1 mm en el mapa -> 25.000 mm en la realidad 120 mm -> x mm en la realidad x = 25.000 * 120 mm = 3.000 m = 3 km', null, '399270c533cdaf5a62de49ee0cfb9c39e9b9d3d63fbbbcd8d746c94002d0ff8d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '399270c533cdaf5a62de49ee0cfb9c39e9b9d3d63fbbbcd8d746c94002d0ff8d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '3 km.', true), ('B', '300 m.', false), ('C', '30 km.', false), ('D', '1,2 km.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Un punto A está a 1.053 m de altitud y un punto B a 1.225 m; la distancia entre ambos es de 2.600 m. ¿Cuál es, aproximadamente, la pendiente del recorrido?', 'Primero se calcula el desnivel: 1.225 − 1.053 = 172 m. La pendiente es desnivel / distancia × 100 = 172 / 2.600 × 100 ≈ 6,6 %.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.ign.es/recursos-educativos/descubre-territorio/brujula.html'), 'Descubre el Territorio, El desnivel', 'Primero tenemos que calcular el desnivel entre los puntos A y B. El resultado es 172 m. Si el recorrido son 2.600 m y el desnivel es de 172 m solo tengo que hacer una regla de tres. Por tanto, la pendiente es del 6,6%.', null, 'ef1eceb461b0de554bc2343e8bb7bcc01875ca8307fb206873b3961da19d7ab7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ef1eceb461b0de554bc2343e8bb7bcc01875ca8307fb206873b3961da19d7ab7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '17,2 %.', false), ('B', '2,6 %.', false), ('C', '47 %.', false), ('D', '6,6 %.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'La Masía de Tetuán está a 1.225 m sobre el nivel del mar y la cima del Menejador a 1.354 m; la distancia entre ambos puntos es de 2.390 m. ¿Cuál es, aproximadamente, la pendiente de ese tramo?', 'Desnivel = 1.354 − 1.225 = 129 m. Pendiente = 129 / 2.390 × 100 ≈ 5,4 %, algo menor que la del tramo anterior (6,6 %), como señala el propio recurso del IGN.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 3, 'es', true, (select id from public.sources where url = 'https://www.ign.es/recursos-educativos/descubre-territorio/brujula.html'), 'Descubre el Territorio, El desnivel', 'La masía está a 1.225 m sobre el nivel del mar, recuerda que la altura del Menejador son 1.354 m; y la distancia que separa los dos puntos es de 2.390 m.', null, '56b16e9714ee2e21e19cbddc15e226f3873cde1f3106b113a58b9fa05f50b62a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '56b16e9714ee2e21e19cbddc15e226f3873cde1f3106b113a58b9fa05f50b62a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', '6,6 %.', false), ('B', '5,4 %.', true), ('C', '12,9 %.', false), ('D', '18,5 %.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-18-topografia-ign_glosario-v1 (2 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Instituto Geográfico Nacional · Glosario del Atlas Didáctico (términos geográficos)', 'https://educativo.ign.es/atlas-didactico/glosario/index.html', 'web_oficial'::public.source_kind, 'Instituto Geográfico Nacional (IGN-CNIG)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-18-topografia', 'Tema 18. Topografía') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-18-topografia' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'La línea que une los puntos en los que las aguas fluyen hacia cuencas hidrográficas diferentes, y que suele corresponderse con líneas de cumbres, se denomina:', 'La divisoria de aguas separa cuencas hidrográficas y suele seguir las líneas de cumbres. La rambla es un cauce normalmente seco y la hoz, la angostura de un valle profundo.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 1, 'es', true, (select id from public.sources where url = 'https://educativo.ign.es/atlas-didactico/glosario/index.html'), 'Glosario del Atlas Didáctico, «divisoria de aguas»', 'Línea que une los puntos en los que las aguas fluyen hacia cuencas hidrográficas diferentes. Suele corresponderse con líneas de cumbres.', null, '74bc738db4026b7b75e68f34891027ef8784567d9a00bba2ca0acb3d3dc46b0e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '74bc738db4026b7b75e68f34891027ef8784567d9a00bba2ca0acb3d3dc46b0e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Divisoria de aguas.', true), ('B', 'Rambla.', false), ('C', 'Hoz.', false), ('D', 'Curva de nivel.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el glosario del IGN, la angostura de un valle profundo o curva que forma un río encajado entre paredes abruptas, normalmente en relieves calcáreos, recibe el nombre de:', 'La hoz es un accidente del terreno propio de relieves calcáreos. El cerro testigo es una elevación aislada en medio de una llanura; la vega, una zona llana y baja regada por un río; y el páramo, una superficie elevada y horizontal.', 'gc_18_topografia', (select id from public.topics where slug = 'gc-18-topografia'), 2, 'es', true, (select id from public.sources where url = 'https://educativo.ign.es/atlas-didactico/glosario/index.html'), 'Glosario del Atlas Didáctico, «hoz» y «cerro testigo»', 'Angostura de un valle profundo o curva que forma un río encajado entre paredes abruptas. Su figura recuerda la del instrumento que le da nombre. Normalmente está asociado a relieves calcáreos.', null, 'f00d33778e9f61558851977b86d33c76f66df415696d26f3c2171ec29ada643e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f00d33778e9f61558851977b86d33c76f66df415696d26f3c2171ec29ada643e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cerro testigo.', false), ('B', 'Vega.', false), ('C', 'Hoz.', true), ('D', 'Páramo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-19b-principios-onu-fuerza-dh_habana-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Principios Básicos sobre el Empleo de la Fuerza y de Armas de Fuego por los Funcionarios Encargados de Hacer Cumplir la Ley (La Habana, 1990)', 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement', 'web_oficial'::public.source_kind, 'Oficina del Alto Comisionado de las Naciones Unidas para los Derechos Humanos (ohchr.org)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-19b-principios-onu-fuerza', 'Tema 19. Deontología (II): Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego (La Habana, 1990)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-19b-principios-onu-fuerza' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Los Principios Básicos sobre el Empleo de la Fuerza y de Armas de Fuego por los Funcionarios Encargados de Hacer Cumplir la Ley fueron aprobados por:', 'Según la ficha oficial del ACNUDH, los Principios Básicos se aprobaron el 7 de septiembre de 1990 por el Octavo Congreso de las Naciones Unidas sobre Prevención del Delito y Tratamiento del Delincuente, celebrado en La Habana (Cuba) del 27 de agosto al 7 de septiembre de 1990.', 'gc_19b_principios_onu_fuerza', (select id from public.topics where slug = 'gc-19b-principios-onu-fuerza'), 1, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement'), 'Adopción de los Principios Básicos (1990)', 'el Octavo Congreso de las Naciones Unidas sobre Prevención del Delito y Tratamiento del Delincuente, celebrado en La Habana (Cuba) del 27 de agosto al 7 de septiembre de 1990', null, '79c68c276b0af868735e7608c5fe3a957fa21cf4ae4b1a4310b7fa8e6991d0ad', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '79c68c276b0af868735e7608c5fe3a957fa21cf4ae4b1a4310b7fa8e6991d0ad')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La Asamblea General de las Naciones Unidas en su resolución 34/169, de 1979.', false), ('B', 'El Octavo Congreso de las Naciones Unidas sobre Prevención del Delito y Tratamiento del Delincuente, celebrado en La Habana en 1990.', true), ('C', 'El Consejo de Derechos Humanos de las Naciones Unidas en 2006.', false), ('D', 'El Comité de Ministros del Consejo de Europa en 2001.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el principio 2 de los Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego, entre las armas de que se dote a los funcionarios encargados de hacer cumplir la ley deberían figurar, para restringir cada vez más los medios que puedan ocasionar lesiones o muertes:', 'El principio 2 pide dotar a los funcionarios de distintos tipos de armas y municiones para un uso diferenciado de la fuerza, incluidas armas incapacitantes no letales, y de equipo autoprotector (escudos, cascos, chalecos y medios de transporte a prueba de balas).', 'gc_19b_principios_onu_fuerza', (select id from public.topics where slug = 'gc-19b-principios-onu-fuerza'), 1, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement'), 'Principio 2', 'Entre estas armas deberían figurar armas incapacitantes no letales para emplearlas cuando fuera apropiado, con miras a restringir cada vez más el empleo de medios que puedan ocasionar lesiones o muertes.', null, '6cf1040ff50a5c109836cff692dde8574fa0d99c23841e52c56f96d4ec73ad41', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6cf1040ff50a5c109836cff692dde8574fa0d99c23841e52c56f96d4ec73ad41')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Armas automáticas de gran calibre.', false), ('B', 'Armas de fuego con munición expansiva.', false), ('C', 'Armas incapacitantes no letales para emplearlas cuando fuera apropiado.', true), ('D', 'Exclusivamente armas de fuego cortas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el principio 4 de los Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego, los funcionarios encargados de hacer cumplir la ley, en el desempeño de sus funciones:', 'El principio 4 consagra la subsidiariedad: la fuerza y las armas de fuego solo pueden utilizarse cuando otros medios resulten ineficaces o no garanticen el logro del resultado previsto.', 'gc_19b_principios_onu_fuerza', (select id from public.topics where slug = 'gc-19b-principios-onu-fuerza'), 1, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement'), 'Principio 4', 'utilizarán en la medida de lo posible medios no violentos antes de recurrir al empleo de la fuerza y de armas de fuego. Podrán utilizar la fuerza y armas de fuego solamente cuando otros medios resulten ineficaces o no garanticen de ninguna manera el logro del resultado previsto.', null, '0aa8a9f788df54e97078b9a0e9e58dc67bae8a09c8496fc078cb1b5ea153614d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0aa8a9f788df54e97078b9a0e9e58dc67bae8a09c8496fc078cb1b5ea153614d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Podrán utilizar armas de fuego siempre que lo ordene un superior.', false), ('B', 'Utilizarán la fuerza como primer medio para garantizar su seguridad personal.', false), ('C', 'Podrán emplear libremente la fuerza cuando actúen contra personas sospechosas de un delito.', false), ('D', 'Utilizarán en la medida de lo posible medios no violentos antes de recurrir al empleo de la fuerza y de armas de fuego.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el principio 5 de los Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego, cuando el empleo de las armas de fuego sea inevitable, los funcionarios encargados de hacer cumplir la ley ejercerán moderación y actuarán en proporción a:', 'El principio 5 exige, cuando el uso de armas de fuego sea inevitable: moderación y proporcionalidad, reducir al mínimo daños y lesiones, asistencia médica cuanto antes y notificación a parientes o amigos íntimos.', 'gc_19b_principios_onu_fuerza', (select id from public.topics where slug = 'gc-19b-principios-onu-fuerza'), 2, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement'), 'Principio 5.a)', 'a) Ejercerán moderación y actuarán en proporción a la gravedad del delito y al objetivo legítimo que se persiga;', null, 'd095c1590681b3c7dbbf254ebddca52e892bd0040009fccf0af89411ccd650d4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd095c1590681b3c7dbbf254ebddca52e892bd0040009fccf0af89411ccd650d4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La gravedad del delito y al objetivo legítimo que se persiga.', true), ('B', 'El número de agresores y a las armas de que dispongan.', false), ('C', 'Las instrucciones recibidas de sus superiores.', false), ('D', 'La pena prevista para el delito en la legislación nacional.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el principio 5 de los Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego, cuando el empleo de armas de fuego sea inevitable, los funcionarios procurarán notificar lo sucedido, a la menor brevedad posible:', 'El principio 5.d) se refiere a la notificación a parientes o amigos íntimos; la comunicación a los superiores en caso de lesiones o muerte está en el principio 6.', 'gc_19b_principios_onu_fuerza', (select id from public.topics where slug = 'gc-19b-principios-onu-fuerza'), 2, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement'), 'Principio 5.d)', 'd) Procurarán notificar lo sucedido, a la menor brevedad posible, a los parientes o amigos íntimos de las personas heridas o afectadas.', null, '8f79969ffd0c1f95c721ec57c919fe5ec50ade15cde13f11e2fe42da0ff8b5a5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8f79969ffd0c1f95c721ec57c919fe5ec50ade15cde13f11e2fe42da0ff8b5a5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Ministerio Fiscal, en el plazo de veinticuatro horas.', false), ('B', 'A los parientes o amigos íntimos de las personas heridas o afectadas.', true), ('C', 'Al Consejo de Derechos Humanos de las Naciones Unidas.', false), ('D', 'A los medios de comunicación, para garantizar la transparencia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el principio 6 de los Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego, cuando al emplear la fuerza o armas de fuego los funcionarios ocasionen lesiones o muerte:', 'El principio 6 impone la comunicación inmediata a los superiores, de conformidad con el principio 22, que exige procedimientos eficaces de informe y revisión.', 'gc_19b_principios_onu_fuerza', (select id from public.topics where slug = 'gc-19b-principios-onu-fuerza'), 1, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement'), 'Principio 6', 'Cuando al emplear la fuerza o armas de fuego los funcionarios encargados de hacer cumplir la ley ocasionen lesiones o muerte, comunicarán el hecho inmediatamente a sus superiores de conformidad con el principio 22.', null, '391a4ccaca9a95508ff3f470d8b0c45ca609fc5cc379c19eaa03eb041833024f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '391a4ccaca9a95508ff3f470d8b0c45ca609fc5cc379c19eaa03eb041833024f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Comunicarán el hecho en el plazo de cuarenta y ocho horas a la autoridad judicial.', false), ('B', 'Solo deberán comunicarlo si la persona afectada presenta una queja.', false), ('C', 'Comunicarán el hecho al Defensor del Pueblo.', false), ('D', 'Comunicarán el hecho inmediatamente a sus superiores.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el principio 7 de los Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego, los gobiernos adoptarán las medidas necesarias para que en la legislación se castigue como delito:', 'El principio 7 exige tipificar como delito el uso arbitrario o abusivo de la fuerza o de las armas de fuego; la negativa a cumplir una orden ilícita de emplear la fuerza está protegida por el principio 25.', 'gc_19b_principios_onu_fuerza', (select id from public.topics where slug = 'gc-19b-principios-onu-fuerza'), 2, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement'), 'Principio 7', 'Los gobiernos adoptarán las medidas necesarias para que en la legislación se castigue como delito el empleo arbitrario o abusivo de la fuerza o de armas de fuego por parte de los funcionarios encargados de hacer cumplir la ley.', null, 'b017c1935ea66f2d44635600ce7b4f8ec9a12ab3054288162705110d6c418fee', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b017c1935ea66f2d44635600ce7b4f8ec9a12ab3054288162705110d6c418fee')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cualquier empleo de armas de fuego por los funcionarios, aunque sea en defensa propia.', false), ('B', 'La negativa de un funcionario a cumplir una orden de emplear la fuerza.', false), ('C', 'El empleo arbitrario o abusivo de la fuerza o de armas de fuego por parte de los funcionarios encargados de hacer cumplir la ley.', true), ('D', 'La tenencia de armas incapacitantes no letales sin autorización judicial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el principio 8 de los Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego, ¿pueden invocarse circunstancias excepcionales como la inestabilidad política interna para justificar el quebrantamiento de estos Principios?', 'El principio 8 excluye que la inestabilidad política interna o cualquier otra situación pública de emergencia justifiquen el quebrantamiento de los Principios Básicos.', 'gc_19b_principios_onu_fuerza', (select id from public.topics where slug = 'gc-19b-principios-onu-fuerza'), 1, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement'), 'Principio 8', 'No se podrán invocar circunstancias excepcionales tales como la inestabilidad política interna o cualquier otra situación pública de emergencia para justificar el quebrantamiento de estos Principios Básicos.', null, 'a9e2f3292d6b202f04305b15696d43a87f0d1c3f1ffd33041457be84188352e3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a9e2f3292d6b202f04305b15696d43a87f0d1c3f1ffd33041457be84188352e3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No, ni esas ni ninguna otra situación pública de emergencia.', true), ('B', 'Sí, durante la vigencia de un estado de excepción declarado.', false), ('C', 'Sí, si lo autoriza previamente el Gobierno.', false), ('D', 'Sí, cuando la inestabilidad política afecte a la seguridad nacional.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el principio 9 de los Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego, solo se podrá hacer uso intencional de armas letales:', 'El principio 9 limita el empleo de armas de fuego contra personas a supuestos tasados y, en todo caso, reserva el uso intencional de armas letales a cuando sea estrictamente inevitable para proteger una vida.', 'gc_19b_principios_onu_fuerza', (select id from public.topics where slug = 'gc-19b-principios-onu-fuerza'), 2, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement'), 'Principio 9', 'En cualquier caso, sólo se podrá hacer uso intencional de armas letales cuando sea estrictamente inevitable para proteger una vida.', null, '5c0fe82219b9dfa05acd63f8fbfeec598d8c8369d3d87424ebc5bdea3ff81f2c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5c0fe82219b9dfa05acd63f8fbfeec598d8c8369d3d87424ebc5bdea3ff81f2c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cuando sea estrictamente inevitable para proteger una vida.', true), ('B', 'Cuando sea necesario para proteger bienes de especial valor.', false), ('C', 'Cuando el sospechoso huya tras cometer cualquier delito.', false), ('D', 'Cuando lo autorice previamente un superior jerárquico.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el principio 9 de los Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego, ¿cuál de los siguientes NO es uno de los supuestos en que los funcionarios pueden emplear armas de fuego contra las personas?', 'El principio 9 solo admite el uso de armas de fuego en defensa propia o de terceros ante peligro inminente de muerte o lesiones graves, para evitar un delito particularmente grave que amenace seriamente la vida, o para detener o impedir la fuga de quien represente ese peligro, y siempre que resulten insuficientes medidas menos extremas.', 'gc_19b_principios_onu_fuerza', (select id from public.topics where slug = 'gc-19b-principios-onu-fuerza'), 3, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement'), 'Principio 9', 'no emplearán armas de fuego contra las personas salvo en defensa propia o de otras personas, en caso de peligro inminente de muerte o lesiones graves, o con el propósito de evitar la comisión de un delito particularmente grave que entrañe una seria amenaza para la vida, o con el objeto de detener a una persona que represente ese peligro y oponga resistencia a su autoridad, o para impedir su fuga', null, '2f979697c64753a739c317ad7d5c8a61076a22ef21534b54e0fc174eeacf4d59', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2f979697c64753a739c317ad7d5c8a61076a22ef21534b54e0fc174eeacf4d59')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En defensa propia o de otras personas, en caso de peligro inminente de muerte o lesiones graves.', false), ('B', 'Para evitar la comisión de cualquier delito contra la propiedad.', true), ('C', 'Con el propósito de evitar la comisión de un delito particularmente grave que entrañe una seria amenaza para la vida.', false), ('D', 'Con el objeto de detener a una persona que represente ese peligro y oponga resistencia a su autoridad, o para impedir su fuga.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el principio 10 de los Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego, en las circunstancias del principio 9, los funcionarios encargados de hacer cumplir la ley:', 'El principio 10 impone identificación y advertencia previa, salvo que ello ponga indebidamente en peligro a los funcionarios, cree riesgo de muerte o daños graves a otras personas o resulte evidentemente inadecuado o inútil.', 'gc_19b_principios_onu_fuerza', (select id from public.topics where slug = 'gc-19b-principios-onu-fuerza'), 2, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement'), 'Principio 10', 'se identificarán como tales y darán una clara advertencia de su intención de emplear armas de fuego, con tiempo suficiente para que se tome en cuenta', null, '38bf9118eb3fb70d742cce1cc32afddf65d55571c1630e01cd6a4311cd0dbe24', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '38bf9118eb3fb70d742cce1cc32afddf65d55571c1630e01cd6a4311cd0dbe24')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Efectuarán siempre un disparo al aire antes de apuntar a la persona.', false), ('B', 'Solo deberán identificarse si visten de paisano.', false), ('C', 'No tienen obligación de advertir, pues la situación ya es de peligro inminente.', false), ('D', 'Se identificarán como tales y darán una clara advertencia de su intención de emplear armas de fuego, con tiempo suficiente para que se tome en cuenta, salvo en los casos exceptuados.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el principio 11 de los Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego, las normas y reglamentaciones sobre el empleo de armas de fuego deben contener directrices que:', 'El principio 11 exige directrices que especifiquen cuándo se portan armas y de qué tipo, aseguren su uso apropiado, prohíban armas y municiones que causen lesiones no deseadas, regulen control y almacenamiento, señalen los avisos y establezcan un sistema de informes.', 'gc_19b_principios_onu_fuerza', (select id from public.topics where slug = 'gc-19b-principios-onu-fuerza'), 3, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement'), 'Principio 11.f)', 'f) Establezcan un sistema de presentación de informes siempre que los funcionarios encargados de hacer cumplir la ley recurran al empleo de armas de fuego en el desempeño de sus funciones.', null, 'f3b1088b34fba0f1411aa6b18216f65a9051e7243938e70ff1fc263e3fe9bdb5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f3b1088b34fba0f1411aa6b18216f65a9051e7243938e70ff1fc263e3fe9bdb5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Permitan a cada funcionario elegir libremente el tipo de arma y munición que porta.', false), ('B', 'Autoricen el empleo de municiones que puedan provocar lesiones no deseadas en situaciones de riesgo.', false), ('C', 'Establezcan un sistema de presentación de informes siempre que los funcionarios recurran al empleo de armas de fuego en el desempeño de sus funciones.', true), ('D', 'Eximan de responder de las armas y municiones entregadas a los funcionarios con más de diez años de servicio.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el principio 13 de los Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego, al dispersar reuniones ilícitas pero no violentas, los funcionarios encargados de hacer cumplir la ley:', 'El principio 13 rige las reuniones ilícitas no violentas (evitar la fuerza o limitarla al mínimo); para las violentas, el principio 14 solo permite armas de fuego en los supuestos del principio 9.', 'gc_19b_principios_onu_fuerza', (select id from public.topics where slug = 'gc-19b-principios-onu-fuerza'), 2, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement'), 'Principio 13', 'Al dispersar reuniones ilícitas pero no violentas, los funcionarios encargados de hacer cumplir la ley evitarán el empleo de la fuerza o, si no es posible, lo limitarán al mínimo necesario.', null, '19d0aec87c72c8e0a3b106db9b948882d3b3b63ab281b6bc63406e5ef316ed57', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '19d0aec87c72c8e0a3b106db9b948882d3b3b63ab281b6bc63406e5ef316ed57')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Podrán emplear armas de fuego si los reunidos no se dispersan tras la primera advertencia.', false), ('B', 'Emplearán la fuerza que consideren necesaria sin más limitación.', false), ('C', 'No podrán intervenir en ningún caso.', false), ('D', 'Evitarán el empleo de la fuerza o, si no es posible, lo limitarán al mínimo necesario.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el principio 14 de los Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego, al dispersar reuniones violentas los funcionarios encargados de hacer cumplir la ley:', 'El principio 14 condiciona el uso de armas de fuego en reuniones violentas a la imposibilidad de usar medios menos peligrosos, a la mínima medida necesaria y a los supuestos del principio 9.', 'gc_19b_principios_onu_fuerza', (select id from public.topics where slug = 'gc-19b-principios-onu-fuerza'), 3, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement'), 'Principio 14', 'Al dispersar reuniones violentas, los funcionarios encargados de hacer cumplir la ley podrán utilizar armas de fuego cuando no se puedan utilizar medios menos peligrosos y únicamente en la mínima medida necesaria. Los funcionarios encargados de hacer cumplir la ley se abstendrán de emplear las armas de fuego en esos casos, salvo en las circunstancias previstas en el principio 9.', null, '09dd665e16d840e7e5b02d018fb5345c87f47c644b11a28888aadf747b454e1a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '09dd665e16d840e7e5b02d018fb5345c87f47c644b11a28888aadf747b454e1a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Podrán utilizar armas de fuego en todo caso, por tratarse de una reunión violenta.', false), ('B', 'No podrán utilizar en ningún caso armas de fuego, sino solo armas no letales.', false), ('C', 'Podrán utilizar armas de fuego cuando no se puedan utilizar medios menos peligrosos y únicamente en la mínima medida necesaria, absteniéndose de emplearlas salvo en las circunstancias del principio 9.', true), ('D', 'Podrán utilizar armas de fuego siempre que la reunión no haya sido comunicada a la autoridad.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el principio 15 de los Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego, en sus relaciones con las personas bajo custodia o detenidas, los funcionarios no emplearán la fuerza salvo:', 'El principio 15 restringe la fuerza sobre personas bajo custodia a lo estrictamente necesario para la seguridad y el orden o ante peligro para la integridad física; el principio 16 regula el uso de armas de fuego en ese ámbito.', 'gc_19b_principios_onu_fuerza', (select id from public.topics where slug = 'gc-19b-principios-onu-fuerza'), 2, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement'), 'Principio 15', 'no emplearán la fuerza, salvo cuando sea estrictamente necesario para mantener la seguridad y el orden en los establecimientos o cuando corra peligro la integridad física de las personas.', null, '868062c42671c0c883d4d5e6deb7b470d503aa51383f5c93a83096b2de687ece', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '868062c42671c0c883d4d5e6deb7b470d503aa51383f5c93a83096b2de687ece')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Cuando sea estrictamente necesario para mantener la seguridad y el orden en los establecimientos o cuando corra peligro la integridad física de las personas.', true), ('B', 'Cuando la persona detenida se niegue a declarar.', false), ('C', 'Cuando lo solicite el director del establecimiento por razones disciplinarias.', false), ('D', 'Cuando sea necesario para obtener información sobre otros delitos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el principio 17 de los Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego, los principios sobre personas bajo custodia se aplicarán sin perjuicio de los derechos y obligaciones de los funcionarios de establecimientos penitenciarios enunciados en:', 'El principio 17 remite a las Reglas Mínimas para el Tratamiento de los Reclusos, reglas 33, 34 y 54, que el preámbulo cita también como precedente sobre el uso de la fuerza por los funcionarios penitenciarios.', 'gc_19b_principios_onu_fuerza', (select id from public.topics where slug = 'gc-19b-principios-onu-fuerza'), 3, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement'), 'Principio 17', 'tal como se enuncian en las Reglas Mínimas para el Tratamiento de los Reclusos, sobre todo las reglas 33, 34 y 54.', null, 'd3d695f8ad8bb14b99e77a995dcd4ab5f98037c45d72c081a1b77a95e6515092', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd3d695f8ad8bb14b99e77a995dcd4ab5f98037c45d72c081a1b77a95e6515092')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Código de Conducta para Funcionarios Encargados de Hacer Cumplir la Ley, sobre todo sus artículos 2 y 3.', false), ('B', 'Las Reglas Mínimas para el Tratamiento de los Reclusos, sobre todo las reglas 33, 34 y 54.', true), ('C', 'La Convención contra la tortura, sobre todo sus artículos 10 y 11.', false), ('D', 'El Pacto Internacional de Derechos Civiles y Políticos, sobre todo sus artículos 7 y 10.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el principio 19 de los Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego, los funcionarios que deban portar armas de fuego deben estar autorizados para hacerlo:', 'El principio 19 exige capacitación en el empleo de la fuerza, evaluación conforme a normas adecuadas y, para portar armas de fuego, haber finalizado una capacitación especializada.', 'gc_19b_principios_onu_fuerza', (select id from public.topics where slug = 'gc-19b-principios-onu-fuerza'), 1, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement'), 'Principio 19', 'Los funcionarios que deban portar armas de fuego deben estar autorizados para hacerlo sólo tras haber finalizado la capacitación especializada en su empleo.', null, '559606ab237b703fb782b90392778c8909fac32cb106d035e2b9de8e526838bc', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '559606ab237b703fb782b90392778c8909fac32cb106d035e2b9de8e526838bc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Sólo tras haber finalizado la capacitación especializada en su empleo.', true), ('B', 'Desde el momento de su nombramiento, sin otro requisito.', false), ('C', 'Tras superar un reconocimiento médico anual, sin necesidad de capacitación.', false), ('D', 'Cuando lo soliciten por escrito a su superior.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el principio 23 de los Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego, las personas afectadas por el empleo de la fuerza y de armas de fuego o sus representantes legales tendrán acceso a un proceso independiente, incluido un proceso judicial. En caso de muerte de esas personas, esta disposición se aplicará:', 'El principio 23 reconoce el acceso a un proceso independiente, incluido el judicial, a los afectados o sus representantes legales y, si fallecen, a sus herederos.', 'gc_19b_principios_onu_fuerza', (select id from public.topics where slug = 'gc-19b-principios-onu-fuerza'), 2, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement'), 'Principio 23', 'Las personas afectadas por el empleo de la fuerza y de armas de fuego o sus representantes legales tendrán acceso a un proceso independiente, incluido un proceso judicial. En caso de muerte de esas personas, esta disposición se aplicará a sus herederos.', null, 'a3b42d67b4b9c7e96c0775d27e294d9196de199032a0b7a936d998db1ad5cf2e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a3b42d67b4b9c7e96c0775d27e294d9196de199032a0b7a936d998db1ad5cf2e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Al Ministerio Fiscal exclusivamente.', false), ('B', 'A sus herederos.', true), ('C', 'A cualquier persona que tenga conocimiento de los hechos.', false), ('D', 'A las asociaciones de defensa de los derechos humanos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el principio 25 de los Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego, los gobiernos adoptarán las medidas necesarias para que no se imponga ninguna sanción penal o disciplinaria contra los funcionarios que, en cumplimiento del Código de conducta y de estos Principios:', 'El principio 25 protege frente a sanciones a quien, conforme al Código de conducta y a los Principios Básicos, se niegue a cumplir una orden de emplear la fuerza o armas de fuego o denuncie su empleo por otros funcionarios.', 'gc_19b_principios_onu_fuerza', (select id from public.topics where slug = 'gc-19b-principios-onu-fuerza'), 2, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement'), 'Principio 25', 'no se imponga ninguna sanción penal o disciplinaria contra los funcionarios encargados de hacer cumplir la ley que, en cumplimiento del Código de conducta pertinente y de estos Principios Básicos, se nieguen a ejecutar una orden de emplear la fuerza o armas de fuego o denuncien ese empleo por otros funcionarios.', null, '63fc1729bf7c3b6c0f93b457b7225572c5ac66371593b9d1876307c1512e9d93', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '63fc1729bf7c3b6c0f93b457b7225572c5ac66371593b9d1876307c1512e9d93')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Empleen armas de fuego sin advertencia previa.', false), ('B', 'Utilicen armas no autorizadas en situaciones de urgencia.', false), ('C', 'Omitan comunicar a sus superiores el empleo de la fuerza.', false), ('D', 'Se nieguen a ejecutar una orden de emplear la fuerza o armas de fuego o denuncien ese empleo por otros funcionarios.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el principio 26 de los Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego, los funcionarios encargados de hacer cumplir la ley no podrán alegar obediencia de órdenes superiores:', 'El principio 26 excluye la obediencia debida cuando la orden era manifiestamente ilícita, el funcionario lo sabía y tuvo oportunidad razonable de negarse; además, también son responsables los superiores que dieron las órdenes ilícitas.', 'gc_19b_principios_onu_fuerza', (select id from public.topics where slug = 'gc-19b-principios-onu-fuerza'), 3, 'es', true, (select id from public.sources where url = 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement'), 'Principio 26', 'no podrán alegar obediencia de órdenes superiores si tenían conocimiento de que la orden de emplear la fuerza o armas de fuego, a raíz de la cual se ha ocasionado la muerte o heridas graves a una persona, era manifiestamente ilícita y tuvieron una oportunidad razonable de negarse a cumplirla.', null, '87af37af24c57003a09ca7b2676fa7326d31cd227ecd0624c541208339f54a3e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '87af37af24c57003a09ca7b2676fa7326d31cd227ecd0624c541208339f54a3e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En ningún caso, aunque desconocieran la ilicitud de la orden.', false), ('B', 'Salvo que la orden se haya dado por escrito.', false), ('C', 'Si tenían conocimiento de que la orden de emplear la fuerza o armas de fuego, a raíz de la cual se ha ocasionado la muerte o heridas graves a una persona, era manifiestamente ilícita y tuvieron una oportunidad razonable de negarse a cumplirla.', true), ('D', 'Si la orden procedía de una autoridad judicial.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-23b-infracciones-contrabando-rdcont-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto 1649/1998, de 24 de julio, infracciones administrativas de contrabando (desarrollo del título II de la LO 12/1995) (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-23b-infracciones-contrabando', 'Tema 23. Derecho fiscal (II): infracciones administrativas de contrabando (RD 1649/1998)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-23b-infracciones-contrabando' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 1649/1998, que desarrolla el título II de la Ley Orgánica 12/1995, de represión del contrabando, las diligencias que formalizan las actuaciones de las autoridades y fuerzas serán de descubrimiento cuando:', 'El art. 23.2 RD 1649/1998 distingue entre diligencias de aprehensión (cuando al formalizarse se aprehenden los bienes, efectos o instrumentos) y de descubrimiento (cuando no hay aprehensión).', 'gc_23b_infracciones_contrabando', (select id from public.topics where slug = 'gc-23b-infracciones-contrabando'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017'), 'Art. 23.2 RD 1649/1998', 'Serán de descubrimiento cuando no tenga lugar la aprehensión de los bienes, efectos e instrumentos.', null, '6fd6ccd185d26fe3bd75d6dc1b659fff3fa88cf1275125107c98838b2d4c1a91', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6fd6ccd185d26fe3bd75d6dc1b659fff3fa88cf1275125107c98838b2d4c1a91')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En el momento de formalizarse, tenga lugar la aprehensión de los bienes, efectos o instrumentos.', false), ('B', 'Los presuntos infractores se nieguen a firmarlas.', false), ('C', 'Los hechos pudieran ser constitutivos de delito de contrabando.', false), ('D', 'No tenga lugar la aprehensión de los bienes, efectos e instrumentos.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 23 del Real Decreto 1649/1998, las diligencias de aprehensión o descubrimiento se extenderán:', 'El original se remite al órgano de la Administración aduanera que deba iniciar el procedimiento, una copia se entrega al presunto infractor y otra queda en poder de quienes suscriben la diligencia (art. 23.5).', 'gc_23b_infracciones_contrabando', (select id from public.topics where slug = 'gc-23b-infracciones-contrabando'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017'), 'Art. 23.5 RD 1649/1998', 'Las diligencias se extenderán por triplicado', null, 'b5b17c4b63878b3c3522edba886b59dca5a3f88358e136534f94dbc80cb7f2d6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b5b17c4b63878b3c3522edba886b59dca5a3f88358e136534f94dbc80cb7f2d6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por triplicado.', true), ('B', 'Por duplicado.', false), ('C', 'Por cuadruplicado.', false), ('D', 'En un único ejemplar, del que se expedirán copias a petición del interesado.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 1649/1998, es competente para acordar el cierre de establecimientos por infracciones administrativas de contrabando relacionadas con las labores del tabaco:', 'Las multas y el comiso los imponen, entre otros, los Administradores de Aduanas e Impuestos Especiales (art. 16.1), pero el cierre de establecimientos por infracciones relativas al tabaco corresponde al Director del Departamento de Aduanas e Impuestos Especiales de la AEAT (art. 16.2).', 'gc_23b_infracciones_contrabando', (select id from public.topics where slug = 'gc-23b-infracciones-contrabando'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017'), 'Art. 16.2 RD 1649/1998', 'Es competente para acordar el cierre de establecimientos por infracciones administrativas de contrabando relacionadas con las labores del tabaco, el Director del Departamento de Aduanas e Impuestos Especiales de la Agencia Estatal de Administración Tributaria.', null, '3c9bf492b580a4bb05c577cb4e527f9ad6c46ba7e25261995fde6398f44477e4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3c9bf492b580a4bb05c577cb4e527f9ad6c46ba7e25261995fde6398f44477e4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El Delegado del Gobierno en la comunidad autónoma.', false), ('B', 'El Comisionado para el Mercado de Tabacos.', false), ('C', 'El Director del Departamento de Aduanas e Impuestos Especiales de la Agencia Estatal de Administración Tributaria.', true), ('D', 'El Administrador de Aduanas e Impuestos Especiales de la provincia en la que se haya descubierto la infracción.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el Real Decreto 1649/1998, el procedimiento sancionador por infracciones administrativas de contrabando se iniciará:', 'El art. 20.1 RD 1649/1998 dispone la iniciación de oficio, por propia iniciativa del titular de la unidad instructora o como consecuencia de orden superior, petición razonada de otros órganos o denuncia.', 'gc_23b_infracciones_contrabando', (select id from public.topics where slug = 'gc-23b-infracciones-contrabando'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017'), 'Art. 20.1 RD 1649/1998', 'El procedimiento se iniciará de oficio, mediante acuerdo del titular de la unidad administrativa que instruya el expediente', null, '8130ea7cc1681226732f06eece6453ce665a91708de6d20c02d6cb9def0ea1fd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8130ea7cc1681226732f06eece6453ce665a91708de6d20c02d6cb9def0ea1fd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Siempre a instancia de parte, mediante denuncia del perjudicado.', false), ('B', 'De oficio, mediante acuerdo del titular de la unidad administrativa que instruya el expediente.', true), ('C', 'Por resolución del Ministro de Hacienda.', false), ('D', 'Por auto del juez de instrucción competente.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 1649/1998, los bienes, efectos e instrumentos definitivamente decomisados por resolución firme en procedimientos por infracción administrativa de contrabando serán adjudicados:', 'Los bienes decomisados se adjudican al Estado (art. 37.1). Solo el uso de los bienes intervenidos no enajenables queda adscrito a las fuerzas o servicios que los aprehendieron, conforme a su legislación específica (art. 37.4).', 'gc_23b_infracciones_contrabando', (select id from public.topics where slug = 'gc-23b-infracciones-contrabando'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017'), 'Art. 37.1 RD 1649/1998', 'Los bienes, efectos e instrumentos definitivamente decomisados por resolución firme en procedimientos por infracción administrativa de contrabando serán adjudicados al Estado.', null, '27342bc77efa5225f25d66c45af4389e206ae880a3ea6982ee9c880da209ddb9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '27342bc77efa5225f25d66c45af4389e206ae880a3ea6982ee9c880da209ddb9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A la comunidad autónoma en cuyo territorio se cometió la infracción.', false), ('B', 'Al Estado.', true), ('C', 'A las fuerzas que hayan procedido a su aprehensión.', false), ('D', 'Al ayuntamiento del lugar de la aprehensión.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Cuál de los siguientes es uno de los criterios de graduación de las sanciones por infracciones administrativas de contrabando del artículo 6 del Real Decreto 1649/1998?', 'El art. 6.1 RD 1649/1998 recoge la reiteración; la resistencia u obstrucción a la acción investigadora; los medios fraudulentos o persona interpuesta; la facilidad especial para cometer la infracción; el uso de mecanismos aduaneros de simplificación, y la naturaleza de los bienes. Los mismos criterios figuran en el art. 12 bis de la LO 12/1995.', 'gc_23b_infracciones_contrabando', (select id from public.topics where slug = 'gc-23b-infracciones-contrabando'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017'), 'Art. 6.1 RD 1649/1998', 'Las sanciones por infracciones administrativas de contrabando se graduarán atendiendo en cada caso concreto a los siguientes criterios: a) La reiteración.', null, '7dc3c75caa2937f6ca662d45d51c230c972fdbecc9598b8212c578920c408a8d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7dc3c75caa2937f6ca662d45d51c230c972fdbecc9598b8212c578920c408a8d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La edad del infractor.', false), ('B', 'El arrepentimiento espontáneo.', false), ('C', 'La reiteración.', true), ('D', 'La cuantía de los ingresos anuales del infractor.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 22 del Real Decreto 1649/1998, las diligencias formalizadas por las autoridades y fuerzas se remitirán al órgano al que corresponda iniciar el procedimiento sancionador:', 'El art. 22.5 RD 1649/1998 obliga a remitir las diligencias en 48 horas, poniendo a disposición del órgano competente los bienes, efectos o instrumentos aprehendidos.', 'gc_23b_infracciones_contrabando', (select id from public.topics where slug = 'gc-23b-infracciones-contrabando'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017'), 'Art. 22.5 RD 1649/1998', 'se remitirán, dentro de las cuarenta y ocho horas siguientes al momento en que se formalicen, al órgano al que corresponda iniciar el procedimiento sancionador', null, '850da08794dbf2e0603cf4927f958e0ac2e9c0df311b4f2460fafb3c25034c18', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '850da08794dbf2e0603cf4927f958e0ac2e9c0df311b4f2460fafb3c25034c18')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Dentro de las veinticuatro horas siguientes al momento en que se formalicen.', false), ('B', 'Dentro de las setenta y dos horas siguientes al momento en que se formalicen.', false), ('C', 'En el plazo de diez días desde su formalización.', false), ('D', 'Dentro de las cuarenta y ocho horas siguientes al momento en que se formalicen.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el Real Decreto 1649/1998, los interesados disponen, para aportar alegaciones, documentos o informaciones y, en su caso, proponer prueba, de un plazo de:', 'El art. 31 RD 1649/1998 fija 15 días para alegaciones tras la notificación del acuerdo de iniciación; el trámite de audiencia previo a la propuesta de resolución también es de 15 días (art. 33).', 'gc_23b_infracciones_contrabando', (select id from public.topics where slug = 'gc-23b-infracciones-contrabando'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017'), 'Art. 31 RD 1649/1998', 'los interesados dispondrán de un plazo de quince días desde el día siguiente a la notificación de la iniciación', null, '5f7cb598f9d186dd23ce2ac19388d72ffe9c98b2fe09cb08fa99e64cf0cc81b3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5f7cb598f9d186dd23ce2ac19388d72ffe9c98b2fe09cb08fa99e64cf0cc81b3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Quince días desde el día siguiente a la notificación de la iniciación.', true), ('B', 'Diez días desde el día siguiente a la notificación de la iniciación.', false), ('C', 'Un mes desde la notificación de la iniciación.', false), ('D', 'Veinte días desde la formalización de la diligencia de aprehensión.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 1649/1998, el período de prueba que puede acordar el órgano instructor tendrá un plazo:', 'Recibidas las alegaciones o transcurrido su plazo, el instructor puede abrir un período de prueba de entre 10 y 30 días (art. 32.1).', 'gc_23b_infracciones_contrabando', (select id from public.topics where slug = 'gc-23b-infracciones-contrabando'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017'), 'Art. 32.1 RD 1649/1998', 'por un plazo no superior a treinta días ni inferior a diez.', null, 'cf8858f1450c67957478c8c30d37adb6046b2a112d97ad066668669c1cec8921', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'cf8858f1450c67957478c8c30d37adb6046b2a112d97ad066668669c1cec8921')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No superior a quince días ni inferior a cinco.', false), ('B', 'No superior a treinta días ni inferior a diez.', true), ('C', 'No superior a dos meses ni inferior a quince días.', false), ('D', 'De veinte días, improrrogable.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 35 del Real Decreto 1649/1998, el plazo máximo para resolver el procedimiento sancionador por infracción administrativa de contrabando será de:', 'El art. 35.5 RD 1649/1998 fija seis meses desde el acuerdo de iniciación, sin computar las interrupciones imputables a los interesados ni la suspensión por prejudicialidad penal (art. 17).', 'gc_23b_infracciones_contrabando', (select id from public.topics where slug = 'gc-23b-infracciones-contrabando'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017'), 'Art. 35.5 RD 1649/1998', 'El plazo máximo para resolver el procedimiento será de seis meses desde la fecha del acuerdo de iniciación.', null, 'dd13a545d74e7d8256bf9fc79e1e59a799b30bf4c9e8c59fae5b9efac02c49d3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'dd13a545d74e7d8256bf9fc79e1e59a799b30bf4c9e8c59fae5b9efac02c49d3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres meses desde la fecha del acuerdo de iniciación.', false), ('B', 'Un año desde la fecha de la diligencia de aprehensión.', false), ('C', 'Seis meses desde la notificación de la propuesta de resolución.', false), ('D', 'Seis meses desde la fecha del acuerdo de iniciación.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 1649/1998, las diligencias formalizadas observando los requisitos señalados en el artículo 23.3:', 'El art. 23.6 RD 1649/1998 reconoce a estas diligencias carácter de documento público y valor probatorio, sin perjuicio de las pruebas que en defensa de sus derechos puedan señalar o aportar los interesados.', 'gc_23b_infracciones_contrabando', (select id from public.topics where slug = 'gc-23b-infracciones-contrabando'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017'), 'Art. 23.6 RD 1649/1998', 'tendrán el carácter de documento público y valor probatorio sin perjuicio de las pruebas que en defensa de sus respectivos derechos e intereses puedan señalar o aportar los propios interesados.', null, '6a8daf866cd97fd200c6c8df836427103fdc6333a4f55c116dc700fc3f11bdea', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6a8daf866cd97fd200c6c8df836427103fdc6333a4f55c116dc700fc3f11bdea')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tendrán el carácter de documento público y valor probatorio, sin perjuicio de las pruebas que puedan aportar los interesados.', true), ('B', 'Tendrán presunción de veracidad que no admite prueba en contrario.', false), ('C', 'Carecen de valor probatorio hasta que sean ratificadas por sus autores ante el instructor.', false), ('D', 'Solo tienen valor como denuncia, sin eficacia probatoria.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 24 del Real Decreto 1649/1998, cuando los bienes aprehendidos sean labores de tabaco, se entregarán:', 'El art. 24.a) RD 1649/1998 remite a las normas de los monopolios públicos y ordena la entrega de las labores de tabaco o géneros estancados al Comisionado para el Mercado de Tabacos o a los representantes de dichos monopolios.', 'gc_23b_infracciones_contrabando', (select id from public.topics where slug = 'gc-23b-infracciones-contrabando'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017'), 'Art. 24.a) RD 1649/1998', 'Cuando se trate de labores de tabaco o de otros géneros o efectos estancados, se procederá en la forma que indiquen las disposiciones reguladoras de los respectivos monopolios públicos, entregándose los mismos al Comisionado para el Mercado de Tabacos', null, '8e4b11a884f7361863bb26ec3546d699745b51c3bdbf9f8b3e79e0a320dc0463', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8e4b11a884f7361863bb26ec3546d699745b51c3bdbf9f8b3e79e0a320dc0463')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A la Dirección General de la Guardia Civil, para su custodia.', false), ('B', 'Al Departamento de Aduanas e Impuestos Especiales, para su destrucción inmediata.', false), ('C', 'Al Comisionado para el Mercado de Tabacos.', true), ('D', 'A la Delegación del Ministerio de Economía y Hacienda.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el Real Decreto 1649/1998, la sentencia condenatoria de la autoridad judicial por los mismos hechos:', 'Si el órgano competente estima que los hechos pueden ser delito, pasa el tanto de culpa y se abstiene de seguir; la sentencia condenatoria excluye la sanción administrativa (art. 17.5), en línea con el principio de no concurrencia del art. 14 bis de la LO 12/1995.', 'gc_23b_infracciones_contrabando', (select id from public.topics where slug = 'gc-23b-infracciones-contrabando'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017'), 'Art. 17.5 RD 1649/1998', 'La sentencia condenatoria de la autoridad judicial excluirá la imposición de sanción por infracción administrativa de contrabando.', null, 'e948f5e84b75bb25edfa825c7fc6dd9f0ada26e061dcc4b873f14b6cc9ae4ef4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e948f5e84b75bb25edfa825c7fc6dd9f0ada26e061dcc4b873f14b6cc9ae4ef4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Permitirá imponer además la sanción administrativa, reducida a la mitad.', false), ('B', 'Obligará a la Administración aduanera a imponer la sanción en su grado máximo.', false), ('C', 'No afecta al procedimiento administrativo, que es independiente del penal.', false), ('D', 'Excluirá la imposición de sanción por infracción administrativa de contrabando.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 20 del Real Decreto 1649/1998, el acuerdo de iniciación del procedimiento sancionador podrá basarse, entre otras, en la actuación de:', 'El art. 20.2 RD 1649/1998 cita los órganos de la administración aduanera; las fuerzas de la Guardia Civil que cumplan funciones de resguardo fiscal y persecución del contrabando y otras autoridades con competencias específicas; las demás Fuerzas y Cuerpos de Seguridad, y las autoridades militares.', 'gc_23b_infracciones_contrabando', (select id from public.topics where slug = 'gc-23b-infracciones-contrabando'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017'), 'Art. 20.2.b) RD 1649/1998', 'b) Las fuerzas de la Guardia Civil, que cumplan funciones propias del resguardo fiscal del Estado y las actuaciones encaminadas a evitar y perseguir el contrabando', null, 'c7fbdd42346995165092fa696667f8089bdcfafce0e10095a1b3bce8da148ae9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c7fbdd42346995165092fa696667f8089bdcfafce0e10095a1b3bce8da148ae9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Las policías locales, con carácter exclusivo.', false), ('B', 'Las empresas de seguridad privada que presten servicio en recintos aduaneros.', false), ('C', 'Las fuerzas de la Guardia Civil que cumplan funciones propias del resguardo fiscal del Estado.', true), ('D', 'Los órganos jurisdiccionales del orden contencioso-administrativo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 14 del Real Decreto 1649/1998, no se procederá al comiso de los bienes, efectos e instrumentos del contrabando cuando:', 'Toda sanción por infracción administrativa de contrabando lleva consigo el comiso (art. 14.1), salvo que los bienes sean de lícito comercio y los haya adquirido un tercero de buena fe (art. 14.2).', 'gc_23b_infracciones_contrabando', (select id from public.topics where slug = 'gc-23b-infracciones-contrabando'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017'), 'Art. 14.2 RD 1649/1998', 'No se procederá al comiso de los bienes, efectos e instrumentos del contrabando, cuando éstos sean de lícito comercio y hayan sido adquiridos por un tercero de buena fe.', null, 'bc07bcd111da9d6445ce113cb185d5d964b7e469ba3baa02b284d7084f9939b4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'bc07bcd111da9d6445ce113cb185d5d964b7e469ba3baa02b284d7084f9939b4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Su valor sea inferior al de la multa impuesta.', false), ('B', 'Sean de lícito comercio y hayan sido adquiridos por un tercero de buena fe.', true), ('C', 'El infractor reconozca voluntariamente su responsabilidad.', false), ('D', 'Se trate de géneros estancados o prohibidos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Real Decreto 1649/1998, transcurrido el plazo máximo para resolver, el procedimiento se entenderá caducado y se procederá al archivo de las actuaciones:', 'El plazo de seis meses puede prorrogarse una sola vez por otros seis; transcurridos treinta días desde su vencimiento sin resolución, el procedimiento caduca y se archiva, de oficio o a instancia del interesado, sin impedir iniciar uno nuevo si no ha prescrito la acción (art. 35.5).', 'gc_23b_infracciones_contrabando', (select id from public.topics where slug = 'gc-23b-infracciones-contrabando'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017'), 'Art. 35.5 RD 1649/1998', 'Transcurridos treinta días desde el vencimiento del plazo sin que la resolución haya sido dictada se entenderá caducado el procedimiento y se procederá al archivo de las actuaciones', null, '029c6ff1e0050abbc9a24730a7c5bac2a458ddbae7014b17ff557e3390120b80', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '029c6ff1e0050abbc9a24730a7c5bac2a458ddbae7014b17ff557e3390120b80')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Transcurridos treinta días desde el vencimiento del plazo sin que la resolución haya sido dictada.', true), ('B', 'De forma automática, el mismo día del vencimiento del plazo.', false), ('C', 'Transcurridos quince días desde el vencimiento del plazo, solo a instancia del interesado.', false), ('D', 'Transcurridos tres meses desde el vencimiento del plazo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el artículo 23 del Real Decreto 1649/1998, si los presuntos sujetos infractores no saben o no quieren firmar la diligencia de aprehensión o descubrimiento, esta será suscrita:', 'Las diligencias las suscriben los aprehensores o descubridores y los presuntos infractores; en defecto de estos, o si no saben o no quieren firmar, dos testigos si los hubiese, haciendo constar la circunstancia (art. 23.4).', 'gc_23b_infracciones_contrabando', (select id from public.topics where slug = 'gc-23b-infracciones-contrabando'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017'), 'Art. 23.4 RD 1649/1998', 'y en defecto de éstos o si no saben o no quieren firmar, por dos testigos, si los hubiese, haciendo constar esta circunstancia.', null, 'a92134dbec5b7422a840c752ece9ef5248e271138444fc5e6910db3a252007e8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a92134dbec5b7422a840c752ece9ef5248e271138444fc5e6910db3a252007e8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Por un testigo y por el jefe de la unidad aprehensora.', false), ('B', 'Por el instructor del expediente, en el momento de recibirla.', false), ('C', 'Por dos testigos, si los hubiese, haciendo constar esta circunstancia.', true), ('D', 'Por un fedatario público requerido al efecto.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 6 del Real Decreto 1649/1998, para la aplicación de los criterios de graduación de las sanciones por infracciones administrativas de contrabando:', 'El art. 6.3 RD 1649/1998 ordena partir del límite inferior y aplicar los criterios simultáneamente; si la sanción ya ha alcanzado su límite superior o inferior, se aplica en dicho límite (art. 6.4 y 6.5).', 'gc_23b_infracciones_contrabando', (select id from public.topics where slug = 'gc-23b-infracciones-contrabando'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017'), 'Art. 6.3 RD 1649/1998', 'Para la aplicación de los criterios de graduación se partirá de la sanción en su límite inferior. Los criterios de graduación son aplicables simultáneamente.', null, '654feb38f678badcd5aa2ae330e376ef8a3ce6b5c3f17d67addddbe8ede38838', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '654feb38f678badcd5aa2ae330e376ef8a3ce6b5c3f17d67addddbe8ede38838')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se partirá de la sanción en su límite inferior, y los criterios son aplicables simultáneamente.', true), ('B', 'Se partirá de la sanción en su grado medio, y los criterios son excluyentes entre sí.', false), ('C', 'Se partirá de la sanción en su límite superior, que se reducirá por las circunstancias atenuantes.', false), ('D', 'Se aplicará un único criterio, el más favorable al infractor.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 22 del Real Decreto 1649/1998, las demás Fuerzas y Cuerpos de Seguridad y las autoridades militares podrán realizar actuaciones previas a la iniciación del procedimiento, entre otros casos:', 'El art. 22.2 RD 1649/1998 les permite actuar cuando sean requeridas por urgencia por los funcionarios y fuerzas encargados de perseguir el contrabando, cuando sorprendan a los infractores en el momento de cometer la infracción o cuando puedan aprehender preventivamente los bienes en ausencia de aquellos.', 'gc_23b_infracciones_contrabando', (select id from public.topics where slug = 'gc-23b-infracciones-contrabando'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017'), 'Art. 22.2 RD 1649/1998', 'b) Cuando sorprendan a los infractores en el momento de cometer la infracción.', null, '143a6aef234b49932add6c413fb26b5c0ca5a4a54ebdeaa946ecc7098115ae41', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '143a6aef234b49932add6c413fb26b5c0ca5a4a54ebdeaa946ecc7098115ae41')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Únicamente cuando lo ordene el Delegado de Economía y Hacienda.', false), ('B', 'Solo cuando el valor de las mercancías supere el límite del delito.', false), ('C', 'Cuando lo soliciten los interesados para evitar el comiso.', false), ('D', 'Cuando sorprendan a los infractores en el momento de cometer la infracción.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'De acuerdo con el Real Decreto 1649/1998, la acumulación de expedientes que guarden conexión directa entre sí:', 'La acumulación puede acordarse de oficio o a instancia de los interesados cuando todos los expedientes correspondan a la misma Administración (art. 26.1), y no implica acumular el valor de las mercancías en un único expediente (art. 26.2).', 'gc_23b_infracciones_contrabando', (select id from public.topics where slug = 'gc-23b-infracciones-contrabando'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017'), 'Art. 26.2 RD 1649/1998', 'Esta acumulación se efectuará a los solos efectos de la tramitación del expediente y de la imposición de las sanciones, sin que en ningún caso suponga la acumulación del valor de los bienes, mercancías, géneros a efectos en un único expediente.', null, '81b1c87ebdd793fb9c8b65cff95517a81766387cf7e06ec0383fc5e10144e84c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '81b1c87ebdd793fb9c8b65cff95517a81766387cf7e06ec0383fc5e10144e84c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Supone sumar el valor de todos los bienes para calificar la infracción en un único expediente.', false), ('B', 'Se efectuará a los solos efectos de la tramitación del expediente y de la imposición de las sanciones, sin que suponga la acumulación del valor de los bienes en un único expediente.', true), ('C', 'Solo puede acordarse a instancia de los interesados.', false), ('D', 'Solo procede cuando los expedientes correspondan a distintas Administraciones de Aduanas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gc-23c-codigo-aduanero-eu_cau-v1 (20 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Reglamento (UE) n.º 952/2013, por el que se establece el código aduanero de la Unión (texto consolidado a 12.12.2022): títulos I (caps. 1-2, secc. 1-2), III (cap. 1), VI (caps. 1-2), VII (caps. 1-2) y VIII (caps. 1-4)', 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212', 'web_oficial'::public.source_kind, 'Unión Europea · EUR-Lex (DOUE L 269 de 10.10.2013 y modificaciones)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-23c-codigo-aduanero', 'Tema 23. Derecho fiscal (III): código aduanero de la Unión (Reglamento (UE) 952/2013)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-23c-codigo-aduanero' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 1 del Reglamento (UE) n.º 952/2013, por el que se establece el código aduanero de la Unión, el código:', 'El art. 1.1 del código aduanero de la Unión (CAU) dispone que contiene las disposiciones y procedimientos generales para las mercancías que entran en el territorio aduanero de la Unión o salen de él, y que se aplica de manera uniforme en todo ese territorio. Al ser un reglamento, es directamente aplicable y no requiere transposición. El Reglamento 952/2013 seguirá aplicándose hasta que lo sustituya el Reglamento (UE) 2026/2108 (fin de validez en EUR-Lex: 20/09/2027).', 'gc_23c_codigo_aduanero', (select id from public.topics where slug = 'gc-23c-codigo-aduanero'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212'), 'Art. 1.1 Rgto. (UE) 952/2013', 'Sin perjuicio del Derecho y de los convenios internacionales y de la normativa de la Unión aplicable a otros ámbitos, el código se aplicará de manera uniforme en todo el territorio aduanero de la Unión.', null, '423954ae8126e375a2f5057f93821b676eab61bb62da7eab8f1c8da27be4f06c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '423954ae8126e375a2f5057f93821b676eab61bb62da7eab8f1c8da27be4f06c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se aplicará en cada Estado miembro según lo que disponga su legislación nacional de transposición.', false), ('B', 'Solo se aplicará a las mercancías que salgan del territorio aduanero de la Unión.', false), ('C', 'Se aplicará de manera uniforme en todo el territorio aduanero de la Unión.', true), ('D', 'Se aplicará únicamente en los Estados miembros cuya moneda es el euro.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 4 del código aduanero de la Unión, el territorio del Reino de España forma parte del territorio aduanero de la Unión salvo:', 'El art. 4.1 del Reglamento 952/2013 incluye en el territorio aduanero de la Unión el del Reino de España salvo Ceuta y Melilla (incluidos el mar territorial, las aguas interiores y el espacio aéreo). Las Islas Canarias sí forman parte del territorio aduanero.', 'gc_23c_codigo_aduanero', (select id from public.topics where slug = 'gc-23c-codigo-aduanero'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212'), 'Art. 4.1 Rgto. (UE) 952/2013', 'el territorio del Reino de España, salvo Ceuta y Melilla,', null, 'c9c5e075c9dfc9d3871f1c2908c8bf6d2c006cd29d62b97649e7f3db2c42f39c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c9c5e075c9dfc9d3871f1c2908c8bf6d2c006cd29d62b97649e7f3db2c42f39c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ceuta y Melilla.', true), ('B', 'Las Islas Canarias.', false), ('C', 'Las Islas Canarias, Ceuta y Melilla.', false), ('D', 'Ceuta, Melilla y las Islas Baleares.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 3 del código aduanero de la Unión, las autoridades aduaneras serán responsables de:', 'El art. 3 encomienda a las autoridades aduaneras supervisar el comercio internacional de la Unión y adoptar medidas para proteger sus intereses financieros, protegerla del comercio desleal e ilegal, garantizar la seguridad y protección (también del medio ambiente) y equilibrar controles y facilitación del comercio legítimo.', 'gc_23c_codigo_aduanero', (select id from public.topics where slug = 'gc-23c-codigo-aduanero'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212'), 'Art. 3 Rgto. (UE) 952/2013', 'Las autoridades aduaneras serán responsables de supervisar el comercio internacional de la Unión', null, '4b55b6d0f5f6fcfca4d86ed01b403fb2e58191d4a7b168ed68d272d401129170', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4b55b6d0f5f6fcfca4d86ed01b403fb2e58191d4a7b168ed68d272d401129170')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Fijar el arancel aduanero común.', false), ('B', 'Supervisar el comercio internacional de la Unión.', true), ('C', 'Recaudar el impuesto sobre el valor añadido de las operaciones interiores.', false), ('D', 'Negociar los acuerdos comerciales de la Unión con terceros países.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 5 del código aduanero de la Unión, tienen la consideración de «mercancías de la Unión», entre otras, las que:', 'El art. 5.23 considera mercancías de la Unión las obtenidas enteramente en el territorio aduanero de la Unión, las procedentes de fuera que se despachan a libre práctica y las obtenidas en la Unión a partir de estas. Las mercancías en depósito temporal o en tránsito externo son mercancías no pertenecientes a la Unión (arts. 5.17 y 226).', 'gc_23c_codigo_aduanero', (select id from public.topics where slug = 'gc-23c-codigo-aduanero'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212'), 'Art. 5.23 Rgto. (UE) 952/2013', 'b) se introduzcan en el territorio aduanero de la Unión procedentes de países o territorios situados fuera de dicho territorio y se despachen a libre práctica;', null, '11508fe26c9070c8c561b9d11cc695645f5aaa90e4aef48c42613517f36547df', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '11508fe26c9070c8c561b9d11cc695645f5aaa90e4aef48c42613517f36547df')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se encuentren en depósito temporal en el territorio aduanero de la Unión.', false), ('B', 'Circulen por el territorio aduanero de la Unión al amparo del régimen de tránsito externo.', false), ('C', 'Se fabriquen fuera de la Unión por empresas establecidas en el territorio aduanero de la Unión.', false), ('D', 'Se introduzcan en el territorio aduanero de la Unión procedentes de países o territorios situados fuera de dicho territorio y se despachen a libre práctica.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 18 del código aduanero de la Unión, en la representación aduanera indirecta el representante aduanero actúa:', 'El art. 18.1 distingue dos tipos de representación: directa (en nombre y por cuenta de otra persona) e indirecta (en nombre propio pero por cuenta de otra persona). Toda persona puede nombrar a un representante aduanero, que debe estar establecido, como regla, en el territorio aduanero de la Unión (art. 18.2).', 'gc_23c_codigo_aduanero', (select id from public.topics where slug = 'gc-23c-codigo-aduanero'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212'), 'Art. 18.1 Rgto. (UE) 952/2013', 'Esta representación podrá ser directa, en cuyo caso el representante aduanero actuará en nombre y por cuenta de otra persona, o indirecta, en cuyo caso actuará en su propio nombre pero por cuenta de otra persona.', null, '41785bbde733d8c0ab3ae3b4d54c1fa76c34a40e880dd265fadce9c971cee7fc', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '41785bbde733d8c0ab3ae3b4d54c1fa76c34a40e880dd265fadce9c971cee7fc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'En nombre y por cuenta de otra persona.', false), ('B', 'En nombre de otra persona pero por cuenta propia.', false), ('C', 'En su propio nombre pero por cuenta de otra persona.', true), ('D', 'En su propio nombre y por cuenta propia.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 19 del código aduanero de la Unión, quien declare estar actuando como representante aduanero sin poseer un poder de representación para ello:', 'El art. 19.1 obliga al representante a declarar que actúa por cuenta de otro y si la representación es directa o indirecta; quien omita declararlo o lo declare sin poder de representación se considera que actúa en su propio nombre y por cuenta propia.', 'gc_23c_codigo_aduanero', (select id from public.topics where slug = 'gc-23c-codigo-aduanero'), 3, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212'), 'Art. 19.1 Rgto. (UE) 952/2013', 'Quien omita declarar que está actuando como representante aduanero o declare estar actuando en tal condición sin poseer un poder de representación para ello, se considerará que actúa en su propio nombre y por cuenta propia.', null, '6b79cdfbfaef0f04a46953ff23730e96a83addbd439ed6e1de6b25c2c131e5eb', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6b79cdfbfaef0f04a46953ff23730e96a83addbd439ed6e1de6b25c2c131e5eb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se considerará que actúa en representación indirecta de la persona por cuya cuenta declara.', false), ('B', 'Verá anulada de oficio la declaración presentada, sin más efectos.', false), ('C', 'Se considerará que actúa en representación directa, si la persona representada ratifica después su actuación.', false), ('D', 'Se considerará que actúa en su propio nombre y por cuenta propia.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 77 del código aduanero de la Unión, la deuda aduanera de importación nacida al incluir mercancías no pertenecientes a la Unión en el régimen de despacho a libre práctica se origina en el momento:', 'El art. 77.1 hace nacer la deuda aduanera de importación al incluir las mercancías en el despacho a libre práctica o en la importación temporal con exención parcial, y el art. 77.2 fija su nacimiento en la admisión de la declaración en aduana. La misma regla rige para la deuda de exportación (art. 81.2).', 'gc_23c_codigo_aduanero', (select id from public.topics where slug = 'gc-23c-codigo-aduanero'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212'), 'Art. 77.2 Rgto. (UE) 952/2013', 'La deuda aduanera se originará en el momento de la admisión de la declaración en aduana.', null, '36204d9c1f7a8ea801fb5ac1ebf95a166d360b37493817fc6573927937a2a467', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '36204d9c1f7a8ea801fb5ac1ebf95a166d360b37493817fc6573927937a2a467')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'De la admisión de la declaración en aduana.', true), ('B', 'De la presentación de las mercancías en aduana.', false), ('C', 'Del levante de las mercancías.', false), ('D', 'De la presentación de la declaración sumaria de entrada.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Conforme al artículo 77 del código aduanero de la Unión, en la deuda aduanera de importación nacida por despacho a libre práctica, cuando la declaración se presente mediante representación indirecta, será deudor:', 'El art. 77.3 establece que el declarante es el deudor y que, en la representación indirecta, también lo es la persona por cuya cuenta se hace la declaración; además, es deudor quien suministró información que sabía o debía saber que era falsa.', 'gc_23c_codigo_aduanero', (select id from public.topics where slug = 'gc-23c-codigo-aduanero'), 3, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212'), 'Art. 77.3 Rgto. (UE) 952/2013', 'El declarante será el deudor. En caso de representación indirecta, será también deudora la persona por cuya cuenta se haga la declaración en aduana.', null, '543e45dac1d227f41dde239202217a32cce830a19f5c146b1afb3a942d438b8a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '543e45dac1d227f41dde239202217a32cce830a19f5c146b1afb3a942d438b8a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Únicamente la persona por cuya cuenta se haga la declaración en aduana.', false), ('B', 'El declarante y, también, la persona por cuya cuenta se haga la declaración en aduana.', true), ('C', 'Únicamente el representante aduanero, como declarante.', false), ('D', 'El transportista que introdujo las mercancías en el territorio aduanero de la Unión.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 82 del código aduanero de la Unión, cuando nace una deuda aduanera de exportación por incumplimiento de una obligación establecida para la salida de las mercancías, uno de los momentos en que nace la deuda es:', 'El art. 82.2 fija el nacimiento de la deuda de exportación por incumplimiento en la salida efectiva sin declaración en aduana, en la llegada a un destino distinto del autorizado con exención o, si no puede determinarse, al vencer el plazo para probar las condiciones de la exención.', 'gc_23c_codigo_aduanero', (select id from public.topics where slug = 'gc-23c-codigo-aduanero'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212'), 'Art. 82.2.a) Rgto. (UE) 952/2013', 'a) el momento en que las mercancías salgan efectivamente del territorio aduanero de la Unión sin una declaración en aduana;', null, 'c1d619d3ec275930ccd0cfe36fa9a57b2c95bd00b9586dad2061fee8fae8153b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c1d619d3ec275930ccd0cfe36fa9a57b2c95bd00b9586dad2061fee8fae8153b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El momento en que se presente la declaración sumaria de salida.', false), ('B', 'El momento en que las mercancías salgan efectivamente del territorio aduanero de la Unión sin una declaración en aduana.', true), ('C', 'El momento en que las mercancías sean presentadas en la aduana de salida.', false), ('D', 'El momento en que se inicie un procedimiento sancionador por contrabando.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 201 del código aduanero de la Unión, el despacho a libre práctica conferirá a las mercancías no pertenecientes a la Unión:', 'El art. 201 dispone que las mercancías destinadas al mercado o al consumo en la Unión se incluyen en el despacho a libre práctica, que implica percibir los derechos de importación y otros gravámenes, aplicar medidas de política comercial y prohibiciones, y cumplir las formalidades; y que confiere el estatuto aduanero de mercancías de la Unión.', 'gc_23c_codigo_aduanero', (select id from public.topics where slug = 'gc-23c-codigo-aduanero'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212'), 'Art. 201.3 Rgto. (UE) 952/2013', 'El despacho a libre práctica conferirá a las mercancías no pertenecientes a la Unión el estatuto aduanero de mercancías de la Unión.', null, '77f8935478eee706823690db41dedc531f92f8ac5afeeaf95a8b24ab6ee9e13f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '77f8935478eee706823690db41dedc531f92f8ac5afeeaf95a8b24ab6ee9e13f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El origen preferencial de la Unión.', false), ('B', 'La exención de los derechos de importación.', false), ('C', 'El estatuto aduanero de mercancías de la Unión.', true), ('D', 'La condición de mercancías en depósito temporal.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 203 del código aduanero de la Unión, quedarán exentas de derechos de importación, previa solicitud, las mercancías de retorno que, exportadas inicialmente como mercancías de la Unión, se reintroduzcan y declaren para su despacho a libre práctica en un plazo de:', 'El art. 203 regula las mercancías de retorno: plazo de tres años (superable por circunstancias especiales, apartado 2) y exención solo si se devuelven en el mismo estado en que se exportaron (apartado 5).', 'gc_23c_codigo_aduanero', (select id from public.topics where slug = 'gc-23c-codigo-aduanero'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212'), 'Art. 203.1 Rgto. (UE) 952/2013', 'Previa solicitud del interesado, quedarán exentas de derechos de importación las mercancías no pertenecientes a la Unión que, tras haber sido inicialmente exportadas fuera del territorio aduanero de esta última como mercancías de la Unión, se reintroduzcan y declaren para su despacho a libre práctica en dicho territorio en un plazo de tres años.', null, '0a4cababad11993c3e8f5b7a876be730c320248e6162efea47af96faf25ca7b2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0a4cababad11993c3e8f5b7a876be730c320248e6162efea47af96faf25ca7b2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tres años, que podrá superarse atendiendo a circunstancias especiales.', true), ('B', 'Un año, improrrogable.', false), ('C', 'Cinco años, que podrá superarse atendiendo a circunstancias especiales.', false), ('D', 'Dos años, improrrogable.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 208 del código aduanero de la Unión, están exentos de derechos de importación al despacharse a libre práctica los productos de la pesca marítima extraídos de las aguas territoriales de un país situado fuera del territorio aduanero de la Unión por buques:', 'El art. 208.1 exige buques exclusivamente matriculados o registrados en un Estado miembro y con pabellón de ese Estado; la exención alcanza también a los productos obtenidos a bordo de buques factoría que cumplan esas condiciones, y debe justificarse con pruebas (apartado 2).', 'gc_23c_codigo_aduanero', (select id from public.topics where slug = 'gc-23c-codigo-aduanero'), 3, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212'), 'Art. 208.1 Rgto. (UE) 952/2013', 'a) los productos de la pesca marítima y los demás productos extraídos de las aguas territoriales de un país o territorio situado fuera del territorio aduanero de la Unión por buques exclusivamente matriculados o registrados en un Estado miembro y que enarbolen pabellón de dicho Estado;', null, '940d5a32d14a002b76510f399b558d9a5ce8151a145f3ca739141a3def6918fd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '940d5a32d14a002b76510f399b558d9a5ce8151a145f3ca739141a3def6918fd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Matriculados en cualquier país, siempre que su armador esté establecido en la Unión.', false), ('B', 'Que enarbolen pabellón de un Estado miembro, aunque estén matriculados en un tercer país.', false), ('C', 'Que descarguen la captura en un puerto de la Unión en un plazo de tres días.', false), ('D', 'Exclusivamente matriculados o registrados en un Estado miembro y que enarbolen pabellón de dicho Estado.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 210 del código aduanero de la Unión, la categoría de regímenes especiales denominada «depósito» incluye:', 'El art. 210 agrupa los regímenes especiales en cuatro categorías: tránsito (interno y externo), depósito (depósito aduanero y zonas francas), destinos especiales (importación temporal y destino final) y perfeccionamiento (activo y pasivo). El depósito temporal no es un régimen aduanero sino una situación (art. 5.17).', 'gc_23c_codigo_aduanero', (select id from public.topics where slug = 'gc-23c-codigo-aduanero'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212'), 'Art. 210 Rgto. (UE) 952/2013', 'b) el depósito, que incluirá el depósito aduanero y las zonas francas;', null, 'b9ce452606ce57643492066b8573b6c84904b5e98561685a596331725d9fddb7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b9ce452606ce57643492066b8573b6c84904b5e98561685a596331725d9fddb7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El depósito aduanero y las zonas francas.', true), ('B', 'La importación temporal y el destino final.', false), ('C', 'El depósito aduanero y el depósito temporal.', false), ('D', 'El tránsito interno y el tránsito externo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 211 del código aduanero de la Unión, ¿para cuál de los siguientes regímenes especiales se requiere autorización de las autoridades aduaneras?', 'El art. 211.1 exige autorización para utilizar el perfeccionamiento activo o pasivo, la importación temporal y el destino final, y para explotar instalaciones de depósito aduanero (salvo que el operador sea la propia autoridad aduanera). El tránsito y las zonas francas no figuran en esa lista.', 'gc_23c_codigo_aduanero', (select id from public.topics where slug = 'gc-23c-codigo-aduanero'), 3, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212'), 'Art. 211.1 Rgto. (UE) 952/2013', 'a) la utilización de regímenes de perfeccionamiento activo o pasivo, de importación temporal y de destino final;', null, 'e59ad1afbcc87c3fd6ac145851d5a2c210694a3659196f2862121752b1ea465a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e59ad1afbcc87c3fd6ac145851d5a2c210694a3659196f2862121752b1ea465a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El tránsito externo.', false), ('B', 'La importación temporal.', true), ('C', 'El tránsito interno.', false), ('D', 'La zona franca.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 226 del código aduanero de la Unión, en el marco del régimen de tránsito externo, las mercancías no pertenecientes a la Unión podrán circular de un punto a otro dentro del territorio aduanero de la Unión sin estar sujetas, entre otros, a:', 'El art. 226.1 permite la circulación en tránsito externo sin derechos de importación, sin otros gravámenes y sin medidas de política comercial, salvo las que prohíban la entrada o salida de las mercancías.', 'gc_23c_codigo_aduanero', (select id from public.topics where slug = 'gc-23c-codigo-aduanero'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212'), 'Art. 226.1 Rgto. (UE) 952/2013', 'En el marco del régimen de tránsito externo, las mercancías no pertenecientes a la Unión podrán circular de un punto a otro dentro del territorio aduanero de la Unión sin estar sujetas: a) a derechos de importación;', null, '5d942a4b3280ea5c576070603d61eaec1f05bce6176f9322a971a6c09a707f34', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5d942a4b3280ea5c576070603d61eaec1f05bce6176f9322a971a6c09a707f34')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Vigilancia aduanera.', false), ('B', 'Prohibiciones de entrada en el territorio aduanero de la Unión.', false), ('C', 'Ningún tipo de control aduanero.', false), ('D', 'Derechos de importación.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 227 del código aduanero de la Unión, el régimen de tránsito interno permite:', 'El art. 227.1 define el tránsito interno (mercancías de la Unión que pasan por un tercer país sin cambiar su estatuto); la circulación de mercancías no pertenecientes a la Unión sin derechos corresponde al tránsito externo (art. 226), y la salida para transformación, al perfeccionamiento pasivo.', 'gc_23c_codigo_aduanero', (select id from public.topics where slug = 'gc-23c-codigo-aduanero'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212'), 'Art. 227.1 Rgto. (UE) 952/2013', 'El régimen de tránsito interno permitirá, en las condiciones dispuestas en el apartado 2, la circulación de mercancías de la Unión entre dos puntos del territorio aduanero de la Unión, pasando por un país o territorio no perteneciente a dicho territorio aduanero, sin que su estatuto aduanero se modifique.', null, '34e8cc7eff43e67f94c7a023fa9314c5bde0b1f6ac206e3757c823fdbd44ea76', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '34e8cc7eff43e67f94c7a023fa9314c5bde0b1f6ac206e3757c823fdbd44ea76')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La circulación de mercancías no pertenecientes a la Unión entre dos puntos del territorio aduanero de la Unión sin estar sujetas a derechos de importación.', false), ('B', 'La circulación de mercancías de la Unión dentro de un mismo Estado miembro sin declaración en aduana.', false), ('C', 'La circulación de mercancías de la Unión entre dos puntos del territorio aduanero de la Unión, pasando por un país o territorio no perteneciente a dicho territorio aduanero, sin que su estatuto aduanero se modifique.', true), ('D', 'La salida temporal de mercancías de la Unión para su transformación en un tercer país.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 269 del código aduanero de la Unión, las mercancías de la Unión que vayan a salir del territorio aduanero de la Unión se incluirán, como regla general, en el régimen de:', 'El art. 269.1 somete al régimen de exportación las mercancías de la Unión que salen del territorio aduanero, con las excepciones del apartado 2 (perfeccionamiento pasivo, destino final, avituallamiento de aeronaves o buques, tránsito interno y salidas temporales). Las mercancías no pertenecientes a la Unión salen con declaración de reexportación (art. 270).', 'gc_23c_codigo_aduanero', (select id from public.topics where slug = 'gc-23c-codigo-aduanero'), 1, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212'), 'Art. 269.1 Rgto. (UE) 952/2013', 'Las mercancías de la Unión que vayan a salir del territorio aduanero de la Unión se incluirán en el régimen de exportación.', null, 'c94802e83490382c13cdd38181bd1a20c882852f5658d04d11d6b9b8871ce02b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c94802e83490382c13cdd38181bd1a20c882852f5658d04d11d6b9b8871ce02b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Reexportación.', false), ('B', 'Tránsito externo.', false), ('C', 'Exportación.', true), ('D', 'Perfeccionamiento activo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 270 del código aduanero de la Unión, las mercancías no pertenecientes a la Unión que vayan a salir del territorio aduanero de la Unión estarán sujetas, como regla general, a:', 'El art. 270.1 exige declaración de reexportación para las mercancías no pertenecientes a la Unión que salen, salvo las que solo atraviesan el territorio en tránsito externo, las transbordadas o reexportadas directamente desde zona franca y las reexportadas directamente desde un almacén de depósito temporal (apartado 3).', 'gc_23c_codigo_aduanero', (select id from public.topics where slug = 'gc-23c-codigo-aduanero'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212'), 'Art. 270.1 Rgto. (UE) 952/2013', 'Las mercancías no pertenecientes a la Unión que vayan a salir del territorio aduanero de la Unión estarán sujetas a una declaración de reexportación, que deberá presentarse en la aduana competente.', null, 'dbf34334dd316f90644d4ba829ac5c34d897ca4bda4da48bb9b3e0a8cbb74436', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'dbf34334dd316f90644d4ba829ac5c34d897ca4bda4da48bb9b3e0a8cbb74436')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una declaración de exportación, que deberá presentarse en la aduana de salida.', false), ('B', 'Una declaración sumaria de entrada.', false), ('C', 'Una notificación de llegada, que deberá presentarse en la aduana de primera entrada.', false), ('D', 'Una declaración de reexportación, que deberá presentarse en la aduana competente.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 271 del código aduanero de la Unión, ¿quién deberá presentar la declaración sumaria de salida, sin perjuicio de que otras personas puedan presentarla en su lugar?', 'El art. 271.2 atribuye al transportista la presentación de la declaración sumaria de salida; puede presentarla en su lugar el exportador o expedidor, la persona por cuya cuenta actúe el transportista o quien pueda presentar las mercancías en la aduana de salida. Solo es necesaria cuando no se presenta declaración en aduana o de reexportación como declaración previa a la salida (art. 271.1).', 'gc_23c_codigo_aduanero', (select id from public.topics where slug = 'gc-23c-codigo-aduanero'), 2, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212'), 'Art. 271.2 Rgto. (UE) 952/2013', 'La declaración sumaria de salida deberá presentarla el transportista.', null, 'd33f5bdef012389621029809713a9de0fffce280b5157e1bd8671e346f7d0942', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd33f5bdef012389621029809713a9de0fffce280b5157e1bd8671e346f7d0942')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El transportista.', true), ('B', 'El exportador, en todo caso.', false), ('C', 'La aduana de salida.', false), ('D', 'El titular del régimen de tránsito.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el artículo 263 del código aduanero de la Unión, la declaración previa a la salida que debe amparar a las mercancías que vayan a salir del territorio aduanero de la Unión podrá adoptar la forma de:', 'El art. 263.3 admite tres formas de declaración previa a la salida: declaración en aduana (si el régimen la requiere), declaración de reexportación (art. 270) o declaración sumaria de salida (art. 271). Debe contener los datos para el análisis de riesgos a efectos de seguridad y protección (art. 263.4).', 'gc_23c_codigo_aduanero', (select id from public.topics where slug = 'gc-23c-codigo-aduanero'), 3, 'es', true, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212'), 'Art. 263.3 Rgto. (UE) 952/2013', 'La declaración previa a la salida adoptará una de las siguientes formas: a) una declaración en aduana, en caso de que las mercancías que vayan a salir del territorio aduanero de la Unión estén incluidas en un régimen aduanero que requiera tal declaración; b) una declaración de reexportación de conformidad con el artículo 270; c) una declaración sumaria de salida de conformidad con el artículo 271.', null, 'ebe09e1fd3301d30229dabc6198d6bd774a585aa96b8bbbe6378b45012794c68', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ebe09e1fd3301d30229dabc6198d6bd774a585aa96b8bbbe6378b45012794c68')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una declaración en aduana, una declaración de depósito temporal o una notificación de reexportación.', false), ('B', 'Una declaración en aduana, una declaración de reexportación o una declaración sumaria de salida.', true), ('C', 'Únicamente una declaración sumaria de salida.', false), ('D', 'Una declaración sumaria de entrada, una declaración en aduana o una declaración de reexportación.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gcl-24-ingles-convgc-v1 (40 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Resolución 160/38243/2026, de 5 de mayo, de la Dirección General de la Guardia Civil, por la que se convocan pruebas selectivas para ingreso en los centros docentes de formación para la incorporación a la Escala de Cabos y Guardias del Cuerpo de la Guardia Civil (base 6.1.1)', 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982', 'web_oficial'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gcl-24-ingles', 'Tema 24. Lengua inglesa (prueba de inglés)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gcl-24-ingles' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correct option: «My brother ___ in a police station in Madrid.»', 'En presente simple, la tercera persona del singular (he, she, it, my brother) añade -s al verbo: works. «Is work» mezcla el verbo to be con el infinitivo y es incorrecto.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Present simple (3.ª persona)', null, null, '2aa88e6a93e92dbd98eba4ba59e6929c05070bcc7298b1127a6eec5c3eaba80a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2aa88e6a93e92dbd98eba4ba59e6929c05070bcc7298b1127a6eec5c3eaba80a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'work', false), ('B', 'working', false), ('C', 'is work', false), ('D', 'works', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correct option: «Yesterday we ___ to the beach by train.»', '«Yesterday» exige pasado simple. Go es irregular: go – went – gone. «Gone» es el participio y necesita un auxiliar (have gone); «goed» no existe.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Past simple (verbos irregulares)', null, null, 'def0588931abdcee97b736a18630f5ab09f90ab40861f5343adee319a46b83d9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'def0588931abdcee97b736a18630f5ab09f90ab40861f5343adee319a46b83d9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'goed', false), ('B', 'gone', false), ('C', 'went', true), ('D', 'go', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correct option: «She ___ the email last night because her computer was broken.»', 'La negativa del pasado simple se forma con did not (didn''t) + infinitivo sin to: didn''t send. Tras didn''t el verbo nunca va en pasado.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Past simple (negativa)', null, null, '177037f6d1be3eef439f4a1d3fd966f5fd645a06524dfecb322d29474e355644', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '177037f6d1be3eef439f4a1d3fd966f5fd645a06524dfecb322d29474e355644')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'didn''t send', true), ('B', 'didn''t sent', false), ('C', 'doesn''t sent', false), ('D', 'not sent', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correct option: «___ two patrol cars outside the building.»', 'Para indicar existencia se usa there is (singular) y there are (plural). «Two patrol cars» es plural, por lo que corresponde there are.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · There is / there are', null, null, 'c916075a642dfba9111102e0313a216c8078b00f65985c86b3705bbf1dcd8662', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c916075a642dfba9111102e0313a216c8078b00f65985c86b3705bbf1dcd8662')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'There is', false), ('B', 'There are', true), ('C', 'It is', false), ('D', 'They are', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correct preposition: «The exam starts ___ 9 o''clock ___ Monday.»', 'Se usa at con horas (at 9 o''clock), on con días de la semana y fechas (on Monday) e in con meses, años y partes del día (in May, in the morning).', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Preposiciones de tiempo', null, null, '2df9bbb6ead666f6d1140d63d3bdc1c0b97a9baf1dbdb3e2499dc50f439e8a92', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2df9bbb6ead666f6d1140d63d3bdc1c0b97a9baf1dbdb3e2499dc50f439e8a92')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'on / at', false), ('B', 'at / on', true), ('C', 'in / on', false), ('D', 'at / in', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Read the sign: «NO PARKING. Vehicles will be removed.» What does it mean?', '«No parking» significa prohibido aparcar, y «vehicles will be removed» advierte que los vehículos serán retirados (por la grúa). Por tanto, no se puede dejar el coche allí.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Imperativo y vocabulario de indicaciones', null, null, '8d081b5d8e1cb66e02d042bba88b1330d645cd3db416f70a50493f4cf51dd2b8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8d081b5d8e1cb66e02d042bba88b1330d645cd3db416f70a50493f4cf51dd2b8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'You can leave your car here for free.', false), ('B', 'You must drive slowly here.', false), ('C', 'You can only park here at night.', false), ('D', 'You must not leave your car here.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correct option: «I ___ in this city since 2019.»', 'Con since (desde un momento concreto) o for (durante un periodo) para una situación que empezó en el pasado y continúa, se usa el present perfect: have/has + participio (have lived).', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Present perfect vs past simple', null, null, '8b5429ff123c65ca9dad15e5df2bd73b60460145f86f2d4e870d5fe2c26cd819', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8b5429ff123c65ca9dad15e5df2bd73b60460145f86f2d4e870d5fe2c26cd819')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'live', false), ('B', 'lived', false), ('C', 'have lived', true), ('D', 'am living since', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correct option: «If you study hard, you ___ the exam.»', 'El primer condicional expresa una condición real o probable: if + presente simple, will + infinitivo. Would se usa en el segundo condicional (if + pasado simple).', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · First conditional', null, null, '07a95aaadcbae9ce370d7e99f6a45dde307a0e038721fe4550354ad2c2099ded', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '07a95aaadcbae9ce370d7e99f6a45dde307a0e038721fe4550354ad2c2099ded')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'will pass', true), ('B', 'would pass', false), ('C', 'passed', false), ('D', 'will passing', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correct option: «English ___ in many countries around the world.»', 'La voz pasiva se forma con to be + participio. El inglés no habla, sino que es hablado: is spoken (presente simple pasivo).', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Voz pasiva (presente)', null, null, '111b80028380eafc44de12125b25dacfe5f9884670a6e25ea42b399f0ec82fa1', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '111b80028380eafc44de12125b25dacfe5f9884670a6e25ea42b399f0ec82fa1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'speaks', false), ('B', 'is speaking', false), ('C', 'spoken', false), ('D', 'is spoken', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correct option: «You ___ use your mobile phone while driving. It''s illegal.»', 'Mustn''t expresa prohibición. Don''t have to y needn''t indican que algo no es necesario, pero no que esté prohibido.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Must / mustn''t / don''t have to', null, null, '9ba338bb75871526af5714fd843f65ddaa4aea050adf7b5fd3b3348e3e70df24', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9ba338bb75871526af5714fd843f65ddaa4aea050adf7b5fd3b3348e3e70df24')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'don''t have to', false), ('B', 'needn''t', false), ('C', 'mustn''t', true), ('D', 'must', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correct option: «How ___ water do you drink every day?»', 'Much se usa con sustantivos incontables (water, money, information) y many con contables en plural (bottles). «How a lot» no existe.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Cuantificadores (much/many)', null, null, '46e063fba704e8d15d2d82533bb9b44ae38f10fb1b90d68b7f539af53ecfecbd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '46e063fba704e8d15d2d82533bb9b44ae38f10fb1b90d68b7f539af53ecfecbd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'much', true), ('B', 'many', false), ('C', 'few', false), ('D', 'a lot', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correct option: «The woman ___ called the police was very nervous.»', 'Who (o that) introduce oraciones de relativo referidas a personas; which se refiere a cosas, whose expresa posesión y where lugar.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Pronombres relativos', null, null, '06f1f6eb86d1e25f2ab2176cbc053095818d3ce351bb1f8d0272e8898c31e0d5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '06f1f6eb86d1e25f2ab2176cbc053095818d3ce351bb1f8d0272e8898c31e0d5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'which', false), ('B', 'who', true), ('C', 'whose', false), ('D', 'where', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correct option: «I enjoy ___ in the mountains at weekends.»', 'Algunos verbos como enjoy, finish, mind o avoid van seguidos de gerundio (-ing), no de infinitivo.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Gerundio tras ciertos verbos', null, null, '7659af2758d89d0866d0138f3df604fcf8f1b99e1af941f9b6673fe48cf50f6f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7659af2758d89d0866d0138f3df604fcf8f1b99e1af941f9b6673fe48cf50f6f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'to walk', false), ('B', 'walk', false), ('C', 'walking', true), ('D', 'walked', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Read the text: «Tom starts work at 7 a.m. He usually drives to work, but today his car is at the garage, so he is taking the bus.» Which statement is true?', '«Usually drives» indica la costumbre (va en coche normalmente); «today… he is taking the bus» es una excepción de hoy. Empieza a las 7 a. m. (de la mañana), no p. m.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Comprensión lectora breve', null, null, 'ab7d6a4752af5c051dd387010835ac4570bb554b38af3cb854aac5889d398a62', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ab7d6a4752af5c051dd387010835ac4570bb554b38af3cb854aac5889d398a62')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Tom always takes the bus to work.', false), ('B', 'Tom''s car is broken, so he is walking to work.', false), ('C', 'Tom starts work at 7 p.m.', false), ('D', 'Tom normally goes to work by car.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correct option: «When I was a child, I ___ play football every afternoon.»', 'Used to + infinitivo expresa hábitos pasados que ya no se dan. «Be used to + -ing» significa estar acostumbrado a algo y no encaja aquí; «use to» solo aparece tras did (didn''t use to).', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Used to', null, null, '384e5060da60c1db72def18e46711c221facf4c0c64d3839db70693234cc75c9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '384e5060da60c1db72def18e46711c221facf4c0c64d3839db70693234cc75c9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'use to', false), ('B', 'used to', true), ('C', 'was used to', false), ('D', 'am used to', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correct option: «When we arrived at the station, the train ___.»', 'El past perfect (had + participio) indica una acción anterior a otra acción pasada: el tren se fue antes de que llegáramos.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Past perfect', null, null, '1fac58511f3587485c51770ad4ae15cc4518cb5f48fc5901d06e1f5fe7d0e1c8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '1fac58511f3587485c51770ad4ae15cc4518cb5f48fc5901d06e1f5fe7d0e1c8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'had already left', true), ('B', 'has already left', false), ('C', 'already leaves', false), ('D', 'was already leave', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correct reported sentence: He said, «I am tired.»', 'En estilo indirecto con said el tiempo retrocede (am → was) y el pronombre se adapta (I → he). Say no lleva objeto de persona sin to («said me» es incorrecto) y tell sí lo exige (he told me that…).', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Estilo indirecto', null, null, '3ae5227794fa56259af4089d6e27bc7a0a8fc72b9cc955f75da3308986fbe703', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3ae5227794fa56259af4089d6e27bc7a0a8fc72b9cc955f75da3308986fbe703')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'He said that he was tired.', true), ('B', 'He said that I am tired.', false), ('C', 'He said me that he was tired.', false), ('D', 'He told that he is tired.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correct option: «If they had left earlier, they ___ the accident.»', 'El tercer condicional se refiere a situaciones pasadas que no ocurrieron: if + past perfect, would have + participio.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Third conditional', null, null, '01e08c3b9f3cc82115d1f0b2ed38c76d85362c4800e5b9f0fec67f10521df826', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '01e08c3b9f3cc82115d1f0b2ed38c76d85362c4800e5b9f0fec67f10521df826')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'would avoid', false), ('B', 'would have avoided', true), ('C', 'will have avoided', false), ('D', 'had avoided', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Read the text: «Visitors must show an identity document at the entrance. Children under 14 must be accompanied by an adult. Photography is allowed, except in the archive room.» Which statement is true?', 'Los menores de 14 años deben ir acompañados de un adulto, así que un niño de 12 no puede entrar solo. Hay que mostrar un documento de identidad y las fotos solo están prohibidas en la sala de archivo.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Comprensión lectora (inferencia)', null, null, 'c1adfe4f2417fcfabff5d703bcd8f57eaa685dd34a819e778abdee56050b803b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c1adfe4f2417fcfabff5d703bcd8f57eaa685dd34a819e778abdee56050b803b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Visitors do not need any document to enter.', false), ('B', 'Taking photos is forbidden everywhere.', false), ('C', 'A 12-year-old cannot enter alone.', true), ('D', 'Adults must be accompanied by a child.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Read the text: «Hi Laura! I''m in Salamanca now. I''m staying with my aunt and uncle in a flat near the Plaza Mayor. Yesterday I visited the cathedral and in the evening we had dinner in a small restaurant. The weather is sunny, but it''s quite cold at night, so I''m happy I brought my jacket. On Saturday my cousin and I are taking the bus to Ávila. I''m going back home next Wednesday. Love, Marta.» Where is Marta staying?', 'El texto dice «I''m staying with my aunt and uncle»: se aloja con sus tíos, en un piso cerca de la Plaza Mayor.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Comprensión lectora (correo personal)', null, null, '36e41db05b3e6e094bef19a8e1459e79279c16434ebacbd33403da1cb4b15c66', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '36e41db05b3e6e094bef19a8e1459e79279c16434ebacbd33403da1cb4b15c66')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'In a hotel near the cathedral.', false), ('B', 'With her cousin in Ávila.', false), ('C', 'In a small restaurant.', false), ('D', 'With her aunt and uncle.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Read the text: «Hi Laura! I''m in Salamanca now. I''m staying with my aunt and uncle in a flat near the Plaza Mayor. Yesterday I visited the cathedral and in the evening we had dinner in a small restaurant. The weather is sunny, but it''s quite cold at night, so I''m happy I brought my jacket. On Saturday my cousin and I are taking the bus to Ávila. I''m going back home next Wednesday. Love, Marta.» What did Marta do yesterday?', '«Yesterday I visited the cathedral and in the evening we had dinner in a small restaurant»: ayer visitó la catedral y cenó en un restaurante.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Comprensión lectora (correo personal)', null, null, 'f3a038d34b71cc784030be3457ba0aae7e35fd836920b61163c1746ae0c031a3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f3a038d34b71cc784030be3457ba0aae7e35fd836920b61163c1746ae0c031a3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'She visited the cathedral and had dinner in a restaurant.', true), ('B', 'She took the bus to Ávila.', false), ('C', 'She went back home.', false), ('D', 'She bought a jacket.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Read the text: «Hi Laura! I''m in Salamanca now. I''m staying with my aunt and uncle in a flat near the Plaza Mayor. Yesterday I visited the cathedral and in the evening we had dinner in a small restaurant. The weather is sunny, but it''s quite cold at night, so I''m happy I brought my jacket. On Saturday my cousin and I are taking the bus to Ávila. I''m going back home next Wednesday. Love, Marta.» How will Marta travel to Ávila?', '«On Saturday my cousin and I are taking the bus to Ávila»: el present continuous expresa un plan futuro ya decidido; irá en autobús con su primo o prima.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Comprensión lectora (correo personal)', null, null, '35010ae51620766981a84e354ae28ed99e17f1f6c2d497adc290cecba19a8a9d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '35010ae51620766981a84e354ae28ed99e17f1f6c2d497adc290cecba19a8a9d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'By car, with her aunt.', false), ('B', 'By train, alone.', false), ('C', 'By bus, with her cousin.', true), ('D', 'She is not going to Ávila.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Read the text: «Hi Laura! I''m in Salamanca now. I''m staying with my aunt and uncle in a flat near the Plaza Mayor. Yesterday I visited the cathedral and in the evening we had dinner in a small restaurant. The weather is sunny, but it''s quite cold at night, so I''m happy I brought my jacket. On Saturday my cousin and I are taking the bus to Ávila. I''m going back home next Wednesday. Love, Marta.» Which statement is true?', '«It''s quite cold at night, so I''m happy I brought my jacket»: hace frío por la noche y Marta sí trajo la chaqueta. Vuelve a casa el miércoles, no el sábado.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Comprensión lectora (correo personal)', null, null, '522df375818bbf63b9bea1055ec29701ff159450a0f4e505192594476e45a9fd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '522df375818bbf63b9bea1055ec29701ff159450a0f4e505192594476e45a9fd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'It is raining in Salamanca.', false), ('B', 'Marta forgot her jacket.', false), ('C', 'Marta is going home on Saturday.', false), ('D', 'It is cold at night in Salamanca.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Read the notice: «CENTRAL STATION – LOST PROPERTY. If you have lost something on a train, please come to the Lost Property Office on Platform 1. Items are kept for 30 days. To collect an item, you must show an identity document and describe the item. Opening hours: Monday to Friday, 8:00–18:00. Closed at weekends and on public holidays. Items not collected after 30 days are given to charity.» Where should you go if you lost something on a train?', '«Please come to the Lost Property Office on Platform 1»: hay que ir a la oficina de objetos perdidos del andén 1.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Comprensión lectora (aviso)', null, null, 'e977ad2c9b91cf9c7f676d5f85ded25377f4b7614c9dae0a99461b5ad56a977d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e977ad2c9b91cf9c7f676d5f85ded25377f4b7614c9dae0a99461b5ad56a977d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'To the ticket office.', false), ('B', 'To the Lost Property Office on Platform 1.', true), ('C', 'To the police station.', false), ('D', 'To a charity shop.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Read the notice: «CENTRAL STATION – LOST PROPERTY. If you have lost something on a train, please come to the Lost Property Office on Platform 1. Items are kept for 30 days. To collect an item, you must show an identity document and describe the item. Opening hours: Monday to Friday, 8:00–18:00. Closed at weekends and on public holidays. Items not collected after 30 days are given to charity.» What do you need to collect an item?', '«You must show an identity document and describe the item»: se exige documento de identidad y describir el objeto. Must expresa obligación.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Comprensión lectora (aviso)', null, null, 'fac25963f24919192e8faedf1420e30481701c43f5a5fc109a1be774c212f3cc', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'fac25963f24919192e8faedf1420e30481701c43f5a5fc109a1be774c212f3cc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Only your train ticket.', false), ('B', 'A letter from the police.', false), ('C', 'An identity document and a description of the item.', true), ('D', 'Nothing: you just ask for it.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Read the notice: «CENTRAL STATION – LOST PROPERTY. If you have lost something on a train, please come to the Lost Property Office on Platform 1. Items are kept for 30 days. To collect an item, you must show an identity document and describe the item. Opening hours: Monday to Friday, 8:00–18:00. Closed at weekends and on public holidays. Items not collected after 30 days are given to charity.» Can you collect your item on a Sunday?', 'El horario es de lunes a viernes y la oficina está «closed at weekends»: el domingo forma parte del fin de semana, así que está cerrada.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Comprensión lectora (aviso)', null, null, 'ff6f0bfb8d3584b58832058dc6651fbc8ab189b2ea308e49bcfdd8fd962bb336', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ff6f0bfb8d3584b58832058dc6651fbc8ab189b2ea308e49bcfdd8fd962bb336')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No, because the office is closed at weekends.', true), ('B', 'Yes, from 8:00 to 18:00.', false), ('C', 'Yes, but only in the morning.', false), ('D', 'Only if it is a public holiday.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Read the notice: «CENTRAL STATION – LOST PROPERTY. If you have lost something on a train, please come to the Lost Property Office on Platform 1. Items are kept for 30 days. To collect an item, you must show an identity document and describe the item. Opening hours: Monday to Friday, 8:00–18:00. Closed at weekends and on public holidays. Items not collected after 30 days are given to charity.» What happens to an item that nobody collects in 30 days?', '«Items not collected after 30 days are given to charity»: la pasiva are given indica que se entregan a una organización benéfica.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Comprensión lectora (aviso)', null, null, '0aa062bac2773a71d03771193910df8701469865a2ac15acfa9c970f76627e6a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '0aa062bac2773a71d03771193910df8701469865a2ac15acfa9c970f76627e6a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'It is sent to the police.', false), ('B', 'It is thrown away.', false), ('C', 'It is kept for another 30 days.', false), ('D', 'It is given to charity.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Read the text: «Last winter Daniel was driving through the mountains when it started to snow heavily. He couldn''t see the road, so he stopped in a small village. A family who lived there offered him a room for the night. The next morning the snowplough had cleared the road and he continued his journey. Since then, Daniel has visited the family every summer.» Why did Daniel stop in the village?', '«It started to snow heavily. He couldn''t see the road, so he stopped»: so introduce la consecuencia; paró porque la nevada no le dejaba ver la carretera.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Comprensión lectora (relato)', null, null, 'aac31c5d5696239f785f496cead7b943b3f84e21ca7da26d14fa818d6af23daf', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'aac31c5d5696239f785f496cead7b943b3f84e21ca7da26d14fa818d6af23daf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Because his car broke down.', false), ('B', 'Because he couldn''t see the road in the heavy snow.', true), ('C', 'Because he wanted to visit a family.', false), ('D', 'Because the village was his destination.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Read the text: «Last winter Daniel was driving through the mountains when it started to snow heavily. He couldn''t see the road, so he stopped in a small village. A family who lived there offered him a room for the night. The next morning the snowplough had cleared the road and he continued his journey. Since then, Daniel has visited the family every summer.» Where did Daniel sleep that night?', '«A family who lived there offered him a room for the night»: durmió en una habitación que le ofreció una familia del pueblo.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Comprensión lectora (relato)', null, null, '2c62b1094efcad86d7c7c97b75535057533742a4260abb5b1e00b39a32ed62c4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2c62b1094efcad86d7c7c97b75535057533742a4260abb5b1e00b39a32ed62c4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'In his car.', false), ('B', 'In a hotel in the mountains.', false), ('C', 'In a room offered by a family in the village.', true), ('D', 'At his own home.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Read the text: «Last winter Daniel was driving through the mountains when it started to snow heavily. He couldn''t see the road, so he stopped in a small village. A family who lived there offered him a room for the night. The next morning the snowplough had cleared the road and he continued his journey. Since then, Daniel has visited the family every summer.» What does «the snowplough had cleared the road» mean?', 'Snowplough es la máquina quitanieves y clear significa despejar. El past perfect (had cleared) indica que la carretera ya estaba despejada cuando Daniel siguió su viaje.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Comprensión lectora (relato)', null, null, '7827dd9cbf9d9e3d592b74a143e4e6243b19be2ff7f739fed7505aefa6fb8913', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7827dd9cbf9d9e3d592b74a143e4e6243b19be2ff7f739fed7505aefa6fb8913')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A machine had removed the snow from the road before he left.', true), ('B', 'The road was still closed because of the snow.', false), ('C', 'Daniel cleaned the road himself.', false), ('D', 'It snowed again in the morning.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Read the text: «Last winter Daniel was driving through the mountains when it started to snow heavily. He couldn''t see the road, so he stopped in a small village. A family who lived there offered him a room for the night. The next morning the snowplough had cleared the road and he continued his journey. Since then, Daniel has visited the family every summer.» Which statement is true now?', '«Since then, Daniel has visited the family every summer»: el present perfect con since expresa algo que empezó en el pasado y sigue hasta hoy; sigue visitándolos cada verano.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Comprensión lectora (relato)', null, null, 'b8834a4fb047cc69a6c8637c2b5b3438e1d126fd92a62218ffb0bc7dc9d275a0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b8834a4fb047cc69a6c8637c2b5b3438e1d126fd92a62218ffb0bc7dc9d275a0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Daniel visited the family only once.', false), ('B', 'Daniel lives in the village now.', false), ('C', 'Daniel visits the family every winter.', false), ('D', 'Daniel still visits the family every summer.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Read the message: «Hi Sam, just to let you know that the team meeting has been moved from Thursday to Friday because the manager is ill. It will start at 10:30 instead of 9:00. Please bring last week''s report. Thanks, Alex.» When is the meeting now?', '«Moved from Thursday to Friday» y «at 10:30 instead of 9:00»: la reunión es ahora el viernes a las 10:30. Instead of significa «en lugar de».', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Comprensión lectora (mensaje)', null, null, 'b0739f9a1e8f5dfeabac243e01a5036da5479ea6d7cca8070e2bf518964b7207', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b0739f9a1e8f5dfeabac243e01a5036da5479ea6d7cca8070e2bf518964b7207')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'On Thursday at 9:00.', false), ('B', 'On Friday at 10:30.', true), ('C', 'On Friday at 9:00.', false), ('D', 'On Thursday at 10:30.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Read the message: «Hi Sam, just to let you know that the team meeting has been moved from Thursday to Friday because the manager is ill. It will start at 10:30 instead of 9:00. Please bring last week''s report. Thanks, Alex.» Why was the meeting changed?', '«Because the manager is ill»: se cambió porque el responsable está enfermo (ill = enfermo).', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Comprensión lectora (mensaje)', null, null, '22fb7520b33cf551b469abd8cf001ce9e91bc1344feabde8322b6cb328ba8d0b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '22fb7520b33cf551b469abd8cf001ce9e91bc1344feabde8322b6cb328ba8d0b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Because Sam is on holiday.', false), ('B', 'Because the report is not ready.', false), ('C', 'Because the manager is ill.', true), ('D', 'Because Alex is busy on Thursday.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correctly spelled word.', 'Beautiful se escribe con «eau» (de beauty) y el sufijo -ful lleva una sola l.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 1, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Ortografía (spelling)', null, null, 'ad07d098449fb19976756ee327849f7fd330974f3fefcfb60ba420b0d09f33f2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ad07d098449fb19976756ee327849f7fd330974f3fefcfb60ba420b0d09f33f2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'beautiful', true), ('B', 'beatiful', false), ('C', 'beautifull', false), ('D', 'beutiful', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Which word is spelled incorrectly?', 'Regla «i before e, except after c»: tras c se escribe ei (received, receipt); en los demás casos, ie (believe, piece). Lo correcto es received.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Ortografía (spelling)', null, null, 'a7d417d027de9af5a5a51ce2400b8af85b5f09144b6b820a855f0c3074fed69a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a7d417d027de9af5a5a51ce2400b8af85b5f09144b6b820a855f0c3074fed69a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'believe', false), ('B', 'piece', false), ('C', 'receipt', false), ('D', 'recieved', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correct plural of «baby».', 'Los sustantivos acabados en consonante + y forman el plural cambiando y por i y añadiendo -es: baby → babies (pero boy → boys, porque la y va tras vocal).', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Ortografía (spelling)', null, null, '3a713f71f591fb6c85613abc3b9fd93c77f6d5e334f1332f3075cf00f24bbb0b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '3a713f71f591fb6c85613abc3b9fd93c77f6d5e334f1332f3075cf00f24bbb0b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'babys', false), ('B', 'babies', true), ('C', 'babyes', false), ('D', 'babis', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correct -ing form of «run».', 'En los verbos de una sílaba acabados en una vocal + una consonante se duplica la consonante final antes de -ing: run → running, swim → swimming.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Ortografía (spelling)', null, null, 'c125b864ce5f92e24292def3ff680a0e67f5b8cf29ee84c96b7804fe44421ff4', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c125b864ce5f92e24292def3ff680a0e67f5b8cf29ee84c96b7804fe44421ff4')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'runing', false), ('B', 'running', true), ('C', 'runnin', false), ('D', 'runeing', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correctly spelled day of the week.', 'Wednesday lleva una d que no se pronuncia (Wed-nes-day). En inglés los días de la semana se escriben siempre con mayúscula inicial.', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 2, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Ortografía (spelling)', null, null, '499cf199f3fe31c0813d7f0b907ea7e4c24357b3b8699b1cdd2358b27b6641cd', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '499cf199f3fe31c0813d7f0b907ea7e4c24357b3b8699b1cdd2358b27b6641cd')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Wensday', false), ('B', 'Wednesdey', false), ('C', 'Wednesday', true), ('D', 'wednesday', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correctly spelled word.', 'Necessary lleva una sola c y dos s (ne-ce-ssa-ry).', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Ortografía (spelling)', null, null, '89e17b7704bd5b182782e060cd97669fff3b3a9f41a01ece8de69acd5bfb1961', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '89e17b7704bd5b182782e060cd97669fff3b3a9f41a01ece8de69acd5bfb1961')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'neccessary', false), ('B', 'necesary', false), ('C', 'neccesary', false), ('D', 'necessary', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Choose the correctly spelled word.', 'Accommodation lleva doble c y doble m (ac-com-mo-da-tion).', 'gcl_24_ingles', (select id from public.topics where slug = 'gcl-24-ingles'), 3, 'es', true, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982'), 'Inglés · Ortografía (spelling)', null, null, '47c261e9ff16eadff0fd97cf9314008e3826a449c74d66d2cee649288b1b5c6c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '47c261e9ff16eadff0fd97cf9314008e3826a449c74d66d2cee649288b1b5c6c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'accommodation', true), ('B', 'accomodation', false), ('C', 'acommodation', false), ('D', 'acomodation', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gcl-25a-ortografia-rae_dpd-v1 (40 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Academia Española y ASALE · Diccionario panhispánico de dudas (DPD), 2.ª edición en línea', 'https://www.rae.es/dpd/', 'web_oficial'::public.source_kind, 'Real Academia Española y Asociación de Academias de la Lengua Española', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gcl-25a-ortografia', 'Tema 25. Lengua española (I): ortografía') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gcl-25a-ortografia' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «La vegetación exhuberante del valle cubría la hierba y el garaje abandonado, que parecía absorber toda la humedad».', 'Según el DPD, la grafía correcta es exuberante (y exuberancia), sin hache; ⊗exhuberante es incorrecta. Hierba, garaje y absorber están bien escritas.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. exuberante', 'Es incorrecta la grafía ⊗exhuberante.', null, '01e0bf92c09e054ebb5eea3fb4ec19eff629b022133888294bb38ffd64b48c52', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '01e0bf92c09e054ebb5eea3fb4ec19eff629b022133888294bb38ffd64b48c52')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'hierba', false), ('B', 'exhuberante', true), ('C', 'garaje', false), ('D', 'absorber', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «Cuando hecho de menos a mi familia, hojeo el álbum y enseguida me siento mejor».', 'El verbo echar (echar de menos) no lleva h: debe escribirse echo. El DPD advierte que el error es frecuente en echo, echas, echa por homofonía con el participio de hacer (hecho). Hojeo (de hojear, pasar las hojas) y enseguida son correctas.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. echar', 'No debe escribirse con h inicial, error frecuente en las formas de presente echo, echas, echa por homofonía con las formas del participio de hacer (hecho, hecha).', null, '8699f6cc30a6f0fc4f9f9f78752dfe271c76e7c4c269c74f3f7c4ba981b2c41c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8699f6cc30a6f0fc4f9f9f78752dfe271c76e7c4c269c74f3f7c4ba981b2c41c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'hojeo', false), ('B', 'enseguida', false), ('C', 'mejor', false), ('D', 'hecho', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «El tejido debe absorver el líquido del absceso sin provocar una reacción exorbitante, según el informe de meteorología sanitaria».', 'Absorber se escribe con b; ⊗absorver es incorrecta por cruce con absolver (''declarar inocente''). Absceso, exorbitante y meteorología están bien escritas.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. absorber', 'Es incorrecta la grafía ⊗absorver, debida al cruce con absolver (''declarar inocente''; → absolver).', null, '4759a5153aa2655e3964bfa8bc87ca44ccf2dd909f5408abe850c604063d48ee', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4759a5153aa2655e3964bfa8bc87ca44ccf2dd909f5408abe850c604063d48ee')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'absorver', true), ('B', 'absceso', false), ('C', 'exorbitante', false), ('D', 'meteorología', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «Fue un gesto expontáneo y espléndido que superó todas las expectativas del público escéptico».', 'Espontáneo y toda su familia (espontaneidad, espontáneamente) se escriben con s; el DPD califica de incorrectas las grafías con x. Espléndido se escribe con s, expectativa con x y escéptico con s.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. espontáneo', 'En este adjetivo y en el resto de las palabras de su misma familia léxica, como espontaneidad o espontáneamente, son incorrectas las grafías con x: ⊗expontáneo, ⊗expontaneidad, etc.', null, '929382aa97ca7d5d21a97840dc8618e63fa6f9a2533cfeb6edd5805470f2b7f3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '929382aa97ca7d5d21a97840dc8618e63fa6f9a2533cfeb6edd5805470f2b7f3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'espléndido', false), ('B', 'expectativas', false), ('C', 'expontáneo', true), ('D', 'escéptico', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «Ante la espectativa de un desahucio, el cónyuge reivindicó sus derechos».', 'La grafía correcta es expectativa, con x; el DPD considera incorrecta ⊗espectativa. Desahucio, cónyuge y reivindicó son correctas.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. expectativa', 'Es incorrecta la grafía ⊗espectativa.', null, '5ba2397c6cd3aacfa89f35f78ca1e51738e8d68644e065d3057cc1479e4857b8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5ba2397c6cd3aacfa89f35f78ca1e51738e8d68644e065d3057cc1479e4857b8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'espectativa', true), ('B', 'desahucio', false), ('C', 'cónyuge', false), ('D', 'reivindicó', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «El investigador se mostró excéptico ante una cifra tan exorbitante, aunque la idiosincrasia del grupo era espontánea».', 'Escéptico (y escepticismo) se escribe con s; el DPD señala como incorrecta la grafía ⊗excéptico. Las otras tres palabras están bien escritas.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. escéptico', 'Es incorrecta la grafía ⊗excéptico y la correspondiente pronunciación ⊗[ekséptiko, ekszéptiko].', null, '8cfe05d4ee583c98e8b011300395717efc5a8962855c4a65b2ed3313d88fbf8d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8cfe05d4ee583c98e8b011300395717efc5a8962855c4a65b2ed3313d88fbf8d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'exorbitante', false), ('B', 'excéptico', true), ('C', 'idiosincrasia', false), ('D', 'espontánea', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «Asímismo, el agente informó enseguida a sus superiores y les dio la enhorabuena por la aprehensión».', 'El adverbio asimismo (''también'') se escribe en una palabra y sin tilde; el DPD declara incorrecta ⊗asímismo. Enseguida, enhorabuena (sustantivo ''felicitación'') y aprehensión (''acción y efecto de aprehender'') son correctas.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. asimismo', 'La forma simple se escribe sin tilde, por lo que no es correcta la grafía ⊗asímismo.', null, '8537e82fe0fac43ea0142f72b6160edba1aeccc135d52d26cefd92c90456a64e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8537e82fe0fac43ea0142f72b6160edba1aeccc135d52d26cefd92c90456a64e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'enseguida', false), ('B', 'enhorabuena', false), ('C', 'Asímismo', true), ('D', 'aprehensión', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «El cónyugue del vagabundo firmó el documento con un bolígrafo oscuro mientras tomaba un yogur».', 'Se escribe cónyuge (pronunciado [kónyuje]); el DPD considera incorrecta la grafía ⊗cónyugue. Vagabundo, oscuro (forma simplificada recomendada) y yogur son correctas.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. cónyuge', 'Se pronuncia [kónyuje], no ⊗[kónyuge]; por tanto, no es correcta la grafía ⊗cónyugue.', null, 'd4b8e19f574678b1418262b900f13082011d7fc9edf55bb79d33807812181d8a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd4b8e19f574678b1418262b900f13082011d7fc9edf55bb79d33807812181d8a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'vagabundo', false), ('B', 'oscuro', false), ('C', 'yogur', false), ('D', 'cónyugue', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «La idiosincracia de aquella comunidad era inocua, aunque algunos se mostraban escépticos ante su esplendor».', 'La forma correcta es idiosincrasia, con s en la última sílaba; el DPD da como erróneas ⊗idiosincracia, ⊗ideosincrasia y otras variantes. Inocua, escépticos y esplendor son correctas.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 3, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. idiosincrasia', 'Son erróneas las formas ⊗ideosincrasia, ⊗ideosincracia, ⊗idiosincracia, ⊗indiosincrasia e ⊗indiosincracia.', null, '8ebb82b86c3ce894ed04d23a9e036d135d2fb8d0c54e26ec8b137640d02ccedf', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8ebb82b86c3ce894ed04d23a9e036d135d2fb8d0c54e26ec8b137640d02ccedf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'inocua', false), ('B', 'idiosincracia', true), ('C', 'escépticos', false), ('D', 'esplendor', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «Los vecinos decidieron revindicar un parque con un hexágono de hierba y un garaje subterráneo».', 'El verbo es reivindicar, con el diptongo ei; el DPD considera incorrecto reducirlo a e (⊗revindicar, ⊗revindicación). Hexágono conserva la h- etimológica; hierba y garaje son correctas.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. reivindicar', 'Es incorrecto reducir el diptongo ei a e en todas las formas de este verbo (⊗revindicar)', null, '00816ed1f982605cd7ef2f06cc586e4b52a63f4d527510e97a412f99d3156adf', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '00816ed1f982605cd7ef2f06cc586e4b52a63f4d527510e97a412f99d3156adf')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'revindicar', true), ('B', 'hexágono', false), ('C', 'hierba', false), ('D', 'garaje', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «El vagamundo durmió en el garaje y, enseguida, pidió un yogur».', 'La forma correcta es vagabundo; el DPD indica que ⊗vagamundo es una deformación propia del habla popular que debe evitarse en la lengua culta.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. vagabundo', 'Debe evitarse, en la lengua culta, la deformación ⊗vagamundo, propia del habla popular.', null, '71427e65a8a2388e0ee213004ca1927e0e5006820ff5fc8f49b5d894b537302c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '71427e65a8a2388e0ee213004ca1927e0e5006820ff5fc8f49b5d894b537302c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'garaje', false), ('B', 'enseguida', false), ('C', 'vagamundo', true), ('D', 'yogur', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «Le exigieron una cantidad exhorbitante por reparar el hexágono del garaje, algo que absorbió todos sus ahorros».', 'Exorbitante se escribe sin h porque está emparentado con órbita; el DPD considera incorrecta ⊗exhorbitante. Hexágono, en cambio, sí lleva h- etimológica.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. exorbitante', 'Es incorrecta la grafía ⊗exhorbitante, ya que órbita, voz con la que está etimológicamente emparentado este adjetivo, se escribe sin hache.', null, '6faa57a3da15d8bf1cbffcdb81c05316de8c7481155c02eeef6b40682fac04c8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6faa57a3da15d8bf1cbffcdb81c05316de8c7481155c02eeef6b40682fac04c8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'hexágono', false), ('B', 'garaje', false), ('C', 'absorbió', false), ('D', 'exhorbitante', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Diccionario panhispánico de dudas, ¿cuál de las siguientes palabras no sigue la adaptación gráfica al español de las voces francesas terminadas en -age?', 'Garaje es la adaptación gráfica del francés garage; como el resto de las voces francesas en -age incorporadas al español (bagaje, brebaje, menaje), se escribe con la terminación -aje.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. garaje', 'no hay razón para que esta palabra quede excluida del proceso de adaptación seguido por las voces francesas terminadas en -age que se han incorporado al español, y que se han adaptado siempre con la terminación -aje (pron. [áje]): bagaje, brebaje, menaje, etc.', null, '6f61ac51ad5da8abd16dd3cc4460bfc97580d4f7cc880e829b2fe69e814654e6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '6f61ac51ad5da8abd16dd3cc4460bfc97580d4f7cc880e829b2fe69e814654e6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'bagaje', false), ('B', 'brebaje', false), ('C', 'menaje', false), ('D', 'garage', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «El médico drenó el abceso con el bisturí y prescribió una convalecencia breve y un tratamiento inocuo».', 'Se escribe absceso, con el grupo -bsc-; el DPD considera incorrecta ⊗abceso y advierte que no debe confundirse con acceso. Convalecencia se escribe sin -sc- y bisturí e inocuo son correctas.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 3, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. absceso', 'Es incorrecta la grafía ⊗abceso.', null, 'e320eb00a603b5e23d33dfa2cac9933f1ffc034409bc788a03f6657b34b0a39a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'e320eb00a603b5e23d33dfa2cac9933f1ffc034409bc788a03f6657b34b0a39a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'bisturí', false), ('B', 'convalecencia', false), ('C', 'abceso', true), ('D', 'inocuo', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «El juez ordenó deshauciar al inquilino; el cónyuge, escéptico, intentó reivindicar la vivienda».', 'Se escribe desahuciar: la h intercalada va detrás de la primera a y no detrás de la s, por lo que ⊗deshauciar es incorrecta según el DPD.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 3, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. desahuciar', 'La h intercalada va detrás de la primera a, y no detrás de la s: ⊗deshauciar.', null, '9ed2dd2d4a6c8236ce4f4bb224224527629160ee36191006fb426033d905c5a0', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '9ed2dd2d4a6c8236ce4f4bb224224527629160ee36191006fb426033d905c5a0')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'cónyuge', false), ('B', 'deshauciar', true), ('C', 'escéptico', false), ('D', 'reivindicar', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Diccionario panhispánico de dudas, ¿cuál de las siguientes grafías no se considera correcta?', 'El uso culto mayoritario mantiene la h- etimológica de hexágono y hexagonal, por lo que ⊗exágono y ⊗exagonal no se consideran correctas, aunque figuraron en ediciones pasadas del diccionario académico. Exuberante, en cambio, se escribe sin h.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. hexágono', 'El uso culto mayoritario mantiene hoy la h- etimológica (→ hexa-), por lo que no se considera correcta la grafía ⊗exágono', null, '5eccb13ff0980fa905a4ec00dbb21a071a8a5f69e4fc404949ee8b46a5a4319f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5eccb13ff0980fa905a4ec00dbb21a071a8a5f69e4fc404949ee8b46a5a4319f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'exágono', true), ('B', 'hexágono', false), ('C', 'hexagonal', false), ('D', 'exuberante', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «Su presencia cohibe a los alumnos, que enseguida se callan y hojean el libro».', 'La forma correcta es cohíbe: la h intercalada no impide el hiato, y la i tónica debe llevar tilde (cohíbo, cohíbes, cohíbe, cohíben). Hojean, de hojear (''pasar las hojas''), está bien escrita.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 3, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. cohibir', 'La hache intercalada no exime de la obligación de tildar la i para marcar el hiato en las formas en que esta vocal es tónica (→ tilde2, 2.3.2a): cohíbo, cohíbes, cohíbe, cohíben', null, 'd9581845cd6e04e82e688934dcb302023d3d71978512c33b1bfa56d16120b717', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd9581845cd6e04e82e688934dcb302023d3d71978512c33b1bfa56d16120b717')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'alumnos', false), ('B', 'enseguida', false), ('C', 'cohibe', true), ('D', 'hojean', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «Durante su convalescencia tomó yogur, leyó con espontaneidad y recibió la enhorabuena de todos».', 'Debe escribirse convalecencia, sin el grupo -sc- etimológico; el DPD no considera hoy correctas ⊗convalescer, ⊗convalescencia ni ⊗convalesciente.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 3, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. convalecer', 'no se consideran hoy correctas las formas ⊗convalescer, ⊗convalescencia ni ⊗convalesciente', null, 'b38b25fc41196996ff94d39371186deb73ec257cb5a0779242ac21a6d0cb0329', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b38b25fc41196996ff94d39371186deb73ec257cb5a0779242ac21a6d0cb0329')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'yogur', false), ('B', 'espontaneidad', false), ('C', 'enhorabuena', false), ('D', 'convalescencia', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «Compró un dentrífico, un yogur y un cepillo en la tienda del garaje».', 'La forma correcta es dentífrico (''pasta para limpiar la dentadura''); el DPD da como erróneas ⊗dentrífrico y ⊗dentrífico.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. dentífrico', 'Son erróneas las formas ⊗dentrífrico y ⊗dentrífico.', null, 'f80739221eb249b0ed0c0209c7bb7f96de0833df4b656131a3405c8268094e62', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f80739221eb249b0ed0c0209c7bb7f96de0833df4b656131a3405c8268094e62')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'yogur', false), ('B', 'dentrífico', true), ('C', 'cepillo', false), ('D', 'garaje', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «El servicio de metereología anunció una tormenta espléndida y una bajada exorbitante de las temperaturas».', 'Se escribe meteorología (de meteoro); el DPD califica de incorrecta ⊗metereología y sus derivados ⊗metereólogo y ⊗metereológico.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. meteorología', 'Es incorrecta la forma ⊗metereología, así como sus derivados ⊗metereólogo, ⊗metereológico, en lugar de meteorólogo y meteorológico.', null, '246a954764b388d30dd5f83889eee78203159005bcf57f53a0c6cfbbfe8f8d7f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '246a954764b388d30dd5f83889eee78203159005bcf57f53a0c6cfbbfe8f8d7f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'metereología', true), ('B', 'espléndida', false), ('C', 'exorbitante', false), ('D', 'temperaturas', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «El palacio recuperó su antiguo explendor tras una restauración espontánea que superó las expectativas».', 'Espléndido y toda su familia léxica (esplendor, esplendoroso) se escriben con s; el DPD considera incorrectas ⊗expléndido, ⊗explendor y ⊗explendoroso.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. espléndido', 'En este adjetivo y en el resto de las palabras de su misma familia léxica, como esplendor o esplendoroso, son incorrectas las grafías con x: ⊗expléndido, ⊗explendor, ⊗explendoroso.', null, 'be2c35ee58e1a33109b1b24aca98bfb377349f27ced977f51618f580ed8854c8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'be2c35ee58e1a33109b1b24aca98bfb377349f27ced977f51618f580ed8854c8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'explendor', true), ('B', 'espontánea', false), ('C', 'expectativas', false), ('D', 'restauración', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «Llegaron ventidós agentes, veintiún vehículos y treinta y un guías».', 'En los numerales de la veintena no debe reducirse el diptongo ei a e: lo correcto es veintidós; el DPD rechaza ⊗ventiuno, ⊗ventidós, ⊗ventitrés, etc.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. veintiuno', 'El diptongo ei no debe reducirse a e ni en la grafía ni en la pronunciación de este numeral, ni en las del resto de los que completan la decena: ⊗ventiuno, ⊗ventidós, ⊗ventitrés, ⊗venticuatro, etc.', null, '28d71b265a8f3f61e6a33d061ac0e1a3f2063cf680f4b64c61ee127d2b597e46', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '28d71b265a8f3f61e6a33d061ac0e1a3f2063cf680f4b64c61ee127d2b597e46')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'veintiún', false), ('B', 'treinta', false), ('C', 'ventidós', true), ('D', 'guías', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «El plan prevee el desahucio, pero el juez previó un plazo y el abogado lo reivindicó».', 'Prever se conjuga como ver: prevé, previó, previendo. Son incorrectas las formas que lo tratan como proveer o leer (⊗preveer, ⊗prevee, ⊗preveyó): lo correcto es «El plan prevé el desahucio».', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. prever', 'Es incorrecta la grafía ⊗preveer, debida al cruce con proveer (''suministrar''; → proveer(se)), cuyo modelo es leer; por tanto, son incorrectas formas como ⊗prevee, ⊗preveyó, ⊗preveyendo, etc., en lugar de prevé, previó, previendo, etc.', null, 'f980e41a00ba99dd2b66baa0b113ab3e633615a17adc181fb0aa8dbfc85c6ad7', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f980e41a00ba99dd2b66baa0b113ab3e633615a17adc181fb0aa8dbfc85c6ad7')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'desahucio', false), ('B', 'prevee', true), ('C', 'previó', false), ('D', 'reivindicó', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «Antes de salir, echó una hojeada a los periódicos, hojeó la revista y ojeó el horizonte».', 'El sustantivo derivado de ojear (''mirar rápida y superficialmente'') es ojeada; el DPD considera incorrecta ⊗hojeada, incluso cuando lo que se mira es un libro o revista. Hojeó (pasó las hojas) y ojeó (miró rápidamente) son correctas, cada una con su sentido.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 3, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. ojear', 'Es incorrecta la grafía ⊗hojeada ―error debido al influjo de hojear―, incluso cuando lo que se mira es un libro o revista que puede hojearse', null, '7f3171de1106acb138536b087e2fa9732e4a4a0060fd632a08143fb867c7af66', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7f3171de1106acb138536b087e2fa9732e4a4a0060fd632a08143fb867c7af66')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'hojeó', false), ('B', 'ojeó', false), ('C', 'horizonte', false), ('D', 'hojeada', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «El Gobierno decidió grabar con un nuevo impuesto los productos importados, según reveló el ministro».', 'Con el sentido de ''imponer un gravamen o impuesto'' el verbo es gravar, con v; grabar, con b, significa ''marcar en una superficie'' o ''registrar sonidos o imágenes''. Reveló (''manifestó algo oculto'') se escribe con v.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. grabar y gravar', '''Imponer un gravamen o impuesto [a alguien o a algo]''', null, 'd040ba8b8ea9e0d241905e9ee57525c7c44a6744704d975a706e19f646596a1d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd040ba8b8ea9e0d241905e9ee57525c7c44a6744704d975a706e19f646596a1d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'impuesto', false), ('B', 'importados', false), ('C', 'reveló', false), ('D', 'grabar', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «Los presos se revelaron contra los guardias y reivindicaron mejoras con una actitud exorbitante».', 'Con el sentido de ''sublevarse o negarse a obedecer'' el verbo es rebelarse, con b; revelar, con v, significa ''descubrir o manifestar algo ignorado u oculto''. El DPD advierte que no deben confundirse gráficamente.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. rebelar', 'No debe confundirse gráficamente con el verbo homófono revelar(se) (''descubrir(se) o manifestar(se) algo ignorado u oculto''', null, '2e57912fbf50aa6b9e060b3cac6c1c81c006aed848395e84d692c3dd55294e62', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2e57912fbf50aa6b9e060b3cac6c1c81c006aed848395e84d692c3dd55294e62')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'revelaron', true), ('B', 'guardias', false), ('C', 'reivindicaron', false), ('D', 'exorbitante', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «El monitor pidió inspirar despacio y, al expirar el aire de los pulmones, relajar los hombros antes de que expirase el plazo».', '''Expulsar el aire de los pulmones'' es espirar, con s; expirar, con x, significa ''morir'' o ''acabarse un periodo de tiempo'', por lo que expirase el plazo es correcto.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 3, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. espirar', '''Expulsar el aire de los pulmones'': «Inspirar echando la cabeza y los hombros hacia atrás. Al espirar, volver a la posición relajada»', null, '100d6382cbd8643182b562c035610f62867b7fd5aa2bad2b74701a7a20f91fa3', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '100d6382cbd8643182b562c035610f62867b7fd5aa2bad2b74701a7a20f91fa3')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'inspirar', false), ('B', 'pulmones', false), ('C', 'expirar', true), ('D', 'expirase', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «La Guardia Civil aprendió 760 kilos de resina de hachís tras una aprehensión anterior en el mismo puerto».', 'Con el sentido de ''capturar [algo, especialmente mercancía de contrabando]'' el verbo es aprehender; aprender tiene hoy un uso diferenciado. El propio DPD pone el ejemplo «La Guardia Civil aprehendió 760 kilos de resina de hachís».', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. aprehender', '«La Guardia Civil aprehendió 760 kilos de resina de hachís» (País es 30.8.1997)', null, 'deb2010ce4e8b3cdcda3641087e449d6752a6c9cf3db5ce1c529f65de23e45d6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'deb2010ce4e8b3cdcda3641087e449d6752a6c9cf3db5ce1c529f65de23e45d6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'resina', false), ('B', 'aprendió', true), ('C', 'aprehensión', false), ('D', 'puerto', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra o expresión que presenta falta de ortografía: «Ella canta también que enseguida la ha contratado una orquesta».', 'En las construcciones consecutivas y comparativas debe escribirse tan bien, en dos palabras: Canta tan bien que la ha contratado una orquesta. También es el adverbio que indica adición.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. también', 'La secuencia tan bien se usa en construcciones comparativas (Canta tan bien como su padre) y consecutivas (Canta tan bien que la ha contratado una orquesta).', null, 'd8a2aa2c14b6bdb646721f14654051ab52bb1245e83a2bbb916f12d4f489e439', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd8a2aa2c14b6bdb646721f14654051ab52bb1245e83a2bbb916f12d4f489e439')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'canta', false), ('B', 'enseguida', false), ('C', 'también', true), ('D', 'orquesta', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la palabra que presenta falta de ortografía: «El museo conserva un rico acerbo cultural y recibió críticas acerbas por su espléndido pero exorbitante presupuesto».', 'El sustantivo ''conjunto de bienes'' es acervo, con v (acervo cultural); acerbo, con b, es el adjetivo ''áspero o agrio'', correcto en críticas acerbas.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. acerbo', 'No debe confundirse la forma masculina de este adjetivo con el sustantivo acervo (''conjunto de bienes''; → acervo).', null, '5197e3fe6321e6ebd4d1358ce63f5637cce33bd7fedfa733a8bc32390ec51715', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5197e3fe6321e6ebd4d1358ce63f5637cce33bd7fedfa733a8bc32390ec51715')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'acerbo', true), ('B', 'acerbas', false), ('C', 'espléndido', false), ('D', 'exorbitante', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la forma incorrecta según las reglas de acentuación gráfica:', 'Los monosílabos no se acentúan gráficamente, salvo tilde diacrítica. Guion es monosílabo a efectos ortográficos (como fue, vio, hui), por lo que se escribe sin tilde.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. tilde2, 1.1', 'Las palabras de una sola sílaba no se acentúan nunca gráficamente, salvo en los casos de tilde diacrítica (→ 3.1): mes, bien, fe, fue, vio, guion, hui, riais.', null, '20005f801a7be3b69ee85be9603128f7839ca37583b9ba5738bb3e0f4a764670', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '20005f801a7be3b69ee85be9603128f7839ca37583b9ba5738bb3e0f4a764670')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'guion', false), ('B', 'guión', true), ('C', 'fue', false), ('D', 'vio', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la forma incorrecta: «La avería mecanica del cántaro de cristal fue rápida de reparar».', 'Las palabras esdrújulas llevan siempre tilde: mecánica, cántaro, rápida. Avería lleva tilde por el hiato de vocal cerrada tónica.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. tilde2, 1.2.3', 'Las palabras esdrújulas (→ acento, 1.2c) y sobresdrújulas (→ acento, 1.2d) siempre llevan tilde: cántaro, mecánica, cómetelo, llévesemelo.', null, '2c8f27067c34373944dcac318c0cef0dc69c5171636d7303f1c9cebad1d30333', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2c8f27067c34373944dcac318c0cef0dc69c5171636d7303f1c9cebad1d30333')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'avería', false), ('B', 'cántaro', false), ('C', 'rápida', false), ('D', 'mecanica', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la forma incorrecta: «La caída del árbol dejó a la vista la raiz y un laúd enterrado junto a la grúa».', 'Las palabras con hiato de vocal abierta átona y cerrada tónica llevan siempre tilde en la cerrada, aunque no les correspondiera por las reglas generales: raíz, caída, laúd, grúa.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 1, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. tilde2, 2.3.2a', 'siempre llevan tilde sobre la vocal cerrada, con independencia de lo que establecen las reglas generales de acentuación: armonía, grúa, insinúe, dúo, río, hematíe, laúd, caída, raíz', null, 'eb1a997b99ece32de3d7f00eaa864c434c4bef341b5672282d50a104938596bb', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'eb1a997b99ece32de3d7f00eaa864c434c4bef341b5672282d50a104938596bb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'caída', false), ('B', 'laúd', false), ('C', 'raiz', true), ('D', 'grúa', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la forma incorrecta según las reglas de acentuación de las palabras agudas:', 'Las agudas llevan tilde si terminan en -n, -s o vocal (compás, colibrí), pero no si terminan en -y: virrey, convoy, estoy.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. tilde2, 1.2.1', 'o cuando terminan en -y: guirigay, virrey, convoy, estoy.', null, 'a2bb9e66a5d1913ec87caaaf6317d4704d380142a8e15d95a7db83097926f447', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a2bb9e66a5d1913ec87caaaf6317d4704d380142a8e15d95a7db83097926f447')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'convóy', true), ('B', 'virrey', false), ('C', 'compás', false), ('D', 'colibrí', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la forma incorrecta: «El buho vigilaba al rehén mientras el guardia prohíbe el paso al almacén de bebidas alcohólicas».', 'La hache intercalada no exime de tildar la vocal tónica del hiato: búho, prohíbe. Alcohólicas es esdrújula y rehén, aguda terminada en -n.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. tilde2, 2.3.2', 'La presencia de una hache intercalada no exime de la obligación de tildar la vocal tónica del hiato: búho, ahíto, prohíbe, alcohólico, rehén, turbohélice.', null, 'a8ed9955936afd05b5fb1af6e21c42599c60c5f87435ca11e1134a95433e0a17', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a8ed9955936afd05b5fb1af6e21c42599c60c5f87435ca11e1134a95433e0a17')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'alcohólicas', false), ('B', 'rehén', false), ('C', 'prohíbe', false), ('D', 'buho', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según las normas vigentes, señale la frase con un uso incorrecto de la tilde:', 'El adverbio solo es una palabra llana terminada en vocal: es obligatorio escribirlo sin tilde cuando no hay riesgo de ambigüedad, como en Solo le interesa el deporte. La tilde solo es optativa en casos de ambigüedad.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. tilde2, 3.3', 'a) Es obligatorio escribir sin tilde el adverbio solo en contextos donde su empleo no entrañe riesgo de ambigüedad.', null, '557b171286f1b73592834dbc406672c52173f1e23b8f5b43dd5b89fb7bd43ab1', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '557b171286f1b73592834dbc406672c52173f1e23b8f5b43dd5b89fb7bd43ab1')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Solo le interesa el deporte.', false), ('B', 'Sólo le interesa el deporte.', true), ('C', 'Está muy solo desde que se mudó.', false), ('D', 'Solo quiero un café.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase con una falta de acentuación gráfica:', 'Los demostrativos neutros esto, eso y aquello nunca se han escrito ni se deben escribir con tilde. Esta, sin riesgo de ambigüedad, también se escribe sin tilde.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. tilde2, 3.4', 'Los demostrativos neutros esto, eso y aquello, que son siempre pronombres, nunca se han escrito, ni se deben escribir, con tilde: Eso no es cierto; No entiendo esto.', null, 'c2d2b128193b2fe25651c9a7579350d0adaa81b80e30f14ecb4689c01feed79b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c2d2b128193b2fe25651c9a7579350d0adaa81b80e30f14ecb4689c01feed79b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Eso no es cierto.', false), ('B', 'Éso no es cierto.', true), ('C', 'No entiendo esto.', false), ('D', 'Esta es la casa.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase con un uso incorrecto de aún/aun:', 'Aún lleva tilde cuando puede sustituirse por todavía (valor temporal): Aún la espera. Se escribe aun, sin tilde, cuando equivale a hasta, incluso, siquiera o tiene valor concesivo (aun cansado = aunque estaba cansado).', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 3, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. tilde2, 4', 'a) Con valor temporal, denotando la continuidad o persistencia de una situación: Aún la espera.', null, '87238d19b593b3bc9987b98a10c75072efb50c1a70b01b44261df51a05dddc3f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '87238d19b593b3bc9987b98a10c75072efb50c1a70b01b44261df51a05dddc3f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Aun la espera en la estación.', true), ('B', 'Ni aun con descuento podría pagarlo.', false), ('C', 'Aun cansado, terminó el trabajo.', false), ('D', 'Es joven aún.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la forma verbal con pronombre enclítico que está mal acentuada:', 'Las formas con enclíticos siguen las reglas generales: deles, estate o suponlo son llanas terminadas en vocal o -s y van sin tilde; déselo y cuéntame son esdrújulas, y oídme lleva tilde por el hiato.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 3, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. tilde2, 5.3', 'así, formas como estate, suponlo, deles se escriben ahora sin tilde por ser palabras llanas terminadas en vocal o en -s, mientras que déselo, cuéntame, entiéndannos llevan tilde por ser esdrújulas, y oídme, salíos, reírte, por contener un hiato de vocal cerrada tónica y vocal abierta átona.', null, '2e2f49dec135c2f1025e20b22410f54f9dd43baa5086f877daba2118a4063a08', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2e2f49dec135c2f1025e20b22410f54f9dd43baa5086f877daba2118a4063a08')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'déselo', false), ('B', 'cuéntame', false), ('C', 'oídme', false), ('D', 'déles', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase incorrecta desde el punto de vista de la acentuación gráfica:', 'Fie (pretérito) es monosílabo a efectos ortográficos y se escribe sin tilde; fíe y fío llevan tilde por el hiato de vocal cerrada tónica.', 'gcl_25a_ortografia', (select id from public.topics where slug = 'gcl-25a-ortografia'), 3, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. tilde2, 1.1', 'Si quieres que me fíe de ti, tienes que decirme la verdad, frente a Me fie de ti porque te consideraba mi amigo.', null, '5c25f4ade549f4e4fa558e571b70abdcbe7af0605d8b5c4f084c0ca981833d3c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5c25f4ade549f4e4fa558e571b70abdcbe7af0605d8b5c4f084c0ca981833d3c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Me fie de ti porque te consideraba mi amigo.', false), ('B', 'Si quieres que me fíe de ti, dime la verdad.', false), ('C', 'Me fié de ti porque te consideraba mi amigo.', true), ('D', 'No me fío de nadie.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Lote gcl-25b-gramatica-rae_dpd-v1 (30 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Academia Española y ASALE · Diccionario panhispánico de dudas (DPD), 2.ª edición en línea', 'https://www.rae.es/dpd/', 'web_oficial'::public.source_kind, 'Real Academia Española y Asociación de Academias de la Lengua Española', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gcl-25b-gramatica', 'Tema 25. Lengua española (II): gramática') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gcl-25b-gramatica' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase incorrecta desde el punto de vista sintáctico:', 'Es un caso de dequeísmo: la subordinada es complemento directo de pensar y el complemento directo nunca va encabezado por la preposición de. Alegrarse de algo y estar seguro de algo sí exigen la preposición.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 1, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. dequeísmo, 1a', 'El complemento directo nunca va encabezado por la preposición de y, por tanto, son incorrectas oraciones como ⊗Pienso de que conseguiremos ganar el campeonato', null, '517e3c0348df1883a67f26c383ed52574f0f444f0c88069d0ced403ce6792929', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '517e3c0348df1883a67f26c383ed52574f0f444f0c88069d0ced403ce6792929')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Pienso que conseguiremos ganar el campeonato.', false), ('B', 'Pienso de que conseguiremos ganar el campeonato.', true), ('C', 'Me alegro de que seáis felices.', false), ('D', 'Estoy seguro de que vendrá.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Diccionario panhispánico de dudas, el dequeísmo es:', 'El dequeísmo es el uso indebido de de ante que; la supresión indebida de la preposición es el queísmo, y el uso de le como complemento directo es el leísmo.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 1, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. dequeísmo', 'Es el uso indebido de la preposición de delante de la conjunción que cuando la preposición no está gramaticalmente justificada.', null, '820b0424b2ea46eef73571e5ff8864fdba8ee67153dbdc469dfd8366d2cacd62', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '820b0424b2ea46eef73571e5ff8864fdba8ee67153dbdc469dfd8366d2cacd62')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'La supresión indebida de la preposición de delante de la conjunción que cuando está gramaticalmente justificada.', false), ('B', 'El uso de le(s) en función de complemento directo.', false), ('C', 'El uso indebido de la preposición de delante de la conjunción que cuando la preposición no está gramaticalmente justificada.', true), ('D', 'El empleo del pronombre que como relativo posesivo en lugar de cuyo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase incorrecta desde el punto de vista sintáctico:', 'Con alegrar (no pronominal) la subordinada es el sujeto y el sujeto nunca va encabezado por preposición: Me alegra que seáis felices. En cambio, el pronominal alegrarse exige de: Me alegro de que seáis felices.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. dequeísmo, 1b', '⊗Me alegra de que seáis felices (correcto: Me alegra que seáis felices)', null, '81d095e8e0796e34bb4b1edae3241c87b67be3e960c6e00f18decb9da77eed8d', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '81d095e8e0796e34bb4b1edae3241c87b67be3e960c6e00f18decb9da77eed8d')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Me alegra que seáis felices.', false), ('B', 'Me alegro de que seáis felices.', false), ('C', 'Me preocupo de que no os falte nada.', false), ('D', 'Me alegra de que seáis felices.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase incorrecta:', 'En las oraciones copulativas con sujeto pospuesto no debe anteponerse de a la subordinada: lo correcto es Es posible que nieve mañana.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 1, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. dequeísmo, 1b', 'También es frecuente el dequeísmo en oraciones copulativas con sujeto posverbal: ⊗Es posible de que nieve mañana (correcto: Es posible que nieve mañana)', null, '5fda938e704827259d08e5c8d3e0ba944068156428ad9da0f3388a0c52c2e3db', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5fda938e704827259d08e5c8d3e0ba944068156428ad9da0f3388a0c52c2e3db')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Es posible de que nieve mañana.', true), ('B', 'Es posible que nieve mañana.', false), ('C', 'Mi intención es que participemos todos.', false), ('D', 'Se rumorea que está en quiebra.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿En cuál de las siguientes frases hay un uso incorrecto de la preposición de?', 'Es dequeísmo insertar de en locuciones conjuntivas que no la llevan: a medida que, a menos que, a no ser que, una vez que. A pesar de que, en cambio, sí lleva de.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. dequeísmo, 1d', 'd) Cuando se inserta la preposición de en locuciones conjuntivas que no la llevan: ⊗a medida de que (correcto: a medida que; → medida, 1)', null, 'c4f26cd2840060b9820d3f424b4a02411e8cc2a20f389a331e93af9145dc8060', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c4f26cd2840060b9820d3f424b4a02411e8cc2a20f389a331e93af9145dc8060')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A pesar de que llovía, salimos a pasear.', false), ('B', 'Una vez que terminó, se marchó.', false), ('C', 'A menos que llueva, iremos al campo.', false), ('D', 'A medida de que avanzaba la noche, aumentaba el frío.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase incorrecta desde el punto de vista sintáctico:', 'Insistir exige la preposición en (insistir en algo); usar de en su lugar es un caso de dequeísmo. Tratar de algo (''procurarlo'') sí lleva de.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. dequeísmo, 1e', '⊗Insistieron de que fuéramos con ellos (correcto: Insistieron en que fuéramos con ellos)', null, '8f0c107c7f5dcc041181c9bffa5d13790b68acc7837e173cd13429ae4226de74', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '8f0c107c7f5dcc041181c9bffa5d13790b68acc7837e173cd13429ae4226de74')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Insistieron de que fuéramos con ellos.', true), ('B', 'Insistieron en que fuéramos con ellos.', false), ('C', 'Me fijé en que llevaba corbata.', false), ('D', 'Trato de que estéis a gusto.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase incorrecta por supresión indebida de una preposición (queísmo):', 'Olvidarse (pronominal) se construye con de: Me olvidé de que… La forma no pronominal olvidar lleva complemento directo sin preposición: Olvidó que…', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. queísmo, 1a', 'Me olvidé de que tenía que llamarte (no ⊗Me olvidé que tenía que llamarte)', null, '01a6c4675929e369968f28d65f12437626d4a58ad83b418ba52705dde20d9802', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '01a6c4675929e369968f28d65f12437626d4a58ad83b418ba52705dde20d9802')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Me olvidé de que tenía que llamarte.', false), ('B', 'Me olvidé que tenía que llamarte.', true), ('C', 'Olvidó que tenía que ir al dentista.', false), ('D', 'No se acordó de que era mi cumpleaños.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase incorrecta:', 'Es queísmo suprimir la preposición en locuciones como a pesar de que, a fin de que, a condición de que o en caso de que.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. queísmo, 1e', 'e) En locuciones o construcciones como a pesar de que (no ⊗a pesar que)', null, '7aa11dd63a30f9f7b6f9057d98eb4447385c0c9a3aadd229ee70f1c2830bce2f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7aa11dd63a30f9f7b6f9057d98eb4447385c0c9a3aadd229ee70f1c2830bce2f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A fin de que lo entiendas, te lo repetiré.', false), ('B', 'En caso de que llueva, suspenderemos el acto.', false), ('C', 'A pesar que estaba cansado, terminó el informe.', true), ('D', 'A condición de que vengas pronto, te espero.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase incorrecta:', 'Darse cuenta y caer en la cuenta exigen de (Nos dimos cuenta de que era tarde); tener en cuenta, en cambio, no exige la preposición.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 3, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. queísmo, 1f', 'Nos dimos cuenta de que era tarde (no ⊗Nos dimos cuenta que era tarde). No deben confundirse las locuciones caer en la cuenta o darse cuenta, que exigen de, con tener en cuenta, que no exige la preposición', null, 'bc06a705a4b242cb70437b455bfcb116bb840ca5117fb5431925db77cc4aabd9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'bc06a705a4b242cb70437b455bfcb116bb840ca5117fb5431925db77cc4aabd9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Nos dimos cuenta que era tarde.', true), ('B', 'No tiene en cuenta que nos esforzamos.', false), ('C', 'Pronto cayó en la cuenta de que estaba solo.', false), ('D', 'No cabe duda de que es un gran escritor.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase en la que se incurre en laísmo:', 'El laísmo es el uso de la(s) como complemento indirecto femenino en lugar de le(s). En La dio un beso, el complemento directo es un beso y a su madre es indirecto: lo correcto es Le dio un beso. En La besó, la sí es complemento directo.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 1, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. laísmo', 'de La besó y Le dio un beso, a ⊗La dio un beso.', null, 'c517d350e5b5293dd6133b1cc2265fba34095d8971a58793f6827fd58839f69e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'c517d350e5b5293dd6133b1cc2265fba34095d8971a58793f6827fd58839f69e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Le dio un beso a su madre al llegar.', false), ('B', 'La besó al llegar.', false), ('C', 'La dio un beso a su madre al llegar.', true), ('D', 'La carta, escríbela hoy mismo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Diccionario panhispánico de dudas, el loísmo consiste en:', 'El loísmo es el uso de lo(s) como complemento indirecto masculino o neutro en lugar de le(s); el uso de le como complemento directo es leísmo, y el de la como indirecto, laísmo.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. loísmo', 'Es el uso impropio de lo(s) en función de complemento indirecto masculino (de persona o de cosa) o neutro (cuando el antecedente es un pronombre neutro o toda una oración), en lugar de le(s)', null, 'ddca916031969286f85ee8d0836cf934abfdc05ca545597258e8517a72446a44', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ddca916031969286f85ee8d0836cf934abfdc05ca545597258e8517a72446a44')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El uso impropio de le(s) en función de complemento directo, en lugar de lo(s).', false), ('B', 'El uso impropio de lo(s) en función de complemento indirecto, en lugar de le(s).', true), ('C', 'El uso impropio de la(s) en función de complemento indirecto femenino.', false), ('D', 'El uso de lo como artículo neutro ante adjetivos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase que el Diccionario panhispánico de dudas considera incorrecta en la norma culta:', 'El leísmo no se admite de ningún modo cuando el referente es inanimado (el libro): debe usarse lo. Sí se admite, por su extensión entre hablantes cultos, le como complemento directo de persona masculina (A tu marido no le he visto).', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 3, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. leísmo, 2', 'El leísmo, en cambio, no se admite de ningún modo en la norma culta cuando el referente es inanimado: ⊗El libro que me prestaste le leí de un tirón', null, '66804b76e392e1a33ce03be39145a4f11d09cb3781245492f068a32e276c1c2a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '66804b76e392e1a33ce03be39145a4f11d09cb3781245492f068a32e276c1c2a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'A tu marido no le he visto.', false), ('B', 'El libro que me prestaste lo leí de un tirón.', false), ('C', 'A tu marido no lo he visto.', false), ('D', 'El libro que me prestaste le leí de un tirón.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase incorrecta desde el punto de vista morfosintáctico:', 'Haber, cuando denota existencia, es impersonal: el sintagma nominal es complemento directo, no sujeto, por lo que el verbo debe permanecer en singular (Había muchos problemas).', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 1, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. haber, 4', 'Por consiguiente, en estos casos, lo más apropiado es que el verbo permanezca en singular', null, '97542ce7b5eb8ec58a23853e77e4fbd94fc17d27cc392d97ba5282e9fcf5bd37', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '97542ce7b5eb8ec58a23853e77e4fbd94fc17d27cc392d97ba5282e9fcf5bd37')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Había muchos problemas en la empresa.', false), ('B', 'Habían muchos problemas en la empresa.', true), ('C', 'Hubo varios momentos en que lloré.', false), ('D', 'Hay alguien esperándote.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase incorrecta:', 'Cuando haber impersonal forma parte de una perífrasis con poder, soler, deber, ir a, etc., el verbo conjugado también debe quedar en singular: Va a haber muchos cambios.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. haber, 4', 'La misma inmovilidad en singular del verbo conjugado debe producirse en el caso de que haber forme parte de una perífrasis con poder, soler, deber, ir a, etc.', null, '5cfcbdd0a47c27ad42d63c16dfb6abc3abee46fe3449688fffc56b582b66a92b', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5cfcbdd0a47c27ad42d63c16dfb6abc3abee46fe3449688fffc56b582b66a92b')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Van a haber muchos cambios en la plantilla.', true), ('B', 'Va a haber muchos cambios en la plantilla.', false), ('C', 'Podía haber víboras en el camino.', false), ('D', 'Suele haber retenes en todas las salidas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase incorrecta:', 'Haber que + infinitivo es impersonal y solo se conjuga en tercera persona del singular; por ello, si el infinitivo es pronominal, no puede llevar el pronombre de primera persona del plural. Para incluir al hablante se usa tener que.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 3, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. haber, 3b', '⊗«Todavía hay que esforzarnos mucho más» (Proceso mx 27.10.1996); debió decirse Todavía hay que esforzarse mucho más.', null, '679e89f3fe7004beec16282fbc390d7308c1e85e9b6ea852ba317e95feeebd6e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '679e89f3fe7004beec16282fbc390d7308c1e85e9b6ea852ba317e95feeebd6e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Todavía hay que esforzarse mucho más.', false), ('B', 'Todavía tenemos que esforzarnos mucho más.', false), ('C', '¿Habrá que esperar mucho?', false), ('D', 'Todavía hay que esforzarnos mucho más.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase incorrecta:', 'El imperativo singular de hacer es haz (tú), no hace. Hace dos días y hacía frío son usos impersonales correctos en tercera persona del singular.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. hacer, 1', 'El imperativo singular es haz (tú) y hacé (vos), y no ⊗hace.', null, '24b2bc5747fc73b9f75163a5f705ec3a3a2ffa9d8ad51f73c146585aeeaf4d42', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '24b2bc5747fc73b9f75163a5f705ec3a3a2ffa9d8ad51f73c146585aeeaf4d42')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Haz tú la cama antes de salir, por favor.', false), ('B', 'Hace dos días que llegó.', false), ('C', 'Hace tú la cama antes de salir, por favor.', true), ('D', 'Hacía bastante frío esa noche.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la expresión que el Diccionario panhispánico de dudas considera redundante y que debe evitarse:', 'Es redundante usar atrás cuando hacer lleva un complemento temporal: debe decirse hace dos años o dos años atrás.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. hacer, 2', 'Es redundante, y debe evitarse, el uso del adverbio atrás cuando hacer se construye con un complemento temporal', null, '5bc02b698ef7402e22293e79c102961909af922f72b92d25a5f8d369787f545e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5bc02b698ef7402e22293e79c102961909af922f72b92d25a5f8d369787f545e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El concurso se falló hace dos años.', false), ('B', 'El concurso se falló dos años atrás.', false), ('C', 'Hace dos días que se falló el concurso.', false), ('D', 'El concurso se falló hace dos años atrás.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase incorrecta:', 'En la construcción hacer público, el adjetivo debe concordar en género y número con el complemento directo: hizo públicos los nombramientos. No es correcto usar público como invariable.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 3, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. hacer, 9', 'el adjetivo público debe concordar en género y número con el sustantivo al que se refiere, esto es, con el complemento directo del verbo hacer', null, '22cf2d90215d39360869f32b86cef673913a5c68989acf94e6e71a4932aba353', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '22cf2d90215d39360869f32b86cef673913a5c68989acf94e6e71a4932aba353')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El ministerio hizo público ayer los nombramientos.', true), ('B', 'El ministerio hizo públicos ayer los nombramientos.', false), ('C', 'El ministerio hizo pública ayer la fecha del examen.', false), ('D', 'El ministerio hizo públicas ayer las listas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase incorrecta desde el punto de vista morfológico:', 'El imperativo de ir para tú es ve (y vete en el uso pronominal); ⊗ves es una forma vulgar que debe evitarse. Para vosotros, id.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 1, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. ir, 1', 'debe evitarse el uso de la forma arcaica ⊗íos y, para el imperativo singular, de la forma vulgar ⊗ves', null, '7f4ca657e121ba829489bbf126cccd78c67a499cf82def1419990b7908fd6cf8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '7f4ca657e121ba829489bbf126cccd78c67a499cf82def1419990b7908fd6cf8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ve al cuarto de baño y lávate las manos.', false), ('B', 'Id a ver si está ya la cena.', false), ('C', 'Ves al cuarto de baño y lávate las manos.', true), ('D', 'Vete a la cama.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Diccionario panhispánico de dudas, ¿cuál de las siguientes formas de imperativo de ir(se) para vosotros debe evitarse?', 'La forma tradicional es idos; iros es hoy mayoritaria en el habla coloquial y se considera también válida. Debe evitarse la forma arcaica íos. Id es el imperativo no pronominal (Id a ver si está ya la cena).', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 3, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. ir, 1', 'y, para los usos pronominales, vete (tú) y, tradicionalmente, idos (vosotros) […] En cambio, debe evitarse el uso de la forma arcaica ⊗íos', null, 'd48b0b4a62e34a31a250ae21562a8c1c90cfdd6e4e318740715e18bafa422833', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd48b0b4a62e34a31a250ae21562a8c1c90cfdd6e4e318740715e18bafa422833')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Idos.', false), ('B', 'Íos.', true), ('C', 'Iros.', false), ('D', 'Id.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Diccionario panhispánico de dudas, la perífrasis «deber de + infinitivo» denota normalmente:', 'Deber + infinitivo denota preferentemente obligación; deber de + infinitivo denota normalmente probabilidad o suposición (La mujer debe de tener unos sesenta años), aunque ambos usos se cruzan con menor frecuencia en la lengua culta.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. deber, 2b', 'b) deber de + infinitivo. Denota normalmente probabilidad o suposición', null, 'bbfb9f9aa61b360fda0b8b7b3eafd738305dfe082512367691c527ff5b605fef', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'bbfb9f9aa61b360fda0b8b7b3eafd738305dfe082512367691c527ff5b605fef')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Obligación.', false), ('B', 'Probabilidad o suposición.', true), ('C', 'Comienzo de una acción.', false), ('D', 'Repetición de una acción.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la expresión que se desaconseja en el habla culta:', 'Detrás es un adverbio y por eso se desaconseja su uso con posesivos (detrás mío, detrás suya); lo correcto es detrás de mí, detrás de él o de ella.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 1, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. detrás, 2', 'Por su condición de adverbio, se desaconseja en el habla culta su uso con posesivos: ⊗detrás mío, ⊗detrás suya, etc. (en lugar de detrás de mí, detrás de él/ella, etc.).', null, 'f6cafb3dd7e5d0759aa475a8fb4dc3a9e57fea4b295f3bb285a31bf3f877a4e2', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f6cafb3dd7e5d0759aa475a8fb4dc3a9e57fea4b295f3bb285a31bf3f877a4e2')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Se sentó detrás de mí.', false), ('B', 'Se escondió detrás de una enredadera.', false), ('C', 'Se sentó detrás mío.', true), ('D', 'Iba detrás de ella.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase incorrecta:', 'Cuando lo que se contrapone son oraciones con verbo en forma personal, sino debe ir seguido de que. No debe confundirse la conjunción sino con la secuencia si no (conjunción condicional + negación).', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. sino, 2.1', 'En la lengua actual, cuando lo que se contrapone son oraciones con el verbo en forma personal, sino debe ir seguido de que', null, 'de8d18e9087b48564f27b8a808af5056e26d349cdf59a01544935a314743882e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'de8d18e9087b48564f27b8a808af5056e26d349cdf59a01544935a314743882e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'No compraba la droga, sino la vendía.', true), ('B', 'No compraba la droga, sino que la vendía.', false), ('C', 'No me refiero al trabajo, sino a tu vida misma.', false), ('D', '¿Y quién se lo dirá, si no lo hace usted?', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la forma verbal incorrecta:', 'Conducir, como todos los verbos en -ducir, es irregular en el pretérito perfecto simple y tiempos derivados: conduje, condujo, condujera, condujese. Las formas regularizadas (⊗conducí, ⊗condució) no se consideran correctas.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 1, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. conducir, 1', '⊗conducí, ⊗conduciste, ⊗condució, etc., en lugar de conduje, condujiste, condujo, etc.', null, 'bb14cbe64628a2b1149b6a158ff4d63258e7bd4ffca9eeb872a371945e70ff75', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'bb14cbe64628a2b1149b6a158ff4d63258e7bd4ffca9eeb872a371945e70ff75')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Condujo.', false), ('B', 'Condujera.', false), ('C', 'Condujese.', false), ('D', 'Condució.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase incorrecta desde el punto de vista morfológico:', 'En el pretérito perfecto simple y en los subjuntivos derivados solo se admiten en la norma culta las formas con raíz anduv- (anduve, anduviera); ⊗andé, ⊗andaste no se consideran correctas.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 1, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. andar, 1', 'Así pues, no se consideran correctas las formas de estos tiempos con la raíz regular and-: ⊗andé, ⊗andaste', null, '5750356d3ca55946eabdc4754034109fc197c7af3ae94e82e44c6696b7b0bd9a', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '5750356d3ca55946eabdc4754034109fc197c7af3ae94e82e44c6696b7b0bd9a')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Ayer anduve diez kilómetros por el monte.', false), ('B', 'Ayer andé diez kilómetros por el monte.', true), ('C', 'Si anduvieras más, estarías en forma.', false), ('D', 'Anduvimos toda la tarde.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase incorrecta:', 'Satisfacer se conjuga como hacer (satisfice, satisficiera, satisfaré, satisfaría); es incorrecto conjugarlo como regular (⊗satisfací, ⊗satisfaciera, ⊗satisfaceré).', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. satisfacer, 1', 'Es incorrecto, aunque no infrecuente, incluso en la lengua escrita, conjugar este verbo como si fuera regular, usando formas como ⊗satisfací, ⊗satisfaciera, ⊗satisfaceré, ⊗satisfacería, etc., en lugar de satisfice, satisficiera, satisfaré, satisfaría, etc.', null, '2823e58c517d68d13f45300ce87b4eb6f457f56c483b42ef097a76b3fba4b963', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '2823e58c517d68d13f45300ce87b4eb6f457f56c483b42ef097a76b3fba4b963')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Si satisficiera la deuda, quedaría libre.', false), ('B', 'No le satisfizo la aclaración.', false), ('C', 'Si satisfaciera la deuda, quedaría libre.', true), ('D', 'Satisfaré todas tus dudas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la forma verbal incorrecta del verbo errar en el uso culto mayoritario:', 'Errar es irregular en el uso culto mayoritario: solo comienzan por ye- las formas con la raíz tónica (yerro, yerras, yerra, yerran). Cuando el acento recae en la desinencia, no se diptonga: erramos, errabais; ⊗yerramos es incorrecta.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 3, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. errar, 1', 'Son, pues, incorrectas las formas con ye- cuando el acento de intensidad recae en la desinencia verbal y no en la raíz: ⊗yerramos, ⊗yerráis, ⊗yerraba, etc.', null, '4ba9ef26d6f75745cd977a53325889dbfa0f2f47cf79fa2d228fb8fc4ba258cb', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '4ba9ef26d6f75745cd977a53325889dbfa0f2f47cf79fa2d228fb8fc4ba258cb')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Yerro.', false), ('B', 'Yerras.', false), ('C', 'Erramos.', false), ('D', 'Yerramos.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Señale la frase en la que «sendos» está mal empleado:', 'Sendos es un distributivo que significa ''uno para cada uno'' y no debe emplearse como equivalente de dos o ambos. En la primera frase se usa con el sentido de ''ambos''.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 3, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. sendos, 2', 'No debe emplearse como equivalente de dos o ambos', null, 'af21409159ae3efad53c5d1b527aae06583fe8efb8e6fd7a2fc7ff62126c171c', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'af21409159ae3efad53c5d1b527aae06583fe8efb8e6fd7a2fc7ff62126c171c')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Robaron en la farmacia y en el estanco, y sendos atracos los cometió la misma persona.', true), ('B', 'Los dos agentes llevaban sendos chalecos reflectantes.', false), ('C', 'Al final de la lista había tres líneas marcadas con sendos asteriscos.', false), ('D', 'Los ganadores recibieron sendas medallas.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Diccionario panhispánico de dudas, ¿cuál de las siguientes variantes no se considera correcta?', 'El DPD no considera correcta la variante ⊗con base a; con base en y en base a se admiten (esta última menos recomendable), y sobre la base de es una de las fórmulas tradicionales preferidas.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. base, 5', 'No se considera correcta, en cambio, la variante ⊗con base a.', null, '742f769d2c9f1d02c063c7159b3a2f483b82eb6036502c21dee91ac5fba2dda5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '742f769d2c9f1d02c063c7159b3a2f483b82eb6036502c21dee91ac5fba2dda5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Con base en.', false), ('B', 'Con base a.', true), ('C', 'Sobre la base de.', false), ('D', 'En base a.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el Diccionario panhispánico de dudas, el relativo posesivo cuyo concuerda en género y número con:', 'Cuyo se construye con un antecedente explícito (el poseedor) y se antepone al sustantivo que denota lo poseído, con el que concuerda: la casa cuyas ventanas. Además, por ser átono, se escribe sin tilde.', 'gcl_25b_gramatica', (select id from public.topics where slug = 'gcl-25b-gramatica'), 2, 'es', true, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'DPD, s. v. cuyo, 1', 'se antepone al sustantivo que denota lo poseído, con el que concuerda en género y número', null, 'b27e1e270d69fc4d52fc38631caafb9cc9a142ad80e13ef319685d5bd4b37767', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'b27e1e270d69fc4d52fc38631caafb9cc9a142ad80e13ef319685d5bd4b37767')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El sustantivo que denota lo poseído, al que se antepone.', true), ('B', 'El antecedente, que expresa el poseedor.', false), ('C', 'El sujeto de la oración principal.', false), ('D', 'El verbo de la oración de relativo.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug in ('guardia-civil-cabos-guardias');
-- Fichas de estudio (17) · generado por scripts/content/notes-to-sql.mjs
insert into public.sources (title, url, kind, publisher, published_on) values ('Carta de las Naciones Unidas (texto completo)', 'https://www.un.org/es/about-us/un-charter/full-text', 'web_oficial'::public.source_kind, 'Naciones Unidas (un.org)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-01b-naciones-unidas', 'Tema 1. Derechos humanos (II): Carta de las Naciones Unidas, sus órganos, DUDH y Consejo de Derechos Humanos') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-01b-naciones-unidas' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'es', '[{"n":"1","title":"Carta de las Naciones Unidas (San Francisco, 1945)"},{"n":"1.1","title":"Propósitos y principios (arts. 1-2)"},{"n":"1.2","title":"Miembros: admisión, suspensión y expulsión (arts. 3-6)"},{"n":"1.3","title":"Órganos principales (arts. 7-8)"},{"n":"2","title":"Asamblea General: composición, funciones y votación (arts. 9-22)"},{"n":"3","title":"Consejo de Seguridad: composición, funciones y votación (arts. 23-32)"},{"n":"4","title":"Consejo Económico y Social (arts. 61-72)"},{"n":"5","title":"Corte Internacional de Justicia y Secretaría (arts. 92-101)"},{"n":"6","title":"Declaración Universal de los Derechos Humanos (1948)"},{"n":"7","title":"Consejo de Derechos Humanos de las Naciones Unidas (2006)"}]'::jsonb, '["Art. 2 Carta de las Naciones Unidas: «La Organización esta basada en el principio de la igualdad soberana de todos sus Miembros.»","Art. 4 Carta de las Naciones Unidas: «La admisión de tales Estados como Miembros de las Naciones Unidas se efectuará por decisión de la Asamblea General a recomendación del Consejo de Seguridad.»","Art. 7 Carta de las Naciones Unidas: «Se establecen como órganos principales de las Naciones Unidas: una Asamblea General, un Consejo de Seguridad, un Consejo Económico y Social, un Consejo de Administración Fiduciaria, una Corte Internacional de Justicia, una Secretaría.»","Art. 9 Carta de las Naciones Unidas: «La Asamblea General estará integrada por todos los Miembros de las Naciones Unidas. Ningun Miembro podrá tener más de cinco representantes en la Asamblea General.»","Art. 18 Carta de las Naciones Unidas: «Las decisiones de la Asamblea General en cuestiones importantes se tomarán por el voto de una mayoria de dos tercios de los miembros presentes y votantes.»","Art. 23 Carta de las Naciones Unidas: «El Consejo de Seguridad se compondrá de quince miembros de las Naciones Unidas.»","Art. 23 Carta de las Naciones Unidas: «Los miembros no permanentes del Consejo de Seguridad serán elegidos por un periodo de dos años.»","Art. 24 Carta de las Naciones Unidas: «sus Miembros confieren al Consejo de Seguridad la responsabilidad primordial de mantener la paz y la seguridad internacionales»","Art. 27 Carta de las Naciones Unidas: «Las decisiones del Consejo de Seguridad sobre todas las demás cuestiones serán tomadas por el voto afirmativo de nueve miembros, incluso los votos afirmativos de todos los miembros permanentes»","Art. 61 Carta de las Naciones Unidas: «El Consejo Económico y Social estará integrado por cincuenta y cuatro Miembros de las Naciones Unidas elegidos por la Asamblea General.»","Art. 92 Carta de las Naciones Unidas: «La Corte Internacional de Justicia será el órgano judicial principal de las Naciones Unidas»","Art. 97 Carta de las Naciones Unidas: «El Secretario General será nombrado por la Asamblea General a recomendación del Consejo de Seguridad. El Secretario General sera el más alto funcionario administrativo de la Organización.»","Introducción DUDH: «la Declaración fue proclamada por la Asamblea General de las Naciones Unidas en París, el 10 de diciembre de 1948 en su (Resolución 217 A (III)) como un ideal común para todos los pueblos y naciones.»","Art. 1 DUDH: «Todos los seres humanos nacen libres e iguales en dignidad y derechos y, dotados como están de razón y conciencia, deben comportarse fraternalmente los unos con los otros.»","Art. 5 DUDH: «Nadie será sometido a torturas ni a penas o tratos crueles, inhumanos o degradantes.»","Composición OHCHR · Consejo de Derechos Humanos: «El Consejo de Derechos Humanos está formado por 47 Estados miembros elegidos directa e individualmente por mayoría de los 193 Estados de la Asamblea General de la ONU.»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://www.un.org/es/about-us/un-charter/full-text'), 'https://www.un.org/es/about-us/un-charter/full-text', null, null, null, 'Otras normas citadas: DUDH (https://www.un.org/es/about-us/universal-declaration-of-human-rights), OHCHR · Consejo de Derechos Humanos (https://www.ohchr.org/es/hr-bodies/hrc/about-council)'
  from public.topics t where t.slug = 'gc-01b-naciones-unidas'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Convención contra la tortura y otros tratos o penas crueles, inhumanos o degradantes (Nueva York, 10 de diciembre de 1984). Instrumento de ratificación, BOE núm. 268, de 9 de noviembre de 1987', 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1987-25053', 'web_oficial'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado (BOE-A-1987-25053)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-01c-tortura-carta-ue-defensor', 'Tema 1. Derechos humanos (III): Convención contra la tortura y Protocolo facultativo, Carta de Derechos Fundamentales de la UE y Defensor del Pueblo (ROF y Mecanismo Nacional de Prevención)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-01c-tortura-carta-ue-defensor' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'es', '[{"n":"1","title":"Convención contra la tortura y otros tratos o penas crueles, inhumanos o degradantes (1984; BOE 9-11-1987)"},{"n":"1.1","title":"Definición de tortura y obligaciones de los Estados (arts. 1-16)"},{"n":"1.2","title":"Comité contra la Tortura: composición, informes y comunicaciones (arts. 17-24)"},{"n":"2","title":"Protocolo facultativo (2002; BOE 22-6-2006)"},{"n":"2.1","title":"Subcomité para la Prevención (arts. 1-16)"},{"n":"2.2","title":"Mecanismos nacionales de prevención (arts. 17-23)"},{"n":"3","title":"Carta de los Derechos Fundamentales de la Unión Europea"},{"n":"3.1","title":"Títulos I a VI: dignidad, libertades, igualdad, solidaridad, ciudadanía y justicia (arts. 1-50)"},{"n":"3.2","title":"Disposiciones generales (arts. 51-54)"},{"n":"4","title":"Defensor del Pueblo como Mecanismo Nacional de Prevención (ROF, 1983)"},{"n":"4.1","title":"Consejo Asesor del Mecanismo Nacional de Prevención (arts. 19-22)"}]'::jsonb, '["Art. 1.1 Convención contra la tortura: «CUANDO DICHOS DOLORES O SUFRIMIENTOS SEAN INFLIGIDOS POR UN FUNCIONARIO PUBLICO U OTRA PERSONA EN EL EJERCICIO DE FUNCIONES PUBLICAS, A INSTIGACION SUYA, O CON SU CONSENTIMIENTO O AQUIESCENCIA.»","Art. 2.2 Convención contra la tortura: «EN NINGUN CASO, PODRAN INVOCARSE CIRCUNSTANCIAS EXCEPCIONALES TALES COMO ESTADO DE GUERRA O AMENAZA DE GUERRA, INESTABILIDAD POLITICA INTERNA O CUALQUIER OTRA EMERGENCIA PUBLICA COMO JUSTIFICACION DE LA TORTURA.»","Art. 2.3 Convención contra la tortura: «NO PODRA INVOCARSE UNA ORDEN DE UN FUNCIONARIO SUPERIOR O DE UNA AUTORIDAD PUBLICA COMO JUSTIFICACION DE LA TORTURA.»","Art. 3.1 Convención contra la tortura: «NINGUN ESTADO PARTE PROCEDERA A LA EXPULSION, DEVOLUCION O EXTRADICION DE UNA PERSONA A OTRO ESTADO CUANDO HAYA RAZONES FUNDADAS PARA CREER QUE ESTARIA EN PELIGRO DE SER SOMETIDA A TORTURA.»","Art. 17.1 Convención contra la tortura: «EL COMITE ESTARA COMPUESTO DE DIEZ EXPERTOS DE GRAN INTEGRIDAD MORAL Y RECONOCIDA COMPETENCIA EN MATERIA DE DERECHOS HUMANOS, QUE EJERCERAN SUS FUNCIONES A TITULO PERSONAL.»","Art. 17.5 Convención contra la tortura: «LOS MIEMBROS DEL COMITE SERAN ELEGIDOS POR CUATRO AÑOS. PODRAN SER REELEGIDOS SI SE PRESENTA DE NUEVO SU CANDIDATURA.»","Art. 1 Protocolo facultativo de la Convención contra la tortura: «El objetivo del presente Protocolo es establecer un sistema de visitas periódicas a cargo de órganos internacionales y nacionales independientes a los lugares en que se encuentren personas privadas de su libertad, con el fin de prevenir la tortura y otros tratos o penas crueles, inhumanos o degradantes.»","Art. 5.1 Protocolo facultativo de la Convención contra la tortura: «El Subcomité para la Prevención estará compuesto de diez miembros. Una vez que se haya registrado la quincuagésima ratificación del presente Protocolo o adhesión a él, el número de miembros del Subcomité para la Prevención aumentará a veinticinco.»","Art. 17 Protocolo facultativo de la Convención contra la tortura: «Cada Estado Parte mantendrá, designará o creará, a más tardar un año después de la entrada en vigor del presente Protocolo o de su ratificación o adhesión, uno o varios mecanismos nacionales independientes para la prevención de la tortura a nivel nacional.»","Art. 30 Protocolo facultativo de la Convención contra la tortura: «No se admitirán reservas al presente Protocolo.»","Art. 1 Carta de los Derechos Fundamentales de la UE: «La dignidad humana es inviolable. Será respetada y protegida.»","Art. 52.3 Carta de los Derechos Fundamentales de la UE: «En la medida en que la presente Carta contenga derechos que correspondan a derechos garantizados por el Convenio Europeo para la Protección de los Derechos Humanos y de las Libertades Fundamentales, su sentido y alcance serán iguales a los que les confiere dicho Convenio.»","Art. 1.2 ROF del Defensor del Pueblo: «El Defensor del Pueblo ejercerá las funciones de Mecanismo Nacional de Prevención de la Tortura, previstas en el Protocolo facultativo de la Convención contra la tortura y otros tratos o penas crueles, inhumanos o degradantes, hecho en Nueva York el 18 de diciembre de 2002, y dará cuenta de su actividad a las Cortes Generales y al Subcomité para la Prevención de la Tortura de la Organización de las Naciones Unidas.»","Art. 19.2 ROF del Defensor del Pueblo: «El Consejo Asesor estará integrado por los Adjuntos del Defensor del Pueblo, como miembros natos, además de por un máximo de 10 Vocales.»","Art. 20.1 ROF del Defensor del Pueblo: «Los Vocales del Consejo Asesor serán designados para un período de cuatro años y se renovarán por mitades cada dos.»","Art. 21.1 ROF del Defensor del Pueblo: «El Consejo Asesor del Mecanismo Nacional de Prevención se reunirá, al menos, dos veces al año.»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1987-25053'), 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1987-25053', null, null, null, 'Otras normas citadas: Protocolo facultativo de la Convención contra la tortura (https://www.boe.es/diario_boe/txt.php?id=BOE-A-2006-11128), Carta de los Derechos Fundamentales de la UE (https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016P/TXT), ROF del Defensor del Pueblo (https://www.boe.es/buscar/act.php?id=BOE-A-1983-10613)'
  from public.topics t where t.slug = 'gc-01c-tortura-carta-ue-defensor'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto 67/2010, de 29 de enero, de adaptación de la legislación de Prevención de Riesgos Laborales a la Administración General del Estado (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2010-2161', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-03b-prevencion-age-guardia-civil', 'Tema 3. Prevención de riesgos laborales (II): RD 67/2010 (AGE) y RD 179/2005 (Guardia Civil)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-03b-prevencion-age-guardia-civil' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'es', '[{"n":"1","title":"RD 67/2010: adaptación de la prevención de riesgos laborales a la Administración General del Estado"},{"n":"1.1","title":"Objeto y ámbito de aplicación; exclusiones (arts. 1-2)"},{"n":"1.2","title":"Plan de Prevención (art. 3)"},{"n":"1.3","title":"Participación y representación: Comisión Técnica, Delegados de Prevención y Comité de Seguridad y Salud (arts. 4-6)"},{"n":"1.4","title":"Servicios de prevención, niveles de cualificación e instrumentos de control (arts. 7-10)"},{"n":"1.5","title":"Funciones de la Dirección General de la Función Pública (art. 11)"},{"n":"2","title":"RD 179/2005: prevención de riesgos laborales en la Guardia Civil"},{"n":"2.1","title":"Objeto y ámbito de aplicación (arts. 1-2)"},{"n":"2.2","title":"Medidas de prevención y protección; obligaciones de la Administración y del personal (arts. 3-12)"},{"n":"2.3","title":"Órganos de prevención, asesoramiento y control; medidas correctoras (arts. 13-16)"}]'::jsonb, '["Art. 2.3 RD 67/2010: «No será de aplicación la Ley 31/1995, de 8 de noviembre, según lo dispuesto en su artículo 3.2, en aquellas actividades cuyas particularidades lo impidan, en el ámbito de las funciones públicas de: a) Policía, seguridad y resguardo aduanero. b) Servicios operativos de protección civil y peritaje forense en los casos de grave riesgo, catástrofe y calamidad pública. c) Fuerzas armadas y actividades militares de la Guardia Civil.»","Art. 4.2 RD 67/2010: «La Comisión Técnica de Prevención de Riesgos Laborales, dependiente de la Mesa General de Negociación de la Administración General del Estado, regulada por el artículo 36.3 de la Ley 7/2007, de 12 de abril, del Estatuto Básico del Empleado Público, será el órgano específico de participación y negociación de las organizaciones sindicales en materia de prevención de riesgos laborales»","Art. 6.1 RD 67/2010: «El citado Comité estará formado por los Delegados de Prevención designados conforme al artículo 5 del presente real decreto y por representantes de la Administración en número no superior al de delegados.»","Art. 6.2 RD 67/2010: «se constituirá un único Comité de Seguridad y Salud en cada uno de los centros de trabajo que se recogen en el Anexo I de este Real Decreto, siempre que dichos centros de trabajo cuenten con 50 o más empleados públicos»","Art. 6.5 RD 67/2010: «El Comité de Seguridad y Salud se reunirá trimestralmente y siempre que lo solicite alguna de las representaciones en el mismo.»","Art. 7.2 RD 67/2010: «a) Constituyendo un servicio de prevención propio. b) Designando a uno o varios empleados públicos para llevarla a cabo. c) Recurriendo a un servicio de prevención ajeno.»","Art. 7.4 RD 67/2010: «los servicios de prevención mancomunados deberán contar con, al menos, tres especialidades o disciplinas preventivas.»","Art. 10.1 RD 67/2010: «cada sistema de prevención deberá someterse a un control periódico externo cuya realización corresponderá al Instituto Nacional de Seguridad e Higiene en el Trabajo»","Art. 2.a) RD 179/2005: «Ámbito personal: incluye a los miembros del Cuerpo de la Guardia Civil y a los miembros de las Fuerzas Armadas destinados en unidades, centros y organismos de la Dirección General de la Guardia Civil.»","Art. 2.b) RD 179/2005: «Las misiones de carácter militar que se encomienden a la Guardia Civil se regirán por sus normas específicas.»","Art. 3 bis.f) RD 179/2005: «f) Priorizar la protección colectiva sobre la individual.»","Art. 6 RD 179/2005: «Estos reconocimientos serán realizados por la Sanidad de la Guardia Civil o bien, mediante la contratación de un servicio de prevención ajeno.»","Art. 13.2 RD 179/2005: «a) Servicio de Prevención. b) Sección de Prevención de Zona. c) Oficina de Prevención de Comandancia. d) Otras unidades.»","Art. 14 RD 179/2005: «El Consejo de la Guardia Civil, según lo dispuesto en el artículo 54.4 de la Ley Orgánica 11/2007, de 22 de octubre, reguladora de los derechos y deberes de los miembros de la Guardia Civil, analizará y valorará las propuestas efectuadas en virtud del principio de participación»","Art. 15 RD 179/2005: «La Inspección de Personal y Servicios de Seguridad de la Secretaría de Estado de Seguridad realizará las funciones de inspección y control externo de las actividades de los órganos citados en el párrafo anterior.»","Art. 16 RD 179/2005: «la Inspección de Personal y Servicios de Seguridad podrá elevar una propuesta de requerimiento definitivo al Secretario de Estado de Seguridad, quien, previos los informes que estime oportunos, dictará la resolución procedente.»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2010-2161'), 'https://www.boe.es/buscar/act.php?id=BOE-A-2010-2161', null, null, null, 'Otras normas citadas: RD 179/2005 (https://www.boe.es/buscar/act.php?id=BOE-A-2005-3241)'
  from public.topics t where t.slug = 'gc-03b-prevencion-age-guardia-civil'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Tratado de la Unión Europea (versión consolidada), títulos I y II (arts. 1-12) y arts. 49-50', 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016M/TXT', 'web_oficial'::public.source_kind, 'Unión Europea · EUR-Lex (DOUE C 202 de 7.6.2016)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-05b-tratados-ue', 'Tema 5. Derecho de la Unión Europea (II): principios, competencias, actos jurídicos y órganos consultivos (TUE y TFUE)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-05b-tratados-ue' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'es', '[{"n":"1","title":"Tratado de la Unión Europea: disposiciones comunes (título I, arts. 1-8)"},{"n":"1.1","title":"Fundamento, valores y objetivos de la Unión (arts. 1-3)"},{"n":"1.2","title":"Principios de atribución, subsidiariedad, proporcionalidad y cooperación leal (arts. 4-5)"},{"n":"1.3","title":"Derechos fundamentales y procedimiento del artículo 7 (arts. 6-7)"},{"n":"2","title":"Principios democráticos (título II, arts. 9-12): ciudadanía, democracia representativa, iniciativa ciudadana y Parlamentos nacionales"},{"n":"3","title":"Adhesión y retirada (arts. 49 y 50 TUE)"},{"n":"4","title":"Competencias de la Unión (TFUE, arts. 2-6): exclusivas, compartidas, de coordinación y de apoyo"},{"n":"5","title":"Actos jurídicos de la Unión (TFUE, arts. 288-292, 296-297)"},{"n":"6","title":"Órganos consultivos: Comité Económico y Social y Comité de las Regiones (TFUE, arts. 300-307)"}]'::jsonb, '["Art. 1 TUE: «La Unión se fundamenta en el presente Tratado y en el Tratado de Funcionamiento de la Unión Europea (en lo sucesivo denominados «los Tratados»). Ambos Tratados tienen el mismo valor jurídico. La Unión sustituirá y sucederá a la Comunidad Europea.»","Art. 2 TUE: «La Unión se fundamenta en los valores de respeto de la dignidad humana, libertad, democracia, igualdad, Estado de Derecho y respeto de los derechos humanos, incluidos los derechos de las personas pertenecientes a minorías.»","Art. 4.2 TUE: «En particular, la seguridad nacional seguirá siendo responsabilidad exclusiva de cada Estado miembro.»","Art. 5.1 TUE: «La delimitación de las competencias de la Unión se rige por el principio de atribución. El ejercicio de las competencias de la Unión se rige por los principios de subsidiariedad y proporcionalidad.»","Art. 5.4 TUE: «En virtud del principio de proporcionalidad, el contenido y la forma de la acción de la Unión no excederán de lo necesario para alcanzar los objetivos de los Tratados.»","Art. 6.1 TUE: «La Unión reconoce los derechos, libertades y principios enunciados en la Carta de los Derechos Fundamentales de la Unión Europea de 7 de diciembre de 2000, tal como fue adaptada el 12 de diciembre de 2007 en Estrasburgo, la cual tendrá el mismo valor jurídico que los Tratados.»","Art. 7.1 TUE: «A propuesta motivada de un tercio de los Estados miembros, del Parlamento Europeo o de la Comisión, el Consejo, por mayoría de cuatro quintos de sus miembros y previa aprobación del Parlamento Europeo, podrá constatar la existencia de un riesgo claro de violación grave por parte de un Estado miembro de los valores contemplados en el artículo 2.»","Art. 9 TUE: «Será ciudadano de la Unión toda persona que tenga la nacionalidad de un Estado miembro. La ciudadanía de la Unión se añade a la ciudadanía nacional sin sustituirla.»","Art. 11.4 TUE: «Un grupo de al menos un millón de ciudadanos de la Unión, que sean nacionales de un número significativo de Estados miembros, podrá tomar la iniciativa de invitar a la Comisión Europea, en el marco de sus atribuciones, a que presente una propuesta adecuada»","Art. 50.3 TUE: «Los Tratados dejarán de aplicarse al Estado de que se trate a partir de la fecha de entrada en vigor del acuerdo de retirada o, en su defecto, a los dos años de la notificación a que se refiere el apartado 2, salvo si el Consejo Europeo, de acuerdo con dicho Estado, decide por unanimidad prorrogar dicho plazo.»","Art. 3.1 TFUE TFUE: «La Unión dispondrá de competencia exclusiva en los ámbitos siguientes: a) la unión aduanera; b) el establecimiento de las normas sobre competencia necesarias para el funcionamiento del mercado interior; c) la política monetaria de los Estados miembros cuya moneda es el euro; d) la conservación de los recursos biológicos marinos dentro de la política pesquera común; e) la política comercial común.»","Art. 2.2 TFUE TFUE: «Los Estados miembros ejercerán su competencia en la medida en que la Unión no haya ejercido la suya.»","Art. 288 TFUE TFUE: «El reglamento tendrá un alcance general. Será obligatorio en todos sus elementos y directamente aplicable en cada Estado miembro. La directiva obligará al Estado miembro destinatario en cuanto al resultado que deba conseguirse, dejando, sin embargo, a las autoridades nacionales la elección de la forma y de los medios.»","Art. 297.1 TFUE TFUE: «Los actos legislativos se publicarán en el Diario Oficial de la Unión Europea. Entrarán en vigor en la fecha que ellos mismos fijen o, a falta de ella, a los veinte días de su publicación.»","Art. 300.1 TFUE TFUE: «El Parlamento Europeo, el Consejo y la Comisión estarán asistidos por un Comité Económico y Social y por un Comité de las Regiones, que ejercerán funciones consultivas.»","Art. 305 TFUE TFUE: «Los miembros del Comité, así como un número igual de suplentes, serán nombrados para un período de cinco años. Su mandato será renovable.»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016M/TXT'), 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016M/TXT', null, null, null, 'Otras normas citadas: TFUE (https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:12016E/TXT)'
  from public.topics t where t.slug = 'gc-05b-tratados-ue'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Estatuto del Consejo de Europa (Londres, 5 de mayo de 1949), Instrumento de Adhesión de España (BOE núm. 51, de 1 de marzo de 1978)', 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1978-5972', 'web_oficial'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-06a-instituciones-internacionales', 'Tema 6. Instituciones internacionales (I): ONU, Consejo de Europa, Unión Europea y OTAN') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-06a-instituciones-internacionales' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'es', '[{"n":"1","title":"Organización de las Naciones Unidas (ONU)"},{"n":"1.1","title":"Órganos principales: Asamblea General, Consejo de Seguridad, Consejo Económico y Social, Consejo de Administración Fiduciaria, Corte Internacional de Justicia y Secretaría"},{"n":"2","title":"Consejo de Europa (Estatuto de Londres de 1949)"},{"n":"2.1","title":"Finalidad y composición (arts. 1-9)"},{"n":"2.2","title":"Órganos, sede e idiomas (arts. 10-14)"},{"n":"2.3","title":"Asamblea Consultiva y Secretaría (arts. 22-36)"},{"n":"3","title":"Unión Europea: marco institucional (TUE, arts. 13-16)"},{"n":"4","title":"Organización del Tratado del Atlántico Norte (OTAN)"},{"n":"4.1","title":"Tratado de Washington de 1949: defensa colectiva y Consejo (arts. 1-9)"},{"n":"4.2","title":"Adhesión, vigencia y denuncia (arts. 10-14); adhesión de España (1982)"}]'::jsonb, '["ONU, órganos principales ONU, «Órganos principales» (un.org): «Los principales órganos de las Naciones Unidas son la Asamblea General, el Consejo de Seguridad, el Consejo Económico y Social, el Consejo de Administración Fiduciaria, la Corte Internacional de Justicia y la Secretaría de la ONU. Todos se establecieron en virtud de la Carta de las Naciones Unidas cuando se fundó la Organización en 1945.»","ONU, Consejo de Seguridad ONU, «Órganos principales» (un.org): «Cuenta con 15 Miembros (5 permanentes y 10 no permanentes). Cada uno tiene un voto, aunque los cinco permanentes cuentan con el poder del veto.»","ONU, Consejo Económico y Social ONU, «Órganos principales» (un.org): «La Asamblea General elige a los 54 Miembros del Consejo para períodos superpuestos de tres años.»","ONU, Corte Internacional de Justicia ONU, «Órganos principales» (un.org): «La Corte Internacional de Justicia es el órgano judicial principal de las Naciones Unidas. Su sede está en el Palacio de la Paz en la Haya (Países Bajos). Es el único de los seis órganos principales de la Organización que no se encuentra en Nueva York.»","Art. 1.a) Estatuto del Consejo de Europa Estatuto del Consejo de Europa: «a) La finalidad del Consejo de Europa consiste en realizar una unión más estrecha entre sus miembros para salvaguardar y promover los ideales y los principios que constituyen su patrimonio común y favorecer su progreso económico y social.»","Art. 1.d) Estatuto del Consejo de Europa Estatuto del Consejo de Europa: «d) Los asuntos relativos a la defensa nacional no son de la competencia del Consejo de Europa.»","Art. 10 Estatuto del Consejo de Europa Estatuto del Consejo de Europa: «Los órganos del Consejo de Europa son: (i) El Comité de Ministros. (ii) La Asamblea Consultiva. Estos dos órganos serán asistidos por la Secretaría del Consejo de Europa.»","Arts. 11 y 12 Estatuto del Consejo de Europa Estatuto del Consejo de Europa: «La sede del Consejo de Europa es Estrasburgo. […] Los idiomas oficiales del Consejo de Europa son el francés y el inglés.»","Art. 14 Estatuto del Consejo de Europa Estatuto del Consejo de Europa: «Cada Miembro tendrá un representante en el Comité de Ministros y cada representante tiene un voto. Los representantes en el Comité son los Ministros de Asuntos Exteriores.»","Art. 13.1 TUE TUE: «Las instituciones de la Unión son: El Parlamento Europeo, El Consejo Europeo, El Consejo, La Comisión Europea (denominada en lo sucesivo «Comisión»), El Tribunal de Justicia de la Unión Europea, El Banco Central Europeo, El Tribunal de Cuentas.»","Art. 14.2 TUE TUE: «Su número no excederá de setecientos cincuenta, más el Presidente. La representación de los ciudadanos será decrecientemente proporcional, con un mínimo de seis diputados por Estado miembro. No se asignará a ningún Estado miembro más de noventa y seis escaños.»","Art. 15.5 TUE TUE: «El Consejo Europeo elegirá a su Presidente por mayoría cualificada para un mandato de dos años y medio, que podrá renovarse una sola vez.»","Art. 5 Tratado del Atlántico Norte Tratado del Atlántico Norte: «Las Partes convienen en que un ataque armado contra una o contra varias de ellas, acaecido en Europa o en América del Norte, se considerará como un ataque dirigido contra todas ellas»","Art. 10 Tratado del Atlántico Norte Tratado del Atlántico Norte: «Las Partes pueden, por acuerdo unánime, invitar a adherirse al Tratado a cualquier otro Estado europeo que esté en condiciones de favorecer el desarrollo de los principios del presente Tratado y de contribuir a la seguridad de la región del Atlántico Norte.»","Adhesión de España a la OTAN Tratado del Atlántico Norte: «El presente Tratado entró en vigor para España el día 30 de mayo de 1982, fecha del depósito del Instrumento de Adhesión, de conformidad con lo dispuesto en el artículo 10.»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1978-5972'), 'https://www.boe.es/diario_boe/txt.php?id=BOE-A-1978-5972', null, null, null, 'Otras normas citadas: ONU, «Órganos principales» (un.org) (https://www.un.org/es/about-us/main-bodies), TUE (https://eur-lex.europa.eu/legal-content/ES/TXT/?uri=CELEX:12016M/TXT), Tratado del Atlántico Norte (https://www.boe.es/diario_boe/txt.php?id=BOE-A-1982-12535)'
  from public.topics t where t.slug = 'gc-06a-instituciones-internacionales'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('INTERPOL · ¿Qué es INTERPOL? y Comité Ejecutivo', 'https://www.interpol.int/es/Quienes-somos/Que-es-INTERPOL', 'web_oficial'::public.source_kind, 'Organización Internacional de Policía Criminal (INTERPOL, web oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-06b-agencias-internacionales', 'Tema 6. Instituciones internacionales (II): INTERPOL, EUROPOL, EUROJUST, FRONTEX, CEPOL, FAO, FMI y OMS') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-06b-agencias-internacionales' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'es', '[{"n":"1","title":"INTERPOL (Organización Internacional de Policía Criminal)"},{"n":"1.1","title":"Asamblea General, Comité Ejecutivo, Secretaría General y Oficinas Centrales Nacionales"},{"n":"2","title":"Agencias de la Unión Europea en materia de seguridad y justicia"},{"n":"2.1","title":"EUROPOL: cooperación policial (La Haya)"},{"n":"2.2","title":"EUROJUST: cooperación judicial penal (La Haya)"},{"n":"2.3","title":"FRONTEX: Guardia Europea de Fronteras y Costas (Varsovia)"},{"n":"2.4","title":"CEPOL: formación policial (Budapest)"},{"n":"3","title":"Organismos especializados de las Naciones Unidas"},{"n":"3.1","title":"FAO: alimentación y agricultura (Roma)"},{"n":"3.2","title":"FMI: Fondo Monetario Internacional"},{"n":"3.3","title":"OMS: Organización Mundial de la Salud"}]'::jsonb, '["INTERPOL, ¿Qué es INTERPOL? Web de INTERPOL: «La Secretaría General coordina nuestras actividades diarias de lucha contra distintos delitos. Dirigida por el Secretario General, trabajan en ella tanto policías como civiles. Está formada por las oficinas centrales en Lyon, un complejo mundial para la innovación en Singapur y varias oficinas satélites en distintas regiones.»","INTERPOL, Oficinas Centrales Nacionales Web de INTERPOL: «En cada país, una Oficina Central Nacional (OCN) de INTERPOL actúa como punto de contacto para la Secretaría General y otras OCN.»","INTERPOL, Asamblea General Web de INTERPOL: «La Asamblea General es nuestro órgano de gobierno y reúne a todos los países una vez al año para tomar decisiones.»","INTERPOL, Comité Ejecutivo Web de INTERPOL: «Elegido por la Asamblea General, el Comité Ejecutivo está formado por 13 miembros incluyendo el Presidente de la Organización, tres vicepresidentes y nueve vocales.»","Europol Portal de la UE (Europol): «El cometido de la Oficina Europea de Policía (Europol), agencia encargada de velar por el cumplimiento de la ley en la UE, es contribuir a que Europa sea más segura ayudando a las autoridades responsables de la aplicación de la ley en los países miembros de la UE.»","Eurojust Portal de la UE (Eurojust): «La Agencia de la Unión Europea para la Cooperación Judicial Penal (Eurojust) facilita la coordinación judicial y la cooperación entre las autoridades nacionales prestando apoyo práctico a los fiscales en la lucha contra la delincuencia transfronteriza grave y el terrorismo.»","Eurojust, Colegio Portal de la UE (Eurojust): «Miembros: Colegio de Eurojust, con un miembro nacional de cada país»","Frontex Portal de la UE (Frontex): «Función: Frontex, la Agencia Europea de la Guardia de Fronteras y Costas, apoya a los países de la UE y de Schengen en la gestión de las fronteras exteriores de la UE y en la lucha contra la delincuencia transfronteriza.»","Frontex, cuerpo permanente Portal de la UE (Frontex): «Con el cuerpo permanente, el primer servicio uniformado de fuerzas de seguridad de la Unión Europea, Frontex se ha convertido en un brazo operativo de la UE.»","CEPOL Portal de la UE (CEPOL): «La CEPOL, Agencia de la Unión Europea para la Formación Policial, desarrolla, ejecuta y organiza cursos de formación para la policía y otros funcionarios de las fuerzas y cuerpos de seguridad del Estado.»","FAO Web de la FAO: «La FAO es la agencia de las Naciones Unidas que lidera el esfuerzo internacional para poner fin al hambre.»","FAO, Día Mundial de la Alimentación Web de la FAO: «Durante la 20.a reunión de la Conferencia de la FAO se decidió en forma unánime celebrar anualmente el Día Mundial de la Alimentación el 16 de octubre en honor a la fecha de fundación de la FAO.»","FMI, misiones Web del FMI: «El FMI tiene tres misiones críticas: promover la cooperación monetaria internacional, alentar la expansión del comercio internacional y del crecimiento económico, y desalentar políticas que vayan en perjuicio de la prosperidad.»","FMI, fundación Web del FMI: «La idea de crear el FMI se planteó en julio de 1944 en una conferencia de las Naciones Unidas celebrada en Bretton Woods, cuando los representantes de 44 países acordaron establecer un marco de cooperación económica internacional»","OMS Web de la OMS: «Fundada en 1948, la OMS es el organismo de las Naciones Unidas que pone en contacto a naciones, asociados y personas a fin de promover la salud, preservar la seguridad mundial y servir a las poblaciones vulnerables»","OMS, Asamblea Mundial de la Salud Web de la OMS: «La Asamblea Mundial de la Salud es el órgano decisorio de la OMS y a ella asisten delegaciones de todos los Estados Miembros.»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://www.interpol.int/es/Quienes-somos/Que-es-INTERPOL'), 'https://www.interpol.int/es/Quienes-somos/Que-es-INTERPOL', null, null, null, 'Otras normas citadas: Portal de la UE (Europol) (https://european-union.europa.eu/institutions-law-budget/institutions-and-bodies/search-all-eu-institutions-and-bodies/europol_es), Portal de la UE (Eurojust) (https://european-union.europa.eu/institutions-law-budget/institutions-and-bodies/search-all-eu-institutions-and-bodies/eurojust_es), Portal de la UE (Frontex) (https://european-union.europa.eu/institutions-law-budget/institutions-and-bodies/search-all-eu-institutions-and-bodies/frontex_es), Portal de la UE (CEPOL) (https://european-union.europa.eu/institutions-law-budget/institutions-and-bodies/search-all-eu-institutions-and-bodies/european-union-agency-law-enforcement-training-cepol_es), Web de la FAO (https://www.fao.org/about/about-fao/es/), Web del FMI (https://www.imf.org/es/about/factsheets/imf-at-a-glance), Web de la OMS (https://www.who.int/es/about)'
  from public.topics t where t.slug = 'gc-06b-agencias-internacionales'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto 205/2024, de 27 de febrero, estructura orgánica básica del Ministerio de Defensa (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-14b-ministerio-defensa', 'Tema 14. Estructura orgánica básica del Ministerio de Defensa (RD 205/2024)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-14b-ministerio-defensa' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'es', '[{"n":"1","title":"Organización general del Ministerio de Defensa (art. 1)"},{"n":"1.1","title":"CNI, Guardia Civil y órganos asesores y consultivos"},{"n":"2","title":"Fuerzas Armadas: JEMAD, Jefes de Estado Mayor y UME (art. 2)"},{"n":"3","title":"Secretaría de Estado de Defensa y sus direcciones generales; CESTIC (arts. 3-7)"},{"n":"4","title":"Subsecretaría de Defensa (art. 8)"},{"n":"4.1","title":"Secretaría General Técnica, Personal y Reclutamiento y Enseñanza Militar (arts. 9-11)"},{"n":"4.2","title":"Asesoría Jurídica, Intervención e Inspección General de Sanidad (arts. 12-14)"},{"n":"5","title":"Secretaría General de Política de Defensa y Dirección General de Política de Defensa (arts. 15-16)"},{"n":"6","title":"Consejos y Juntas Superiores (arts. 17-18)"},{"n":"7","title":"Disposiciones adicionales: precedencias, CNI, Establecimiento Penitenciario Militar"}]'::jsonb, '["Art. 1.1 RD 205/2024: «El Ministerio de Defensa es el Departamento de la Administración General del Estado al que le corresponde la preparación, el desarrollo y la ejecución de la política de defensa determinada por el Gobierno y la gestión de la administración militar.»","Art. 1.3 RD 205/2024: «a) Las Fuerzas Armadas. b) La Secretaría de Estado de Defensa. c) La Subsecretaría de Defensa. d) La Secretaría General de Política de Defensa.»","Art. 1.4 RD 205/2024: «Está adscrito al Ministerio de Defensa, con dependencia directa de la persona titular del Departamento, el Centro Nacional de Inteligencia.»","Art. 1.5 RD 205/2024: «La Guardia Civil depende de la persona titular del Ministerio de Defensa en los términos previstos en la Ley Orgánica 2/1986, de 13 de marzo, de Fuerzas y Cuerpos de Seguridad; en la Ley Orgánica 5/2005, de 17 de noviembre, de la Defensa Nacional; en la Ley Orgánica 12/2007, de 22 de octubre, del régimen disciplinario de la Guardia Civil, y en la Ley 29/2014, de 28 de noviembre, de Régimen del Personal de la Guardia Civil.»","Art. 2.2 RD 205/2024: «El Jefe de Estado Mayor de la Defensa (JEMAD), con rango de secretario de estado»","Art. 2.5 RD 205/2024: «Los Jefes de Estado Mayor del Ejército de Tierra, de la Armada y del Ejército del Aire y del Espacio tienen rango de subsecretario.»","Art. 2.6 RD 205/2024: «La Unidad Militar de Emergencias (UME), que depende orgánicamente de la persona titular del Ministerio de Defensa, está constituida de forma permanente»","Art. 3.3 RD 205/2024: «a) La Dirección General de Estrategia e Innovación de la Industria de Defensa. b) La Dirección General de Armamento y Material. c) La Dirección General de Asuntos Económicos. d) La Dirección General de Infraestructura. e) El Centro de Sistemas y Tecnologías de la Información y las Comunicaciones.»","Art. 8.3 RD 205/2024: «La persona titular de la Subsecretaría de Defensa ostentará la representación ordinaria del Departamento»","Art. 8.5 RD 205/2024: «a) La Secretaría General Técnica. b) La Dirección General de Personal. c) La Dirección General de Reclutamiento y Enseñanza Militar.»","Art. 8.7 RD 205/2024: «a) La Asesoría Jurídica General de la Defensa. b) La Intervención General de la Defensa. c) La Inspección General de Sanidad de la Defensa.»","Art. 13.1 RD 205/2024: «La Intervención General de la Defensa, dependiente funcionalmente de la Intervención General de la Administración del Estado»","Art. 15.4 RD 205/2024: «a) Presidir la Comisión Interministerial de Defensa. b) Actuar de Secretario del Consejo de Defensa Nacional. c) Presidir la Comisión de Coordinación de la Actividad Internacional del Ministerio de Defensa.»","Art. 15.6 RD 205/2024: «De la Secretaría General de Política de Defensa depende la Dirección General de Política de Defensa.»","Disp. adic. 1.ª RD 205/2024: «a) Persona titular del Ministerio de Defensa. b) Jefe de Estado Mayor de la Defensa. c) Persona titular de la Secretaría de Estado de Defensa. d) Persona titular de la Subsecretaría de Defensa.»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791'), 'https://www.boe.es/buscar/act.php?id=BOE-A-2024-3791', null, null, null, null
  from public.topics t where t.slug = 'gc-14b-ministerio-defensa'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Orden PRE/422/2013, de 15 de marzo, estructura orgánica de los Servicios Centrales de la Dirección General de la Guardia Civil (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-15c-servicios-centrales-dggc', 'Tema 15. Estructura de los Servicios Centrales de la Dirección General de la Guardia Civil') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-15c-servicios-centrales-dggc' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'es', '[{"n":"1","title":"Dirección General de la Guardia Civil: organización central y periférica (Orden PRE/422/2013, cap. I)"},{"n":"1.1","title":"Órganos colegiados y órganos de apoyo al Director: Gabinete Técnico, Asesoría Jurídica, Secretaría de Despacho"},{"n":"1.2","title":"Centro Universitario de la Guardia Civil"},{"n":"1.3","title":"Estructura vigente de primer nivel según el RD 207/2024 (Dirección Adjunta Operativa, Mando de Personal, Mando de Apoyo)"},{"n":"2","title":"Dirección Adjunta Operativa y Mando de Operaciones (cap. II)"},{"n":"2.1","title":"Estado Mayor y Jefatura de Unidades Especiales y de Reserva"},{"n":"2.2","title":"Jefaturas de Información, Policía Judicial, Fiscal y de Fronteras, Tráfico y SEPRONA; Zonas"},{"n":"2.3","title":"Asuntos Internos y Unidad Especial de Intervención"},{"n":"3","title":"Área de personal (cap. III): Jefaturas de Personal, Enseñanza y Asistencia al Personal; Observatorio de Conducta Ética"},{"n":"4","title":"Área de apoyo (cap. IV): Jefaturas de los Servicios de Apoyo, de Servicios Técnicos y de Asuntos Económicos"}]'::jsonb, '["Art. 1.2 Orden PRE/422/2013: «La organización periférica de la Dirección General de la Guardia Civil estará constituida por las Zonas, las Comandancias, las Compañías y los Puestos.»","Art. 2 Orden PRE/422/2013: «Adscritos a la Dirección General de la Guardia Civil estarán el Consejo Superior de la Guardia Civil y el Consejo de la Guardia Civil»","Art. 4.3 RD 207/2024: «De la persona titular de la Dirección General dependen directamente los siguientes órganos: a) La Dirección Adjunta Operativa. b) El Mando de Personal. c) El Mando de Apoyo.»","Art. 3.2 Orden PRE/422/2013: «Gabinete Técnico. Con nivel orgánico de Subdirección General, y a cargo de un Oficial General de la Guardia Civil, es el órgano de asistencia y apoyo del Director General»","Art. 4 Orden PRE/422/2013: «Dependiente de la Dirección General de la Guardia Civil se encuentra el Centro Universitario de la Guardia Civil, con naturaleza de centro universitario público, cuya titularidad corresponde al Ministro del Interior.»","Art. 5.1.e) Orden PRE/422/2013: «e) Sustituir al Director General de la Guardia Civil, con carácter interino o accidental, así como en el ejercicio de la potestad sancionadora que le atribuye la legislación vigente sobre régimen disciplinario del Cuerpo de la Guardia Civil.»","Art. 7.2 Orden PRE/422/2013: «Del Jefe del Estado Mayor depende orgánicamente la Sala de Operaciones y Servicios, que tiene como misión la recepción y transmisión de las novedades y órdenes relativas al servicio diario. Cuando las necesidades del mismo así lo aconsejen, se activará como Centro de Crisis»","Art. 8.2.b) Orden PRE/422/2013: «b) Unidad de Acción Rural. Unidad de la Guardia Civil, especialmente concebida, preparada y organizada para la lucha contra elementos terroristas y la ejecución de operaciones que entrañen gran riesgo y requieran una respuesta rápida»","Art. 9 Orden PRE/422/2013: «A la Jefatura de Información, al mando de un Oficial General de la Guardia Civil en situación de servicio activo, le corresponde organizar, dirigir y gestionar la obtención, recepción, tratamiento, análisis y difusión de la información de interés para el orden público y la seguridad ciudadana»","Art. 10.2.a) Orden PRE/422/2013: «a) Unidad Central Operativa. Tiene como misión investigar y perseguir los asuntos relacionados con la delincuencia grave, nacional e internacional»","Art. 14.1 Orden PRE/422/2013: «son las Unidades de mando, coordinación e inspección de todos los Servicios de la Dirección General de la Guardia Civil existentes en el ámbito territorial de cada una de ellas.»","Art. 17.1 Orden PRE/422/2013: «El Servicio de Asuntos Internos tiene como misión investigar las conductas contrarias a la ética profesional del personal destinado en la Dirección General de la Guardia Civil»","Art. 22.2.d) Orden PRE/422/2013: «d) Servicio de Prevención. Tiene como cometidos el control interno superior, dentro de la estructura orgánica de la Dirección General de la Guardia Civil, en materia de prevención de riesgos para la seguridad y salud del personal en el trabajo.»","Art. 23 bis Orden PRE/422/2013: «El Observatorio de Conducta Ética de la Guardia Civil, con el nivel orgánico que se determine en la relación de puestos de trabajo, es el órgano responsable de centralizar las labores de seguimiento, impulso y evaluación de la aplicación del Código de Conducta en la Guardia Civil.»","Art. 24.3 Orden PRE/422/2013: «a) Jefatura de los Servicios de Apoyo. b) Jefatura de Servicios Técnicos. c) Jefatura de Asuntos Económicos.»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906'), 'https://www.boe.es/buscar/act.php?id=BOE-A-2013-2906', null, null, null, 'Otras normas citadas: RD 207/2024 (https://www.boe.es/buscar/act.php?id=BOE-A-2024-3793)'
  from public.topics t where t.slug = 'gc-15c-servicios-centrales-dggc'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Guardia Civil · Historia de la Guardia Civil (web oficial)', 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/', 'web_oficial'::public.source_kind, 'Guardia Civil (web oficial)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-15d-historia-guardia-civil', 'Tema 15. Historia de la Guardia Civil') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-15d-historia-guardia-civil' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'es', '[{"n":"1","title":"Antecedentes: los inicios del siglo XIX (bandolerismo, Milicia Nacional, Legión de Salvaguardias Nacionales)"},{"n":"2","title":"La Fundación (1844-1845): reales decretos, reglamentos y Cartilla"},{"n":"3","title":"La consolidación: guerras carlistas, primera misión internacional y Guardias Jóvenes"},{"n":"4","title":"Sexenio Revolucionario y Restauración Monárquica (1868-1902)"},{"n":"5","title":"El reinado de Alfonso XIII (1902-1931)"},{"n":"6","title":"La Segunda República (1931-1936)"},{"n":"7","title":"El Franquismo: supresión de Carabineros, Tráfico y especialidades"},{"n":"8","title":"La Transición y la Democracia: LO 2/1986, SEPRONA, EUROGENDFOR y normas actuales"}]'::jsonb, '["Los inicios del Siglo XIX Web de la Guardia Civil (Historia): «Desde este puesto concibe un proyecto de Instituto armado para el mantenimiento del orden público: la Legión de Salvaguardias Nacionales que, inspirada en la Gendarmería Nacional francesa, debería combatir la delincuencia y garantizar la libre circulación de bienes y personas.»","La Fundación (28/03/1844) Web de la Guardia Civil (Historia): «Así, el 28 de marzo de 1844, se produce el momento histórico de la creación oficial de la Guardia Civil cuando, por Real Decreto, se crea un “cuerpo especial de fuerza armada de Infantería y Caballería”, bajo la dependencia del Ministerio de la Gobernación y con “la denominación de Guardias Civiles”. A los efectos de organizar esta nueva fuerza se comisiona al mariscal de campo D. Francisco Javier Girón y Ezpeleta, II Duque de Ahumada.»","La Fundación (13/05/1844) Web de la Guardia Civil (Historia): «para dar lugar al definitivo Real Decreto de 13 de mayo, presentado por el Presidente de Gobierno y Ministro de la Guerra, D. Ramón María Narváez, auténtico decreto fundacional de la Guardia Civil.»","La Fundación (organización) Web de la Guardia Civil (Historia): «Inicialmente se compondrá de 14 jefes, 232 oficiales y 5769 guardias repartidos en 14 Tercios»","La Fundación (reglamentos) Web de la Guardia Civil (Historia): «El 9 de octubre de 1844 se aprobaba el Reglamento para el Servicio de la Guardia Civil, estableciendo las obligaciones y facultades de la Guardia Civil, su dependencia orgánica, vinculada en lo referido a su servicio peculiar al Ministerio de la Gobernación, y el objeto primordial de la Institución: “la conservación del orden público, la protección de las personas y las propiedades (...) y el auxilio que reclame la ejecución de las leyes”.»","La Fundación (Cartilla) Web de la Guardia Civil (Historia): «Surge así el 20 de diciembre de 1845, de la propia mano del Duque de Ahumada, un documento que constituye el auténtico código moral de la Institución: la “Cartilla del Guardia Civil”»","La Fundación (honor) Web de la Guardia Civil (Historia): «“el honor es la principal divisa del guardia civil; debe, por consiguiente, conservarlo sin mancha. Una vez perdido, no se recobra jamás”.»","La consolidación (Oporto, 1847) Web de la Guardia Civil (Historia): «Una unidad de Caballería de la Guardia Civil se encarga de patrullar y garantizar la seguridad ciudadana en la ciudad de Oporto.»","La consolidación (Guardias Jóvenes) Web de la Guardia Civil (Historia): «El 1º de abril de 1853, por Real Orden, se creará la “Compañía de Guardias Jóvenes” para dar amparo y educación a los huérfanos e hijos del Cuerpo y ayudar a la formación de nuevos guardias.»","El Reinado de Alfonso XIII (patrona) Web de la Guardia Civil (Historia): «la declaración de la Virgen del Pilar como patrona de la Guardia Civil en 1913»","El Reinado de Alfonso XIII (Beneficencia) Web de la Guardia Civil (Historia): «En 1929 mediante Real Decreto de 4 de octubre, se concede a la Guardia Civil la Gran Cruz de la Orden Civil de Beneficencia»","La Segunda República (Sanjurjada) Web de la Guardia Civil (Historia): «La conocida como Sanjurjada tiene como consecuencia que la Dirección General de la Guardia Civil dependiente del Ministerio de la Guerra se transforme en Inspección General para pasar a depender del Ministerio de Gobernación.»","El Franquismo (Carabineros) Web de la Guardia Civil (Historia): «el 15 de marzo de 1940 se promulga una Ley fundamentada en dos pilares básicos: la supresión del Cuerpo de Carabineros, al que se pone fin tras 111 años de servicio ininterrumpido, y asunción de sus funciones por la Guardia Civil»","El Franquismo (Tráfico) Web de la Guardia Civil (Historia): «Se crea la Agrupación de Tráfico de la Guardia Civil que constituye un punto de inflexión en el proceso de la modernización del Cuerpo.»","La Transición y La Democracia (LO 2/1986) Web de la Guardia Civil (Historia): «Con la Ley Orgánica 2/1986, de Fuerzas y Cuerpos de Seguridad de 13 de marzo, se define a la Guardia Civil como instituto armado de naturaleza militar»","La Transición y La Democracia (SEPRONA) Web de la Guardia Civil (Historia): «se crea en 1988 el Servicio de Protección de la Naturaleza (SEPRONA)»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/'), 'https://web.guardiacivil.es/es/institucional/conocenos/historiaguacivil/', null, null, null, null
  from public.topics t where t.slug = 'gc-15d-historia-guardia-civil'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Directiva 2012/27/UE, relativa a la eficiencia energética (texto consolidado a 4.5.2023, capítulos I y II), derogada con efectos desde el 12.10.2025 por la Directiva (UE) 2023/1791 (versión refundida)', 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504', 'web_oficial'::public.source_kind, 'Unión Europea · EUR-Lex (DOUE L 315 de 14.11.2012 y modificaciones)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-16b-eficiencia-energetica', 'Tema 16. Eficiencia energética: Directiva 2012/27/UE (capítulos I y II)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-16b-eficiencia-energetica' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'es', '[{"n":"1","title":"Directiva 2012/27/UE, relativa a la eficiencia energética: vigencia (derogada desde el 12.10.2025 por la Directiva (UE) 2023/1791, versión refundida)"},{"n":"2","title":"Capítulo I: objeto, ámbito de aplicación, definiciones y objetivos (arts. 1-3)"},{"n":"2.1","title":"Objeto y objetivos principales para 2020 y 2030 (art. 1)"},{"n":"2.2","title":"Definiciones (art. 2)"},{"n":"2.3","title":"Objetivos y contribuciones nacionales (art. 3)"},{"n":"3","title":"Capítulo II: eficiencia del uso de energía (arts. 5-13)"},{"n":"3.1","title":"Función ejemplarizante de los edificios de los organismos públicos (art. 5)"},{"n":"3.2","title":"Adquisición por los organismos públicos (art. 6)"},{"n":"3.3","title":"Obligación de ahorro de energía y sistemas de obligaciones (arts. 7 y 7 bis)"},{"n":"3.4","title":"Auditorías energéticas y sistemas de gestión energética (art. 8)"},{"n":"3.5","title":"Medición, facturación e información a los consumidores; sanciones (arts. 9-13)"}]'::jsonb, '["Art. 1.1 Directiva 2012/27/UE: «La presente Directiva establece un marco común de medidas para el fomento de la eficiencia energética dentro de la Unión a fin de garantizar la consecución de los objetivos principales en materia de eficiencia energética de la Unión, que consisten en un aumento de la eficiencia energética del 20 % para 2020 y de al menos el 32,5 % para 2030»","Art. 1.1 Directiva 2012/27/UE: «La presente Directiva contribuye a la aplicación del principio «primero, la eficiencia energética».»","Art. 1.2 Directiva 2012/27/UE: «Los requisitos que establece la presente Directiva son requisitos mínimos y se entienden sin perjuicio de que cualquier Estado miembro mantenga o introduzca medidas más estrictas.»","Art. 2.4 Directiva 2012/27/UE: ««eficiencia energética»: la relación entre la producción de un rendimiento, servicio, bien o energía, y el gasto de energía;»","Art. 2.25 Directiva 2012/27/UE: ««auditoría energética»: todo procedimiento sistemático destinado a obtener conocimientos adecuados del perfil de consumo de energía existente de un edificio o grupo de edificios, de una instalación u operación industrial o comercial, o de un servicio privado o público, así como para determinar y cuantificar las posibilidades de ahorro de energía a un coste eficiente e informar al respecto;»","Art. 2.30 Directiva 2012/27/UE: ««cogeneración»: la generación simultánea de energía térmica y de energía eléctrica o mecánica en un solo proceso;»","Art. 3.5 Directiva 2012/27/UE: «En la fijación de esas contribuciones, los Estados miembros tendrán en cuenta que el consumo de energía de la Unión en 2030 no deberá exceder de 1 128 Mtep de energía primaria y/o de 846 Mtep de energía final.»","Art. 5.1 Directiva 2012/27/UE: «cada uno de los Estados miembros se asegurará de que, a partir del 1 de enero de 2014, el 3 % de la superficie total de los edificios con calefacción y/o sistema de refrigeración que tenga en propiedad y ocupe su Administración central se renueve cada año»","Art. 5.1 Directiva 2012/27/UE: «Dicho límite bajará a 250 m2 a partir del 9 de julio de 2015.»","Art. 6.1 Directiva 2012/27/UE: «Los Estados miembros garantizarán que las Administraciones centrales adquieran solamente productos, servicios y edificios que tengan un alto rendimiento energético»","Art. 7.1.b) Directiva 2012/27/UE: «b) la consecución de un nuevo ahorro cada año, desde el 1 de enero de 2021 hasta el 31 de diciembre de 2030, del 0,8 % del consumo anual de energía final, como promedio de los últimos tres años previos al 1 de enero de 2019.»","Art. 8.4 Directiva 2012/27/UE: «Los Estados miembros velarán por que se someta a las empresas que no sean PYME a una auditoría energética realizada de manera independiente y con una buena rentabilidad por expertos cualificados y/o acreditados o ejecutada y supervisada por autoridades independientes con arreglo al Derecho nacional a más tardar el 5 de diciembre de 2015, y como mínimo cada cuatro años a partir de la fecha de la auditoría energética anterior.»","Art. 11 bis.1 Directiva 2012/27/UE: «Los Estados miembros velarán por que los usuarios finales reciban de forma gratuita la totalidad de sus facturas y la información sobre la facturación del consumo de energía y de que tengan un acceso adecuado y gratuito a los datos sobre su consumo.»","Art. 13 Directiva 2012/27/UE: «Las sanciones previstas deberán ser eficaces, proporcionadas y disuasorias.»","Art. 38 Directiva (UE) 2023/1791 Directiva 2012/27/UE: «Queda derogada con efectos a partir del 12 de octubre de 2025 la Directiva 2012/27/UE, en su versión modificada por los actos citados en el anexo XVI, parte A»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504'), 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02012L0027-20230504', null, null, null, null
  from public.topics t where t.slug = 'gc-16b-eficiencia-energetica'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto 421/2004, de 12 de marzo, por el que se regula el Centro Criptológico Nacional (BOE-A-2004-5051)', 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-5051', 'web_oficial'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-17b-ciberseguridad-ccn-cert', 'Tema 17. Ciberseguridad: CCN-CERT') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-17b-ciberseguridad-ccn-cert' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'es', '[{"n":"1","title":"Centro Criptológico Nacional (RD 421/2004)"},{"n":"1.1","title":"Director del CCN: autoridades de certificación (art. 1)"},{"n":"1.2","title":"Ámbito de actuación y funciones (art. 2.1 y 2.2)"},{"n":"1.3","title":"Adscripción al CNI y personal (art. 2.3)"},{"n":"2","title":"CCN-CERT: Capacidad de Respuesta a Incidentes del CCN"},{"n":"2.1","title":"Creación, misión y normativa aplicable"},{"n":"2.2","title":"Comunidad, servicios y notificación de incidentes"},{"n":"2.3","title":"Cooperación nacional e internacional (CNPIC, FIRST, NCIRC, EGC)"}]'::jsonb, '["Preámbulo RD 421/2004 RD 421/2004: «En consecuencia, la seguridad de los sistemas de información debe garantizar la confidencialidad, la disponibilidad y la integridad de la información que manejan y la disponibilidad y la integridad de los propios sistemas.»","Art. 1 RD 421/2004 RD 421/2004: «El Secretario de Estado Director del Centro Nacional de Inteligencia, como Director del Centro Criptológico Nacional (CCN), es la autoridad responsable de coordinar la acción de los diferentes organismos de la Administración que utilicen medios o procedimientos de cifra, garantizar la seguridad de las tecnologías de la información en ese ámbito, informar sobre la adquisición coordinada del material criptológico y formar al personal de la Administración especialista en este campo.»","Art. 1 RD 421/2004 RD 421/2004: «En este sentido, el Director del CCN es la autoridad de certificación de la seguridad de las tecnologías de la información y autoridad de certificación criptológica.»","Art. 2.1 RD 421/2004 RD 421/2004: «b) La seguridad de los sistemas de las tecnologías de la información que procesan, almacenan o transmiten información clasificada.»","Art. 2.2.a) RD 421/2004 RD 421/2004: «a) Elaborar y difundir normas, instrucciones, guías y recomendaciones para garantizar la seguridad de los sistemas de las tecnologías de la información y las comunicaciones de la Administración.»","Art. 2.2.c) RD 421/2004 RD 421/2004: «c) Constituir el organismo de certificación del Esquema nacional de evaluación y certificación de la seguridad de las tecnologías de información, de aplicación a productos y sistemas en su ámbito.»","Art. 2.2.d) RD 421/2004 RD 421/2004: «d) Valorar y acreditar la capacidad de los productos de cifra y de los sistemas de las tecnologías de la información, que incluyan medios de cifra, para procesar, almacenar o transmitir información de forma segura.»","Art. 2.3 RD 421/2004 RD 421/2004: «El Centro Criptológico Nacional queda adscrito al Centro Nacional de Inteligencia y comparte con éste medios, procedimientos, normativa y recursos, y se regirá por la Ley 11/2002, de 6 de mayo, reguladora del Centro Nacional de Inteligencia.»","CCN-CERT, Misión y Objetivos Web del CCN-CERT: «El CCN-CERT es la Capacidad de Respuesta a Incidentes de Seguridad de la Información del Centro Criptológico Nacional, CCN. Este servicio se creó en el año 2006 como CERT Gubernamental Nacional español y sus funciones quedan recogidas en la Ley 11/2002 reguladora del Centro Nacional de Inteligencia, el RD 421/2004 de regulación del CCN y en el RD 311/2022, de 3 de mayo, que regula el Esquema Nacional de Seguridad.»","CCN-CERT, misión Web del CCN-CERT: «Su misión, por tanto, es contribuir a la mejora de la ciberseguridad española, siendo el centro de alerta y respuesta nacional que coopere y ayude a responder de forma rápida y eficiente a los ciberataques y a afrontar de forma activa las ciberamenazas»","CCN-CERT, gestión de ciberincidentes Web del CCN-CERT: «En el caso de operadores críticos del sector público la gestión de ciberincidentes se realizará por el CCN-CERT en coordinación con el CNPIC.»","CCN-CERT, comunidad Web del CCN-CERT: «Administraciones Públicas, sistemas clasificados y empresas de interés estratégico para el país.»","CCN-CERT, notificación obligatoria Web del CCN-CERT: «Las Administraciones Públicas y en virtud del cumplimiento del Esquema Nacional de Seguridad, deben notificar al CCN-CERT todos aquellos incidentes que sean catalogados con un nivel de peligrosidad de Alto, Muy Alto y Crítico.»","CCN-CERT, qué es un CERT Web del CCN-CERT: «El término CERT proviene de las siglas en inglés Computer Emergency Response Team»","CCN-CERT, foros internacionales Web del CCN-CERT: «NCIRC de la OTAN (NATO Computer Incident Response Capability), en las que los distintos CERTs de los países miembros de esta Organización analizan y comparten información sobre seguridad de la información.»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-5051'), 'https://www.boe.es/buscar/act.php?id=BOE-A-2004-5051', null, null, null, 'Otras normas citadas: Web del CCN-CERT (https://www.ccn-cert.cni.es/es/sobre-nosotros/mision-y-objetivos.html)'
  from public.topics t where t.slug = 'gc-17b-ciberseguridad-ccn-cert'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Instituto Geográfico Nacional · Tu amigo el mapa (F. Aranaz del Río, 6.ª ed., 2019)', 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf', 'web_oficial'::public.source_kind, 'Instituto Geográfico Nacional (IGN-CNIG)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-18-topografia', 'Tema 18. Topografía') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-18-topografia' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'es', '[{"n":"1","title":"Elementos geográficos: eje terrestre, polos, meridianos, paralelos y ecuador"},{"n":"1.1","title":"Coordenadas geográficas: latitud y longitud"},{"n":"1.2","title":"Puntos cardinales, acimut y rumbo; declinación magnética"},{"n":"2","title":"Unidades de medida: lineales y angulares (grados, minutos y segundos)"},{"n":"3","title":"Proyecciones cartográficas y proyección UTM"},{"n":"4","title":"Escalas numérica y gráfica; cálculo de distancias"},{"n":"5","title":"Elementos del mapa y Mapa Topográfico Nacional (MTN50 y MTN25)"},{"n":"6","title":"Representación del terreno: planimetría y altimetría"},{"n":"6.1","title":"Curvas de nivel, equidistancia y sistema de puntos acotados"},{"n":"6.2","title":"Clases y accidentes del terreno"},{"n":"7","title":"Pendiente entre dos puntos"}]'::jsonb, '["Conceptos cartográficos, ap. 1.1 IGN, Conceptos cartográficos: «La forma real de la Tierra es un geoide cuya superficie irregular coincide con la que resultaría al prolongar por debajo de las superficies continentales, los mares y océanos en calma.»","Latitud y longitud IGN, Atlas Didáctico (cartografía): «Los paralelos determinan la latitud, es decir, la distancia angular que hay desde un punto de la superficie de la Tierra hasta el ecuador. La latitud se mide en grados, minutos y segundos de arco, de 0º a 90°, dirección Norte o Sur.»","Latitud y longitud IGN, Atlas Didáctico (cartografía): «Los meridianos precisan la longitud, que es la distancia angular existente entre un punto de la superficie de la Tierra y el Meridiano de Greenwich. La longitud se mide en grados, minutos y segundos de arco de 0º a 180°, dirección Este u Oeste.»","Conceptos cartográficos, ap. 2.1 IGN, Conceptos cartográficos: «Una proyección cartográfica es conforme cuando mantiene los ángulos que forman dos líneas en la superficie terrestre. Este tipo de proyecciones se utilizan en cartas de navegación.»","Descubre el Territorio, La brújula IGN, Descubre el Territorio: «El ángulo entre el Norte (N) y la dirección de la marcha es el acimut de la dirección a la que nos queremos dirigir.»","Tu amigo el mapa, cap. 8 IGN, Tu amigo el mapa: «La proyección se desarrolla para husos de 6° de amplitud (numerados del 1 al 60 a partir del meridiano 180° hacia el este). España queda comprendida en los husos 28 (de 18° a 12° W), 29 (de 12° a 6° W), 30 (de 6°W a 0°) y 31 (de 0° a 6°E).»","Conceptos cartográficos, ap. 3 IGN, Conceptos cartográficos: «La escala puede expresarse de tres formas distintas: numérica, gráfica y textual o literal.»","Partes de un mapa IGN, Atlas Didáctico (cartografía): «Si se quiere más detalle, se necesitará un mapa a gran escala (denominador pequeño) y, por el contrario, si lo que se quiere es representar una gran extensión de territorio con menor detalle, se utilizará una escala más pequeña (denominador grande).»","Tu amigo el mapa, cap. 24 IGN, Tu amigo el mapa: «Con la misma distribución de hojas del Mapa Topográfico Nacional a escala 1:50.000, cada hoja de esta serie va a dar origen a cuatro nuevas hojas de la serie 1:25.000, cuartos I, II, III y IV, de tal manera que las dimensiones de cada cuarto son las mismas que las de la hoja del MTN 1:50.000.»","Tu amigo el mapa, cap. 32 IGN, Tu amigo el mapa: «En la España peninsular este origen, nivel cero, se fija en el nivel medio del mar en Alicante.»","Representación del relieve IGN, Atlas Didáctico (cartografía): «En un mismo mapa la distancia vertical que separa dos curvas de nivel consecutivas suele ser constante y se denomina equidistancia. Dependiendo de la escala, las isolíneas se representan en los mapas topográficos españoles cada 10 metros (en el Mapa Topográfico Nacional a escala 1:25.000) o cada 20 metros (en el Mapa Topográfico Nacional a escala 1:50.000).»","Representación del relieve IGN, Atlas Didáctico (cartografía): «Puntos acotados. Son puntos que tienen una posición determinada y se representan con la indicación de su altitud numérica.»","Glosario, «divisoria de aguas» IGN, Glosario del Atlas Didáctico: «Línea que une los puntos en los que las aguas fluyen hacia cuencas hidrográficas diferentes. Suele corresponderse con líneas de cumbres.»","Tu amigo el mapa, cap. 33 IGN, Tu amigo el mapa: «La pendiente de una carretera o de un camino puede calcularse fácilmente dividiendo la diferencia de altura entre dos puntos determinados (Δh) por la distancia entre ellos (D).»","Tu amigo el mapa, cap. 74 IGN, Tu amigo el mapa: «Sabemos que la dirección que nos indica la brújula (norte magnético) y el norte verdadero forman un ángulo (declinación magnética) que varía con cada lugar y con el tiempo.»","Tu amigo el mapa, cap. 74 IGN, Tu amigo el mapa: «Para orientarse en un mapa coloque su brújula sobre él y determine el norte magnético con su aguja. Ahora gire lentamente el mapa hasta que la dirección que corresponde al norte geográfico forme con la aguja de la brújula el ángulo que corresponde a la declinación magnética. Esa es la dirección del norte geográfico.»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf'), 'https://www.ign.es/resources/acercaDe/libDigPub/tu-amigo-el-mapa.pdf', null, null, null, 'Otras normas citadas: IGN, Conceptos cartográficos (https://www.ign.es/web/resources/cartografiaEnsenanza/conceptosCarto/descargas/Conceptos_Cartograficos_def.pdf), IGN, Atlas Didáctico (cartografía) (https://educativo.ign.es/atlas-didactico/cartografia-bach/representacin_del_relieve.html), IGN, Descubre el Territorio (https://www.ign.es/recursos-educativos/descubre-territorio/brujula.html), IGN, Glosario del Atlas Didáctico (https://educativo.ign.es/atlas-didactico/glosario/index.html)'
  from public.topics t where t.slug = 'gc-18-topografia'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Principios Básicos sobre el Empleo de la Fuerza y de Armas de Fuego por los Funcionarios Encargados de Hacer Cumplir la Ley (La Habana, 1990)', 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement', 'web_oficial'::public.source_kind, 'Oficina del Alto Comisionado de las Naciones Unidas para los Derechos Humanos (ohchr.org)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-19b-principios-onu-fuerza', 'Tema 19. Deontología (II): Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego (La Habana, 1990)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-19b-principios-onu-fuerza' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'es', '[{"n":"1","title":"Principios Básicos de la ONU sobre el Empleo de la Fuerza y de Armas de Fuego (La Habana, 1990): origen y preámbulo"},{"n":"2","title":"Disposiciones generales (principios 1-8)"},{"n":"3","title":"Disposiciones especiales: uso de armas de fuego (principios 9-11)"},{"n":"4","title":"Actuación en caso de reuniones ilícitas (principios 12-14)"},{"n":"5","title":"Vigilancia de personas bajo custodia o detenidas (principios 15-17)"},{"n":"6","title":"Calificaciones, capacitación y asesoramiento (principios 18-21)"},{"n":"7","title":"Procedimientos de presentación de informes y recursos (principios 22-26)"}]'::jsonb, '["Adopción Principios Básicos de la ONU sobre el empleo de la fuerza (La Habana, 1990): «el Octavo Congreso de las Naciones Unidas sobre Prevención del Delito y Tratamiento del Delincuente, celebrado en La Habana (Cuba) del 27 de agosto al 7 de septiembre de 1990»","Principio 4 Principios Básicos de la ONU sobre el empleo de la fuerza (La Habana, 1990): «Los funcionarios encargados de hacer cumplir la ley, en el desempeño de sus funciones, utilizarán en la medida de lo posible medios no violentos antes de recurrir al empleo de la fuerza y de armas de fuego. Podrán utilizar la fuerza y armas de fuego solamente cuando otros medios resulten ineficaces o no garanticen de ninguna manera el logro del resultado previsto.»","Principio 5.a) Principios Básicos de la ONU sobre el empleo de la fuerza (La Habana, 1990): «a) Ejercerán moderación y actuarán en proporción a la gravedad del delito y al objetivo legítimo que se persiga;»","Principio 6 Principios Básicos de la ONU sobre el empleo de la fuerza (La Habana, 1990): «Cuando al emplear la fuerza o armas de fuego los funcionarios encargados de hacer cumplir la ley ocasionen lesiones o muerte, comunicarán el hecho inmediatamente a sus superiores de conformidad con el principio 22.»","Principio 8 Principios Básicos de la ONU sobre el empleo de la fuerza (La Habana, 1990): «No se podrán invocar circunstancias excepcionales tales como la inestabilidad política interna o cualquier otra situación pública de emergencia para justificar el quebrantamiento de estos Principios Básicos.»","Principio 9 Principios Básicos de la ONU sobre el empleo de la fuerza (La Habana, 1990): «En cualquier caso, sólo se podrá hacer uso intencional de armas letales cuando sea estrictamente inevitable para proteger una vida.»","Principio 10 Principios Básicos de la ONU sobre el empleo de la fuerza (La Habana, 1990): «se identificarán como tales y darán una clara advertencia de su intención de emplear armas de fuego, con tiempo suficiente para que se tome en cuenta»","Principio 13 Principios Básicos de la ONU sobre el empleo de la fuerza (La Habana, 1990): «Al dispersar reuniones ilícitas pero no violentas, los funcionarios encargados de hacer cumplir la ley evitarán el empleo de la fuerza o, si no es posible, lo limitarán al mínimo necesario.»","Principio 14 Principios Básicos de la ONU sobre el empleo de la fuerza (La Habana, 1990): «Al dispersar reuniones violentas, los funcionarios encargados de hacer cumplir la ley podrán utilizar armas de fuego cuando no se puedan utilizar medios menos peligrosos y únicamente en la mínima medida necesaria.»","Principio 15 Principios Básicos de la ONU sobre el empleo de la fuerza (La Habana, 1990): «no emplearán la fuerza, salvo cuando sea estrictamente necesario para mantener la seguridad y el orden en los establecimientos o cuando corra peligro la integridad física de las personas.»","Principio 19 Principios Básicos de la ONU sobre el empleo de la fuerza (La Habana, 1990): «Los funcionarios que deban portar armas de fuego deben estar autorizados para hacerlo sólo tras haber finalizado la capacitación especializada en su empleo.»","Principio 23 Principios Básicos de la ONU sobre el empleo de la fuerza (La Habana, 1990): «En caso de muerte de esas personas, esta disposición se aplicará a sus herederos.»","Principio 24 Principios Básicos de la ONU sobre el empleo de la fuerza (La Habana, 1990): «Los gobiernos y los organismos encargados de hacer cumplir la ley adoptarán las medidas necesarias para que los funcionarios superiores asuman la debida responsabilidad cuando tengan conocimiento, o debieran haberlo tenido, de que los funcionarios a sus órdenes recurren, o han recurrido, al uso ilícito de la fuerza y de armas de fuego, y no adopten todas las medidas a su disposición para impedir, eliminar o denunciar ese uso.»","Principio 26 Principios Básicos de la ONU sobre el empleo de la fuerza (La Habana, 1990): «De cualquier modo, también serán responsables los superiores que dieron las órdenes ilícitas.»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement'), 'https://www.ohchr.org/es/instruments-mechanisms/instruments/basic-principles-use-force-and-firearms-law-enforcement', null, null, null, null
  from public.topics t where t.slug = 'gc-19b-principios-onu-fuerza'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Decreto 1649/1998, de 24 de julio, infracciones administrativas de contrabando (desarrollo del título II de la LO 12/1995) (texto consolidado, BOE)', 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017', 'boe'::public.source_kind, 'Agencia Estatal Boletín Oficial del Estado', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-23b-infracciones-contrabando', 'Tema 23. Derecho fiscal (II): infracciones administrativas de contrabando (RD 1649/1998)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-23b-infracciones-contrabando' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'es', '[{"n":"1","title":"RD 1649/1998: objeto y ámbito (desarrollo del título II de la LO 12/1995)"},{"n":"2","title":"Infracciones, sanciones y comiso (cap. I); las cuantías en pesetas, los porcentajes y la prescripción vigentes son los de los arts. 11, 12 y 15 de la LO 12/1995"},{"n":"2.1","title":"Criterios de graduación de las sanciones (arts. 6-12)"},{"n":"2.2","title":"Comiso (art. 14)"},{"n":"3","title":"Procedimiento sancionador: disposiciones generales y órganos competentes (arts. 15-20)"},{"n":"4","title":"Actuaciones previas: denuncia, diligencias de aprehensión o descubrimiento, destino de lo aprehendido (arts. 21-24)"},{"n":"5","title":"Iniciación e instrucción: valoración, medidas provisionales, alegaciones, prueba y audiencia (arts. 25-34)"},{"n":"6","title":"Resolución, plazos y destino de los bienes decomisados (arts. 35-37)"}]'::jsonb, '["Art. 6.1 RD 1649/1998: «a) La reiteración. b) La resistencia, negativa u obstrucción a la acción investigadora»","Art. 6.3 RD 1649/1998: «Para la aplicación de los criterios de graduación se partirá de la sanción en su límite inferior. Los criterios de graduación son aplicables simultáneamente.»","Art. 14.2 RD 1649/1998: «No se procederá al comiso de los bienes, efectos e instrumentos del contrabando, cuando éstos sean de lícito comercio y hayan sido adquiridos por un tercero de buena fe.»","Art. 16.2 RD 1649/1998: «Es competente para acordar el cierre de establecimientos por infracciones administrativas de contrabando relacionadas con las labores del tabaco, el Director del Departamento de Aduanas e Impuestos Especiales de la Agencia Estatal de Administración Tributaria.»","Art. 17.5 RD 1649/1998: «La sentencia condenatoria de la autoridad judicial excluirá la imposición de sanción por infracción administrativa de contrabando.»","Art. 20.1 RD 1649/1998: «El procedimiento se iniciará de oficio, mediante acuerdo del titular de la unidad administrativa que instruya el expediente, bien por propia iniciativa o como consecuencia de orden superior, petición razonada de otros órganos o denuncia.»","Art. 20.2.b) RD 1649/1998: «b) Las fuerzas de la Guardia Civil, que cumplan funciones propias del resguardo fiscal del Estado y las actuaciones encaminadas a evitar y perseguir el contrabando»","Art. 22.5 RD 1649/1998: «Las diligencias citadas en el párrafo anterior se remitirán, dentro de las cuarenta y ocho horas siguientes al momento en que se formalicen, al órgano al que corresponda iniciar el procedimiento sancionador en razón de su competencia territorial»","Art. 23.2 RD 1649/1998: «Serán de aprehensión cuando, en el momento de formalizarse, tenga lugar la aprehensión de los bienes, efectos o instrumentos. Serán de descubrimiento cuando no tenga lugar la aprehensión de los bienes, efectos e instrumentos.»","Art. 23.5 RD 1649/1998: «Las diligencias se extenderán por triplicado»","Art. 23.6 RD 1649/1998: «Las diligencias formalizadas observando los requisitos señalados en el apartado 3 de este artículo tendrán el carácter de documento público y valor probatorio»","Art. 31 RD 1649/1998: «los interesados dispondrán de un plazo de quince días desde el día siguiente a la notificación de la iniciación»","Art. 32.1 RD 1649/1998: «por un plazo no superior a treinta días ni inferior a diez.»","Art. 35.5 RD 1649/1998: «El plazo máximo para resolver el procedimiento será de seis meses desde la fecha del acuerdo de iniciación.»","Art. 37.1 RD 1649/1998: «Los bienes, efectos e instrumentos definitivamente decomisados por resolución firme en procedimientos por infracción administrativa de contrabando serán adjudicados al Estado.»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017'), 'https://www.boe.es/buscar/act.php?id=BOE-A-1998-21017', null, null, null, null
  from public.topics t where t.slug = 'gc-23b-infracciones-contrabando'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Reglamento (UE) n.º 952/2013, por el que se establece el código aduanero de la Unión (texto consolidado a 12.12.2022): títulos I (caps. 1-2, secc. 1-2), III (cap. 1), VI (caps. 1-2), VII (caps. 1-2) y VIII (caps. 1-4)', 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212', 'web_oficial'::public.source_kind, 'Unión Europea · EUR-Lex (DOUE L 269 de 10.10.2013 y modificaciones)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gc-23c-codigo-aduanero', 'Tema 23. Derecho fiscal (III): código aduanero de la Unión (Reglamento (UE) 952/2013)') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gc-23c-codigo-aduanero' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'es', '[{"n":"1","title":"Reglamento (UE) n.º 952/2013, código aduanero de la Unión (sustituido por el Reglamento (UE) 2026/2108; fin de validez en EUR-Lex: 20.9.2027)"},{"n":"2","title":"Título I, capítulo 1: ámbito de aplicación, misión de las aduanas, territorio aduanero y definiciones (arts. 1-5)"},{"n":"3","title":"Título I, capítulo 2, secciones 1 y 2: suministro de información y representación aduanera (arts. 6-21)"},{"n":"4","title":"Título III, capítulo 1: origen de la deuda aduanera de importación (sección 1) y de exportación (sección 2)"},{"n":"5","title":"Título VI: despacho a libre práctica (cap. 1) y exención de derechos de importación (cap. 2)"},{"n":"6","title":"Título VII: disposiciones generales de los regímenes especiales (cap. 1) y tránsito (cap. 2)"},{"n":"7","title":"Título VIII, capítulos 1 a 4: formalidades previas a la salida, formalidades de salida, exportación y reexportación, declaración sumaria de salida"}]'::jsonb, '["Art. 1.1 Código aduanero de la Unión (Rgto. 952/2013): «El presente Reglamento establece el código aduanero de la Unión (en lo sucesivo, «código»), que contiene las disposiciones y procedimientos generales aplicables a las mercancías introducidas en el territorio aduanero de la Unión o que salgan del mismo.»","Art. 4.1 Código aduanero de la Unión (Rgto. 952/2013): «el territorio del Reino de España, salvo Ceuta y Melilla,»","Art. 5.16 Código aduanero de la Unión (Rgto. 952/2013): ««régimen aduanero» : cualquiera de los regímenes en los que puedan incluirse las mercancías con arreglo al código, a saber: a) despacho a libre práctica; b) regímenes especiales; c) exportación;»","Art. 15.1 Código aduanero de la Unión (Rgto. 952/2013): «A requerimiento de las autoridades aduaneras y dentro del plazo fijado, toda persona que intervenga directa o indirectamente en la realización de las formalidades aduaneras o en los controles aduaneros deberá facilitar a dichas autoridades toda la información y documentación exigida, en una forma adecuada, y toda la asistencia que sea precisa para la realización de esas formalidades o controles.»","Art. 18.1 Código aduanero de la Unión (Rgto. 952/2013): «Esta representación podrá ser directa, en cuyo caso el representante aduanero actuará en nombre y por cuenta de otra persona, o indirecta, en cuyo caso actuará en su propio nombre pero por cuenta de otra persona.»","Art. 77.2-3 Código aduanero de la Unión (Rgto. 952/2013): «La deuda aduanera se originará en el momento de la admisión de la declaración en aduana. […] El declarante será el deudor. En caso de representación indirecta, será también deudora la persona por cuya cuenta se haga la declaración en aduana.»","Art. 81.1 Código aduanero de la Unión (Rgto. 952/2013): «Una deuda aduanera de exportación nacerá al incluirse las mercancías sujetas a derechos de exportación en el régimen de exportación o en el régimen de perfeccionamiento pasivo.»","Art. 201.3 Código aduanero de la Unión (Rgto. 952/2013): «El despacho a libre práctica conferirá a las mercancías no pertenecientes a la Unión el estatuto aduanero de mercancías de la Unión.»","Art. 203.1 Código aduanero de la Unión (Rgto. 952/2013): «Previa solicitud del interesado, quedarán exentas de derechos de importación las mercancías no pertenecientes a la Unión que, tras haber sido inicialmente exportadas fuera del territorio aduanero de esta última como mercancías de la Unión, se reintroduzcan y declaren para su despacho a libre práctica en dicho territorio en un plazo de tres años.»","Art. 210 Código aduanero de la Unión (Rgto. 952/2013): «a) el tránsito, que incluirá el tránsito interno y el tránsito externo; b) el depósito, que incluirá el depósito aduanero y las zonas francas; c) destinos especiales, que incluirán la importación temporal y el destino final; d) el perfeccionamiento, que incluirá el perfeccionamiento activo y el perfeccionamiento pasivo.»","Art. 227.1 Código aduanero de la Unión (Rgto. 952/2013): «El régimen de tránsito interno permitirá, en las condiciones dispuestas en el apartado 2, la circulación de mercancías de la Unión entre dos puntos del territorio aduanero de la Unión, pasando por un país o territorio no perteneciente a dicho territorio aduanero, sin que su estatuto aduanero se modifique.»","Art. 233.1.a) Código aduanero de la Unión (Rgto. 952/2013): «presentar las mercancías intactas y la información requerida en la aduana de destino, en el plazo señalado y habiendo respetado las medidas tomadas por las autoridades aduaneras para garantizar su identificación;»","Art. 263.1 Código aduanero de la Unión (Rgto. 952/2013): «Las mercancías que vayan a salir del territorio aduanero de la Unión irán amparadas por una declaración previa a la salida que se presentará en la aduana competente dentro de un plazo específico antes de que las mercancías salgan del territorio aduanero de la Unión.»","Art. 269.1 Código aduanero de la Unión (Rgto. 952/2013): «Las mercancías de la Unión que vayan a salir del territorio aduanero de la Unión se incluirán en el régimen de exportación.»","Art. 270.1 Código aduanero de la Unión (Rgto. 952/2013): «Las mercancías no pertenecientes a la Unión que vayan a salir del territorio aduanero de la Unión estarán sujetas a una declaración de reexportación, que deberá presentarse en la aduana competente.»","Art. 271.2 Código aduanero de la Unión (Rgto. 952/2013): «La declaración sumaria de salida deberá presentarla el transportista.»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212'), 'https://eur-lex.europa.eu/legal-content/ES/TXT/HTML/?uri=CELEX:02013R0952-20221212', null, null, null, null
  from public.topics t where t.slug = 'gc-23c-codigo-aduanero'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Academia Española y ASALE · Diccionario panhispánico de dudas (DPD), 2.ª edición en línea', 'https://www.rae.es/dpd/', 'web_oficial'::public.source_kind, 'Real Academia Española y Asociación de Academias de la Lengua Española', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gcl-25a-ortografia', 'Tema 25. Lengua española (I): ortografía') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gcl-25a-ortografia' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'es', '[{"n":"1","title":"La prueba de ortografía (base 6.1.1.a de la convocatoria)"},{"n":"2","title":"Uso de la h: echar/hecho, exuberante, exorbitante, hexágono, desahuciar"},{"n":"3","title":"Uso de b y v: absorber/absolver, grabar/gravar, rebelar/revelar, acerbo/acervo"},{"n":"4","title":"Uso de x y s: espontáneo, espléndido, escéptico, expectativa, espirar/expirar"},{"n":"5","title":"Grupos consonánticos: absceso, convalecer, oscuro"},{"n":"6","title":"Diptongos y grafías vulgares: reivindicar, veintidós, cónyuge, idiosincrasia, meteorología"},{"n":"7","title":"Acentuación gráfica: reglas generales, hiatos, monosílabos, solo, demostrativos, aún/aun, enclíticos"},{"n":"8","title":"Palabras juntas o separadas: también/tan bien, enseguida"},{"n":"9","title":"Parónimos: hojear/ojear, aprehender/aprender"}]'::jsonb, '["Base 6.1.1.a Convocatoria Guardia Civil 2026 (BOE-A-2026-9982): «Se considera respuesta errónea, tanto dejar de marcar una palabra o expresión con falta de ortografía como marcar una que es correcta.»","DPD, s. v. echar RAE-ASALE, Diccionario panhispánico de dudas: «No debe escribirse con h inicial, error frecuente en las formas de presente echo, echas, echa por homofonía con las formas del participio de hacer (hecho, hecha).»","DPD, s. v. exorbitante RAE-ASALE, Diccionario panhispánico de dudas: «Es incorrecta la grafía ⊗exhorbitante, ya que órbita, voz con la que está etimológicamente emparentado este adjetivo, se escribe sin hache.»","DPD, s. v. desahuciar RAE-ASALE, Diccionario panhispánico de dudas: «La h intercalada va detrás de la primera a, y no detrás de la s: ⊗deshauciar.»","DPD, s. v. absorber RAE-ASALE, Diccionario panhispánico de dudas: «Es incorrecta la grafía ⊗absorver, debida al cruce con absolver (''declarar inocente''; → absolver).»","DPD, s. v. gravar RAE-ASALE, Diccionario panhispánico de dudas: «No debe confundirse con grabar (''marcar [algo] en una superficie mediante incisión'' y ''registrar [sonidos o imágenes] en un soporte''; → grabar).»","DPD, s. v. revelar RAE-ASALE, Diccionario panhispánico de dudas: «Como el resto de las palabras que pertenecen a su misma familia léxica (revelación, revelado, revelador, etc.), se escribe siempre con v. No debe confundirse, pues, con el verbo homófono rebelar(se) (''sublevar(se)''; → rebelar(se)).»","DPD, s. v. espontáneo RAE-ASALE, Diccionario panhispánico de dudas: «En este adjetivo y en el resto de las palabras de su misma familia léxica, como espontaneidad o espontáneamente, son incorrectas las grafías con x: ⊗expontáneo, ⊗expontaneidad, etc.»","DPD, s. v. escéptico RAE-ASALE, Diccionario panhispánico de dudas: «Es incorrecta la grafía ⊗excéptico y la correspondiente pronunciación ⊗[ekséptiko, ekszéptiko]. Lo mismo cabe decir del derivado escepticismo (no ⊗excepticismo).»","DPD, s. v. absceso RAE-ASALE, Diccionario panhispánico de dudas: «Es incorrecta la grafía ⊗abceso. No debe confundirse con acceso (''entrada o paso''; → acceso).»","DPD, s. v. reivindicar RAE-ASALE, Diccionario panhispánico de dudas: «Es incorrecto reducir el diptongo ei a e en todas las formas de este verbo (⊗revindicar), así como en las voces de su misma familia: ⊗revindicación, ⊗revindicativo, etc.; en lugar de reivindicación, reivindicativo, etc.»","DPD, s. v. tilde2, 1.2.1 RAE-ASALE, Diccionario panhispánico de dudas: «Las palabras agudas (→ acento, 1.2a) llevan tilde cuando terminan en -n o en -s no precedidas de otra consonante, o en las vocales a, e, i, o, u: balón, compás, café, colibrí, bantú.»","DPD, s. v. asimismo RAE-ASALE, Diccionario panhispánico de dudas: «La forma simple se escribe sin tilde, por lo que no es correcta la grafía ⊗asímismo.»","DPD, s. v. cohibir RAE-ASALE, Diccionario panhispánico de dudas: «La hache intercalada no exime de la obligación de tildar la i para marcar el hiato en las formas en que esta vocal es tónica (→ tilde2, 2.3.2a): cohíbo, cohíbes, cohíbe, cohíben; cohíba, cohíbas, cohíban.»","DPD, s. v. también RAE-ASALE, Diccionario panhispánico de dudas: «La secuencia tan bien se usa en construcciones comparativas (Canta tan bien como su padre) y consecutivas (Canta tan bien que la ha contratado una orquesta).»","DPD, s. v. ojear RAE-ASALE, Diccionario panhispánico de dudas: «Es incorrecta la grafía ⊗hojeada ―error debido al influjo de hojear―, incluso cuando lo que se mira es un libro o revista que puede hojearse»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'https://www.rae.es/dpd/', null, null, null, 'Otras normas citadas: Convocatoria Guardia Civil 2026 (BOE-A-2026-9982) (https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982)'
  from public.topics t where t.slug = 'gcl-25a-ortografia'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
insert into public.sources (title, url, kind, publisher, published_on) values ('Real Academia Española y ASALE · Diccionario panhispánico de dudas (DPD), 2.ª edición en línea', 'https://www.rae.es/dpd/', 'web_oficial'::public.source_kind, 'Real Academia Española y Asociación de Academias de la Lengua Española', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('gcl-25b-gramatica', 'Tema 25. Lengua española (II): gramática') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug in ('guardia-civil-cabos-guardias') and t.slug = 'gcl-25b-gramatica' on conflict do nothing;
insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, 'es', '[{"n":"1","title":"La prueba de gramática (base 6.1.1.b de la convocatoria)"},{"n":"2","title":"Dequeísmo y queísmo"},{"n":"3","title":"Leísmo, laísmo y loísmo"},{"n":"4","title":"Verbo haber impersonal y perífrasis «haber que»"},{"n":"5","title":"Verbo hacer: imperativo, uso impersonal y «hacer público»"},{"n":"6","title":"Verbos irregulares: ir, andar, conducir, satisfacer, errar"},{"n":"7","title":"Perífrasis deber / deber de + infinitivo"},{"n":"8","title":"Adverbios, conjunciones y determinantes: detrás, sino, sendos, cuyo"}]'::jsonb, '["Base 6.1.1.b Convocatoria Guardia Civil 2026 (BOE-A-2026-9982): «Consistirá en la realización de un ejercicio con veinte (20) frases o expresiones, debiendo señalar aquellas frases o expresiones que no son correctas desde los puntos de vista morfológico y/o sintáctico.»","DPD, s. v. dequeísmo RAE-ASALE, Diccionario panhispánico de dudas: «Es el uso indebido de la preposición de delante de la conjunción que cuando la preposición no está gramaticalmente justificada.»","DPD, s. v. queísmo RAE-ASALE, Diccionario panhispánico de dudas: «Es la supresión indebida de una preposición (generalmente de) delante de la conjunción que, cuando la preposición está gramaticalmente justificada.»","DPD, s. v. dequeísmo, 5b RAE-ASALE, Diccionario panhispánico de dudas: «Sustituir la subordinada con que por el pronombre eso y comprobar si se mantiene o no la preposición de, o si ha de usarse otra distinta»","DPD, s. v. laísmo RAE-ASALE, Diccionario panhispánico de dudas: «Es el uso impropio de la(s) en función de complemento indirecto femenino, en lugar de le(s), que es la forma a la que corresponde etimológicamente ejercer esa función»","DPD, s. v. loísmo RAE-ASALE, Diccionario panhispánico de dudas: «Es el uso impropio de lo(s) en función de complemento indirecto masculino (de persona o de cosa) o neutro (cuando el antecedente es un pronombre neutro o toda una oración), en lugar de le(s)»","DPD, s. v. leísmo RAE-ASALE, Diccionario panhispánico de dudas: «El leísmo, en cambio, no se admite de ningún modo en la norma culta cuando el referente es inanimado: ⊗El libro que me prestaste le leí de un tirón; ⊗Los informes me les mandas cuando puedas.»","DPD, s. v. haber, 4 RAE-ASALE, Diccionario panhispánico de dudas: «Por consiguiente, en estos casos, lo más apropiado es que el verbo permanezca en singular, y así sucede en el uso culto mayoritario, especialmente en la lengua escrita, tanto en España como en América»","DPD, s. v. haber, 3b RAE-ASALE, Diccionario panhispánico de dudas: «Al ser impersonal, se conjuga solo en tercera persona del singular; por ello, si el verbo que le sigue es pronominal, no es correcto el uso del pronombre de primera persona del plural»","DPD, s. v. hacer RAE-ASALE, Diccionario panhispánico de dudas: «El imperativo singular es haz (tú) y hacé (vos), y no ⊗hace.»","DPD, s. v. ir RAE-ASALE, Diccionario panhispánico de dudas: «Las formas de imperativo propias del tuteo son ve (tú) e id (vosotros)»","DPD, s. v. conducir RAE-ASALE, Diccionario panhispánico de dudas: «Como ocurre en todos los verbos terminados en -ducir, se escuchan a veces formas regularizadas en el pretérito perfecto simple, que no se consideran correctas: ⊗conducí, ⊗conduciste, ⊗condució, etc., en lugar de conduje, condujiste, condujo, etc.»","DPD, s. v. deber RAE-ASALE, Diccionario panhispánico de dudas: «b) deber de + infinitivo. Denota normalmente probabilidad o suposición»","DPD, s. v. detrás RAE-ASALE, Diccionario panhispánico de dudas: «Por su condición de adverbio, se desaconseja en el habla culta su uso con posesivos: ⊗detrás mío, ⊗detrás suya, etc. (en lugar de detrás de mí, detrás de él/ella, etc.).»","DPD, s. v. sino RAE-ASALE, Diccionario panhispánico de dudas: «En la lengua actual, cuando lo que se contrapone son oraciones con el verbo en forma personal, sino debe ir seguido de que»","DPD, s. v. sendos RAE-ASALE, Diccionario panhispánico de dudas: «No debe emplearse como equivalente de dos o ambos»"]'::jsonb, '[]'::jsonb, '[]'::jsonb, (select id from public.sources where url = 'https://www.rae.es/dpd/'), 'https://www.rae.es/dpd/', null, null, null, 'Otras normas citadas: Convocatoria Guardia Civil 2026 (BOE-A-2026-9982) (https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-9982)'
  from public.topics t where t.slug = 'gcl-25b-gramatica'
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);
commit;
