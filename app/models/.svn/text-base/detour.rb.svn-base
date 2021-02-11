class Detour < ActiveRecord::Base
  has_many :notifications

  validates_presence_of :route, :description, :reason

  def start_date_formated
    if start_date.nil?
      ""
    else
      start_date.strftime '%m/%d/%Y'
    end
  end

  def end_date_formated
    if end_date.nil?
      ""
    else 
      end_date.strftime '%m/%d/%Y'
    end
  end

  def start_time_formated
    if start_time.nil?
      ""
    else
      start_time.strftime '%H:%M'
    end
  end

  def end_time_formated
    if end_time.nil?
      ""
    else
      end_time.strftime '%H:%M'
    end
  end

  def cancel_date_formated
    if cancel_date.nil?
      ""
    else
      cancel_date.strftime '%m/%d/%Y %H:%M'
    end
  end

  def detour_type_str
    case detour_type
      when 1: 'Unplanned - No Sched Chg'
      when 2: 'Planned - Sched Chg'
      when 3: 'Unplanned - Sched Chg'
      when 4: 'Planned - No Sched Chg'

      else 'Invalid Detour Type'
     
     end
  end

  def direction_str
    case direction
      when 0: 'Northbound'
      when 1: 'Southbound'
      when 2: 'Eastbound'
      when 3: 'Westbound'
      when 4: 'Both'
      when 5: 'All'
    end
  end

  def self.find_active_detours
    find(:all, :order => "Route", :conditions => "canceled is null")
  end

  def self.find_active_detours_by_date
    find(:all, :order => "start_date", :conditions => "canceled is null")
  end

  def self.find_inactive_detours
    find(:all, :order => "Route", :conditions => "canceled is not null")
  end

end
