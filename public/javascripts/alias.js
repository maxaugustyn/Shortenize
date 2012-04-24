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
          	$("#pane").html('<div class="alert-box warning">' + data +'</div>').hide().fadeIn(900);
          }
        });    
    });
});