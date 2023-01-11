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
    <!-- <xsl:variable name="worktitle">
        <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/@xml:id"/>
		</xsl:variable>-->
    <xsl:template match="tei:figure">
        <xsl:choose>
            <xsl:when test="@rend = 'right'">
                <div class="figure-right">
                    <xsl:variable name="illustration-type">
                        <xsl:value-of select="tei:desc"/>
                    </xsl:variable>
                    <xsl:variable name="illustration-text">
                        <xsl:apply-templates select="tei:head | tei:p"/>
                    </xsl:variable>
                    <xsl:if test="tei:pb">
                        <xsl:apply-templates select="tei:pb"/>
                    </xsl:if>
                    <xsl:apply-templates select="tei:graphic"/>
                    <div class="image-text">
                        <small>
                          <strong>{{% images/figure %}} <xsl:value-of select="@n"/>&#160; </strong>
                            <span>
                                <xsl:value-of select="$illustration-type"/>
                            </span>
                            <xsl:if test="$illustration-text != ''">
                              <!--<strong> {{% images/figure_text %}} </strong>-->
                                <span class="illustration-text">
                                   &#160;<xsl:value-of select="$illustration-text"/>
                                </span>
                            </xsl:if>
                        </small>
                    </div>

                </div>
            </xsl:when>
            <xsl:otherwise>
                <div class="figure">
                    <xsl:variable name="illustration-type">
                        <xsl:value-of select="tei:desc"/>
                    </xsl:variable>
                    <xsl:variable name="illustration-text">
                        <xsl:apply-templates select="tei:head | tei:p"/>
                    </xsl:variable>
                    <xsl:if test="tei:pb">
                        <xsl:apply-templates select="tei:pb"/>
                    </xsl:if>
                    <!--<p class="editorial">
                <strong>Illustration </strong>
                <xsl:value-of select="tei:desc"/>
            </p>
            <xsl:if test="tei:head | tei:p">
                <p class="editorial">
                    <strong>Tekst </strong>
                </p>
                <xsl:choose>
                    <xsl:when test="tei:head">
                        <xsl:apply-templates select="tei:head | tei:pb"/>
                    </xsl:when>
                    <xsl:when test="tei:p">
                        <xsl:apply-templates select="tei:p | tei:pb"/>
                    </xsl:when>
                </xsl:choose>
						</xsl:if>-->
                    <xsl:apply-templates select="tei:graphic"/>
                    <div class="image-text">
                        <small>
                          <strong> {{% images/figure %}} <xsl:value-of select="@n"/>&#160; </strong>
                            <span>
                                <xsl:value-of select="$illustration-type"/>
                            </span>
                            <xsl:if test="$illustration-text != ''">
                              <!--<strong> {{% images/figure_text %}} </strong>-->
                                <span class="illustration-text">
                                  <xsl:value-of select="$illustration-text"/>
                                </span>
                            </xsl:if>
                        </small>
                    </div>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:graphic">
        <img src="{concat(concat(concat(concat('/images/', $basename), '/'), @url), '.jpg')}">
        <!--<img>-->
            <xsl:attribute name="alt">
                <xsl:text>Illustration: </xsl:text>
                <xsl:value-of select="parent::tei:desc"/>
                <xsl:text>Text: </xsl:text>
                <xsl:choose>
                    <xsl:when test="parent::tei:head">
                        <xsl:apply-templates select="parent::tei:head | tei:pb"/>
                    </xsl:when>
                    <xsl:when test="parent::tei:p">
                        <xsl:apply-templates select="parent::tei:p | tei:pb"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:attribute>
        </img>
    </xsl:template>
</xsl:stylesheet>
