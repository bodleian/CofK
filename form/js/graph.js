 var graph;
                    
 
                    function myGraph(el, context) {
                    
                    // set up the D3 visualisation in the specified element
                    var w = "800",
                    h = "800";
                    
                    
                    var vis = d3.select(el)
                    
                    
                    // append svg elemnt with attributes eg weight and height
                    .append("svg")
                        .attr("width", w)
                         .attr("height", h)                        
                        .attr("class", "graph-svg-component")
                        .attr("id",context)
                        .attr("fill-opacity", "0.0")
                        
                        .attr("pointer-events", "all")
                        .attr("viewBox","0 0 "+w+" "+h)
                        .attr("perserveAspectRatio","xMinYMid")
                    
                    // append g element to svg
                    .append('g')
                    .attr("fill", "black");
                    
                    // function not used
                    this.createGraph = function(){ }
                    

                    // Add node to the graph object
                    this.addNode = function (id) {
                    nodes.push({"id":id});
                    update();
                    };
                    
                    
                    // remove node from the graph object
                    this.removeNode = function (id) {
                    var i = 0;
                    var n = findNode(id);
                    while (i <links.length) {
                    if ((links[i]['source'] == n)||(links[i]['target'] == n))
                    {
                    links.splice(i,1);
                    }
                    else i++;
                    }
                    nodes.splice(findNodeIndex(id),1);
                    update();
                    };
                    
                    
                    // remove link from the graph object    
                    this.removeLink = function (source,target){
                    for(var i=0;i<links.length;i++)
                    {
                    if(links[i].source.id == source && links[i].target.id == target)
                    {
                    links.splice(i,1);
                    break;
                    }
                    }
                    update();
                    };
                    
                    
                    // remove all links from the graph object
                    this.removeallLinks = function(){
                    links.splice(0,links.length);
                    update();
                    };
                    
                    // remove all nodes from the graph object
                    this.removeAllNodes = function(){
                    nodes.splice(0,links.length);
                    update();
                    };
                    
                    // add link to the graph object
                    this.addLink = function (source, target, value) {
                    
                    links.push({"source":findNode(source),"target":findNode(target), "linktext": value});
                    
                    update();
                    };
                    
                    
                    // find node in the graph object
                    var findNode = function(id) {
                    for (var i in nodes) {
                    if (nodes[i]["id"] === id) return nodes[i];};
                    };
                    
                    var findNodeIndex = function(id) {
                    for (var i=0;i<nodes.length;i++) {
                    if (nodes[i].id==id){
                    return i;
                    }
                    };
                    };
                    
                 
                    // 
                    var force = d3.layout.force(); // instantiate forced graph layout
                    var nodes = force.nodes(); // instantiate nodes in graph
                    var links = force.links(); // instantiate links in graph
                    
                    
                    var drag = force.drag()
                    .on("dragstart", dragstart);
                    
                    // update the graph
                    var update = function () {
                        // select all lines
                    var link = vis.selectAll("path")
                        // associate links data with line elements, where the data is a concatenated value - $sourceid-$targetid
                    .data(links, function(d) {
                    return d.source.id + "-" + d.target.id; 
                    });
                    
                    // add path to the path elements for any data elements that do not have a line associated with it
                    link.enter().append("path")
                    .attr("link",function(d){return d.source.id + "-" + d.target.id;})
                    .attr("class","link")
                    .attr("dx", 1)
                    .attr("dy", ".35em")
                    .attr("id",function(d){return "id" + d.source.id + d.target.id;})
                    
                    // delete any lines that do not have data associated with them
                  
                    

                      /* 
                    select("svg")   - finds svg element in DOM and hands a reference off to next step in the chain

                    .data(links)    - counts and parses data values. everything past this point is repeated according to number of items in links
                     
                    .enter()        - use to create new data bound elements
                                      if there are more data values than corresponding elements
                                
                     
                    */
                   
                   
                     link.enter().append("text")
                    .attr("dy", "-5")
                    .attr("dx", "60")
                   
                    .append("textPath")
                    .attr("xlink:href", function(d){ return "#id"+ d.source.id + d.target.id })
                    .attr("class", "linklabelholder")
                    .attr("startoffset", "50%")
                    .text(function(d){return d.linktext;})
                   
                  
                        link.exit().remove();
                    // select all nodes
                    var node = vis.selectAll("g.node")
                    .data(nodes, function(d) { 
                    return d.id;});
                    
                    // create nodes as required to associate node with data
                    var nodeEnter = node.enter().append("g")
                    .attr("class", "node")
                    //.call(force.drag);
                    .on("dblclick", dblclick)
                    .call(drag);
                    
                    // append a circle element to the node
                    nodeEnter.append("circle")
                    .attr("r", 10)
                    .attr("id",function(d) { return "Node;"+d.id;})
                    .attr("class","nodeStrokeClass")
                    .attr("fill-opacity", "0")
                    
                    
                    // append a text element to the node
                    nodeEnter.append("text")
                    .attr("class","textClass")
                    
                    .attr("x", 20)           // set x position of left side of text
                     .style("fill", "black")
                     
                      .attr("fill-opacity", "1.0")
                      
                    .text( function(d){return d.id;}) ;
                    
                     nodeEnter.append("text")
                    .attr("class","textClass")
                     .attr("id", function(d){ return "txt"+ d.id })
                    .attr("x", 50)           // set x position of left side of text
                    .attr("y", 20) 
                    
                    .style("fill", "red")
                    .style("font-weight", "bold")
                    .attr("fill-opacity", "1.0");
                    
                    
                    // remove any nodes that are not needed
                    node.exit().remove();
                    

                    // run tick function 
                    force.on("tick", function() {
                    

                   link.attr("d", function(d) {
                        var dx = d.target.x - d.source.x,
                        dy = d.target.y - d.source.y,
                        dr = Math.sqrt(dx * dx + dy * dy);
                        return "M" + d.source.x + "," + d.source.y + "A" + dr + "," 
                        + dr + " 0 0,1 " + d.target.x + "," + d.target.y;
                    });    
                    
                    
                   var linkpath = vis.selectAll("textPath").data(links);
                    
                   linkpath.attr("transform", function(d) {
                   return "translate(" + (d.source.x + d.target.x) / 2 + "," + ( d.source.y + d.target.y) / 2 + ")"; });
                    
                    // add transform attribute to node
                    node.attr("transform", function(d) { return "translate(" + d.x + "," + d.y  + ")"; });
                    
                    });
                    
                    // Restart the force layout.
                    force
                    
                    .distance(60)
                    .linkDistance( 200 )
                    .size([w, h])
                    .charge(-4000)
                   
                   // .on("tick", tick)  
                    .start();
                    };
                    
                    
                    // Make it all go
                    update();
                     
                    }
                    
                    
 
 // function to free position of svg node when selected
                   function dblclick(d) {
                        d3.select(this).classed("fixed", d.fixed = false);
}


// function to fix position of svg node when selected
function dragstart(d) {
  d3.select(this).classed("fixed", d.fixed = true);
}
                  
                  
       
                   
         
                  
              