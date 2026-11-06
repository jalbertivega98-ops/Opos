/**
 * Banco verbal comprobado en el Diccionario de la lengua española (RAE-ASALE),
 * dle.rae.es, el 6/11/2026 (ADR-040).
 *
 * - `DLE_SYNONYMS`: una línea por entrada, «palabra:sinónimos;antónimos», con
 *   las listas de sinónimos y antónimos que el DLE muestra para la entrada
 *   (todas sus acepciones, en el orden del diccionario, solo palabras sueltas).
 * - `SPELLING_PAIRS`: [forma correcta, forma errónea]. Cada forma correcta
 *   existe en el DLE y cada forma errónea da «no está en el Diccionario».
 *
 * No se usan las palabras de los exámenes reales del INAP.
 */
export const DLE_SYNONYMS = `
abundante:rico,pletórico,prolífico,fértil,fecundo,copioso,cuantioso,profuso,numeroso,pingüe,opimo;escaso
acabar:terminar,concluir,finiquitar,rematar,ultimar,culminar,liquidar,consumar,apurar,gastar,agotar,consumir,asesinar,eliminar,victimar,pasaportar,tumbar,limpiar,perecer,ir,sonar;empezar,iniciar,principiar,comenzar,emprender
acertado:adecuado,pertinente,conveniente,oportuno,apropiado;erróneo,errado,desacertado,inadecuado,inoportuno
adversidad:infortunio,desgracia,desventura,malaventura,calamidad,desdicha,infelicidad,contratiempo,percance,revés,tropiezo,fatalidad,hostilidad,enemistad;felicidad,dicha,suerte,fortuna
afable:agradable,amable,atento,cortés,gentil,dulce,cordial,campechano;antipático,descortés,desabrido
afligir:entristecer,apesadumbrar,apenar,atribular,acongojar,angustiar,atormentar,amargar,desconsolar,consternar,doler,abatir,desolar,preocupar,inquietar,mortificar,lacerar,molestar,maltratar,dañar,sufrir;animar,alegrar,consolar,tranquilizar
ágil:rápido,veloz,ligero,vivo,diligente,resuelto,listo,activo,sutil,raudo,dinámico,pronto,expedito,enérgico,desembarazado,eficaz;lento,torpe,pesado
agradable:grato,atractivo,atrayente,satisfactorio,ameno,placentero,entretenido,bueno,delicioso,deleitoso,chévere,sabroso,afable,amable,atento,simpático,afectuoso,encantador,adorable,tratable,entrador;desagradable,antipático
alegre:contento,jovial,jubiloso,animado,divertido,vivaracho,festivo,alborozado,vivo,chillón,luminoso,vistoso,alumbrado,calamocano,chirlomirlo,picado,achichado,cachudo;triste,afligido,apenado,apagado
altivo:altanero,arrogante,soberbio,orgulloso,presuntuoso,engreído,petulante,presumido,encastillado,encrestado;humilde,modesto
amable:afable,agradable,cordial,cortés,atento,benévolo,tratable,encantador,simpático,cariñoso,afectuoso;desabrido,rudo,grosero,antipático,desagradable
ambiguo:confuso,equívoco,anfibológico,incierto,indeterminado,dudoso,oscuro,misterioso;claro,preciso
amplio:extenso,dilatado,espacioso,grande,holgado,vasto;escaso,reducido,estrecho
ancho:holgado,grande,espacioso,extenso,dilatado,anchura,grosor,espesor,orgulloso,satisfecho,ufano;estrecho
anciano:viejo,vetusto,provecto,abuelo,matusalén,vejestorio,carcamal,carroza,senecto,awicho;joven
apacible:afable,dócil,tranquilo,agradable,pacífico,manso,plácido,dulce,sosegado,relajado,quieto,benigno,sereno,reposado,templado,suave,calmo,placentero;desagradable,hosco,desabrido,desapacible,destemplado
apático:indiferente,indolente,abúlico,acostadote,dejado,descuidado,desidioso,linfático;apasionado
árido:seco,desierto,desértico,estéril,baldío,yermo,infecundo,improductivo,incultivable,aburrido,pesado,molesto,fastidioso,tedioso,enfadoso,estomagante,cansado,farragoso;húmedo,ameno,divertido
arrogante:altanero,soberbio,altivo,engreído,orgulloso,presumido,presuntuoso,insolente,envarado,petulante,vanidoso,chulo,gallito,inmodesto,imperioso,creído,encopetado,chuleta,fachendoso,valiente,valeroso,bizarro,brioso,gallardo,garboso,apuesto,elegante,distinguido,saleroso,galán,majo,donoso,desenvuelto;humilde,modesto
ascender:subir,elevar,levantar,alzar,remontar,trepar,escalar,promover,progresar,mejorar,adelantar,encaramar,montar,sumar;descender,degradar
audaz:osado,atrevido,intrépido,valeroso,arrojado,valiente,arrestado,brioso,resuelto,decidido,determinado,bizarro,denodado,temerario,arriesgado,aventado,insolente,descarado,desvergonzado,procaz,desfachatado,descocado;indeciso,cobarde
austero:severo,rigorista,rígido,riguroso,estricto,serio,grave,sobrio,moderado,continente,espartano,parco,templado,frugal,mesurado,prudente,económico,ahorrativo,reflexivo,puritano,temperado,penitente;ostentoso,lujoso
avaro:codicioso,ávido,ambicioso,tacaño,agarrado,mezquino,cicatero,ruin,miserable,mísero,estrecho,roñica,cutre,roñoso;generoso,desprendido
benévolo:benevolente,bondadoso,generoso,afectuoso,benigno,liberal,afable,compasivo,magnánimo,clemente,indulgente,apacible,condescendiente,complaciente,chévere;malévolo,maligno
bondad:benevolencia,benignidad,generosidad,magnanimidad,tolerancia,afabilidad,amabilidad,cordialidad,apacibilidad,dulzura,ternura,suavidad,docilidad,mansedumbre;maldad,malicia,perversidad,aspereza,desabrimiento
breve:corto,reducido,limitado,pequeño,sucinto,conciso,lacónico,escueto,efímero,momentáneo,pasajero,transitorio,perecedero,precario,temporal,fugaz,exiguo;largo,extenso,duradero
brusco:rápido,repentino,súbito,inesperado,imprevisto,antipático,violento,arisco,hosco,bronco,rudo,áspero,grosero,descortés;lento,suave,apacible
calma:paz,tranquilidad,quietud,reposo,sosiego,placidez,cesación,suspensión,bonanza,escampada,serenidad,apacibilidad,clara,flema,indolencia,parsimonia,apatía,lentitud,cachaza,pachorra;intranquilidad,agitación,rapidez,presteza
cándido:candoroso,ingenuo,crédulo,incauto,inocente,párvulo,sencillo,simple,panoli,níveo,cano;astuto,malicioso,pícaro
caos:desorden,confusión,embrollo,vorágine,anarquía,entropía,desorganización,enredo,desconcierto,berrodo,burundanga,lío;orden,organización,claridad
caro:costoso,preciado,oneroso,gravoso,inasequible,prohibitivo,valioso,precioso,ruinoso,querido,estimado;barato,económico
célebre:conocido,popular,famoso,afamado,nombrado,renombrado,reputado,eminente,ilustre,eximio,glorioso;desconocido,mediocre
claro:luminoso,brillante,iluminado,vivo,resplandeciente,ventana,luz,despejado,raso,pálido,blanquecino,transparente,limpio,límpido,cristalino,diáfano,nítido,desembarazado,amplio,dilatado,hueco,ralo,preciso,definido,comprensible,inteligible,entendible,indudable,evidente,obvio,manifiesto,visible,notorio,patente,palmario,ostensible,franco,sincero,directo,honesto,perspicaz,agudo,sagaz,clarividente,argentino,ilustre,noble,esclarecido,preclaro,famoso,insigne,reputado,destacado,espacio,espaciado,albumen,albúmina,ciertamente,evidentemente,manifiestamente;oscuro,sombrío,sombra,sombreado,nublado,turbio,sucio,borroso,confuso,ininteligible,enrevesado,dudoso,discutible,incierto,retorcido,solapado,torpe,obtuso,espeso,cargado,tupido
cobarde:pusilánime,temeroso,apocado,medroso,miedoso,encogido,amilanado,gallina,miedica,cobardica,cagado,cagón,cagueta;valiente,atrevido
codicia:avaricia,usura,miseria,ruindad,deseo,anhelo,ambición,avidez,afán,angurria;desinterés,desprendimiento
cómodo:confortable,agradable,placentero,descansado,manejable,desahogado,holgado,acomodado,vago,haragán,despreocupado,perezoso,cuña,orinal,bacín;incómodo
compasión:condolencia,conmiseración,compunción,lástima,ternura,piedad,misericordia,caridad,clemencia,solidaridad,humanidad;impiedad,insensibilidad
conciso:breve,escueto,lacónico,parco,sucinto,sobrio,preciso,corto;prolijo,extenso
conocido:famoso,popular,afamado,célebre,ilustre,insigne,nombrado,renombrado,distinguido,notable,prestigioso,amigo,relaciones;desconocido
constante:tenaz,perseverante,persistente,firme,insistente,tesonero,empeñoso,continuo,incesante,ininterrumpido;inconstante,irregular,variable
contento:alegre,gozoso,alborozado,jubiloso,satisfecho,feliz,risueño,divertido,encantado,ufano,orgulloso,jovial,alegría,gozo,alborozo,júbilo,satisfacción,felicidad,dicha,exultación,entusiasmo,ufanía,orgullo,jovialidad;triste,descontento,achantado,insatisfecho,tristeza,pena,desolación
cortés:atento,caballeroso,educado,comedido,afable,cordial,amable,obsequioso,correcto,fino,cariñoso,considerado,delicado;descortés,maleducado
cruel:violento,sangriento,desalmado,despiadado,inhumano,brutal,bárbaro,feroz,atroz,sádico,sanguinario,salvaje,lacerante,insufrible,insoportable;compasivo,humano
culto:educado,instruido,docto,sabio,ilustrado,erudito,cultivado,civilizado,ritual,liturgia,rito,ceremonia,veneración,adoración,reverencia,devoción;inculto,ignorante
débil:delicado,decaído,flojo,frágil,enclenque,endeble,desmadejado,exánime,blandengue,cobarde,tímido,pusilánime,inseguro,timorato,blando;fuerte,resistente,robusto,enérgico,intenso,potente,férreo,impasible
decadencia:ocaso,caída,descenso,retroceso,degeneración,disminución,deterioro,debilitación;auge,apogeo,esplendor
decente:casto,decoroso,recatado,íntegro,pudoroso,púdico,moral,modesto,digno,honesto,honrado,honorable,respetable,pundonoroso,noble,aseado,limpio,curioso;indecente,impúdico,indecoroso,inmoral,deshonesto,indigno
delgado:flaco,enjuto,magro,escuchimizado,consumido,esquelético,esbelto,fino,ligero,menudo,tenue,delicado,sutil,suave,grácil;gordo,grueso
denso:compacto,espeso,tupido,concentrado,apelmazado,oscuro,confuso,incomprensible,difícil;fluido,suelto,ligero,sencillo
desidia:negligencia,abandono,descuido,dejadez,holgazanería,vagancia,pereza,desgana,inapetencia,desinterés,abulia,incuria,boludencia;cuidado,diligencia
diestro:derecha,hábil,experto,ducho,versado,avezado,experimentado,curtido,perito,entendido,sagaz,inteligente,canchero,ácido,torero,espada,matador,estoqueador,lidiador,toreador,rejoneador;izquierdo,siniestro,izquierda,siniestra,zurda,zurdo,inexperto,inhábil,torpe
diligente:rápido,presto,resuelto,expeditivo,veloz,expedito,dinámico,vivo,listo,ágil,aplicado,eficiente,eficaz,solícito,dispuesto,aprovechado,cumplidor,laborioso,cuidadoso,hacendoso,activo,oficioso;lento,tardo,negligente,descuidado
discreto:mesurado,reservado,juicioso,prudente,comedido,sensato,circunspecto,ponderado,razonable,prudencial,módico,moderado;indiscreto,insensato,llamativo,exagerado,excesivo
dócil:sumiso,manso,disciplinado,maleable,dúctil,accesible,afable;rebelde,desobediente,indócil
efímero:pasajero,fugaz,breve,temporal,transitorio,momentáneo,perecedero,caduco,corto,fugitivo,temporario;duradero,perdurable,eterno
elocuente:expresivo,retórico,significativo,convincente,conmovedor,seductor;inexpresivo,lacónico
empezar:emprender,principiar,originar,aparecer,arrancar,asomar,nacer,surgir;acabar,terminar,finalizar
enorme:inmenso,gigantesco,grandioso,colosal,descomunal,inconmensurable,vasto,mastodóntico,mayúsculo,monumental,formidable,extraordinario,excepcional,desmedido,desmesurado,atroz,espantoso,monstruoso,terrible;pequeño,diminuto,minúsculo,nimio
entusiasmo:apasionamiento,pasión,exaltación,emoción,arrebato,arrebatamiento,fogosidad,enardecimiento,vehemencia,frenesí,ánimo,afán,ardor,calor,admiración,fervor,entrega,interés,empeño;apatía,frialdad,desinterés
escaso:exiguo,insuficiente,limitado,pobre,parvo,corto,apretado;abundante,copioso,cuantioso,amplio,sobrado,largo
espeso:denso,pastoso,consistente,cuajado,tupido,frondoso,boscoso,cerrado,apretado,compacto,amazacotado,macizo,sólido,grueso,voluminoso,pesado,molesto;claro,ralo,delgado,fino
estéril:yermo,infértil,improductivo,infecundo,árido,horro,machorro,aséptico;fértil,fecundo,productivo
eterno:eternal,perpetuo,imperecedero,interminable,inmortal,perenne,constante;finito,perecedero,pasajero,fugaz,efímero
euforia:alegría,entusiasmo,optimismo,satisfacción,vehemencia,ímpetu,ardor;abatimiento,desaliento
evidente:obvio,incuestionable,indiscutible,irrebatible,cierto,claro,manifiesto,notorio,ostensible,palmario,visible,patente,franco;dudoso,discutible
exacto:preciso,justo,concreto,específico,correcto,cabal,cierto,fiel,puntual,verdadero,riguroso,fielmente,cabalmente;inexacto,impreciso
excéntrico:extravagante,raro,estrafalario,estrambótico,singular,original,maniático,descentrado,desplazado;normal,corriente,común
exiguo:escaso,insuficiente,corto,reducido,pequeño,mínimo;abundante,cuantioso
expandir:esparcir,agrandar,dilatar,ensanchar,extender,ampliar,expansionar,difundir,divulgar,propagar,propalar;reducir,encoger,contraer
fácil:sencillo,asequible,simple,comprensible,claro,elemental,tirado,chupado,probable,posible,tratable,dócil,manejable;difícil,complicado,complejo,improbable,intratable,difícilmente
fértil:fecundo,prolífico,fructífero,feraz,opimo,productivo,ubérrimo,exuberante;infértil,estéril,infecundo,árido
feroz:fiero,bravo,bravío,cruel,despiadado,atroz,violento,salvaje,inhumano,bestial,bárbaro,enorme,inmenso,descomunal,extraordinario;manso,inofensivo,amable
firme:resistente,estable,fuerte,consistente,sólido,duro,seguro,fijo,calzada,asfalto,suelo,pavimento,piso,inmutable,inalterable,inamovible,imperturbable,constante,impávido,definitivo;inestable,tambaleante,vacilante,voluble,variable,frágil
flexible:dúctil,elástico,maleable,blando,tolerante,transigente,comprensivo,permisivo,acomodaticio,dócil,sumiso,obediente,aguantón;inflexible,rígido,duro,intolerante,severo
fortuna:destino,fario,sino,hado,azar,ventura,dinero,hacienda,patrimonio,capital,caudal,plata;infortunio,desventura,fracaso
frágil:quebradizo,endeble,delicado,débil,enclenque,flojo,desmadejado;fuerte,resistente,duro
franco:sincero,veraz,libre,despejado,expedito,desembarazado,evidente,claro,obvio,manifiesto,notorio,patente,ostensible,palmario,visible;falso,hipócrita,agazapado
frugal:parco,sobrio,discreto,escueto,comedido,moderado,austero,mesurado,templado,ligero;glotón,tragón,opíparo,copioso
fuerte:vivo,penetrante,sano,robusto,duro,recio,firme,resistente,férreo,compacto,consistente,sólido,granítico,berroqueño,fortín,fortaleza,fortificación,alcazaba,vigoroso,potente,forzudo,hercúleo,fornido,corpulento,musculoso,nervudo,agarrado,ñeque,tenaz,entero,sereno,animoso,enérgico,impetuoso,valiente,bizarro,influyente,impactante;débil,flojo,enfermo,frágil,blando,endeble,enclenque,pusilánime,apocado
generoso:dadivoso,desprendido,espléndido,desinteresado,liberal,pródigo,rumboso,fértil,fecundo,rico,productivo,altruista,magnánimo,abundante,amplio;tacaño,egoísta,escaso,pobre
gentil:infiel,idólatra,apuesto,gallardo,garboso,donoso,galán,bizarro,elegante,chango,amable,cortés,atento,educado,correcto,urbano;feo,desgarbado,grosero,descortés
gozo:alegría,contento,deleite,felicidad,placer,gusto,gustazo,disfrute,deleitación,satisfacción,goce,gozada,regalo,complacencia,fruición,voluptuosidad;tristeza,pesar,dolor,disgusto,amargura
grato:agradable,placentero,gustoso,amable,satisfactorio,ameno;desagradable,ingrato
honesto:honrado,decente,recto,probo,íntegro,justo,intachable,irreprochable,honorable,cumplidor,decoroso,casto,pudoroso,puro,púdico,recatado;deshonesto
hostil:contrario,enemigo,adverso,desfavorable,rival,adversario;amigable
humilde:modesto,sencillo,llano,recatado,plebeyo,proletario,pobre,pequeño,diminuto;soberbio,vanidoso,arrogante,altivo,altanero
ileso:indemne,incólume,salvo,intacto;herido,dañado,perjudicado
impetuoso:rápido,violento,vertiginoso,enérgico,fuerte,veloz,fogoso,vehemente,vivo,impulsivo,irreflexivo,ardiente,ardoroso,arrebatado,febril,irrefrenable;tranquilo,suave,reflexivo,prudente
incierto:dudoso,impreciso,vago,borroso,inseguro,eventual,vacilante,titubeante,desconocido,falso;seguro,sabido,conocido,cierto
indolente:perezoso,vago,haragán,gandul,descuidado,negligente,dejado,abandonado,desidioso,apático,abúlico,insensible,impasible,inconmovible,frío;laborioso,afanoso
ingenuo:inocente,cándido,candoroso,crédulo,incauto,párvulo,bobo;retorcido,malicioso,pícaro
inmenso:enorme,descomunal,colosal,gigantesco,grandioso,exorbitante,monumental,infinito,ilimitado,incalculable,incontable,innumerable,inmensurable;minúsculo,diminuto
insípido:soso,desabrido,desaborido,chirle,inexpresivo,anodino,insulso,insustancial;
íntegro:entero,completo,intacto,absoluto,pleno,total,decente,honesto,probo,recto,intachable,honorable,honrado,irreprochable,incorruptible,insobornable;incompleto,deshonesto,inmoral,corrupto
inútil:inservible,ineficaz,infructuoso,vano,inane,baldío,ruco,inepto,incompetente,incapaz;útil,eficaz,productivo,efectivo
jovial:alegre,contento,gracioso,divertido,bromista,vivaz,animado,vivaracho,festivo,risueño,ameno;triste,apagado
júbilo:regocijo,algazara,alborozo,entusiasmo,exultación,exaltación,alegría,felicidad,contento,gozo,placer;tristeza,pena
lacónico:conciso,escueto,parco,breve,sobrio,sucinto,lacón;locuaz,verboso
leal:fiel,noble,amigo,franco,adepto,devoto,incondicional,seguidor,partidario,fanático,honrado,honesto,fidedigno,legal;desleal
lento:pausado,parsimonioso,tardo,tranquilo,calmoso,pesado,flemático,tardón,cachazudo,pausadamente;rápido,veloz
lícito:justo,autorizado,legal,auténtico;ilícito
locuaz:hablador,charlatán,parlanchín,bocazas;silencioso,callado
lozano:saludable,sano,lustroso,vigoroso,joven,rozagante,frondoso,verde,exuberante,lujuriante;marchito,mustio,lacio
lúcido:inteligente,perspicaz,sagaz,agudo,clarividente,sutil,sensato,brillante,resplandeciente,rutilante,refulgente,reluciente;simple,torpe
lujoso:suntuoso,fastuoso,opulento,ostentoso,pomposo,profuso,regio,magnífico;sencillo,sobrio
manso:finca,afable,reposado,benigno,dócil,tranquilo,apacible,sosegado,templado,suave,amaestrado,doméstico,cabestro;indómito,rebelde,salvaje,bravo,fiero
mezquino:ruin,avariento,avaro,avaricioso,cicatero,miserable,roñoso,egoísta;generoso,liberal,dadivoso,espléndido
minucioso:meticuloso,perfeccionista,detallista,cuidadoso,concienzudo,escrupuloso,riguroso,puntilloso,quisquilloso,esmerado;
modesto:humilde,sencillo,sobrio,llano,tímido,pobre,austero,moderado,escaso,pequeño,insignificante,irrelevante,nimio,baladí,recatado,pudoroso,decente,honesto,púdico,decoroso;inmodesto,vanidoso,soberbio,arrogante,altivo,altanero
mustio:marchito,lacio,lánguido,seco,triste,melancólico,apagado,decaído,abatido,mohíno,deprimido;lozano,vigoroso,fresco,alegre,animado
necio:ceporro,ignorante,palurdo,zote,tonto,bobo,estúpido,inepto,zoquete,zopenco,burro;culto,sabio,inteligente,listo
negligente:distraído,despistado,desidioso,olvidadizo,perezoso,vago,holgazán,indolente,apático,abúlico,acostadote;cuidadoso,diligente,activo,entusiasta
noble:bondadoso,leal,honrado,honesto,sincero,franco,generoso,desinteresado,magnánimo,liberal,ilustre,distinguido,preclaro,honorable,aristócrata,señor,patricio,príncipe,duque,marqués,conde,vizconde,barón,hidalgo,caballero,dama,infanzón,ricohombre,linajudo,refinado,fino,selecto,escogido,señorial;plebeyo,villano,innoble,vil
nocivo:dañino,perjudicial,pernicioso,dañoso,malo,malsano;inocuo,beneficioso,positivo
novato:principiante,primerizo,novel,bisoño,inexperto,nuevo;veterano,experto
obediente:cumplidor,bienmandado,dócil,disciplinado,sumiso;desobediente,rebelde
obstinado:tenaz,cerril,empecinado,pertinaz,firme,porfiado,terco,testarudo,tozudo,retobado,cabezudo,cabezón,cabezota;flexible,transigente
ocioso:desocupado,inactivo,perezoso,holgazán,vago,indolente,haragán,gandul,inútil,innecesario,vano,estéril,nulo;trabajador,ocupado,diligente,activo,útil,provechoso
opulento:rico,acaudalado,adinerado,pudiente,millonario,capitalista,lujoso,suntuoso,ostentoso,fastuoso,exuberante,copioso;pobre
orgullo:satisfacción,enorgullecimiento,ufanía,vanidad,presunción,engreimiento,petulancia,ínfulas,suficiencia,endiosamiento,pedantería,arrogancia,soberbia,altanería,altivez,autoestima,dignidad,pundonor,honra;vergüenza,insatisfacción,humildad,modestia
osado:atrevido,audaz,intrépido,arrojado,decidido,resuelto,valiente;cobarde,indeciso,prudente
pacífico:quieto,reposado,sosegado,tranquilo,manso,sereno;inquieto,violento,belicoso
pálido:descolorido,blanquecino,lívido,amarillento,abuhado,macilento,cadavérico,berrejo,desvaído,apagado,desmayado;
parco:escaso,exiguo,corto,escueto,lacónico,mirado,frugal,moderado,sobrio,templado;generoso,glotón,tragón
perenne:eterno,perpetuo,imperecedero,perdurable,permanente,constante,perennifolio;pasajero,transitorio,caduco
perezoso:desganado,desidioso,vago,holgazán,indolente,negligente,haragán,dejado,apático,descuidado,remolón,acostadote,gandul,lento,tardo,pausado,parsimonioso,balance,comadrita;diligente,trabajador,ágil,rápido
pertinaz:obstinado,empecinado,terco,testarudo,tozudo,cerril,tenaz,porfiado,cabezón,cabezudo,persistente,permanente,prolongado,duradero,incesante,ininterrumpido,perenne,perdurable;flexible,transigente,breve
plácido:apacible,sosegado,sereno,tranquilo,calmo,manso,suave;agitado
pobre:necesitado,indigente,miserable,menesteroso,pelado,humilde,desamparado,infortunado,varado,pordiosero,escaso,insuficiente,bajo,corto,exiguo,falto,parco,modesto,sencillo,llano,infeliz,desgraciado,desdichado,desventurado;rico,adinerado,acaudalado,abundante,lujoso,afortunado,dichoso
preciso:nítido,claro,minucioso,detallista,conciso,riguroso,exacto,estricto,concreto,determinado,específico,cierto,matemático,necesario,imprescindible,indispensable,conveniente,esencial,básico,útil,obligatorio,urgente,vital;impreciso,inexacto,inconcreto,indeterminado,innecesario,superfluo
pródigo:derrochador,despilfarrador,dilapidador,malgastador,generoso,liberal,desprendido,dadivoso,espléndido,productivo,fértil,fecundo,prolífico,abundante;ahorrador,tacaño,improductivo,estéril,yermo
prudente:sensato,juicioso,cauteloso,precavido,reflexivo,razonable,comedido,discreto,moderado;imprudente,insensato
pulcro:aseado,limpio,atildado,prolijo,cuidadoso,delicado,escrupuloso,esmerado;sucio,desaseado,descuidado
puntual:escrupuloso,diligente,metódico,formal,cumplidor,exacto,preciso,minucioso,ocasional,eventual,circunstancial,accidental,casual,esporádico,fortuito;impuntual,informal,dudoso,habitual,general
quieto:parado,detenido,inmóvil,estático,sedentario,apacible,pacífico,relajado,calmado,sereno,sosegado,tranquilo,reposado;nervioso,inquieto,intranquilo
raudo:rápido,veloz,diligente,pronto,vivo,presuroso,vertiginoso,presto;lento
rebelde:insurrecto,insurgente,amotinado,sedicioso,subversivo,insubordinado,levantisco,contumaz,desobediente,indisciplinado,indómito,indomable,indócil,insumiso,díscolo,inconformista,contestatario,reacio;sumiso,dócil
recio:fuerte,robusto,vigoroso,forzudo,musculoso,nervudo,firme,duro,rígido,poderoso,agarrado,grueso,macizo,sólido,riguroso,áspero,desagradable,intenso,violento,vigorosamente,fuertemente,poderosamente;débil,endeble,fino,suave,templado,benigno
reacio:remiso,hostil,reticente,resistente,renuente,contrario,refractario,indócil,adverso,rebelde,opuesto;propenso,partidario
rígido:inflexible,duro,tieso,agarrotado,firme,erecto,yerto,estricto,severo,austero,inconmovible;flexible,elástico,comprensivo
robusto:fuerte,fornido,corpulento,macizo,recio,duro,vigoroso,hercúleo,saludable,sano,ñeque,morocho;endeble,débil,frágil,enclenque,enfermizo
sagaz:astuto,perspicaz,agudo,sutil,ladino,despierto,espabilado,despabilado,inteligente,listo,vivo,avispado,clarividente,intuitivo,imaginativo,lince,artero,taimado,abusado;ingenuo,bobo
salubre:saludable,sano,salutífero;insalubre
sabio:inteligente,erudito,docto,culto,ilustrado,versado,letrado,experto,perito,enterado,listo,prudente,sensato,juicioso;ignorante
sencillo:fácil,asequible,elemental,simple,chupado,factible,sobrio,discreto,austero,mondo,natural,espontáneo,campechano,llano;difícil,complicado,complejo,elaborado,doble,ostentoso,artificioso,afectado
sereno:apacible,quieto,relajado,sosegado,tranquilo,calmoso,plácido,entero,flemático,estoico,firme,imperturbable,sobrio,abstemio,frugal,parco,despejado,estable,relente,rocío,intemperie,helada,escarcha,vigilante,guardián;inquieto,nervioso,borracho,nublado
severo:adusto,seco,agrio,serio,rígido,inflexible,estricto,intransigente,exigente,austero,fregado,extremo,crudo,recio,riguroso,duro;afable,flexible,tolerante,transigente,suave
sincero:franco,verdadero,veraz,honrado,claro,directo,espontáneo,natural,abierto,efusivo,cordial,noble,leal,limpio,confiado,serio,ingenuo,inocente;mentiroso,falso,hipócrita,insincero
sobrio:moderado,mesurado,prudente,comedido,contenido,sensato,parsimonioso,serio,circunspecto,sereno,sencillo,formal,austero,abstemio,frugal,parco;exagerado,excesivo,desmedido,ebrio
soez:grosero,vil,chabacano,basto,bajo,ordinario,lépero;fino,refinado,cortés,educado
sosiego:calma,serenidad,tranquilidad,quietud,paz,placidez,reposo,relajación;desasosiego,intranquilidad,agitación
sumiso:obediente,subordinado,dócil,rendido;
tacaño:cicatero,roñoso,ruin,avariento,avaricioso,avaro,miserable,mísero;generoso,desprendido,espléndido
taciturno:callado,silencioso,reservado,chamicado,retraído,triste,melancólico,lúgubre,apesadumbrado;comunicativo,locuaz,alegre
temerario:imprudente,insensato,irreflexivo,atrevido,osado,audaz,arriesgado,aventurado;prudente,sensato
tenaz:perseverante,constante,firme,persistente,incansable,pertinaz,porfiado,testarudo,obstinado,terco,fuerte,resistente,consistente,irrompible,indeformable;inconstante
tibio:suave,moderado,indiferente,frío,desapasionado;apasionado,entusiasta
tímido:cohibido,retraído,timorato,vergonzoso,corto,pacato,cobardica;resuelto,lanzado
tosco:basto,rudimentario,ordinario,grosero,chabacano,desatento,descortés,maleducado,ineducado,malcriado,vulgar,zafio,patán,palurdo,bayunco,chuto,grencho;delicado,fino
tranquilo:imperturbable,impertérrito,flemático,relajado,parsimonioso,indolente,apático,perezoso,indiferente,frío,pacífico,reposado,sosegado,plácido,apacible,calmo,manso,quieto,sereno,amable,moderado;nervioso,intranquilo,irritable
trivial:intrascendente,banal,nimio,baladí,insignificante,frívolo,anodino,fútil,superficial,irrelevante,insustancial,vulgar,común,huero;original,extraordinario,trascendental
ufano:engreído,arrogante,presumido,jactancioso,presuntuoso,fanfarrón,vano,aguajero,alegre,contento,jubiloso,alborozado,frondoso,vigoroso;humilde,modesto,triste,timorato,indeciso
útil:práctico,apropiado,eficaz,eficiente,conveniente,provechoso,beneficioso,ventajoso,favorable,rentable,servicial,valioso,fructífero,laborable,herramienta,utensilio,instrumento,implemento;inútil,ineficaz,inhábil
vago:holgazán,perezoso,haragán,remolón,indolente,acostadote,gandul,impreciso,indeterminado,indefinido,confuso,ambiguo,equívoco;diligente,trabajador,preciso,concreto,claro,definido
valiente:valeroso,corajudo,osado,arrojado,intrépido,brioso,audaz,atrevido,animoso,denodado;cobarde
veloz:rápido,raudo,ligero,presuroso,acelerado,vertiginoso,vivo,repentino,momentáneo,súbito,ágil;lento,pausado,torpe
verídico:veraz,fidedigno,honesto,cierto,verdadero,auténtico,fiel;
verosímil:creíble,posible,probable,aceptable,admisible,veraz;inverosímil
vigoroso:fuerte,recio,robusto,macizo,hercúleo,musculoso,corpulento,enérgico,activo,vital,potente,poderoso,ñeque,agarrado;débil
voluble:inconstante,veleidoso,versátil,inestable,indeciso,veleta,variable,volátil,tornadizo,mudable,mercurial;constante,firme
zafio:grosero,tosco,basto,burdo,ordinario,chabacano,vulgar,rudo,patán,cateto,maleducado;educado,fino
`;

