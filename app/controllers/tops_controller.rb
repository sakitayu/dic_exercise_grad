class TopsController < ApplicationController
  def index
    if user_signed_in?
      redirect_to users_path
    else
      @users = User.all
      @q = @users.ransack(params[:q])
      @users = @q.result(distinct: true)
    end
  end
end
