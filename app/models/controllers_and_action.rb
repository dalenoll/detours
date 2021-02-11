class ControllersAndAction < ActiveRecord::Base
  validates_presence_of :name, :controller, :action
  validate :name_controller_action_must_be_unique
protected
  def name_controller_action_must_be_unique

    if ca = ControllersAndAction.find_by_name(name)
      errors.add(:name, 'Name not unique') if ca.id != id
    end
    if ca = ControllersAndAction.find_by_controller_and_action(controller, action)
      errors.add(:controller, ': Controller and Action combination must be unique') if ca.id != id
      errors.add(:action, ': Controller and Action combination must be unique') if ca.id != id
    end 

  end
end
