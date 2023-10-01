class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin_role
  
    def dashboard
      @users = User.all
    end
  
    def ban_user
      user = User.find(params[:id])
      user.lock_access!
      render json: "User #{user.email} has been banned."
    end
  
    def unban_user
      user = User.find(params[:id])
      user.unlock_access!
      render json: "User #{user.email} has been unbanned."
    end
  
  
    private
  
    def check_admin_role
      render json: { error: "Access denied." } unless current_user.admin?
    end
  
end
