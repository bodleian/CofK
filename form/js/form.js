

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