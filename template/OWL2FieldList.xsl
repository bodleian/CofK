<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    exclude-result-prefixes="xs" version="2.0" xmlns="http://www.w3.org/2002/07/owl#"
    xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#">
    <xsl:output indent="yes" method="xml" />

    <xd:doc type="stylesheet"> The purpose of this stylesheet is to generate a list of fields
        with their definitions for use in the prosopography input form </xd:doc>




    <xd:doc>
        <xd:short>  </xd:short>
        
        
        
    </xd:doc>

    <xsl:template match="/">
        <fields>
            
            <xsl:for-each select="collection('../../../../GitHub/CAMELOT/DataModel/OWL?select=*.owl')" >
            
                <xsl:apply-templates select=".//owl:Declaration[owl:Class and (contains(owl:Class/@IRI, ':') = false()) and (contains(owl:Class/@IRI, '#') = false())]"/>
                
            </xsl:for-each>
        </fields>
    </xsl:template>






    <xd:doc>
       
        

    </xd:doc>

    <xsl:template  match="owl:Declaration">
        <xsl:variable name="iri" select="owl:Class/@IRI"/>
<field>
    <id><xsl:value-of select="$iri"/></id>
    <def><xsl:apply-templates select="../owl:AnnotationAssertion[owl:IRI=$iri]" /></def>
</field>
  
    </xsl:template>


<xsl:template match="owl:AnnotationAssertion"><xsl:value-of select="owl:Literal/text()"/></xsl:template>





</xsl:stylesheet>
