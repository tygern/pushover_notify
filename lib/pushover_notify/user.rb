module PushoverNotify
  class User
    attr_reader :key, :devices

    def initialize(key, devices: [])
      @key = key
      @devices = devices
    end

    def add_device(device)
      devices << device unless has_device?(device)
    end

    def has_device?(device)
      devices.include?(device)
    end

  end
end