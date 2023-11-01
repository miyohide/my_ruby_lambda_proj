# frozen_string_literal: true

require "json"
require "date"

# event には {"command": コマンド名, "option": オプション値}という
# Hashで出力される
def handler(event:, context:)
  status_code = 200
  case event["command"]
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
    body: result,
    message: "message v1"
  }
end
