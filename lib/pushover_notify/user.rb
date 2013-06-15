module PushoverNotify
  class User
    attr_reader :key

    def initialize(key)
      @key = key
    end

  end
end