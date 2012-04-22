$(function() {
    $("#submit").submit(data, function(event) {
        event.preventDefault();
        var postData = data.serialize();
        $.ajax({
            url: '/',
            type: 'POST',
            dataType: 'html',
            data: postData,
            success: function() {
                alert('Ajaxed query:' + postData);
            },
            error: function() {
                alert('screwed up!');
            }
        });
    })
});