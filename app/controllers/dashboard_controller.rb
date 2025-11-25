class DashboardController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'
  def index
     @total_user = User.all
  end
end
