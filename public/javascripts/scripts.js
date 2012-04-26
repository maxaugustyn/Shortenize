
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
          }
        });    
    });
});

$(function(){
  $("a.close:hover").click(function(){
    $(this).parent().fadeOut(700);
  })
})