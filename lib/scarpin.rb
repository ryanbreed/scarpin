require 'scarpin/version'
require 'ostruct'
require 'json'
require 'nokogiri'
require 'rest-client'
require 'nori'
require 'gyoku'

require 'scarpin/helpers'
require 'scarpin/api'

module Scarpin
  def self.configure(config_file = File.join(ENV['HOME'], '.scarpin.json'))
    configuration = JSON.parse(File.read(config_file))
    Api.new(configuration)
  end
end
