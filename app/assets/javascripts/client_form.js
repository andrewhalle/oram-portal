function clientTogglePersonalRelationshipToReferrer() {
	togglePersonalRelationship('.client-personal-relationship-to-referrer', '.client-personal-relationship-yes-questionnaire', '.client-personal-relationship-no-questionnaire');
}

function showHideElement(controlFunction, el) {
	function showHideFunction() {
		if (controlFunction()) {
			$(el).slideDown();
		} else {
			$(el).slideUp();
		}
	}
	showHideFunction();
	return showHideFunction;
}


$(document).ready(function() {

	$(document).on('click', '.client-languages-spoken-other', showHideElement(function() {
		return $('.client-languages-spoken-other').first().prop('checked');
	}, '.other-languages-spoken'));
	$(document).on('change', '.client-outside-country', showHideElement(function() {
		return $('.client-outside-country').first().val() === "No";
	}, '.client-cannot-provide-assistance'));
	$(document).on('change', '.client-kimlik', showHideElement(function() {
		return $('.client-kimlik').first().val() === "Yes";
	}, '.client-kimlik-number'));
	$(document).on('change', '.client-refugee-status', showHideElement(function() {
		return $('.client-refugee-status').first().val() === "Yes";
	}, '.client-unhcr-case-info'));
	$(document).on('change', '.client-open-about', showHideElement(function() {
		return $('.client-open-about').first().val() === "Yes";
	}, '.client-open-with'));
	$(document).on('change', '.client-dangerous-aware', showHideElement(function() {
		return $('.client-dangerous-aware').first().val() === "Yes";
	}, '.client-aware-sexual-orientation-dangers'));
	$(document).on('change', '.client-verbal-abuse', showHideElement(function() {
		return $('.client-verbal-abuse').first().val() === "Yes";
	}, '.client-verbal-abuse-dangers'));
	$(document).on('change', '.client-physical-abuse', showHideElement(function() {
		return $('.client-physical-abuse').first().val() === "Yes";
	}, '.client-physical-abuse-dangers'));
	$(document).on('change', '.client-other-abuse', showHideElement(function() {
		return $('.client-other-abuse').first().val() === "Yes";
	}, '.client-other-violence-overview'));
	$(document).on('change', '.client-sexual-violence', showHideElement(function() {
		return $('.client-sexual-violence').first().val() === "Yes";
	}, '.client-sexual-violence-dangers'));
	$(document).on('change', '.client-mental-illness', showHideElement(function() {
		return $('.client-mental-illness').first().val() === "Yes";
	}, '.client-mental-illness-optional'));
	$(document).on('change', '.client-arrested', showHideElement(function() {
		return $('.client-arrested').first().val() === "Yes";
	}, '.client-arrested-optional'));
	$(document).on('change', '.client-persecution', showHideElement(function() {
		return $('.client-persecution').first().val() === "Yes";
	}, '.client-persecution-optional'));
	$(document).on('change', '.client-medical-concern', showHideElement(function() {
		return $('.client-medical-concern').first().val() === "Yes";
	}, '.client-medical-concern-optional'));
	$(document).on('change', '.client-documentary-evidence', showHideElement(function() {
		return $('.client-documentary-evidence').first().val() === "Yes";
	}, '.client-documentary-evidence-optional'));
	$(document).on('click', '.client-documentary-evidence-other', showHideElement(function() {
		return $('.client-documentary-evidence-other').first().prop('checked');
	}, '.client-documentary-other-optional'));
	$(document).on('change', '.client-personal-relationship-to-referrer', clientTogglePersonalRelationshipToReferrer);
	clientTogglePersonalRelationshipToReferrer();
	$(document).on('change', '.client-personal-relationship-professional', showHideElement(function() {
		return $('.client-personal-relationship-professional').first().val() === "Yes";
	}, '.client-personal-relationship-organization'));
	$(document).on('change', '.client-which-organization', showHideElement(function() {
		return $('.client-which-organization').first().val() === "Other";
	}, '.client-organization-name'));
	$(document).on('change', '.client-yes-personal-relationship', showHideElement(function() {
		return $('.client-yes-personal-relationship').first().val() === "Yes";
	}, '.client-friendship-level'));

});

