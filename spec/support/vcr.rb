require 'vcr'
require 'faraday'

# Custom VCR matchers
custom_body_matcher = lambda do |request_1, request_2|
  if request_1.body.encoding.name == 'ASCII-8BIT'
    # when uploading a file, we noticed that VCR or Faraday added 2 extra characters
    # at the end of the body: \r\n.
    request_1.body == request_2.body ||
    request_1.body == request_2.body.gsub(/\r\n$/, '')
  else
    request_1.body == request_2.body
  end
end

# VCR config
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :faraday
  c.ignore_hosts 'codeclimate.com'
  c.configure_rspec_metadata!
  c.register_request_matcher :custom_body, &custom_body_matcher
  # the User-Agent carries the Faraday version, which would break the cassettes on every bump
  c.register_request_matcher(:headers_without_user_agent) do |r1, r2|
    r1.headers.except('User-Agent') == r2.headers.except('User-Agent')
  end
end

# Without this, VCR is unable to match a POST request with uploaded files
# https://github.com/lostisland/faraday/issues/772
Faraday.default_connection_options.request.boundary = "------------------RubyMultiPartPost".freeze
