class UsersController < Clearance::UsersController
  before_filter :load_user, :only => [:edit, :update]

  def edit
    @page_title = 'Settings updating'
  end

  def update
    if @user.update_attributes(params[:user])
      flash.now[:notice] = 'Successfully updated'
      redirect_to root_path
    else
      render :action => 'edit'
    end
  end

  private

  def load_user
    @user = current_user
  end
end