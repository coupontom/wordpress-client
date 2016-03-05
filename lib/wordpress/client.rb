require 'multi_json'
require 'faraday'
require 'faraday_middleware/gzip'
require_relative 'base'
require_relative 'request'
require_relative 'api'
require_relative 'errors'
require_relative 'configuration'

module Wordpress
  class Client < Base
    include Wordpress::API

    attr_accessor :access_token

    def initialize
      @conn = Faraday.new do |faraday|
        faraday.use Faraday::Response::Logger, logger
        faraday.request :multipart
        faraday.request :url_encoded
        #faraday.response :gzip
        faraday.adapter Faraday.default_adapter
      end
    end

    def call(request, options = {})
      debug "Request: #{request.inspect}"

      response = @conn.send(request.method) do |req|

        case req.method
          when :delete, :get
            req.url(request.url, request.params)
          when :put, :post
            req.path = request.url
            req.body = request.body unless request.body.empty?
        end


        if options[:bearer_token_request] && !bearer_auth_header.nil?
          req.headers['Authorization'] = bearer_auth_header
        end
        #req.headers['Accept-Encoding'] = 'gzip,deflate'
        req.options[:timeout] = 10
        req.options[:open_timeout] = 5
      end

      begin
        json = MultiJson.load(response.body)
        if json.nil? || json == ''
          raise Wordpress::ResponseError
        end
      rescue MultiJson::LoadError => e
        raise Wordpress::ResponseError, {'error' => e, 'message' => "Can not parse the response: #{response.body.inspect}"}
      end

      debug "Response: #{json}"

      json
    end

    private

    def bearer_auth_header
      access_token.nil? ? nil : "Bearer #{access_token}"
    end
  end
end