export const SPELLING_PAIRS: readonly (readonly [string, string])[] = [
  ["absorber", "absorver"],
  ["abuhardillado", "abuardillado"],
  ["adherir", "aderir"],
  ["advenedizo", "adbenedizo"],
  ["ahínco", "aínco"],
  ["ahuyentar", "auyentar"],
  ["alhaja", "alaja"],
  ["amnistía", "anmistía"],
  ["anhelo", "anelo"],
  ["arbitrio", "arvitrio"],
  ["atenuar", "athenuar"],
  ["avalancha", "abalancha"],
  ["bisturí", "visturí"],
  ["boicot", "voicot"],
  ["bravucón", "bravugón"],
  ["cohibir", "coibir"],
  ["cónyuge", "cónyugue"],
  ["convalecer", "combalecer"],
  ["deshabitado", "desabitado"],
  ["desahucio", "desaucio"],
  ["desavenencia", "desabenencia"],
  ["disyuntiva", "disjuntiva"],
  ["divagar", "dibagar"],
  ["efervescencia", "efervesencia"],
  ["enhebrar", "enebrar"],
  ["envergadura", "enbergadura"],
  ["espontáneo", "expontáneo"],
  ["estrafalario", "extrafalario"],
  ["exhalar", "exalar"],
  ["exhausto", "exausto"],
  ["extravagante", "estravagante"],
  ["exiguo", "esiguo"],
  ["garabato", "garavato"],
  ["hendidura", "endidura"],
  ["hilvanar", "hilbanar"],
  ["hojarasca", "ojarasca"],
  ["huésped", "güésped"],
  ["inherente", "inerente"],
  ["inhóspito", "inóspito"],
  ["inmersión", "inmerción"],
  ["jengibre", "gengibre"],
  ["mohíno", "moíno"],
  ["obcecado", "obsecado"],
  ["orfebre", "orfevre"],
  ["prohibir", "proibir"],
  ["proveer", "probeer"],
  ["sobrevivir", "sobrebivir"],
  ["subvención", "subención"],
  ["taxativo", "tasativo"],
  ["tejemaneje", "tegemaneje"],
  ["trasiego", "trasiejo"],
  ["vahído", "vaído"],
  ["vehemente", "veemente"],
  ["verosímil", "berosímil"],
  ["vigésimo", "vijésimo"],
  ["yacimiento", "llacimiento"],
  ["zozobra", "sozobra"],
  ["aterido", "haterido"],
  ["bohemio", "boemio"],
  ["exento", "exhento"],
  ["herrumbre", "errumbre"],
  ["inmiscuirse", "inmiscuirce"],
  ["perejil", "peregil"],
  ["recoger", "recojer"],
  ["ahorcar", "aorcar"],
  ["cerveza", "cervesa"],
  ["hálito", "álito"],
  ["sintaxis", "sintasis"],
  ["ojeriza", "hojeriza"],
  ["vertiginoso", "vertijinoso"],
];
