class DisposeController < ApplicationController
  set_tab :dispose
  before_filter :login_required
  def index
    search = []
    if params[:search].to_s != ""
      search.push(" ( material_code::varchar like '%#{params[:search]}%' or material_name::varchar like '%#{params[:search]}%') ")
    end
    if @current_user.admin != '1'
      search.push(" room_id = #{@current_user.room_id} ")
    end
    @disposes = MaterialRoom.joins(:material).find(:all,:conditions => search.join(" and "))
  end

  def show
    @dispose = MaterialRoom.find(params[:id])
  end

  def edit
    @dispose = MaterialRoom.find(params[:id])
  end

  def update
    @dispose = MaterialRoom.find(params[:id])
    if params[:hn].to_s.strip == ""  or params[:material_room][:amount].to_s.strip == ""
      redirect_to  edit_dispose_url(@dispose), :notice  => "กรุณากรอกข้อมูลให้ครบ"  
    else
        MaterialRoom.transaction do
          #ของเจ้าของห้อง
          @dispose.amount =  @dispose.amount - params[:material_room][:amount].to_i
          @dispose.user_id = params[:material_room][:user_id]
          @dispose.save!
          #ประวัติเจ้าของห้อง
          rs_his_owner = MaterialHistory.new
          rs_his_owner.material_id = @dispose.material_id
          rs_his_owner.amount = params[:material_room][:amount].to_i
          rs_his_owner.type = 'export'
          rs_his_owner.room_id  = @dispose.room_id
          rs_his_owner.user_id = params[:material_room][:user_id]
          rs_his_owner.save!
          #ประวัติปลายทาง
          rs_his_owner = MaterialHistory.new
          rs_his_owner.material_id = @dispose.material_id
          rs_his_owner.amount = params[:material_room][:amount].to_i
          rs_his_owner.type = 'dispose'
          rs_his_owner.hn  = params[:hn]
          rs_his_owner.user_id = params[:material_room][:user_id]
          rs_his_owner.save!
        end
        redirect_to  dispose_url(@dispose), :notice  => "Successfully updated import room." 
    end
  end  
end
