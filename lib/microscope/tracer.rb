require 'rack/body_proxy'

require 'microscope/headers'
require 'microscope/trace_logger'

module Microscope

class Tracer
  def initialize(app,logger = Logger.new($stdout))
    @app = app
    @trace_logger = TraceLogger.new(logger)
  end

  def call(env)
    span = (env["SPAN"] ||= Headers.span_from_server_request_headers(env))
    span.store_for_this_request

    started_at = Time.now

    @trace_logger.log_server_start(span)

    status, header, body = @app.call(env)

    body = Rack::BodyProxy.new(body) do
      duration = Time.now - started_at
      @trace_logger.log_server_end(span,duration) 
    end

    [status, header, body]
  end
end

end
