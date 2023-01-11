<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
	xmlns:tei="http://www.tei-c.org/ns/1.0" 
	xmlns:functx="http://www.functx.com"
  exclude-result-prefixes="xs tei functx" version="2.0">
	<xsl:include href="ab.xsl"/>
  <xsl:include href="abstract.xsl"/>
  <xsl:include href="additions.xsl"/>
  <xsl:include href="app.xsl"/>
  <xsl:include href="appInfo.xsl"/>
  <xsl:include href="application.xsl"/>
  <xsl:include href="bibl.xsl"/>
  <xsl:include href="byline.xsl"/>
  <xsl:include href="c.xsl"/>
  <xsl:include href="cit.xsl"/>
  <xsl:include href="closer.xsl"/>
  <xsl:include href="condition.xsl"/>
  <xsl:include href="creation.xsl"/>
  <xsl:include href="damage.xsl"/>
  <xsl:include href="date.xsl"/>
  <xsl:include href="dateline.xsl"/>
  <xsl:include href="dimensions.xsl"/>
  <xsl:include href="div.xsl"/>
  <xsl:include href="docAuthor.xsl"/>
  <xsl:include href="docEdition.xsl"/>
  <xsl:include href="docImprint.xsl"/>
  <xsl:include href="docTitle.xsl"/>
  <xsl:include href="emph.xsl"/>
  <xsl:include href="encodingDesc.xsl"/>
  <xsl:include href="epigraph.xsl"/>
  <xsl:include href="ex.xsl"/>
  <xsl:include href="extent.xsl"/>
  <xsl:include href="figure.xsl"/>
  <xsl:include href="foreign.xsl"/>
  <xsl:include href="gap.xsl"/>
  <xsl:include href="handDesc.xsl"/>
  <xsl:include href="head.xsl"/>
  <xsl:include href="height.xsl"/>
  <xsl:include href="hi.xsl"/>
  <xsl:include href="history.xsl"/>
  <xsl:include href="imprimatur.xsl"/>
  <xsl:include href="item.xsl"/>
  <xsl:include href="keywords.xsl"/>
  <xsl:include href="l.xsl"/>
  <xsl:include href="langUsage.xsl"/>
  <xsl:include href="lb.xsl"/>
  <xsl:include href="lg.xsl"/>
  <xsl:include href="list.xsl"/>
  <xsl:include href="listBibl.xsl"/>
  <xsl:include href="listWit.xsl"/>
  <xsl:include href="msDesc.xsl"/>
	<xsl:include href="msIdentifier.xsl"/>
	<!--<xsl:include href="notatedMusic.xsl"/>-->
  <xsl:include href="note.xsl"/>
  <xsl:include href="objectDesc.xsl"/>
  <xsl:include href="opener.xsl"/>
  <xsl:include href="orig.xsl"/>
  <xsl:include href="p.xsl"/>
  <xsl:include href="pb.xsl"/>
  <xsl:include href="persName.xsl"/>
  <xsl:include href="physDesc.xsl"/>
  <xsl:include href="placeName.xsl"/>
  <xsl:include href="postscript.xsl"/>
  <xsl:include href="profileDesc.xsl"/>
  <xsl:include href="projectDesc.xsl"/>
  <xsl:include href="q.xsl"/>
  <xsl:include href="ref.xsl"/>
  <xsl:include href="reg.xsl"/>
  <xsl:include href="salute.xsl"/>
  <xsl:include href="samplingDecl.xsl"/>
  <xsl:include href="sealDesc.xsl"/>
  <xsl:include href="signed.xsl"/>
  <xsl:include href="sourceDesc.xsl"/>
  <xsl:include href="sp.xsl"/>
  <xsl:include href="speaker.xsl"/>
  <xsl:include href="stage.xsl"/>
  <xsl:include href="supplied.xsl"/>
  <xsl:include href="support.xsl"/>
  <xsl:include href="supportDesc.xsl"/>
  <xsl:include href="table.xsl"/>
  <!--  <xsl:include href="text.xsl"/>-->
  <xsl:include href="textClass.xsl"/>
  <xsl:include href="title.xsl"/>
  <xsl:include href="w.xsl"/>

  <xsl:output method="html" indent="yes" encoding="UTF-8" omit-xml-declaration="yes"/>
  <xsl:strip-space elements="*"/>
  <xsl:preserve-space elements="tei:p"/>
  <!--Function that capitalizes first letter-->
  <xsl:function name="functx:capitalize-first" as="xs:string?" xmlns:functx="http://www.functx.com">
    <xsl:param name="arg" as="xs:string?"/>
    <xsl:sequence select="concat(upper-case(substring($arg, 1, 1)), substring($arg, 2)) "/>
  </xsl:function>
  <!--Old way of getting the basename <xsl:variable name="basename" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/@xml:id"/>-->
  <xsl:variable name="basename" select="substring-before(tokenize(base-uri(), '/')[last()], '.xml')"/>
  <xsl:variable name="title-text" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[not(@xml:lang='en')]"/>
  <xsl:variable name="title-text-en" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@xml:lang='en']"/>
  
	<xsl:template match="/">
    <xsl:apply-templates/>
	</xsl:template>

  <xsl:template match="tei:TEI">
    <!--Make Danish version of "colophon" file-->
    <xsl:result-document href="{$basename}/000_colophon.md">
      <xsl:text>---
