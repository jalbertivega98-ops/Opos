import type { PsychoType } from "@/lib/learning/psycho/types";

/**
 * Páginas públicas por tipo de psicotécnico (ADR-025). Explican el método de
 * resolución de cada tipo (contenido propio y genérico) y enlazan al entrenador
 * gratuito. Lo que se diga de un examen concreto debe venir de exam-guides.ts.
 */
type L = { es: string; ca: string };

export type PsychoGuide = {
  type: PsychoType;
  slug: string;
  title: L;
  description: L;
  intro: L;
  method: L[];
  faq: { q: L; a: L }[];
};

const G: PsychoGuide[] = [
  {
    type: "series",
    slug: "series-numericas",
    title: {
      es: "Test de series numéricas gratis para oposiciones",
      ca: "Test de sèries numèriques gratis",
    },
    description: {
      es: "Practica gratis series numéricas de psicotécnicos con dificultad creciente: aritméticas, geométricas, alternas, de segundo orden e intercaladas, con la solución explicada.",
      ca: "Practica gratis sèries numèriques de psicotècnics amb dificultat creixent: aritmètiques, geomètriques, alternes, de segon ordre i intercalades, amb la solució explicada.",
    },
    intro: {
      es: "En una serie numérica hay que descubrir la regla que relaciona los términos y calcular el siguiente. Es uno de los ejercicios más habituales de los psicotécnicos de oposiciones.",
      ca: "En una sèrie numèrica cal descobrir la regla que relaciona els termes i calcular el següent. És un dels exercicis més habituals dels psicotècnics d'oposicions.",
    },
    method: [
      {
        es: "Calcula la diferencia entre cada término y el anterior. Si es constante, es una serie aritmética.",
        ca: "Calcula la diferència entre cada terme i l'anterior. Si és constant, és una sèrie aritmètica.",
      },
      {
        es: "Si las diferencias crecen, mira si cambian siempre lo mismo (segundo orden) o si cada término se multiplica por un número (geométrica).",
        ca: "Si les diferències creixen, mira si canvien sempre igual (segon ordre) o si cada terme es multiplica per un nombre (geomètrica).",
      },
      {
        es: "Si nada encaja, separa los términos pares e impares: puede haber dos series intercaladas o una regla que alterna dos operaciones.",
        ca: "Si res no encaixa, separa els termes parells i senars: hi pot haver dues sèries intercalades o una regla que alterna dues operacions.",
      },
    ],
    faq: [
      {
        q: {
          es: "¿Qué tipos de series numéricas hay en los psicotécnicos?",
          ca: "Quins tipus de sèries numèriques hi ha als psicotècnics?",
        },
        a: {
          es: "Las más comunes son aritméticas (se suma siempre lo mismo), geométricas (se multiplica), alternas, de segundo orden (las diferencias cambian de forma regular), tipo Fibonacci e intercaladas (dos series mezcladas).",
          ca: "Les més comunes són aritmètiques (se suma sempre el mateix), geomètriques (es multiplica), alternes, de segon ordre (les diferències canvien de manera regular), tipus Fibonacci i intercalades (dues sèries barrejades).",
        },
      },
    ],
  },
  {
    type: "letters",
    slug: "series-de-letras",
    title: {
      es: "Test de series de letras gratis para oposiciones",
      ca: "Test de sèries de lletres gratis",
    },
    description: {
      es: "Ejercicios gratis de series alfabéticas con el alfabeto español (con Ñ): saltos, alternancias e intercalados, con explicación de cada respuesta.",
      ca: "Exercicis gratis de sèries alfabètiques amb l'alfabet espanyol (amb Ñ): salts, alternances i intercalats, amb l'explicació de cada resposta.",
    },
    intro: {
      es: "Las series de letras funcionan como las numéricas, pero con la posición de cada letra en el alfabeto. En los psicotécnicos en castellano se usa el alfabeto español de 27 letras, con la Ñ.",
      ca: "Les sèries de lletres funcionen com les numèriques, però amb la posició de cada lletra a l'alfabet. Als psicotècnics en castellà es fa servir l'alfabet espanyol de 27 lletres, amb la Ñ.",
    },
    method: [
      {
        es: "Escribe el número de posición de cada letra (A = 1, B = 2… Ñ = 15) y busca la regla con los números.",
        ca: "Escriu el número de posició de cada lletra (A = 1, B = 2… Ñ = 15) i busca la regla amb els números.",
      },
      {
        es: "Comprueba si los saltos son constantes, si alternan o si crecen.",
        ca: "Comprova si els salts són constants, si alternen o si creixen.",
      },
      {
        es: "No olvides la Ñ al contar: es el error más frecuente.",
        ca: "No oblidis la Ñ en comptar: és l'error més freqüent.",
      },
    ],
    faq: [
      {
        q: {
          es: "¿Se cuenta la Ñ en las series de letras?",
          ca: "Es compta la Ñ a les sèries de lletres?",
        },
        a: {
          es: "En los psicotécnicos en castellano, sí: el alfabeto español tiene 27 letras y la Ñ va entre la N y la O. Nuestros ejercicios lo indican en el enunciado.",
          ca: "Als psicotècnics en castellà, sí: l'alfabet espanyol té 27 lletres i la Ñ va entre la N i la O. Els nostres exercicis ho indiquen a l'enunciat.",
        },
      },
    ],
  },
  {
    type: "numeric",
    slug: "razonamiento-numerico",
    title: { es: "Test de razonamiento numérico gratis", ca: "Test de raonament numèric gratis" },
    description: {
      es: "Problemas breves de cálculo para psicotécnicos: reglas de tres, proporciones directas e inversas, velocidades, medias y mezclas. Gratis y con la solución paso a paso.",
      ca: "Problemes breus de càlcul per a psicotècnics: regles de tres, proporcions directes i inverses, velocitats, mitjanes i barreges. Gratis i amb la solució pas a pas.",
    },
    intro: {
      es: "El razonamiento numérico mide la rapidez para plantear y resolver problemas sencillos sin calculadora: porcentajes, proporciones, velocidades o medias.",
      ca: "El raonament numèric mesura la rapidesa per plantejar i resoldre problemes senzills sense calculadora: percentatges, proporcions, velocitats o mitjanes.",
    },
    method: [
      {
        es: "Identifica qué relación hay entre las magnitudes: si una crece y la otra también, es proporción directa; si una crece y la otra baja, inversa.",
        ca: "Identifica quina relació hi ha entre les magnituds: si una creix i l'altra també, és proporció directa; si una creix i l'altra baixa, inversa.",
      },
      {
        es: "Escribe la operación antes de calcular y simplifica cuando puedas.",
        ca: "Escriu l'operació abans de calcular i simplifica quan puguis.",
      },
      {
        es: "Estima el resultado para descartar opciones imposibles antes de hacer la cuenta exacta.",
        ca: "Estima el resultat per descartar opcions impossibles abans de fer el compte exacte.",
      },
    ],
    faq: [
      {
        q: {
          es: "¿Cómo distinguir una proporción directa de una inversa?",
          ca: "Com es distingeix una proporció directa d'una d'inversa?",
        },
        a: {
          es: "Si al duplicar una magnitud la otra también se duplica (más cajas, más peso), es directa. Si la otra se reduce a la mitad (más personas, menos días de trabajo), es inversa.",
          ca: "Si en duplicar una magnitud l'altra també es duplica (més caixes, més pes), és directa. Si l'altra es redueix a la meitat (més persones, menys dies de feina), és inversa.",
        },
      },
    ],
  },
  {
    type: "analogies",
    slug: "analogias-verbales",
    title: {
      es: "Test de analogías verbales gratis",
      ca: "Test d'analogies verbals gratis per a oposicions",
    },
    description: {
      es: "Practica analogías verbales de psicotécnicos: contrarios, parte y todo, categoría, función y crías de animales. Ejercicios gratis con la relación explicada.",
      ca: "Practica analogies verbals de psicotècnics: contraris, part i tot, categoria, funció i cries d'animals. Exercicis gratis amb la relació explicada.",
    },
    intro: {
      es: "Una analogía verbal plantea dos palabras relacionadas y pide la palabra que mantiene la misma relación con una tercera. Mide la aptitud verbal y el razonamiento con conceptos.",
      ca: "Una analogia verbal planteja dues paraules relacionades i demana la paraula que manté la mateixa relació amb una tercera. Mesura l'aptitud verbal i el raonament amb conceptes.",
    },
    method: [
      {
        es: "Formula la relación del primer par con una frase: «A es lo contrario de B», «A es una parte de B».",
        ca: "Formula la relació del primer parell amb una frase: «A és el contrari de B», «A és una part de B».",
      },
      {
        es: "Aplica la misma frase a la tercera palabra con cada opción.",
        ca: "Aplica la mateixa frase a la tercera paraula amb cada opció.",
      },
      {
        es: "Si encajan varias, haz la frase más precisa hasta que solo quede una.",
        ca: "Si n'encaixen diverses, fes la frase més precisa fins que només en quedi una.",
      },
    ],
    faq: [
      {
        q: {
          es: "¿Qué relaciones aparecen en las analogías verbales?",
          ca: "Quines relacions apareixen a les analogies verbals?",
        },
        a: {
          es: "Las más habituales son contrarios, parte y todo, elemento y categoría, objeto y función, y animal y cría.",
          ca: "Les més habituals són contraris, part i tot, element i categoria, objecte i funció, i animal i cria.",
        },
      },
    ],
  },
  {
    type: "matrices",
    slug: "matrices",
    title: {
      es: "Test de matrices y razonamiento abstracto gratis",
      ca: "Test de matrius i raonament abstracte gratis",
    },
    description: {
      es: "Matrices de figuras para practicar razonamiento abstracto: forma, número, relleno y giro cambian por filas y columnas. Ejercicios gratis generados y verificados automáticamente.",
      ca: "Matrius de figures per practicar raonament abstracte: forma, nombre, farciment i gir canvien per files i columnes. Exercicis gratis generats i verificats automàticament.",
    },
    intro: {
      es: "En una matriz de 3 × 3 falta una casilla y hay que elegir la figura que la completa. Cada atributo (forma, número de elementos, relleno y giro) sigue una regla por filas, por columnas o es constante.",
      ca: "En una matriu de 3 × 3 falta una casella i cal triar la figura que la completa. Cada atribut (forma, nombre d'elements, farciment i gir) segueix una regla per files, per columnes o és constant.",
    },
    method: [
      {
        es: "Analiza un atributo cada vez: primero la forma, luego el número, el relleno y el giro.",
        ca: "Analitza un atribut cada vegada: primer la forma, després el nombre, el farciment i el gir.",
      },
      {
        es: "Para cada atributo, mira si cambia de una fila a otra, de una columna a otra o si cada fila contiene las tres variantes.",
        ca: "Per a cada atribut, mira si canvia d'una fila a una altra, d'una columna a una altra o si cada fila conté les tres variants.",
      },
      {
        es: "Descarta las opciones que fallan en algún atributo; la que cumple todos es la respuesta.",
        ca: "Descarta les opcions que fallen en algun atribut; la que els compleix tots és la resposta.",
      },
    ],
    faq: [
      {
        q: {
          es: "¿Qué miden las matrices en un psicotécnico?",
          ca: "Què mesuren les matrius en un psicotècnic?",
        },
        a: {
          es: "Miden el razonamiento abstracto: la capacidad de descubrir reglas en información visual sin apoyo de palabras ni números.",
          ca: "Mesuren el raonament abstracte: la capacitat de descobrir regles en informació visual sense el suport de paraules ni nombres.",
        },
      },
    ],
  },
  {
    type: "spatial",
    slug: "razonamiento-espacial",
    title: { es: "Test de razonamiento espacial gratis", ca: "Test de raonament espacial gratis" },
    description: {
      es: "Ejercicios gratis de giros y simetrías de piezas en cuadrícula para psicotécnicos de oposiciones, con dificultad creciente y solución explicada.",
      ca: "Exercicis gratis de girs i simetries de peces en quadrícula per a psicotècnics d'oposicions, amb dificultat creixent i solució explicada.",
    },
    intro: {
      es: "Se muestra una pieza y hay que reconocer cuál de las opciones es la misma pieza girada. Las demás son su imagen en espejo o piezas distintas.",
      ca: "Es mostra una peça i cal reconèixer quina de les opcions és la mateixa peça girada. Les altres són la seva imatge en mirall o peces diferents.",
    },
    method: [
      {
        es: "Elige un detalle asimétrico de la pieza (una esquina, un saliente) y síguelo al girar.",
        ca: "Tria un detall asimètric de la peça (una cantonada, un sortint) i segueix-lo en girar.",
      },
      {
        es: "Comprueba la posición relativa de dos detalles: en un espejo se intercambian izquierda y derecha.",
        ca: "Comprova la posició relativa de dos detalls: en un mirall s'intercanvien esquerra i dreta.",
      },
      {
        es: "Cuenta las casillas de la pieza para descartar rápido las que son diferentes.",
        ca: "Compta les caselles de la peça per descartar ràpidament les que són diferents.",
      },
    ],
    faq: [
      {
        q: {
          es: "¿Cómo distinguir una pieza girada de su imagen en espejo?",
          ca: "Com es distingeix una peça girada de la seva imatge en mirall?",
        },
        a: {
          es: "Al girar, el orden de los detalles alrededor de la pieza se mantiene (por ejemplo, en el sentido de las agujas del reloj). En el espejo ese orden se invierte.",
          ca: "En girar, l'ordre dels detalls al voltant de la peça es manté (per exemple, en el sentit de les agulles del rellotge). Al mirall aquest ordre s'inverteix.",
        },
      },
    ],
  },
  {
    type: "attention",
    slug: "atencion-y-concentracion",
    title: {
      es: "Test de atención y concentración gratis",
      ca: "Test d'atenció i concentració gratis",
    },
    description: {
      es: "Practica ejercicios de atención y percepción: recuento de símbolos parecidos y detección de parejas idénticas, gratis y con tiempo.",
      ca: "Practica exercicis d'atenció i percepció: recompte de símbols semblants i detecció de parelles idèntiques, gratis i amb temps.",
    },
    intro: {
      es: "Los ejercicios de atención miden la precisión y la rapidez perceptiva: contar cuántas veces aparece un símbolo entre otros parecidos o encontrar parejas exactamente iguales.",
      ca: "Els exercicis d'atenció mesuren la precisió i la rapidesa perceptiva: comptar quantes vegades apareix un símbol entre altres de semblants o trobar parelles exactament iguals.",
    },
    method: [
      {
        es: "Recorre la línea de izquierda a derecha y en bloques pequeños, sin saltar.",
        ca: "Recorre la línia d'esquerra a dreta i en blocs petits, sense saltar.",
      },
      {
        es: "Fíjate en un rasgo que diferencie el símbolo objetivo de los parecidos.",
        ca: "Fixa't en un tret que diferenciï el símbol objectiu dels semblants.",
      },
      {
        es: "En las parejas, compara cifra a cifra: lo habitual es que cambie o se intercambie un solo carácter.",
        ca: "A les parelles, compara xifra a xifra: el més habitual és que canviï o s'intercanviï un sol caràcter.",
      },
    ],
    faq: [
      {
        q: {
          es: "¿Cómo mejorar en los ejercicios de atención?",
          ca: "Com es millora als exercicis d'atenció?",
        },
        a: {
          es: "Con práctica cronometrada y un método fijo de recorrido. Es mejor ir algo más despacio y no fallar que repasar dos veces.",
          ca: "Amb pràctica cronometrada i un mètode fix de recorregut. És millor anar una mica més a poc a poc i no fallar que repassar dues vegades.",
        },
      },
    ],
  },
  {
    type: "percentages",
    slug: "porcentajes-y-fracciones",
    title: {
      es: "Test de porcentajes y fracciones gratis",
      ca: "Test de percentatges i fraccions gratis",
    },
    description: {
      es: "Problemas de descuentos, subidas, asistencia y partes de un total con importes en euros, como en el psicotécnico de Auxiliar Administrativo del Estado. Gratis y con solución.",
      ca: "Problemes de descomptes, apujades, assistència i parts d'un total amb imports en euros, com al psicotècnic d'Auxiliar Administratiu de l'Estat. Gratis i amb solució.",
    },
    intro: {
      es: "Problemas cortos con porcentajes y fracciones sobre situaciones cotidianas de oficina: precios con descuento o subida, asistentes a una reunión o partes de un presupuesto.",
      ca: "Problemes curts amb percentatges i fraccions sobre situacions quotidianes d'oficina: preus amb descompte o apujada, assistents a una reunió o parts d'un pressupost.",
    },
    method: [
      {
        es: "Un descuento del d % equivale a multiplicar por (100 − d)/100; una subida, por (100 + d)/100.",
        ca: "Un descompte del d % equival a multiplicar per (100 − d)/100; una apujada, per (100 + d)/100.",
      },
      {
        es: "Con fracciones, suma primero las partes conocidas y resta del total para hallar lo que queda.",
        ca: "Amb fraccions, suma primer les parts conegudes i resta-les del total per trobar el que queda.",
      },
      {
        es: "Redondea solo al final y revisa que la unidad de la respuesta (euros, personas, %) coincide con la pregunta.",
        ca: "Arrodoneix només al final i revisa que la unitat de la resposta (euros, persones, %) coincideix amb la pregunta.",
      },
    ],
    faq: [
      {
        q: {
          es: "¿Cómo se calcula rápido un precio con descuento?",
          ca: "Com es calcula ràpidament un preu amb descompte?",
        },
        a: {
          es: "Multiplica el precio por lo que queda: con un 20 % de descuento pagas el 80 %, es decir, precio × 0,8.",
          ca: "Multiplica el preu pel que queda: amb un 20 % de descompte pagues el 80 %, és a dir, preu × 0,8.",
        },
      },
    ],
  },
  {
    type: "equations",
    slug: "ecuaciones",
    title: {
      es: "Test de ecuaciones de primer grado gratis",
      ca: "Test d'equacions de primer grau gratis",
    },
    description: {
      es: "Ecuaciones de primer grado con paréntesis como las del examen de la AGE. Practica gratis y revisa la resolución paso a paso.",
      ca: "Equacions de primer grau amb parèntesis com les de l'examen de l'AGE. Practica gratis i revisa la resolució pas a pas.",
    },
    intro: {
      es: "Ecuaciones lineales con una incógnita y paréntesis que hay que resolver mentalmente o con pocos pasos escritos.",
      ca: "Equacions lineals amb una incògnita i parèntesis que cal resoldre mentalment o amb pocs passos escrits.",
    },
    method: [
      {
        es: "Quita los paréntesis multiplicando con cuidado los signos.",
        ca: "Treu els parèntesis multiplicant amb cura els signes.",
      },
      {
        es: "Pasa los términos con x a un lado y los números al otro.",
        ca: "Passa els termes amb x a un costat i els nombres a l'altre.",
      },
      {
        es: "Comprueba la solución sustituyéndola en la ecuación original o probando las opciones.",
        ca: "Comprova la solució substituint-la a l'equació original o provant les opcions.",
      },
    ],
    faq: [
      {
        q: {
          es: "¿Conviene probar las opciones en lugar de resolver la ecuación?",
          ca: "Convé provar les opcions en lloc de resoldre l'equació?",
        },
        a: {
          es: "A veces sí: sustituir cada opción en la ecuación es rápido cuando los números son sencillos y sirve para comprobar el resultado.",
          ca: "De vegades sí: substituir cada opció a l'equació és ràpid quan els nombres són senzills i serveix per comprovar el resultat.",
        },
      },
    ],
  },
  {
    type: "probability",
    slug: "probabilidad",
    title: {
      es: "Test de probabilidad gratis para oposiciones",
      ca: "Test de probabilitat gratis per a oposicions",
    },
    description: {
      es: "Problemas de probabilidad básica (casos favorables entre casos posibles) con el resultado en porcentaje. Ejercicios gratis con la solución explicada.",
      ca: "Problemes de probabilitat bàsica (casos favorables entre casos possibles) amb el resultat en percentatge. Exercicis gratis amb la solució explicada.",
    },
    intro: {
      es: "Problemas de probabilidad simple: sacar una bola, elegir a una persona de un grupo o un expediente de una caja. Se calcula como casos favorables entre casos posibles.",
      ca: "Problemes de probabilitat simple: treure una bola, triar una persona d'un grup o un expedient d'una caixa. Es calcula com a casos favorables entre casos possibles.",
    },
    method: [
      {
        es: "Cuenta todos los casos posibles (el total).",
        ca: "Compta tots els casos possibles (el total).",
      },
      {
        es: "Cuenta solo los casos que cumplen la condición de la pregunta.",
        ca: "Compta només els casos que compleixen la condició de la pregunta.",
      },
      {
        es: "Divide favorables entre posibles y multiplica por 100 si piden porcentaje.",
        ca: "Divideix favorables entre possibles i multiplica per 100 si demanen percentatge.",
      },
    ],
    faq: [
      {
        q: {
          es: "¿Cómo se calcula una probabilidad en un psicotécnico?",
          ca: "Com es calcula una probabilitat en un psicotècnic?",
        },
        a: {
          es: "Con la regla de Laplace: casos favorables divididos entre casos posibles. Si hay 3 favorables de 12, la probabilidad es 3/12 = 0,25, es decir, un 25 %.",
          ca: "Amb la regla de Laplace: casos favorables dividits entre casos possibles. Si n'hi ha 3 de favorables de 12, la probabilitat és 3/12 = 0,25, és a dir, un 25 %.",
        },
      },
    ],
  },
  {
    type: "codes",
    slug: "codificacion",
    title: {
      es: "Test de codificación gratis para oposiciones",
      ca: "Test de codificació gratis per a oposicions",
    },
    description: {
      es: "Ejercicios de equivalencias entre letras y códigos binarios, como en el psicotécnico de Auxiliar Administrativo del Estado. Gratis y con la clave explicada.",
      ca: "Exercicis d'equivalències entre lletres i codis binaris, com al psicotècnic d'Auxiliar Administratiu de l'Estat. Gratis i amb la clau explicada.",
    },
    intro: {
      es: "Se da una tabla de equivalencias entre letras y códigos y hay que traducir una palabra o un código. Mide atención y rapidez con información administrativa.",
      ca: "Es dona una taula d'equivalències entre lletres i codis i cal traduir una paraula o un codi. Mesura l'atenció i la rapidesa amb informació administrativa.",
    },
    method: [
      {
        es: "Traduce carácter a carácter y escribe el resultado parcial.",
        ca: "Tradueix caràcter a caràcter i escriu el resultat parcial.",
      },
      {
        es: "Compara solo el primer y el último elemento con las opciones para descartar rápido.",
        ca: "Compara només el primer i l'últim element amb les opcions per descartar ràpidament.",
      },
      {
        es: "Revisa los códigos parecidos (por ejemplo, 01 y 10): son la trampa habitual.",
        ca: "Revisa els codis semblants (per exemple, 01 i 10): són el parany habitual.",
      },
    ],
    faq: [
      {
        q: {
          es: "¿Qué es un ejercicio de codificación?",
          ca: "Què és un exercici de codificació?",
        },
        a: {
          es: "Un ejercicio en el que se aplica una clave de equivalencias (por ejemplo, letra y código binario) para traducir una palabra o un código en poco tiempo.",
          ca: "Un exercici en què s'aplica una clau d'equivalències (per exemple, lletra i codi binari) per traduir una paraula o un codi en poc temps.",
        },
      },
    ],
  },
  {
    type: "tables",
    slug: "interpretacion-de-tablas",
    title: {
      es: "Test de interpretación de tablas gratis",
      ca: "Test d'interpretació de taules gratis",
    },
    description: {
      es: "Preguntas sobre tablas de datos: sumas, medias, porcentajes, cocientes y filas que cumplen varias condiciones, el bloque más numeroso del psicotécnico de la AGE. Gratis.",
      ca: "Preguntes sobre taules de dades: sumes, mitjanes, percentatges, quocients i files que compleixen diverses condicions, el bloc més nombrós del psicotècnic de l'AGE. Gratis.",
    },
    intro: {
      es: "Se presenta una tabla con datos de personas, oficinas o expedientes y varias preguntas sobre ella: quién suma o promedia más, qué porcentaje supone un dato o qué fila cumple varias condiciones.",
      ca: "Es presenta una taula amb dades de persones, oficines o expedients i diverses preguntes sobre aquesta taula: qui suma o fa més mitjana, quin percentatge representa una dada o quina fila compleix diverses condicions.",
    },
    method: [
      {
        es: "Lee primero la pregunta y localiza solo las columnas que necesitas.",
        ca: "Llegeix primer la pregunta i localitza només les columnes que necessites.",
      },
      {
        es: "Con varias condiciones, aplícalas de una en una y tacha las filas que no cumplen.",
        ca: "Amb diverses condicions, aplica-les d'una en una i ratlla les files que no compleixen.",
      },
      {
        es: "Para comparar medias de grupos del mismo tamaño basta con comparar las sumas.",
        ca: "Per comparar mitjanes de grups de la mateixa mida n'hi ha prou amb comparar les sumes.",
      },
    ],
    faq: [
      {
        q: {
          es: "¿Cuántas preguntas de tablas hay en el examen de Auxiliar Administrativo del Estado?",
          ca: "Quantes preguntes de taules hi ha a l'examen d'Auxiliar Administratiu de l'Estat?",
        },
        a: {
          es: "En los exámenes de 2024 y 2025 hubo 12 preguntas de tablas (dos tablas con seis preguntas cada una) dentro de las 30 psicotécnicas.",
          ca: "Als exàmens del 2024 i el 2025 hi va haver 12 preguntes de taules (dues taules amb sis preguntes cadascuna) dins de les 30 psicotècniques.",
        },
      },
    ],
  },
  {
    type: "spelling",
    slug: "ortografia",
    title: {
      es: "Test de ortografía gratis para oposiciones",
      ca: "Test d'ortografia castellana gratis",
    },
    description: {
      es: "Encuentra la palabra mal escrita entre cuatro (b/v, h, g/j, x/s, ll/y), como en el psicotécnico de Auxiliar del Estado. Gratis y comprobado con el diccionario de la RAE.",
      ca: "Troba la paraula castellana mal escrita entre quatre (b/v, h, g/j, x/s, ll/y), com al psicotècnic d'Auxiliar de l'Estat. Gratis i comprovat amb el diccionari de la RAE.",
    },
    intro: {
      es: "Tres palabras están bien escritas y una tiene una falta. Todas las formas correctas están en el Diccionario de la lengua española y ninguna de las erróneas.",
      ca: "Tres paraules estan ben escrites i una té una falta. Totes les formes correctes són al Diccionario de la lengua española i cap de les errònies.",
    },
    method: [
      {
        es: "Lee cada palabra despacio y fíjate en las letras que suelen confundirse: b/v, g/j, ll/y, x/s y la h.",
        ca: "Llegeix cada paraula a poc a poc i fixa't en les lletres que se solen confondre: b/v, g/j, ll/y, x/s i la h.",
      },
      {
        es: "Piensa en palabras de la misma familia: si «hilo» lleva h, «hilvanar» también.",
        ca: "Pensa en paraules de la mateixa família: si «hilo» porta h, «hilvanar» també.",
      },
      {
        es: "Revisa las tildes: una tilde que falta o sobra también es un error ortográfico.",
        ca: "Revisa els accents: un accent que falta o sobra també és un error ortogràfic.",
      },
    ],
    faq: [
      {
        q: {
          es: "¿Cuántas preguntas de ortografía hay en el examen de Auxiliar del Estado?",
          ca: "Quantes preguntes d'ortografia hi ha a l'examen d'Auxiliar de l'Estat?",
        },
        a: {
          es: "En los exámenes de 2024 y 2025 hubo 3 preguntas de «señale la palabra con error» dentro de las 30 psicotécnicas.",
          ca: "Als exàmens del 2024 i el 2025 hi va haver 3 preguntes de «assenyali la paraula amb error» dins de les 30 psicotècniques.",
        },
      },
    ],
  },
  {
    type: "synonyms",
    slug: "sinonimos",
    title: {
      es: "Test de sinónimos gratis para oposiciones",
      ca: "Test de sinònims castellans gratis",
    },
    description: {
      es: "Ejercicios de sinónimos con las listas del diccionario de la RAE, como en el psicotécnico de Auxiliar del Estado. Gratis y con la explicación de cada respuesta.",
      ca: "Exercicis de sinònims castellans amb les llistes del diccionari de la RAE, com al psicotècnic d'Auxiliar de l'Estat. Gratis i amb l'explicació de cada resposta.",
    },
    intro: {
      es: "Elige la palabra que significa lo mismo. La respuesta correcta está en la lista de sinónimos del Diccionario de la lengua española y ninguna otra opción lo está.",
      ca: "Tria la paraula que vol dir el mateix. La resposta correcta és a la llista de sinònims del Diccionario de la lengua española i cap altra opció no hi és.",
    },
    method: [
      {
        es: "Piensa una frase con la palabra y prueba a cambiarla por cada opción.",
        ca: "Pensa una frase amb la paraula i prova de canviar-la per cada opció.",
      },
      {
        es: "Cuidado con el antónimo: suele aparecer entre las opciones como trampa.",
        ca: "Compte amb l'antònim: sol aparèixer entre les opcions com a parany.",
      },
      {
        es: "Si dudas, descarta primero las palabras que no tienen nada que ver.",
        ca: "Si dubtes, descarta primer les paraules que no hi tenen res a veure.",
      },
    ],
    faq: [
      {
        q: {
          es: "¿De dónde salen los sinónimos?",
          ca: "D'on surten els sinònims?",
        },
        a: {
          es: "Del apartado «Sinónimos o afines» del Diccionario de la lengua española (RAE-ASALE), comprobado palabra por palabra.",
          ca: "De l'apartat «Sinónimos o afines» del Diccionario de la lengua española (RAE-ASALE), comprovat paraula per paraula.",
        },
      },
    ],
  },
  {
    type: "antonyms",
    slug: "antonimos",
    title: {
      es: "Test de antónimos gratis para oposiciones",
      ca: "Test d'antònims castellans gratis",
    },
    description: {
      es: "Ejercicios de antónimos con las listas del diccionario de la RAE, como en el psicotécnico de Auxiliar del Estado. Gratis y con la explicación de cada respuesta.",
      ca: "Exercicis d'antònims castellans amb les llistes del diccionari de la RAE, com al psicotècnic d'Auxiliar de l'Estat. Gratis i amb l'explicació de cada resposta.",
    },
    intro: {
      es: "Elige la palabra de significado contrario. La respuesta correcta está en la lista de antónimos del Diccionario de la lengua española y ninguna otra opción lo está.",
      ca: "Tria la paraula de significat contrari. La resposta correcta és a la llista d'antònims del Diccionario de la lengua española i cap altra opció no hi és.",
    },
    method: [
      {
        es: "Piensa qué significa la palabra y busca la opción que diga lo contrario.",
        ca: "Pensa què vol dir la paraula i busca l'opció que digui el contrari.",
      },
      {
        es: "Cuidado con el sinónimo: suele aparecer entre las opciones como trampa.",
        ca: "Compte amb el sinònim: sol aparèixer entre les opcions com a parany.",
      },
      {
        es: "Los prefijos in-, des- y a- dan pistas, pero no siempre forman el antónimo.",
        ca: "Els prefixos in-, des- i a- donen pistes, però no sempre formen l'antònim.",
      },
    ],
    faq: [
      {
        q: {
          es: "¿Cuántas preguntas de sinónimos y antónimos hay en el examen?",
          ca: "Quantes preguntes de sinònims i antònims hi ha a l'examen?",
        },
        a: {
          es: "En el examen de Auxiliar del Estado de 2025 hubo 6 y en el de 2024, 5, dentro de las 30 psicotécnicas.",
          ca: "A l'examen d'Auxiliar de l'Estat del 2025 n'hi va haver 6 i al del 2024, 5, dins de les 30 psicotècniques.",
        },
      },
    ],
  },
];

export const psychoGuides = (): PsychoGuide[] => G;
export const psychoGuideBySlug = (slug: string) => G.find((g) => g.slug === slug);
export const psychoGuideByType = (type: string) => G.find((g) => g.type === type);
export const tr = (l: L, locale: string) => (locale === "ca" ? l.ca : l.es);
