require_relative 'meta_object'

module Wordpress::Object
  class Media < MetaObject
    attr_parameter :media, :errors
  end
end
