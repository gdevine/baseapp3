class UsersController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource
  
  def index   
  end

  def show
  end
  
  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:link] = "User Updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  
  private
    def user_params
      if current_user.role == 'admin'
        params.require(:user).permit(:approved, :role)
      end
    end   
 
  
end
