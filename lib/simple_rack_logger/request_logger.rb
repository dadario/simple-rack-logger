#encoding: utf-8
module Rack

  class RequestLogger
    attr_reader :logger

    def initialize(app, logger, *filters)
      @app     = app
      @logger  = logger
      @filters = filters

      def @logger.flush
        # Chamando o flush diretamente, pois está demorando para descarregar a memória
        # além de não ter a opção de executar
        logdev = self.instance_variable_get(:@logdev)
        logdev.instance_variable_get(:@dev).flush if logdev
      end
    end

    def call(env)
      request = Rack::Request.new(env)
      block = @filters.select { |filter| filter.respond_to?(:filter) && filter.send(:filter, request) }

      if block.empty?
        logger.info(expose(request))
        logger.flush
      end

      @app.call(env)
    end

    private
    def expose(request)
      params = request.params.map { |key, value| "#{key}=#{value}" }
      "#{request.request_method}: #{request.url} for #{request.ip} with #{request.user_agent} [params: #{params.join('; ')}]"
    end

  end
end
