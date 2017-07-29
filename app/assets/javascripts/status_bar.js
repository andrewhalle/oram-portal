function animateStatus(phase) {
	var newWidth = Math.round((phase / 6) * 97.5).toString() + "%";
	$("#status_bar").animate({
		width: newWidth,
		easing: "swing"
	}, 500, function() {});
	$("#status_text").html("You are currently in phase " + phase.toString());
}