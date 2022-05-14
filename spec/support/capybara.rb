RSpec.configure do |config|
  config.before(:each, type: :sysytem) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome
  end
end

Capybara.register_driver :chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_preference('profile.content_settings.exceptions.clipboard', {
    '*': {'setting': 1}
  })
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
