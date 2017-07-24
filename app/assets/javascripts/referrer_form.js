//= require jquery

function hideLGBTIQOptional() {
	var checked = false;
	$('.LGBTIQ-option').each(function (_, el) {
		if ($(el).prop('checked')) {
			checked = true;
		}
	});
	if (checked) {
		$('.LGBTIQ-optional').slideDown();
	} else {
		$('.LGBTIQ-optional').slideUp();
	}
}

function hideORAMContactOptional() {
	var checked = $('.referrer-contact-other').first().prop('checked');
	if (checked) {
		$('.ORAM-referrer-contact-optional').slideDown();
	} else {
		$('.ORAM-referrer-contact-optional').slideUp();
	}
}

function hideLGBTIQAssociationOptional() {
	hideItem('.AccountsLGBTIQ-association', '.LGBTIQ-association-optional');
}

function hideVettingTrainingOptional() {
	hideItem('.vetting-training', '.vetting-training-optional');
}

$(document).on('click', '.LGBTIQ-option', hideLGBTIQOptional);

$(document).on('click', '.referrer-contact-other', hideORAMContactOptional);

$(document).on('change', '.LGBTIQ-association', hideLGBTIQAssociationOptional);

$(document).on('change', '.vetting-training', hideVettingTrainingOptional);

$(document).ready(function() {

	hideLGBTIQOptional();
	hideORAMContactOptional();
	hideLGBTIQAssociationOptional();
	hideVettingTrainingOptional();
});



