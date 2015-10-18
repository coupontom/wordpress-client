require "wordpress/ostruct"
require "wordpress/object/oauth"
module Wordpress::API
  module Oauth
    def get_token(params = {})
      validate_keys! params, [:client_id, :client_secret, :code, :grant_type, :redirect_uri] + default_keys
      exec_api(Wordpress::Request.new(:post, "oauth2/token",nil, params )) do |json|
        Wordpress::Object::Oauth.new(self, json)
      end

    end

    def token_info(params = {})
      validate_keys! params, [:client_id, :token] + default_keys
      exec_api(Wordpress::Request.new(:get, "oauth2/token-info",params,  )) do |json|
        Wordpress::Object::Oauth.new(self, json)
      end
    end

  end
end

