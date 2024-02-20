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
                <xd:b>Created on:</xd:b> February 9, 2024</xd:p>
            <xd:p>
                <xd:b>Author:</xd:b> Axel Teich Geertinger</xd:p>
            <xd:copyright>2024, Society for Danish Language and Literature</xd:copyright>
        </xd:desc>
    </xd:doc>
 
    <xsl:template match="tei:notatedMusic">
       <!-- MEI url may or may not include reference to a specific mDiv element to be rendered (given as #id)-->
        <xsl:if test="tei:ptr/@target">
           <xsl:variable name="urlWithoutHash">
              <xsl:choose>
                 <xsl:when test="substring(tei:ptr/@target,1,7)='http://'">
                    <!-- Absolute path -->
                    <xsl:value-of select="tokenize(tei:ptr/@target,'#')[1]"/>
                 </xsl:when>
                 <xsl:otherwise>
                    <!-- Relative path; make it absolute -->
                    <xsl:variable name="docPath" select="string-join(tokenize(translate(base-uri(),'\','/'),'/')[not(position()=last())],'/')"/>
                    <xsl:value-of select="concat($docPath,'/',tokenize(tei:ptr/@target,'#')[1])"/>
                 </xsl:otherwise>
              </xsl:choose>
           </xsl:variable>
           <xsl:variable name="filename" select="tokenize(translate($urlWithoutHash,'\','/'),'/')[last()]"/>
           <xsl:variable name="extensionRegex" select="concat('\.',tokenize($filename,'\.')[last()])"/>
           <xsl:variable name="mdiv" select="tokenize(tei:ptr/@target,'#')[2]"/>
           <xsl:variable name="id">
              <xsl:choose>
                 <xsl:when test="$mdiv">
                    <xsl:value-of select="concat(replace($filename,$extensionRegex,''),'_mdiv_',$mdiv)"/>
                 </xsl:when>
                 <xsl:otherwise>
                    <xsl:value-of select="replace($filename,$extensionRegex,'')"/>
                 </xsl:otherwise>
              </xsl:choose>              
           </xsl:variable>
            <div class="mei">
            <xsl:choose>
                <xsl:when test="doc-available($urlWithoutHash)">
                   <!-- MEI data are put in a script element -->
                   <script id="{$id}_data" type="text/xml">
                      <xsl:copy-of select="doc($urlWithoutHash)[not($mdiv)] | doc($urlWithoutHash)//*[@xml:id=$mdiv]"/>
                   </script>
                   <div id="{$id}" class="verovioSVG">
                        <xsl:comment>SVG will be inserted here</xsl:comment>
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <div style="border: 1px solid black; padding: 2px;">
                       <small>File <xsl:value-of select="$filename"/> not found</small>
                    </div>
                </xsl:otherwise>
            </xsl:choose>
            </div>
        </xsl:if>
    </xsl:template>
       
    <xsl:template match="*" mode="notatedMusic_head">
       <!-- Include additional header elements if the TEI file contains notated music. -->
       <script type="text/javascript" src="../js/verovio-toolkit-wasm-4.1.0.js"><!-- Verovio toolkit --></script>
       <script type="text/javascript" src="../js/mei.js"><!-- MEI handling script --></script>
    </xsl:template>
    
</xsl:stylesheet>
