<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl">
<xsl:output method="text" version="1.0" encoding="UTF-8"/> 

<xsl:strip-space elements="*"/>

<xsl:variable name="paths">
	<xsl:apply-templates select="node()" mode="path-returning"/>
</xsl:variable>

<!-- https://stackoverflow.com/a/18886096/1447002 -->
<xsl:template match="/">
	<xsl:for-each select="exsl:node-set($paths)/path[not(.=preceding::*)]">
	<xsl:sort select="." order="ascending"/>
<!--
	<xsl:sort data-type="number" select="string-length(.)"/>
-->
		<xsl:value-of select="."/><xsl:text>&#xd;&#xa;</xsl:text>
	</xsl:for-each>
</xsl:template>

<xsl:template match="node()" mode="path-returning">
	<xsl:param name="location"></xsl:param>
	<xsl:variable name="path"><xsl:value-of select="$location"/><xsl:text>/</xsl:text><xsl:value-of select="name()"/></xsl:variable>

	<xsl:apply-templates  select="node()" mode="path-returning">
		<xsl:with-param name="location"><xsl:value-of select="$path"/></xsl:with-param>
	</xsl:apply-templates>

	<xsl:if test="count(*) &lt; 1">
		<path><xsl:value-of select="$path"/></path>
	</xsl:if>

</xsl:template>

<xsl:template match="text()"></xsl:template>
<xsl:template match="text()" mode="path-returning"></xsl:template>

</xsl:stylesheet>