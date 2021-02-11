class Notification < ActiveRecord::Base
  belongs_to :detours
  belongs_to :location

  def last_attempt_formated
    if last_attempt.nil?
      "Never"
    else
      last_attempt.strftime '%m/%d/%Y %H:%M'
    end
  end

  def acknowledged_at_formated
    if acknowledged_at.nil?
      "Never"
    else
      acknowledged_at.strftime '%m/%d/%Y %H:%M'
    end
  end

  def delivered_str
    if delivered.nil? or delivered == 0
      "No"
    else
      "Yes"
    end
  end
end
