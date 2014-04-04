<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
   <xsl:output method="xhtml"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Prosopography Input Form</title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                    <!-- Bootstrap -->
                    <link href="bootstrap-3.1.1-dist/css/bootstrap.min.css" rel="stylesheet" media="screen"/>
                <link rel="stylesheet" href="amelia/bootstrap.min.css"/>
                <script src="http://code.jquery.com/jquery.js"></script>
                <script src="bootstrap-3.1.1-dist/js/bootstrap.min.js"></script>
                
            </head>
            <body>
                <form role="form" class="form-horizontal">
                <div class="container">
             
                    
                    
                    <div class="tabbable">
                        <ul class="nav nav-tabs">
                            
                            <xsl:for-each select="document('form.xml')/template/section">
                                <xsl:variable name="active" select="if (count(preceding-sibling::section) = 0) then 'active' else ''"/>
                            <li>
                                <a href="#{@id}" data-toggle="tab" class="{$active}"><xsl:value-of select="@title"/></a>
                            </li>
                            </xsl:for-each>          
                        </ul>
                    </div>
                    <div class="tab-content">
            <xsl:for-each select="document('form.xml')/template/section">
            
            
                <xsl:variable name="sectionTitle" select="@title"/>
                <xsl:variable name="active" select="if (count(preceding-sibling::section) = 0) then 'active' else ''"/>
                
                    <div class="tab-pane {$active}" id="{@id}">  
                        <div class="well bs-component">
                       
                        <fieldset>
                        
                    <legend><xsl:value-of select="$sectionTitle"/></legend>
                    <xsl:for-each select="group">
                            <xsl:variable name="groupId" select="@id"/>
                        <xsl:variable name="groupTitle" select="document('group.xml')/template/group[@id = $groupId]/@title"/>
                        
                        <h4><xsl:value-of select="$groupTitle"/></h4>
                       <xsl:for-each select="document('group.xml')/template/group[@id = $groupId]/field">
                           <xsl:variable name="fieldId" select="@id"/>
                           <xsl:variable name="fieldTitle" select="@title"/>
                           <xsl:variable name="fieldPlaceholder" select="@placeHolder"/>
                           <div class="form-group">
                               <label for="{$fieldId}" class="col-sm-2 control-label"><xsl:value-of select="$fieldTitle"/></label>
                               <div class="col-sm-10">
                               <input type="text" class="form-control" id="{$fieldId}" placeholder="{$fieldPlaceholder}"/>
                               </div>
                               </div>
                       </xsl:for-each>                        
                        
                    </xsl:for-each>
                    
                        </fieldset></div>
                    </div>
              
        
            
                        
           
        </xsl:for-each>
                    </div>
      
                </div>
                </form>
            </body>
        </html>
        
        <!--  
    <form role="form">
  <div class="form-group">
    <label for="exampleInputEmail1">Email address</label>
    <input type="email" class="form-control" id="exampleInputEmail1" placeholder="Enter email">
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">Password</label>
    <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
  </div>
  <div class="form-group">
    <label for="exampleInputFile">File input</label>
    <input type="file" id="exampleInputFile">
    <p class="help-block">Example block-level help text here.</p>
  </div>
  <div class="checkbox">
    <label>
      <input type="checkbox"> Check me out
    </label>
  </div>
  <button type="submit" class="btn btn-default">Submit</button>
</form>
    
    -->
    </xsl:template>
   
   
</xsl:stylesheet>