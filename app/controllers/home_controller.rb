class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token

  def letter

  end

  def index

  end

  def reps
    address = params[:address] + " " + params[:city] + " " + params[:state] + " " + params[:zip]
    @persons = Locate.lookup(address)
  end
end
