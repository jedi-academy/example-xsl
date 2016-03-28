<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : AC7flight.xsl
    Created on : March 3, 2011, 2:11 PM
    Author     : jim
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Air Canada schedules for Toronto</title>
            </head>
            <body>
                <h2>Flight-centric data, hard-coded to select Toronto</h2>
                <xsl:call-template name="arrivals"/>
                <xsl:call-template name="departures"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="arrivals">
        <h1>Toronto Arrivals</h1>
        <table>
            <tr>
                <th>Arriving at</th>
                <th>From</th>
                <th>Flight #</th>
            </tr>
            <xsl:for-each select="/schedule/flight[@to='TTZ']/instance">
                <xsl:sort select="@arrive"/>
                <xsl:call-template name="arrival_flight"/>
            </xsl:for-each>
        </table>
    </xsl:template>

    <xsl:template name="arrival_flight">
        <tr>
            <td>
                <xsl:value-of select="@arrive"/>
            </td>
            <td>
                <xsl:value-of select="../@from"/>
            </td>
            <td>
                <xsl:value-of select="../@num"/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template name="departures">
        <h1>Toronto Departures</h1>
        <table>
            <tr>
                <th>Leaving at</th>
                <th>Destination</th>
                <th>Flight #</th>
            </tr>
            <xsl:for-each select="/schedule/flight[@from='TTZ']/instance">
                <xsl:sort select="@leave"/>
                <xsl:call-template name="departing_flight"/>
            </xsl:for-each>
        </table>
    </xsl:template>

    <xsl:template name="departing_flight">
        <tr>
            <td>
                <xsl:value-of select="@leave"/>
            </td>
            <td>
                <xsl:value-of select="../@to"/>
            </td>
            <td>
                <xsl:value-of select="../@num"/>
            </td>
        </tr>
    </xsl:template>

</xsl:stylesheet>
