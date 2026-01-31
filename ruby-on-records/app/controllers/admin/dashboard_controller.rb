class Admin::DashboardController < Admin::BaseController
  authorize_resource class: false
  skip_before_action :set_collection

  def index
    @total_disks = Disk.count
    @total_sales = Sale.count
    @total_clients = Client.count
    @total_users = User.count
    @recent_disks = Disk.order(created_at: :desc).limit(5)
  end
end
