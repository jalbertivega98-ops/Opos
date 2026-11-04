-- Auxiliar del Estado · 13 preguntas nuevas de informática general y seguridad (temas II.5 y II.12),
-- tras ver que el examen real de 2025 (parte 2) incluye unas 8 de este tipo (insider, SGSI,
-- VPN, DNS…). Fuente oficial: Glosario de términos de ciberseguridad del INCIBE (2021),
-- citas literales comprobadas con build.py --check. Se publican como el resto de Auxiliar
-- (petición de joel: «súbelos y publícalos», «Sigue y sube todo»). Idempotente.
begin;
-- Lote age-aux-b2-05-informatica-basica-incibe_glosario-v1 (8 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('INCIBE · Glosario de términos de ciberseguridad: una guía de aproximación para el empresario (2021)', 'https://www.incibe.es/sites/default/files/contenidos/guias/doc/guia_glosario_ciberseguridad_2021.pdf', 'web_oficial'::public.source_kind, 'Instituto Nacional de Ciberseguridad (INCIBE)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-05-informatica-basica', 'II.5 Informática básica y seguridad') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b2-05-informatica-basica' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el glosario de ciberseguridad del INCIBE, ¿qué es un insider?', 'El INCIBE define el insider como una persona de la propia organización que divulga información sensible de forma intencionada: es interno y actúa a propósito.', 'age_aux_b2_05_informatica_basica', (select id from public.topics where slug = 'age-aux-b2-05-informatica-basica'), 2, 'es', true, (select id from public.sources where url = 'https://www.incibe.es/sites/default/files/contenidos/guias/doc/guia_glosario_ciberseguridad_2021.pdf'), 'Glosario INCIBE · Insider', 'Persona perteneciente a una organización o empresa que divulga información sensible sobre dicha empresa de forma intencionada.', null, 'd1627b2a8167b93224104945373ebc0e4b4109bc1ba13e6c97f80d8f7fd23310', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'd1627b2a8167b93224104945373ebc0e4b4109bc1ba13e6c97f80d8f7fd23310')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Una persona ajena a la organización que provoca un incidente de seguridad de forma intencionada.', false), ('B', 'Una persona perteneciente a una organización que divulga información sensible sobre ella de forma intencionada.', true), ('C', 'Una persona perteneciente a una organización que provoca un incidente de seguridad de forma accidental.', false), ('D', 'Un programa malicioso que se instala dentro de la red de la organización sin que lo detecte el antivirus.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'El malware que «secuestra» un dispositivo o la información que contiene, de forma que la víctima no puede acceder a ella si no paga un rescate, se denomina:', 'Es el ransomware. El spyware recopila información sin consentimiento, el rootkit da acceso oculto con permisos de administrador y el adware se apoya en anuncios.', 'age_aux_b2_05_informatica_basica', (select id from public.topics where slug = 'age-aux-b2-05-informatica-basica'), 1, 'es', true, (select id from public.sources where url = 'https://www.incibe.es/sites/default/files/contenidos/guias/doc/guia_glosario_ciberseguridad_2021.pdf'), 'Glosario INCIBE · Ransomware', 'Malware cuya funcionalidad es «secuestrar» un dispositivo (en sus inicios) o la información que contiene de forma que si la víctima no paga el rescate, no podrá acceder a ella.', null, '00fa41422cfc2f15695b8c821dd598cf26f3c00f23650feca5ddfeca6f3d22f9', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '00fa41422cfc2f15695b8c821dd598cf26f3c00f23650feca5ddfeca6f3d22f9')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Spyware.', false), ('B', 'Rootkit.', false), ('C', 'Adware.', false), ('D', 'Ransomware.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el INCIBE, el malware que recopila información de un ordenador y la envía a una entidad remota sin el conocimiento ni el consentimiento de su propietario es:', 'Es el spyware o programa espía. El gusano se propaga solo, el ransomware pide un rescate y una botnet es un conjunto de equipos controlados a distancia.', 'age_aux_b2_05_informatica_basica', (select id from public.topics where slug = 'age-aux-b2-05-informatica-basica'), 1, 'es', true, (select id from public.sources where url = 'https://www.incibe.es/sites/default/files/contenidos/guias/doc/guia_glosario_ciberseguridad_2021.pdf'), 'Glosario INCIBE · Spyware', 'Es un malware que recopila información de un ordenador y después la envía a una entidad remota sin el conocimiento o el consentimiento del propietario del ordenador.', null, 'ef98ac5f962bbb47b2df9ffb0f72d5d90e0554331465404626d5a90d065021df', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ef98ac5f962bbb47b2df9ffb0f72d5d90e0554331465404626d5a90d065021df')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El gusano.', false), ('B', 'El ransomware.', false), ('C', 'El spyware.', true), ('D', 'La botnet.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Qué tipo de spyware monitoriza toda la actividad realizada con el teclado para enviarla después al ciberdelincuente?', 'El keylogger registra las teclas pulsadas. El rootkit da acceso continuo y oculto con permisos de administrador; el sniffer captura el tráfico de la red; el exploit aprovecha una vulnerabilidad.', 'age_aux_b2_05_informatica_basica', (select id from public.topics where slug = 'age-aux-b2-05-informatica-basica'), 2, 'es', true, (select id from public.sources where url = 'https://www.incibe.es/sites/default/files/contenidos/guias/doc/guia_glosario_ciberseguridad_2021.pdf'), 'Glosario INCIBE · Keylogger', 'Es un tipo de spyware que se encarga de monitorizar toda la actividad realizada con el teclado (teclas que se pulsan) para luego enviarla al ciberdelincuente.', null, 'ecdc2280f111dba4c3d8d912d4a28b3694ff41721a5f069c4b20c92d0ecc316f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ecdc2280f111dba4c3d8d912d4a28b3694ff41721a5f069c4b20c92d0ecc316f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Keylogger.', true), ('B', 'Rootkit.', false), ('C', 'Sniffer.', false), ('D', 'Exploit.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el INCIBE, ¿qué diferencia a un gusano de un troyano?', 'Los troyanos dependen de que el usuario acceda a una web maliciosa o ejecute un fichero infectado; los gusanos se copian y se propagan solos, con independencia de la acción humana.', 'age_aux_b2_05_informatica_basica', (select id from public.topics where slug = 'age-aux-b2-05-informatica-basica'), 2, 'es', true, (select id from public.sources where url = 'https://www.incibe.es/sites/default/files/contenidos/guias/doc/guia_glosario_ciberseguridad_2021.pdf'), 'Glosario INCIBE · Gusano', 'Mientras que los troyanos dependen de que un usuario acceda a una web maliciosa o ejecute un fichero infectado, los gusanos realizan copias de sí mismos, infectan a otros ordenadores y se propagan automáticamente en una red independientemente de la acción humana.', null, 'a1b54978d1478d27398e27bbbafb34e91e5844d101cffcf319e4e5d8c4c766e8', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a1b54978d1478d27398e27bbbafb34e91e5844d101cffcf319e4e5d8c4c766e8')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El gusano necesita que el usuario ejecute un fichero infectado para propagarse.', false), ('B', 'El gusano solo infecta los sectores de arranque de los dispositivos de almacenamiento.', false), ('C', 'El gusano cifra la información del equipo y pide un rescate.', false), ('D', 'El gusano hace copias de sí mismo y se propaga automáticamente por la red sin necesidad de acción humana.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el glosario del INCIBE, un Sistema de Gestión de la Seguridad de la Información (SGSI) es un conjunto de políticas de seguridad de la información que siguen la norma:', 'El SGSI sigue la norma ISO/IEC 27001. La ISO 9001 es de gestión de la calidad, la 14001 de gestión ambiental y la ISO/IEC 20000 de gestión de servicios de TI.', 'age_aux_b2_05_informatica_basica', (select id from public.topics where slug = 'age-aux-b2-05-informatica-basica'), 2, 'es', true, (select id from public.sources where url = 'https://www.incibe.es/sites/default/files/contenidos/guias/doc/guia_glosario_ciberseguridad_2021.pdf'), 'Glosario INCIBE · SGSI', 'Un Sistema de Gestión de la seguridad de la Información (SGSI) es un conjunto de políticas de seguridad de la información que siguen la norma ISO/IEC 27001.', null, 'a611ed887696e805b58e4d5402c69dbae187753d6816f11106d6b7a2a9526804', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'a611ed887696e805b58e4d5402c69dbae187753d6816f11106d6b7a2a9526804')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'ISO/IEC 27001.', true), ('B', 'ISO 9001.', false), ('C', 'ISO 14001.', false), ('D', 'ISO/IEC 20000.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select '¿Cómo define el INCIBE el doble factor de autenticación?', 'Es una autenticación básica reforzada con otro factor (código al móvil, huella, OTP), más segura que la autenticación simple.', 'age_aux_b2_05_informatica_basica', (select id from public.topics where slug = 'age-aux-b2-05-informatica-basica'), 1, 'es', true, (select id from public.sources where url = 'https://www.incibe.es/sites/default/files/contenidos/guias/doc/guia_glosario_ciberseguridad_2021.pdf'), 'Glosario INCIBE · Doble factor de autenticación', 'Esquema de autenticación básica a la que se añade otro factor como puede ser un código enviado a un móvil, huella dactilar, sistema OTP, etc., más seguro que la autenticación simple.', null, '813336d3be8d5429baa8ce06575b3db7a60374669bd90deea2e9b12c469aafbc', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '813336d3be8d5429baa8ce06575b3db7a60374669bd90deea2e9b12c469aafbc')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El uso de dos contraseñas distintas para la misma cuenta.', false), ('B', 'Una autenticación básica a la que se añade otro factor, como un código enviado al móvil o la huella dactilar.', true), ('C', 'La comprobación de la identidad del usuario por dos personas de la organización.', false), ('D', 'El cifrado de la contraseña con dos claves, una pública y otra privada.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'El sistema de seguridad, de software o hardware, situado en los puntos limítrofes de una red para permitir y limitar el flujo de tráfico según un conjunto de normas se denomina:', 'Es el cortafuegos o firewall. El proxy hace de intermediario entre la red local e Internet, la VPN extiende una red local de forma segura sobre Internet y el antivirus evita ejecutar software malicioso.', 'age_aux_b2_05_informatica_basica', (select id from public.topics where slug = 'age-aux-b2-05-informatica-basica'), 1, 'es', true, (select id from public.sources where url = 'https://www.incibe.es/sites/default/files/contenidos/guias/doc/guia_glosario_ciberseguridad_2021.pdf'), 'Glosario INCIBE · Cortafuegos', 'Sistema de seguridad compuesto o bien de programas (software) o de dispositivos hardware situados en los puntos limítrofes de una red que tienen el objetivo de permitir y limitar, el flujo de tráfico entre los diferentes ámbitos que protege sobre la base de un conjunto de normas y otros criterios.', null, 'ec3fb7cfe52470eb3ae03186091341794524eb50da005ded2470da9ec86c7e8e', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ec3fb7cfe52470eb3ae03186091341794524eb50da005ded2470da9ec86c7e8e')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Proxy.', false), ('B', 'Red privada virtual.', false), ('C', 'Cortafuegos (firewall).', true), ('D', 'Antivirus.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
-- Lote age-aux-b2-12-internet-incibe_glosario-v1 (5 preguntas)
insert into public.sources (title, url, kind, publisher, published_on) values ('INCIBE · Glosario de términos de ciberseguridad: una guía de aproximación para el empresario (2021)', 'https://www.incibe.es/sites/default/files/contenidos/guias/doc/guia_glosario_ciberseguridad_2021.pdf', 'web_oficial'::public.source_kind, 'Instituto Nacional de Ciberseguridad (INCIBE)', null) on conflict (url) do nothing;
insert into public.topics (slug, title) values ('age-aux-b2-12-internet', 'II.12 La red Internet y los navegadores') on conflict (slug) do nothing;
insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = 'auxiliar-administrativo-estado' and t.slug = 'age-aux-b2-12-internet' on conflict do nothing;
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el INCIBE, ¿cuál es la función más importante del servicio DNS?', 'El DNS traduce nombres de dominio en direcciones IP. La asignación automática de direcciones es tarea del DHCP, el cifrado del tráfico web lo da HTTPS y el intermediario es el proxy.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 1, 'es', true, (select id from public.sources where url = 'https://www.incibe.es/sites/default/files/contenidos/guias/doc/guia_glosario_ciberseguridad_2021.pdf'), 'Glosario INCIBE · DNS', 'Su función más importante es traducir nombres inteligibles para las personas en direcciones IP asociados con los sistemas conectados a la red', null, '28d2ba22a5c382d770c26f58451b50dd2622f88b4133e83f31d3dc0fc5503d13', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '28d2ba22a5c382d770c26f58451b50dd2622f88b4133e83f31d3dc0fc5503d13')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Traducir nombres inteligibles para las personas en direcciones IP.', true), ('B', 'Asignar automáticamente una dirección IP a cada equipo que se conecta a la red.', false), ('C', 'Cifrar el tráfico entre el navegador y el servidor web.', false), ('D', 'Hacer de intermediario en las peticiones de los equipos de la red local hacia Internet.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'La tecnología de red que permite una extensión segura de una red local (LAN) sobre una red pública o no controlada como Internet es:', 'Es la VPN (Virtual Private Network), que protege la integridad y la confidencialidad con autenticación y cifrado.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 2, 'es', true, (select id from public.sources where url = 'https://www.incibe.es/sites/default/files/contenidos/guias/doc/guia_glosario_ciberseguridad_2021.pdf'), 'Glosario INCIBE · Red privada virtual', 'Una red privada virtual, también conocida por sus siglas VPN (Virtual Private Network) es una tecnología de red que permite una extensión segura de una red local (LAN) sobre una red pública o no controlada como Internet.', null, 'ad924fa7574aad9f21ff6d59dda3bd77f06259cb09b55cf007e62166c4324b9f', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'ad924fa7574aad9f21ff6d59dda3bd77f06259cb09b55cf007e62166c4324b9f')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'El proxy.', false), ('B', 'La red privada virtual (VPN).', true), ('C', 'El punto de acceso inalámbrico.', false), ('D', 'El servidor DNS.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'Según el INCIBE, una dirección IP en su versión 4 es:', 'La IPv4 son cuatro números del 0 al 255 separados por puntos (por ejemplo, 192.168.121.40). Los grupos hexadecimales separados por dos puntos son propios de IPv6.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 2, 'es', true, (select id from public.sources where url = 'https://www.incibe.es/sites/default/files/contenidos/guias/doc/guia_glosario_ciberseguridad_2021.pdf'), 'Glosario INCIBE · Dirección IP', 'Así, una dirección IP (o simplemente IP) en su versión v4 es un conjunto de cuatro números del 0 al 255 separados por puntos.', null, 'f1a4f37c7e739b7029db7bd50032d278477c33dbce189b1f37ce8c112609e2c6', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = 'f1a4f37c7e739b7029db7bd50032d278477c33dbce189b1f37ce8c112609e2c6')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Un conjunto de seis números del 0 al 99 separados por guiones.', false), ('B', 'Un conjunto de cuatro números del 0 al 999 separados por puntos.', false), ('C', 'Un conjunto de cuatro números del 0 al 255 separados por puntos.', true), ('D', 'Una cadena de ocho grupos de cifras hexadecimales separados por dos puntos.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'El equipo o software que hace de intermediario en las peticiones de los equipos de una red LAN hacia Internet se denomina:', 'Es el proxy, que centraliza el tráfico entre Internet y la red privada y puede añadir mecanismos de seguridad.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 2, 'es', true, (select id from public.sources where url = 'https://www.incibe.es/sites/default/files/contenidos/guias/doc/guia_glosario_ciberseguridad_2021.pdf'), 'Glosario INCIBE · Proxy', 'El proxy es tanto el equipo, como el software encargado de dar el servicio, que hacen de intermediario en las peticiones de los equipos de la redes LAN hacia Internet.', null, '06897e1678317b191bea894b9fd201f256bd812973136ff072ff0888b5938ba5', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '06897e1678317b191bea894b9fd201f256bd812973136ff072ff0888b5938ba5')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'DNS.', false), ('B', 'Router inalámbrico.', false), ('C', 'Botnet.', false), ('D', 'Proxy.', true)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select 'La técnica en la que alguien suplanta a una entidad o servicio mediante un correo electrónico o un mensaje instantáneo para conseguir las credenciales o los datos de la tarjeta de crédito de un usuario es el:', 'Es el phishing. El pharming aprovecha una vulnerabilidad de los servidores DNS para redirigir a una web falsa, y el keylogger registra las teclas pulsadas.', 'age_aux_b2_12_internet', (select id from public.topics where slug = 'age-aux-b2-12-internet'), 1, 'es', true, (select id from public.sources where url = 'https://www.incibe.es/sites/default/files/contenidos/guias/doc/guia_glosario_ciberseguridad_2021.pdf'), 'Glosario INCIBE · Phishing', 'Técnica o tipo de ataque en el que alguien suplanta a una entidad/servicio mediante un correo electrónico o mensaje instantáneo para conseguir las credenciales o información de la tarjeta de crédito de un usuario.', null, '17042964e4f731b3007e08d0cd9ae5e0b540f2914a47a638889663bf7f18b6fa', false
  where not exists (select 1 from public.questions where locale = 'es' and content_hash = '17042964e4f731b3007e08d0cd9ae5e0b540f2914a47a638889663bf7f18b6fa')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ('A', 'Pharming.', false), ('B', 'Spoofing de IP.', false), ('C', 'Phishing.', true), ('D', 'Keylogger.', false)) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = 'auxiliar-administrativo-estado';
