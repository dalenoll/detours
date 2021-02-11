class NotificationRequest
  attr_reader :location_id, :short_name, :long_name, :notify, :acknowledge
  def initialize(id, short_name, long_name, notify)
    @location_id = id
    @short_name = short_name
    @long_name = long_name
    @notify = notify
    @acknowledge = 0
  end
  
end
