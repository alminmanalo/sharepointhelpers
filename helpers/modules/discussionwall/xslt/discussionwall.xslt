<xsl:stylesheet
xmlns:x="http://www.w3.org/2001/XMLSchema"
xmlns:d="http://schemas.microsoft.com/sharepoint/dsp"
version="1.0"
exclude-result-prefixes="x d xsl msxsl ddwrt"
xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime"
xmlns:asp="http://schemas.microsoft.com/ASPNET/20"
xmlns:__designer="http://schemas.microsoft.com/WebParts/v2/DataView/designer"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:msxsl="urn:schemas-microsoft-com:xslt"
xmlns:SharePoint="Microsoft.SharePoint.WebControls"
xmlns:ddwrt2="urn:frontpage:internal">
	<xsl:import href="/_layouts/xsl/main.xsl"/>
	
	<xsl:output method="html" indent="no"/>
	<xsl:template match="/" xmlns:x="http://www.w3.org/2001/XMLSchema">
		<xsl:variable name="Rows" select="/dsQueryResponse/Rows/Row" />

		<div class="bootstrap">
			<div class="trumbowygContainer" placeholder="What do you want to say?" style="height: 50px;"></div>
			
			<div class="navbar navbar-default noPadding noBorder noMargin postDiscussionActionContainer" role="navigation">
				<div class="container noPadding noBorder noMargin">
					<div class="navbar-header navbar-right noPadding noBorder noMargin">
						<button type="button" class="btn btn-primary navbar-btn noHide">Submit</button>
					</div>
				</div>
			</div>

			<xsl:for-each select="$Rows">
				<xsl:call-template name="DiscussionWallTemplate" />
			</xsl:for-each>
		</div>

		<!-- STYLES HERE -->
		<link rel="stylesheet" href="{$HttpVDir}/DiscussionCatalog/css/libraries/bootstrap.min.css" />
		<link rel="stylesheet" href="{$HttpVDir}/DiscussionCatalog/css/libraries/bootstrap-theme.min.css" />
		<link rel="stylesheet" href="{$HttpVDir}/DiscussionCatalog/css/libraries/trumbowyg.min.css" />
		<link rel="stylesheet" href="{$HttpVDir}/DiscussionCatalog/css/overridebootstrap.min.css" />
		<link rel="stylesheet" href="{$HttpVDir}/DiscussionCatalog/css/overridebootstrap-theme.min.css" />
		<link rel="stylesheet" href="{$HttpVDir}/DiscussionCatalog/css/discussionstyle.min.css" />

		<!-- SCRIPTS HERE -->
		<script src="https://code.jquery.com/jquery-latest.min.js"></script>
		<script src="{$HttpVDir}/DiscussionCatalog/js/libraries/bootstrap.min.js"></script>
		<script src="{$HttpVDir}/DiscussionCatalog/js/libraries/trumbowyg.min.js"></script>
		<script src="{$HttpVDir}/DiscussionCatalog/js/discussions.min.js"></script>
	</xsl:template>
	<xsl:template name="DiscussionWallTemplate">
		<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
		<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

		<xsl:variable name="AuthorProfileUrl">
			<xsl:call-template name="replace-string">
				<xsl:with-param name="text" select="translate(substring-before(@Author.picture, '?'), $uppercase, $smallcase)"/>
				<xsl:with-param name="replace" select="'mthumb'" />
				<xsl:with-param name="with" select="'sthumb'"/>
			</xsl:call-template>
		</xsl:variable>

		<div class="panel panel-default">
			<div class="panel-header">
				<ul class="nav nav-pills">
					<li class="dropdown floatRight">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="caret"></span></a>
						<ul class="dropdown-menu dropdown-menu-right">
							<li><a href="#">Action</a></li>
							<li><a href="#">Another action</a></li>
							<li><a href="#">Something else here</a></li>
							<li role="separator" class="divider"></li>
							<li><a href="#">Separated link</a></li>
						</ul>
					</li>
				</ul>
			</div>
			<div class="panel-body">
				<div class="media">
					<div class="media-left">
						<a target="_blank" href="{$HttpVDir}/_layouts/15/userdisp.aspx?ID={@Author.id}">
							<img class="media-object">
								<xsl:attribute name="src">
									<xsl:value-of select="$AuthorProfileUrl" />
								</xsl:attribute>
							</img>
						</a>
					</div>
					<div class="media-body">
						<h4 class="media-heading"><xsl:value-of select="@Author.title" /></h4>
						<xsl:value-of select="@Body" disable-output-escaping="yes" />
						<ul class="nav nav-pills" role="tablist">
							<li role="presentation">
								<a href="#">Like 
									<xsl:text> </xsl:text>
									<span class="glyphicon glyphicon-thumbs-up" aria-hidden="true">
										<xsl:text> </xsl:text>
									</span>
									<xsl:text> </xsl:text>
									<span class="badge"><xsl:value-of select="@LikesCount" disable-output-escaping="yes" /></span>
								</a>
							</li>
							<li role="presentation"><a href="#">Comments <span class="badge">3</span></a></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="panel-footer">
				<div class="media-left currentUserProfile"></div>
				<div class="media-body">
					<div class="input-group input-group-lg">
						<input type="text" class="form-control" placeholder="Comment" />
						<span class="input-group-btn">
							<button class="btn btn-default" type="button">Post</button>
						</span>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>
	<xsl:template name="replace-string">
		<xsl:param name="text"/>
		<xsl:param name="replace"/>
		<xsl:param name="with"/>
		<xsl:choose>
			<xsl:when test="contains($text,$replace)">
				<xsl:value-of select="substring-before($text,$replace)"/>
				<xsl:value-of select="$with"/>
				<xsl:call-template name="replace-string">
					<xsl:with-param name="text" select="substring-after($text,$replace)"/>
					<xsl:with-param name="replace" select="$replace"/>
					<xsl:with-param name="with" select="$with"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>