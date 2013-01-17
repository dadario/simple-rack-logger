#encoding: utf-8
module Rack

  class RackLogger
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

  end
end
