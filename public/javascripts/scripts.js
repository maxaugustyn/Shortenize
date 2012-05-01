$(function() {
    $(document).on("click", "a.close", function(event) {
        event.preventDefault();
        console.log("Suck My Dick");
        $(event.target).closest(".alert-box").fadeOut(function() {
            $(this).remove();
        });
    });

    $("#submission").click(function(event) {
        event.preventDefault(); // self-explanatory
        var address = $("input#address").val();
        var suggestion = $("input#suggestion").val();
        var postData = 'address=' + address + '&suggestion=' + suggestion;
        $.ajax({
            url: '/',
            type: 'POST',
            dataType: 'html',
            data: postData,
            success: function(data) {
                $(data).appendTo("#pane").hide().fadeIn(300);
                console.log("Ajax successful!");
            }
        });
    });
});