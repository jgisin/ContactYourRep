task :twitter => :environment do
  client = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = "ejcTGGiCQipaCAbXOVw4N8l2G"
  config.consumer_secret     = "VbU3Sek76WxO7iPjTHn0qFWxqBF82uCjFSCwbDibK2b9McielF"
  config.access_token        = "871034498338750464-bhImnpWeWAM9yzVCWATrCKAkkTWQBvt"
  config.access_token_secret = "ymRlDYTNa5d37G5njdOhDV01POmM0IbOxW9NRmOtcjYF1"
end

client2 = Twitter::REST::Client.new do |config|
  config.consumer_key        = "ejcTGGiCQipaCAbXOVw4N8l2G"
  config.consumer_secret     = "VbU3Sek76WxO7iPjTHn0qFWxqBF82uCjFSCwbDibK2b9McielF"
  config.access_token        = "871034498338750464-bhImnpWeWAM9yzVCWATrCKAkkTWQBvt"
  config.access_token_secret = "ymRlDYTNa5d37G5njdOhDV01POmM0IbOxW9NRmOtcjYF1"
end


 topic = "ContactYourRep"
 client.filter(track: topic) do |object|
   puts object.name.to_s + " says " + object.text.to_s
   persons = Locate.lookup(object.text.to_s)
   response = object.user.screen_name.to_s + " Your reps are "
   persons.each_with_index do |p,index|
     response += "@" + p["twitter"] + " "
   end
   puts response
   client2.update(response)
 end
end
