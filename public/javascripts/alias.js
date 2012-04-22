$(function() {
	$("#submit").click(function(event){
		event.preventDefault(); // self-explanatory
		var address = $("input#address").val();
		var suggestion = $("input#suggestion").val();
		var postData = 'address='+address+'&suggestion='+suggestion; 
		$.ajax({
		  url: '/',
		  type: 'POST',
		  dataType: 'html',
		  data: postData,
		  success: function(){
		  	alert('Ajaxed!')
		  },
		  failure: function(){
		  	alert('screwed up!');
		  }
		});	
	})
});