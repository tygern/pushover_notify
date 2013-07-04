module PushoverNotify
  class Authentication
    def self.user_key
      YAML.load_file('config/keys.yml').fetch('user_key')
      end
    def self.application_key
      YAML.load_file('config/keys.yml').fetch('application_key')
    end
  end
end