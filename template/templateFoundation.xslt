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
                
                <link rel="stylesheet" href="/f5/css/foundation.css" />
                <script src="/f5/js/vendor/modernizr.js"></script>
               
               
               
                <script src="http://d3js.org/d3.v3.min.js"></script>
                
                <link rel="stylesheet" href="css/style.css"/>
            </head>
            <body>
                
                <form method="get">
                    
                    <dl class="tabs vertical" data-tab="">
                        <dd class="active">
                            <a href="#panel1a">Input Form</a>
                        </dd>
                        <dd>
                            <a href="#panel2a">Load Data</a>
                        </dd>
                        <dd>
                            <a href="#panel3a">Save Report</a>
                        </dd>
                        <dd>
                            <a href="#panel4a">Validate Form</a>
                        </dd>
                        <dd>
                            <a href="#panel5a">Help</a>
                        </dd>
                    </dl>
                    <div class="tabs-content vertical">
                        <div class="content active" id="panel1a">
                          
                    
                    
                <div class="row">
                    
                   <h2>Input Form</h2>
                    
                    
                 
                    
                    
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
                        <dd class="active"><a href="#{$groupId}"><xsl:value-of select="$groupTitle"/></a></dd>
                    </xsl:for-each>
 
                    </dl>
                    
                    
            <xsl:for-each select="group">
                        
                          <xsl:variable name="groupId" select="@id"/>
                        <xsl:variable name="groupTitle" select="@title"/>
                        
                        <fieldset>
                            <legend id="{$groupId}"><xsl:value-of select="$groupTitle"/></legend>
                            
                          
                            
                            <script language="javascript">
                                function drawGraph<xsl:value-of select="$groupId"/>()
                                {
                                
                                d3.select("#svg").remove()
                                
                                graph = new myGraph("#myModal");
                                
                                <!--
                                graph.addNode('<xsl:value-of select="$groupId"/>');
                                
                                <xsl:for-each select="field">graph.addNode('<xsl:value-of select="@id"/>');
                                    graph.addLink('<xsl:value-of select="$groupId"/>','<xsl:value-of select="@id"/>','20');
                                </xsl:for-each>
                                -->
                                
                                <xsl:for-each select="graph/node">graph.addNode('<xsl:value-of select="@id"/>');
                                </xsl:for-each>
                                
<xsl:for-each select="graph/node/link"> graph.addLink('<xsl:value-of select="parent::node/@id"/>','<xsl:value-of select="text()"/>','20');
                                </xsl:for-each>
                                    
                                }
                                
                                
                                
                            </script>
                            
                            <p><xsl:value-of select="description"/></p>
                            
                            
                            <p><a href="#" data-reveal-id="myModal" data-reveal="" onClick="javascript:drawGraph{$groupId}()">Display context as a graph</a></p>
                       
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
                                <h2>Load Data</h2>
                            </div>
                        </div>
                        <div class="content" id="panel3a">
                            <div class="row">
                                <h2>Save Report</h2>
                            
                            <p>Save your report</p>
                            <input type="submit" value="Save Report"/>
                            
                            </div>
                        </div>
                        <div class="content" id="panel4a">
                            <div class="row">
                                <h2>Validate Form</h2>
                            </div>
                        </div>
                        <div class="content" id="panel5a">
                            <div class="row">
                                <h2>Help</h2>
                            </div>
                        </div>                 </div>
                </form>
                
                
                
                <div id="myModal" class="reveal-modal" data-reveal="">
                    <p>A graphical representation of the relationships defined for this context.</p>
                    <a class="close-reveal-modal">&#215;</a>
                    
                    <svg id="mySVG"/>
                </div>
                
                
                
                
                
                
                <script src="http://code.jquery.com/jquery.js"></script>
                <script src="/f5/js/foundation.min.js"></script>
                <script>
                    $(document).foundation();
                </script>
                
                <script src="js/graph.js"/>
                    
                   
                 
                    
                    
                
             
            </body>
        </html>
        
    
    </xsl:template>
   
   
   <xsl:template mode="input" match="*">
       <xsl:param name="groupId"/>
       
       <xsl:variable name="fieldId" select="@id"/>
       <xsl:variable name="fieldPlaceholder" select="@placeHolder"/>
       <xsl:choose>
       <xsl:when test="@type ='text'">
           <input type="text"  id="{$groupId}-{$fieldId}" placeholder="{$fieldPlaceholder}"/>
           
       </xsl:when>
           <xsl:when test="@type='select'">
               <select>
                   <option value="">Please select..</option>
                   <xsl:copy-of select="option"/>
                 
               </select>
           </xsl:when>
           <xsl:otherwise>
               <input type="text"  id="{$groupId}-{$fieldId}" placeholder="{$fieldPlaceholder}"/>
           </xsl:otherwise>
       </xsl:choose>
       
       
       
   </xsl:template>
   
</xsl:stylesheet>