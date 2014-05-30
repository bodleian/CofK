

 $(".date_is_range").click(function(){
/*
 add click event to add another set of date fields if this date to be captures is a range
 */
       $( ".date_is_range" ).change();
    });

$( ".date_is_range" ).change(function() {
  alert( "Handler for .change() called." );
});


function showContext(context){
	
	
// hide all fieldset elements
	$("fieldset").css("display","none");
	
// display selected fieldset element using id	
	$(context).css("display","inline");
	
}




function updateAssertion(value, id, svgid, circleid){
	    
	/*
	 * parameters
	 * 
	 * @value = value of input field
	 * @id = class identifier for span element
	 * 
	 * 
	 * This function updates the value of span elements that are used to illustration assertions that can be made with
	 * values entered in the input form
	 * 
	 * called when an onChange event occurs in an input field for a given context
	 * 
	 */
	
	// for each element with the select class name
	jQuery(id).each(function () {
		
	// set inner text to value of input field
		this.innerText = value  ;
		
		
	})
	
	
	// want to also update the svg graph
	
	cid = "txt" + circleid;
	
	svg = document.getElementById(svgid);
	svg.getElementById(cid).textContent = value;
	
	
	
}


function addSection(sectionclass){
    
   var currentCount =  $(sectionclass).length;
    var newCount = currentCount+1;
    var lastRepeatingGroup = $(sectionclass).last();
    var newSection = lastRepeatingGroup.clone();
    newSection.insertAfter(lastRepeatingGroup);
    
    newSection.find("input").each(function (index, input) {
        input.id = input.id.replace("_" + currentCount, "_" + newCount);
        input.name = input.name.replace("_" + currentCount, "_" + newCount);
    });
    
    newSection.find("textarea").each(function (index, input) {
        input.id = input.id.replace("_" + currentCount, "_" + newCount);
        input.name = input.name.replace("_" + currentCount, "_" + newCount);
    });
    
    
    newSection.find("label").each(function (index, label) {
        var l = $(label);
        l.attr('for', l.attr('for').replace("_" + currentCount, "_" + newCount));
    });
    return false; 
    
}


function deleteSection(obj, sectionclass){
    
    var currentCount =  $(sectionclass).length;
    // do not delete section if there is only one section
    if (currentCount == 1){
   
        return false;
    }
    
     $(obj).parent('p').parent('fieldset').remove();
    return false;
}




function addField(obj, fieldclass){
    
	
	// identify index of groupclass
	
	var group = $(obj).parent().parent().parent().parent();
	var field = $(group).find(fieldclass)
	
	
   var currentCount =  $(field).length;
    var newCount = currentCount+1;
    var lastRepeatingGroup = $(field).last();
    var newField = lastRepeatingGroup.clone();
    newField.insertAfter(lastRepeatingGroup);
    
    newField.find("input").each(function (index, input) {
        input.id = input.id.replace("_" + currentCount, "_" + newCount);
        input.name = input.name.replace("_" + currentCount, "_" + newCount);
    });
    
    newField.find("textarea").each(function (index, input) {
        input.id = input.id.replace("_" + currentCount, "_" + newCount);
        input.name = input.name.replace("_" + currentCount, "_" + newCount);
    });
    
    
    newField.find("label").each(function (index, label) {
        var l = $(label);
        l.attr('for', l.attr('for').replace("_" + currentCount, "_" + newCount));
    });
    return false; 
    
}


function deleteField(obj, fieldclass){
    
    var currentCount =  $(fieldclass).length;
    // do not delete field if there is only one field
    if (currentCount == 1){
   
        return false;
    }
    
     $(obj).parent('label').parent('div').remove();
    return false;
}
















