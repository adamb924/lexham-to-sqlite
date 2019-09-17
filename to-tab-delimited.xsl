<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:str="http://exslt.org/strings" extension-element-prefixes="str">
<xsl:output method="text" version="1.0" encoding="UTF-8"/> 

<xsl:strip-space elements="*"/>

<xsl:template match="/leb">
	<xsl:apply-templates select="*"/>
</xsl:template>

<xsl:template match="verse-number">
	<xsl:value-of select="str:replace(str:replace(str:replace(@id,'3 ','3'),'2 ','2'),'1 ','1')"/><xsl:text>&#x9;</xsl:text><xsl:value-of select="normalize-space(following-sibling::text()[1])"/><xsl:text>&#xd;&#xa;</xsl:text>
</xsl:template>

<xsl:template match="text()"></xsl:template>

</xsl:stylesheet>