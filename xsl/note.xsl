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


    <!-- Handle marginal notes -->
    <xsl:template match="tei:note[@place = 'right'] | tei:note[@place = 'left'] | tei:note[@place = 'margin']"></xsl:template>

    <!--Make a note reference to legacy footnote in a headline-->
    <xsl:template match="tei:head//tei:note[@place = 'bottom']">
      <sup><a><xsl:number level="any"/></a></sup>
    </xsl:template>

    <!--Make a note reference to legacy footnote in poetry-->
    <xsl:template match="tei:l/tei:note[@place = 'bottom']">
      <sup><a><xsl:number level="any"/></a></sup>
    </xsl:template>

    <!--Make a note reference to legacy footnote in prose-->
    <xsl:template match="tei:p/tei:note[@place = 'bottom']">
      <sup><a><xsl:number level="any"/></a></sup>
    </xsl:template>

    <!--Make named footnote block to be called within text-->
    <xsl:template name="footnote-block">
      <div class="footnote-block"><hr class="footnote-separator"/>
        <xsl:for-each select="preceding-sibling::tei:head//tei:note[@place = 'bottom']">
          <div class="footnote row">
            <div class="col footnote-number"><xsl:number level="any"/>.</div>
            <div class="col">
              <xsl:apply-templates select="tei:p"/>
            </div>
          </div>
        </xsl:for-each>
          <xsl:for-each select=".//tei:note[@place = 'bottom']">
            <div class="footnote row">
              <div class="col footnote-number"><xsl:number level="any"/>.</div>
              <div class="col">
                <xsl:apply-templates select="tei:p"/>
              </div>
            </div>
        </xsl:for-each>

      </div>
    </xsl:template>

    <!--<xsl:template match="tei:note[@place = 'bottom']">
        <xsl:choose>
            <xsl:when test="@type = 'add'"/>
            <xsl:otherwise>
                <xsl:variable name="identifier">
                    <xsl:text>Note</xsl:text>
                    <xsl:choose>
                        <xsl:when test="@xml:id">
                            <xsl:value-of select="@xml:id"/>
                        </xsl:when>
                        <xsl:when test="@n">
                            <xsl:value-of select="@n"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:number count="tei:note[@place = 'bottom']" from="tei:body"
                                level="any"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <a class="notelink" href="#{$identifier}" id="back{$identifier}">
                    <sup>*<xsl:call-template name="noteN"/></sup>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>-->
    <xsl:template name="noteN">
        <xsl:choose>
            <xsl:when test="@n">
                <xsl:value-of select="@n"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:number count="tei:note[@place = 'bottom']" from="tei:body" level="any"/>
            </xsl:otherwise>
        </xsl:choose>
      </xsl:template>
    <xsl:template match="tei:note[@place = 'bottom']" mode="footnoteApparatus">
        <xsl:choose>
            <xsl:when test="@type = 'add'"/>
            <xsl:otherwise>
                <xsl:variable name="identifier">
                    <xsl:text>Note</xsl:text>
                    <xsl:choose>
                        <xsl:when test="@xml:id">
                            <xsl:value-of select="@xml:id"/>
                        </xsl:when>
                        <xsl:when test="@n">
                            <xsl:value-of select="@n"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <!--<xsl:number count="tei:note[not(@type)]" from="tei:body" level="any"/>-->
                            <xsl:number count="tei:note[@place = 'bottom']" from="tei:body"
                                level="any"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <p class="note">
                    <span class="noteLabel" id="{$identifier}">
                        <strong>
                            <a href="#back{$identifier}">
                                <xsl:call-template name="noteN"/>
                            </a>
                            <xsl:text>. </xsl:text>
                        </strong>
                    </span>
                    <span class="noteBody">
                        <xsl:apply-templates/>
                    </span>
                </p>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <!--Notes in rdg elements should be rendered in italics-->
    <xsl:template match="tei:rdg/tei:note">
      <!--Har escaped em'er da disse skal stå i en HTML-attribut-->
      &lt;em&gt;<!--<em>--><xsl:apply-templates/><!--</em>-->&lt;/em&gt;
    </xsl:template>
    <!-- <xsl:template match="tei:note[tei:p]"> -->
        <!-- der skal foreløbig ikke ske noget med denne form for noter, 
            jf. ex i Munch-Petersen, det nøgne menneske: gamle mødre -->
    <!-- </xsl:template> -->
</xsl:stylesheet>
