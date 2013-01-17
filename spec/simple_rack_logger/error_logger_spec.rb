require 'spec_helper'

describe Rack::ErrorLogger do

  let(:logger) { logger = double(Logger) }
  let(:app) {
    mock(Struct.new(:none))
  }
  let(:env) { { } }

  subject {
    Rack::ErrorLogger.new(app, logger)
  }

  it 'log exception when dispatched' do
    app.should_receive(:call).and_throw(ArgumentError.new("forced error"))
    logger.should_receive(:error).with(anything)

    expect { subject.call(env) }.to raise_exception
  end

end