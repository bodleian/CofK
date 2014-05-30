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
                       <xsl:copy-of select="graph"/>
                          
                          
                         <xsl:for-each select="field">
                         <xsl:variable name="fieldId" select="@id"/>
                         
                        
                         <xsl:copy>
                         <xsl:copy-of select="@id"/>
                             <!-- is the field repeatable - default at the moment is yes-->
                             <xsl:attribute name="repeat">yes</xsl:attribute> 
                             
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
                         
                         
                               <!-- 
                           <field id="date" type="date" title="Date " placeHolder="Enter details of date "/>
		       				
		       				EMLO database schema for date
                             date_of_death_year     :   { type: Number },
      date_of_death_month    :   { type: Number },
      date_of_death_day      :   { type: Number },
      date_of_death_is_range :   { type: Number },
      date_of_death2_year    :   { type: Number },
      date_of_death2_month   :   { type: Number },
      date_of_death2_day     :   { type: Number },
      date_of_death_inferred :   { type: Number },
      date_of_death_uncertain:   { type: Number },
      date_of_death_approx   :   { type: Number },
                          
                          -->
                               <field id="date_is_range" position="start" type="checkbox" title="Is this a date range?" placeHolder=""/>
                               <field id="date_year"  group="start"  position="start" type="" title="Year" placeHolder="Enter year"/>
                               <field id="date_month" type="" title="Month" placeHolder="Enter month  "/>
                               <field id="date_day" type="" title="Day" placeHolder="Enter day  "/>
                               
                               <field id="date_inferred" position="start" type="checkbox" title="Inferred date" placeHolder=""/>
                               <field id="date_uncertain" type="checkbox" title="Uncertain date" placeHolder=""/>
                               <field id="date_approximate"  group="end" position="end" type="checkbox" title="Approximate date" placeHolder=""/>
                              
                              
                               
                               <field id="location_name" position="start"  title="Location name" placeHolder="Enter details of location name"/>
                               <field id="element_1_eg_room"  title="Room" placeHolder="Enter details of room"/>
                               <field id="element_2_eg_building"  title="Building" placeHolder="Enter details of building"/>
                               <field id="element_3_eg_parish"  title="Parish" placeHolder="Enter details of parish"/>
                               <field id="element_4_eg_city"  title="City" placeHolder="Enter details of city"/>
                               <field id="element_5_eg_county"  title="County" placeHolder="Enter details of county"/>
                               <field id="element_6_eg_country"  title="Country" placeHolder="Enter details of country"/>
                               <field id="element_7_eg_empire" position="end" title="Empire" placeHolder="Enter details of empire"/>
                               <field id="notes_on_place" size="12" type="textarea" position="end" title="Notes on place" placeHolder="Enter details of notes on place"/>
                               
                               
                               <!-- 
                                   
              EMLO database schema for location                   
                                   
                                   var locationSchema = new mongoose.Schema({ 
      location_id            :  { type: Number },
      location_name          :  { type: String },
      element_1_eg_room      :  { type: String },
      element_2_eg_building  :  { type: String },
      element_3_eg_parish    :  { type: String },
      element_4_eg_city      :  { type: String },
      element_5_eg_county    :  { type: String },
      element_6_eg_country   :  { type: String },
      element_7_eg_empire    :  { type: String },
      notes_on_place         :  { type: String },
      editors_notes          :  { type: String }
   }); -->
                               
                         
                         
                         
                         
                           </xsl:copy>
                           
                           
                           
                       </xsl:for-each>                        
                        
                    </xsl:for-each>
                    
             </xsl:copy>
        </xsl:for-each>
                  </form>
      
             
    </xsl:template>
   
   
</xsl:stylesheet>