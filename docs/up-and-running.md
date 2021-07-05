---
title: Up and running with dsl-tei
author: Thomas Hansen (<th@dsl.dk>)
fontsize: 10pt
fontfamily: palatino
indent: true
language: en-US
papersize: a4
---

## How to use this tutorial

The current tutorial makes use of a tool called a 'shell'.  By 'shell'
we mean the command interpreter in a Unix or Unix-like operating
system that users interact with by typing in commands. To access the
shell Linux and macOS users may search for 'Terminal' among their
applications; Windows 10 users may install a Linux subsystem, and
access a terminal from there.

In this tutorial we follow the convention of using `$` to denote the
(Bash) shell prompt for a normal, unprivileged user.[^1] It's the
shell's way of saying: "I'm ready for executing commands that can be
run without special privileges". Placeholders (e.g. command arguments
that should not be taken literally) are delimited with `<` and `>`.
For instance, in the following example:

```
$ cp <file> <directory>
```

\noindent you're __only__ supposed to enter `cp`, followed by the real
name of the file and the real name of the directory. You're __not__
supposed to write out the `$`, the `<` and the `>`. Also note that a
command is always concluded by entering __Return__.

[^1]: If you're using a Mac newer than 2019, you'll be met by a `%`
  prompt instead of a `$`. This is because Apple is now using the Z
  Shell instead of Bash (Bourne Again Shell).

### Requirements

As a prerequisite for following this tutorial, some software must be
installed:

Oxygen XML Editor
: XML IDE that allows validation of XML documents on the fly
  and transformation into readable HTML.[^2] A license key authorizing
  the use of this program may be obtained from your project lead.

Git 
: version control system that enables tracking of changes in the
  project source texts. This software is open source and so requires no
  license key.[^3]

\noindent Finally, a (free) Github account must be created[^4]. Github
provides a hosted collaborative version control platform for storing
and exchanging project source code. After signing up, please send the
user name to the project lead. You'll then be affiliated with the
project.

[^2]: Download: <https://www.oxygenxml.com/xml_editor/download_oxygenxml_editor.html>.
[^3]: Cf. <https://git-scm.com/book/en/v2/Getting-Started-Installing-Git>.
[^4]: Please sign up at <https://github.com/>.



## Set up a workspace

With all requirements in place, we'll start by using the shell to set
up a workspace on our local computer. Since this is for introductory
purposes, we'll set it up in the so-called `home` directory.

1. To find out where on your computer you're located; open a terminal,
   and check that you're in the home directory by listing what's in
   the current directory. This is done by writing 

   `$ ls`

   If a `~` (tilde) comes before the `$` prompt, like this: `~$`, you're in the
   right place.[^5] 
2. After establishing that you are in fact in the home directory, create a
   workspace, e.g. 'dsl-workspace' (or pick another name)[^6], for DSL
   projects by entering:

   `$ mkdir dsl-workspace`

   Now, when you run the `ls` command, the `dsl-workspace` directory
   should appear in the listing.

Your workspace is now ready for use.

[^5]: To be sure, the home directory is usually where folders like
  'Documents' and 'Download' are located. If you have reason to
  believe that you're _not_ located in the home directory, write `cd`
  (_change directory_); and check again by repeating the `ls` command,
  while looking out for the `~$` prompt. 
[^6]: If you _do_ decide to give your workspace another name, remember
  to subsequently use that name instead of `dsl-workspace`. 

## Access to Github

The local workspace is where all the work is done. However, to safely
collaborate and exchange work with colleagues, you need permission to
publish on Github; therefore a set of SSH keys must be generated and
associated with your Github account.[^6a]

1. Open a terminal, and enter the below command (replacing the dummy
   email address with your own):

  `$ ssh-keygen -t ed25519 -C "<your_email@example.com>"`

3. When you're prompted to "Enter a file in which to save the key",
   press Enter. This accepts the default file location.
4. At the prompt, type a password of your own choosing, and enter the
   same password again for verification.
5. Now, copy the public key to the clipboard:[^7]

  `$ xclip -selection clipboard < ~/.ssh/id_ed25519.pub`

