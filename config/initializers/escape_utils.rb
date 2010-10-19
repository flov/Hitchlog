module Rack
  module Utils
    def escape(s)
      EscapeUtils.escape_url(s)
    end
  end
end

# making escaping HTML faster:
require "escape_utils/html/rack"
require "escape_utils/html/haml"