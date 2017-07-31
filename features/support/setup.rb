require 'capybara/poltergeist'
Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, timeout:10000, js_errors: false, debug: false)
end

Capybara.javascript_driver = :poltergeist