6. Open your Github account. In the upper-right corner of any
   page, click your profile photo (or avatar), and then click
   __Settings__.
7. In the user settings sidebar, click __SSH and GPG keys__
8. Click __New SSH key__ or __Add SSH key__.
9. In the "Title" field, add a descriptive label for the new key. For
   example, if you're using a personal Mac, you might call this key
   "Personal MacBook Air".
10. Paste your key into the "Key" field by right clicking in the field
    and choosing 'Paste'
11. Click __Add SSH key__
12. If prompted, confirm your GitHub password.

[^6a]: The Secure Shell (SSH) protocol is a cryptographic network
  protocol for operating network services securely over an unsecured
  network.
[^7]: If xclip doesn't work, simply write out the public key to standard
  output instead: `$ cat .ssh/id_ed25519.pub`. Use your mouse to copy
  the resulting output to the clipboard; then proceed to item 6. Ouput
  should look like this: `ssh-ed25519
  AAAAC3NzaC1lZDI1NTE5AAAAIMTYHZWqkbPvaBpcFWAcR17sldbYJk3Irqy6rwvh5WgE
  your_email@example.com`.

## Get the texts

Having set up a workspace for your DSL project, the next step is to
acquire the relevant project texts. This is the done by 'cloning' the
repository holding the texts on Github into your workspace. To 'clone'
is git jargon for getting a copy of a remote repository and keeping it
under version control.

1. If not already running, open a terminal, and go to the
   `dsl-workspace` folder. This is done by writing:

   `$ cd dsl-workspace`

2. Visit the text repository link on Github, and click on the __Code__ button.
3. Copy the SSH link to the clipboard
4. Return to the terminal, and enter:

   `$ git clone git@github.com:dsldk/<repository-name>.git`

5. Verfiy that the text repository has in fact been cloned to your
   workspace by executing the `ls` command.

## Get the stylesheets

After you have cloned or downloaded the relevant text repository from
[Github](https://github.com/dsldk), it is time to configure a
transformation scenario in order to be able to obtain a version of the
text suited for quality assurance purposes (proof reading, testing
etc.). First, get the stylesheets:

1. Open a terminal emulator, and go to the `dsl-workspace` folder by
   entering:

   `$ cd dsl-workspace`

2. Get the stylesheets by cloning the `dsl-tei` repository like so:

   `$ git clone git@github.com:dsldk/dsl-tei.git`

3. Verify that the `dsl-tei` directory is present in the workspace
   folder by running `ls`.


## Set up transformation in Oxygen

When you have cloned the stylesheets, it's time to put these to work
with an XSLT processor. The next part of this tutorial shows how to do
this using the Oxygen XML Editor.

1. Start Oxygen, and open (__Ctrl+O__) an XML file from your text
   repository. This file will be the first one that we will transform.
2. Use the shortcut __Ctrl+Shift+C__. This opens the 'Configure
   Transformation Scenario' dialogue box.
3. In the 'Configure Transformation Scenario', click the __New__
   button, and, from the drop-down menu, select _XML Transformation
   with XSLT_. This will open the 'New scenario' dialogue box.
4. In the 'New scenario' box
    - Fill in the __Name__ field with a name, for instance
      'dsl-scenario'.
    - Check that the XML URL field has the default value: `${currentFileURL}`
    - Fill in the XSL URL field by using the 'Browse for local file'
      option, and select the `fulltext.xsl` file in the `dsl-tei/xsl`
      directory.
    - In the Transformer menu, pick the default 'Saxon-PE 9.9.1.7' processor (or a later version)
5. Click the Output tab, and:
    - Check the 'Save as' radio button.
    - Fill in the 'Save as' field by using the 'Browse for local file'
      option and selecting the `dsl-tei/html/`. 
    - Append this variable `${cfn}.html`, so that the last part of the path looks
      like this: `/dsl-tei/html/${cfn}.html`
    - Check the 'Open in browser/System Application' check box, and keep the default 'Saved
      file' radio button activated.
6. Click the 'OK' button, and you're done.
