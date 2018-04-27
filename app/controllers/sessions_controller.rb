class SessionsController < Devise::SessionsController
  def new
    @hide_nav_access = true
    super
  end
end
