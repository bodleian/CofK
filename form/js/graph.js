 var graph;
                    
 
                    function myGraph(el) {
                    
          // set up the D3 visualisation in the specified element
                    var w = "1000",
                    h = "1000";
                    var vis = d3.select("#mySVG")
                    
                    .append("svg")
                        .attr("width", w)
                         .attr("height", h)
                        .attr("class", "graph-svg-component")
                        .attr("id","svg")
                        .attr("fill", "blue")
                        .attr("pointer-events", "all")
                        .attr("viewBox","0 0 "+w+" "+h)
                        .attr("perserveAspectRatio","xMinYMid")
                    
                  
                   
                  
                  
                    .append('g');
                    
                    
                    this.createGraph = function(){
                    	
                    	
                  
                    }
                    
                    
                    
                    // Add and remove elements on the graph object
                    this.addNode = function (id) {
                    nodes.push({"id":id});
                    update();
                    };
                    
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
                    
                    this.removeallLinks = function(){
                    links.splice(0,links.length);
                    update();
                    };
                    
                    this.removeAllNodes = function(){
                    nodes.splice(0,links.length);
                    update();
                    };
                    
                    this.addLink = function (source, target, value) {
                    links.push({"source":findNode(source),"target":findNode(target),"value":value});
                    update();
                    };
                    
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
                    
                 
                    
                    var force = d3.layout.force();
                    
                    var nodes = force.nodes(),
                    links = force.links();
                    
                    var update = function () {
                    var link = vis.selectAll("line")
                    .data(links, function(d) {
                    return d.source.id + "-" + d.target.id; 
                    });
                    
                    link.enter().append("line")
                    .attr("id",function(d){return d.source.id + "-" + d.target.id;})
                    .attr("class","link");
                    link.append("title")
                    .text(function(d){
                    return d.value;
                    });
                    link.exit().remove();
                    
                    var node = vis.selectAll("g.node")
                    .data(nodes, function(d) { 
                    return d.id;});
                    
                    var nodeEnter = node.enter().append("g")
                    .attr("class", "node")
                    .call(force.drag);
                    
                    nodeEnter.append("circle")
                    .attr("r", 10)
                    .attr("id",function(d) { return "Node;"+d.id;})
                    .attr("class","nodeStrokeClass");
                    
                    nodeEnter.append("text")
                    .attr("class","textClass")
                    .attr("x", 20)           // set x position of left side of text
                     .style("fill", "black")
                    .text( function(d){return d.id;}) ;
                    
                    node.exit().remove();
                    force.on("tick", function() {
                    
    
                    
                    
                    link.attr("x1", function(d) { return d.source.x; })
                    .attr("y1", function(d) { return d.source.y; })
                    .attr("x2", function(d) { return d.target.x; })
                    .attr("y2", function(d) { return d.target.y; });
                    
                    
                    
                    node.attr("transform", function(d) { return "translate(" + d.x + "," + d.y         + ")"; });
                    
                    });
                    
                    // Restart the force layout.
                    force
                    
                    .distance(30)
                    .linkDistance( 200 )
                    .size([w, h])
                    .charge(-2000)
                    //.on("tick", tick)
                    
                    .start();
                    };
                    
                    
                    // Make it all go
                    update();
                    }
                    
                    
                  
                    
                    
                    