title: kolofon
layout: colophon
weight: -10
---
</xsl:text>
    </xsl:result-document>
    <!--Make English version of "colophon" file-->
    <xsl:result-document href="{$basename}/000_colophon.en.md">
      <xsl:text>---
title: colophon
layout: colophon
weight: -10
---
</xsl:text>
    </xsl:result-document>
    
    <!--Make Danish version of "sources" file-->
    <xsl:result-document href="{$basename}/000_sources.md">
      <xsl:text>---
title: tekstforhold
layout: sources
weight: -5
---

</xsl:text>
      <xsl:for-each select="//tei:witness"><xsl:text>

</xsl:text>
        <xsl:value-of select="@xml:id"/><xsl:text>
:  </xsl:text><xsl:choose>
  <xsl:when test="tei:bibl"><xsl:apply-templates/></xsl:when><xsl:when test="tei:msDesc">
    <xsl:for-each select="tei:msDesc/tei:msIdentifier/child::node()[text()!='empty']">
      <xsl:apply-templates select="."/>
      <xsl:if test="position() != last()">, </xsl:if>
      <xsl:if test="position() = last() and child::node() != 'empty'">. </xsl:if>
    </xsl:for-each>
  </xsl:when></xsl:choose></xsl:for-each>
    </xsl:result-document>
    
    <!--Make English version of "sources" file-->
    <xsl:result-document href="{$basename}/000_sources.en.md">
      <xsl:text>---
title: sources
layout: sources
weight: -5
---

</xsl:text>
      <xsl:for-each select="//tei:witness"><xsl:text>

</xsl:text>
        <xsl:value-of select="@xml:id"/><xsl:text>
:  </xsl:text><xsl:choose>
  <xsl:when test="tei:bibl"><xsl:apply-templates/></xsl:when><xsl:when test="tei:msDesc">
    <xsl:for-each select="tei:msDesc/tei:msIdentifier/child::node()[text()!='empty']">
      <xsl:apply-templates select="."/>
      <xsl:if test="position() != last()">, </xsl:if>
      <xsl:if test="position() = last() and child::node() != 'empty'">. </xsl:if>
    </xsl:for-each>
  </xsl:when></xsl:choose></xsl:for-each>
    </xsl:result-document>
    <xsl:result-document href="{$basename}/toc.md">
---
title: Indholdsfortegnelse
type: nodisplay
---

      <!--This section generates the Danish (Markdown) list of contents. Do
    not reformat or pretty-print the XML markup below this line -->
      <xsl:for-each select="//tei:text/*/*">
        <xsl:variable name="page-name"><xsl:number count="/tei:TEI/tei:text/*/*" level="any" format="001"/></xsl:variable>
- <xsl:choose> <xsl:when test="name() = 'titlePage'">[Titelblad]</xsl:when>
  <xsl:when test="./@xml:id = 'dedikation'">[Dedikation]</xsl:when>
  <xsl:when test="./@xml:id = 'motto'">[Motto]</xsl:when>
  <xsl:when test="tei:head[@type='add'] 
    | tei:head[not(@xml:lang='en')]/text() 
    | tei:head/tei:reg[not(@xml:lang='en')]">[<xsl:value-of select="tei:head[@type='add'] | tei:head[not(@xml:lang='en')]/text() | tei:head/tei:reg[not(@xml:lang='en')]"/>]</xsl:when>
  <xsl:otherwise>[<xsl:value-of select="$title-text"/>]</xsl:otherwise>
