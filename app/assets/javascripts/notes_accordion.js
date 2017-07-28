$(document).ready(setup);

function setup() {
    $( ".notes" ).accordion({
        header: "> h4",
        collapsible: true,
        active: false,
        heightstyle: "content",
        autoActivate: true
    });
}