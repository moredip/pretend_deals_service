require 'microscope/span'

module Microscope
  module Headers
    def self.add_client_request_headers(env,span,child_span_id)
      env["Microscope-Trace-Id"] = span.trace_id
      env["Microscope-Parent-Span-Id"] = span.span_id
      env["Microscope-Span-Id"] = child_span_id
    end

    def self.span_from_server_request_headers(env)
      # TODO: extract span id from Microscope-Span-Id if present
      trace_id = env["Microscope-Trace-Id"]
      parent_span_id = env["Microscope-Parent-Span-Id"]
      span_id = env.fetch("Microscope-Span-Id",false)
      Span.new(trace_id,parent_span_id,span_id)
    end
  end
end
