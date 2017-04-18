require_relative "thermos.rb"
require_relative "httpsvalue.rb"
require_relative "logger.rb"
require_relative "status.rb"
require "OpenSSL"
require 'json'

logger = Logger.new()
status = Status.new()


#Get a termperature from the console arguments
nest = Thermos.new(ARGV[0].to_f, ARGV[1].to_f)
nest.set_temperature(ARGV[2].to_f)
status.get_status(nest)
logger.log_event(nest)


#Get a temperature from the internet
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE #Bypass the SSL certificate problem, but gives a warning :(
httpsvalue = Httpsvalue.new
nest.set_temperature(httpsvalue.get_value("https://labict.be/software-engineering/temperature/api/temperature/fake").to_f)
status.get_status(nest)
logger.log_event(nest)


#Get a temperature from a Json file
nest.set_temperature(JSON.parse(File.read('test.json'))["temperature"].to_f)
status.get_status(nest)
logger.log_event(nest)
