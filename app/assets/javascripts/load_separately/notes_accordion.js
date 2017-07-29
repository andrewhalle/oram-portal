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
           },
           success: function() {
               alert("Saved note!");
           }
        });
    });
    
    $(".notes div a").click(function(event) {
        event.preventDefault();
        note_id = this.id.split("_")[2]
        url = "/notes/" + note_id
        $.ajax({
            url: url,
            method: "delete",
            success: function() {
                $("#note_title_" + note_id).remove();
                $("#note_collapse_" + note_id).remove();
                $(".notes").accordion("refresh");
                $('.notes').accordion({
                    active: false,
                    collapsible: true            
                });
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
                var new_note = "<h4 id=\"note_title_" + result.id + "\">" + title + "</h4><div id=\"note_collapse_" + result.id + "\"><br><a href=\"\" id=\"delete_note_" + result.id + "\">Delete note</a><br><textarea class=\"note-field\" id=\"note_text_" + result.id + "\"></textarea><br><button id=\"note_update_" + result.id + "\">Save</button></div>";
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
                       },
                       success: function() {
                           alert("Saved note!");
                       }
                    });
                });
                $(".notes div a").click(function(event) {
                    event.preventDefault();
                    note_id = this.id.split("_")[2]
                    url = "/notes/" + note_id
                    $.ajax({
                        url: url,
                        method: "delete",
                        success: function() {
                            $("#note_title_" + note_id).remove();
                            $("#note_collapse_" + note_id).remove();
                            $(".notes").accordion("refresh");
                            $('.notes').accordion({
                                active: false,
                                collapsible: true            
                            });
                        }
                    });
                });
                $( ".notes" ).accordion("refresh");
            }
        });
    });
}