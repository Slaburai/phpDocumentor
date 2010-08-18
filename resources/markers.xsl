<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output indent="yes" method="html" />
  <xsl:include href="themes/default/chrome.xsl" />

  <xsl:template match="/project">
    <div id="nb-toolbar">
      <a href="{$root}/index.html">Back to overview</a>
    </div>

    <div class="tabs">
      <ul>
      <xsl:for-each select="marker">
        <xsl:variable name="marker" select="." />
        <li><a href="#{$marker}"><xsl:value-of select="$marker" /> (
          <xsl:if test="$marker='todo'">
          <xsl:value-of select="count(../file/markers/*[name()=$marker]|//tag[@name='todo'])" />
          </xsl:if>
          <xsl:if test="not($marker='todo')">
            <xsl:value-of select="count(../file/markers/*[name()=$marker])" />
          </xsl:if>
          )</a></li>
      </xsl:for-each>
      </ul>

      <xsl:for-each select="marker">
      <xsl:variable name="marker" select="." />
      <div id="{$marker}">
        <table>
          <tr><th>Path</th><th>Description</th></tr>
        <xsl:if test="$marker='todo'">
          <xsl:for-each select="//tag[@name='todo']">
            <tr><td><xsl:value-of select="../../../../@path|../../@path|../../../@path" /></td><td><xsl:value-of select="." /></td></tr>
          </xsl:for-each>
        </xsl:if>
        <xsl:for-each select="../file/markers/*[name()=$marker]">
          <tr><td><xsl:value-of select="../../@path" /></td><td><xsl:value-of select="." /></td></tr>
        </xsl:for-each>
        </table>
      </div>
      </xsl:for-each>
    </div>
  </xsl:template>

</xsl:stylesheet>