<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei" version="2.0">
    <xsl:include href="ab.xsl"/>
    <xsl:include href="abstract.xsl"/>
    <xsl:include href="additions.xsl"/>
    <xsl:include href="app.xsl"/>
    <xsl:include href="appInfo.xsl"/>
    <xsl:include href="application.xsl"/>
    <xsl:include href="bibl.xsl"/>
    <xsl:include href="byline.xsl"/>
    <xsl:include href="c.xsl"/>
    <xsl:include href="cit.xsl"/>
    <xsl:include href="closer.xsl"/>
    <xsl:include href="code.xsl"/>
    <xsl:include href="condition.xsl"/>
    <xsl:include href="creation.xsl"/>
    <xsl:include href="damage.xsl"/>
    <xsl:include href="date.xsl"/>
    <xsl:include href="dateline.xsl"/>
    <xsl:include href="dimensions.xsl"/>
    <xsl:include href="ft-modules/div.xsl"/>
    <xsl:include href="docAuthor.xsl"/>
    <xsl:include href="docEdition.xsl"/>
    <xsl:include href="docImprint.xsl"/>
    <xsl:include href="docTitle.xsl"/>
    <xsl:include href="emph.xsl"/>
    <xsl:include href="encodingDesc.xsl"/>
    <xsl:include href="epigraph.xsl"/>
    <xsl:include href="ex.xsl"/>
    <xsl:include href="extent.xsl"/>
    <xsl:include href="ft-modules/figure.xsl"/>
    <xsl:include href="foreign.xsl"/>
    <xsl:include href="gap.xsl"/>
    <xsl:include href="ft-modules/graphic.xsl"/>
    <xsl:include href="handDesc.xsl"/>
    <xsl:include href="head.xsl"/>
    <xsl:include href="height.xsl"/>
    <xsl:include href="hi.xsl"/>
    <xsl:include href="history.xsl"/>
    <xsl:include href="imprimatur.xsl"/>
    <xsl:include href="item.xsl"/>
    <xsl:include href="keywords.xsl"/>
    <xsl:include href="l.xsl"/>
    <xsl:include href="langUsage.xsl"/>
    <xsl:include href="lb.xsl"/>
    <xsl:include href="lg.xsl"/>
    <xsl:include href="list.xsl"/>
    <xsl:include href="listBibl.xsl"/>
    <xsl:include href="listWit.xsl"/>
    <xsl:include href="milestone.xsl"/>
    <xsl:include href="msDesc.xsl"/>
    <xsl:include href="msIdentifier.xsl"/>
    <!--<xsl:include href="notatedMusic.xsl"/>-->
    <xsl:include href="note.xsl"/>
    <xsl:include href="objectDesc.xsl"/>
    <xsl:include href="opener.xsl"/>
    <xsl:include href="orig.xsl"/>
    <xsl:include href="p.xsl"/>
    <xsl:include href="ft-modules/pb.xsl"/>
    <xsl:include href="persName.xsl"/>
    <xsl:include href="physDesc.xsl"/>
    <xsl:include href="placeName.xsl"/>
    <xsl:include href="postscript.xsl"/>
    <xsl:include href="profileDesc.xsl"/>
    <xsl:include href="projectDesc.xsl"/>
    <xsl:include href="ft-modules/q.xsl"/>
    <xsl:include href="quote.xsl"/>
    <xsl:include href="ref.xsl"/>
    <xsl:include href="reg.xsl"/>
    <xsl:include href="salute.xsl"/>
    <xsl:include href="samplingDecl.xsl"/>
    <xsl:include href="sealDesc.xsl"/>
    <xsl:include href="signed.xsl"/>
    <xsl:include href="sourceDesc.xsl"/>
    <xsl:include href="sp.xsl"/>
    <xsl:include href="speaker.xsl"/>
    <xsl:include href="stage.xsl"/>
    <xsl:include href="supplied.xsl"/>
    <xsl:include href="support.xsl"/>
    <xsl:include href="supportDesc.xsl"/>
    <xsl:include href="ft-modules/table.xsl"/>
    <!--  <xsl:include href="text.xsl"/>-->
    <xsl:include href="textClass.xsl"/>
    <xsl:include href="title.xsl"/>
    <xsl:include href="ft-modules/titlePage.xsl"/>
    <xsl:include href="w.xsl"/>

    <xsl:output method="html" encoding="UTF-8" indent="yes"
        use-character-maps="no-control-characters"/>
    <xsl:character-map name="no-control-characters">
        <xsl:output-character character="&#127;" string=" "/>
        <xsl:output-character character="&#128;" string=" "/>
        <xsl:output-character character="&#129;" string=" "/>
        <xsl:output-character character="&#130;" string=" "/>
        <xsl:output-character character="&#131;" string=" "/>
        <xsl:output-character character="&#132;" string=" "/>
        <xsl:output-character character="&#133;" string=" "/>
        <xsl:output-character character="&#134;" string=" "/>
        <xsl:output-character character="&#135;" string=" "/>
        <xsl:output-character character="&#136;" string=" "/>
        <xsl:output-character character="&#137;" string=" "/>
        <xsl:output-character character="&#138;" string=" "/>
        <xsl:output-character character="&#139;" string=" "/>
        <xsl:output-character character="&#140;" string=" "/>
        <xsl:output-character character="&#141;" string=" "/>
        <xsl:output-character character="&#142;" string=" "/>
        <xsl:output-character character="&#143;" string=" "/>
        <xsl:output-character character="&#144;" string=" "/>
        <xsl:output-character character="&#145;" string=" "/>
        <xsl:output-character character="&#146;" string=" "/>
        <xsl:output-character character="&#147;" string=" "/>
        <xsl:output-character character="&#148;" string=" "/>
        <xsl:output-character character="&#149;" string=" "/>
        <xsl:output-character character="&#150;" string=" "/>
        <xsl:output-character character="&#151;" string=" "/>
        <xsl:output-character character="&#152;" string=" "/>
        <xsl:output-character character="&#153;" string=" "/>
        <xsl:output-character character="&#154;" string=" "/>
        <xsl:output-character character="&#155;" string=" "/>
        <xsl:output-character character="&#156;" string=" "/>
        <xsl:output-character character="&#157;" string=" "/>
        <xsl:output-character character="&#158;" string=" "/>
        <xsl:output-character character="&#159;" string=" "/>
    </xsl:character-map>

    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="tei:p"/>
    <xsl:variable name="basename"
        select="substring-before(tokenize(base-uri(), '/')[last()], '.xml')"/>
    <xsl:variable name="title-text"
        select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[not(@xml:lang = 'en')]"/>
    <xsl:variable name="title-text-en"
        select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@xml:lang = 'en']"/>
    <!-- Create identity template -->
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <!-- Override identity template, so that only 
        1. elements both not containing children 
        + not containing an attribute, and
        2. elements not containing value 'empty' 
	are copied -->
    <xsl:template match="*[node()/self::text() = 'empty'] | comment()" priority="1"/>
    <!-- Match root element -->
    <xsl:template match="/">
        <xsl:apply-templates select="tei:TEI"/>
    </xsl:template>
    <xsl:template match="tei:TEI">
        <html>
            <head>
                <title>
                    <xsl:value-of select="tei:teiHeader//tei:title"/>
                </title>
                <link rel="stylesheet"
                    href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
                    integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z"
                    crossorigin="anonymous"/>
                <!--<link>
                    <xsl:attribute name="rel">stylesheet</xsl:attribute>
                    <xsl:attribute name="href">../css/screen.css</xsl:attribute>
                    <xsl:attribute name="type">text/css</xsl:attribute>-->
                <!--<xsl:attribute name="media">screen</xsl:attribute>-->
                <!--</link>-->
                <link rel="stylesheet" href="../css/styles.css" type="text/css" media=""/>
                <!--<link>
                    <xsl:attribute name="rel">stylesheet</xsl:attribute>
                    <xsl:attribute name="href">../css/print.css</xsl:attribute>
                    <xsl:attribute name="type">text/css</xsl:attribute>
                    <xsl:attribute name="media">print</xsl:attribute>
                </link>-->
            </head>
            <body>

                <!--            <div class="summary">
                    <nav role="navigation">
                        <ul class="toc">-->
                <!-- Title -->
                <!--<xsl:choose>
                                <xsl:when test="//tei:fileDesc//tei:title">
                                    <li class="">
                                        <a href=".">
                                            <xsl:value-of select="//tei:fileDesc//tei:title"/>
                                        </a>
                                    </li>
                                    <li class="divider"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <li>Title missing</li>
                                </xsl:otherwise>
                            </xsl:choose>-->
                <!-- Metadata section -->
                <!--<xsl:if test="//tei:teiHeader">
                                <li class="chapter">
                                    <a href="#metadata-section">Metadata</a>
                                </li>
                            </xsl:if>
                            <xsl:if test="//tei:titlePage">
                                <li>
                                    <a href="#titlepage-section">Titelblad</a>
                                </li>
                            </xsl:if>

                            <xsl:for-each select="//tei:front/tei:div">
                                <xsl:variable name="section-id">
                                    <xsl:value-of select="@xml:id"/>
                                </xsl:variable>
                                <li>
                                    <a href="#{$section-id}">
                                        <xsl:value-of
                                            select="tei:head[@type = 'add'] | tei:head/tei:reg[not(@xml:lang = 'en')]"
                                        />
                                    </a>
                                </li>
                            </xsl:for-each>-->
                <!-- Text body -->
                <!--<xsl:for-each select="//tei:body/tei:div">
                                <xsl:variable name="section-id">
                                    <xsl:value-of select="@xml:id"/>
                                </xsl:variable>
                                <li>
                                    <a href="#{$section-id}">
                                        <xsl:value-of
                                            select="tei:head[@type = 'add'] | tei:head/tei:reg[not(@xml:lang = 'en')]"
                                        />
                                    </a>-->
                <!-- If there's a subsection -->
                <!--<xsl:if test="tei:div">
                                        <ul class="dropdown-container">
                                            <button class="dropbtn">
                                                <i class="fa fa-caret-down"/>
                                            </button>
                                            <xsl:for-each select="tei:div">
                                                <xsl:variable name="subsection-id">
                                                  <xsl:value-of select="@xml:id"/>
                                                </xsl:variable>
                                                <li>
                                                  <a href="#{$subsection-id}">
                                                  <xsl:if test="@n">
                                                  <b>
                                                  <xsl:value-of select="@n"/>&#8194; </b>
                                                  </xsl:if>
                                                  <xsl:value-of
                                                  select="tei:head[@type = 'add'] | tei:head/tei:reg[not(xml:lang = 'en')]"
                                                  />
                                                  </a>
                                                </li>
                                            </xsl:for-each>
                                        </ul>
                                    </xsl:if>-->
                <!-- </li>
                            </xsl:for-each>
                            <xsl:for-each select="//tei:back/tei:div">
                                <xsl:variable name="section-id">
                                    <xsl:value-of select="@xml:id"/>
                                </xsl:variable>
                                <li>
                                    <a href="#{$section-id}">
                                        
                                            
                                                <xsl:value-of
                                            select="tei:head[@type = 'add'] | tei:head/tei:reg"/>
                                            
                                    </a>-->
                <!-- If there's a subsection -->
                <!--<xsl:if test="tei:div">
                                        <ul class="dropdown-container">
                                            <button class="dropbtn">
                                                <i class="fa fa-caret-down"/>
                                            </button>
                                            <xsl:for-each select="tei:div">
                                                <xsl:variable name="subsection-id">
                                                  <xsl:value-of select="@xml:id"/>
                                                </xsl:variable>
                                                <li>
                                                  <a href="#{$subsection-id}">
                                                  <xsl:if test="@n">
                                                  <b>
                                                  <xsl:value-of select="@n"/>&#8194; </b>
                                                  </xsl:if>
                                                  <xsl:value-of
                                                  select="tei:head[@type = 'add'] | tei:head/tei:reg[not(xml:lang = 'en')]"
                                                  />
                                                  </a>
                                                </li>
                                            </xsl:for-each>
                                        </ul>
                                    </xsl:if>
                                </li>
                            </xsl:for-each>-->

                <!--<xsl:choose>
                                <xsl:when test="//tei:teiHeader">
                                    <li class="chapter">
                                        <a href="#metadata-section">Metadata</a>
                                    </li>
                                </xsl:when>
                            </xsl:choose>
                            <xsl:choose>
                                <xsl:when test="//tei:titlePage">
                                    <li class="chapter">
                                        <a href="#titlepage-section">Title page</a>
                                    </li>
                                </xsl:when>
                            </xsl:choose>
                            <li>1. Indledning</li>
                            <li>2. Metadata</li>-->
                <!--</ul>
                    </nav>
                </div>-->

                <nav class="navbar fixed-top navbar-expand-md navbar-light bg-light">
                    <div class="container">
                        <a class="navbar-brand" href="#">
                            <xsl:value-of
                                select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[not(@xml:lang = 'en')]"
                            />
                        </a>
                        <button class="navbar-toggler" type="button" data-toggle="collapse"
                            data-target="#navbarSupportedContent"
                            aria-controls="navbarSupportedContent" aria-expanded="false"
                            aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"/>
                        </button>

                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav mr-auto">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                                        role="button" data-toggle="dropdown" aria-haspopup="true"
                                        aria-expanded="false"> Indhold </a>
                                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                        <xsl:for-each select="//tei:text/*/*">
                                            <xsl:variable name="section-id">
                                                <xsl:value-of select="@xml:id"/>
                                            </xsl:variable>

                                            <a href="#{$section-id}" class="dropdown-item">
                                                <xsl:choose>
                                                  <xsl:when test="@xml:id = 'titelblad'"
                                                  >Titelblad</xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:value-of
                                                  select="tei:head[@type = 'add'] | tei:head/tei:reg[not(@xml:lang = 'en')]"
                                                  />
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </a>
                                        </xsl:for-each>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <!--<nav class="navbar fixed-top navbar-light bg-light">
                        <a class="navbar-brand" href="#">Sticky top</a>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav mr-auto">
                                <li class="nav-item active">
                                    <a class="nav-link" href="#">Home <span class="sr-only"
                                            >(current)</span></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">Link</a>
                                </li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                                        role="button" data-toggle="dropdown" aria-haspopup="true"
                                        aria-expanded="false">Dropdown </a>
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                        <xsl:for-each select="//tei:body/tei:div">
                                            <xsl:variable name="section-id">
                                                <xsl:value-of select="@xml:id"/>
                                            </xsl:variable>

                                            <a href="#{$section-id}" class="dropdown-item">
                                                <xsl:value-of
                                                  select="tei:head[@type = 'add'] | tei:head/tei:reg[not(@xml:lang = 'en')]"
                                                />
                                            </a>
                                        </xsl:for-each>
                                        <a class="dropdown-item" href="#">Action</a>
                                        <a class="dropdown-item" href="#">Another action</a>
                                        <a class="dropdown-item" href="#">Something else here</a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </nav>-->
                <!-- Danish metadata section -->

                    <div class="container bg-light p-3">
                      <div class="row">
                        <div class="col">
                          <h2 class="date-place text-left">
                            <xsl:value-of select="//tei:creation/tei:date[@xml:lang='da' or not(@xml:lang)]/text()"/>
                            &#160;
                            <xsl:choose>
                              <xsl:when test="//tei:creation//tei:placeName[(text() != 'nil') or (text() != 'empty')]">
                                <xsl:value-of select="//tei:creation/tei:placeName[(text() != 'nil') or (text() != 'empty')]" />&#160;
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="//tei:correspAction[@type = 'sent']/tei:placeName" />&#160;
                              </xsl:otherwise>
                            </xsl:choose>
                            <!-- Correspondance info here -->
                            <xsl:if test="//tei:correspDesc">
                              <br/>Fra <xsl:value-of select="//tei:correspAction[@type = 'sent']/tei:persName"/>
                              til <xsl:value-of select="//tei:correspAction[@type = 'received']/tei:persName" />
                            </xsl:if>
                            <hr/>
                            <xsl:choose>
                              <xsl:when test="//tei:abstract[@xml:lang='da' or not(@xml:lang)]">
                                <xsl:apply-templates select="//tei:abstract[@xml:lang='da' or not(@xml:lang)]"/>
                              </xsl:when>
                            </xsl:choose>
                          </h2>
                        </div>
                      </div>
                      <div class="row">
                        <div class="col small pb-2">
                          <dl class="row">
                            <xsl:for-each select="//tei:witness">
                              <dt class="col-sm-2">
                                <xsl:value-of select="@xml:id"/>
                              </dt>
                              <dd class="col-sm-10">
                                <xsl:choose>
                                  <xsl:when test="tei:msDesc">
                                    <xsl:for-each select="tei:msDesc[@xml:lang='da' or not(@xml:lang)]/tei:msIdentifier/*[text() != 'empty']">
                                      <xsl:value-of select="."/>
                                      <xsl:if test="position() != last()">, </xsl:if>
                                      <xsl:if test="position() = last() and child::node() != 'empty'" >. </xsl:if>
                                      <!--Display physical description-->
                                      <xsl:apply-templates select="tei:msDesc[@xml:lang='da' or not(@xml:lang)]/tei:physDesc/tei:ab"/>
                                    </xsl:for-each>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:apply-templates/>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </dd>
                            </xsl:for-each>
                          </dl>
                        </div>
                      </div>
                      <!-- English metadata section -->
                      <xsl:if test="//@xml:lang='enX'">
                        <div class="container bg-light p-3">
                          <h1 class="text-left">Metadata: engelsk</h1>
                          <div class="row">
                            <div class="col">Titel:</div>
                            <div class="col">
                              <xsl:value-of select="//tei:fileDesc/tei:titleStmt/tei:title[@xml:lang = 'en']"/>
                            </div>
                          </div>
                          <!-- <xsl:choose> -->
                            <!--   <xsl:when test="//tei:fileDesc//"></xsl:when> -->
                            <!-- </xsl:choose> -->
                          <div class="row">
                            <div class="col">
                              <h2 class="date-place text-left">
                                <xsl:value-of
                                select="//tei:creation/tei:date[@xml:lang = 'en']/text()"/>
                                &#160;
                                <xsl:choose>
                                  <xsl:when
                                  test="//tei:creation//tei:placeName[@xml:lang = 'en'][(text() != 'nil') or (text() != 'empty')]">
                                  <xsl:text> </xsl:text>
                                  <xsl:value-of
                                  select="//tei:creation/tei:placeName[@xml:lang = 'en'][(text() != 'nil') or (text() != 'empty')]"
                                  />&#160;
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:text> </xsl:text>
                                  <xsl:value-of
                                  select="//tei:correspAction[@type = 'sent']/tei:placeName"
                                  />&#160;
                                </xsl:otherwise>
                              </xsl:choose>
                              <!-- Correspondance info here -->
                              <xsl:if test="//tei:correspDesc">From <xsl:value-of
                              select="//tei:correspAction[@type = 'sent']/tei:persName"
                              /> to <xsl:value-of
                              select="//tei:correspAction[@type = 'received']/tei:persName"
                              /></xsl:if>
                          <hr/>
                        </h2>
                      </div>
                    </div>
                  </div>
                </xsl:if>

                <!--<div class="container bg-light p-3">-->
                  <!--    <div class="row">-->
                    <!--        <div class="col">-->
                      <!--            <h2 class="date-place text-left">-->
                        <!--                <xsl:value-of-->
                          <!--                    select="//tei:creation/tei:date[@xml:lang = 'en']/text()"/>-->
                          <!--                &#160;-->
                          <!--                <xsl:choose>-->
                            <!--                    <xsl:when-->
                              <!--                        test="//tei:creation//tei:placeName[@xml:lang = 'en'][(text() != 'nil') or (text() != 'empty')]">-->
                              <!--                        <xsl:text> </xsl:text>-->
                              <!--                        <xsl:value-of-->
                                <!--                            select="//tei:creation/tei:placeName[@xml:lang = 'en'][(text() != 'nil') or (text() != 'empty')]"-->
                                <!--                        />&#160;-->
                                <!--                    </xsl:when>-->
                                <!--                    <xsl:otherwise>-->
                                  <!--                        <xsl:text> </xsl:text>-->
                                  <!--                        <xsl:value-of-->
                                    <!--                            select="//tei:correspAction[@type = 'sent']/tei:placeName"-->
                                    <!--                        />&#160;-->
                                    <!--                    </xsl:otherwise>-->
                                    <!--                </xsl:choose>-->
                                    <!--                <!-1- Correspondance info here -1->-->
                                    <!--                <xsl:if test="//tei:correspDesc">From <xsl:value-of-->
                                      <!--                        select="//tei:correspAction[@type = 'sent']/tei:persName"-->
                                      <!--                    /> to <xsl:value-of-->
                                      <!--                        select="//tei:correspAction[@type = 'received']/tei:persName"-->
                                      <!--                    /></xsl:if>-->
                                      <!--                <hr/>-->
                                      <!--            </h2>-->

                                      <!--        </div>-->
                                      <!--    </div>-->
                                      <!--    <div/>-->
                                      <!--    <div class="row">-->
                                        <!--        <div class="col small pb-2">-->
                                          <!--            <dl class="row">-->
                                            <!--                <xsl:for-each select="//tei:witness">-->
                                            <!--                    <dt class="col-sm-2">-->
                                              <!--                        <xsl:value-of select="@xml:id"/>-->
                                              <!--                    </dt>-->
                                              <!--                    <dd class="col-sm-10">-->

                                                <!--                        <!-1-Identify the source (manuscript or book)-1->-->
                                                <!--                        <xsl:for-each-->
                                                  <!--                            select="tei:msDesc[@xml:lang='en']/tei:msIdentifier/*[text() != 'empty']">-->
                                                  <!--                            <xsl:value-of select="."/>-->
                                                  <!--                            <xsl:if test="position() != last()">, </xsl:if>-->
                                                  <!--                            <xsl:if-->
                                                    <!--                              test="position() = last() and child::node() != 'empty'"-->
                                                    <!--                              >. </xsl:if>-->
                                                    <!--                        </xsl:for-each>-->

                                                    <!--                        <!-1-Display physical description-1->-->
                                                    <!--                        <xsl:apply-templates-->
                                                      <!--                            select="tei:msDesc[@xml:lang='en']/tei:physDesc/tei:ab"/>-->

                                                      <!--                    </dd>-->



                                                      <!--                </xsl:for-each>-->
                                                      <!--            </dl>-->

                                                      <!--        </div>-->
                                                      <!--    </div>-->
                                                      <!--</div>-->

                                                  </div>
                <div class="container text-section">
                  <div class="col">
                    <div class="my-5">
                      <xsl:apply-templates select="tei:text/*/*"/>
                    </div>
                    <!--<xsl:if test="//tei:app">
                      <hr/>
                      <div class="notes mt-5">
                        <h2>Kritisk apparat</h2>
                        <xsl:apply-templates select="//tei:app" mode="apparatusCriticus"/>
                      </div>
                    </xsl:if>
                    <xsl:if test="//tei:cit">
                      <hr/>
                      <div class="notes mt-5">
                          <h2>Citater</h2>
                        <xsl:apply-templates select="//tei:cit" mode="quotationApparatus"/>
                      </div>
                    </xsl:if>-->
                  </div>
                    <!--</div>-->
                    <!--<xsl:if test="//tei:note">
                        <div>
                            <h2>Fodnoter</h2>
                            <xsl:apply-templates select="//tei:note[@place = 'bottom']"
                                mode="footnoteApparatus"/>
                        </div>
                    </xsl:if>-->
                    <!--<xsl:if test="//tei:cit">
                        <div>
                            <h2>Citater</h2>
                            <xsl:apply-templates select="//tei:cit" mode="quotationApparatus"/>
                        </div>
                    </xsl:if>-->

                    <!--<xsl:if test="//tei:note[@type='add']">
                    <div>
                        <h3>Kommentarer</h3>
                        <xsl:apply-templates select="//tei:note[@type='add']"/>
                    </div>
                </xsl:if>-->

                    <!--</div>
                    </div>-->

                </div>
                <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"/>
                <script  type="text/javascript" src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"/>
                <script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"/>
                <script type="text/javascript" src="../js/tekstnet.js"></script>
                <!--For Math rendition-->
                <!-- <script src="https://polyfill.io/v3/polyfill.min.js?features=es6"/> -->
                <script id="MathJax-script" async="async" src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"/>
                <!-- <link> -->
                <!--     <xsl:attribute name="src">../js/dropdown.js</xsl:attribute> -->
                <!-- </link> -->
                <!-- <script type="text/javascript" src="/js/jquery-3.5.1.min.js"></script> -->
                <!-- <script type="text/javascript" src="/js/popper.min.js"></script> -->
                <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js" integrity="sha512-2rNj2KJ+D8s1ceNasTIex6z4HWyOnEYLVC3FigGOmyQCZc2eBXKgOxQmo3oKLHyfcj53uz4QMsRCWNbLd32Q1g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script> -->
                <!-- <script type="text/javascript" src="../js/bootstrap.min.js"></script> -->
                <!-- <script id="MathJax-script" async="" src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script> -->
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
