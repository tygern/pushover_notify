module PushoverNotify
  class Message
    attr_accessor :text, :title, :url, :url_title, :sound, :priority

    def initialize(text: '', title: nil, url: nil, url_title: nil, sound: nil, priority: nil, device: nil)
      @text = text
      @title = title
      @url = url
      @url_title = url_title
      @sound = sound
      @priority = priority

    end
  end
end