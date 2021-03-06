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
    <xsl:template match="tei:table">
        <xsl:choose>
            <xsl:when test="@rend = 'borders'">
                <table class="borders">
                    <xsl:apply-templates/>
                </table>
            </xsl:when>
            <xsl:when test="@rend = 'no-borders'">
                <table class="no-borders">
                    <xsl:apply-templates/>
                </table>
            </xsl:when>
            <xsl:when test="@rend = 'large-table'">
                <table class="large-table">
                    <xsl:apply-templates/>
                </table>
            </xsl:when>
            <xsl:when test="@rend = 'very-large-table'">
                <table class="very-large-table">
                    <xsl:apply-templates/>
                </table>
            </xsl:when>
            <xsl:otherwise>
                <table>
                    <xsl:apply-templates/>
                </table>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:row">
        <tr>
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    <xsl:template match="tei:cell">
      <xsl:choose>
        <xsl:when test="@role = 'label'">
          <xsl:choose>
            <xsl:when test="@cols">
              <th>
                <xsl:attribute name="colspan">
                  <xsl:value-of select="@cols"/>
                </xsl:attribute>
                <xsl:apply-templates/>
              </th>
            </xsl:when>
            <xsl:otherwise>
              <th>
                <xsl:apply-templates/>
              </th>
            </xsl:otherwise>
          </xsl:choose>
            </xsl:when>
            <xsl:when test="@cols">
                <td>
                    <xsl:attribute name="colspan">
                        <xsl:value-of select="@cols"/>
                    </xsl:attribute>
                    <xsl:if test="@rows">
                      <xsl:attribute name="rowspan">
                        <xsl:value-of select="@rows"/>
                    </xsl:attribute>
                  </xsl:if>
                    <xsl:apply-templates/>
                </td>
            </xsl:when>
            <xsl:when test="@rows">
                <td>
                    <xsl:attribute name="rowspan">
                        <xsl:value-of select="@rows"/>
                    </xsl:attribute>
                    <xsl:choose>
                      <xsl:when test="@rend='vertical'">
                        <span class="vertical"><xsl:apply-templates/></span>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:apply-templates/>
                      </xsl:otherwise>
                    </xsl:choose>
                </td>
            </xsl:when>
            <xsl:otherwise>
                <td>
                    <xsl:apply-templates/>
                </td>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
