function displayCannotProvideAssistance() {
	var checked = $('.referred-outside-country').first().val() === "No";
	if (checked) {
		$('.cannot-provide-assistance').slideDown();
	} else {
		$('.cannot-provide-assistance').slideUp();
	}
}

function hideItem(conditionClass, itemClass) {
	var checked = $(conditionClass).first().val() === "Yes";
	if (checked) {
		$(itemClass).slideDown();
	} else {
		$(itemClass).slideUp();
	}
}

function hideKimlikNumber() {
	hideItem('.kimlik', '.kimlik-number');
}

function hideUNHCRNumber() {
	hideItem('.refugee-status', '.unhcr-case-number');
}

function hideOpenAboutSexualOrientationOrGender() {
	hideItem('.open-about', '.open-with');
}

function hideClientDangersSelect() {
	hideItem('.dangerous-aware', '.client-dangers1');
}

function hideVerbalAbuseClientDangersSelect() {
	hideItem('.verbal-abuse', '.client-dangers2');
}

function hidePhysicalAbuseClientDangersSelect() {
	hideItem('.physical-abuse', '.client-dangers3');
}

function hideOtherAbuseOverview() {
	hideItem('.other-abuse', '.other-violence-overview');
}

function hideSexualViolenceClientDangersSelect() {
	hideItem('.sexual-violence', '.client-dangers4');
}

function hideMentalIllnessOptions() {
	hideItem('.mental-illness', '.mental-illness-optional');
}

function hideArrestedOptions() {
	hideItem('.arrested', '.arrested-optional');
}

function hidePersecutionOptions() {
	hideItem('.persecution', '.persecution-optional');
}

function hideMedicalConcernOptions() {
	hideItem('.medical-concern', '.medical-concern-optional');
}

function hideDocumentaryEvidenceOptions() {
	hideItem('.documentary-evidence', '.documentary-evidence-optional');
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
	hideItem('.personal-relationship-professional', '.personal-relationship-organization');
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
	hideItem('.yes-personal-relationship', '.friendship-level');
}

function hideAll() {
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
	hideAll();
});