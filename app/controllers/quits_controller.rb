class QuitsController < ApplicationController
  def new
    @user = User.find params[:user_id]
    @quit = @user.quits.build
    if current_user.id != @quit.user_id
      flash[:alert] = "Can't create/edit a quit for another person!"
      redirect_to root_path
    end
  end

  def create
    @quit = Quit.new quit_params
    @quit.user_id = params[:user_id]
    if @quit.save
      flash[:success] = 'Created!'
      redirect_to @quit.user
    else
      flash[:error] = 'Oh no'
      render 'new'
    end
  end

  def edit
    @user = User.find params[:user_id]
    @quit = Quit.find params[:id]
    if current_user.id != @quit.user_id
      flash[:alert] = "Can't create/edit a quit for another person!"
      redirect_to root_path
    end
  end

  def update
    @quit = Quit.find params[:id]
    if @quit.update quit_params
      flash[:success] = 'Updated!'
      redirect_to @quit.user
    else
      render 'edit'
    end
  end

  private

  def quit_params
    params.require(:quit).permit(:text)
  end
end