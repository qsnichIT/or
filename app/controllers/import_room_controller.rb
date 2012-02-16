class ImportRoomController < ApplicationController
  set_tab :import_room
  before_filter :login_required
  def index
    search = []
    if params[:search].to_s != ""
      search.push(" ( material_code::varchar like '%#{params[:search]}%' or material_name::varchar like '%#{params[:search]}%') ")
    end
    if @current_user.admin != '1'
      search.push(" room_id = #{@current_user.room_id} ")
    end
    @import_rooms = MaterialRoom.joins(:material).find(:all,:conditions => search.join(" and "))
  end

  def show
    @import_room = MaterialRoom.find(params[:id])
  end

  def edit
    @import_room = MaterialRoom.find(params[:id])
  end

  def update
    @import_room = MaterialRoom.find(params[:id])
    if params[:room][:room_id].to_s.strip == ""  or params[:material_room][:amount].to_s.strip == ""
      redirect_to  edit_import_room_url(@import_room), :notice  => "กรุณากรอกข้อมูลให้ครบ"  
    else
        MaterialRoom.transaction do
          #ของเจ้าของห้อง
          @import_room.amount =  @import_room.amount - params[:material_room][:amount].to_i
          @import_room.user_id = params[:material_room][:user_id]
          @import_room.save!
          #ของห้องปลายทาง
          rs_room2_cn = MaterialRoom.count(:all,:conditions => "room_id = #{params[:room][:room_id]} and material_id = #{@import_room.material_id}")
          if rs_room2_cn == 0
            rs_room2_new = MaterialRoom.new
            rs_room2_new.material_id = @import_room.material_id
            rs_room2_new.room_id = params[:room][:room_id].to_i
            rs_room2_new.amount = params[:material_room][:amount].to_i
            rs_room2_new.user_id = params[:material_room][:user_id]
            rs_room2_new.save!
          else
            rs_room2_update = MaterialRoom.find(:all,:conditions => "room_id = #{params[:room][:room_id]} and material_id = #{@import_room.material_id}")[0]
            rs_room2_update.amount += params[:material_room][:amount].to_i
            rs_room2_update.user_id = params[:material_room][:user_id]
            rs_room2_update.save!
          end
          #ประวัติเจ้าของห้อง
          rs_his_owner = MaterialHistory.new
          rs_his_owner.material_id = @import_room.material_id
          rs_his_owner.amount = params[:material_room][:amount].to_i
          rs_his_owner.type = 'export'
          rs_his_owner.room_id  = @import_room.room_id
          rs_his_owner.user_id = params[:material_room][:user_id]
          rs_his_owner.save!
          #ประวัติปลายทาง
          rs_his_owner = MaterialHistory.new
          rs_his_owner.material_id = @import_room.material_id
          rs_his_owner.amount = params[:material_room][:amount].to_i
          rs_his_owner.type = 'import'
          rs_his_owner.room_id  = params[:room][:room_id].to_i
          rs_his_owner.user_id = params[:material_room][:user_id]
          rs_his_owner.save!
        end
        redirect_to  import_room_url(@import_room), :notice  => "Successfully updated import room." 
    end
  end
end
