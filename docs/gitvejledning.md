---
title: Gitvejledning
author: Thomas Hansen (<th@dsl.dk>)
fontsize: 10pt
fontfamily: palatino
indent: true
language: en-US
papersize: a4
---

# Godt igang med Git

## Installer Git

Tjek allerførst, om Git er installeret på din maskine. Hvis du
benytter en af DSL's arbejdsstationer, kan du se bort fra dette
kapitel, for her er Git allerede installeret. Relevant bliver
spørgsmålet, hvis du fx benytter en bærbar computer. Begynd derfor med
at åbne en terminal og skrive:

```bash
$ git --version
```
\noindent Hvis terminalen svarer:

```
git version 2.25.1
```

\noindent betyder det, at Git allerede _er_ installeret. Hvis ikke kan du gøre
følgende alt efter hvilket styresystem du benytter:

__Linux (Ubuntu)__. I terminalen skriver du 

```bash
$ sudo apt update
$ sudo apt install git
```

__macOS__. I terminalen er det nok at skrive `git`; herefter vil du
ledt igennem installation af de nødvendige udviklerværktøjer.

__Windows 10__. Installer Git og Gitbash.


## Sådan bruger du Git

I dit projekts rodmappe, begynder du med at initialisere et
_repositorium_:

```bash
$ git init
```

Hermed etableres et projektrepositorium, og der er således nu en
skjult mappe `.git` i projektets rodmappe. -- Du kan se efter ved at
køre kommandoen `ls -lha`.

I forbindelse med dit arbejde vil der uvægerligt være filer, du _ikke_
ønsker at spore med Git: systemfiler, midlertidige filer, filer
genereret i forbindelse med bygning osv. Den slags filer kan undgås
ved at opføre dem i en fil, kaldet `.gitignore`, fx med følgende indhold:

```bash
# npm debugging logs
npm-debug.log*

# project dependencies
node_modules

# OSX folder attributes
.DS_Store


# temporary files
*.tmp
*~
```

Hvis der er andet, du gerne vil udelade i sporingen, kan de indsættes.
Hvis du fx ved at dine kolleger laver `.bak`-filer, tilføjer du
`*.bak` til listen.

En kommando du kommer til at benytte meget, er `git status`, som
fortæller dig status for det repositorium, du befinder dig i. Prøv at
køre kommandoen; du skulle gerne se noget i retning af:

```bash
$ git status
On branch master

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	.gitignore

nothing added to commit but untracked files present (use "git add" to track)
```

Det væsentlige her er, at Git fortæller, at der er en ny fil i
mappen (_.gitignore_), men at den ikke spores; det vil sige at Git
ser bort fra den.

Den basale arbejdsenhed i et Git-repositorium er et _commit_. I
øjeblikket har dit repositorium ingen commits; du har kun
initialiseret det og lavet en fil, men du har endnu ikke registreret
noget arbejde med Git. Og eftersom Git ikke gør sig nogen formodninger
om, _hvilke_ filer du gerne vil spore, er du nødt til her at tilføje
_.gitignore_ til repositoriet: 

```bash
$ git add .gitignore
```

Vi har stadig ikke foretaget et commit; vi har blot forberedt (_staged_) filen
_.gitignore_ til at være en del af næste commit. Kører vi derfor igen
`git status`, ser vi følgende:

```bash
$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
	new file:   .gitignore
```

Nu er _.gitignore_ klar til at blive committet. Vi har endnu ikke
foretaget vores commit, men når vi gør det, vil vores ændringer af
filen _.gitignore_ være med. Vi kunne godt tilføje flere filer, men
lad os foreløbig foretage vores første commit:

```bash
$ git commit -m "Første commit: tilføjet .gitignore."
```

Strengen efter `-m` er commit-beskeden: en kort redegørelse for det
arbejde, der ligger i din commit. På den måde kan gå tilbage i
meddelelseshistorikken og se hvordan projektet udvikler sig. 

Du kan se på et commit som et øjebliksbillede af dit projekt. Vi har
taget dette øjebliksbillede (som ikke indholder andet end din
_.gitignore_-fil), således at du fremover -- på et hvilket som helst
tidspunkt -- vil kunne gå tilbage til det tidspunkt i din historik.
Hvis du kører `git status` nu, vil Git fortælle dig:

```bash
$ git status
On branch master
nothing to commit, working tree clean
```

Lad os arbejde videre med vores projekt. I vores _.gitignore_-fil,
ignorerer vi eksempelvis. Ret linjen `npm-debug.log*` i _.gitignore_
til `*.log` for at ignorere _alle_ logfiler i sporingen. Lad os
desuden tilføje filen _README.md_, som er standardmåden at forklare
projektets formål i det udbredte Markdown-format:

```markdown
# Mit Git-projekt

## Git

Her lærer jeg om Git. Her samler jeg noter om sagen.
```

Skriv derefter `git status`:

```bash
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   .gitignore

no changes added to commit (use "git add" and/or "git commit -a")
```

Vi har nu to ændringer: den ene til den allerede sporede fil
(_.gitignore_), den anden til den nye fil (_README.md_). Vi kunne nu
tilføje ændringerne som vi gjorde før:

```bash
$ git add .gitignore
$ git add README.md
```

Imidlertid vil vi denne gang bruge en genvej til at tilføje alle
ændringerne, og derefter foretage et commit med alle ændringerne:

```bash
$ git add -A
$ git commit -m "Ignorerede alle .log-filer og tilføjet README.md."
```

At tilføje ændringer og dernæste committe disse er et almindeligt
arbejdsmønster, som du kommer til at gentage igen og igen. Forsøg at
lave dine commits små og logisk konsistente; tænk gerne på dem som en
historie, du fortæller om dit arbejde og de tanker, der ligger bagved.
Når du laver ændringer i dit repositorium, kommer du til at følge
samme mønster: tilføj en ændring, foretag derpå commit.

> Begyndere bliver ofte forvirrede af `git add`, fordi betegnelsen
> synes at betyde at man tilføjer filer til repositoriet. Ganske vist
> _kan_ ændringerne være tilføjelse af filer, men tilføjelsen går líge
> så ofte slet og ret på tilføjelse af ændringer af allerede sporede
> filer. En ny fil er med andre ord blot en af mange slags
> tilføjelser.

Forløbet, vi har beskrevet ovenfor, viser den mest basale
Git-arbejdsgang. Du kan lære mere om Git i [denne
tutorial](https://docs.github.com/en/get-started/quickstart/set-up-git).

## Opret en konto på Github

For at kunne bruge Git og Github i forening skal du oprette en gratis
konto på <https://github.com>. Vælg et brugernavn, der er så kort som
muligt og består af små bogstaver. Husk dit kodeord -- det får du brug
for senere. 

Når du har oprettet dit brugernavn skal du sende det til din
projektleder, som vil sørge for at du blive tilknyttet de
repositorier, der er relevante for dig. 

# Opsætning

Først skal Git konfigureres, således at dit arbejde får den korrekte
signatur og benytter det tekstbehandlingsværktøj, du bedst kan lide at
arbejde med.

1. Åbn en terminal.
2. Fortæl Git, hvad dit brugernavn på Github er:

  ```bash
  $ git config --global user.name "brugenavn123"
  ```
3. Angiv herefter hvilken email du benytter på Github
  ```bash
$ git config --global user.email "bruger@dsl.dk"



