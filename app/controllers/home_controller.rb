class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token

  def letter

  end

  def index

  end

  def reps
    address = params[:address]
    @persons = Locate.lookup(address)
    if @persons.nil?
      flash[:notice] = "Invalid Address or Zip Code"
      redirect_to root_path
    end
  end
end
