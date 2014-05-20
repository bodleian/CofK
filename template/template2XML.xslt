<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    <xsl:output method="xml"  indent="yes"/>
    <xsl:template match="/">
       
                  <form>
            <xsl:for-each select="document('section.xml')/template/section">
             <xsl:copy>
                 
                 <xsl:copy-of select="@*"/>
               
                    <xsl:for-each select="group">
                        <xsl:variable name="groupId" select="@id"/>
                        
                       <xsl:for-each select="document('group.xml')/template/group[@id = $groupId]"> 
                           
                           
                           
                           <xsl:copy>

                           <xsl:copy-of select="@id"/>
                               <xsl:attribute name="title" select="@id"/>    
                          <xsl:element name="description">
                                       <xsl:value-of select="document('field.xml')//field[id = $groupId]/def"/>

                          </xsl:element>
                          
                           <field id="date" type="date" title="Date " placeHolder="Enter details of date "/>
		       				<field id="location" type="location" title="Location" placeHolder="Enter details of location"/>
                          
                         <xsl:for-each select="field">
                         <xsl:variable name="fieldId" select="@id"/>
                         
                        
                         <xsl:copy>
                         <xsl:copy-of select="@id"/>
                             <xsl:attribute name="help">
                         <xsl:value-of select="document('field.xml')//field[id = $fieldId]/def"/>
                             </xsl:attribute>
                             
                             <xsl:attribute name="title">
                                 <xsl:value-of select="$fieldId"/>
                                 
                             </xsl:attribute>
                             <xsl:attribute name="placeHolder">
                                 <xsl:value-of select="concat('Enter details of ', $fieldId)"/>
                             </xsl:attribute>
                             
                         </xsl:copy>
                         
                         </xsl:for-each>
                         
                         
                         
                           </xsl:copy>
                           
                           
                           
                       </xsl:for-each>                        
                        
                    </xsl:for-each>
                    
             </xsl:copy>
        </xsl:for-each>
                  </form>
      
             
    </xsl:template>
   
   
</xsl:stylesheet>