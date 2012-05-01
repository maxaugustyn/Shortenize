
$(function() {
    $("#submission").click(function(event){
        event.preventDefault(); // self-explanatory
        var address = $("input#address").val();
        var suggestion = $("input#suggestion").val();
        var postData = 'address='+address+'&suggestion='+suggestion;
        $.ajax({
          url: '/',
          type: 'POST',
          dataType: 'html',
          data: postData,
          success: function(data){
          	$(data).appendTo("#pane").hide().fadeIn(300);
            console.log("Ajax successful!")
          }
        });    
    });
});

$(function(){
  $("a.close").on("click", function(event){
    event.preventDefault();
    $(event.target).parent().fadeOut(500,function(){
      $(this).parent();
    });
  })
})