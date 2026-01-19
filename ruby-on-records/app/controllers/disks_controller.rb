class DisksController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  # GET /disks
  def index
    @disks = if params[:filter] == "new"
      Disk.where(state: "Nuevo")
    elsif params[:filter] == "used"
      Disk.where(state: "Usado")
    else
      Disk.all
    end
  end

  # GET /disks/1
  def show
    @disk = Disk.find(params[:id])
  end
end
