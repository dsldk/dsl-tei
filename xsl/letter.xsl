<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei" version="2.0">
    <xsl:include href="ab.xsl"/>
    <xsl:include href="abstract.xsl"/>
    <xsl:include href="additions.xsl"/>
    <xsl:include href="app.xsl"/>
    <xsl:include href="appInfo.xsl"/>
    <xsl:include href="application.xsl"/>
    <!--<xsl:include href="back.xsl"/>-->
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
    <xsl:include href="editor.xsl"/>
    <xsl:include href="emph.xsl"/>
    <xsl:include href="encodingDesc.xsl"/>
    <xsl:include href="epigraph.xsl"/>
    <xsl:include href="ex.xsl"/>
    <xsl:include href="extent.xsl"/>
    <xsl:include href="figure.xsl"/>
    <xsl:include href="foreign.xsl"/>
    <!--<xsl:include href="front.xsl"/>-->
    <xsl:include href="gap.xsl"/>
    <xsl:include href="handDesc.xsl"/>
    <xsl:include href="head.xsl"/>
    <xsl:include href="height.xsl"/>
    <xsl:include href="hi.xsl"/>
    <xsl:include href="history.xsl"/>
    <xsl:include href="idno.xsl"/>
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
    <xsl:include href="msName.xsl"/>
    <xsl:include href="msIdentifier.xsl"/>
    <xsl:include href="name.xsl"/>
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
    <xsl:include href="repository.xsl"/>
    <xsl:include href="salute.xsl"/>
    <xsl:include href="samplingDecl.xsl"/>
    <xsl:include href="sealDesc.xsl"/>
    <xsl:include href="settlement.xsl"/>
    <xsl:include href="signed.xsl"/>
    <xsl:include href="sourceDesc.xsl"/>
    <xsl:include href="sp.xsl"/>
    <xsl:include href="speaker.xsl"/>
    <xsl:include href="stage.xsl"/>
    <xsl:include href="supplied.xsl"/>
    <xsl:include href="support.xsl"/>
    <xsl:include href="supportDesc.xsl"/>
    <xsl:include href="table.xsl"/>
    <xsl:include href="text.xsl"/>
    <xsl:include href="textClass.xsl"/>
    <xsl:include href="title.xsl"/>
    <xsl:include href="titlePage.xsl"/>
    <xsl:include href="width.xsl"/>
    <xsl:include href="witness.xsl"/>
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="tei:p"/>
    <!-- Create identity template -->
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <!-- Override identity template, so that only 
        1. elements both not containing children 
        + not containing an attribute, and
        2. elements not containing value 'empty' 
	are copied -->
    <xsl:template match="*[node()/self::text() = 'empty'] | comment()" priority="1"/>
    <xsl:variable name="basename" select="substring-before(tokenize(base-uri(), '/')[last()], '.xml')"/>
    <!-- Match root element -->
    <xsl:template match="/">
        <xsl:apply-templates select="tei:TEI"/>
    </xsl:template>
    <xsl:template match="tei:TEI">
      <!--This is the YAML header-->
        <xsl:text>
        ---
        title: </xsl:text><xsl:value-of select="substring-before(tokenize(base-uri(), '/')[last()], '.xml')"/><xsl:text>
        subtitle: "</xsl:text><xsl:value-of select="//tei:creation/tei:date/text()"/>
        <xsl:choose>
            <xsl:when test="//tei:creation//tei:placeName">
                <xsl:text> </xsl:text><xsl:value-of select="//tei:creation/tei:placeName"/>
            </xsl:when>
            <xsl:when test="//tei:correspAction[@type='sent'][tei:placeName = 'nil']"/>
            <xsl:when test="//tei:correspAction[@type='sent'][tei:placeName = 'empty']"/>
            <xsl:when test="//tei:correspAction[@type='sent'][tei:placeName = '']"/>
            <xsl:otherwise>
                <xsl:text> </xsl:text><xsl:value-of select="//tei:correspAction[@type='sent']/tei:placeName"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>"
        editors:
          </xsl:text><xsl:for-each select="//tei:editor"><xsl:apply-templates select="."/></xsl:for-each><xsl:text>
        publishDate: 2020-02-01
        publisher: "Det Danske Sprog- og Litteraturselskab"
        genres: 
          - brev
        languages:
            - "</xsl:text> <xsl:apply-templates select="//tei:langUsage"/><xsl:text>"
        senders: </xsl:text>
        <xsl:choose>
          <xsl:when test="//tei:correspDesc/tei:correspAction/tei:persName[(@xml:id != 'nil') or (@xml:id != 'empty')]">
          <xsl:for-each select="//tei:correspAction[@type = 'sent']">
            - <xsl:value-of select="tei:persName/@xml:id"/>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:for-each select="//tei:correspAction[@type = 'sent']">
            - "<xsl:value-of select="tei:persName"/>"
          </xsl:for-each>
        </xsl:otherwise>
        </xsl:choose><xsl:text>
        receivers: </xsl:text>
        <xsl:choose>
          <xsl:when test="//tei:correspDesc/tei:correspAction/tei:persName[(@xml:id != 'nil') or (@xml:id != 'empty')]">
          <xsl:for-each select="//tei:correspAction[@type = 'received']">
            - <xsl:value-of select="tei:persName/@xml:id"/>
          </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
          <xsl:for-each select="//tei:correspAction[@type = 'received']">
            - "<xsl:value-of select="tei:persName"/>"
          </xsl:for-each>
        </xsl:otherwise>
        </xsl:choose><xsl:text>
        summary: "</xsl:text><xsl:choose>
                <xsl:when test="//tei:abstract[tei:ab != nil]">
                  <xsl:value-of select="//tei:abstract/tei:ab"/>
                </xsl:when>
                <xsl:otherwise> Brev fra <xsl:value-of select="//tei:correspAction[@type='sent']/tei:persName"/> til <xsl:value-of select="//tei:correspAction[@type='received']/tei:persName"/>
                </xsl:otherwise>
        </xsl:choose><xsl:text>"

        tags: </xsl:text>
      <xsl:for-each select="//tei:term">
            - "<xsl:value-of select="."/>"
          </xsl:for-each>
        <xsl:text>
        
        ---
        </xsl:text>

        <div class="text-container">
          <div class="metadata">
          <h2 class="date-place">
            <xsl:value-of select="//tei:creation/tei:date/text()"/><xsl:text>. </xsl:text>
            <xsl:choose>
            <xsl:when test="//tei:creation//tei:placeName[(text() != 'nil') or (text() != 'empty')]">
                <xsl:text> </xsl:text><xsl:value-of select="//tei:creation/tei:placeName[(text() != 'nil') or (text() != 'empty')]"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text> </xsl:text><xsl:value-of select="//tei:correspAction[@type='sent']/tei:placeName"/>
            </xsl:otherwise>
        </xsl:choose>
          </h2>
          <h3 class="summary">
              <xsl:choose>
                <xsl:when test="//tei:abstract/tei:ab[text() != nil]">
                  <xsl:value-of select="//tei:abstract/tei:ab"/>
                </xsl:when>
                <xsl:otherwise>
                Brev fra <xsl:value-of select="//tei:correspAction[@type='sent']/tei:persName"/> 
                til <xsl:value-of select="//tei:correspAction[@type='received']/tei:persName"/>
                </xsl:otherwise>
              </xsl:choose>
          </h3>
                <!--<div>
                    <xsl:apply-templates select="tei:teiHeader/tei:encodingDesc"/>
                </div>-->
                <!--<div>
                    <xsl:apply-templates select="tei:teiHeader/tei:profileDesc"/>
                </div>-->
            <xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:sourceDesc"/>
            </div>
            <div class="text-container">
              <xsl:apply-templates select="tei:text/tei:body"/>
            </div>
            <!--<xsl:if test="//tei:note">
                <div>
                    <h2>Fodnoter</h2>
                    <xsl:apply-templates select="//tei:note[@place = 'bottom']"
                        mode="footnoteApparatus"/>
                </div>
            </xsl:if>
            <xsl:if test="//tei:app">
                <div>
                    <h2>Kritisk apparat</h2>
                    <xsl:apply-templates select="//tei:app" mode="apparatusCriticus"/>
                </div>
            </xsl:if>
            <xsl:if test="//tei:cit">
                <div>
                    <h2>Citater</h2>
                    <xsl:apply-templates select="//tei:cit" mode="quotationApparatus"/>
                </div>
            </xsl:if>-->

            <!--<xsl:if test="//tei:note[@type='add']">
                    <div>
                        <h3>Kommentarer</h3>
                        <xsl:apply-templates select="//tei:note[@type='add']"/>
                    </div>
                </xsl:if>-->




        </div>


    </xsl:template>
</xsl:stylesheet>
