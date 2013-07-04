module PushoverNotify
  class Device
    attr_reader :name, :default

    def initialize(name, default = {})
      @name = name
      @default = default || {}
    end

    def add_default(option, value)
      default[option] = value
    end

    def remove_default(option)
      default.delete(option)
    end
  end
end