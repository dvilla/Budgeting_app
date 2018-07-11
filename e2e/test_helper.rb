require 'selenium-webdriver'
require 'minitest'
require 'capybara'
require 'capybara/dsl'
require 'capybara/minitest'
require 'minitest/spec'
require 'minitest/reporters'
require 'minitest/autorun'
require 'pry'

#Including all page objects to be available in all tests
Dir["./e2e/page_objects/*.rb"].each {|file| require file }

#Using minitest spec reporter to show test names
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

if ENV["HTML_REPORTER"]
  Minitest::Reporters.use! Minitest::Reporters::HtmlReporter.new({reports_dir: 'e2e/html_reports'})
end

#Adding headless chrome to run in on a continuous integration server
Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: {
      args: %w[ no-sandbox headless disable-gpu window-size=1280,1024]
    }
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
end

Capybara.register_driver :chrome do |app|
  options = {
      browser: :chrome
  }
  Capybara::Selenium::Driver.new(app, options)
end

Capybara.app_host = 'http://localhost:3000/'
Capybara.current_driver = :chrome

class Minitest::Test
  include Capybara::DSL
end

class CapybaraTestCase < Minitest::Test
  include Capybara::DSL
  include Capybara::Minitest::Assertions
end

def number_with_delimiter(number, delimiter=",")
  number.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/,"\\1#{delimiter}")
end