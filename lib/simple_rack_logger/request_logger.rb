#encoding: utf-8
module Rack

  class RequestLogger < RackLogger

    def initialize(app, logger, *filters)
      super
    end

    def call(env)

      uuid = unique_identy

      request = Rack::Request.new(env)
      block   = @filters.select { |filter| filter.respond_to?(:filter) && filter.send(:filter, request) }
      if block.empty?
        logger.info("IDENT:|#{uuid}| REQUEST_VALUE:|#{expose(request, env)}|")
        logger.flush
      end

      return_value = @app.call(env)

      if block.empty?
        logger.info("IDENT:|#{uuid}| RETURN_VALUE:|#{expose_return(return_value).to_s}|")
        logger.flush
      end

      return_value
    end

    private
    def expose(request, env)
      show = "#{request.request_method}: #{request.url} for #{request.ip}"

      params = request.params.map { |key, value| "#{key}=#{value}" }
      show << "[params: #{params.join('; ')}]" unless params.empty?

      headers = env.select { |key, value| key.start_with?('HTTP_') }
      show << " [headers: #{headers.collect { |pair| pair.join("=") }}" unless headers.empty?

      show
    end

    def expose_return(return_value)
      return_value = [return_value] unless return_value.is_a? Array

      return_value.map do |item|
        (item.is_a? Rack::BodyProxy) ? item.send(:body) : item.to_s
      end
    end

    def unique_identy
      UUID.new.generate
    end
  end
end

