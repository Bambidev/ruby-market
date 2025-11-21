class StorefrontController < ApplicationController

  # GET /
  def index
    @disks = Disk.all
    # Y alguna otra cosa
  end
end
