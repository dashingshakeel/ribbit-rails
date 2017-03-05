class RibbitsController < ApplicationController
  def create
    current_user = User.find(session[:user_id]) if session[:user_id]
    @ribbit = Ribbit.new(params_ribbits)
    @ribbit.user_id = current_user.id 

    if @ribbit.save
      redirect_to current_user
    else
      flash[:eoor] = "problem!"
      redirect_to current_user
    end
  end

  private 
  def params_ribbits
    params.require(:ribbit).permit(:user_id,:content)
    
  end
end
