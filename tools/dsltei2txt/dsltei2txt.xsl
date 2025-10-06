<xsl:stylesheet xmlns="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei" version="1.0">
    <xsl:output method="text" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>

    <!-- Define the text output method -->
    <xsl:output method="text" encoding="UTF-8"/>

    <!-- Identity template to copy text nodes -->
    <xsl:template match="text()">
        <xsl:value-of select="normalize-space()"/>
    </xsl:template>

    <!-- Skip comments, processing instructions, and attributes -->
    <xsl:template match="comment() | processing-instruction() | @* | tei:teiHeader | tei:pb">
        <!-- Do nothing -->
    </xsl:template>

    <xsl:template match="tei:app">
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="tei:lem"/>
        <xsl:text> </xsl:text>
    </xsl:template>
    
    <xsl:template match="tei:bibl">
        <xsl:text>&#10;&#10;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&#10;&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="tei:cell">
        <xsl:apply-templates/>
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template match="tei:code">
        <xsl:text> </xsl:text>
        <xsl:apply-templates/>
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template match="tei:formula">
        <xsl:text> </xsl:text>
        <xsl:apply-templates/>
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template match="tei:head">
        <xsl:text>&#10;&#10;</xsl:text>
        <xsl:apply-templates select="tei:orig | tei:ref | text()"/>
        <xsl:text>&#10;&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="tei:hi">
        <xsl:text> </xsl:text>
        <xsl:apply-templates/>
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template match="tei:item">
        <xsl:apply-templates/>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>


    <xsl:template match="tei:l">
        <xsl:apply-templates select="normalize-space()"/>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="tei:lg">
        <xsl:apply-templates/>
        <xsl:text>&#10;&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="tei:list">
        <xsl:apply-templates/>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="tei:p">
        <xsl:apply-templates/>
        <xsl:text>&#10;&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="tei:persName">
        <xsl:text> </xsl:text>
        <xsl:apply-templates/>
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template match="tei:placeName">
        <xsl:text> </xsl:text>
        <xsl:apply-templates/>
        <xsl:text> </xsl:text>
    </xsl:template>


    <xsl:template match="tei:orig">
        <xsl:apply-templates select="normalize-space()"/>
        <xsl:text>&#10;&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="tei:row">
        <xsl:apply-templates select="tei:cell"/>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    
    <xsl:template match="tei:ref">
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template match="tei:speaker">
        <xsl:apply-templates/>
        <xsl:text>&#10;&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="tei:stage">
        <xsl:apply-templates/>
        <xsl:text>&#10;&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="tei:table">
        <xsl:text>&#10;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&#10;&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="tei:titlePage"/>

</xsl:stylesheet>
