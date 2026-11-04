# Auxiliar Administrativo del Estado · fuentes y elección (2026-11-04)

## Por qué esta oposición (petición de joel: «la siguiente que más clientes podamos tener»)

| Oposición                                          | Aspirantes (último dato)                                                                     | Plazas       | Convocatoria                                 | Encaje con Aprobia                                                                                                                                              |
| -------------------------------------------------- | -------------------------------------------------------------------------------------------- | ------------ | -------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Auxiliar Administrativo del Estado (C2, libre)** | 46.798 convocados / 22.412 presentados (examen 23/05/2026); 54.136 convocados en la anterior | 1.700        | **Anual** (última: BOE 22/12/2025)           | Test 4 opciones, −1/3; **30 psicotécnicas** en el examen; temario = leyes del BOE (citables literalmente); base común con Administrativo, autonómicas y locales |
| Correos (personal laboral)                         | 84.000 inscritos (2022), 149.675 (2020), 166.348 (2018)                                      | 7.757 (2022) | Irregular; **sin convocatoria** a 26/10/2026 | Temario interno de Correos, difícil de verificar con fuente oficial                                                                                             |
| Policía Nacional (Escala Básica)                   | ~37.000 solicitudes (todas las escalas)                                                      | ~2.500       | Anual                                        | Temario propio + físicas                                                                                                                                        |
| Guardia Civil (cabos y guardias)                   | 27.614 (06/09/2025)                                                                          | 3.118        | Anual                                        | Temario propio + físicas                                                                                                                                        |

Fuentes de las cifras: nota de prensa de Función Pública de 22/05/2026 (152.149 admitidos en los cinco
cuerpos generales de la AGE); administraciondejusticia.com y josenrique.es (presentados por cuerpo,
citan la nota del INAP de 23/05/2026; difieren en las plazas de 2024); Público/Europa Press 19/01/2020
(Correos, 166.348 solicitudes); formacion.ninja y redopositor.com (Correos 2022 y 2026);
Periódico de Ibiza 05/09/2025 (Guardia Civil). Interior (Policía) no se pudo abrir.
Las webs del INAP y del BOE bloquean el acceso automatizado desde el contenedor; el BOE de la
convocatoria se leyó con la herramienta de lectura web.

## Convocatoria (verificada)

Resolución de 18 de diciembre de 2025, de la Secretaría de Estado de Función Pública (BOE núm. 306,
22/12/2025, **BOE-A-2025-26262**), Anexo I · Cuerpo General Auxiliar de la Administración del Estado,
ingreso libre, código 1146: **1.700 plazas** (156 reserva discapacidad). Titulación: Graduado en ESO.
Tasa 11,66 €.

**Ejercicio único** (dos partes obligatorias y eliminatorias, a la vez, **90 minutos**):

- Parte 1: hasta 60 preguntas: **30 del Bloque I** + **30 psicotécnicas** (aptitudes administrativas,
  numéricas o verbales) + 5 de reserva. 0-50 puntos, mínimo 25.
- Parte 2: hasta 50 preguntas del **Bloque II** (Windows 11 y Microsoft 365 escritorio) + 5 de reserva.
  0-50 puntos, mínimo 25.
- 4 respuestas, una correcta; **cada error resta 1/3**; en blanco no resta.

Programa: Bloque I (16 temas, organización pública) y Bloque II (12 temas, actividad administrativa y
ofimática). Títulos literales en `/mnt/project-files/aprobia/fuentes-oficiales/auxiliar-estado/`
(build.py, `TOPICS`) y en el BOE.

## Fuentes del temario (Bloque I)

Texto consolidado del BOE de 18 normas, tomado de github.com/legalize-dev/legalize-es (réplica de la
API de datos abiertos del BOE, commit b735e7d, 02/11/2026), porque `boe.es` no es accesible desde el
contenedor. Copia en `/mnt/project-files/aprobia/fuentes-oficiales/auxiliar-estado/leyes/`.
Cada pregunta y cada idea de ficha enlaza al texto consolidado oficial (`boe.es/buscar/act.php?id=…`).

CE, LOTC, LO 3/1981 (Defensor del Pueblo), LOPJ, Ley 50/1997 (Gobierno), Ley 19/2013, Ley 40/2015,
Ley 7/1985, Ley 39/2015, Ley 29/1998, LO 3/2018, TREBEP, Ley 47/2003, LO 3/2007, LO 1/2004,
Ley 4/2023, RDL 1/2013, Ley 39/2006.

**Sin cubrir todavía:** tema 6 (Gobierno Abierto y Agenda 2030: no hay una norma del BOE que lo
recoja), tema 10 (instituciones de la UE: los Tratados no están en la réplica), el Registro Central
de Personal (tema 13), la Seguridad Social de los funcionarios (tema 14) y el **Bloque II completo**
(ofimática: necesita la documentación oficial de Microsoft; atención al ciudadano y registro sí
salen del BOE).

## Estilo de las preguntas

Enunciado directo («Según el artículo X de la Ley 39/2015…»), 4 opciones, una correcta, distractores
del mismo tipo (plazos, mayorías, órganos). Redacción original: no se copian exámenes ni bancos de
academias. Cada pregunta lleva su artículo y la cita literal, comprobada automáticamente
(`build.py --check`). Las dudosas llevan nota y no se publican sin revisión.
