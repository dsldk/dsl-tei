<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:functx="http://www.functx.com"
  exclude-result-prefixes="xs tei functx" version="2.0">
  <xsl:include href="ab.xsl"/>
  <xsl:include href="abstract.xsl"/>
  <xsl:include href="additions.xsl"/>
  <xsl:include href="app.xsl"/>
  <xsl:include href="appInfo.xsl"/>
  <xsl:include href="application.xsl"/>
  <xsl:include href="back.xsl"/>
  <xsl:include href="bibl.xsl"/>
  <xsl:include href="body.xsl"/>
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
  <xsl:include href="docImprint.xsl"/>
  <xsl:include href="docTitle.xsl"/>
  <xsl:include href="emph.xsl"/>
  <xsl:include href="encodingDesc.xsl"/>
  <xsl:include href="epigraph.xsl"/>
  <xsl:include href="ex.xsl"/>
  <xsl:include href="extent.xsl"/>
  <xsl:include href="figure.xsl"/>
  <xsl:include href="front.xsl"/>
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
  <xsl:include href="orig.xsl"/>
  <xsl:include href="p.xsl"/>
  <xsl:include href="pb.xsl"/>
  <xsl:include href="persName.xsl"/>
  <xsl:include href="physDesc.xsl"/>
  <xsl:include href="placeName.xsl"/>
  <xsl:include href="profileDesc.xsl"/>
  <xsl:include href="projectDesc.xsl"/>
  <xsl:include href="q.xsl"/>
  <xsl:include href="ref.xsl"/>
  <xsl:include href="reg.xsl"/>
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
	<!--	<xsl:include href="text.xsl"/>-->
  <xsl:include href="textClass.xsl"/>
  <xsl:include href="title.xsl"/>
  <xsl:include href="titlePage.xsl"/>
  <xsl:include href="w.xsl"/>
  <xsl:include href="width.xsl"/>
  <xsl:include href="witness.xsl"/>
  <xsl:output method="html" indent="yes" encoding="UTF-8" omit-xml-declaration="yes"/>
  <xsl:strip-space elements="*"/>
  <xsl:preserve-space elements="tei:p"/>
  <!--Function that capitalizes first letter-->
  <xsl:function name="functx:capitalize-first" as="xs:string?" xmlns:functx="http://www.functx.com">
    <xsl:param name="arg" as="xs:string?"/>

    <xsl:sequence
      select="
        concat(upper-case(substring($arg, 1, 1)),
        substring($arg, 2))
        "/>

  </xsl:function>
  <xsl:variable name="title" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/@xml:id"/>
  <xsl:variable name="title-text" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
  <xsl:template match="/">
    <!--<xsl:value-of select="//tei:text[starts-with(@xml:id, 'workid')]/@decls"/>-->
    <!--<xsl:apply-templates select="//tei:text[starts-with(@xml:id, 'workid')]"/>-->
    <xsl:apply-templates select="tei:TEI"/>
  </xsl:template>
  <xsl:template match="tei:TEI">
    <xsl:variable name="worktitle">
      <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/@xml:id"/>
    </xsl:variable>

    <!--Template for index.html-->

    <xsl:result-document href="{$title}/toc.md">
<xsl:text>---
title: Indholdsfortegnelse
---

</xsl:text>
	 <!--This section generates det Markdown list of contents. Do
	      not reformat or pretty-print the XML markup below this line -->
	 <xsl:for-each select="//tei:text/*/(tei:epigraph | tei:titlePage | tei:div)">
		 <xsl:text>- </xsl:text><xsl:choose> <xsl:when test="./@xml:id = 'titelblad'">[Titelblad]</xsl:when> <xsl:when test="./@xml:id = 'dedikation'">[Dedikation]</xsl:when><xsl:when test="./@xml:id = 'motto'">[Motto]</xsl:when><xsl:otherwise>[<xsl:value-of select="tei:head[@type='add'] | tei:head/tei:reg"></xsl:value-of>]</xsl:otherwise></xsl:choose>(<xsl:value-of select="./@xml:id"/>)<xsl:text>
</xsl:text>
	 </xsl:for-each>
  </xsl:result-document>
    <xsl:apply-templates/>
  </xsl:template>
  <!--<xsl:template match="tei:text/tei:front | tei:text/tei:body | tei:text/tei:back | tei:text/tei:body/tei:div">-->
		<!--<xsl:template match="tei:text/tei:front | tei:text/tei:body | tei:text/tei:back">-->
			<!--<xsl:template match="tei:text">-->
    <xsl:template match="tei:text/tei:front | tei:text/tei:body | tei:text/tei:back | tei:text/tei:body/tei:div[child::tei:div][1]">
    <!-- Go through child elements and build files named with the @xml:id value -->
    <xsl:for-each select="child::*">
      <xsl:variable name="page-title" select="@xml:id"/>
      <xsl:variable name="section-header" select="tei:head"/>
      <xsl:result-document href="{$title}/{$page-title}.html">
<xsl:text>
<!--Since weight has to assigned in descending order I have it as a decrement of the $number variable starting from 10.000-->
---
title: </xsl:text><!--<xsl:value-of select="$title-text"/>, -->"<xsl:choose> <xsl:when test="./@xml:id = 'titelblad'">Titelblad</xsl:when> <xsl:when test="./@xml:id = 'dedikation'">Dedikation</xsl:when><xsl:when test="./@xml:id = 'motto'">Motto</xsl:when><xsl:otherwise><xsl:value-of select="tei:head[@type='add']|tei:head/tei:reg"></xsl:value-of></xsl:otherwise></xsl:choose>"
<xsl:text>
weight: </xsl:text><xsl:number count="tei:epigraph | tei:titlePage | tei:div" level="any"/><xsl:text>
---
</xsl:text>

<div class="text-container">
	<xsl:apply-templates/>
</div>
      </xsl:result-document>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
