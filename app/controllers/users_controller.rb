class UsersController < ApplicationController
  set_tab :user
  before_filter :login_required_admin#, :except => [:new, :create]
  #layout "sessions"
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_path
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to users_path
    else
      render :action => 'edit'
    end
  end
  
  def index
    @users = User.find(:all,:order => :id)
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url, :notice => "ลบผู้ใช้งานเสร็จเรียบร้อย"
  end  
end
