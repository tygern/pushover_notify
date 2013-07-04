module PushoverNotify
  class Notifier
    attr_accessor :request, :message
    attr_reader :application_key, :user, :response, :device_name

    def initialize (user, message, device: nil)
      @user = user
      @application_key = PushoverNotify::Authentication::application_key
      @message = message

      @url = URI.parse "https://api.pushover.net/1/messages.json"
      @request = Net::HTTP::Post.new @url.path
      @response = Net::HTTP.new @url.host, @url.port

      if device && @user.has_device?(device)
        @device_name = device.name
      end
    end


    def send_message
      message_validator = PushoverNotify::MessageValidator.new(message)
      @message = message_validator.validate

      create_request

      @response = Net::HTTP.new @url.host, @url.port
      @response.use_ssl = true
      @response.verify_mode = OpenSSL::SSL::VERIFY_PEER
      @response.start { |http| http.request(@request) }
    end

    def create_request
      @request.set_form_data(
        {
          token: application_key,
          user: user.key,
          message: message.text,
          title: message.title,
          url: message.url,
          url_title: message.url_title,
          sound: message.sound,
          priority: message.priority,
          device: device_name
        }
      )
    end
  end
end