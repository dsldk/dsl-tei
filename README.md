# dsl-tei

Et skema med tilhørende vejledning og stylesheets til medarbejdere ved [Det
Danske Sprog- og Litteraturselskab](https://dsl.dk/)s tekstudgivelsesprojekter.

Klon eller download dsl-tei, når du skal udgive tekster til Det Danske Sprog- og
Litteraturselskabs udgivelsesplatform [Tekstnet](https://text.dsl.dk/). Skemaet
implementerer den del af standarden [TEI P5](https://tei-c.org/release/doc/tei-p5-doc/en/html/index.html) som af
redaktionen anses for nødvendig for at publicere på Tekstnet.

## Sådan kommer du i gang

__Forudsætninger__

Du skal først:

- have en brugerprofil på Github
- have en gyldig SSH-nøgle uploadet til Github. [Se
  vejledning](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key)

Herefter:

1. Åbn en terminal
2. Hvis du er Linux Ubuntu- eller Debian-bruger, kan du for at installere det
   grundlæggende køre:
   
   ```
   wget -O - https://raw.githubusercontent.com/dsldk/dsl-tei/master/tools/bootstrap.sh | bash
   ```
   Hvis du er OS X-bruger kører du i stedet:

   ```
   curl -sSL https://raw.githubusercontent.com/dsldk/dsl-tei/master/tools/bootstrap.sh | zsh
   ```

3. Læs vejledning i [opsætning af arbejdsområde](docs/up-and-running.md)
4. Læs [retningslinjerne](docs/dsl-tei.md)


## Bugs og ønsker til nye features

Brug [trackeren](https://github.com/dsldk/dsl-tei/issues) til indrapportering af
bugs, ønsker til ny funktionalitet og åbning af pull requests.


## Redaktion

dsl-tei er udviklet af Thomas Hansen (th@dsl.dk) med bidrag fra Axel Teich
Gertinger og Finn Gredal Jensen.


## Copyright

Kode og dokumentation copyright Det Danske Sprog- og Litteraturselskab.  Koden
udgives under [MIT-licens](https://github.com/dsldk/dsl-tei/blob/master/LICENSE.md),
dokumentationen under [Creative Commons](https://creativecommons.org/licenses/by/4.0/).

<!--

I dette repositorium, <https://github.com/dsldk/dsl-tei>, findes materiale til 
brug i udarbejdelse af udgivelser i Det Danske Sprog- og Litteraturselskab, DSL.

* `css/` -- stylesheets som benyttes til visning af HTML-dokumenter, som
  befinder sig html-mappen
* `doc/` -- dokumentation af opmærkningspraksis og udgivelsesprincipper
* `html/` -- HTML-dokumenter som er resultat af transformation af
  XML-dokumenter vha. de XSLT-stylesheets som befinder sig i xslt-mappen
* `rnc/` -- RELAX NG-skema til validering af dokumenter som overholder
  dsl-tei
* `xml/` -- her findes eksempel-dokumenter, som demonstrerer, hvordan
tekster kan opmærkes efter retningslinjer, der er beskrevet i
[Retningslinjerne](https://github.com/dsldk/dsl-tei/blob/master/doc/dsl-tei.md)
* `xslt/` -- stylesheets til transformation af XML-dokumenter der
  validerer med skemaet

  -->
