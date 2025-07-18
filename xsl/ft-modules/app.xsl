<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei" version="2.0">
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
    <xsl:template match="tei:app">
        <xsl:variable name="identifier">
            <xsl:text>App</xsl:text>
            <xsl:choose>
                <xsl:when test="@xml:id">
                    <xsl:value-of select="@xml:id"/>
                </xsl:when>
                <xsl:when test="@n">
                    <xsl:value-of select="@n"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:number count="//tei:app" level="any"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:apply-templates select="tei:lem"/>
				<!--<span class="popup" href="#{$identifier}" id="back{$identifier}" onclick="myFunction()">-->
          <button 
            id="{$identifier}"
            type="button" 
            class="btn btn-outline-secondary btn-sm" 
            data-container="body" 
            data-toggle="popover"
            data-template="&lt;div class='popover' role='tooltip'&gt;&lt;div class='arrow'&gt;&lt;/div&gt;&lt;h3 class='popover-header'&gt;&lt;/h3&gt;&lt;div class='popover-body'&gt;&lt;/div&gt;&lt;/div&gt;"
            data-placement="auto"
            data-html="true">
            <xsl:attribute name="data-content">
              <!-- For display of lemma content _without_ non-textual
                   content use attribute-content mode -->
              <xsl:if test="tei:lem"><xsl:apply-templates select='tei:lem' mode="attribute-content"/>] </xsl:if><xsl:apply-templates select='tei:rdg'/></xsl:attribute><xsl:attribute name="data-title">Tekstkritisk note <xsl:call-template name="appN"/></xsl:attribute>A</button>
    </xsl:template>
    <xsl:template name="appN">
        <xsl:choose>
            <xsl:when test="@n">
                <xsl:value-of select="@n"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:number from="tei:TEI" level="any"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Template, der matcher app og opbygger note
        i det kritiske apparat-->
    <xsl:template match="tei:app" mode="apparatusCriticus">
        <xsl:variable name="identifier">
            <xsl:text>App</xsl:text>
            <xsl:choose>
                <xsl:when test="@xml:id">
                    <xsl:value-of select="@xml:id"/>
                </xsl:when>
                <xsl:when test="@n">
                    <xsl:value-of select="@n"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:number count="tei:app" level="any"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <p class="note">
            <span class="noteLabel" id="{$identifier}">
                <strong>
                    <!--<xsl:attribute name="id">
                        <xsl:value-of select="$identifier"/>
                    </xsl:attribute>-->
                    <a href="#back{$identifier}"><xsl:call-template name="appN"/></a>
                    <xsl:text>. </xsl:text>
                </strong>
            </span>
            <span class="noteBody">
                <!--<xsl:variable name="lemmaLength" select="count(tei:lem//text()/tokenize(., '\W+')[.!=''])"/>-->
                        <xsl:apply-templates select="tei:lem"/><xsl:text>] </xsl:text>
                        <em><xsl:apply-templates select="tei:rdg" mode="apparatusCriticus"/></em>
                
                <!--<xsl:for-each select="tei:rdg">
                    <xsl:apply-templates select="self::node()" mode="apparatusCriticus"/>
                    <xsl:if test="position() != last()">; </xsl:if>
                    <xsl:if test="position() = last()">. </xsl:if>
                </xsl:for-each>
                <xsl:text> </xsl:text>-->
                <!--
                    <xsl:choose>
                    <xsl:when test="count(tei:rdg) > 1">
                    <xsl:apply-templates select="tei:rdg" />
                    <xsl:text>, </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                    <xsl:apply-templates select="tei:rdg"/>
                    <xsl:text>. </xsl:text>
                    </xsl:otherwise>
                    </xsl:choose>
                -->
            </span>
        </p>
    </xsl:template>
    <xsl:template match="tei:rdg" mode="apparatusCriticus">
        <xsl:apply-templates mode="apparatusCriticus"/>
    </xsl:template>
    <xsl:template match="tei:rdg/tei:q" mode="apparatusCriticus">
      <em><xsl:apply-templates mode="apparatusCriticus"/></em>
    </xsl:template>
    
    <xsl:template match="tei:rdg">
      &lt;span class="app-crit-reading"&gt;<xsl:apply-templates/>&lt;/span&gt;
    </xsl:template>
    <xsl:template match="tei:rdg/tei:q">
      &lt;span class="app-crit-reading-quote"&gt;<xsl:apply-templates/>&lt;/span&gt;
    </xsl:template>
    <xsl:template match="tei:lem">
        <xsl:apply-templates />
    </xsl:template>
    <!-- Use the template below for the lemma content i popover -->
    <xsl:template match="tei:lem" mode="attribute-content">
      <xsl:choose>
        <xsl:when test="child::*">
          <xsl:value-of select="child::*//text()"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="text()" />
        </xsl:otherwise>
      </xsl:choose>
      <!--<xsl:apply-templates/>-->
    </xsl:template>
</xsl:stylesheet>