do $$
declare
  v_owner uuid;
  v_slug text;
  v_q int := 0;
  v_n int := 0;
  v_p int := 0;
begin
  select id into v_owner from public.profiles
   where role = 'owner' and status = 'active' order by created_at limit 1;
  if v_owner is null then
    raise notice 'No hay persona titular: no se publica nada.';
    return;
  end if;
  perform set_config('request.jwt.claims',
    json_build_object('sub', v_owner, 'role', 'authenticated')::text, true);

  for v_slug in select slug from public.topics where slug like 'age-aux-%' order by slug loop
    perform public.review_topic_batch(v_slug, 'approved', false);
    v_q := v_q + public.review_topic_batch(v_slug, 'published', false);
    perform public.review_topic_notes(v_slug, 'approved');
    v_n := v_n + public.review_topic_notes(v_slug, 'published');
  end loop;

  with pub as (
    update public.products p set status = 'published'
     where p.status = 'draft' and p.is_test = false and p.slug like 'age-aux-%'
       and (p.type <> 'question_pack'
            or exists (select 1 from public.product_items i join public.questions q on q.id = i.question_id
                        where i.product_id = p.id and q.status = 'published'))
       and (p.type <> 'mock_exam' or p.config->>'kind' = 'psycho'
            or (select count(*) from public.mock_pool(p.id)) >= (public.mock_config(p.config)->>'questions')::int)
    returning 1)
  select count(*) into v_p from pub;

  perform public.open_exams_with_content();
  perform public.log_admin_action('content.publish_exam', 'exam_bodies', 'auxiliar-administrativo-estado',
    jsonb_build_object('questions', v_q, 'notes', v_n, 'products', v_p,
                       'motivo', 'Petición expresa de joel en el hilo del proyecto (04/11/2026, calibración con los exámenes del INAP)'));
  perform set_config('request.jwt.claims', '', true);
  raise notice 'Auxiliar del Estado: % preguntas, % fichas y % productos publicados', v_q, v_n, v_p;
end $$;

commit;
