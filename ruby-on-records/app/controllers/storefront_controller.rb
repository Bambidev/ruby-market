class StorefrontController < ApplicationController
  skip_before_action :require_login

  # GET /
  def index
    @disks = Disk.all
    # Y alguna otra cosa
  end
end
