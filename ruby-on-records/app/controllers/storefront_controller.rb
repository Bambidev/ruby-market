class StorefrontController < ApplicationController
  skip_before_action :require_login

  # GET /
  def index
    @disks = Disk.search(params[:q])
                  .by_state(params[:filter])
                  .by_format(params[:format])
  end
end
