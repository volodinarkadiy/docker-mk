ENV['RACK_ENV'] = 'test'

require_relative 'ui_app.rb'
require 'test/unit'
require 'rack/test'

class UiAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    UI
  end

  def test_healthcheck_page
    get '/health'
    assert last_response.ok?
  end

  def test_it_says_hello_to_a_person
    get '/'
    assert last_response.body.include?('Microservices awesome blog')
  end
end
