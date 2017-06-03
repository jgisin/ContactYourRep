class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token

  def letter

  end

  def index

  end

  def reps
    address = params[:address] + " " + params[:city] + " " + params[:state] + " " + params[:zip]
    offices = Array.new
    @persons = Array.new
    officials = Array.new
    @response = HTTParty.get("https://www.googleapis.com/civicinfo/v2/representatives?key=" + ENV["GOOGLE_API_KEY"] + "&levels=country&levels=administrativeArea1&address=" + address)
    @response["offices"].each do |off|
      offices << off
    end
    @response["officials"].each do |offic|
      officials << offic
    end
    offices.each do |o|
      o["officialIndices"].each do |i,ind|
        person = Hash.new
        person["office"] = o["name"]
        person["name"] = officials[i]["name"]
        person["address"] = officials[i]["address"]
        person["photo"] = officials[i]["photoUrl"]
        person["party"] = officials[i]["party"]
        person["phone"] = officials[i]["phones"][0]
        officials[i]["channels"].each do |chan|
           if chan["type"] == "Twitter"
            person["twitter"] = chan["id"]
          end
        end
        @persons << person
      end
    end
  end
end
