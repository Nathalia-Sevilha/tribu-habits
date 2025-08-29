module ApplicationHelper

  def active_class_by_controller(controller_name)
    "active" if controller_name == controller_name_from_request
  end

  private

  def controller_name_from_request
    controller.controller_name
  end
end
