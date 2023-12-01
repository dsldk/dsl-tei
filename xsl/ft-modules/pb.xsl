<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="tei xs" version="2.0">
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
        <!--<xsl:variable name="config" select="document('../../config.xml')"/>-->
  <xsl:variable name="worktitle">
    <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/@xml:id"/>
  </xsl:variable>
  <xsl:template match="tei:pb">
    <xsl:choose>
      <!--If a text has facsimiles (@facs) make a link to them-->
      <xsl:when test="@facs">
        <span class="legacy-page-break">
          <span class="page-break-mark">
            <!-- <a href="{concat(concat(concat(concat('/facs/', $worktitle), '/'), @n), '.jpg')}"> -->
            <a target="_blank">
              <xsl:attribute name="href"><xsl:value-of select="$config//test"/>
                <xsl:value-of select="@facs"/>
              </xsl:attribute>
              <xsl:attribute name="title">
                <xsl:value-of select="@ed"/><xsl:text> </xsl:text>
                <xsl:value-of select="@n"/>
            </xsl:attribute>|</a>
          </span>
        </span>
      </xsl:when>
      <!-- <xsl:when test="@facs"> -->
        <!--<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">→</button>
        -->
<!-- Modal -->
<!--<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">-->
<!--  <div class="modal-dialog">-->
<!--    <div class="modal-content">-->
<!--      <div class="modal-header">-->
<!--        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>-->
<!--        <button type="button" class="close" data-dismiss="modal" aria-label="Close">-->
<!--          <span aria-hidden="true"></span>-->
<!--        </button>-->
<!--      </div>-->
<!--      <div class="modal-body">-->
<!--            <!-1-<img src="/home/th/Development/dipdandig/dd/facs/test.jpg"/>-1->-->
<!--            <xsl:value-of select="resolve-uri(.)"/>-->
<!--      </div>-->
<!--      <div class="modal-footer">-->
<!--        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>-->
<!--        <button type="button" class="btn btn-primary">Save changes</button>-->
<!--      </div>-->
<!--    </div>-->
<!--  </div>-->
<!--</div>-->
      <!-- </xsl:when> -->
      <xsl:otherwise>
        <span class="legacy-page-break">
          <span class="page-break-mark">
            <xsl:attribute name="title">
              <xsl:value-of select="@ed"/><xsl:text> </xsl:text>
              <xsl:value-of select="@n"/>
          </xsl:attribute>|</span>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
