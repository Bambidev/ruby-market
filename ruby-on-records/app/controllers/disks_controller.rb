class DisksController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  # GET /disks
  def index
    @disks = Disk.by_state(params[:filter])
  end

  # GET /disks/1
  def show
    @disk = Disk.find(params[:id])
  end
end
