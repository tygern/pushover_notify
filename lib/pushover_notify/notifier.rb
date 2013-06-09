module PushoverNotify
  class Notifier
    attr_accessor :user_key, :request, :sounds

    def initialize (user_key)
      @user_key = user_key
      @application_key = 'xQNk3zEDqFczPaqp2CWpjEDwqumvRp'
      @url = URI.parse("https://api.pushover.net/1/messages.json")
      @request = Net::HTTP::Post.new(@url.path)
      @response = Net::HTTP.new(@url.host, @url.port)
      @sounds = fetch_sounds
      @priorities = [-1, 0, 1, "-1", "0", "1"]
    end

    def set_request_attributes (message_tokens = {})

      message_tokens.delete(:sound) unless valid_sound(message_tokens[:sound])
      message_tokens.delete(:priority) unless valid_priority(message_tokens[:priority])

      @request.set_form_data({
                                 :token => @application_key,
                                 :user => @user_key,
                                 :message => message_tokens[:message],
                                 :title => message_tokens[:title],
                                 :url => message_tokens[:url],
                                 :url_title => message_tokens[:url_title],
                                 :sound => message_tokens[:sound],
                                 :priority => message_tokens[:priority]
                               })
    end

    def send_message
      @response = Net::HTTP.new(@url.host, @url.port)
      @response.use_ssl = true
      @response.verify_mode = OpenSSL::SSL::VERIFY_PEER
      @response.start {|http| http.request(@request) }
    end

    private

    def fetch_sounds
      HTTParty.get('https://api.pushover.net/1/sounds.json?token=' + @application_key)['sounds'].keys
    end

    def valid_sound (sound)
      @sounds.include? sound
    end

    def valid_priority (priority)
      @priorities.include? priority
    end
  end
end