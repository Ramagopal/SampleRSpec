require 'allure-rspec'
require 'rspec'
require 'capybara/rspec'
require  'eyes_selenium'
require 'applitools/capybara'

Applitools.register_capybara_driver :browser => :chrome

AllureRSpec.configure do |allureconfig|
  allureconfig.output_dir = 'tmp/screenshots'
  allureconfig.clean_dir = true # this is the default value
  allureconfig.logging_level = Logger::ERROR

end

describe 'Full page example (scrolling)', :type => :feature, :js => true do
  let(:eyes) do
    Applitools::Selenium::Eyes.new.tap do |eyes|
      eyes.api_key = 'your-key'
      eyes.log_handler = Logger.new(STDOUT)
    end
  end

  it 'Full page test' do
    begin
      eyes.force_full_page_screenshot = true
      eyes.test(app_name: 'Ruby SDK',
                test_name: 'Fullpage example (scroll)', driver: page, viewport_size: { width: 900, height: 600 }) do
        visit 'https://github.com'
        eyes.check_window('Entire index page')
      end
    ensure
      eyes.abort_if_not_closed
    end
  end

  it 'The other full page test' do
    begin
      eyes.force_full_page_screenshot = true

      eyes.stitch_mode = :css

      eyes.test(app_name: 'Ruby SDK',
                test_name: 'Fullpage example (css)', driver: page, viewport_size: { width: 900, height: 600 }) do
        visit 'https://github.com'
        eyes.check_window('Entire index page')
      end
    ensure
      eyes.abort_if_not_closed
    end
  end
end