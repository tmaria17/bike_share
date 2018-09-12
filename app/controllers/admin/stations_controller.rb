class Admin::StationsController < Admin::BaseController
before_action :set_station, only: [:destroy, :edit, :show, :update]
  def index
    @stations = Station.all
  end

  def show

  end

  def new
    @station = Station.new
    @admin = current_user.role
  end

  def create
    station = Station.create(station_params)
    redirect_to admin_station_path(station)
  end

  def edit
    @admin = current_user.role
  end

  def update
    @station.update(station_params)
    flash[:notice] = "Successfully updated!"
    redirect_to admin_station_path(@station)
  end

  def destroy
    @station.destroy
    redirect_to admin_stations_path, notice: "Successfully deleted."
  end

  private
  def station_params
    params.require(:station).permit(:name, :dock_count, :city, :installation_date)
  end

  def set_station
    @station = Station.find_by(slug: params[:slug])
  end

end
