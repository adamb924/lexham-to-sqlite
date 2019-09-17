<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="xml" version="1.0" encoding="UTF-8" omit-xml-declaration="no" indent="yes"/> 

<!--
<xsl:strip-space elements="*"/>
-->

<!-- Retain elements by default -->
<xsl:template match="node()|@*">
	<xsl:copy>
		<xsl:apply-templates  select="@*|node()"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="verse-number">
	<!-- skip the mere chapter headings -->
	<xsl:if test="contains(@id,':')">
		<!-- just to give some nice whitespace -->
		<xsl:text>&#xa;</xsl:text>
		<xsl:copy>
			<xsl:apply-templates  select="@*|node()"/>
		</xsl:copy>
	</xsl:if>
</xsl:template>

<!-- Elements to remove but keep their content -->
<xsl:template match="book|chapter|block|p|supplied|ul|li1|li2|li3|i">
	<xsl:apply-templates  select="node()"/>
</xsl:template>

<!-- Elements to omit -->

<!-- Top level elements -->
<xsl:template match="license|preface|title|trademark"></xsl:template>

<!-- More embedded elements -->
<xsl:template match="note|pericope|idiom-start|idiom-end">
<!--
<xsl:if test="not(normalize-space(following-sibling::text())='')"><xsl:text> </xsl:text></xsl:if>
-->
</xsl:template>

</xsl:stylesheet>