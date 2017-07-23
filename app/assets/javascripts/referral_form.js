function displayCannotProvideAssistance() {
	var checked = $('.referred-outside-country').first().val() === "No";
	if (checked) {
		$('.cannot-provide-assistance').slideDown();
	} else {
		$('.cannot-provide-assistance').slideUp();
	}
}

function hideKimlikNumber() {
	var checked = $('.kimlik').first().val() === "Yes";
	if (checked) {
		$('.kimlik-number').slideDown();
	} else {
		$('.kimlik-number').slideUp();
	}
}

function hideUNHCRNumber() {
	var checked = $('.refugee-status').first().val() === "Yes";
	if (checked) {
		$('.unhcr-case-number').slideDown();
	} else {
		$('.unhcr-case-number').slideUp();
	}
}

function hideOpenAboutSexualOrientationOrGender() {
	var checked = $('.open-about').first().val() === "Yes";
	if (checked) {
		$('.open-with').slideDown();
	} else {
		$('.open-with').slideUp();
	}
}

function hideClientDangersSelect() {
	var checked = $('.dangerous-aware').first().val() === "Yes";
	if (checked) {
		$('.client-dangers1').slideDown();
	} else {
		$('.client-dangers1').slideUp();
	}
}

function hideVerbalAbuseClientDangersSelect() {
	var checked = $('.verbal-abuse').first().val() === "Yes";
	if (checked) {
		$('.client-dangers2').slideDown();
	} else {
		$('.client-dangers2').slideUp();
	}
}

function hidePhysicalAbuseClientDangersSelect() {
	var checked = $('.physical-abuse').first().val() === "Yes";
	if (checked) {
		$('.client-dangers3').slideDown();
	} else {
		$('.client-dangers3').slideUp();
	}
}

function hideOtherAbuseOverview() {
	var checked = $('.other-abuse').first().val() === "Yes";
	if (checked) {
		$('.other-violence-overview').slideDown();
	} else {
		$('.other-violence-overview').slideUp();
	}
}

function hideSexualViolenceClientDangersSelect() {
	var checked = $('.sexual-violence').first().val() === "Yes";
	if (checked) {
		$('.client-dangers4').slideDown();
	} else {
		$('.client-dangers4').slideUp();
	}
}

function hideMentalIllnessOptions() {
	var checked = $('.mental-illness').first().val() === "Yes";
	if (checked) {
		$('.mental-illness-optional').slideDown();
	} else {
		$('.mental-illness-optional').slideUp();
	}
}

function hideArrestedOptions() {
	var checked = $('.arrested').first().val() === "Yes";
	if (checked) {
		$('.arrested-optional').slideDown();
	} else {
		$('.arrested-optional').slideUp();
	}
}

function hidePersecutionOptions() {
	var checked = $('.persecution').first().val() === "Yes";
	if (checked) {
		$('.persecution-optional').slideDown();
	} else {
		$('.persecution-optional').slideUp();
	}
}

function hideMedicalConcernOptions() {
	var checked = $('.medical-concern').first().val() === "Yes";
	if (checked) {
		$('.medical-concern-optional').slideDown();
	} else {
		$('.medical-concern-optional').slideUp();
	}
}

function hideDocumentaryEvidenceOptions() {
	var checked = $('.documentary-evidence').first().val() === "Yes";
	if (checked) {
		$('.documentary-evidence-optional').slideDown();
	} else {
		$('.documentary-evidence-optional').slideUp();
	}
}

function hideDocumentaryOtherExplanation() {
	var checked = $('.documentary-evidence-other').first().prop('checked');
	if (checked) {
		$('.documentary-other-optional').slideDown();
	} else {
		$('.documentary-other-optional').slideUp();
	}
}

function togglePersonalRelationship(relationshipClass, yesClass, noClass) {
	var yes = $(relationshipClass).first().val() === "Yes";
	var no = $(relationshipClass).first().val() === "No";
	if (yes) {
		$(yesClass).slideDown();
		$(noClass).slideUp();
	} else if (no) {
		$(noClass).slideDown();
		$(yesClass).slideUp();
	} else {
		$(yesClass).slideUp();
		$(noClass).slideUp();
	}
}

function togglePersonalRelationshipToClient() {
	togglePersonalRelationship('.personal-relationship-to-client', '.personal-relationship-yes', '.personal-relationship-no');
}

function hideProfessionalRelationshipOptions() {
	var checked = $('.personal-relationship-professional').first().val() === "Yes";
	if (checked) {
		$('.personal-relationship-organization').slideDown();
	} else {
		$('.personal-relationship-organization').slideUp();
	}
}

function hideWhichOrganizationOptions() {
	var checked = $('.which-organization').first().val() === "Other";
	if (checked) {
		$('.organization-name').slideDown();
	} else {
		$('.organization-name').slideUp();
	}
}

function hidePersonalRelationshipLevel() {
	var checked = $('.yes-personal-relationship').first().val() === "Yes";
	if (checked) {
		$('.friendship-level').slideDown();
	} else {
		$('.friendship-level').slideUp();
	}
}





$(document).ready(function() {
	$(document).on('change', '.referred-outside-country', displayCannotProvideAssistance);
	$(document).on('change', '.kimlik', hideKimlikNumber);
	$(document).on('change', '.refugee-status', hideUNHCRNumber);
	$(document).on('change', '.open-about', hideOpenAboutSexualOrientationOrGender);
	$(document).on('change', '.dangerous-aware', hideClientDangersSelect);
	$(document).on('change', '.verbal-abuse', hideVerbalAbuseClientDangersSelect);
	$(document).on('change', '.physical-abuse', hidePhysicalAbuseClientDangersSelect);
	$(document).on('change', '.other-abuse', hideOtherAbuseOverview);
	$(document).on('change', '.sexual-violence', hideSexualViolenceClientDangersSelect);
	$(document).on('change', '.mental-illness', hideMentalIllnessOptions);
	$(document).on('change', '.arrested', hideArrestedOptions);
	$(document).on('change', '.persecution', hidePersecutionOptions);
	$(document).on('change', '.medical-concern', hideMedicalConcernOptions);
	$(document).on('change', '.documentary-evidence', hideDocumentaryEvidenceOptions);
	$(document).on('click', '.documentary-evidence-other', hideDocumentaryOtherExplanation);
	$(document).on('change', '.personal-relationship-to-client', togglePersonalRelationshipToClient);
	$(document).on('change', '.which-organization', hideWhichOrganizationOptions);
	$(document).on('change', '.yes-personal-relationship', hidePersonalRelationshipLevel);
	$(document).on('change', '.personal-relationship-professional', hideProfessionalRelationshipOptions);


	displayCannotProvideAssistance();
	hideKimlikNumber();
	hideUNHCRNumber();
	hideOpenAboutSexualOrientationOrGender();
	hideClientDangersSelect();
	hideVerbalAbuseClientDangersSelect();
	hidePhysicalAbuseClientDangersSelect();
	hideOtherAbuseOverview();
	hideSexualViolenceClientDangersSelect();
	hideMentalIllnessOptions();
	hideArrestedOptions();
	hidePersecutionOptions();
	hideMedicalConcernOptions();
	hideDocumentaryEvidenceOptions();
	hideDocumentaryOtherExplanation();
	togglePersonalRelationshipToClient();
	hideWhichOrganizationOptions();
	hidePersonalRelationshipLevel();
	hideProfessionalRelationshipOptions();
});