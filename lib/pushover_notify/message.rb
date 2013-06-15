module PushoverNotify
  class Message
    attr_accessor :text, :title, :url, :url_title, :sound, :priority

    def initialize(attributes)
      @text = attributes[:text] || ""
      @title = attributes[:title]
      @url = attributes[:url]
      @url_title = attributes[:url_title]
      @sound = attributes[:sound]
      @priority = attributes[:priority]
    end
  end
end