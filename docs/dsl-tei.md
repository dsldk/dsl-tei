# Indledning

	<!--2017-03-21, th, denne version af retningslinjerne for brug af DSL-basis 
	    er en ufuldstændig og ikke gennemredigeret kladde. Den bør derfor bruges
	    forsigtigt -->

Nærværende rapport definerer et basisformat for det Danske Sprog- og
Litteraturselskabs (DSL) digitale udgivelser. Med *basis* menes den
grundlæggende opmærkning, som projekternes produkter forventes at indeholde.
Formatet defineres på grundlag af de retningslinjer for opmærkning af tekst- og
metadata defineret af konsortiet Text Encoding Initiative
(<https://www.tei-c.org>).[^a] 

[^a]: [http://www.tei-c.org](http://www.tei-c.org). Den nuværende version af
  TEI's retningslinjer, TEI P5, er den femte. 'P5' refererer således til
  *Proposal 5*.

Hovedbegrundelsen for et fælles opmærkningsformat for DSL's projekter er at
skabe et fælles grundlag for de redaktører, der udfærdiger og bearbejder
teksterne og de værktøjer og procedurer, der appliceres på materialet. 

# 1 Et dsl-tei-dokument

Et dsl-tei-dokument er et XML-dokument med rodelementet `TEI` og attributtet
`@xmlns` (*XML namespace*), udfyldt med værdien `http://www.tei-c.org/ns/1.0`.
Rodelementet indholder de tre hovedkomponenter `teiHeader`, `facsimile` og
`text`.

|element   | beskrivelse                                                      |
|----------|------------------------------------------------------------------|
|teiHeader | (*TEI header*) leverer metadata til beskrivelse af den digitale ressource i bibliografisk, kodnings- og udviklingsmæssig henseende. Jf. 2 Metadata.  |
|facsimile |  indeholder en digital billedgengivelse af den tekst, der beskrives under `teiHeader` og formidles under `text`. Jf. 3 Faksimiler |
|text      |  indeholder ét værk, hvad enten dette udgøres af en tekstmæssig enhed (fx én roman, novelle, brev) eller er en helhed bestående af flere tekster (fx en samling essays, digte, noveller). Jf. 4 Tekst. |

Elementerne disponeres således: 

```xml
<TEI xmlns="http://www.tei-c.org/ns/1.0">
  <teiHeader>...</teiHeader>
  <facsimile>...</facsimile>
  <text>...</text>
</TEI>
```
# 2 Metadata

Elementet `teiHeader` samler metadata, der er nødvendige i udgivelsen af en
tekst. Disse leverer bibliografisk beskrivelse af det digitale værk, redegørelse
for anvendt praksis ved dokumentets kodning, klassifikation af sprog og genre
samt dokumentets ændringshistorik. Under `teiHeader` findes tilsvarende fire
hovedelementer:

|element          | beskrivelse   |
|-----------------|---------------|
| fileDesc        | (*file description*), indeholder komplet bibliografisk beskrivelse af dokumentets tekstdel |
| encodingDesc    | (*encoding description*), beskriver forholdet mellem den digitale tekst og kildegrundlaget |
| profileDesc     | (*text-profile description*), beskriver andre aspekter af teksten, fx sprogbrug, genre eller genstandsfelt |
| revisionDesc    | (*revision description*), indeholder opsummering af ændringer af filen |

De fire elementer fordeler sig således:

```xml
<teiHeader>
  <fileDesc>...</fileDesc>
  <encodingDesc>...</encodingDesc>
  <profileDesc>...</profileDesc>
  <revisionDesc>...</revisionDesc>
</teiHeader>
```

## 2.1 Filbeskrivelsen (`fileDesc`)

Metadatasektionens første del er `fileDesc` (_file description_), som indeholder
information til identifikation, katalogisering og fyldestgørende beskrivelse af
filen. `fileDesc` indeholder følgende elementer:

| element           | beskrivelse                                              |
|-------------------|----------------------------------------------------------|
| titleStmt        | (*title statement*), angivelse af titel, en eller flere forfattere og/eller redaktører samt evt. bevillingsgivere|
| extent           | beskriver omtrentlig størrelse på en tekst lagret på et medie (fx filstørrelse, antal ord) eller i en trykt udgivelse (fx antal sider) |
| publicationStmt  | (*publication statement*) angiver, hvem der har ansvaret for udgivelsen af den digitale tekst og vilkår for distribution af samme |
| sourceDesc       | (*source description*) beskriver den kilde, fra hvilken den digitale tekst er afledt, fx om den har digitalt eller analogt forlæg.|

### 2.1.1 Titelangivelsen

Titelangivelsen (`titleStmt`) indeholder et `title`-element, efterfulgt af et
eller flere `author`-, `editor`-, og `funder`-elementer. 

```xml
<titleStmt>
  <title>...</title>
  <author>...</author>
  <editor role="...">...</editor>
  <funder>...</funder>
</titleStmt>
```

#### 2.1.1.1 Redaktør og andre arbejdsfunktioner

Elementet `editor` bruges med attributtet `@role` til præcisering af udgivernes
redaktionelle ansvarsområder. Følgende attributværdier er tilladt:

| @role: værdi    | beskrivelse                                                               |
|-----------------|---------------------------------------------------------------------------|
| data_engineer   | Redaktører med ansvar for etablering og videre maskinel bearbejdning af data angives `<editor role="data_engineer">...</editor>` |
| digital_version   | Redaktører med ansvar for en digital version af et trykt værk angives `<editor role="digital_version">...</editor>` |
| student_assistant | studentermedhjælper optages i `<editor role="student_assistant">...</editor>` | 
| translator        | oversætter optages i `<editor role="translator">...</editor>` |
| contributor       | andre medvirkende optages i `<editor role="contributor">...</editor>` |

Elementerne kan udfyldes på følgende måde:

```xml
<titleStmt>
  <title> Mit Livs Legende </title>
  <author> Johannes Jørgensen </author>
  <editor role="digital_editor">Andersine And</editor>
  <editor role="student_assistant">Morten Vinge</editor>
  <editor role="contributor">Aage Andersen</editor>
  <editor role="data_engineer">hansen_thomas_1977</editor>
  <funder>A.P. Møller og Hustru Chastine Mc-Kinney Møllers Fond til almene Formaal</funder>
  <funder>Carlsbergfondet</funder>
</titleStmt>
```

### 2.1.2 Omfang (extent)

	<!-- skal udfyldes -->

### 2.1.3 Om udgivelsen (publicationStmt)

Udgivelsesangivelsen, `publicationStmt` (*publication statement*),
samler navn på udgiver, samt *hvor* og *hvornår* filen er publiceret.
Endelig meddeles, under hvilke vilkår den udgives. `publicationStmt`
indeholder fem elementer:

| element         | beskrivelse                                                               |
|-----------------|---------------------------------------------------------------------------|
| publisher       | udgiver. Værdien af elementet er som udgangspunkt Det Danske Sprog- og Litteraturselskab |
| pubPlace        | udgivelsessted. Grundværdien er København, DSL's hjemsted | 
| date            | udgivelsesdato angives i ISO 8601-formatet YYYY-MM-DD |
| idno            | identifikationsnummer er en unik værdi. I DD opbygget efter formen *YYYYMMDDddd*. |
| availability    | tilgængelighed. Elementet indeholder attributtet `@status` som kan have en af tre gyldige værdier:1. `free`, 2. `unknown` eller 3. `restricted`. Om udfyldelse af elementet se 2.1.3.1. |

De fem elementtyper organiseres således:

```xml
<publicationStmt>
  <publisher>Det Danske Sprog- og Litteraturselskab</publisher>
  <pubPlace>København</pubPlace>
  <date>yyyy-mm-dd</date>
  <idno></idno>
  <availability status="">...</availability>
</publicationStmt>
```

#### 2.1.3.1 Tilgængelighed

Under `availability` angives eventuelle licensforhold. 

```xml
<availability status="restricted">
  <licence n="CC BY-SA 4.0" target="http://creativecommons.org/licenses/by-sa/4.0/">
   Distributed under a Creative Commons Attribution-ShareAlike 4.0
   International License.</licence>
</availability>
```

### 2.1.4 Udgivelsens kilder (sourceDesc)

Til beskrivelse af en udgaves forlæg benyttes elementet `sourceDesc` (*source
description*) med de underordnede elementer `listWit` og `listBibl`:

| element             | beskrivelse                                       |
|---------------------|---------------------------------------------------|
| listWit             | (*witness list*) indeholder ét eller flere obligatoriske tekstvidne-elementer (`witness`). Bemærk, at hvert `witness`-element har et `@xml:id`-attribut til identifikation.  Heri indsættes en bogstavværdi, fx `A`, `B`, `C`, som fungerer som reference i tekstkritiske noter. |
| listBibl            | (*bibliographic list*), indeholder supplerende bibliografiske oplysninger kan gives i ét eller flere `bibl`-elementer |

> *Note:* En underinddeling med obligatorisk `listWit` og fakultativt
> `listBibl` sikrer, at de kilder, der konstituerer teksten, kan 
> behandles som *tekstvidner* og kan adskilles fra øvrige
> bibliografiske referencer såsom artikler og monografier og andre
> værker, som nævnes i forbindelse med udgivelsen.

Elementerne disponeres således:

```xml
	<sourceDesc>
	  <listWit>
	    <witness xml:id="A">...</witness>
	    <witness xml:id="B">...</witness>
	    ...
	  </listWit>
	  <listBibl>
	    <bibl>...</bibl>
	    <bibl>...</bibl>
	    ...
	</sourceDesc> 
```

> *Note:* Et originalt manuskript betegnes ved et stort bogstav, fx `A`.
> Et manuskript afledt af originalen `A` betegnes `Aa`, og et manuskript
> afledt af `Aa` betegnes `Aa1`. Koncepter betegnes ved små bogstaver.
> Således er et koncept til `A` betegnet ved `a`. 

#### 2.1.4.1 To anvendelser af witness-elementet

Alt efter om de anvendte tekstvidner er håndskrifter eller trykte forlæg
forsynes `witness`-elementet enten med et underordnet `bibl`- eller
`msDesc`-element:

| element     | beskrivelse              |
|-------------|--------------------------|
| bibl        | (*bibliographic citation*) indeholder en løst struktureret bibliografisk henvisning, hvis bestanddele kan opmærkes efter behov. Denne praksis benyttes typisk, når kilden er et moderne tryk, se 2.1.4.2 |
| msDesc      | (*manuscript description*) indeholder en beskrivelse af ét manuskript eller tekstbærende genstand. Denne praksis benyttes til håndskrevne kilder, inkunabler og tidlige tryk, som findes i biblioteker og arkiver. Se 2.1.4.3 |

```xml
<sourceDesc>
  <listWit>
    <witness xml:id="E">
     <bibl><title>Tychonis Brahe Astronomiæ instauratæ mechanica</title>, Wandesburgi 1598</bibl>
    </witness>
    <witness xml:id="F">
      <bibl><title>Tychonis Brahe Astronomiæ instauratæ progymnasmata</title>, Norimbergæ 1602</bibl>
    </witness>
  </listWit>
</sourceDesc>
```

#### 2.1.4.2 Beskrivelse af trykte forlæg

Et `bibl`-element indeholder en bibliografisk henvisning, som kan
struktureres efter behov. Elementet kan indeholde et `@xml:id` udfyldt
med en unik id, således at man kan referere til kilden i tekstkritiske
noter.

<!-- skal udfyldes -->

#### 2.1.4.3 Beskrivelse af håndskrifter

Til udgivelse af tekster med håndskrevne forlæg hører en beskrivelse af
håndskriftet: hvor det befinder sig, dets tilstand og historie. `msDesc`
indeholder tre elementer:

| element       |                                                 |
|---------------|-------------------------------------------------|
| msIdentifier  | (*manuscript identifier*), identifikation af håndskriftet, jf.  2.1.4.4 |
| physDesc      | (*physical description*), beskrivelse af håndskriftets fysiske tilstand, 2.1.4.5 |
| history       | en redegørelse for håndskriftets proveniens, jf. 2.1.4.6 |

Manuskriptbeskrivelsen har denne struktur:

```xml
<msDesc>
 <msIdentifier> ... </msIdentifier>
 <physDesc> ... </physDesc>
 <history> ... </history>
</msDesc>
```	

#### 2.1.4.4 Identifikation af håndskriftet (msIdentifier)

Til identifikation af et tekstvidne anvendes følgende elementer:

| element       |                                                 |
|---------------|-------------------------------------------------|
| settlement    | stedet, hvor håndskriftet opbevares |
| repository    | institutionen, som opbevarer håndskriftet |  
| idno          | standardiseret identifikation af håndskrift eller bog i en samling |

Et eksempel findes her:

```xml
<msDesc>
  <msIdentifier>
    <settlement> København </settlement>
    <repository> Det Kongelige Bibliotek</repository>
    <idno> NKS 1234 (Æbelholtbogen) </idno>
  </msIdentifier>
  ...
```
	
#### 2.1.4.5 Forlæggets fysiske tilstand 

Beskrivelsen af et tekstvidnes fysiske fremtræden leveres under elementet
`physDesc` (_physical description_) i et eller flere `ab`-elementer.[^2145]

[^2145]: Tidligere udgaver af denne specifikation har opereret med en mere
  udførlig opmærkningsmodel.


```xml
<physDesc>
  <ab>Brevkort skrevet egenhændigt af Niels Bohr. På bagsiden: <q>Hr. stud. mag. H.
      Bohr, Bredgade 62, K., København</q> og <q>Juleaften</q></ab>
</physDesc>
```

<!--falder i fire dele: 

1. `objectDesc`, beskrivelse af det fysiske objekt 
2. `handDesc`, beskrivelse af skriver, skriftform og lign. 
3. `additions`, tilføjelser til teksten
4. `sealDesc`, beskrivelse af segl

Elementerne fordeler sig således:

	<physDesc>
	  <objectDesc> ... </objectDesc>
	  <handDesc> ... </handDesc>
	  <additions> ... </additions>
	  <sealDesc> ... </sealDesc>
	</physDesc>

##### Den tekstbærende genstand (`objectDesc`)

`objectDesc` underordner elementet `supportDesc` (*support
description*) med information om den genstand, som er bærer
af teksten. Elementet har attributtet `@material` til angivelse af
objektets materiale.

	<objectDesc>
	  <supportDesc material="...">
	    ...
	  </supportDesc>
	</objectDesc>

Attributtet `@material` kan have følgende gyldige værdier:

-----------------------------------------------------------------
**Attribut: `@material`**  **Værdi**    **Betydning**
-------------------------- ------------ ---------------------------
                           mixed        objekt af blandet materiale

                           paper        objekt af papir

                           parch        objekt af pergament

                           nil          materialet uafklaret

                           empty        materialet irrelevant

-----------------------------------------------------------------


Under `supportDesc` findes tre elementer, der beskriver genstandens
materiale, fysiske mål og tilstand:

1. `support`, beskrivelse i prosaform af den tekstbærende genstand
2. `extent`, den tekstbærende genstands fysiske mål i cm
3. `condition`, den tekstbærende genstands tilstand

Her ses et eksempel på udfyldt `supportDesc` fra Diplomatarium Danicum: 

	<supportDesc material="parch">
	  <support>
	      <ab> Pergament </ab>
	  </support>
	  <extent>
	    <dimensions unit="cm">
	      <width>25</width>
	      <height>11</height>
	    </dimensions>
	  </extent>
	  <condition>
	    <ab>Beskadiget af fugt i venstre side</ab>
	  </condition>
	</supportDesc>

##### Skriftform og skriver (`handDesc`)

`handDesc`-elementet beskriver tekstvidnets skriftlige udtryk herunder
skrifttype og hvem der skrevet det. `handDesc` indeholder et 
`handNote`-element, som igen underordner et eller flere `ab`-elementer.

Eksempel:

	<handDesc>
	  <handNote>
	    <ab> Afskrift fra det 18. årh. af Langebek </ab>
	  </handNote>
	</handDesc>

##### Påskrifter og andre tilføjelser til teksten (`additions`)

Elementet `additions` indeholder angivelse af væsentlige
tilføjelser på tekstvidnet. Disse tilføjelser indskrives i et
`ab`-element således at selve tilføjelsen står i et `q`-element
(*quote*) på følgende måde:

	<additions>
	  <ab> På bagsiden påskriften: <q>Skipt</q>, derefter 
	    med anden hånd: <q>paa Raasserydh</q>
	  </ab>
	</additions>

Jf. <http://diplomatarium.dk/dokument/14070207001>

##### Seglbeskrivelse (`sealDesc`)

Ved beseglede tekstvidner beskrives seglene under elementet `sealDesc`
(*seal description*). Hvert segl har sit eget `seal`-element, som
identificeres med et nummer angivet som værdi i attributtet `@n`
(number). Seglene tælles fra venstre mod højre. I det omfang seglet i
forvejen er beskrevet i de danske seglværker, angives dette.

	<sealDesc>
	  <seal n="1" type="pendant">
	    <ab> ...</ab>
	  </seal>
	    ...
	</sealDesc>

Nedenfor ses eksempel på segl hvis pergamentsrem bærer en
påskrift, jf. Diplomatarium Danicum <http://diplomatarium.dk/dokument/14190518001>

	<seal n="1" type="pendant">
	  <ab>Bomærke af mørkt voks i perg.rem med tekst 
	    <q>allæ the gothg<damage><ex>er</ex></damage>ning<ex>e</ex> 
	      som gyørthæ æræ oc</q>
	  </ab>
	</seal>

#### 2.1.4.6 Proveniens (history)

Tekstvidnets historie angives under `history`-elementet. Hvis
tekstvidnet vides at være tabt, registreret eller nævnt, angives dette
her.

	...
	<history>
	  <ab>Tabt. Registreret i bla bla</ab>
	</history>
	...
-->
<!--
#### 2.1.7 Bibliografiske oplysninger om teksten (`listBibl`) 

Efter `listWit` følger et `listBibl`-element som sidste del af
`sourceDesc`. Her samles et eller flere `bibl`-elementer (*bibliographic
citation*), jf. 2.1.5.

	  </listWit>
	  <listBibl>
	    <bibl> Weibull, Dipl. Dioc. Lund. III 299-300 nr. 286 </bibl>
	    <bibl> Vejledende Arkivreg. XVIII 284 nr. 364 </bibl>
	    ...
	  </listBibl>
	</sourceDesc>
-->

## 2.2 Det digitale produkt (`encodingDesc`)

TEI-headerens anden komponent er `encodingDesc`-elementet, som
dokumenterer forholdet mellem den opmærkede tekst og dennes kilde. Her
angives de for transkriptionen styrende principper. Elementet
`encodingDesc` indholder følgende elementer:

| element       | beskrivelse                                     |
|---------------|-------------------------------------------------|
| projectDesc   | (*project description*) beskriver formålet med opmærkningen af filen |
| appInfo       | (*application information*) optager information om de applikationer, der har behandlet teksten i filen |

<!-- ### 2.2.1 samplingDecl

Elementet optager oplysninger om eventuelle udeladelser af dele af
teksten, fx om der er tale om en fuld transkription eller et
sammendrag.

En del af *Diplomatarium Danicum*s tekster udgøres af såkaldte
hanserecesser, referater fra hansestædernes repræsentantskabsmøder.
Herfra optages kun de passager af relevans for danske forhold.
Andre tekster hvis indhold kun er af perifer interesse for udgivelsen
kan optages i udtog.

Elementet `samplingDecl` kan have følgende gyldige værdier:

-----------------------------------------------------------------
**Element: `samplingDecl`**  **Værdi**    **Betydning**
---------------------------  ------------ ---------------------------
                             version      teksten er fuldstændig

                             excerpt      teksten er et udtog

                             nil          sagen uafklaret

                             empty        sagen irrelevant

-----------------------------------------------------------------
-->

### 2.2.1 `projectDesc`

Under elementet `projectDesc` angives Tekstnet-id for det projekt, som danner
ramme om udgivelsen, fx `arkiv-for-dansk-litteratur`:

```xml
<projectDesc>
  <ab> arkiv-for-dansk-litteratur </ab>
</projectDesc> 
```

### 2.2.3 `appInfo`

For at kunne følge med i hvordan teksten er behandlet angives under
`appInfo`-elementet hvilke værktøjer og procedurer 

	<!-- udfyldes -->

## 2.3 Tekstprofil

Under `profileDesc` (_text-profile description_) redegøres for de
ikke-bibliografiske aspekter af teksten, herunder tid og sted for tekstens
fremstilling, anvendte sprog, genre og aktører.

| element       | beskrivelse                                     |
|---------------|-------------------------------------------------|
| creation      |	tid og sted for etablering af teksten           |
| abstract      | resumé af tekstens indhold |
| langUsage     | sprog |
| textClass     | genre, tema |
| correspDesc   | beskrivelse af afsender-/modtageroplysninger i korrespondance |


### 2.3.1 Tid og sted for etablering af teksten (`creation`)

Elementet `creation` indeholder to elementer: 

| element       | beskrivelse                                     |
|---------------|-------------------------------------------------|
| date          | Tidsangivelse i et passende format. Elementet suppleres altid af attributtet `@when` udfyldt med værdi i formatet YYYY-MM-DD |
| placeName     | navnet på det sted en tekst er affattet. Dette element anvendes ikke i korrespondance |


### 2.3.2 Resumé af indholdet 

I større tekstsamlinger som brevudgaver forbedrer resuméer overblikket over
stoffet uden at læserne er nødt til at åbne den enkelte tekst. Tilsvarende nytte
gør resuméet i søgeresultatlister. I dsl-tei optages resuméet i elementet
`abstract` med et eller flere underordnede `ab`-elementer. 

```xml
<abstract>
  <ab>Kong Erik 7. af Pommern indskriver de bønder, der ikke på
      rettertinget har godtgjort deres frihed, under ledingen og 
      pålægger dem at udrede den inne, stud og leding samt andre 
      kongelige byrder, som de skylder for flere år.</ab>
</abstract>
```

### 2.3.2 Sprog

Elementet `langUsage` (*language usage*) samler et eller flere
`language`-elementer. Hvert `language`-element har attributtet `@ident`
(*identity*), hvis værdi er en sprogkode konstrueret i overensstemmelse
med BCP 47[^qa] og om muligt følger standarden ISO 639-1.[^qb]

[^qa]: jf. <https://tools.ietf.org/html/bcp47>
[^qb]: jf. <http://www-01.sil.org/iso639-3/codes.asp>


| @ident værdi | ISO 639 | beskrivelse                                     |
|----------------|-------|-----------|
| da | ja | dansk |
| de | ja | tysk |
| en | ja | engelsk |
| fr | ja | fransk |
| gda | - | gammeldansk |
| gmh | - | middelhøjtysk |
| gml | - | middelnedertysk |
| la  | ja | latin |
| xda | - | ældre nydansk |
| xno | - | normannerfransk |



```xml
<langUsage>
  <language ident="da" />
</langUsage>
```

### 2.3.3 Klassifikation

Emne- og genreklassifikation kan ske på følgende måde i elementet `textClass`.
`textClass` indeholder et `keywords`-element, som samler et eller flere
`term`-elementer, som hver især indeholder et nøgleord. 

```xml
<textClass>
  <keywords>
    <term> jura </term>
  </keywords>
</textClass>
```

### 2.3.4 Korrespondance

Opmærkning af korrespondance skal indeholde et `correspDesc` 

```xml
<correspDesc>
  <correspAction type="sent">
    <persName>Brahe, Tycho (1546-1601)</persName>
    <placeName>Helsingborg</placeName>
    <date when="1571-05-18"/>
  </correspAction>
  <correspAction type="received">
    <persName>Anders Sørensen Vedel</persName>
    <placeName>empty</placeName>
  </correspAction>
</correspDesc>
```

## 2.4 Ændringer af udgaven

TEI-headerens sidste underelement er `revisionDesc` (_revision description_), hvor signifikante
tekstændringer registreres i en række `change`-elementer. **Bemærk** at **ændringer
gives i omvendt kronologisk rækkefølge**, dvs. nyeste ændringer først.

| `change`          | beskrivelse   |
|-------------------|---------------|
| `@n`              | revisionsnummer i formatet STØRRE.MINDRE.MINDST, hvor **større** ændringer omfatter overgangen fra kladde til endelig version, **mindre** ændringer omfatter tilføjelser af nyt eller hidtil manglende materiale, og **mindst** omfatter rettelse af småfejl |
| `@when`           | datoangivelse i formatet yyyy-mm-dd |
| `@who`            | redaktørens initialer |
| `text()`          | kort beskrivelse af ændringen | 

```xml
<revisionDesc>
  <change n="1.0.0" when="2022-11-16" who="#th">Første endelige version offentiliggjort</change>
  <change n="0.1.2" when="2022-11-13" who="#th">Indsat blanktegn (&#xA0;) til indrykning af verslinjer</change>
  <change n="0.1.1" when="2022-01-05" who="#th">Korrektur læst vha. aspell, og rettelser fra DSLs eksemplar indført.</change>
</revisionDesc>
```

# 3 Faksimiler

Elementet `facsimile` samler et eller flere `graphic`-elementer:

	<facsimile>
	  <graphic url="nil"/>
	</facsimile>
	
	<!-- udfyldes -->

# 4 Tekst

Den tredje hovedbestanddel af et TEI-dokument, elementet `text`,
indeholder en tekst, som enten er en *enhed* (roman, novelle, brev og
lignende), eller udgør en *helhed* som en essay- eller digtsamling. 

Tekster med trykt eller håndskrevet forlæg kan ofte opdeles i tre
komponenter: Først optræder oplysninger om værkets titel, forfatter,
udgivelsessted; dernæst følger teksten, og til sidst finder vi
registre, noter og lignende.  For at kunne bearbejde disse komponenter
særskilt er elementet `text` inddelt som følger:

`front` 
:	(*front matter*), præliminære oplysninger i form af titelblad, 
	forside og forord, se 4.1 

`body` 
:	(*text body*), den centrale komponent, indeholder selve teksten, se. 4.2

`back` 
:	(*back matter*), eventuelle appendices og fortegnelser, som 
	følger efter teksten, se 4.3

## 4.1 Indledende oplysninger (`front`)

Til behandling af titelblade, forsider, dedikationer og forord i
trykte forlæg anvendes `front`, under hvilket følgende elementer
kan forekomme:

1. `titlePage`,	titelbladets struktur i form af titel, undertitel, byline og lign.
2. `div type="preface"`, forord til teksten
3. `div type="toc", indholdsfortegnelse

### 4.1.1 Titelblad (`titlePage`)

Et titelblad i et tryk eller håndskrift beskrives under elementet `titlePage`
med følgende underelementer:

1. `docTitle` (*document title*), beskrivelse af værkets titel, indeholder et eller flere elementer af typen `titlePart`
2. `byline`, oplysninger om værkets ophav i form af forfatter, redaktør eller udgiver
3. `epigraph`, påskrift, typisk i form af et motto og/eller citat fra et andet værk
4. `docImprint`, navn på udgiver, trykker eller distributør

Et eksempel findes i Georg Brandes Hovedstrømninger

	<titlePage>
	  <pb n="[1]"/>
	  <docTitle>
	    <titlePart>Hovedstrømninger i det 19de Aarhundredes Litteratur.</titlePart>
	    <titlePart type="desc">Forelæsninger holdte ved Kjøbenhavns Universitet i 
	      Efteraarshalvaaret 1871</titlePart>
	  </docTitle>
	  <byline>af <lb/> G. Brandes.</byline>
	  <docTitle>
	    <titlePart type="sub">Emigrantlitteraturen.</titlePart>
	  </docTitle>
	  <docImprint>
	    <pubPlace>Kjøbenhavn.</pubPlace>
	    <publisher>Forlagt af den Gyldendalske Boghandel (F. Hegel).</publisher>
	    <publisher>Græbes Bogtrykkeri.</publisher>
	    <docDate>1872.</docDate>
	  </docImprint>
	</titlePage>

#### 4.1.1.1 Titel (`docTitle`)

`docTitle` samler et eller flere `titlePart`-elementer. Forekommer
undertitler, angives disse med `titlePart type="sub"` (*subtitle*).
Her et eksempel på enkel `docTitle` i Jakob Knudsen, *Sind*:
	
	<docTitle>
	  <titlePart>Sind</titlePart>
	</docTitle>

I Holbergs *Peder Paars* opdeles titlen derimod i hoved- og
undertitel:

	<docTitle>
	  <titlePart>Peder Paars</titlePart>
	  <titlePart type="sub">Poema Heroico-comicum</titlePart>
	</docTitle>

#### Beskrivende titler

I Niels Jespersens Graduale findes et eksempel på en beskrivende
titel:

	<docTitle>
          <titlePart><pb n="E1"/>GRADVAL.</titlePart>
          <titlePart type="desc"> En Almindelig <lb/> Sangbog / som Hoybaarne
            <lb/> Første oc Stormectige Herre / Her Frederich den <lb/> Anden /
            Danmarckis Norgis Wendis oc Gottis Konning <ex>etcetera</ex>. <lb/> Haffuer
            ladet Ordinere oc tilsammen scriffue paa La<lb rend="="/>tine oc Danske / at
            bruge i Kirckerne / til des yder<lb rend="="/>mere endrectighed vdi Sang oc
            Ceremo<lb rend="="/>nier / effter Ordinantzens<lb/> lydelse.</titlePart>
	</docTitle>

#### 4.1.1.2 Byline

En *byline* gengiver i bred forstand værkets ophavsmand, hvad enten
der er tale om en forfatter, en fotograf eller en illustrator.
Nedenfor ses byline fra Holbergs *Peder Paars* med pseudonymet Hans
Mikkelsen:

	<byline> af Hans Michelsen </byline>

#### 4.1.1.3 Påskrift

En påskrift i form af et citat optages vha. elementet `epigraph`
kombineret med `cit`, `quote` samt opmærkning til vers, jf. 4.3.3
eller prosa, se 4.3.2. Nedenstående eksempel er en påskrift fra Ludvig
Holbergs *Peder Paars*

	<epigraph>
	  <cit>
	    <quote>
	      <lg>
	        <l>Nihil est, Antipho,</l>
	        <l>Qvin male narrando possit Depravarier.</l>
	        <l>Tu id qvod boni est Excerpis.</l>
	      </lg>
	    </quote>
	    <bibl>Terent: Phorm: Act: 4. Sc: 4.</bibl>
	  </cit>
	</epigraph>

Eksempel på opmærkning af prosa findes i Georg Brandes,
Hovedstrømninger:

	<epigraph>
	  <cit>
	    <quote>
	      <p>There is no philosophy possible, where fear of
	         consequences is a stronger principle than love 
	         of truth.</p>
	    </quote>
	    <bibl>John Stuart Mill</bibl>
	  </cit>
	</epigraph> 

#### 4.1.1.4 Imprimatur

Et imprimatur[^qw] indeholder typisk tid, sted og udgiverens navn.
Nedenfor ses imprimatur fra Holbergs *Peder Paars*, som dog kun angiver
trykåret:

[^qw]: af lat. konjunktiv: *må trykkes*.
	<docImprint>
	  Tryckt Aar <date>1720</date>.
	</docImprint>

### 4.1.2 Indholdsfortegnelse

Indholdsfortegnelse er et `div`-element med attributtet `@type` udfyldt
med værdien `toc` (table of contents). Selve indholdsfortegnelsen
opmærkes som en liste, dvs. `list`, jf. XXX

### 4.1.3 Forord

Forord opmærkes som et `div`-element med `@type` udfyldt med værdien
`preface`. <!--udfyld og giv eksempler-->

## 4.2 Tekstens struktur (`body` og `div`)

Udgivelsens centrale del udgøres af elementet `body` (*text body*),
som indeholder teksten, hvad enten den er inddelt i bøger eller sange
eller dele og kapitler.  Virkemidlet til beskrivelse af en teksts
disposition er elementet `div` (*division*), som er et rekursivt
element, idet det kan inddeles med andre `div`-elementer til en
hvilken som helst dybde.

En tekst med tre kapitler kan fx struktureres sådan: 

	<body>
	  <div> ... </div>
	  <div> ... </div>
	  <div> ... </div>
	</body>

En tekst med to dele, som hver indeholder et antal kapitler
struktureres således:

	<body>
	  <div>
	    <div> ... </div>
	    <div> ... </div>
	     ... 
	  </div>
	  <div>
	    <div> ... </div>
	    <div> ... </div>
	    ...
	  </div>
	</body>

### 4.2.1 Parallelle tekster

Ved tekster, der som *Diplomatarium Danicum* ledsages af oversættelse,
og synoptiske udgaver, rummer `body` to dele: først en `div` med
grundteksten kendetegnet ved attributtet `@xml:id="basetext"`, dernæst
en `div` med oversættelsen med `@xml:id="translation"`.

	<body>
	  <div xml:id="basetext">...  </div>
	  <div xml:id="translation"> ... </div>
	</body>

### 4.2.2 Deltitelblade

Deltitelblade opmærkes som `div`-elementer med attributten `@type`
udfyldt med værdien `half-title`. Et eksempel fra Brandes
Hovedstrømninger bd. 4

	...
	    </epigraph>
	  </front>
	<body>
	  <div type="half-title">
	    <head><pb n="[3]" />Naturalismen i England</head>
	  </div>
	  ...

## 4.3 Andre strukturelle elementer

Tekstinddelingselementet `div` kan indeholde følgende elementer:

`div`
:	(*text division*) indeholder en del af en tekst. Jf. 3.2.

`head`
:	(*heading*), overskrift, som enten i forvejen optræder i 
	tekstens forlæg eller suppleres af udgiveren. Hvis overskriften 
	suppleres af redaktionen, udvides `head`-elementet med `@type="add"`

`epigraph`
:	anvendes til mottoer i begyndelsen af en tekstdel, jf. 4.1.1.3

`list`
:	(*list*), lister, nummererede/unummererede, se 3.3

`p`
:	(*paragraph*), afsnit i prosa, se 3.3.2

`lg`
:	(*line group*), strofe i poesi, se 3.3.3


`pb`
:	(*page break*), sideskift

### 4.3.1 Overskrifter

DSL-TEI håndterer to slags overskrifter vha. elementet `head`
(*heading*). Herunder opmærkes 1. eksisterende overskrifter med
elementet `orig` og 2. normaliserede overskrifter med elementet `reg`
(*regularization*).

```xml
<head>
  <orig>Genesis Mose Første Bog.</orig>
  <reg>Første Mosebog</reg>
</head>
```
<!--
Eksisterende underoverskrifter angives således:

	<head type="orig-sub">...</head>

Supplerende overskrifter angives

	<head type="add">...</head>

Supplerende underoverskrifter angives

	<head type="add-sub">...</head>
-->

### 4.3.2 Prosa

Under hierarkiet af `body`- og `div`-elementer segmenteres prosatekst
i sideordnede afsnit vha. elementet `p` (*paragraph*). Om nødvendigt,
kan et `p`-element gengive typografiske variationer i form af venstre-
eller højrestillet tekst.  I så fald udvides `p` med attributtet
`@rend` (*rendition*), som udfyldes med én af følgende gyldige
værdier:

`center`
:	centreret tekst

`right` 
:	højrestillet tekst

I Herman Bangs Breve,
[19120106001](http://bangsbreve.dk/dokument/19120106001) højrestilles
tidsfæstelsen i et brev således

	...
	<p rend="right">Søndag.</p>
        <p>Jeg kom igaar ikke længere...


### 4.3.3 Vers

Til opmærkning af vers og strofer anvendes hhv. elementet `lg` (*line
group*) og `l` (*line*). Når verslinjen er brudt, markeres dette vha.
et `lb`-element (*line break*). Selv hvor der kun optræder en enkelt
verslinje, anbefales det at bruge `lg` som wrapper.

Elementet `lg` kan udvides med attributtet `@rend` og værdierne
`center` og `right` for hhv. centreret og højrestillet tekst. Når en
strofe har overskrift benyttes et `head`-element umiddelbart under
`lg`.


|**Attribut: `@rend`**    |  **Værdi** |   **Betydning**|
|-------------------------| -----------|-----------------------------------------|
|                         | center     |    Teksten i `lg` centreres|
|                         | center-it  |  Teksten i `lg` centreres og kursiveres |
|                         | indent[1-10]|  Teksten i `lg` indrykkes|
|                         | right       |  Teksten i `lg` højrestilles|

For at gengive typografisk ekspressivitet kan et `l`-element forsynes
med attributtet `@rend`.

I Brandes *Hovedstrømninger bd. 5* citeres:

	Derpaa
	 gik 
	  vor	 
	   Helt 
	    ganske 
	     nedslaaet 
	      ned 
	       ad 
	        Trapperne

Effekten opnås gennem følgende opmærkning:

	<lg>
          <l rend="indent1">Derpaa</l>
          <l rend="indent2">gik</l>
          <l rend="indent3">vor</l>
          <l rend="indent4">Helt</l>
          <l rend="indent5">ganske</l>
          <l rend="indent6">nedslaaet</l>
          <l rend="indent7">ned</l>
          <l rend="indent8">ad</l>
          <l rend="indent9">Trapperne</l>
        </lg>

NB! For at opnå kontrol med indrykningen transformeres hvert `l` til et
HTML `p` forsynet med `@class="indent1"`.

### 4.3.4 Drama
<!--tilføjet 2017-02-10 -->

Til drama anvendes elementet `sp` (*speech*) til gengivelse af en
replik i et skuespil. Under `sp` optræder altid et `speaker`-element
med karakterens navn efterfulgt af enten prosa- (jf. 4.3.2) eller
vers-opmærkning, jf. 4.3.3.

`sp`
:	(*speech*) rummer en individuel replik i drama

`speaker`
:	navnet på karakteren

`stage`
:	regibemærkning

#### 4.3.4.1 Citation af drama

Når drama citeres, anvendes elementet `cit` med de to
sidestillede elementer: `quote` og `bibl`. Nedenstående eksempel er
fra Georg Brandes, Hovedstrømninger, bd. 1:

```xml
... </p>
<cit>
  </quote>
  <sp>
    <speaker>Herkules</speaker>
    <p>Hvor er Wieland? Der staaer han. Han, naa, han er 
    lille nok, saadan havde jeg netop forestillet mig 
    ham. Er I den Mand, som altid fører Hercules i Munden?</p>
   </sp>
   <sp>
    <speaker>Wieland</speaker>
    <stage>(vigende tilbage)</stage>
    <p>Jeg har Intet at gjøre med Jer, Colos.</p>
   </sp>
   <sp>
     <speaker>Herkules</speaker>
     <p>Hvad nu, bliv kun!</p>
   </sp>
    ...
   </quote>
  <bibl></bibl>
</cit>
<p> ...
```
### 4.3.5 Lister

Lister gengives ved elementet `list`, som underordner et eller
flere `item`-elementer. Hvis listen i forlægget er ordnet, benyttes
attributten `@rend` med værdien `simple`. Hvert `item`-element udvides i
så fald med attributten `@n` udfyldt med en værdi i form af eksempelvis
et tal eller et litra. Et eksempel fra Hans Thomsens Den danske
Psalmebog

	<list rend="simple">
	  <item n="1.">Til at ære / loffue oc prise Gud met saadanne <lb/>Gudelige loffsange.</item>
	  <item n="2.">Til at lære / forfremme oc beuare her met <lb/>Guds ord iblant eder. 
	  ...
	</list>


### 4.3.6 Elementer på tekstniveau

På tekstniveau forekommer følgende elementer:

`hi`
:	fremhævet tekst, se 4.3.6.1

`bibl`
:	(*bibliographic citation*), indeholder en løst-struktureret
	bibliografisk henvisning i den løbende tekst, se X.X.X.X

`cit`
:	(*cited quotation*), citatnote, se 4.3.6.2

`app`
:	(*apparatus entry*), tekskritisk note, se 4.3.6.3


`damage`
:	læsion i manuskript, se 4.3.6.4


`supplied`
:	tilføjelser (konjekturer), som skønnes nødvendige 
	for tekstens mening, se 4.3.6.5

`gap`
:	tekst som udelades, se 4.3.6.6

`figure`
:	grafisk element i den løbende tekst, se 4.3.6.7

`ex`
:	opløsning af forkortelse, se 4.3.6.8

`note`
:	note eller tilføjelse, se 4.3.6.9

`pb`
:	sideskift i forlæg, se X.X.X.X

`persName`
:	personnavn, se 4.3.5.10

`placeName`
:	stednavn, se 4.3.5.11

`ref`
:	(*reference*), krydshenvisning, se 4.3.5.12

`term`
: bruges med `@xml:lang` til at opmærke fx arabiske og hebræiske tegn

`title`
:	titel på et værk, se 4.X.X.X

`opener`
: samleelement til annotering af åbningsformular i breve

`closer`
: samleelement til annotering af afslutningsformular i breve

`dateline`
: datering og stedfæstelse typisk i begyndelsen eller slutningen af breve

`salute`
: hilsen i begyndelsen eller slutningen af breve

`signed`
: underskrift i breve

`postscript`
: indeholder et postscriptum til et brev

`table`
: indeholder en tabel med rækker og kolonner

#### 4.3.5.1 Fremhævet tekst og andre typografiske afvigelser

Til gengivelse af fremhævet tekst benyttes elementet `hi`
(*highlighted*) med `@rend` (*rendition*), der beskriver tekstens
visuelle udtryk. Følgende attributværdier er tilladt:

`italic` ellers `italics` 
:	kursiv

`small` 
:	petit skriftsnit

`spaced`
:	spatieret, gengives med kursiv i endelig visning

`strong`
:	fed skrift

`sublinear`
:	lavstillet tekst

`supralinear`
:	højtstillet tekst

`underline`
: understreget tekst, gengives med kursiv i endelig visning

#### 4.3.5.2 Citater

Citater bringes i elementet `cit` (*cited quotation*), som indholder
følgende elementer:

`quote`
:	citatet

`bibl`
:	(*bibliographic entry*) 


**Eksempler**

I [Herman Bangs Breve,
19120106001](http://bangsbreve.dk/dokument/19120106001) optræder
følgende:

	... havde jo adskilligt 
	  <app>
	    <lem>at at</lem>
	    <rdg>Dittografi, fejlagtigt skrevet i forbindelse med 
	         et sideskift i brevet</rdg>
	  </app>
	tænke paa

Her bør teksten emenderes, således at dittografien kun beskrives i
`rdg`, altså som

	... havde jo adskilligt 
	  <app>
	    <lem>at</lem>
	    <rdg><q>at at</q> Dittografi, fejlagtigt skrevet i forbindelse med 
	         et sideskift i brevet</rdg>
	  </app>
	tænke paa

#### 4.3.5.3 Tekstkritik

Formålet med et tekstkritisk apparat er at vise læseren usikre
læsemåder, og hvilke dele af teksten skyldes emendering. Hertil
anvendes elementet: `app` (*apparatus entry*), som indeholder én 
post i et tekstkritisk apparat. 

Et `app`-element samler to elementer:

1. `lem` (*lemma*) indeholder den tekst, til hvilken der findes en
  variant. `lem` kan indholde attributtet `@wit` med en eller flere 
  blanktegnsadskilte sigelværdier, som alle indledes med #. 
2. `rdg` (*reading*) indeholder et alternativ til lemmaets tekst.
  `rdg` kan indholde attributtet `@wit` med en eller flere referencer 
  til sigler for de manuskripter, i hvilke læsningen optræder. Hver 
  sigelreference indledes med # og adskilles ved blanktegn.

```xml
<app>
<lem>den anden</lem>
<rdg>C, <q>den andet</q> A B, <q>det andet</q> ms.</rdg>
</app>
```

<!-- Denne praksis illustreres i Georg Brandes *Hovedstrømninger* bd. 2 --> 
<!-- med denne tekstkritiske note: -->

<!-- 	<app> -->
<!-- 	  <lem wit="#SS #Fu #1923-24">Alexandre</lem> -->
<!-- 	  <rdg wit="#A #B">Alexander</rdg> -->
<!-- 	</app> -->

<!-- I overenstemmelse med DSL's udgivelsesprincipper udtrykkes dette på -->
<!-- følgende måde -->

<!-- > Alexandre] *SS*, *Fu*, *1923-24*, Alexander *A*, *B*. -->

<!-- I nedenstående eksempel ([Dipl. Dan. 14250712001](http://diplomatarium.dk/dokument/14250712001)) --> 
<!-- tilbyder et andet tekstvidne, *Aa*, et alternativ i form af 'tenebitur' -->
<!-- til hovedvidnets læsning 'detinebitur': -->

<!-- 	... quibus episcopus captus --> 
<!-- 	  <app> -->
<!-- 	    <lem> detinebitur </lem> -->
<!-- 	    <rdg wit="#Aa"> tenebitur </rdg> -->
<!-- 	  </app> --> 
<!-- 	seu ipse ... -->

<!-- Til forklaring af emendationer kan udgiveren supplere `rdg` med elementet `note`. --> 
<!-- Nedenstående eksempel er fra Saxo Grammaticus 6,3,1 (bd. 1 s. 392) -->

<!-- > Denique peragrata Suetia fabri penates ingressus uicinum --> 
<!-- > limini locum occupat &lt;caput&gt; pilleolo, ne proderetur, --> 
<!-- > obscurante. -->  

<!-- Passagen opmærkes således: -->

<!-- 	Denique peragrata Suetia fabri penates ingressus uicinum -->
<!-- 	limini locum occupat --> 
<!-- 	  <app> -->
<!-- 	    <lem resp="#Gertz"> -->
<!-- 	      <supplied>caput</supplied> -->
<!-- 	    </lem> -->
<!-- 	    <rdg> -->
<!-- 	      <note>uocem <q>caput</q> post <q>occupat</q> quasi -->
<!-- 	            per haplographiam omissam add. Gertz</note> -->
<!-- 	    </rdg> -->
<!-- 	  </app> pilleolo, ne proderetur, obscurante. -->

<!-- Forslag til gengivelse i kritisk apparat: -->

<!-- > &lt;caput&gt;] *Gertz*. *Uocem* caput *post* occupat *quasi per -->
<!-- > haplographiam omissam add. Gertz.* -->

<!-- Bemærkninger i tilknytning til læsemåder indsættes i det pågældende -->
<!-- rdg-element, som i nedenstående eksempel i H.C. Ørsted, _Aanden i Naturen_: -->

<!-- ```xml -->
<!-- ...strax at sætte os paa vor egen Tids Standpunkt. Have <app> -->
<!-- <lem>vi gjennemskuet</lem> -->
<!--   <rdg wit="#B #C"><note>(således også i Forhandlinger)</note></rdg> -->
<!--   <rdg wit="#A">vig jennemskuet</rdg> -->
<!-- </app>, hvad deraf... -->
<!-- ``` -->

<!-- Hvis man ønsker at foranstille noten, er man af praktiske grunde nødt -->
<!-- til at benytte følgende praksis, hvor sigler udelades fra -->
<!-- rdg-elementet (her med siglen "ms."): -->

<!-- ```xml -->
<!-- ... havde fuldendt <app> -->
<!--   <lem>Størstedelen</lem> -->
<!--   <rdg wit="#A #C">størstedelen</rdg> -->
<!--   <rdg><note>afviger i ms.</note></rdg> -->
<!--   </app> af sit ... -->
<!-- ``` -->

#### 4.3.5.4 Læsioner

Hvis tekstvidnet er beskadiget, anvendes elementet `damage`, typisk
under lemmaet i en tekstkritisk note. I nedenstående eksempel ([Dipl.
Dan. 14450205001 ](http://diplomatarium.dk/dokument/14450205001)) kan
teksten suppleres vha. det andet tekstvidne *Aa*: 

	perpetui vicarii i sa<ex>m</ex>me stæth wore 
	  <app>
	    <lem>ski<damage>cket</damage>he</lem>
	    <rdg wit="#A">Lakune A; <q>skickethe</q> Aa</rdg>
	  </app> gothe beskethne me<ex>n</ex> ...

#### 4.3.5.5 Konjekturer

Til markering af tekst, som suppleres af redaktøren, anvendes
elementet `supplied`. Nedenstående eksempel kommer fra [Dipl. Dan.
14461229001](http://diplomatarium.dk/dokument/14461229001):

	... presentibus 
	  <app>
	    <lem>e<supplied>s</supplied>t</lem>
	    <rdg> <q>et</q> Weibull, l.c</rdg>
	  </app> 
	appensum ...

#### 4.3.5.6 Udeladelser

Såfremt redaktøren ønsker at udelade tekst, kan dette gøres vha.
elementet `gap`. Et eksempel fra *Diplomatarium Danicum*, hvor
oversættelsen udelades i projektperioden 2017-2021:

	...
	<p n="b#1">
          <gap>I perioden 1. januar 2017 til 30. juni 2021 vil
	    redaktionen udelukkende udarbejde tekster.</gap>
        </p>


#### 4.3.5.7 Grafik

Til gengivelse af grafiske elementer i den løbende tekst anvendes
elementet `figure`. Elementet forsynes altid med underelementet
`figDesc`.

Til adskillelse af afsnit og kapitler kan man anvende tre forskellige
slags skillestreger, hhv. `<milestone unit="section" rend="shortline"/>`, 
`<milestone unit="section" rend="mediumline"/>` samt `<milestone unit="section" rend="longline"/>`.

#### 4.3.5.8 Opløsning af abbreviaturer

Til optagelse af forkortelser og deres opløsninger i typisk
middelalderlige håndskrifter og tidlige tryk anvendes elementet `ex`
(*editorial expansion*), som udfyldes med tekst suppleret af redaktøren.
I [Dipl. Dan. 14151114001](http://diplomatarium.dk/dokument/14151114001)
forekommer:

	Oc weth<ex>e</ex>r kende hwn sigh ...

I Tekstnet gengives den opløste tekst i kursiv:

> Oc weth*e*r kende hwn sigh ...


<!--Elementet implementeres typisk som `em`-elementer i HTML.

	Oc weth<em>e</em>r kende hwn sigh ...

-->

#### 4.3.5.9 Noter

Fodnoter i den løbende tekst beskrives vha. elementet `note`
med attributtet `@place` udfyldt med værdien `foot`. Eventuelle henvisningstegn
opmærkes vha. `ref` karakteriseret ved attributtet `@refMark` som i nedenstående
eksempel H.C. Ørsted, Aanden i Naturen 1:

```xml
... Enster<note place="foot"><ref type="refMark">*)</ref>
                <p>Ordet er allerede blevet brugt af <hi rend="italic">Risbrigh</hi> 
                og er udentvivl gammelt. Det fandtes i Ordet 
                <hi rend="italic">Eensterskilling</hi>, som i forrige Aarhundrede 
                endnu brugtes til at betegne en enkelt Skilling i Sølvmynt.</p></note> (Individ) ...
```

I Tekstnet realiseres fodnoter som popup-noter med deres originale
referencetegn. Noten indledes med en titel bestående af Fodnote plus notens
nummer. Herefter følger referencetegnet og notens tekst. 

<!--

Et eksempel fra
Georg Brandes, Hovedstrømninger 1

	... Tid Poesi og Malerkunst sine 
	Personer?<note place="foot">Hettner: »<bibl>Litteraturgeschichte 
	des 18ten Jahrhunderts</bibl>« passim.</note> Hvad ...

Marginalnoter mærkes på samme måde med `@place` udfyldt med hhv.
`margin`, `margin-left` eller `margin-right`.
-->
 
#### 4.3.5.10 Personnavne

Personnavne opmærkes i den løbende tekst vha. elementet `persName` med
attributtet `@key` (_externally-defined means of identifying the
entity (or entities) being named, using a coded value of some
kind_) udfyldt med en unik id. Et eksempel fra Georg Brandes,
Hovedstrømninger 1

	I alle vore litterære Bevægelser i dette Aarhundredes Begyndelse, 
	i <persName key="adam-oehlenschlager">Oehlenschlägers</persName> 
	Poesier, i <persName key="n-f-s-grundtvig">Grundtvigs</persName>
	Prædikener, i ... 

Bemærk at attributtet @key _skal_ være udfyldt, i det mindste med værdien 'nil'
der indikerer at personen endnu ikke er identificeret.


**Fiktive personer**. Såfremt der er behov for at opmærke **fiktive
personer**, anvendes `persName` med to attributter: 1. `@key` udfyldt
med en unik id, og 2. `@type` udfyldt med værdien `fictional`.


#### 4.3.5.11 Stednavne

Stednavne opmærkes i den løbende tekst vha. elementet `placeName` med
attributtet `@ref` udfyldt med en unik id. Et eksempel fra Georg
Brandes, Hovedstrømninger 1

	... Ideer fra <placeName ref="tyskland">Tydskland</placeName>, 
	Revolutionens fra <placeName ref="frankrig">Frankrig</placeName>
	...


#### 4.3.5.12 Krydshenvisninger

Henvisninger til andre ressourcer indsættes i elementet `ref` på
følgende måde:

	... <ref target="14091009001">14091009001</ref> ...

**Normalisering af henvisninger**. I visse tilfælde kan det være
praktisk at lade originale henvisninger supplere med moderne
konventioner. Til dette formål anvendes hhv. elementerne `orig` til
originalformen og `reg` til den normaliserede form. I nedenstående
eksempel fra Hans Thomissøn, _Den danske Psalmebog_ (1569) ledsages
den oprindelige Bibelhenvisning _Luc. 21._ (opmærket med `orig`) af en
normaliseret og konventionel form _Luk. 21_ (opmærket med `reg`):

```
... Jesu Christi tilkommelse oc Dommedag ere nær / 
			(<ref target="#luk-21">
                            <orig>Luc. 21.</orig>
                            <reg>Luk. 21</reg>
                         </ref>) Derfor effterdi at ...

```

#### 4.3.5.13 Sideskift i forlæg

Sideskift i forlæg markeres med det lukkede element `pb` (*page-break*).
Elementet kan indeholde tre attributter:

`@ed`
:	*edition* udfyldes med sigelværdien for det tekstvidne, der
	transkriberes fra

`@n`
:	*number* udfyldes med tekstvidnets sidetal. Såfremt
	tekstvidnet ikke indeholder paginering sættes sidetallet i
	skarpe parenteser, jf. `n="[2]"`

`@facs`
:	*facsimile* udfyldes med en fil-id for den tilknyttede faksimile

<!--
* Skal initialer kunne opmærkes (argumenter for eller imod)
* Understreget tekst
* Gennemstreget tekst
-->

#### 4.3.5.XX Fremmede tegn

Til opmærkning af arabiske og hebræiske tegn anvendes elementet `term`
med `@xml:lang`. Fx hos Thomas Bartholin:

```xml
per <term xml:lang="ar">س</term>, non <term xml:lang="ar">ش</term> expressum ...
```

```xml
Unde &amp; Hebræis <term xml:lang="he">קנה</term> de hasta ...
```

#### 4.3.5.14 Bibliografiske henvisninger

Henvisninger til værker i den løbende tekst mærkes med elementet
`bibl` (*bibliographic citation*). Elementet kan rumme attributtet
`@ref`, hvis værdi enten peger på 1. dokumentets egen bibliografi
eller 2. en ekstern database.

Et eksempel fra Georg Brandes *Hovedstrømninger*, bd. 1:

	Martensens »Speculative Dogmatik« afløses af den 
	»<bibl ref="martensen-den-christelige-dogmatik">Christelige Dogmatik</bibl>«.

#### 4.3.5.15 Breve

Med elementet `correspDesc` beskrives brevvekslingens aktører samt eventuelle
ledsagende steds- og tidsangivelser:

```xml
<correspDesc>
  <correspAction type="sent">
    <persName>Brahe, Tycho (1546-1601)</persName>
    <placeName>Rostock</placeName>
    <date when="1568-01-14"/>
  </correspAction>
  <correspAction type="received">
    <persName>Johannes Aalborg</persName>
    <placeName>empty</placeName>
  </correspAction>
</correspDesc>
```


#### 4.3.5.X Værktitler

Henvisninger til værker i løbende tekst opmærkes vha. elementet `title`,
som yderligere kan udvides med attributten `@ref`. Eksempler kan
findes i Hans Thomissøns Den danske Psalmebog. <!-- uddyb-->

#### 4.3.5.X Tabeller

Tabeller indeholder tekst til visning i tabulær form, dvs. i rækker og kolonner.
Til opmærkning af tabeller anvendes elementerne:

`table`
: (tabel) indeholder tekst opmærket i tabulær form

`row`
: (række) indeholder en række i en tabel

`cell`
: (celle) indeholder en celle i en tabel


Tabeller kan anvendes til opmærkning af middelalderlige regnskaber. I
Diplomatarium Danicum

```xml
<table>
  <row>
    <cell rows="3"> Summen af guld, modtaget i nævnte tiende af samme kongerige
      Danmark42) </cell>
    <cell> 324 små floriner </cell>
    <cell rows="2">i guld.</cell>
  </row>
  <row>
    <cell> 55 masse. 12 aignel. </cell>
  </row>
  <row>
    <cell cols="2"> 2 mark ½ ørtug guld i barre, iberegnet et guldhostiegemme 
    i samme sum. </cell>
  </row>
</table>
```



