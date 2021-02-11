class Location < ActiveRecord::Base
  belongs_to :notifications
  validates_presence_of :short_name, :long_name
  validates_uniqueness_of :short_name, :long_name


  def notify_by_default_str
    if notify_by_default == 1
      "Y"
    else
      "N"
    end
  end

end
