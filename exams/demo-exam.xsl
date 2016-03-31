<?xml version="1.0"?>
<!--
Note: it is possible to get this looking just like the distributed timetables, 
but not without going into much more advanced XSL.
This XSL serves our demonstration purposes.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>


    <xsl:template match="/">
        <html>
            <head>
                <title>Computing Demo Exam Midterm Schedule</title>
            </head>
            <body>
                <h1>Computing Demo Exam Midterm Schedule</h1>
                <table>
                    <xsl:call-template name="headings"/>
                    <xsl:apply-templates select="/exams/block"/>                    
                </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="headings">
        <tr>
            <th>Block</th>
            <th>Monday<br/>Apr 18</th>
            <th>Tuesday<br/>Apr 18</th>
            <th>etc<br/>Apr 19</th>
            <th>etc<br/>Apr 20</th>
            <th>etc<br/>Apr 21</th>
            <th>etc<br/>Apr 22</th>
            <th>Times</th>
        </tr>
    </xsl:template>
    
    <!-- handle a student set -->
    <xsl:template match="block">
        <tr>
            <td>
                <xsl:value-of select="./@code"/>
            </td>
            <xsl:for-each select="exam">
                <xsl:sort select="./@day"/>
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </tr>
    </xsl:template>
    
    <!-- handle a single exam -->
    <xsl:template match="exam">
        <td>
            <xsl:value-of select="./@course"/><br/>
            <xsl:value-of select="./@room"/><br/>
            <xsl:value-of select="./@day"/>
            <xsl:value-of select="./@start"/>
        </td>
    </xsl:template>
    
</xsl:stylesheet>
