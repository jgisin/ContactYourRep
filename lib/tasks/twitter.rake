task :twitter => :environment do
  client = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = "ejcTGGiCQipaCAbXOVw4N8l2G"
  config.consumer_secret     = "VbU3Sek76WxO7iPjTHn0qFWxqBF82uCjFSCwbDibK2b9McielF"
  config.access_token        = "871034498338750464-bhImnpWeWAM9yzVCWATrCKAkkTWQBvt"
  config.access_token_secret = "ymRlDYTNa5d37G5njdOhDV01POmM0IbOxW9NRmOtcjYF1"
 end


 topics = ["@ContactYourRep"]
 client.filter(track: topics.join(",")) do |object|
   persons = Locate.lookup(object.text.to_s)
   response = object.user.screen_name + " Your reps are "
   persons.each_with_index do |p,index|
     response += "@" + p["twitter"] + " "
   end
   client.update(response)
 end
end
