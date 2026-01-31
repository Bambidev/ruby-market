class Admin::BaseController < ApplicationController
  before_action :require_login
  before_action :set_collection, only: [ :index ]
  layout "admin"

  private

  def set_collection
    model_class = controller_name.classify.constantize
    instance_variable_set("@#{controller_name}", model_class.all)
  end
end
