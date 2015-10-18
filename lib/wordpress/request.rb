require 'uri'

module Wordpress
  class Request < Base
    END_POINT = "https://public-api.wordpress.com/"
    attr_accessor :method, :url, :params, :body

    def initialize(method, url, params = {}, body = {})
      @method = method
      @url = URI.join(end_point, url).to_s
      if params
        @params = params.dup
      end

      if body
        @body = body.dup
      end
    end

    def initialize_copy(other)
      other.params = params.dup
      other.body = body.dup
    end

    def end_point
      END_POINT.freeze
    end
  end
end
