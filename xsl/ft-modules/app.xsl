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
      <xsl:variable name="section_number">
        <xsl:number count="//tei:text/*/tei:div"/>
      </xsl:variable>
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
                    <xsl:number count="tei:app" level="single"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:apply-templates select="tei:lem"/>
        <a class="notelink" href="#{$section_number}-{$identifier}" id="back{$section_number}-{$identifier}">
            <sup>
                <xsl:call-template name="appN"/>
            </sup>
        </a>
    </xsl:template>
    <xsl:template name="appN">
        <xsl:choose>
            <xsl:when test="@n">
                <xsl:value-of select="@n"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:number count="tei:app" level="any" from="//tei:text/*/tei:div"/>
                <!--<xsl:number from="tei:TEI" level="any"/>-->
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Template, der matcher app og opbygger note
        i det kritiske apparat-->
    <xsl:template match="tei:app" mode="apparatusCriticus">
      <xsl:variable name="section_number">
          <xsl:number count="//tei:text/*/tei:div"/>
      </xsl:variable>
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
                    <!--<xsl:number count="tei:app" level="any"/>-->
                    <xsl:number count="tei:app" level="single"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <span class="note">
            <span class="noteLabel" id="{$section_number}-{$identifier}">
                <strong>
                    <!--<xsl:attribute name="id">
                        <xsl:value-of select="$identifier"/>
                    </xsl:attribute>-->
                    <a href="#back{$section_number}-{$identifier}">
                        <xsl:call-template name="appN"/>
                    </a>
                    <xsl:text>. </xsl:text>
                </strong>
            </span>
            <span class="noteBody">
                <xsl:choose>
                    <xsl:when test="tei:lem">
                        <xsl:apply-templates select="tei:lem"/>
                        <xsl:text>] </xsl:text>
                        <xsl:choose>
                            <xsl:when test="tei:lem/@resp"><em><xsl:value-of
                                        select='tei:lem/@resp/tokenize(., "#")'/></em>, </xsl:when>
                            <xsl:when test="tei:lem/@wit"><em><xsl:value-of
                                        select='tei:lem/@wit/tokenize(., "#")'/></em>, </xsl:when>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="tei:lem"/>
                        <xsl:text>]</xsl:text>
                        <xsl:text>  </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="tei:rdg">
                        <xsl:for-each select="tei:rdg">
                            <xsl:apply-templates select="."/>
                        <!-- If there are @resp or @wit attributes render them here-->
                        <xsl:choose>
                            <xsl:when test="@resp">
                                <em>
                                    <xsl:value-of select='@resp/tokenize(., "#")'/>
                                </em>
                                <xsl:if test="position() != last()">, </xsl:if>
                                <xsl:if test="position() = last()"/>
                            </xsl:when>
                            <xsl:when test="@wit">
                                <em>
                                    <xsl:value-of select='@wit/tokenize(., "#")'/>
                                </em>
                                <xsl:if test="position() != last()"> </xsl:if>
                                <xsl:if test="position() = last()"/>
                            </xsl:when>
                        </xsl:choose>
                        <!-- If there is a note pertaining to the reading display it here -->
                        <xsl:if test="tei:note">
                          <xsl:text> </xsl:text><xsl:apply-templates select="tei:note"/>
                        </xsl:if>
                        <xsl:if test="position() != last()">, </xsl:if>
                        <xsl:if test="position() = last()"/>
                        </xsl:for-each>

                    </xsl:when>


                </xsl:choose>

                <xsl:text> </xsl:text>
            </span>
        </span>
    </xsl:template>
    <xsl:template match="tei:rdg">
        <xsl:apply-templates select="text()|tei:hi|tei:q"/>
        <xsl:text> </xsl:text>
        <!--<xsl:if test="@wit">
            <em>-->
        <!-- Since values in the must be prefixed with a 
                 we use tokenize() to obtain the substring after # -->
        <!--<xsl:value-of select="@wit/tokenize(., '#')"/>
            </em>
        </xsl:if>-->
        <!--<xsl:if test="tei:note">
            <xsl:apply-templates select="tei:note"/>
        </xsl:if>-->

        <!--Det er formentlig bedre at lade redaktøren selv
            skrive om læsningen skyldes 'DD' eller fx Aa1.  
            <xsl:text>, </xsl:text>
            <em>
            <xsl:value-of select="@resp | @wit"/>
            </em>
            <xsl:text>
            </xsl:text>-->
    </xsl:template>
    <xsl:template match="tei:lem">
        <xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>
