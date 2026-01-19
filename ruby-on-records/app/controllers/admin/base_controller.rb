class Admin::BaseController < ApplicationController
  before_action :require_login
  layout "admin"
end
