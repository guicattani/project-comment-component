module ApplicationHelper
  def current_user
    @current_user ||= User.find_by(name: "Dummy Persona 1")
  end
end
