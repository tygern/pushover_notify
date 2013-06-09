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
    end

    def set_request_attributes (message_tokens = {})
      unless valid_sound(message_tokens[:sound])
        message_tokens.delete(:sound)
      end

      @request.set_form_data({
                                 :token => @application_key,
                                 :user => @user_key,
                                 :message => message_tokens[:message],
                                 :title => message_tokens[:title],
                                 :url => message_tokens[:url],
                                 :url_title => message_tokens[:url_title],
                                 :sound => message_tokens[:sound]
                               })
    end

    def send
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
      sound.nil? || @sounds.include?(sound)
    end
  end
end