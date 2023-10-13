<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei" version="1.0">
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
    <xsl:template match="tei:lg">
        <div>
            <xsl:attribute name="class">
                <xsl:choose>
                  <xsl:when test="@rend">line-group <xsl:value-of select="@rend"/></xsl:when>
                  <xsl:when test="@rend = 'center-col'">poetry center-col</xsl:when>
                  <xsl:when test="@rend = 'center-col-font-italic'">poetry center-col font-italic</xsl:when>
                  <xsl:when test="(@rend = 'center') or (@rend = 'text-center')">my-4 text-center</xsl:when>
                  <xsl:when test="(@rend = 'right') or (@rend = 'text-right')">my-4 text-right</xsl:when>
                  <xsl:otherwise>mt-2 mb-4</xsl:otherwise>
                </xsl:choose>
                <xsl:if test="@n">
                    <xsl:attribute name="data-num">
                        <xsl:value-of select="@n"/>
                    </xsl:attribute>
                </xsl:if>
            </xsl:attribute>
            <xsl:if test="tei:head">
              <xsl:apply-templates select="tei:lg/tei:head"/>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
        <!--       <xsl:choose>
          <xsl:when test="@rend = 'center-col-font-italic'">
            <xsl:attribute name="poetry center-col font-italic">
              <xsl:apply-templates/>
            </xsl:attribute>
            </xsl:when>
            <xsl:when test="@rend = 'center-col'">
              <xsl:attribute name="poetry center-col">
                    <xsl:apply-templates/>
              </xsl:attribute>>
            </xsl:when>
            <xsl:when test="(@rend = 'center') or (@rend = 'text-center')">
                <xsl:attribute name="poetry text-center">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="(@rend = 'right') or (@rend = 'text-right')">
                <div class="poetry text-right">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@rend = 'it'">
                <div class="poetry font-italic">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div class="poetry">
                    <xsl:if test="@n">
                        <xsl:attribute name="data-num">
                            <xsl:value-of select="@n"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:apply-templates/>
                </div>
            </xsl:otherwise>
          </xsl:choose>
          </div>-->
    </xsl:template>
</xsl:stylesheet>