</xsl:choose>(../<xsl:value-of select="$page-name"/>)</xsl:for-each>
    </xsl:result-document>

    <!--Below the English version of the Table of Contents (TOC)-->

    <xsl:result-document href="{$basename}/toc.en.md">
---
title: "Table of contents"
type: nodisplay
---

      <!-- This section generates the English (Markdown) list of contents. Do
      not reformat or pretty-print the XML markup below this line -->
      
      <!-- If an English version of the head element exists, use it; otherwise
      use the Danish one as fallback. If there are no head elements (as is often
      the case with short texts like poems etc.) use the title -->
      
      <xsl:for-each select="//tei:text/*/*">
        <xsl:variable name="page-name"><xsl:number count="/tei:TEI/tei:text/*/*" level="any" format="001"/></xsl:variable>
- <xsl:choose> <xsl:when test="name() = 'titlePage'">[Title page]</xsl:when>
  <xsl:when test="./@xml:id = 'dedikation'">[Dedication]</xsl:when>
  <xsl:when test="./@xml:id = 'motto'">[Motto]</xsl:when>
  <xsl:when test="tei:head[@type='add']
    | tei:head[@xml:lang='en']/text()
    | tei:head/tei:reg[@xml:lang='en']">[<xsl:value-of select="tei:head[@type='add'] | tei:head[@xml:lang='en']/text() | tei:head/tei:reg[@xml:lang='en']"/>]</xsl:when>
  <xsl:when test="tei:head/tei:reg[not(xml:lang='en')]">[<xsl:value-of select="tei:head/tei:reg[not(xml:lang='en')]"/>]</xsl:when>
  <xsl:otherwise>[<xsl:value-of select="$title-text-en"/>]</xsl:otherwise>
  </xsl:choose>(../<xsl:value-of select="$page-name"/>)</xsl:for-each>
    </xsl:result-document>
		<xsl:apply-templates select="tei:text"/>
	</xsl:template>

	<xsl:template match="tei:text">
	  <xsl:apply-templates/>
	</xsl:template>
  <xsl:template match="tei:text/child::*/child::*">
    
    <!-- Count all chapters under front, body, and back in one
         sequence, and store them in a page-name variable -->
    
    <xsl:variable name="page-name">
      <xsl:number count="/tei:TEI/tei:text/*/*" level="any" format="001"/>
    </xsl:variable>
    <xsl:variable name="page-weight">
      <xsl:number count="/tei:TEI/tei:text/*/*" level="any" format="1"/>
    </xsl:variable>
    
    <!-- Generate default Danish version of chapter -->
    
    <xsl:result-document href="{$basename}/{$page-name}.html">
---
title: "<xsl:choose>
  <xsl:when test="./@xml:id = 'titelblad'">Titelblad</xsl:when>
  <xsl:when test="./@xml:id = 'dedikation'">Dedikation</xsl:when>
  <xsl:when test="./@xml:id = 'motto'">Motto</xsl:when>
  <xsl:otherwise><xsl:value-of select="tei:head[@type='add']|tei:head/tei:reg[not(@xml:lang='en')]"></xsl:value-of></xsl:otherwise>
</xsl:choose>"
weight: <xsl:value-of select="$page-weight"/>
---

      <div class="text-container">
        <xsl:apply-templates/>
      </div>
    </xsl:result-document>
    
    <!-- Generate English version of chapter -->
    
    <xsl:result-document href="{$basename}/{$page-name}.en.html">
---
title: "<xsl:choose>
  <xsl:when test="./@xml:id = 'titelblad'">Title page</xsl:when>
  <xsl:when test="./@xml:id = 'dedikation'">Dedication</xsl:when>
  <xsl:when test="./@xml:id = 'motto'">Motto</xsl:when>
  <xsl:otherwise><xsl:choose>
    <xsl:when test="tei:head/tei:reg[@xml:lang='en']"><xsl:value-of select="tei:head[@type='add']|tei:head/tei:reg[@xml:lang='en']"></xsl:value-of></xsl:when>
    <xsl:otherwise><xsl:value-of select="tei:head[@type='add']|tei:head/tei:reg"></xsl:value-of></xsl:otherwise>
  </xsl:choose>
  </xsl:otherwise>
</xsl:choose>"
weight: <xsl:value-of select="$page-weight"/>
---
      
      <div class="text-container">
        <xsl:apply-templates/>
      </div>
    </xsl:result-document>
  </xsl:template>
</xsl:stylesheet>
