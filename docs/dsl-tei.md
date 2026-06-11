---
title: DSL-TEI, retningslinjer
author: Thomas Hansen (<th@dsl.dk>)
fontsize: 10pt
indent: false
language: da-DK
papersize: a4

---

# 0 Indledning

Nærværende dokument definerer et XML-baseret dataformat til opmærkning af Det
Danske Sprog- og Litteraturselskabs (DSL) digitale tekstudgivelser. Til
vejledningen hører 

- XSD-skemaet `dsl-tei.xsd`
- referencedokumentet `dsl-tei-ref.xml` 
- stylesheets til transformation fra XML til HTML. 

Formatet tilstræber konformitet med skemaet tei_all, defineret af konsortiet
Text Encoding Initiative (<https://www.tei-c.org>)[^a], hvilket betyder at et
validt dsl-tei-dokument også vil være gyldigt i forhold til tei_all.

[^a]: [http://www.tei-c.org](http://www.tei-c.org). Den nuværende version af
  TEI's retningslinjer, TEI P5, er den femte. 'P5' refererer således til
  *Proposal 5*.

Begrundelsen for et fælles opmærkningsformat er at skabe fælles grundlag for de
medarbejdere og projekter, der etablerer og bearbejder teksterne, samt de
værktøjer og procedurer, der anvendes på materialet. 

## 0.1 Et dsl-tei-dokument

Et dsl-tei-dokument er et XML-dokument med rodelementet `<TEI>` og attributtet
`@xmlns` (*XML namespace*), udfyldt med værdien `http://www.tei-c.org/ns/1.0`.
Rodelementet indholder de to obligatoriske komponenter `<teiHeader>` og `<text>`.

| element       | antal | beskrivelse                                        |
|---------------|-------|----------------------------------------------------|
| `<teiHeader>` | 1     | (*TEI header*) metadata til beskrivelse af den digitale ressource i bibliografisk, kodnings- og udviklingsmæssig henseende. Jf. 2 Metadata. |
| `<text>`      | 1     | et værk, enten som en enhed (fx én roman, novelle, brev) eller er en helhed af flere tekster (fx essays, digte, noveller). Jf. 4 Tekst. |

Elementerne disponeres således:

```xml
<TEI xmlns="http://www.tei-c.org/ns/1.0">
  <teiHeader>...</teiHeader>
  <text>...</text>
</TEI>
```
# 1 Metadata (teiHeader)

Elementet `<teiHeader>` samler de fornødne metadata til udgivelsen af en tekst.
Denne metadatasektion leverer bibliografisk beskrivelse af det digitale værk,
redegørelse for anvendt praksis ved dokumentets opmærkning, klassifikation af
sprog og genre samt dokumentets ændringshistorik. Under `<teiHeader>` findes
tilsvarende fire obligatoriske hovedelementer:

| element      | antal | beskrivelse                           |
|--------------|:-----:|---------------------------------------|
| `<fileDesc>`     | 1     | (*file description*) indeholder komplet bibliografisk beskrivelse af dokumentets tekstdel |
| `<encodingDesc>` | 1     | (*encoding description*) beskriver forholdet mellem den digitale tekst og kildegrundlaget |
| `<profileDesc>`  | 1     | (*text-profile description*) beskriver fx sprogbrug, genre eller genstandsfelt |
| `<revisionDesc>` | 1     | (*revision description*) indeholder overblik over ændringer af filen |

De fire elementer under `<teiHeader>`fordeler sig således:

```xml
<teiHeader>
  <fileDesc>...</fileDesc>
  <encodingDesc>...</encodingDesc>
  <profileDesc>...</profileDesc>
  <revisionDesc>...</revisionDesc>
</teiHeader>
```

## 1.1 Filbeskrivelsen

Metadatasektionens første del er `<fileDesc>` (_file description_), som
indeholder information til identifikation, katalogisering og beskrivelse af
filen. `<fileDesc>` indeholder følgende elementer:

| element             | antal  | beskrivelse                                              |
|---------------------|:------:|----------------------------------------------------------|
| `<titleStmt>`       | 1      | (*title statement*) angiver titel, forfattere, redaktører og bevillingsgivere |
| `<extent>`          | 1      | beskriver omfang af lagret tekst (filstørrelse/antal ord) eller sidetal i trykt udgivelse |
| `<publicationStmt>` | 1      | (*publication statement*) ansvarshavende i udgivelsen af teksten og dens distributionsvilkår |
| `<sourceDesc>`      | 1      | (*source description*) beskriver kilderne, fra hvilke den digitale tekst er afledt |

Elementerne fordeler sig sådan: 

```xml
<fileDesc>
  <titleStmt>...</titleStmt>
  <extent>...</extent>
  <publicationStmt>...</publicationStmt>
  <sourceDesc>...</sourceDesc>
</fileDesc>
```

### 1.1.1 Titelangivelsen

Titelangivelsen (`<titleStmt>`) indeholder et `<title>`-element, efterfulgt af et
eller flere `<author>`-, `<editor>`-, og `<funder>`-elementer. 

 element             | antal  | beskrivelse                                              |
|--------------------|--------|----------------------------------------------------------|
| `<title>`          | 1      | titlen på værket |
| `<author>`         | 1..*   | den primært ansvarlige forfatter, dvs. en person eller organisation |
| `<editor>`         | 1..*   | den sekundært ansvarlige for værket, dvs. en udgiver eller redaktør |
| `<funder>`         | 1..*   | det individ eller organisation som betaler for projektet eller teksten |

```xml
<titleStmt>
  <title>...</title>
  <author>...</author>
  <editor role="...">...</editor>
  <funder>...</funder>
</titleStmt>
```

#### 1.1.1.1 Titel

Elementet `<title>` udfyldes for litterære værkers vedkommende med selve
værktitlen:

```xml
<title>En dansk Students Eventyr</title>
```

For tekstindholdet i `<title>` gælder følgende:

- ortografien følger som udgangspunkt originalens
- eventuelt slutpunktum i titel udelades
- i brevudgivelser bruges datering og eventuel stedsangivelse:
  ```xml
  <title>1872. 10. april. Tersløse</title>
  ```

<!--
Ved enkeltudgivelse af noveller eller digte, som indgår i andre udgivelser,
tilføjes til et ekstra `<title>`-element, kvalificeret med `@type="pow"` således:

```xml
<title type="pow">»Fyrtøiet« fra Eventyr, fortalte for Børn I:1</title>
```
Denne _part of work_-titel indgår i HTML-elementet `<title>` på den færdige side. 
-->

#### 1.1.1.2 Forfatter

Elementet `<author>` indeholder tekst med navnet på værkets forfatter i den form
som anvendes på Tekstnet.[^3] For eksempel:

```
<author>H.C. Andersen</author>
```

[^3]: På Tekstnet anvendes den opslagsform der benyttes på lex.dk.

#### 1.1.1.3 Redaktionelle ansvarsområder

Elementet `<editor>` bruges med `@role` til præcisering af udgivernes
redaktionelle ansvarsområder. Følgende attributværdier er tilladt:

| @role: værdi      | beskrivelse                                                            |
|-------------------|------------------------------------------------------------------------|
| pub_editor        | Udgiver                                                                |
| maineditor        | Hovedredaktør                                                          |
| editor            | Redaktør                                                               |
| data_engineer     | Redaktør med ansvar for databehandling                                 |
| digital_version   | Redaktør med ansvar for etablering af digital version af et trykt værk |
| note_author       | Note-/kommentarforfatter                                               |
| student_assistant | Studentermedhjælper                                                    | 
| translator        | Oversætter                                                             |
| contributor       | Medvirkende ved udgivelsen                                             |
| supervision       | Tilsynsførende                                                         |

Navnet i `<editor>` udfyldes i samme form som medarbejderen optræder under i
DSL's Årsberetning.

Elementerne under `<titleStmt>` kan udfyldes på følgende måde:

```xml
<titleStmt>
  <title> Mit Livs Legende </title>
  <author> Johannes Jørgensen </author>
  <editor role="pub_editor">Elise Iuul</editor>
  <editor role="pub_editor">Henrik Wivel</editor>
  <editor role="student_assistant">Ida Salling-Jensen</editor>
  <editor role="supervision">Finn Gredal Jensen</editor>
  <editor role="supervision">Sebastian Olden-Jørgensen</editor>
  <funder>Carlsbergfondet</funder>
</titleStmt>
```

### 1.1.2 Omfang (extent)

	<!-- skal udfyldes -->

### 1.1.3 Om udgivelsen (publicationStmt)

Udgivelsesangivelsen, `<publicationStmt>` (*publication statement*),
samler navn på udgiver, samt *hvor* og *hvornår* filen er publiceret.
Endelig meddeles, under hvilke vilkår den udgives. `<publicationStmt>`
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

#### 1.1.3.1 Tilgængelighed

Under `<availability>` angives eventuelle licensforhold. 

```xml
<availability status="restricted">
  <licence n="CC BY-SA 4.0" target="http://creativecommons.org/licenses/by-sa/4.0/">
   Distributed under a Creative Commons Attribution-ShareAlike 4.0
   International License.</licence>
</availability>
```

### 1.1.4 Udgivelsens kilder (sourceDesc)

Til beskrivelse af en udgaves forlæg benyttes elementet `<sourceDesc>` (*source
description*) med de underordnede elementer `<listWit>` og `<listBibl>`:

| element             | beskrivelse                                       |
|---------------------|---------------------------------------------------|
| listWit             | (*witness list*) ét eller flere obligatoriske `<witness>`-elementer, som hver især beskriver et tekstforlæg. `<witness>` har obligatorisk `@xml:id` til identifikation. Heri indsættes en bogstavværdi, fx `A`, `B`, `C`, som er reference i tekstkritiske noter |
| listBibl            | (*bibliographic list*), indeholder supplerende bibliografiske oplysninger kan gives i ét eller flere `<bibl>`-elementer |

> *Note:* En underinddeling med obligatorisk `<listWit>` og fakultativt
> `<listBibl>` sikrer, at de kilder, der konstituerer teksten, kan 
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

#### 1.1.4.1 Tekstforlægget (witness)

Et tekstforlæg beskrives i `<witness>` i prosaform og indledes altid med

1. arkivalske eller bibliografiske oplysninger til identifikation af forlægget
   (lokalitet, institution, klassifikation)
2. en eventuel beskrivelse af forlæggets fysiske tilstand
3. en eventuel redegørelse for forlæggets historie og proveniens

```xml
<listWit>
  <witness xml:id="A"><hi rend="italic">Aanden i Naturen</hi>, bd. 1, 
                      1. udgave, 1850 [1849]</witness>
  <witness xml:id="B"><hi rend="italic">Aanden i Naturen</hi>, bd. 1, 
                      2. udgave, 1851</witness>
  <witness xml:id="C"><hi rend="italic">Aanden i Naturen</hi>, 
                      3. udgave, 1856</witness>
  <witness xml:id="D"><hi rend="italic">Aanden i Naturen</hi>, 
                      4. udgave, 1978</witness>
  <witness xml:id="ms.">Det Kgl. Bibliotek, H.C. Ørsteds arkiv, 
                      Ørsted 21 fol.</witness>
</listWit>
```

```xml
<listWit>
  <witness xml:id="A">Uppsala, Uppsala universitetsbibliotek. Pergament.
  På bagsiden påskriften: <hi rend="italic">Skipt</hi>, derefter med 
  anden hånd: <hi rend="italic">paa Raasserydh</hi>. Segl: 1. perg.rem, 
  2. perg.rem, 3. perg.rem, 4. perg.rem, 5. perg.rem, 6. perg.rem, 7. 
  perg.rem, 8. perg.rem.</witness>
</listWit>
```

```xml
<witness xml:id="A">Ti Aar. Erindringer og Hændelser, I-II. Schubothes
Boghandel, XX + 276 s.</witness>
```

### 1.2.1 `<projectDesc>`

Under elementet `<projectDesc>` angives Tekstnet-id for det projekt, som danner
ramme om udgivelsen, fx `arkiv-for-dansk-litteratur`:

```xml
<projectDesc>
  <ab> arkiv-for-dansk-litteratur </ab>
</projectDesc> 
```

### 1.2.3 `<appInfo>`

For at kunne følge med i hvordan teksten er behandlet angives under
`appInfo>`-elementet hvilke værktøjer og procedurer 

	<!-- udfyldes -->

## 1.3 Tekstprofil

Under `<profileDesc>` (_text-profile description_) redegøres for de
ikke-bibliografiske aspekter af teksten, herunder tid og sted for tekstens
fremstilling, anvendte sprog, genre og aktører.

| element       | beskrivelse                                     |
|---------------|-------------------------------------------------|
| creation      |	tid og sted for etablering af teksten           |
| abstract      | resumé af tekstens indhold |
| langUsage     | sprog |
| textClass     | genre, tema |
| correspDesc   | beskrivelse af afsender-/modtageroplysninger i korrespondance |


### 1.3.1 Tid og sted for etablering af teksten (`creation>`)

Elementet `<creation>` indeholder to elementer: 

| element       | beskrivelse                                     |
|---------------|-------------------------------------------------|
| date          | Tidsangivelse i et passende format. Elementet suppleres altid af attributtet `@when` udfyldt med værdi i formatet YYYY-MM-DD |
| placeName     | navnet på det sted en tekst er affattet. Dette element anvendes ikke i korrespondance |


### 1.3.2 Resumé af indholdet 

I større tekstsamlinger som brevudgaver forbedrer resuméer overblikket over
stoffet uden at læserne er nødt til at åbne den enkelte tekst. Tilsvarende nytte
gør resuméet i søgeresultatlister. I dsl-tei optages resuméet i elementet
`<abstract>` med et eller flere underordnede `<p>`-elementer. 

```xml
<abstract>
  <p>Kong Erik 7. af Pommern indskriver de bønder, der ikke på
      rettertinget har godtgjort deres frihed, under ledingen og 
      pålægger dem at udrede den inne, stud og leding samt andre 
      kongelige byrder, som de skylder for flere år.</p>
</abstract>
```

### 1.3.2 Sprog

Elementet `<langUsage>` (*language usage*) samler et eller flere
`language>`-elementer. Hvert `<language>`-element har attributtet `@ident`
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

### 1.3.3 Klassifikation

Emne- og genreklassifikation kan ske på følgende måde i elementet `<textClass>`.
`textClass>` indeholder et `<keywords>`-element, som samler et eller flere
`term>`-elementer, som hver især indeholder et nøgleord. 

```xml
<textClass>
  <keywords>
    <term> jura </term>
  </keywords>
</textClass>
```

### 1.3.4 Korrespondance

Opmærkning af korrespondance skal indeholde et `<correspDesc>` indsat som første
element under `<fileDesc>` før `<creation>`:

```xml
<fileDesc>
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
  <creation>
  ...
```

## 1.4 Ændringer af udgaven

TEI-headerens sidste underelement er `<revisionDesc>` (_revision description_),
hvor signifikante tekstændringer registreres i en række `<change>`-elementer,
underinddelt i et eller flere `<p>`-elementer. **Bemærk** at **ændringer gives i
omvendt kronologisk rækkefølge**, dvs. nyeste ændringer først.

| `<change>` | beskrivelse                                                                     |
|----------|---------------------------------------------------------------------------------|
| `@n`     | revisionsnummer i formatet STØRRE.MINDRE hvor **større** ændringer omfatter overgangen fra kladde til endelig version og tilføjelse af supplerende materiale, og **mindre** ændringer omfatter rettelse af småfejl |
| `@when`  | datoangivelse i formatet yyyy-mm-dd |
| `@who`   | redaktørens initialer |
| `text()` | kort beskrivelse af ændringen | 

```xml
<revisionDesc>
  <change n="1.0" when="2022-11-16" who="#th">
    <p>Første endelige version offentliggjort.</p>
  </change>
  <change n="0.2" when="2022-11-13" who="#th">
    <p>Indsat blanktegn (&#xA0;) til indrykning af verslinjer.</p>
  </change>
  <change n="0.1" when="2022-01-05" who="#th">
    <p>Korrektur læst vha. aspell, og rettelser fra DSLs eksemplar indført.</p>
  </change>
</revisionDesc>
```

### 1.4.1 Sådan retter du versionsnummeret

Som udgangspunkt offentliggøres alle tekster i version 0.1. Denne første version
kan betragtes som en testversion som stilles til rådighed i forventning om at
teksten vil undergå rettelser og at supplerende materiale (kommentarer,
tekstkritik, person- og stednavne samt ledsagende tekster) kan offentliggøres
ved senere lejlighed. Bemærk at en tekst godt kan offentliggøres i en version
1.0 uden tekstkritik, noter og anden funktionalitet. På den måde kan også
tekster stilles til rådighed uden at de opfylder de kvalitetskrav der
almindeligvis gælder ved DSL-udgivelser.

Følgende kriterier gælder ved rettelse af tekstens versionsnummer:  

**STØRRE** ændres ved:

- afsluttet arbejdsgang herunder:
  - korrektur
  - kommentarer tilføjet
  - forord, indledning, tekstredegørelse tilføjet
- omdøbning af filnavn

**MINDRE** ændres ved:

- rettelse af småfejl
- justering af formatering


<!--
# 3 Faksimiler

Elementet `<facsimile>` samler et eller flere `graphic>`-elementer:

```xml
<facsimile>
  <graphic url="nil"/>
</facsimile>
```	
-->

# 2 Tekst

Den anden obligatoriske hovedbestanddel af et DSL-TEI-dokument, elementet
`<text>`, indeholder udgivelsens centrale del, hvad enten det fx er en roman, et digt,
brev, en novelle- eller digtsamling.

Til at dokumentere en sådan tekst kan `<text>` derfor opdeles i tre dele:

| element | antal | beskrivelse                                                        |
|---------|-------|--------------------------------------------------------------------|
| `<front>` | 0..1  | (*front matter*), præliminære oplysninger i form af titelblad, forside og forord, se 4.1 |
| `<body>`  | 1     | (*text body*), den centrale komponent, indeholder selve teksten, se. 4.2 |
| `<back>`  | 0..1  |	(*back matter*), eventuelle appendices og fortegnelser, som følger efter teksten, se 4.3 |

I DSL-TEI struktureres teksten under de tre tekstelementer `<front>`, `<body>`
og `back>` i kapitler eller tilsvarende enheder. Den primære begrundelse herfor
er, at kapitelinddelingen i de fleste litterære værker som regel er en inhærent
del af tekstens indholdsstruktur og som sådan let at identificere. De
brugsmæssige fordele kan sammenfattes således:

- Navigation. Kapitelinddeling understøtter intuitiv navigation i form af fx
  indholdsfortegnelser og bladrefunktioner ("forrige/næste kapitel").
- Orientering. Kapitler udgør for det meste overskuelige læseenheder, hvor en
  enhedsvisning ofte virker uoverskuelig.
- Indeksering. Søgeresultater bliver mere præcise, idet hvert kapitel er
  udstyret med metadata.

Nedenfor ses et eksempel på hvordan strukturen kan se ud:

```xml
<front>
  <titlePage> <!--titelblad--> </titlePage>
  <div>       <!--motto-->     </div>
  <div>       <!--dedikation--></div>
  <div>       <!--forord-->    </div>
</front>
<body>
  <div>       <!--kapitel 1--></div>
  <div>       <!--kapitel 2--></div>
</body>
<back>
  <div>       <!--efterskrift--></div>
</back>
```

## 2.1 Indledende oplysninger (front)

Til behandling af præliminære indholdsdele som titelblade, dedikationer og
forord anvendes `<front>`, som kan indeholde følgende elementer:

| element     | antal | beskrivelse                                                        |
|-------------|-------|--------------------------------------------------------------------|
| `<titlePage>` | 0..1  | titelbladets struktur i form af titel, undertitel, byline og lign. |
| `<div>`       | 0..\* | indledende afsnit, fx forord eller indholdsfortegnelse             |

### 2.1.1 Titelblad (titlePage)

Et titelblad i et tryk eller håndskrift beskrives under elementet `<titlePage>`.
Der er mulighed for følgende underelementer:

| element    | antal | beskrivelse                                                        |
|------------|-------|--------------------------------------------------------------------|
| `<docTitle>` | 1     | (*document title*), beskrivelse af værkets titel, indeholder et eller flere elementer af typen `<titlePart>` |
| `<byline>`   | 0..1  | oplysninger om værkets ophav i form af forfatter, redaktør eller udgiver |
| `<epigraph>` | 1 | påskrift, typisk i form af et motto og/eller citat fra et andet værk |
| `<docImprint>` | 1   | (_document imprint_) navn på udgiver, trykker eller distributør |

Nedenstående eksempel er hentet fra Georg Brandes _Hovedstrømninger i det 19.
Aarhundredes Litteratur_:

```xml
<titlePage>
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
```

#### 2.1.1.1 Titel (docTitle)

Elementet `<docTitle>` samler et eller flere `<titlePart>`-elementer. Her et
eksempel på `<docTitle>` i Jakob Knudsen, *Sind*:

```xml
<docTitle>
  <titlePart>Sind</titlePart>
</docTitle>
```

Til opmærkning af undertitler og længere beskrivende titler anvendes `<titlePart>`
kvalificeret vha. `@type` og en af følgende værdier:


| `@type`-værdi  | beskrivelse                                                        | 
|----------------|--------------------------------------------------------------------|
| `desc`         | (_descriptive_) angiver en beskrivende titel                       |
| `sub`          | (_subtitle_) angiver undertitel                                    |


I Holbergs *Peder Paars* opdeles titlen i hoved- og undertitel:

```xml
<docTitle>
  <titlePart>Peder Paars</titlePart>
  <titlePart type="sub">Poema Heroico-comicum</titlePart>
</docTitle>
```

I Niels Jespersens _Graduale_ findes et eksempel på en beskrivende
titel:

```xml
<docTitle>
  <titlePart><pb n="E1"/>GRADVAL.</titlePart>
  <titlePart type="desc"> En Almindelig <lb/> Sangbog / som Hoybaarne
    <lb/> Første oc Stormectige Herre / Her Frederich den <lb/> Anden
    / Danmarckis Norgis Wendis oc Gottis Konning <ex>etcetera</ex>. 
    <lb/> Haffuer ladet Ordinere oc tilsammen scriffue paa 
    La<lb rend="="/>tine oc Danske / at bruge i Kirckerne / til des 
    yder<lb rend="="/>mere endrectighed vdi Sang oc 
    Ceremo<lb rend="="/>nier / effter Ordinantzens<lb/> lydelse.
  </titlePart>
</docTitle>
```
#### 2.1.1.2 Byline

En *byline* gengiver i bred forstand værkets ophavsmand, hvad enten
der er tale om en forfatter, en fotograf eller en illustrator.
Nedenfor ses byline fra Holbergs *Peder Paars* med pseudonymet Hans
Mikkelsen:

```xml
<byline> af Hans Michelsen </byline>
```

#### 2.1.1.3 Påskrift (epigraph)

En påskrift i form af et citat optages vha. elementet `<epigraph>`
kombineret med `<cit>`, `<quote>` samt opmærkning til vers, jf. 4.3.3
eller prosa, se 4.3.2. Nedenstående eksempel er en påskrift fra Ludvig
Holbergs *Peder Paars*:

```xml
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
```

Eksempel på opmærkning af prosa findes i Georg Brandes, _Hovedstrømninger_:

```xml
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
```

#### 2.1.1.4 Imprimatur (docImprint)

Et imprimatur[^qw] indeholder typisk tid, sted og udgiverens navn.
Nedenfor ses imprimatur fra Holbergs *Peder Paars*, som dog kun angiver
trykåret:

[^qw]: af lat. konjunktiv: *må trykkes*.

```xml
<docImprint> Tryckt Aar <date>1720</date>. </docImprint>
```

### 2.1.2 Indholdsfortegnelse

Indholdsfortegnelse er et `<div>`-element med attributtet `@type` udfyldt
med værdien `toc` (table of contents). Selve indholdsfortegnelsen
opmærkes som en liste, dvs. `<list>`, jf. XXX

### 2.1.3 Forord

Forord opmærkes i et `<div>`-element direkte under `<front>`: 

```xml
<front>
  <div>
    <head>
      <reg>Forord</reg>
      <orig/>
    </head>
    <div>
      <p>Denne Bog tilhører dig.</p>
      <p>Den Gang, da du endnu var stærk og lykkelig, gik vi en Dag, som vi, 
      mens jeg var Dreng, saa ofte plejede, naar Skumringen faldt paa, en
      »Ønskevandring« ned ad Byens Gade: ...
      </p>
      ...
    </div>
    ...
```

## 2.2 Tekstens centrale del (body)

Udgivelsens centrale del udgøres af `<body>` (*text body*), som indeholder
teksten, hvad enten den er inddelt i bøger, sange, dele og/eller kapitler.
Virkemidlet til beskrivelse af en teksts disposition er elementet `<div>`
(*division*), som er et rekursivt element, idet det kan inddeles med andre
`div>`-elementer til en hvilken som helst dybde.

En tekst med tre kapitler kan fx struktureres sådan: 

```xml
<body>
  <div> ... </div>
  <div> ... </div>
  <div> ... </div>
</body>
```

### 2.2.1 Parallelle tekster

Ved kortere teksttyper som breve og diplomer kan grundteksten ledsages af en
oversættelse. I så fald rummer `<body>` to dele: 1. en `<div>` med grundteksten
kendetegnet ved `@xml:id="basetext"` og 2. en `<div>` med oversættelsen med
`@xml:id="translation"`.

```xml
<body>
  <div xml:id="basetext">...  </div>
  <div xml:id="translation"> ... </div>
</body>
```

### 2.2.2 Deltitelblade

Deltitelblade opmærkes i et `<head>`-element med attributtet `@type`
udfyldt med værdien `part`. Et eksempel fra Henrik Pontoppidans _Muld_:

```xml
<div>
  <head type="part">
    <reg>Første bog</reg>
    <orig>FØRSTE BOG</orig>
  </head>
  <head>
    <reg>1</reg>
    <orig>I.</orig>
  </head>
  ...
```

## 2.3 Blokelementer under `<div>`

Blokelementet `<div>` kan indeholde følgende andre blokelementer:

| element    | antal | beskrivelse                                                              |
|------------|-------|--------------------------------------------------------------------------|
| `<div>`      | 0..\* | (*division*), inddeling af en tekstdel                                   |
| `<head>`     | 0..\* | (*heading*), overskrift, som enten i forvejen optræder i tekstens forlæg eller suppleres af udgiveren. |
| `<cit>`      | 0..\* | (*citation*) citat, jf. 4.1.1.X                                          |
| `<epigraph>` | 0..\* | anvendes til mottoer i begyndelsen af en tekstdel, jf. 4.1.1.3           |
| `<list>`     | 0..\* | (*list*), lister, nummererede/unummererede, se 3.3                       |
| `<p>`        | 0..\* | (*paragraph*), afsnit i prosa, se 3.3.2                                  |
| `<lg>`       | 0..\* | (*line group*), strofe i poesi, se 3.3.3                                 |
| `<table>`    | 0..\* | (*table*), tabel, se X.X.X                                               |


### 2.3.1 Overskrifter (head)

Overskrifter til kapitler opmærkes med elementet `<head>` (*heading*) underinddelt
i to elementer: 1. `<reg>` en normaliseret overskrift der sikrer at alle tekster i
på Tekstnet fremtræder sammenligneligt i fx søgeresultater; 2. `<orig>` forlæggets 
overskrift.

| element | antal | beskrivelse                                              |
|---------|-------|----------------------------------------------------------|
| `<reg>`   | 1     | (*regularization*) normaliseret overskrift, hvor moderne retskrivning kan følges og kapitelnummerering skal indsættes              | 
| `<orig>`  | 1     | (*original*) oprindelig overskrift                       |

```xml
<head>
  <reg>3. Tænkningens og Indbildningskraftens Naturopfatning</reg>
  <orig>Over Forholdet mellem Tænkningens og Indbildningskraftens 
        Naturopfatning</orig>
</head>
```

Bemærk at eventuelle præciseringer af overskriften, dvs. såkaldte
"underoverskrifter" som ikke tilhører en egen div-struktur, opmærkes i
`<orig>`-elementet

__Eksempler__

```xml
<head>
  <reg>1. Det Aandelige i det Legemlige</reg>
  <orig>Det Aandelige i det Legemlige <lb/>
        <hi rend="small">En Samtale</hi>
  </orig>
</head>
```

Ved udgivelse af digt- og novellesamlinger skal hvert digt eller hver novelle
forsynes med et ekstra `<reg>`-element, kvalificeret med `@type="pow"`:

```xml
<head>
  <reg>1. Dødskamp</reg>
  <reg type="pow">»Dødskamp« fra Skygger</reg>
  <orig><pb ed="A" n="[9]"/>Dødskamp</orig>
</head>
```

Dette _part of work_-element indgår i HTML-elementet `<title>` på den færdige side.


### 2.3.2 Prosa

Under hierarkiet af `<body>`- og `<div>`-elementer segmenteres prosatekst i
sideordnede afsnit vha. elementet `<p>` (*paragraph*). Om nødvendigt, kan et
`<p>`-element gengive typografiske variationer i form af venstre- eller
højrestillet tekst.  I så fald udvides `<p>` med `@rend` (*rendition*), som
udfyldes med én af følgende gyldige værdier:

| `p/@rend` værdi | betydning                                     |
|-----------------|-----------------------------------------------|
| `text-center`   | centreret tekst                               | 
| `text-right`    | højrestillet tekst                            | 


### 2.3.3 Lyrik

Til opmærkning af strofer anvendes elementet `<lg>` (*line group*) med de
underordnede elementer `<l>` (*line*) til verslinjer og `<head>` til
strofeoverskrifter. Når verslinjen er brudt, markeres dette vha.  et
`<lb>`-element (*line break*). Selv hvor der kun optræder en enkelt verslinje,
skal `<lg>` benyttes som wrapper.

Elementet `<lg>` kan udvides med attributtet `@rend` for at angive venstreindrykning af strofen:

| `lg/@rend` værdi | betydning                                    |
|------------------|----------------------------------------------|
|  `ml-0`          | nulstiller venstremargin på `<lg>`           | 
|  `ml-1`          | sætter venstremargin til $spacer * .25       | 
|  `ml-2`          | sætter venstremargin til $spacer * .5        | 
|  `ml-3`          | sætter venstremargin til $spacer *           | 
|  `ml-4`          | sætter venstremargin til $spacer * 1.5       | 
|  `ml-5`          | sætter venstremargin til $spacer * 3         | 

For at tillade gengivelse af typografisk ekspressivitet kan et `<l>`-element forsynes med
attributtet `@rend` og en værdi der angiver graden af indrykning.

| `l/@rend` værdi  | betydning                                    |
|------------------|----------------------------------------------|
| `indent`         | venstreindrykker teksten med 4 * &nbsp;      |
| `indent-1`       | venstreindrykker teksten med 2 * &nbsp;      |
| `indent-2`       | venstreindrykker teksten med 4 * &nbsp;      |
| `indent-3`       | venstreindrykker teksten med 6 * &nbsp;      |
| `indent-4`       | venstreindrykker teksten med 8 * &nbsp;      |
| `indent-5`       | venstreindrykker teksten med 10 * &nbsp;     |
| `indent-6`       | venstreindrykker teksten med 12 * &nbsp;     |
| `indent-7`       | venstreindrykker teksten med 14 * &nbsp;     |
| `indent-8`       | venstreindrykker teksten med 16 * &nbsp;     |
| `indent-9`       | venstreindrykker teksten med 18 * &nbsp;     |
| `indent-10`      | venstreindrykker teksten med 20 * &nbsp;     |

__Eksempel__ I Brandes *Hovedstrømninger bd. 5* citeres:

```
	Derpaa
	 gik 
	  vor	 
	   Helt 
	    ganske 
	     nedslaaet 
	      ned 
	       ad 
	        Trapperne
```

Effekten opnås gennem følgende opmærkning:

```xml
<lg>
  <l rend="indent-1">Derpaa</l>
  <l rend="indent-2">gik</l>
  <l rend="indent-3">vor</l>
  <l rend="indent-4">Helt</l>
  <l rend="indent-5">ganske</l>
  <l rend="indent-6">nedslaaet</l>
  <l rend="indent-7">ned</l>
  <l rend="indent-8">ad</l>
  <l rend="indent-9">Trapperne</l>
</lg>
```

### 2.3.4 Drama
<!--tilføjet 2017-02-10 -->

Til drama anvendes elementet `<sp>` (*speech*) til gengivelse af en
replik i et skuespil. Under `<sp>` optræder altid et `<speaker>`-element
med karakterens navn efterfulgt af enten prosa- (jf. 4.3.2) eller
vers-opmærkning, jf. 4.3.3.

| element      | antal | beskrivelse                                              |
|--------------|-------|----------------------------------------------------------|
| `<speaker>`  | 1     | (*speech*) rummer en individuel replik i drama           |
| `<stage>`    | 0..n  | regibemærkning                                           |
| `<lg>`       | 0..n  | strofe/vers                                              |
| `<p>`        | 0..n  | afsnit                                                   |


```xml
<stage>ANNIE og AILSIE</stage>
<sp>
  <speaker>AILSIE</speaker>
  <stage>(synger).</stage>
  <lg n="1.">
    <l>Fuldmaanen skinner paa Busk og Krat,</l>
    <l>Thi det er St. Hans’s lystige Nat.</l>
    <l rend="indent-2">Husch! husch!</l>
    <l>Mo’erlille sadler sit Kosteskaft,</l>
    <l>En bedre Hest har der ingen havt!</l>
    <l>Saa flyver hun op, saa flyver hun ned,</l>
    <l>Hun flyver til Bal og til Lystighed,</l>
    <l rend="indent-2"> Husch! husch!</l>
    <l>Den Smaa-Dreng læser sit: »<hi rend="italic">Fader vor</hi>,«</l>
    <l>Ak, hvor vil Du hen, Du søde Mo’er?</l>
    <l>Sov stille, Barnlille!</l>
    <l>Jeg <ref target="n27"/>har at bestille;</l>
    <l>Med Kosten jeg feier vor Skorsteen net;</l>
    <l>Jeg flyver saa let!</l>
    <l rend="indent-2">Husch! husch!</l>
  </lg>
</sp>
<sp>
  <speaker>ANNIE</speaker>
  <stage>(hæver sin Krykkestok).</stage>
  <p>Vil Du tie stille med Din Hexe-Sang! he, he, he!</p>
</sp>
```

#### 2.3.4.1 Rollelister

Rollelister kan placeres i `<div>`-elementer under `<front>` og `<body>`:

```xml
<div>
  <head>
    <reg>Personer</reg>
    <orig>Personerne</orig>
  </head>
  <castList>
    <castItem>
      <role>Johan von Ehrenpreis,</role>
      <roleDesc>Skredder-Svend.</roleDesc>
    </castItem>
    <castItem>
      <role>Grete,</role>
      <roleDesc>Johans Forlovede.</roleDesc>
    </castItem>
  </castList>
</div>
```

### 2.3.5 Lister

Lister gengives ved elementet `<list>`, som underordner et eller
flere `<item>`-elementer. Hvis listen i forlægget er ordnet, benyttes
attributten `@rend` med værdien `<simple>`. Hvert `<item>`-element udvides i
så fald med attributten `@n` udfyldt med en værdi i form af eksempelvis
et tal eller et litra. Et eksempel fra Hans Thomsens Den danske
Psalmebog

```xml
<list rend="simple">
  <item n="1.">Til at ære / loffue oc prise Gud met ... loffsange.</item>
  <item n="2.">Til at lære / forfremme oc beuare ... </item> 
	...
</list>
```

### 2.3.6 Elementer på tekstniveau

På tekstniveau forekommer følgende elementer:

| element      | antal | beskrivelse                                              |
|--------------|-------|----------------------------------------------------------|
| `<hi>`       | 0..n  | fremhævet tekst, se 4.3.6.1                              |
| `<bibl>`     | 0..n  | (*bibliographic citation*) bibliografisk henvisning i den løbende tekst, se X.X.X.X |
| `<cit>`      | 0..n  | (*cited quotation*), citatnote, se 4.3.6.2 |
| `<app>`      | 0..n  | (*apparatus entry*), tekskritisk note, se 4.3.6.3 |
| `<damage>`   | 0..n  | læsion i manuskript, se 4.3.6.4 |
| `<supplied>` | 0..n  | tilføjelser (konjekturer), som skønnes nødvendige for tekstens mening, se 4.3.6.5 |
| `<gap>`      | 0..n  | tekst som udelades, se 4.3.6.6 |
| `<figure>`   | 0..n  | grafisk element i den løbende tekst, se 4.3.6.7 |
| `<formula>`  | 0..n  | matematisk eller anden formel, se 4.3.6.7a |
| `<ex>`       | 0..n  | opløsning af forkortelse, se 4.3.6.8 | 
| `<note>`     | 0..n  | note eller tilføjelse, se 4.3.6.9 |
| `<pb>`       | 0..n  | sideskift i forlæg, se X.X.X.X |
| `<persName>` | 0..n  | personnavn, se 4.3.5.10 |
| `<placeName>`| 0..n  | stednavn, se 4.3.5.11 |
| `<ref>`      | 0..n  | (*reference*), krydshenvisning, se 4.3.5.12 |
| `<term>`     | 0..n  | bruges med `@xml:lang` til at opmærke fx arabiske og hebræiske tegn |
| `<title>`    | 0..n  | titel på et værk, se 4.X.X.X |
| `<opener>`   | 0..n  | samleelement til annotering af åbningsformular i breve |
| `<closer>`   | 0..n  | samleelement til annotering af afslutningsformular i breve |
| `<dateline>` | 0..n  | datering og stedfæstelse typisk i begyndelsen eller slutningen af breve |
| `<salute>`   | 0..n  | hilsen i begyndelsen eller slutningen af breve |
| `<signed>`   | 0..n  | underskrift i breve |
| `<postscript>` | 0..n | indeholder et postscriptum til et brev |
| `<table>`    | 0..n  | indeholder en tabel med rækker og kolonner | 

#### 2.3.5.1 Fremhævet tekst og andre typografiske afvigelser

Til gengivelse af fremhævet tekst benyttes elementet `<hi>`
(*highlighted*) med `@rend` (*rendition*), der beskriver tekstens
visuelle udtryk. Følgende attributværdier er tilladt:

| `hi/@rend` værdi | beskrivelse                                                  |           
|-------------|-------------------------------------------------------------------|
| `initial`   | initialbogstav, fx `<hi rend="smallcaps"><hi rend="initial">J</hi>eg ...</hi>` |
| `italic`    | kursiv fx `den berømte <hi rend="italic">Stærkodder II,</hi>`     |
| `small`     | petit/småt skriftsnit                                             |
| `smallcaps` | kapitæler fx `<hi rend="smallcaps">H. Johansen,</hi> Sagfører.`   |
| `spaced`    | spærret/spatieret fx `Kirkens <hi rend="spaced">egne</hi> Rammer` |
| `strong`    | fed                                                               |
| `sub`       | understillet                                                      |
| `sup`       | overstillet                                                       |
| `underline` | understreget                                                      |

#### 2.3.5.2 Citater

Citater bringes i elementet `<cit>` (*cited quotation*), som indholder
følgende elementer:

|element     | antal | beskrivelse                                                         |
|------------|-------|---------------------------------------------------------------------|
| `<quote>`  | 1     | selve citatet, som igen underordner et eller flere `<p>` el. `<lg>` |
| `<bibl>`   | 0..1  | (*bibliographic entry*) bibliografisk reference                     |

Et eksempel ses her:

```xml
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
```

<!--
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
`rdg>`, altså som

	... havde jo adskilligt 
	  <app>
	    <lem>at</lem>
	    <rdg><q>at at</q> Dittografi, fejlagtigt skrevet i forbindelse med 
	         et sideskift i brevet</rdg>
	  </app>
	tænke paa
-->

#### 2.3.5.3 Tekstkritik

Formålet med et tekstkritisk apparat er at vise læseren usikre læsemåder, og
hvilke dele af teksten skyldes emendering. Hertil anvendes elementet: `<app>`
(*apparatus entry*), som indeholder en post i et tekstkritisk apparat. 

Et `<app>`-element indeholder de to underelementer `<lem>` og `<rdg>`:

| element | antal | beskrivelse                                                           |
|---------|-------|-----------------------------------------------------------------------|
| `<lem>` | 1     | (*lemma*) indeholder den tekst, til hvilken findes en variant         | 
| `<rdg>` | 1     | (*reading*) indeholder et eller flere alternativer til lemmaets tekst |

Da elementet `<rdg>` ofte både indledes og afsluttes af redaktionelle
bemærkninger og sigelhenvisninger har vi valgt at lade elementet være
ustruktureret tekst med mulighed for at opmærke de konkrete læsemåder fra
forlægget med `<q>` (*quote*). 

For eksempel:

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

<!-- Til forklaring af emendationer kan udgiveren supplere `<rdg>` med elementet `<note>`. --> 
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

#### 2.3.5.4 Læsioner

Hvis tekstvidnet er beskadiget, anvendes elementet `<damage>`, typisk
under lemmaet i en tekstkritisk note. I nedenstående eksempel fra _Diplomatarium
Danicum_ suppleres lakunen med læsning i et andet tekstvidne *Aa*:

```xml
perpetui vicarii i sa<ex>m</ex>me stæth wore 
  <app>
    <lem>ski<damage>cket</damage>he</lem>
	<rdg>lakune A; <q>skickethe</q> Aa</rdg>
  </app> gothe beskethne me<ex>n</ex> ...
```

#### 2.3.5.5 Konjekturer

Til markering af tekst, som suppleres af redaktøren, anvendes elementet
`<supplied>`. Nedenstående eksempel kommer fra _Diplomatarium Danicum_:

```xml
presentibus 
  <app>
    <lem>e<supplied>s</supplied>t</lem>
	<rdg><q>et</q> Weibull, l.c</rdg>
  </app> appensum ...
```

#### 2.3.5.6 Udeladelser

Såfremt redaktøren ønsker at udelade tekst, kan dette gøres vha.
elementet `<gap>`. Et eksempel fra *Diplomatarium Danicum*, hvor
oversættelsen udelades i projektperioden 2017-2021:

```xml
<p>
  <gap>Oversættelse mangler</gap>
</p>
```

#### 2.3.5.7 Grafik

Til gengivelse af grafiske elementer i løbende tekst anvendes `<figure>`
eventuelt kvalificeret af `@rend="right"` til højrestilling af figuren.  Til
større grafiske elementer som billeder og figurer samler `<figure>` elementet
`<graphic>`, som rummer reference til billedfilen, og evt. en eller flere `<p>`
til billedtekst.

Til billeder anvendes elementet som i følgende eksempel:

```xml
... udgivelser, der faldt sidst på året.</p>
<figure rend="right">
  <p>Titelblad til <hi rend="italic">Aanden i Naturen</hi>, bind 1, 1. udgave, 1850 [1849]</p>
  <graphic url="392"/>
</figure>
<p> ...</p>
```

`<figure>` anvendes også til markering af typografisk adskillelse af afsnit ved
symboler og skillestreger. Her opmærkes med `<figure>` med attributtet `@type>`. En
asterisk mellem to afsnit opmærkes fx:

```
... i sine vildeste Drømme! — — </p>
</div>
<figure type="asterisk"/>
<div>
  <p> Efter Pers Bortrejse havde Jakobe, nu da hun ikke længer 
      paavirkedes umiddelbart af hans Person, ... 
```

Gyldige værdier af `<figure>`-elementets `@type>`:

| `@type`, værdi   | beskrivelse           |
|------------------|-----------------------|
| asterisk         | centreret asterisk    |
| asterism         | centreret asterisk    |
| fleuron          | centreret fleuron     |
| line             | centreret skillestreg |

#### 2.3.5.8 Formler

Matematiske formler opmærkes i `<formula>` udvidet med `@notation`. Foreløbig
tillades kun TeX-notation:

```xml
<p> Integralet 
<formula notation="TeX">\(\int_0^\infty e^{it}t^{x-1}dt\)</formula> 
er jo et "Dirichlet’s Integral" (ses strax naar 
<formula notation="TeX">\(x-1\)</formula> sættes lig 
<formula notation="TeX">\(-y\)</formula>; de Diri. Int. ... Form 
</p>
```

#### 2.3.5.9 Opløsning af abbreviaturer

Til optagelse af forkortelser og deres opløsninger i typisk middelalderlige
håndskrifter og tidlige tryk anvendes elementet `<ex>` (*editorial expansion*),
som udfyldes med tekst suppleret af redaktøren.

```xml
Oc weth<ex>e</ex>r kende hwn sigh ...
```

#### 2.3.5.10 Noter

Eksisterende fodnoter i den løbende tekst beskrives vha. elementet `<note>` med attributtet
`@place` udfyldt med værdien `<bottom>`. Eventuelle henvisningstegn opmærkes ikke.

```xml
... Enster<note place="bottom">
  <p>Ordet er allerede blevet brugt af <hi rend="italic">Risbrigh</hi> 
  og er udentvivl gammelt. Det fandtes i Ordet 
  <hi rend="italic">Eensterskilling</hi>, som i forrige Aarhundrede 
  endnu brugtes til at betegne en enkelt Skilling i Sølvmynt.</p>
  </note> (Individ) ...
```
 
#### 2.3.5.11 Personnavne

Personnavne opmærkes i den løbende tekst vha. elementet `<persName>` med
attributtet `@key` (_externally-defined means of identifying the
entity (or entities) being named, using a coded value of some
kind_) udfyldt med en unik id. 

```xml
I alle vore litterære Bevægelser i dette Aarhundredes Begyndelse, 
i <persName key="adam-oehlenschlager">Oehlenschlägers</persName> 
Poesier, i <persName key="n-f-s-grundtvig">Grundtvigs</persName>
Prædikener, i ... 
```
Bemærk at attributtet @key _skal_ være udfyldt, i det mindste med værdien 'nil'
der indikerer at personen endnu ikke er identificeret.

<!--
**Fiktive personer**. Såfremt der er behov for at opmærke **fiktive
personer**, anvendes `<persName` med to attributter: 1. `@key` udfyldt
med en unik id, og 2. `@type` udfyldt med værdien `<fictional`.
-->

#### 2.3.5.12 Stednavne

Stednavne opmærkes i den løbende tekst vha. elementet `<placeName>` med
attributtet `@key` udfyldt med en unik id. Et eksempel fra Georg
Brandes, Hovedstrømninger 1

```xml
... Ideer fra <placeName key="tyskland">Tydskland</placeName>, 
Revolutionens fra <placeName key="frankrig">Frankrig</placeName> ...
```


#### 2.3.5.13 Krydshenvisninger

Henvisninger til andre ressourcer i Tekstnet indsættes i elementet `<ref>` på
følgende måde:

```xml
... <ref target="14091009001" type="link">14091009001</ref> ...
```

<!--
**Normalisering af henvisninger**. I visse tilfælde kan det være
praktisk at lade originale henvisninger supplere med moderne
konventioner. Til dette formål anvendes hhv. elementerne `<orig>` til
originalformen og `<reg>` til den normaliserede form. I nedenstående
eksempel fra Hans Thomissøn, _Den danske Psalmebog_ (1569) ledsages
den oprindelige Bibelhenvisning _Luc. 21._ (opmærket med `<orig>`) af en
normaliseret og konventionel form _Luk. 21_ (opmærket med `<reg>`):

```
... Jesu Christi tilkommelse oc Dommedag ere nær / 
			(<ref target="#luk-21">
                            <orig>Luc. 21.</orig>
                            <reg>Luk. 21</reg>
                         </ref>) Derfor effterdi at ...

```
-->

#### 2.3.5.14 Kommentarer

Kommentarer opmærkes i to dele: I teksten indsættes en henvisning i et tomt
`<ref>`-element med `@target` og værdi svarende til en tabel-header i den
tilhørende kommentarfil med poster bestående af lemma og note. Følgende regler gælder:

1. Kommentarfilen navngives med samme filnavn som den dsl-tei-fil, den
   ledsager, men med ekstensionen .toml. Til dsl-tei-filen
   `oersted-hc_aanden-i-naturen-1.xml` svarer således kommentarfilen
   `oersted-hc_aanden-i-naturen-1.toml`. 
2. Værdien af henvisningens `@target` skal bestå af _n_ efterfulgt af et tal, fx
   `n1`, `n2`, `n3`, osv. 
3. Af hensyn til overskueligheden i organiseres noterne så vidt muligt i
   rækkefølge i såvel tekst som kommentarfil. 

Følgende henvisninger:

```xml
Forholdet mellem Tænkningens og <ref target="n5"/>Indbildningskraftens 
<ref target="n6"/>Naturopfatning.
```
svarer til følgende tabeller i TOML-filen:

```toml
[n5]
lemma = "Indbildningskraftens"
note = "forestillingsevnens, fantasiens."

[n6]
lemma = "Naturopfatning"
note = "opfattelse af naturen."
```
Henvisningen placeres enten før eller efter den tekst, kommentaren
knyttes til.

Links i kommentarer skrives som i eksemplet her:

```toml
lemma = "o.s.v."
note = "jf. nr. <a href='/books/dipdan/1400/dd_14000121002'>213</a>."
```

Bemærk at attributværdien af `@href` omkranses af enkelte citationstegn.

#### 2.3.5.15 Sideskift i forlæg

Sideskift i forlæg markeres med det lukkede element `<pb>` (_page beginning_).
Elementet  kan indeholde tre attributter:

| attribut | antal | beskrivelse                                                                     |
|----------|-------|---------------------------------------------------------------------------------|
| `@ed`    | 1     | (*edition*) udfyldes med sigelværdien for det tekstvidne, der transkriberes fra |
| `@n`     | 1     | (*number*) udfyldes med tekstvidnets sidetal. Hvis tekstvidnet ikke har paginering, indsættes sidetal i skarpe parenteser, jf. `n="[2]"`|
| `@facs`  | 0..1  | (*facsimile*) udfyldes med en fil-id for den tilknyttede faksimile              |


#### 2.3.5.16 Fremmede tegn

Til opmærkning af arabiske og hebræiske tegn anvendes elementet `<term>`
med `@xml:lang`. Fx hos Thomas Bartholin:
<!--
```xml
per <term xml:lang="ar">س</term>, non <term xml:lang="ar">ش</term> expressum ...
```

```xml
Unde &amp; Hebræis <term xml:lang="he">קנה</term> de hasta ...
```
-->

<!--
#### 2.3.5.16 Bibliografiske henvisninger

Henvisninger til værker i den løbende tekst mærkes med elementet
`bibl` (*bibliographic citation*). Elementet kan rumme attributtet
`@ref`, hvis værdi enten peger på 1. dokumentets egen bibliografi
eller 2. en ekstern database.

Et eksempel fra Georg Brandes *Hovedstrømninger*, bd. 1:

```xml
Martensens »Speculative Dogmatik« afløses af den 
»<bibl ref="martensen-den-christelige-dogmatik">Christelige Dogmatik</bibl>«.

#### 2.3.5.X Værktitler

Henvisninger til værker i løbende tekst opmærkes vha. elementet `<title>`,
som yderligere kan udvides med attributten `@ref`. Eksempler kan
findes i Hans Thomissøns Den danske Psalmebog. 
-->

#### 2.3.5.17 Tabeller

Tabeller opmærkes vha. elementet `<table>` som kan indeholde følgedende elementer: 

| element | antal | beskrivelse                                                           |
|---------|-------|-----------------------------------------------------------------------|
| `<row>` | 1..n  |  (række) indeholder en række i en tabel                               |

Elementet `<row>` har dette indhold:

| element | antal | beskrivelse                                                           |
|---------|-------|-----------------------------------------------------------------------|
| `<cell>`| 1..n  |  indeholder en celle i en tabelrække                                  |


Tabeller kan anvendes til opmærkning af middelalderlige regnskaber. I
Diplomatarium Danicum

```xml
<table>
  <row>
    <cell rows="3"> Summen af guld ...</cell>
    <cell> 324 små floriner </cell>
    <cell rows="2">i guld.</cell>
  </row>
  <row>
    <cell> 55 masse. 12 aignel. </cell>
  </row>
  <row>
    <cell cols="2"> 2 mark ½ ørtug ... </cell>
  </row>
</table>
```

