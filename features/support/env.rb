require 'cucumber'
require 'httparty'
require 'JSON'
require 'pry-byebug'
require "rspec/expectations"
require 'require_all'

require_all 'lib'

Before do
  @application_manager = ApplicationManager.new
  @yoti_api = YotiApi.new("https://api.yoti.com")
end