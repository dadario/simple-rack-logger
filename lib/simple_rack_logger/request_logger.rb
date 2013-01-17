#encoding: utf-8
module Rack

  class RequestLogger < RackLogger

    def initialize(app, logger, *filters)
      super
    end

    def call(env)
      request = Rack::Request.new(env)
      block   = @filters.select { |filter| filter.respond_to?(:filter) && filter.send(:filter, request) }
      if block.empty?
        logger.info(expose(request, env))
        logger.flush
      end

      @app.call(env)
    end

    private
    def expose(request, env)
      show = "#{request.request_method}: #{request.url} for #{request.ip}"

      params = request.params.map { |key, value| "#{key}=#{value}" }
      show << "[params: #{params.join('; ')}]" unless params.empty?

      headers = env.select { |key, value| key.start_with?('HTTP_') }
      show << " [heades: #{headers.collect { |pair| pair.join("=") }}" unless headers.empty?

      show
    end

  end
end
