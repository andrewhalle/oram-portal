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
    }
    );
}