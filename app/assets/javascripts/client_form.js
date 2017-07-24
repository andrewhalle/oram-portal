function clientTogglePersonalRelationshipToReferrer() {
	togglePersonalRelationship('.client-personal-relationship-to-referrer', '.client-personal-relationship-yes-questionnaire', '.client-personal-relationship-no-questionnaire');
}

function showHideElement(controlFunction, arg, el) {
	function showHideFunction() {
		if (controlFunction(arg)) {
			$(el).slideDown();
		} else {
			$(el).slideUp();
		}
	}
	showHideFunction();
	return showHideFunction;
}

function isChecked(class_name) {
	return $(class_name).first().prop('checked');
}

function isString(string, class_name) {
	return $(class_name).first().val() === string;
}

function isNo(class_name) {
	return isString("No", class_name);
}

function isYes(class_name) {
	return isString("Yes", class_name);
}

function isOther(class_name) {
	return isString("Other", class_name);
}


$(document).ready(function() {

	$(document).on('click', '.client-languages-spoken-other', showHideElement(isChecked, '.client-languages-spoken-other', '.other-languages-spoken'));
	$(document).on('change', '.client-outside-country', showHideElement(isNo, '.client-outside-country', '.client-cannot-provide-assistance'));
	$(document).on('change', '.client-kimlik', showHideElement(isYes, '.client-kimlik', '.client-kimlik-number'));
	$(document).on('change', '.client-refugee-status', showHideElement(isYes, '.client-refugee-status', '.client-unhcr-case-info'));
	$(document).on('change', '.client-open-about', showHideElement(isYes, '.client-open-about', '.client-open-with'));
	$(document).on('change', '.client-dangerous-aware', showHideElement(isYes, '.client-dangerous-aware', '.client-aware-sexual-orientation-dangers'));
	$(document).on('change', '.client-verbal-abuse', showHideElement(isYes, '.client-verbal-abuse', '.client-verbal-abuse-dangers'));
	$(document).on('change', '.client-physical-abuse', showHideElement(isYes, '.client-physical-abuse', '.client-physical-abuse-dangers'));
	$(document).on('change', '.client-other-abuse', showHideElement(isYes, '.client-other-abuse', '.client-other-violence-overview'));
	$(document).on('change', '.client-sexual-violence', showHideElement(isYes, '.client-sexual-violence', '.client-sexual-violence-dangers'));
	$(document).on('change', '.client-mental-illness', showHideElement(isYes, '.client-mental-illness', '.client-mental-illness-optional'));
	$(document).on('change', '.client-arrested', showHideElement(isYes, '.client-arrested', '.client-arrested-optional'));
	$(document).on('change', '.client-persecution', showHideElement(isYes, '.client-persecution', '.client-persecution-optional'));
	$(document).on('change', '.client-medical-concern', showHideElement(isYes, '.client-medical-concern', '.client-medical-concern-optional'));
	$(document).on('change', '.client-documentary-evidence', showHideElement(isYes, '.client-documentary-evidence', '.client-documentary-evidence-optional'));
	$(document).on('click', '.client-documentary-evidence-other', showHideElement(isChecked, '.client-documentary-evidence-other', '.client-documentary-other-optional'));
	$(document).on('change', '.client-personal-relationship-to-referrer', clientTogglePersonalRelationshipToReferrer);
	clientTogglePersonalRelationshipToReferrer();
	$(document).on('change', '.client-personal-relationship-professional', showHideElement(isYes, '.client-personal-relationship-professional', '.client-personal-relationship-organization'));
	$(document).on('change', '.client-which-organization', showHideElement(isOther, '.client-which-organization', '.client-organization-name'));
	$(document).on('change', '.client-yes-personal-relationship', showHideElement(isYes, '.client-yes-personal-relationship', '.client-friendship-level'));

});

