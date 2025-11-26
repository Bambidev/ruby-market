class Admin::ItemsController < Admin::BaseController
  before_action :set_item, only: %i[ show edit update destroy ]

  # GET /admin/items
  def index
    @items = Item.all
  end

  # GET /admin/items/1
  def show
  end

  # GET /admin/items/new
  def new
    @item = Item.new
  end

  # GET /admin/items/1/edit
  def edit
  end

  # POST /admin/items
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to [:admin, @item], notice: "Item creado exitosamente." }
        format.json { render :show, status: :created, location: [:admin, @item] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/items/1
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to [:admin, @item], notice: "Item actualizado exitosamente.", status: :see_other }
        format.json { render :show, status: :ok, location: [:admin, @item] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/items/1
  def destroy
    @item.destroy!

    respond_to do |format|
      format.html { redirect_to admin_items_path, notice: "Item eliminado exitosamente.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_item
      @item = Item.find(params.expect(:id))
    end

    def item_params
      params.expect(item: [ :amount ])
    end
end
