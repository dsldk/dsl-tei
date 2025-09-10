<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="1.0">

  <xsl:output method="text" encoding="UTF-8"/>
  <xsl:strip-space elements="*"/>

  <!-- Normalize text output -->
  <xsl:template match="text()">
    <xsl:value-of select="normalize-space()"/>
    <xsl:text> </xsl:text>
  </xsl:template>

  <!-- Skip comments, PIs, attributes, TEI header, page breaks -->
  <xsl:template match="comment() | processing-instruction() | @* | tei:teiHeader | tei:pb"/>

  <!-- Handle apparatus -->
  <xsl:template match="tei:app">
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="tei:lem"/>
    <xsl:text> </xsl:text>
  </xsl:template>

  <!-- Table handling -->
  <xsl:template match="tei:table">
    <xsl:text>&#10;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&#10;&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="tei:row">
    <xsl:apply-templates select="tei:cell"/>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="tei:cell">
    <xsl:apply-templates/>
    <xsl:text> </xsl:text>
  </xsl:template>

  <!-- Lists -->
  <xsl:template match="tei:list">
    <xsl:apply-templates/>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="tei:item">
    <xsl:apply-templates/>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <!-- Verse -->
  <xsl:template match="tei:lg">
    <xsl:apply-templates/>
    <xsl:text>&#10;&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="tei:l">
    <xsl:apply-templates/>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <!-- Paragraph -->
  <xsl:template match="tei:p">
    <xsl:apply-templates/>
    <xsl:text>&#10;&#10;</xsl:text>
  </xsl:template>

  <!-- Headings -->
  <xsl:template match="tei:head">
    <xsl:text>&#10;&#10;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&#10;&#10;</xsl:text>
  </xsl:template>

  <!-- Inline formatting (adds spacing around) -->
  <xsl:template match="tei:hi | tei:code | tei:formula | tei:persName | tei:placeName">
    <xsl:text> </xsl:text>
    <xsl:apply-templates/>
    <xsl:text> </xsl:text>
  </xsl:template>

  <!-- References: just insert a space -->
  <xsl:template match="tei:ref">
    <xsl:text> </xsl:text>
  </xsl:template>

  <!-- Stage directions, speakers -->
  <xsl:template match="tei:speaker | tei:stage">
    <xsl:apply-templates/>
    <xsl:text>&#10;&#10;</xsl:text>
  </xsl:template>

  <!-- Title pages: omit entirely -->
  <xsl:template match="tei:titlePage"/>

</xsl:stylesheet>

