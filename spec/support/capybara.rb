RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless
  end

  # RSpecでビューヘルパーを使う
  config.include ActionView::Helpers::DateHelper

  # RSpecでアプリケーションヘルパーを使う
  config.include ApplicationHelper
end

Capybara.default_max_wait_time = 15
