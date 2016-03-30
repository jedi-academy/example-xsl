<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : pricing.xsl
    Created on : November 20, 2013, 10:08 AM
    Author     : jim
    Description:
        Produce the trends pricing report, using the views/pricing_report
        as a guideline.
        This only produces an HTML fragment, and is intended to be embedded
        in a webpage with banner(s), nav/sidebar(s) and footer(s).
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>

    <!-- 
    This top-level template provides the report titles and a table wrapper
    with headings.
    -->
    <xsl:template match="/">
        <h1>Coffee Bean Pricing - ICO Indicator Prices</h1>
        <h4>US cents per pound (lb)</h4>
        <table class="table table-bordered table-condensed myreport">
            <xsl:call-template name="headings"/>
            <xsl:apply-templates select="/pricing/averages"/>            
        </table>
    </xsl:template>

    <!-- 
    This template creates the trends tale headings.
    -->
    <xsl:template name="headings">
        <thead>
            <tr>
                <th>Annual</th>
                <xsl:for-each select="/pricing/beans/bean">
                    <th colspan="2">
                        <xsl:value-of select="."/>
                    </th>                   
                </xsl:for-each>
            </tr>
            <tr>
                <th>Averages</th>
                <xsl:for-each select="/pricing/averages[1]/entry">
                    <th>
                        <xsl:variable name="which" select="./@market"/>
                        <xsl:value-of select="/pricing/markets/market[@code=$which][1]"/>
                    </th>                  
                </xsl:for-each>

            </tr>
        </thead>
    </xsl:template>
    
    <xsl:template match="averages">
        <tr>
            <td><xsl:value-of select="./@year"/></td>
            <xsl:for-each select="entry">
                <td>
                    <xsl:value-of select="."/>
                </td>                   
            </xsl:for-each>       
        </tr>
    </xsl:template>
    
</xsl:stylesheet>
