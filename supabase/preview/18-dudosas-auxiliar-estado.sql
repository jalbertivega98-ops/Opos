-- Auxiliar del Estado: las 12 preguntas dudosas, aclaradas y publicadas.
-- joel pidió publicarlas (hilo del proyecto, 04/11/2026: «Súbelas»). Antes de publicar se ha
-- añadido a cada explicación la aclaración que motivaba la duda (dato del Tratado que el
-- Consejo cambió, denominación de ministerio que conserva la ley, atajo que depende del
-- idioma, etc.) y se quita la nota de revisión. Después se publica igual que en 15-/17-.
-- Idempotente. Requiere 12- a 17-.
begin;

update public.questions q
   set explanation = v.explanation, review_note = null
  from (values
  ('4ecbd458b8785a4b411e998afe42e13330e997fb17b756c26ac8f496a59dade7', 'El art. 252 TFUE fija ocho abogados generales y permite que el Consejo, por unanimidad y a petición del Tribunal de Justicia, aumente su número. Su función es presentar públicamente conclusiones motivadas con imparcialidad e independencia. En la práctica, el Consejo usó esa facultad (Decisión 2013/336/UE) y hoy hay once abogados generales.'),
  ('3466d767e9de0eea6ad7e6b31be71c29d672896bdc051de48a4937b8c82a7371', 'El art. 10.1 LT dispone que el Portal de la Transparencia dependa del Ministerio de la Presidencia. Al Ministerio de Hacienda y Administraciones Públicas está adscrito el Consejo de Transparencia y Buen Gobierno (art. 33.1). «Ministerio de la Presidencia» es la denominación que usa el texto de la ley; el ministerio concreto depende de cada reestructuración ministerial.'),
  ('0206ce2a723d8b49de7e125c2d5a302c71eea7246aae95abd0a25a7dd432d189', 'Ctrl+Mayús+E activa o desactiva el control de cambios; un comentario se inserta con Ctrl+Alt+M, la vista Esquema con Ctrl+Alt+O y los caracteres no imprimibles se muestran con Ctrl+Mayús+8. Los atajos con letra pueden variar según el idioma del teclado; este es el que da Microsoft para Word en español.'),
  ('17539999bd9d167de7ffbb664a90cd2be5db7ba4642e147efd975dfa5e2e40d0', 'El art. 17.5 TUE prevé una Comisión reducida a dos tercios del número de Estados miembros, con rotación estrictamente igual, salvo decisión unánime del Consejo Europeo que modifique ese número. En la práctica, el Consejo Europeo usó esa facultad (Decisión 2013/272/UE) y la Comisión sigue teniendo un nacional de cada Estado miembro.'),
  ('550ab5f04589ed5acdc2063b9191249f73bce9e92f8b562e6f997a54667aea22', 'El art. 15.2 RD 951/2005 admite la presentación presencial, por correo postal y por medios telemáticos; las presentadas por correo electrónico o Internet deben ir suscritas con firma electrónica del interesado. El texto consolidado mantiene esta exigencia, que convive con las reglas generales de firma del art. 11 de la Ley 39/2015.'),
  ('074f3e631b3b736b18d7c8b9f8eb066d842d5c126f09f1d1b7b3b37507b1010b', 'Microsoft indica: pestaña Diseño de consulta, grupo Resultados, Ejecutar. La pestaña Crear contiene Diseño de consulta para crearla, no para ejecutarla. En versiones anteriores de Access la pestaña se llamaba «Diseño».'),
  ('ffade3fdf44f1036c4f7082e6cd7cd8236e14d8b5258973f646e76f89c3280e6', 'El art. 59.2 LRJSP prevé la orden del Ministro respectivo, previa autorización del Ministro de Hacienda y Administraciones Públicas. El Real Decreto del Consejo de Ministros se reserva a Subsecretarías, Secretarías Generales, Direcciones y Subdirecciones Generales (art. 59.1), y las relaciones de puestos de trabajo, a las unidades que no son órganos (art. 59.3). «Ministro de Hacienda y Administraciones Públicas» es la denominación que conserva el texto de la ley; hoy esa competencia corresponde al ministerio con competencias en función pública.'),
  ('a214aca8b72b85f312627078dc9b35a17bbedb753662c487d8671de1fcf36edb', 'Windows + C abre Copilot. El dictado por voz se abre con Windows + H, las notificaciones con Windows + N y los emojis con Windows + punto. Microsoft indica que el comportamiento de este atajo se puede configurar.'),
  ('26512465ac2cb2f83ea45e8dca3e98735b7e354f31451195d12de540b2d3173c', 'El art. 49.a) TREBEP, en su redacción vigente, fija en diecinueve semanas el permiso por nacimiento para la madre biológica (treinta y dos en caso de monoparentalidad), de las cuales las seis inmediatamente posteriores al parto son obligatorias. Duración vigente tras el Real Decreto-ley 9/2025 (antes eran dieciséis semanas).'),
  ('70ced163e3d1278db16383e2255378a8502352006ba58b2f3bd8f93eeed55c87', 'El art. 5.1.c) Ley 39/2006 exige cinco años de residencia, dos de ellos inmediatamente anteriores a la solicitud; para los menores de cinco años, el periodo se exige a quien ejerza su guarda y custodia.'),
  ('1d8b77d1bc0bfa85979c78a59ac192ce5013e84fcc349d678c470622d8dfb158', 'Microsoft indica que el Explorador se abre de forma predeterminada en Acceso rápido y que, si se prefiere Este equipo, puede cambiarse desde las opciones de la cinta. En versiones recientes de Windows 11 esta vista aparece como «Inicio» en el panel de navegación; el programa oficial la llama «Acceso rápido».'),
  ('4858bf48835cf4cef66eca64258598a5fbf51530acb265444cf4e4dcb766339b', 'El Grupo de Trabajo Interministerial, foro técnico de coordinación entre Ministerios, lo preside la Alta Comisionada para la Agenda 2030 y eleva trimestralmente informes a la Comisión Delegada del Gobierno para Asuntos Económicos. Ojo: la Orden se cita en su redacción de 2019; la estructura de gobernanza de la Agenda 2030 (Alto Comisionado y ministerio responsable) ha cambiado después.')
  ) as v(content_hash, explanation)
 where q.content_hash = v.content_hash and q.locale = 'es' and q.is_test = false
   and q.status in ('draft', 'needs_review')
   and (q.explanation is distinct from v.explanation or q.review_note is not null);

commit;
