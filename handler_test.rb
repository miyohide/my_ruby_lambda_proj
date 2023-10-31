# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'handler'

class HandlerTest < Minitest::Test
  def test_handler_date_command
    event = {"command" => "date", "option" => "option1"}
    result = handler(event: event, context: nil)
    assert_equal 200, result[:statusCode]
    assert_match /\A\"\d{4}-\d{2}-\d{2}\"\Z/, result[:body][:date]
  end

  def test_handler_time_command
    event = {"command" => "time", "option" => "option1"}
    result = handler(event: event, context: nil)
    assert_equal 200, result[:statusCode]
    assert_match /\A\"\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2} \+0900"\Z/, result[:body][:time]
  end

  def test_handler_unsupport_command
    event = {"command" => "foobar", "option" => "option1"}
    assert_equal 400, handler(event: event, context: nil)[:statusCode]
  end
end
