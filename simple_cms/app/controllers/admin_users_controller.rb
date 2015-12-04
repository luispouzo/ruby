class AdminUsersController < ApplicationController
  
  layout 'admin'
  before_action :confirm_logged_in

  # GET /admin_users
  # GET /admin_users.json
  def index
    @admin_users = AdminUser.sorted
    respond_to do |format|
      format.html
    end
  end

  # GET /admin_users/new
  def new
    @admin_user = AdminUser.new
  end

  # POST /admin_users
  # POST /admin_users.json
  def create
    @admin_user = AdminUser.new(admin_user_params)
    respond_to do |format|
      if @admin_user.save 
        format.html { 
          flash[:notice] = "User #{@admin_user.name} has been successfully created."
          redirect_to action: :index }
      else
        format.html { render :new }
      end
    end
  end

  # GET /subjects/1/edit
  def edit
    @admin_user = get_admin_user
  end

  # PATCH/PUT /admin_users/1
  # PATCH/PUT /admin_users/1.json
  def update
    @admin_user = get_admin_user
    respond_to do |format|
      if @admin_user.update(admin_user_params)
        format.html {
          flash[:notice] = "User #{@admin_user.name} has been successfully updated."
          redirect_to action: :index
        }
      else
        format.html {
          render :edit
        }
      end
    end
  end

  def delete
    @admin_user = get_admin_user
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    admin_user = get_admin_user.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "User '#{admin_user.name}' has been successfully destryed."
        redirect_to action: :index
      }
    end
  end

  private

    def admin_user_params
      params.require(:admin_user).permit(:first_name, :last_name, :email, :username, :password)
    end

    def get_admin_user
      AdminUser.find(params[:id])
    end
end
