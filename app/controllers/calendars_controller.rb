class CalendarsController < ApplicationController
  
  def set_calendar
    calendar_id = params[:calendar_id]
    user = User.find_by_id(params[:id])
    user.calendar_id = calendar_id
    user.save
    @new_url = user.calendar_id
    redirect_to client_path
  end
  
  def calendars
    client = Signet::OAuth2::Client.new({
      client_id: Rails.application.secrets.google_client_id,
      client_secret: Rails.application.secrets.google_client_secret,
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token'
    })

    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @calendar_list = service.list_calendar_lists

    events = service.list_events("#{@calendar_list.items[0].id}")

    @my_calendar = @calendar_list.items[6]
    foregroundColor = @my_calendar.foreground_color
    backgroundColor = @my_calendar.background_color
    @all_events = events.items
    # nice = cast_google_events(events, foregroundColor, backgroundColor)
    calendar_id = @my_calendar.id
    @calender_url = "https://calendar.google.com/calendar/embed?src=berkeley.edu_ekjciavasf7fqh2jp1ka7pht00%40group.calendar.google.com&ctz=America/Los_Angeles"
    @new_url = "https://calendar.google.com/calendar/embed?src=#{calendar_id}&ctz=America/Los_Angeles"
  end
  
  def redirect
    client = Signet::OAuth2::Client.new({
      client_id: Rails.application.secrets.google_client_id,
      client_secret: Rails.application.secrets.google_client_secret,
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: calendar_callback_url
    })
    redirect_to client.authorization_uri.to_s
  end
  
  def callback
    client = Signet::OAuth2::Client.new({
      client_id: Rails.application.secrets.google_client_id,
      client_secret: Rails.application.secrets.google_client_secret,
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      redirect_uri: calendar_callback_url,
      code: params[:code]
    })
  
    response = client.fetch_access_token!
  
    session[:authorization] = response
  
    redirect_to calendars_url
  end
  

  


end