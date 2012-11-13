require 'spec_helper'

describe Rack::RequestLogger do

  let(:logger) { logger = double(Logger) }
  let(:app) {
    mock(Struct.new(:none))
  }

  let(:env) do
    {
      "GATEWAY_INTERFACE" => "CGI/1.1",
      "PATH_INFO"         => "/v1/crachas.xml",
      "QUERY_STRING"      => "",
      "REMOTE_ADDR"       => "127.0.0.1",
      "REMOTE_HOST"       => "localhost",
      "REQUEST_METHOD"    => "GET",
      "REQUEST_URI"       => "http://localhost:9393/v1/crachas.xml",
      "SCRIPT_NAME"       => "",
      "SERVER_NAME"       => "localhost",
      "SERVER_PORT"       => "9393",
      "SERVER_PROTOCOL"   => "HTTP/1.1",
      "SERVER_SOFTWARE"   => "WEBrick/1.3.1 (Ruby/1.9.3/2012-10-12)",
      "HTTP_USER_AGENT"   => "curl/7.22.0 (x86_64-pc-linux-gnu) libcurl/7.22.0 OpenSSL/1.0.1 zlib/1.2.3.4 libidn/1.23 librtmp/2.3",
      "HTTP_HOST"         => "localhost:9393",
      "HTTP_ACCEPT"       => "*/*",
      "HTTP_VERSION"      => "HTTP/1.1",
      "REQUEST_PATH"      => "/v1/crachas.xml",
      "rack.input"        => "",
      "rack.errors"       => "",
      "rack.multithread"  => true,
      "rack.multiprocess" => false,
      "rack.run_once"     => false,
      "rack.url_scheme"   => "http"
    }
  end

  context 'inicial state without filter' do
    subject {
      Rack::RequestLogger.new(app, logger)
    }

    it 'log request information from env' do
      app.should_receive(:call)
      logger.should_receive(:info).with('GET: http://localhost:9393/v1/crachas.xml for 127.0.0.1 [heades: ["HTTP_USER_AGENT=curl/7.22.0 (x86_64-pc-linux-gnu) libcurl/7.22.0 OpenSSL/1.0.1 zlib/1.2.3.4 libidn/1.23 librtmp/2.3", "HTTP_HOST=localhost:9393", "HTTP_ACCEPT=*/*", "HTTP_VERSION=HTTP/1.1"]')
      subject.call(env)
    end
  end

  context 'inicial state with filter' do
    subject {
      filter = Object.new
      def filter.filter(request)
        request.ip =~/127.0.0.1/
      end
      Rack::RequestLogger.new(app, logger, filter)
    }

    it 'dont log request information from env' do
      app.should_receive(:call)
      logger.should_not_receive(:info)
      subject.call(env)
    end

  end

end