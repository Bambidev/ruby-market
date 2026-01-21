class Admin::SalesController < Admin::BaseController
  load_and_authorize_resource

  # GET /admin/sales
  def index
  end

  # GET /admin/sales/1
  def show
  end

  # GET /admin/sales/new
  def new
    @sale = Sale.new
  end

  # GET /admin/sales/1/edit
  def edit
  end

  # POST /admin/sales
  def create
    @sale = Sale.new(sale_params)

    respond_to do |format|
      if @sale.save
        format.html { redirect_to [ :admin, @sale ], notice: "Venta creada exitosamente." }
        format.json { render :show, status: :created, location: [ :admin, @sale ] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/sales/1
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to [ :admin, @sale ], notice: "Venta actualizada exitosamente.", status: :see_other }
        format.json { render :show, status: :ok, location: [ :admin, @sale ] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/sales/1
  def destroy
    @sale.destroy!

    respond_to do |format|
      format.html { redirect_to admin_sales_path, notice: "Venta eliminada exitosamente.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def sale_params
    params.expect(sale: [ :cancelled, :total ])
  end
end
