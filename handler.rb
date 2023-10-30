# frozen_string_literal: true

require "json"
require "date"

def handler(event:, context:)
  events = JSON.parse(event.body)
  status_code = 200
  case events
  when "date"
    result = { date: JSON.generate(Date.today) }
  when "time"
    result = { time: JSON.generate(Time.now) }
  else
    status_code = 400
    result = { "error" => "Must specify 'date' or 'time'" }
  end

  {
    statusCode: status_code,
    body: result
  }
end
