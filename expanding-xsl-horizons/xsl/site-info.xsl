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
	
	<xsl:mode on-no-match="shallow-copy"/>
	<xsl:template match="processing-instruction()|comment()" />

	<xsl:param name="title" select="/descendant::title[1]"/>

	<xsl:template match="/document">
		<html lang="en">
			<head>
				<meta charset="UTF-8" /> <!-- charset encoding -->
				<meta http-equiv="x-ua-compatible" content="ie=edge" /> <!-- compatibility mode for IE / Edge -->
				<title>{$title}</title> <!-- page title -->
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
								<h1>{$title}</h1>
								<!-- do stuff here -->
								<!--
									1. Use doc() function to list all files in the current site
									2. Display the title if the file is a PCF
									3. Turn the list into edit links
									4. Add support for ignoring extensions
									5. Add support for listing files from other sites
								-->
							</div>
						</div>
					</div>
				</section>
				<ouc:div label="fake" /> <!-- fake edit button, so that you see an html page in Edit view -->
				<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
			</body>
		</html>
	</xsl:template>
	
</xsl:stylesheet>