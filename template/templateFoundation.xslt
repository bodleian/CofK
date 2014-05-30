<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
   <xsl:output method="xhtml"/>
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="utf-8"/>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <title>Prosopography Input Form</title>
               
                <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
                <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
                
                <link rel="stylesheet" href="../f5/css/foundation.css" />
                <link rel="stylesheet" href="../f5/css/foundation-icons.css" />
                <script src="../f5/js/vendor/modernizr.js"></script>
               
                <script src="./js/form.js"></script>
               
                <script src="http://d3js.org/d3.v3.min.js"></script>
                
                <link rel="stylesheet" href="css/style.css"/>
            </head>
            <body>
                
                <form method="post" action="formsave">
                    
                    
                    <div class="off-canvas-wrap" data-offcanvas="">
                        <div class="inner-wrap">
                            
                           
                            <!-- Off Canvas Menu -->
                            <aside class="left-off-canvas-menu">
                                <!-- whatever you want goes here -->
                                <ul>
                                    <li class="active">
                                        <a href="#panel1a">Input Form</a>
                                    </li>
                                    <li>
                                        <a href="#panel2a">Load Data</a>
                                    </li>
                                    <li>
                                        <a href="#panel3a">Save Report</a>
                                    </li>
                                    <li>
                                        <a href="#panel4a">Validate Form</a>
                                    </li>
                                    <li>
                                        <a href="#panel5a">Help</a>
                                    </li>
                                </ul>
                            </aside>
                    
                            <p> <a class="left-off-canvas-toggle" href="#" >Menu</a>
                            </p>
                            
                            
                            <dl class="accordion" data-accordion="">
                                <dd>
                                    <a href="#panelintroduction">Introduction</a>
                                    <div id="panelintroduction" class="content active">
                                        
                                        <input type="submit" value="Submit Form"/>
                                        
                                        
                                    </div>
                            
                                </dd>
                                
                                <xsl:apply-templates mode="section" select="document('result.xml')/form/section"/>
                        <dd>
                            <a href="#panelprovenance" class="">Provenance</a>
                            <div id="panelprovenance" class="content">
                                <fieldset>
                                    <legend>Provenance of this report</legend>
                                </fieldset>
                                
                            </div>               
                        </dd>
                        </dl>
                           
                        </div>
                    </div>
               
                
                </form>
                
                
                
                <div id="myModal" class="reveal-modal" data-reveal="">
                    <p>A graphical representation of the relationships defined for this context.</p>
                    <a class="close-reveal-modal">&#215;</a>
                    
                    <svg id="mySVG"/>
                </div>
                

                <script src="http://code.jquery.com/jquery.js"></script>
                <script src="../f5/js/foundation.min.js"></script>
                <script>
                    $(document).foundation();
                </script>
                
                <script src="js/graph.js"/>
                    
                   
                <script language="javascript">                      
                    <xsl:apply-templates mode="graphFunction" select="/"/>
                </script>
                    
                    
                
             
            </body>
        </html>
        
    
    </xsl:template>
   
   
   
   
   
   
   <!-- TEMPLATES -->
   
   
   
   <xsl:template mode="section" match="section">
       
       <xsl:variable name="active" select="if (count(preceding-sibling::section) = 0) then 'active' else ''"/>
       <xsl:variable name="sectionTitle" select="@title"/>
       
       <dd>
           <a href="#panel{@id}" class="{$active}"><xsl:value-of select="@title"/></a>
           
           <div id="panel{@id}" class="content ">
               
               <dl class="tabs" data-tab="">
                   <xsl:for-each select="group"> 
                       <xsl:variable name="active2" select="if (count(preceding-sibling::group) = 0) then 'active' else ''"/>
                       
                       <xsl:variable name="groupId" select="@id"/>
                       <xsl:variable name="groupTitle" select="@title"/>
                       <dd class="{$active2}"><a  href="#{$groupId}"><xsl:value-of select="$groupTitle"/></a></dd>
                   </xsl:for-each>
                   
               </dl>
               
               <div class="tabs-content">
                   <xsl:apply-templates mode="group" select="group"/>
               </div>    
           </div>
       </dd>
       
   </xsl:template>
   
   
   
   <xsl:template mode="group" match="group">
       
       <xsl:variable name="active2" select="if (count(preceding-sibling::group) = 0) then 'active' else ''"/>
       
       <xsl:variable name="groupId" select="@id"/>
       <xsl:variable name="groupTitle" select="@title"/>
       
       
       <script language="javascript">
           function drawGraph<xsl:value-of select="$groupId"/>()
           {
           
           d3.select("#context-<xsl:value-of select="$groupId"/>").remove();
           
           
           graph = new myGraph("#modalGraph<xsl:value-of select="$groupId"/>", "context-<xsl:value-of select="$groupId"/>"); 
           <xsl:for-each select="graph/node">graph.addNode('<xsl:value-of select="@id"/>');
           </xsl:for-each>
           <xsl:for-each select="graph/node/link"> graph.addLink('<xsl:value-of select="parent::node/@id"/>','<xsl:value-of select="text()"/>','<xsl:value-of select="@rel"/>');
           </xsl:for-each>
           }   
       </script>
       
       
       <div class="content {$active2}" id="{$groupId}">
           
           <div id="modalGraph{$groupId}" class="reveal-modal svgmodal" data-reveal="">
               <h2>Graph</h2>
               
               <a class="close-reveal-modal">&#215;</a>
           </div>
           <div id="modalAssertions{$groupId}" class="reveal-modal svgmodal" data-reveal="">
               <h2>Assertions</h2>
               <ul>
                   <xsl:apply-templates mode="node" select="graph/node"/>
                  
                   
               </ul>
               <a class="close-reveal-modal">&#215;</a>
           </div>
           
           <fieldset class="repeatSection{$groupId}">
               
               <p class="addRemove"><a href="#" class="button [radius round tiny ]" onClick="javascript:drawGraph{$groupId}()"  data-reveal-id="modalGraph{$groupId}">Show graph</a><a href="#" class="button [radius round tiny ]" data-reveal-id="modalAssertions{$groupId}">Show assertions</a><a href="#" class="add" onClick="addSection('.repeatSection{$groupId}')"><span data-tooltip="" class="has-tip" title="Add Section"><i class="fi-plus"></i></span></a>   <a href="#" class="delete" onClick="deleteSection(this, '.repeatSection{$groupId}')"><span data-tooltip="" class="has-tip" title="Delete this section"><i class="fi-minus"></i></span></a></p>
               
               
               <legend><xsl:value-of select="$groupTitle"/></legend>
               
               <p><xsl:value-of select="description"/></p>
               <div class="row">
                   <xsl:apply-templates mode="field" select="field">
                       <xsl:with-param name="groupId" select="$groupId"/>
                       
                   </xsl:apply-templates>
               </div>
           </fieldset>
           
           
       </div>
       
       
       
       
   </xsl:template>
   
   
   <xsl:template mode="node" match="node">
      
      <xsl:apply-templates mode="link" select="link">
          <xsl:with-param name="subject" select="@id"/>
          <xsl:with-param name="graphid" select="ancestor::group/@id"/>    
      </xsl:apply-templates>
       
   </xsl:template>
   
   
   
   <xsl:template mode="link" match="link">
       <xsl:param name="subject"/>
       <xsl:param name="graphid"/>
          
       <xsl:variable name="predicate" select="@rel"/>
       <xsl:variable name="object" select="text()"/>                              
       <li> <xsl:value-of select="$subject"/> <xsl:text>  </xsl:text><span class="assertion a-{$graphid}-{$subject}"/> <xsl:text>  </xsl:text> <xsl:value-of select="$predicate"/><xsl:text>  </xsl:text>  <span class="assertion a-{$graphid}-{$object}"></span></li>
       
   </xsl:template>
   
   
   <xsl:template mode="field" match="field">
       <xsl:param name="groupId"/>
       <xsl:variable name="size" select="if (number(./@size) > 0) then @size else '4'"/>
       
       <xsl:if test="./@position = 'start'">
           <div class="row"/>
       </xsl:if>
       
       <div class="small-{$size} columns div{$groupId}-{@id}"> 
           <xsl:apply-templates mode="input" select=".">
               <xsl:with-param name="groupId" select="$groupId"/>
           </xsl:apply-templates>   
       </div>
       
       <xsl:if test="@position = 'end'">
           <div class="row"/>
       </xsl:if>
           
   </xsl:template>
   
   
   
    <xsl:template mode="graphFunction" match="*">
        <xsl:for-each select="document('result.xml')/form/section/group">
        <!--    drawGraph<xsl:value-of select="@id"/>();   --> 
        </xsl:for-each>
    </xsl:template>
   
   
   <xsl:template mode="input" match="*">
       <xsl:param name="groupId"/>
       
       
       <xsl:variable name="fieldId" select="@id"/>
       <xsl:variable name="fieldTitle" select="@title"/>
       <xsl:variable name="fieldPlaceholder" select="@placeHolder"/>
       <xsl:variable name="help" select="@help"/>
       
       
       
       
       
      
       <xsl:choose>
       <xsl:when test="@type ='text'">
           
               <xsl:apply-templates mode='label' select=".">
                   <xsl:with-param name="groupId" select="$groupId"/>
               </xsl:apply-templates>
           
           <input type="text"   onChange="updateAssertion(this.value, '.a-{$groupId}-{$fieldId}')" id="{$groupId}-{$fieldId}" placeholder="{$fieldPlaceholder}"/>
           
       </xsl:when>
           <xsl:when test="@type='select'">
               <xsl:apply-templates mode='label' select=".">
                   <xsl:with-param name="groupId" select="$groupId"/>
               </xsl:apply-templates>
               <select id="{$groupId}-{$fieldId}">
                   <option value="">Please select..</option>
                   <xsl:copy-of select="option"/>
                 
               </select>
           </xsl:when>
           <xsl:when test="@type='checkbox'">
               <!--  <input id="checkbox1" type="checkbox"><label for="checkbox1">Checkbox 1</label> -->
               
               
               
               <!-- if checkbox id = date_is_range then add javascript function to insert/delete additional date fields -->
               
               <xsl:choose>
                   
                   <xsl:when test="@id='date_is_range'">
                       <input class="{$fieldId}" id="{$groupId}-{$fieldId}" type="checkbox" onChange="dateRange(this, '{$groupId}-{$fieldId}', '{$groupId}')"/> 
                   </xsl:when>
                   <xsl:otherwise>
                       <input class="{$fieldId}" id="{$groupId}-{$fieldId}" type="checkbox"/>
                       
                       
                   </xsl:otherwise>
               </xsl:choose>
              
               
               
              
               
               <xsl:apply-templates mode='label' select=".">
                   <xsl:with-param name="groupId" select="$groupId"/>
               </xsl:apply-templates>
               
               
           </xsl:when>
           
           <xsl:when test="@type='textarea'">
               <!-- <label>Textarea Label
        <textarea></textarea>
      </label>  -->
              
               <xsl:apply-templates mode='label' select=".">
                   <xsl:with-param name="groupId" select="$groupId"/>
               </xsl:apply-templates>
               <textarea id="{$groupId}-{$fieldId}"></textarea>

               
           </xsl:when>
           <xsl:otherwise>
               <xsl:apply-templates mode='label' select=".">
                   <xsl:with-param name="groupId" select="$groupId"/>
               </xsl:apply-templates>
               
               <input type="text" onChange="updateAssertion(this.value, '.a-{$groupId}-{$fieldId}',  'context-{$groupId}', '{$fieldId}')"  id="{$groupId}-{$fieldId}" placeholder="{$fieldPlaceholder}"/>
           </xsl:otherwise>
       </xsl:choose>
       
       
       
   </xsl:template>
   
   
   <xsl:template mode="label" match="*">
       
       <xsl:param name="groupId"/>
       <xsl:variable name="fieldId" select="@id"/>
       <xsl:variable name="fieldTitle" select="@title"/>
       <xsl:variable name="help" select="@help"/>
       
       
       <label for="{$groupId}-{$fieldId}">
       <xsl:value-of select="$fieldTitle"/>   
       <xsl:if test="$help != ''">
           <span data-tooltip="" class="has-tip" title="{$help}"><i class="fi-magnifying-glass"></i></span>
       </xsl:if>
           <xsl:if test="@repeat = 'yes'">
       <a href="#"  onClick="addField(this, '.div{$groupId}-{$fieldId}')"><i class="fi-plus"></i></a><a href="#"  onClick="deleteField(this, '.div{$groupId}-{$fieldId}')"><i class="fi-minus"></i></a>
           </xsl:if>
       </label>
       
   </xsl:template>
   
   
</xsl:stylesheet>






