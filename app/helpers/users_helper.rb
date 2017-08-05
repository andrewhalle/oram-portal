module UsersHelper
    def get_form(user, type)
        if !user.forms.empty? && !user.forms.where(form_type: type).empty?
			user_forms = user.forms.where(form_type: type)
			@form_id = user_forms.first.id
			form_hash = JSON.parse(user_forms.first.form_json)
        end
		form_hash
    end
    
    def get_calendar_url(calendar_id)
        if calendar_id == ""
            return ""
        else
            return "https://calendar.google.com/calendar/embed?src=#{calendar_id}&ctz=America/Los_Angeles"
        end
    end
end
