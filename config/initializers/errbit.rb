Airbrake.configure do |config|
  config.api_key = '8ad3590e2cf0ee535f8bf84fddb7d112'
  config.host    = 'errbit.hut.shefcompsci.org.uk'
  config.port    = 443
  config.secure  = config.port == 443
end
