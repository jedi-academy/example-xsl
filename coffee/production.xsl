<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : production.xsl
    Created on : November 20, 2013
    Author     : jim
    Description:
        Produce the trends production report, using the views/production_report,
        views/production_subreport and views/regional_totals as guidelines.
        This only produces an HTML fragment, and is intended to be embedded
        in a webpage with banner(s), nav/sidebar(s) and footer(s).
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>

    <!-- 
    
    -->
    <xsl:template match="/">
        <h1>Exporting Countries: Total Production</h1>
        <h4>Thousands of 60 pound bags</h4>
        <table class="table table-bordered table-condensed myreport">
            <xsl:call-template name="headings"/>
            <xsl:call-template name="world_totals"/>
            <xsl:call-template name="members_report"/>
            <xsl:call-template name="non_members_report"/>
        </table>
    </xsl:template>


    <xsl:template name="headings">
        <thead>
            <tr>
                <th>(000 bags)</th>
                <xsl:for-each select="/production/region[1]/country[1]/value">
                    <th>
                        <xsl:value-of select="./@year"/>
                    </th>                   
                </xsl:for-each>
            </tr>
        </thead>
    </xsl:template>
    
    <xsl:template name="world_totals">
        <tr>
            <td>
                <b>WORLD TOTALS</b>
            </td>
            <xsl:for-each select="/production/region[1]/country[1]/value">
                <xsl:variable name="year" select="./@year"/>
                <td>
                    <b>
                        <xsl:value-of select="sum(//value[@year=$year])"/>
                    </b>
                </td>                   
            </xsl:for-each>
        </tr>
    </xsl:template>
    
    <xsl:template name="members_report">
        <tr>
            <td>
                <b>Member countries</b>
            </td>
            <xsl:for-each select="/production/region[1]/country[1]/value">
                <xsl:variable name="year" select="./@year"/>
                <td>
                    <b>
                        <xsl:value-of select="sum(//value[@year=$year]) - sum(//country[@member='N']/value[@year=$year])"/>
                    </b>
                </td>                   
            </xsl:for-each>
        </tr>
        <xsl:for-each select="//country">
            <xsl:sort select="name"/>
            <xsl:choose>
                <xsl:when test="@member='N'"></xsl:when>
                <xsl:otherwise>
                    <tr>
                        <td>
                            <xsl:value-of select="name"/>
                        </td>
                        <xsl:for-each select="value">
                            <xsl:sort select="@year"/>
                            <td>
                                <xsl:value-of select="."/>
                            </td>
                        </xsl:for-each>
                    </tr>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
        
    </xsl:template>
    
    <xsl:template name="non_members_report">
        <tr>
            <td>
                <b>Non-member countries</b>
            </td>
            <xsl:for-each select="/production/region[1]/country[1]/value">
                <xsl:variable name="year" select="./@year"/>
                <td>
                    <b>
                        <xsl:value-of select="sum(//country[@member='N']/value[@year=$year])"/>
                    </b>
                </td>                   
            </xsl:for-each>
        </tr>
        <xsl:for-each select="//country">
            <xsl:sort select="name"/>
            <xsl:choose>
                <xsl:when test="@member='N'">                    
                    <tr>
                        <td>
                            <xsl:value-of select="name"/>
                        </td>
                        <xsl:for-each select="value">
                            <xsl:sort select="@year"/>
                            <td>
                                <xsl:value-of select="."/>
                            </td>
                        </xsl:for-each>
                    </tr>
                </xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>
