require 'spec_helper'

describe Rack::RequestLogger do

  let(:logger) { logger = double(Logger) }

  subject {
    app = mock(Struct.new(:none))
    app.should_receive(:call)
    Rack::RequestLogger.new(app, logger)
  }

  it 'log request information from env' do

    env = {
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

    logger.should_receive(:info).with('GET: http://localhost:9393/v1/crachas.xml for 127.0.0.1 with curl/7.22.0 (x86_64-pc-linux-gnu) libcurl/7.22.0 OpenSSL/1.0.1 zlib/1.2.3.4 libidn/1.23 librtmp/2.3 [params: ]')

    subject.call(env)
  end

end