class CodeController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :login_required
  def material
    limit = params[:limit].to_i
    start = params[:start].to_i
    search = []
    if params[:query].to_s != ""
      search.push( " (material_code::varchar like '%#{params[:query]}%'  or material_name::varchar like '%#{params[:query]}%' ) ")
    end
    if params[:id].to_s != ""
      search.push("id = '#{params[:id]}' ")
    end
    search = search.join(" and ")
    records = Material.find(:all, :conditions => search, :limit => limit,:order => "material_name asc")
    return_data = Hash.new()
    return_data[:success] = true
    return_data[:totalcount] = Material.find(:all, :conditions => search).count()
    return_data[:records]   = records.collect{|u| {
      :id => u.id,
      :material_name => " #{u.material_name} (#{u.material_code})".strip
    } }
    render :text => return_data.to_json, :layout => false
  end
  

  
end
