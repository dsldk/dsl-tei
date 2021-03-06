<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs tei" version="2.0">
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
            <xd:p>
                <xd:b>Created on:</xd:b> April 8, 2019</xd:p>
            <xd:p>
                <xd:b>Author:</xd:b> Axel Geertinger</xd:p>
            <xd:copyright>2019, Society for Danish Language and Literature</xd:copyright>
        </xd:desc>
    </xd:doc>
    
    <xsl:template match="tei:notatedMusic">
        <!-- MEI-filer læses fra github indtil videre. Ændres til endelig placering -->
	<xsl:variable name="mei_base" select="'https://raw.githubusercontent.com/dsldk/middelaldertekster/master/data/mei/'"/>
        <!-- Hvis alle filer ligger i samme mappe, brug -->
        <!-- <xsl:variable name="mei_dir" select="''"/> -->
        <!-- i stedet.                                  -->
        <xsl:variable name="mei_dir">
            <!-- Bestem mappenavn ud fra filnavn -->
            <xsl:value-of select="tokenize(tei:ptr/@target, '_')[position() &lt;= 2]" separator="_"/>/</xsl:variable>
        <xsl:if test="tei:ptr/@target">
            <xsl:variable name="file">
                <xsl:choose>
                    <xsl:when test="contains(tei:ptr/@target,'#')">
                        <xsl:value-of select="substring-before(tei:ptr/@target,'#')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="tei:ptr/@target"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="mdiv">
                <xsl:choose>
                    <xsl:when test="contains(tei:ptr/@target,'#')">
                        <xsl:value-of select="substring-after(tei:ptr/@target,'#')"/>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="id">
                <xsl:value-of select="substring-before($file,'.xml')"/> 
                <xsl:if test="contains(tei:ptr/@target,'#')">
                    <xsl:text>MDIV</xsl:text>
                    <xsl:value-of select="substring-after(tei:ptr/@target,'#')"/>
                </xsl:if>
            </xsl:variable>
            <div>
                <xsl:choose>
                    <xsl:when test="doc-available(concat($mei_base,$mei_dir,$file))">
                        <div id="{$id}_options" class="mei_options">
                            <xsl:comment>MEI options menu will be inserted here</xsl:comment>
                        </div>
                        <div id="{$id}" class="mei">
                            <xsl:comment>SVG will be inserted here</xsl:comment>
                        </div>
                        <!-- put in data if this is the first instance referring to the file -->
                        <xsl:if test="not(normalize-space($mdiv)) or not(preceding-sibling::tei:notatedMusic/tei:ptr[contains(@target,$file)])">
                            <!-- MEI data: -->
                            <script id="{substring-before($file,'.xml')}_data" type="text/xml">
                                <!-- output the root node as text to force an explicit namespace declaration -->
                                <xsl:text>
                            &lt;mei xmlns="http://www.music-encoding.org/ns/mei"</xsl:text>
                                <xsl:for-each select="document(concat($mei_base,$mei_dir,$file))/*/@*">
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="local-name(.)"/>
                                    <xsl:text>="</xsl:text>
                                    <xsl:value-of select="."/>
                                    <xsl:text>"</xsl:text>
                                </xsl:for-each>
                                <xsl:text>&gt;
                            </xsl:text>
                                <xsl:comment>Data URI: <xsl:value-of select="concat($mei_base,$mei_dir,$file)"/>
                                </xsl:comment>
                                <xsl:apply-templates select="document(concat($mei_base,$mei_dir,$file))/*/*" mode="serializeXML"/>
                                <xsl:text>&lt;/mei&gt;</xsl:text>
                            </script>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <div style="border: 1px solid black"> 
                            <small>
                                <xsl:value-of select="concat($mei_base,$mei_dir,$file)"/> not found</small>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            </div>
        </xsl:if>
    </xsl:template>
    
    <!-- Serialize XML for output as text. -->
    <xsl:template match="*" mode="serializeXML">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="name(.)"/>
        <xsl:for-each select="@*">
            <xsl:text> </xsl:text>
            <xsl:value-of select="name(.)"/>
            <xsl:text>="</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>"</xsl:text>
        </xsl:for-each>
        <xsl:text>&gt;</xsl:text>
        <xsl:apply-templates mode="serializeXML" select="node()"/>
        <xsl:text>&lt;/</xsl:text>
        <xsl:value-of select="name(.)"/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
    
    <xsl:template match="text()" mode="serializeXML">
        <xsl:choose>
            <xsl:when test="contains(.,'&amp;')">
                <!-- to do: call template recursively to catch more than one ampersand -->
                <xsl:value-of select="substring-before(.,'&amp;')"/>&amp;amp;<xsl:value-of select="substring-after(.,'&amp;')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template name="notatedMusic_head">
        <!-- Include additional header elements if the TEI file contains notated music. -->
        <xsl:if test="//tei:notatedMusic">
            
            <!-- TO DO: Change relative paths to whatever is the right place... -->
	    <xsl:variable name="mei_js_base" select="'tools/js/'"/>
	    <xsl:variable name="mei_css_base" select="'tools/style/'"/>
	    <xsl:variable name="mei_xslt_base" select="'tools/xsl/'"/>
            
            <!-- External JS libraries -->
            <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css"/>
            <!-- Note highlighting only works with jQuery 3+ -->
            <script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.min.js"><!-- jquery --></script>
            <script type="text/javascript" src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"><!-- jquery UI --></script>
            
            <!-- Local JS libraries -->
            <script type="text/javascript" src="{$mei_js_base}libs/verovio/2.0.2-95c61b2/verovio-toolkit.js"> </script>
            <script type="text/javascript" src="{$mei_js_base}libs/Saxon-CE_1.1/Saxonce/Saxonce.nocache.js"> </script>
            <script type="text/javascript" src="{$mei_js_base}MeiLib.js"> </script>
            <!-- MIDI -->        
            <script type="text/javascript" src="{$mei_js_base}wildwebmidi.js"><!-- MIDI library --></script>
            <script type="text/javascript" src="{$mei_js_base}midiplayer.js"><!-- MIDI player --></script>
            <script type="text/javascript" src="{$mei_js_base}midiLib.js"><!-- Custom MIDI library --></script>
            
            <!-- SVG CSS styling -->
            <link rel="stylesheet" type="text/css" href="{$mei_css_base}mei.css"/>
            
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>
