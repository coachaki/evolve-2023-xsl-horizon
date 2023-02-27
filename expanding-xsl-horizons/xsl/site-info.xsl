<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="3.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:xs="http://www.w3.org/2001/XMLSchema"
				xmlns:ou="http://omniupdate.com/XSL/Variables"
				xmlns:ouc="http://omniupdate.com/XSL/Variables"
				expand-text="yes"
				exclude-result-prefixes="xsl xs ou ouc">

	<xsl:output method="html" version="5.0" indent="yes" encoding="UTF-8" include-content-type="no"/>
	
	<xsl:param name="ou:root"/>
	<xsl:param name="ou:site"/>
	<xsl:param name="ou:stagingpath"/>
	<xsl:param name="ou:skin" select="($ou:root => tokenize('/'))[4]"/>
	<xsl:param name="ou:account" select="($ou:root => tokenize('/'))[5]"/>
	
	<xsl:param name="ignore-extensions" select="/document/descendant::parameter[@name='ignore-extensions'] => normalize-space() => tokenize('\s*,\s*')"/>
	<xsl:param name="sites" select="let $sites := /document/descendant::parameter[@name='sites'] => normalize-space()
									return if ($sites) then tokenize($sites, '\s*,\s*') else $ou:site"/>

	<xsl:template match="processing-instruction()|comment()" />

	<xsl:template match="/document">
		<html lang="en">
			<head>
				<meta charset="UTF-8" /> <!-- charset encoding -->
				<meta http-equiv="x-ua-compatible" content="ie=edge" /> <!-- compatibility mode for IE / Edge -->
				<title>Site Info</title> <!-- page title -->
				<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" /> <!-- viewport -->
				<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous"/>
			</head>
			<body>
				<header class="p-3 text-bg-dark d-flex justify-content-center py-3">
					<span class="fs-4">Evolve 2023 User Conference</span>
				</header>
				<section class="py-5 bg-light">
					<div class="container">
						<div class="row py-lg-5">
							<div class="col-lg-6 col-md-8 mx-auto">
								<h1>Site Info</h1>
								<xsl:for-each select="$sites">
									<xsl:variable name="path" select="$ou:root || ."/>
									
									<h2>{.}</h2>
									<xsl:if test="doc-available($path)">
										<xsl:apply-templates select="doc($path)" mode="page-list">
											<xsl:with-param name="path" select="$path" tunnel="true"/>
										</xsl:apply-templates>
									</xsl:if>
								</xsl:for-each>
							</div>
						</div>
					</div>
				</section>
				<ouc:div label="fake" /> <!-- fake edit button, so that you see an html page in Edit view -->
				<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="list" mode="page-list">
		<xsl:param name="path" tunnel="true"/>
		
		<ul>
			<xsl:apply-templates select="node()" mode="#current">
				<xsl:with-param name="path" select="$path" tunnel="true"/>
				<xsl:sort select="."/>
			</xsl:apply-templates>
		</ul>
	</xsl:template>
	
	<xsl:template match="directory" mode="page-list">
		<xsl:param name="path" tunnel="true"/>
		
		<xsl:variable name="new-path" select="$path || '/' || ."/>
		
		<li>
			{.}/
			<xsl:apply-templates select="doc($new-path)" mode="#current">
				<xsl:with-param name="path" select="$new-path" tunnel="true"/>
				<xsl:sort select="."/>
			</xsl:apply-templates>
		</li>
	</xsl:template>
	
	<xsl:template match="file" mode="page-list">
		<xsl:param name="path" tunnel="true"/>
		
		<li>{.}</li>
	</xsl:template>
	
	<xsl:template match="file[let $file := . return $ignore-extensions!ends-with($file, .) = true()]" mode="page-list"/>
	
	<xsl:template match="file[ends-with(., '.pcf')]" mode="page-list">
		<xsl:param name="path" tunnel="true"/>
		
		<xsl:variable name="new-path" select="$path || '/' || ."/>
		
		<li>
			<xsl:choose>
				<xsl:when test="doc-available($new-path)">
					<a target="_blank">
						<xsl:attribute name="href" select="ou:get-preview-link($new-path)"/>
						<xsl:value-of select="."/>
						<xsl:if test="doc($new-path)/document/descendant::title[1] => normalize-space()">
							-- {doc($new-path)/document/descendant::title[1]}
						</xsl:if>
					</a>
				</xsl:when>
				<xsl:otherwise>
					{.} (invalid xml)
				</xsl:otherwise>
			</xsl:choose>
		</li>
	</xsl:template>
	
	<xsl:function name="ou:get-preview-link">
		<xsl:param name="staging-full-path" />
		
		<xsl:variable name="base-url" select="'https://a.cms.omniupdate.com/11/#'"/>
		<xsl:variable name="site" select="($staging-full-path => tokenize('/'))[6]"/>
		<xsl:variable name="staging-path" select="$staging-full-path => substring-after($ou:account || '/' || $site)"/>
		
		<xsl:value-of select="concat($base-url, $ou:skin, '/', $ou:account, '/', $site, '/previewedit', $staging-path)"/>
	</xsl:function>
	
</xsl:stylesheet>