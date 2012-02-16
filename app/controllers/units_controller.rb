class UnitsController < ApplicationController
  set_tab :unit
  before_filter :login_required_admin
  def index
    @units = Unit.all
  end

  def show
    @unit = Unit.find(params[:id])
  end

  def new
    @unit = Unit.new
  end

  def create
    @unit = Unit.new(params[:unit])
    if @unit.save
      redirect_to @unit, :notice => "Successfully created unit."
    else
      render :action => 'new'
    end
  end

  def edit
    @unit = Unit.find(params[:id])
  end

  def update
    @unit = Unit.find(params[:id])
    if @unit.update_attributes(params[:unit])
      redirect_to @unit, :notice  => "Successfully updated unit."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @unit = Unit.find(params[:id])
    @unit.destroy
    redirect_to units_url, :notice => "Successfully destroyed unit."
  end
end
