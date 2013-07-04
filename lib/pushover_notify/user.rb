module PushoverNotify
  class User
    attr_accessor :device
    attr_reader :key

    def initialize(key, device = [])
      @key = key
      @device = device || []
    end

  end
end