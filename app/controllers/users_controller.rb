class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  def index
    @users = User.all
  end

  def impersonate
    user = User.find(params[:id])
    impersonate_user(user)
    redirect_to root_path
  end

  def stop_impersonating
    stop_impersonating_user
    redirect_to root_path
  end

  private

  # Redirect if true user is not an admin
  def require_admin
    # Will not let you see admin tools when impersonating normal user
    # redirect_to root_path, notice: "Go away, you're no admin" unless current_user.admin?

    # Will let you see admin tools when impersonating normal user
    redirect_to root_path unless true_user.admin?
  end
end
