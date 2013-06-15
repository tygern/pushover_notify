module PushoverNotify
  class MessageValidator
    def initialize(notifier)
      @application_key = notifier.application_key
      @sounds = fetch_sounds
      @priorities = [-1, 0, 1, "-1", "0", "1"]

      @message = notifier.message
    end

    def validate
      sound = @message.sound
      priority = @message.priority

      @message.sound = nil unless valid_sound(sound)
      @message.priority = nil unless valid_priority(priority)

      @message
    end

    private

    def fetch_sounds
      HTTParty.get('https://api.pushover.net/1/sounds.json?token=' + @application_key)['sounds'].keys
    end

    def valid_priority (priority)
      @priorities.include? priority
    end

    def valid_sound (sound)
      @sounds.include? sound
    end
  end
end