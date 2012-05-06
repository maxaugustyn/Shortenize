$(function() {
    $(document).on("click", "a.close", function(event) {
        event.preventDefault();
        $(event.target).closest(".alert-box").slideUp(300, function() {
            $(this).remove();
        });
    });

    $("#submission").click(function(event) {
        event.preventDefault(); 
        var address = $("input#address").val();
        var suggestion = $("input#suggestion").val();
        var postData = 'address=' + address + '&suggestion=' + suggestion;
        $.ajax({
            url: '/',
            type: 'POST',
            dataType: 'html',
            data: postData,
            success: function(data) {
                $("#not_found").slideUp();
                $(data).appendTo("#pane").hide().fadeIn(300);
            }
        });
    });
});