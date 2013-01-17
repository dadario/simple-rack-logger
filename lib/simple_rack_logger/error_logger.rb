#encoding: utf-8
module Rack

  class ErrorLogger < RackLogger
    attr_reader :logger

    def initialize(app, logger, *filters)
      super
    end

    def call(env)
      begin
        @app.call(env)
      rescue => e
        logger.error("#{e.message}\r\n#{e.backtrace.join("\r\n")}")
        logger.flush
        raise e
      end
    end

  end
end
