class Stops < ActiveRecord::Base

  def start_date_string
    if start_date.nil?
      ""
    else
      start_date.strftime '%m/%d/%Y %H:%M'
    end
  end

  def start_date_string=(start_date_str)
    self.start_date = Time.parse(start_date_str)
  end



  def start_date_formated
    if start_date.nil?
      ""
    else
      start_date.strftime '%m/%d/%Y %H:%M'
    end
  end

  def direction_str
    case direction
      when 0: 'Northbound'
      when 1: 'Southbound'
      when 2: 'Eastbound'
      when 3: 'Westbound'
    end
  end

end
