class UsersController < ApplicationController

  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
   
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Thank you for signing up for Ribbit!"
    else
      render 'new'
    end
  end

  def show
    current_user = User.find(session[:user_id]) if session[:user_id]
    @user = User.find(params[:id])
    @ribbit = Ribbit.new
    @relationship = Relationship.where(
    follower_id: current_user.id,
    followed_id: @user.id
).first_or_initialize if current_user
  end

  private

  def user_params
    params.require(:user).permit(:avatar_url,:email,:name,:password,:password_confirmation,:username)
  end
end
