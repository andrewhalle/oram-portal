$(document).ready(setup);

function setup() {
    $( ".notes" ).accordion({
        header: "> h4",
        collapsible: true,
        active: false,
        heightstyle: "content",
        autoActivate: true
    });
    
    $(".notes div button").click(function() {
        var curr_id = this.id;
        var note_id = curr_id.split("_")[2];
        var url = "/notes/" + note_id;
        $.ajax({
           url: url,
           method: "put",
           data: {
               text: $("#note_text_" + note_id).val()
           }
        });
    });
    
    $("#add_note").click(function() {
        var title = $("#add_note_title").val();
        $("#add_note_title").val("");
        var user_id = window.location.pathname.split("/");
        user_id = user_id[user_id.length - 1];
        user_id = parseInt(user_id);
        $.ajax({
            url: "/notes",
            method: "post",
            data: {
                title: title,
                user_id: user_id
            },
            success: function(result) {
                var new_note = "<h4>" + title + "</h4><div><br><textarea class=\"note-field\" id=\"note_text_" + result.id +"\"></textarea><button id=\"note_update_" + result.id + "\">Save</button></div>";
                $(".notes").prepend(new_note);
                $("#note_update_" + result.id).click(function() {
                    var curr_id = this.id;
                    var note_id = curr_id.split("_")[2];
                    var url = "/notes/" + note_id;
                    $.ajax({
                       url: url,
                       method: "put",
                       data: {
                           text: $("#note_text_" + note_id).val()
                       }
                    });
                });
                $( ".notes" ).accordion("refresh");
            }
        });
    });
}