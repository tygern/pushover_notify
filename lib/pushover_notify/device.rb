module PushoverNotify
  class Device
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end
end