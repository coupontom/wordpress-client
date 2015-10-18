require_relative 'meta_object'

module Wordpress::Object
  class Oauth < MetaObject
    attr_parameter :access_token, :token_type, :blog_id, :blog_url
  end
end
