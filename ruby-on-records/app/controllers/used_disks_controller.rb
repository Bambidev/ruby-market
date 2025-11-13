class UsedDisksController < ApplicationController
  before_action :set_used_disk, only: %i[ show edit update destroy ]

  # GET /used_disks or /used_disks.json
  def index
    @used_disks = UsedDisk.all
  end

  # GET /used_disks/1 or /used_disks/1.json
  def show
  end

  # GET /used_disks/new
  def new
    @used_disk = UsedDisk.new
  end

  # GET /used_disks/1/edit
  def edit
  end

  # POST /used_disks or /used_disks.json
  def create
    @used_disk = UsedDisk.new(used_disk_params)

    respond_to do |format|
      if @used_disk.save
        format.html { redirect_to @used_disk, notice: "Used disk was successfully created." }
        format.json { render :show, status: :created, location: @used_disk }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @used_disk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /used_disks/1 or /used_disks/1.json
  def update
    respond_to do |format|
      if @used_disk.update(used_disk_params)
        format.html { redirect_to @used_disk, notice: "Used disk was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @used_disk }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @used_disk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /used_disks/1 or /used_disks/1.json
  def destroy
    @used_disk.destroy!

    respond_to do |format|
      format.html { redirect_to used_disks_path, notice: "Used disk was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_used_disk
      @used_disk = UsedDisk.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def used_disk_params
      params.fetch(:used_disk, {})
    end
end
