class UsersController < ApplicationController

  def new
    current_user = User.find(session[:user_id]) if session[:user_id]

    if current_user
        redirect_to buddies_path
    else
        @user = User.new
    end
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
  def index
    @users = User.all
  end
  def buddies
    current_user = User.find(session[:user_id]) if session[:user_id]

    if current_user
        @ribbit = Ribbit.new
        buddies_ids = current_user.followeds.map(&:id).push(current_user.id)
        @ribbits = Ribbit.where(id: buddies_ids)
    else
        redirect_to root_url
    end
  end
  private

  def user_params
    params.require(:user).permit(:avatar_url,:email,:name,:password,:password_confirmation,:username)
  end
end
