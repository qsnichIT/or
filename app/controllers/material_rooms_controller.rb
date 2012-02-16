class MaterialRoomsController < ApplicationController
  set_tab :material_room
  before_filter :login_required
  def index
    if @current_user.admin == '1'
      @material_rooms = MaterialRoom.all
    else
      @material_rooms = MaterialRoom.find(:all,:conditions => "room_id = #{@current_user.room_id}")
    end
  end

  def show
    @material_room = MaterialRoom.find(params[:id])
  end

  def new
    @material_room = MaterialRoom.new
  end

  def create
    cn = MaterialRoom.find(:all,:conditions => "room_id::varchar = '#{params[:material_room][:room_id]}' and material_id::varchar = '#{params[:material_room][:material_id]}' ").count
    if cn == 0
      @material_room = MaterialRoom.new(params[:material_room])
      if @material_room.save
        
        
        rs_his_owner = MaterialHistory.new
        rs_his_owner.material_id = @material_room.material_id
        rs_his_owner.amount = params[:material_room][:amount].to_i
        rs_his_owner.type = 'import'
        rs_his_owner.room_id  = @material_room.room_id
        rs_his_owner.user_id = params[:material_room][:user_id]
        rs_his_owner.flag = 1
        rs_his_owner.save!        
        
        redirect_to @material_room, :notice => "Successfully created material room."
      else
        render :action => 'new'
      end
    else
      @material_room = MaterialRoom.find(:all,:conditions => "room_id::varchar = '#{params[:material_room][:room_id]}' and material_id::varchar = '#{params[:material_room][:material_id]}' ")[0]
      @material_room.amount += params[:material_room][:amount].to_i
      if @material_room.save
        
        
        
        rs_his_owner = MaterialHistory.new
        rs_his_owner.material_id = @material_room.material_id
        rs_his_owner.amount = params[:material_room][:amount].to_i
        rs_his_owner.type = 'import'
        rs_his_owner.room_id  = @material_room.room_id
        rs_his_owner.user_id = params[:material_room][:user_id]
        rs_his_owner.flag = 1
        rs_his_owner.save!             
        
        
        redirect_to @material_room, :notice => "Successfully created material room."
      else
        render :action => 'new'
      end      
    end
  end


end
