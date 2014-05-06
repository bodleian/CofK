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
               
                <!-- If you are using CSS version, only link these 2 files, you may add app.css to use for your overrides if you like. -->
               
               <!--
                <link rel="stylesheet" href="Foundation5/css/foundation.css"/>
                <script src="Foundation5/js/vendor/fastclick.js"></script>
                -->
                
                <link rel="stylesheet" href="../f5/css/foundation.css" />
                <script src="../f5/js/vendor/modernizr.js"></script>
               
                <script src="./js/form.js"></script>
               
                <script src="http://d3js.org/d3.v3.min.js"></script>
                
                <link rel="stylesheet" href="css/style.css"/>
            </head>
            <body>
                
                <form method="get">
                    
                    
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
                    <div class="tabs-content">
                        <div class="content active" id="panel1a">
                <div class="row">
                    <dl class="tabs" data-tab="">
                        
                      
                        
                        <xsl:for-each select="document('result.xml')/form/section">
                                <xsl:variable name="active" select="if (count(preceding-sibling::section) = 0) then 'active' else ''"/>
                            <dd>
                                <a href="#{@id}" class="{$active}"><xsl:value-of select="@title"/></a>
                            </dd>
                            </xsl:for-each>      
                        <dd>
                            <a href="#provenance" class="">Provenance</a>
                        </dd>
                        </dl>
                   
                    <div class="tabs-content">
                        
                       
                        <div class="content " id="provenance">
                            <fieldset>
                                <legend>Provenance of this report</legend>
                            </fieldset>
                            </div>
                       
                       
                        
                        <xsl:for-each select="document('result.xml')/form/section">
                <xsl:variable name="sectionTitle" select="@title"/>
                <xsl:variable name="active" select="if (count(preceding-sibling::section) = 0) then 'active' else ''"/>
                
                <div class="content {$active}" id="{@id}">  
                   
                    <dl class="sub-nav">
                        <dt>Context:</dt>
                    <xsl:for-each select="group">       
                        <xsl:variable name="groupId" select="@id"/>
                        <xsl:variable name="groupTitle" select="@title"/>
                        <dd class="active"><a  href="javascript:showContext('#{$groupId}')"><xsl:value-of select="$groupTitle"/></a></dd>
                    </xsl:for-each>
 
                    </dl>
                    
                    
            <xsl:for-each select="group">
                        
                          <xsl:variable name="groupId" select="@id"/>
                        <xsl:variable name="groupTitle" select="@title"/>
                        
                        <fieldset id="{$groupId}">
                            <legend><xsl:value-of select="$groupTitle"/></legend>
                            
                          
                            
                            <script language="javascript">
                                
                               
                                
                                function drawGraph<xsl:value-of select="$groupId"/>()
                                {
                                
                                <!--
                                d3.select("#svg").remove()
                                
                                graph = new myGraph("#myModal"); -->
                                graph = new myGraph("#svg<xsl:value-of select="$groupId"/>", "context-<xsl:value-of select="$groupId"/>"); 
                                <!--
                                graph.addNode('<xsl:value-of select="$groupId"/>');
                                
                                <xsl:for-each select="field">graph.addNode('<xsl:value-of select="@id"/>');
                                    graph.addLink('<xsl:value-of select="$groupId"/>','<xsl:value-of select="@id"/>','20');
                                </xsl:for-each>
                                -->
                                
                                <xsl:for-each select="graph/node">graph.addNode('<xsl:value-of select="@id"/>');
                                </xsl:for-each>
                                
                                <xsl:for-each select="graph/node/link"> graph.addLink('<xsl:value-of select="parent::node/@id"/>','<xsl:value-of select="text()"/>','<xsl:value-of select="@rel"/>');
                                </xsl:for-each>
                                    
                                }
                                
                                
                                
                            </script>
                            
                            <p><xsl:value-of select="description"/></p>
                            
                            <!--
                            <p><a href="#" data-reveal-id="myModal" data-reveal="" onClick="javascript:drawGraph{$groupId}()">Display context as a graph</a></p>
                       -->
                                <xsl:for-each select="field">
                                    <xsl:variable name="fieldId" select="@id"/>
                                    <xsl:variable name="fieldTitle" select="@title"/>
                                    <xsl:variable name="fieldPlaceholder" select="@placeHolder"/>
                                    <div class="form-group">
                                        <label for="{$groupId}-{$fieldId}"><xsl:value-of select="$fieldTitle"/></label>
                          
                          
                                           <xsl:apply-templates mode="input" select=".">
                                               <xsl:with-param name="groupId" select="$groupId"/>
                                               
                                           </xsl:apply-templates>
                          
                                      
                                        
                                    </div>
                                </xsl:for-each>
                         <h4>Graph</h4>       
                            <svg id="svg{$groupId}"></svg>
                        <h4>Assertions</h4>
                            <ul>
                            <xsl:for-each select="graph/node">
                                
                                <xsl:variable name="graphid" select="ancestor::group/@id"/>
                                
                                <xsl:variable name="subject" select="@id"/>
                                
                                
                                <xsl:for-each select="link">
                                <xsl:variable name="predicate" select="@rel"/>
                                <xsl:variable name="object" select="text()"/>
                              
                                    <li> <xsl:value-of select="$subject"/> <xsl:text>  </xsl:text><span class="assertion a-{$graphid}-{$subject}"/> <xsl:text>  </xsl:text> <xsl:value-of select="$predicate"/><xsl:text>  </xsl:text>  <span class="assertion a-{$graphid}-{$object}"></span></li>
                                    
                                    
                                    
                                    
                                    
                                    
                                
                                    
                                </xsl:for-each>
                            </xsl:for-each>
                            
                            </ul>
                            
                            
                        </fieldset>
                    </xsl:for-each>
                    
                   
                 
                            <!--  end of for each group -->
                
                
                <!--  -->
                
                </div>
              
        
            
                        
           
        </xsl:for-each>
                    </div>
      
                </div>
           
                
                        </div>
                
               
                        <div class="content" id="panel2a">
                            <div class="row">
                                <h3>Load Data</h3>
                            </div>
                        </div>
                        <div class="content" id="panel3a">
                            <div class="row">
                                <h3>Save Report</h3>
                            
                            <p>Save your report</p>
                            <input type="submit" value="Save Report"/>
                            
                            </div>
                        </div>
                        <div class="content" id="panel4a">
                            <div class="row">
                                <h3>Validate Form</h3>
                            </div>
                        </div>
                        <div class="content" id="panel5a">
                            <div class="row">
                                <h3>Help</h3>
                            </div>
                        </div>                 </div>
             
                            <!-- close the off-canvas menu -->
                            <a class="exit-off-canvas"></a>
                            
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
   
   
    <xsl:template mode="graphFunction" match="*">
        <xsl:for-each select="document('result.xml')/form/section/group">
            drawGraph<xsl:value-of select="@id"/>();    
        </xsl:for-each>
    </xsl:template>
   
   
   <xsl:template mode="input" match="*">
       <xsl:param name="groupId"/>
       
       <xsl:variable name="fieldId" select="@id"/>
       <xsl:variable name="fieldPlaceholder" select="@placeHolder"/>
       <xsl:choose>
       <xsl:when test="@type ='text'">
           <input type="text"   onChange="updateAssertion(this.value, '.a-{$groupId}-{$fieldId}')" id="{$groupId}-{$fieldId}" placeholder="{$fieldPlaceholder}"/>
           
       </xsl:when>
           <xsl:when test="@type='select'">
               <select>
                   <option value="">Please select..</option>
                   <xsl:copy-of select="option"/>
                 
               </select>
           </xsl:when>
           <xsl:otherwise>
               <input type="text" onChange="updateAssertion(this.value, '.a-{$groupId}-{$fieldId}',  'context-{$groupId}', '{$fieldId}')"  id="{$groupId}-{$fieldId}" placeholder="{$fieldPlaceholder}"/>
           </xsl:otherwise>
       </xsl:choose>
       
       
       
   </xsl:template>
   
</xsl:stylesheet>



<!-- 

<textarea id ="txtbirth"></textarea>
 <input type="button" onClick='document.getElementById("txtbirth").value = document.getElementById("svgbirth").innerHTML' value="Show"/>
                                 

-->