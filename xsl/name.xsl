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
    <xsl:template match="tei:name">
        <xsl:choose>
            <xsl:when test="@xml:id='alk'">knudsen_anders_1958</xsl:when>
            <xsl:when test="@xml:id='fgj'">jensen_fg_19XX</xsl:when>
            <xsl:when test="@xml:id='jon'">adams_j_19XX</xsl:when>
            <xsl:when test="@xml:id='maria.arvidsson'">arvidsson_m_19XX</xsl:when>
            <xsl:when test="@xml:id='mh'">hedemann_markus_1970</xsl:when>
            <xsl:when test="@xml:id='pbh'">hansen_pb_1988</xsl:when>
            <xsl:when test="@xml:id='pz'">zeeberg_peter_1957</xsl:when>
            <xsl:when test="@xml:id='smb'">bak_sm_1984</xsl:when>
            <xsl:when test="@xml:id='th'">hansen_thomas_1977</xsl:when>
            <xsl:when test="@xml:id='th'">posselt_gert_1955</xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="@xml:id"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
