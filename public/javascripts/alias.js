$(function() {
    $("#submit").submit(function(event) {
        event.preventDefault();
        var postData = this.serialize();
        $.ajax({
            url: '/',
            type: 'POST',
            dataType: 'html',
            data: postData,
            success: function() {
                alert('Ajaxed query:' + postData);
            },
            failure: function() {
                alert('screwed up!');
            }
        });
    })
});