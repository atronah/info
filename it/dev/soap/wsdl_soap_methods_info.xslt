<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/">
    <xsl:output method="text" encoding="UTF-8" indent="yes"/>

    <!-- Disable default template (transform all text nodes to plain text -->
    <xsl:template match="text()" />

    <xsl:template match="*/wsdl:portType">
        <xsl:for-each select="wsdl:operation">
            <xsl:value-of select="@name"/><xsl:text>&#xa;</xsl:text>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>