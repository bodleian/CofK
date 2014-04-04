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
                           <xsl:copy-of select="."/>
                       </xsl:for-each>                        
                        
                    </xsl:for-each>
                    
             </xsl:copy>
        </xsl:for-each>
                  </form>
      
             
    </xsl:template>
   
   
</xsl:stylesheet>