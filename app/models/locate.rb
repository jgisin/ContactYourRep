class Locate
  def self.lookup(address)
offices = Array.new
@persons = Array.new
officials = Array.new
puts "address: " + address
@response = HTTParty.get("https://www.googleapis.com/civicinfo/v2/representatives?key=" + ENV["GOOGLE_API_KEY"] + "&levels=country&levels=administrativeArea1&address=" + address)
if !@response["offices"].nil?
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
return @persons
end
return ""
end
end
