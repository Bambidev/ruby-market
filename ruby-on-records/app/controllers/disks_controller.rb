class DisksController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]
  before_action :set_disk, only: [:show]

  # GET /disks
  def index
    @disks = Disk.includes(:genres).in_stock.order(created_at: :desc)
    
    # Filtro por búsqueda de texto
    if params[:q].present?
      @disks = @disks.search(params[:q])
    end
    
    # Filtro por género
    if params[:genre_id].present?
      @disks = @disks.joins(:genres).where(genres: { id: params[:genre_id] })
    end
    
    # Filtro por formato
    if params[:format_filter].present?
      @disks = @disks.where(format: params[:format_filter])
    end
    
    # Filtro por estado (nuevo/usado)
    if params[:state].present?
      @disks = @disks.where(state: params[:state])
    end
    
    # Filtro por año
    if params[:year].present?
      @disks = @disks.where(year: params[:year])
    end
    
    @disks = @disks.page(params[:page]).per(12)
    @genres = Genre.order(:genre_name)
    @years = Disk.distinct.order(year: :desc).pluck(:year)
  end

  # GET /disks/1
  # GET /disks/1
  def show
    @related_disks = Disk.joins(:genres)
                         .where(genres: { id: @disk.genre_ids })
                         .where.not(id: @disk.id)
                         .distinct
                         .limit(5)
  end

  private

  def set_disk
    @disk = Disk.find(params[:id])
  end
end
