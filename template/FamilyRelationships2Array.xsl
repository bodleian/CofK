<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    exclude-result-prefixes="xs" version="2.0" xmlns="http://www.w3.org/2002/07/owl#"
    xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#">
    <xsl:output indent="yes" method="text" />

    <xd:doc type="stylesheet"> The purpose of this stylesheet is to generate the family.js file that is used to populate a family relationship field in the prosopography input form </xd:doc>




    <xd:doc>
        <xd:short>  </xd:short>
        
        
        
    </xd:doc>

    <xsl:template match="/">
       
            <xsl:text>
                $(function() {
                
                var relationships = [</xsl:text>
            <xsl:for-each select=".//owl:Declaration[owl:ObjectProperty]" >
            
                <xsl:apply-templates mode="Declaration" select="."/>
                
            </xsl:for-each>
        <xsl:text>];
            
             $( "#FamilyRelationships-FamilyRole" ).autocomplete({
                    source: relationships
                    });
                    });
            
            
        
        </xsl:text>
    </xsl:template>






    <xd:doc>
       
        

    </xd:doc>

    <xsl:template mode="Declaration" match="owl:Declaration">
        <xsl:variable name="iri" select="owl:ObjectProperty/@IRI"/>
        <xsl:text>"</xsl:text><xsl:value-of select="$iri"/><xsl:text>"</xsl:text>
        
        <xsl:if test="count(following-sibling::owl:Declaration) > 0">
            <xsl:text>, 
            </xsl:text>
            
        </xsl:if>
        
       
  
    </xsl:template>








</xsl:stylesheet>
