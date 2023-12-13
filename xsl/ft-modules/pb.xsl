<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="tei xs" version="1.0">
  <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
    <xd:desc>
      <xd:detail>Licensed by Thomas Hansen under the Creative Commons Attribution-Share Alike
        3.0 United States license. You are free to copy, distribute, transmit, and remix
        this work, provided you attribute the work to Thomas Hansen as the original author
        and reference the Society for Danish Language and Literature [http://dsl.dk] for the
        work. If you alter, transform, or build upon this work, you may distribute the
        resulting work only under the same, similar or a compatible license. Any of the
        above conditions can be waived if you get permission from the copyright holder. For
        any reuse or distribution, you must make clear to others the license terms of this
        work. The best way to do this is with a link to the license
        [http://creativecommons.org/licenses/by-sa/3.0/deed.en].</xd:detail>
      <xd:p><xd:b>Created on:</xd:b> Jan 5, 2010</xd:p>
      <xd:p><xd:b>Author:</xd:b> Thomas Hansen</xd:p>
      <xd:copyright>2010, Society for Danish Language and Literature</xd:copyright>
    </xd:desc>
  </xd:doc>
        <!--<xsl:variable name="config" select="document('../../config.xml')"/>-->
  <xsl:variable name="worktitle">
    <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/@xml:id"/>
  </xsl:variable>
  <xsl:template match="tei:pb">
    <span class="pageBegin">
      <xsl:attribute name="id">p<xsl:value-of select="@n"/></xsl:attribute>
      <xsl:attribute name="class">pageBegin</xsl:attribute>
      <xsl:attribute name="title">
        <xsl:value-of select="@ed"/>
        <xsl:value-of select="@n"/>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="@facs">
          <a target="_blank">
            <xsl:attribute name="href">
              <xsl:value-of select="@facs"/>
            </xsl:attribute>
            <xsl:value-of select="@n"/>
          </a>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@n"/>
        </xsl:otherwise>
      </xsl:choose>
    </span>
    <span class="legacy-page-break">
      <span class="page-break-mark">|</span>
    </span>
  </xsl:template>
</xsl:stylesheet>
