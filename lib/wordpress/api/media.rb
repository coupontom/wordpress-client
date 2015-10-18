require "wordpress/ostruct"
require "wordpress/object/media"
module Wordpress::API
  module Media

    def add_media(site, params = {})
      validate_keys! params, [:context, :media, :media_urls,:attrs] + default_keys
      exec_api(Wordpress::Request.new(:post, "/rest/v1.1/sites/#{site}/media/new",nil, params)) do |json|
        Wordpress::Object::Media.new( self, json )
      end
    end

  end
end

