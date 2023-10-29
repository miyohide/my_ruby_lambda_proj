# frozen_string_literal: true

module LambdaFunctions
  # Handler はAWS Lambda上で動かすことを想定したクラス
  class Handler
    # self.process はAWS Lambda上での関数ハンドラー
    def self.process(event:, context:)
      'Hello!'
    end
  end
end
