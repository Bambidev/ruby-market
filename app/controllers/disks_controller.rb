class DisksController < ApplicationController
  before_action :set_disk, only: %i[ show edit update destroy ]

  # GET /disks or /disks.json
  def index
    @disks = Disk.all
  end

  # GET /disks/1 or /disks/1.json
  def show
  end

  # GET /disks/new
  def new
    @disk = Disk.new
  end

  # GET /disks/1/edit
  def edit
  end

  # POST /disks or /disks.json
  def create
    @disk = Disk.new(disk_params)

    respond_to do |format|
      if @disk.save
        format.html { redirect_to @disk, notice: "Disk was successfully created." }
        format.json { render :show, status: :created, location: @disk }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @disk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disks/1 or /disks/1.json
  def update
    respond_to do |format|
      if @disk.update(disk_params)
        format.html { redirect_to @disk, notice: "Disk was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @disk }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @disk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disks/1 or /disks/1.json
  def destroy
    @disk.destroy!

    respond_to do |format|
      format.html { redirect_to disks_path, notice: "Disk was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disk
      @disk = Disk.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def disk_params
      params.expect(disk: [ :title, :artist, :year, :description, :price, :stock, :format, :state ])
    end
end
