# Auxiliar Administrativo del Estado · exámenes reales y calibración (2026-11-04)

Fuente: sede electrónica del INAP (sede.inap.gob.es), ingreso libre, convocatorias 2025 (examen del
23/05/2026) y 2024. Leídos en el Chrome de joel porque el contenedor no llega a INAP. Los PDF se
abrieron con pdf.js (cdnjs) dentro de la propia página. Documentos: cuestionario modelo A,
plantillas, «Criterios de corrección, valoración y superación» (18/05/2026) y la nota de
puntuaciones mínimas (15/10/2026).

No se copia ninguna pregunta: este análisis solo sirve para ajustar el formato, el reparto y el estilo.

## Formato y nota

- Ejercicio único en 90 minutos. Parte 1: 60 preguntas (+5 de reserva). Parte 2: 50 (+5). Cuatro
  opciones, una correcta; puntuación directa A − E/3; en blanco no resta.
- Parte 1 apta con el 50 % de la máxima (o menos, hasta un 30 %, si no se llega a 4.632 aptos).
  Parte 2: los mejores hasta 1.544 plazas, siempre que tengan al menos el 30 %.
- Calificación de cada parte de 0 a 50: 25 en el corte, 50 con la máxima, lineal entre ambos. Se suman.
- **Cortes de 2025 (sistema general):** parte 1, **29,00** de 60; parte 2, **21,33** de 50.
  Norma común 13: 21,33 y 15,33.

## Parte 1 (60)

- **1-30, Bloque I.** Estilo «Conforme al artículo X de la Ley…», «Señale la afirmación correcta…»,
  «¿Cuál NO es…?», con distractores casi idénticos (mayorías, plazos, órganos). Es el estilo que ya
  seguían nuestras preguntas. Temas de 2025: CE (arts. 8, 57, 63, 78, 102, 123, 167), Ley 50/1997,
  Agenda 2030, Ley 19/2013, Ley 40/2015, LBRL, TUE (art. 15) y adhesiones a la UE, Ley 39/2015,
  TREBEP (arts. 37, 53, 87, 88, 96, 97), Ley 47/2003 y LO 3/2007.
- **31-60, psicotécnicas.**

| Tipo                                  | 2025 | 2024 |
| ------------------------------------- | ---- | ---- |
| Ortografía (palabra con error)        | 3    | 3    |
| Sinónimos y antónimos                 | 6    | 5    |
| Porcentajes y fracciones con importes | 4    | 2    |
| Series numéricas                      | 2    | 3    |
| Ecuaciones de primer grado            | 3    | 0    |
| Probabilidad                          | 0    | 2    |
| Codificación letras ↔ binario         | 0    | 3    |
| Tablas (2 tablas × 6 preguntas)       | 12   | 12   |

Las preguntas de tablas son de cinco clases: quién suma o promedia más, porcentaje sobre el total,
cociente por fila o por grupo, y qué fila cumple varias condiciones.

## Parte 2 (50)

- Unas 10 de los temas 1-4 (RD 208/1996, CE y discapacidad, RD 951/2005, Ley 39/2015, RD 203/2021).
- **Unas 8 de informática general:** malvertising, ISO 27000/SGSI, insider, plug and play, UTF-8,
  almacenamiento secundario, IA generativa, archivo, VPN, DNS y DHCP.
- El resto de ofimática: Windows 11 (unas 10), Word (4), Excel (6), Access (6), Outlook (5).

## Qué se ha cambiado (ADR-022)

1. **Cinco generadores nuevos** con el formato de la AGE: `percentages`, `equations`,
   `probability`, `codes` y `tables`. Cada solución se recalcula al corregir y hay tests con los
   casos reales (41,40 €, 0,625, 33,33 %, «accb»…).
2. El simulacro de psicotécnicos de la AGE pasa a tener: codificación 3, porcentajes 6,
   probabilidad 2, series 3, ecuaciones 4 y tablas 12.
3. **Simulacro completo** (`kind: "sections"`): 30 Bloque I + 30 psicotécnicos + 50 Bloque II en
   90 minutos, con nota por partes y los cortes de 2025.
4. **13 preguntas nuevas** de seguridad y redes, con cita literal del glosario del INCIBE.

## Pendiente

- ~~Sinónimos, antónimos y ortografía~~: hecho en ADR-043 con un banco comprobado en el DLE (preview `63-`).
- Las tablas del examen real sirven para 6 preguntas cada una. En la plataforma, cada pregunta trae
  su propia tabla, más pequeña.
- Falta informática general sin fuente aún: plug and play, UTF-8, IA generativa y DHCP.
