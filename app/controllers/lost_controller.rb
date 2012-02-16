class LostController < ApplicationController
  set_tab :lost
  before_filter :login_required
  def index
    search = []
    if params[:search].to_s != ""
      search.push(" ( material_code::varchar like '%#{params[:search]}%' or material_name::varchar like '%#{params[:search]}%') ")
    end
    if @current_user.admin != '1'
      search.push(" room_id = #{@current_user.room_id} ")
    end
    @losts = MaterialRoom.joins(:material).find(:all,:conditions => search.join(" and "))
  end

  def show
    @lost = MaterialRoom.find(params[:id])
  end

  def edit
    @lost = MaterialRoom.find(params[:id])
  end

  def update
    @lost = MaterialRoom.find(params[:id])
    if params[:lost].to_s.strip == ""  or params[:material_room][:amount].to_s.strip == ""
      redirect_to  edit_lost_url(@lost), :notice  => "กรุณากรอกข้อมูลให้ครบ"  
    else
        MaterialRoom.transaction do
          #ของเจ้าของห้อง
          @lost.amount =  @lost.amount - params[:material_room][:amount].to_i
          @lost.user_id = params[:material_room][:user_id]
          @lost.save!
          #ประวัติเจ้าของห้อง
          rs_his_owner = MaterialHistory.new
          rs_his_owner.material_id = @lost.material_id
          rs_his_owner.amount = params[:material_room][:amount].to_i
          rs_his_owner.type = 'export'
          rs_his_owner.room_id  = @lost.room_id
          rs_his_owner.user_id = params[:material_room][:user_id]
          rs_his_owner.save!
          #ประวัติปลายทาง
          rs_his_owner = MaterialHistory.new
          rs_his_owner.material_id = @lost.material_id
          rs_his_owner.amount = params[:material_room][:amount].to_i
          rs_his_owner.type = params[:lost]
          rs_his_owner.room_id  = @lost.room_id
          rs_his_owner.user_id = params[:material_room][:user_id]
          rs_his_owner.save!
        end
        redirect_to  lost_url(@lost), :notice  => "Successfully updated import room." 
    end
  end 
end
