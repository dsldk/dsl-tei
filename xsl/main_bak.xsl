<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:functx="http://www.functx.com" exclude-result-prefixes="xs tei functx" version="2.0">
  <xsl:output method="html" indent="yes" encoding="UTF-8" omit-xml-declaration="yes"/>
  <xsl:strip-space elements="*"/>
  <xsl:preserve-space elements="tei:p"/>
  <!--Function that capitalizes first letter-->
  <xsl:function name="functx:capitalize-first" as="xs:string?"
    xmlns:functx="http://www.functx.com">
    <xsl:param name="arg" as="xs:string?"/>
    
    <xsl:sequence select="
      concat(upper-case(substring($arg,1,1)),
      substring($arg,2))
      "/>
    
  </xsl:function>
  <xsl:template match="/">
    <!--<xsl:value-of select="//tei:text[starts-with(@xml:id, 'workid')]/@decls"/>-->
    <!--<xsl:apply-templates select="//tei:text[starts-with(@xml:id, 'workid')]"/>-->
    <xsl:apply-templates select="tei:TEI"/>
  </xsl:template>
  <xsl:template match="tei:TEI">
    <xsl:variable name="workid" select="@decls"/>
    <xsl:variable name="worktitle">
      <xsl:value-of select="parent::tei:sourceDesc//tei:bibl[@xml:id = '$work-id']/@xml:id"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="//tei:text[starts-with(@xml:id, 'workid')]">
        <xsl:for-each select="//tei:text[starts-with(@xml:id, 'workid')]">
          <xsl:variable name="author-name">
            <xsl:value-of select="replace(lower-case(concat(//tei:sourceDesc//tei:author//tei:surname, '_', //tei:sourceDesc//tei:author//tei:forename)), '[ \[\]:?.]', '')"/>
          </xsl:variable>
          <xsl:variable name="workid" select="substring-after(@decls, '#')"/>
          <xsl:variable name="worktitle">
            <!--<xsl:value-of select="//tei:sourceDesc//tei:bibl[@xml:id = $workid]//tei:title"/>-->
            <xsl:value-of select="replace(replace(lower-case(normalize-space(//tei:sourceDesc//tei:bibl[@xml:id = $workid]//tei:title/string())), ' ', '-'), '[\[\]:?.]', '')"/>
          </xsl:variable>
          <xsl:variable name="page-from">
            <xsl:choose>
              <xsl:when test="number((.//tei:body//tei:pb/@n)[1]) = number((.//tei:body//tei:pb/@n)[1])">
                <xsl:value-of select="((.//tei:body//tei:pb/@n)[1] - 1)"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="0"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="page-to" select="(.//tei:body//tei:pb/@n)[last()]"/>
          <xsl:result-document href="{$author-name}/{$worktitle}/{$worktitle}.xml">
            <TEI>
              <teiHeader>
                <fileDesc>
                  <titleStmt>
                    <title>
                      <xsl:value-of select="functx:capitalize-first(lower-case(//tei:sourceDesc//tei:bibl[@xml:id = $workid]//tei:title))"/>
                    </title>
                    <author>
                      <xsl:value-of>
                        <xsl:value-of select="//tei:sourceDesc//tei:author//tei:surname"/>, <xsl:value-of
                          select="//tei:sourceDesc//tei:author//tei:forename"/></xsl:value-of>
                    </author>
                    <editor xml:id="th"/>
                  </titleStmt>
                  <publicationStmt>
                    <publisher>textbase</publisher>
                    <pubPlace>Copenhagen</pubPlace>
                    <date>
                      <xsl:value-of select="current-date()"/>
                    </date>
                    <idno/>
                    <availability status="free">
                      <ab>GNU license</ab>
                    </availability>
                  </publicationStmt>
                  <sourceDesc>
                    <listWit>
                      <witness xml:id="A">empty</witness>
                    </listWit>
                    <listBibl>
                      <bibl>
                        <xsl:copy-of select="//tei:sourceDesc/tei:bibl/*"/>
                        <biblScope>
                          <xsl:value-of>
                            <xsl:value-of select="$page-from"/>-<xsl:value-of select="$page-to"/>
                          </xsl:value-of>
                        </biblScope>
                      </bibl>
                    </listBibl>
                  </sourceDesc>
                </fileDesc>
                <encodingDesc/>
                <profileDesc/>
                <revisionDesc/>
              </teiHeader>
              <text>
                <body>
                  <xsl:copy-of select="."/>
                </body>
              </text>
            </TEI>
          </xsl:result-document>
        </xsl:for-each>
      </xsl:when>
      <xsl:when test="//tei:body/tei:div[starts-with(@xml:id, 'workid')]">
        <xsl:for-each select="//tei:body/tei:div[starts-with(@xml:id, 'workid')]">
          <xsl:variable name="author-name">
            <xsl:value-of select="replace(lower-case(concat(//tei:sourceDesc//tei:author//tei:surname, '_', //tei:sourceDesc//tei:author//tei:forename)), '[ \[\]:?.]', '')"/>
          </xsl:variable>
          <xsl:variable name="workid" select="substring-after(@decls, '#')"/>
          <xsl:variable name="worktitle">
            <!--<xsl:value-of select="//tei:sourceDesc//tei:bibl[@xml:id = $workid]//tei:title"/>-->
            <xsl:value-of select="replace(replace(lower-case(normalize-space(//tei:sourceDesc//tei:bibl[@xml:id = $workid]//tei:title/string())), ' ', '-'), '[\[\]:?.]', '')"/>
          </xsl:variable>
          <xsl:variable name="page-from">
            <xsl:choose>
              <xsl:when test="number((.//tei:body//tei:pb/@n)[1]) = number((.//tei:body//tei:pb/@n)[1])">
                <xsl:value-of select="((.//tei:body//tei:pb/@n)[1] - 1)"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="0"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="page-to" select="(.//tei:body//tei:pb/@n)[last()]"/>
          <xsl:result-document href="{$author-name}/{$worktitle}/{$worktitle}-{generate-id()}.xml">
            <TEI>
              <teiHeader>
                <fileDesc>
                  <titleStmt>
                    <title>
                      <xsl:value-of select="functx:capitalize-first(lower-case(//tei:sourceDesc//tei:bibl[@xml:id = $workid]//tei:title))"/>
                    </title>
                    <author>
                      <xsl:value-of>
                        <xsl:value-of select="//tei:sourceDesc//tei:author//tei:surname"/>, <xsl:value-of
                          select="//tei:sourceDesc//tei:author//tei:forename"/></xsl:value-of>
                    </author>
                    <editor xml:id="th"/>
                  </titleStmt>
                  <publicationStmt>
                    <publisher>textbase</publisher>
                    <pubPlace>Copenhagen</pubPlace>
                    <date>
                      <xsl:value-of select="current-date()"/>
                    </date>
                    <idno/>
                    <availability status="free">
                      <ab>GNU license</ab>
                    </availability>
                  </publicationStmt>
                  <sourceDesc>
                    <listWit>
                      <witness xml:id="A">empty</witness>
                    </listWit>
                    <listBibl>
                      <bibl>
                        <xsl:copy-of select="//tei:sourceDesc/tei:bibl/*"/>
                        <biblScope>
                          <xsl:value-of>
                            <xsl:value-of select="$page-from"/>-<xsl:value-of select="$page-to"/>
                          </xsl:value-of>
                        </biblScope>
                      </bibl>
                    </listBibl>
                  </sourceDesc>
                </fileDesc>
                <encodingDesc/>
                <profileDesc/>
                <revisionDesc/>
              </teiHeader>
              <text>
                <body>
                  <xsl:copy-of select="."/>
                </body>
              </text>
            </TEI>
          </xsl:result-document>         
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="//tei:body//tei:div/tei:div[starts-with(@xml:id, 'workid')]">
          <xsl:variable name="author-name">
            <xsl:value-of select="replace(lower-case(concat(//tei:sourceDesc//tei:author//tei:surname, '_', //tei:sourceDesc//tei:author//tei:forename)), '[ \[\]:?.]', '')"/>
          </xsl:variable>
          <xsl:variable name="workid" select="substring-after(@decls, '#')"/>
          <xsl:variable name="worktitle">
            <!--<xsl:value-of select="//tei:sourceDesc//tei:bibl[@xml:id = $workid]//tei:title"/>-->
            <xsl:value-of select="replace(replace(lower-case(normalize-space(//tei:sourceDesc//tei:bibl[@xml:id = $workid]//tei:title/string())), ' ', '-'), '[\[\]:?.]', '')"/>
          </xsl:variable>
          <xsl:variable name="page-from">
            <xsl:choose>
              <xsl:when test="number((.//tei:body//tei:pb/@n)[1]) = number((.//tei:body//tei:pb/@n)[1])">
                <xsl:value-of select="((.//tei:body//tei:pb/@n)[1] - 1)"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="0"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="page-to" select="(.//tei:body//tei:pb/@n)[last()]"/>
          <xsl:result-document href="{$author-name}/{$worktitle}/{$worktitle}-{generate-id()}.xml">
            <TEI>
              <teiHeader>
                <fileDesc>
                  <titleStmt>
                    <title>
                      <xsl:value-of select="functx:capitalize-first(lower-case(//tei:sourceDesc//tei:bibl[@xml:id = $workid]//tei:title))"/>
                    </title>
                    <author>
                      <xsl:value-of>
                        <xsl:value-of select="//tei:sourceDesc//tei:author//tei:surname"/>, <xsl:value-of
                          select="//tei:sourceDesc//tei:author//tei:forename"/></xsl:value-of>
                    </author>
                    <editor xml:id="th"/>
                  </titleStmt>
                  <publicationStmt>
                    <publisher>textbase</publisher>
                    <pubPlace>Copenhagen</pubPlace>
                    <date>
                      <xsl:value-of select="current-date()"/>
                    </date>
                    <idno/>
                    <availability status="free">
                      <ab>GNU license</ab>
                    </availability>
                  </publicationStmt>
                  <sourceDesc>
                    <listWit>
                      <witness xml:id="A">empty</witness>
                    </listWit>
                    <listBibl>
                      <bibl>
                        <xsl:copy-of select="//tei:sourceDesc/tei:bibl/*"/>
                        <biblScope>
                          <xsl:value-of>
                            <xsl:value-of select="$page-from"/>-<xsl:value-of select="$page-to"/>
                          </xsl:value-of>
                        </biblScope>
                      </bibl>
                    </listBibl>
                  </sourceDesc>
                </fileDesc>
                <encodingDesc/>
                <profileDesc/>
                <revisionDesc/>
              </teiHeader>
              <text>
                <body>
                  <xsl:copy-of select="."/>
                </body>
              </text>
            </TEI>
          </xsl:result-document>         
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
    
    <!--<xsl:for-each select="tei:text/tei:group/tei:text/tei:body//tei:div[starts-with(@xml:id, 'workid')]">
      <xsl:variable name="author-name">
        <xsl:value-of select="replace(lower-case(concat(//tei:sourceDesc//tei:author//tei:surname, '_', //tei:sourceDesc//tei:author//tei:forename)), '[ \[\]:?.]', '')"/>
      </xsl:variable>
      <xsl:variable name="workid" select="substring-after(@decls, '#')"/>
      <xsl:variable name="worktitle">
        <xsl:value-of select="replace(replace(lower-case(normalize-space(//tei:sourceDesc//tei:bibl[@xml:id = $workid]//tei:title/string())), ' ', '-'), '[\[\]:?.]', '')"/>
      </xsl:variable>-->
      <!-- Find out on which pages the work is printed. -->
      <!-- Since first page is rarely captured -->
      <!-- subtract one from first -->
      <!--<xsl:variable name="page-from">
        <xsl:choose>-->
          <!-- make sure that what's inside the pb/@n value is a number -->
          <!--<xsl:when test="number((.//tei:body//tei:pb/@n)[1]) = number((.//tei:body//tei:pb/@n)[1])">
            <xsl:value-of select="((.//tei:body//tei:pb/@n)[1] - 1)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="0"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>-->
      <!--<xsl:variable name="page-from" select="((.//tei:body//tei:pb/@n)[1] - 1)"/>-->
      <!--<xsl:variable name="page-to" select="(.//tei:body//tei:pb/@n)[last()]"/>
      <xsl:result-document href="{$author-name}/{$worktitle}/{$worktitle}-{generate-id()}.xml">
        <TEI>
          <teiHeader>
            <fileDesc>
              <titleStmt>
                <title>
                  <xsl:value-of select="functx:capitalize-first(lower-case(//tei:sourceDesc//tei:bibl[@xml:id = $workid]//tei:title))"/>
                </title>
                <author>
                  <xsl:value-of>
                    <xsl:value-of select="//tei:sourceDesc//tei:author//tei:surname"/>, <xsl:value-of
                      select="//tei:sourceDesc//tei:author//tei:forename"/></xsl:value-of>
                </author>
                <editor xml:id="th"/>
              </titleStmt>
              <publicationStmt>
                <publisher>textbase</publisher>
                <pubPlace>Copenhagen</pubPlace>
                <date>
                  <xsl:value-of select="current-date()"/>
                </date>
                <idno/>
                <availability status="free">
                  <ab>GNU license</ab>
                </availability>
              </publicationStmt>
              <sourceDesc>
                <listWit>
                  <witness xml:id="A">empty</witness>
                </listWit>
                <listBibl>
                  <bibl>
                    <xsl:copy-of select="//tei:sourceDesc/tei:bibl/*"/>
                    <biblScope>
                      <xsl:value-of>
                        <xsl:value-of select="$page-from"/>-<xsl:value-of select="$page-to"/>
                      </xsl:value-of>
                    </biblScope>
                  </bibl>
                </listBibl>
              </sourceDesc>
            </fileDesc>
            <encodingDesc/>
            <profileDesc/>
            <revisionDesc/>
          </teiHeader>
          <text>
            <body>
              <xsl:copy-of select="."/>
            </body>
          </text>
        </TEI>
      </xsl:result-document>
    </xsl:for-each>-->
    <!-- -->
    
    
  </xsl:template>
</xsl:stylesheet>
