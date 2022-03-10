class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: username = ENV["ADMIN_USERNAME"], password: password = ENV["ADMIN_PASSWORD"]
  def show
  end
end
