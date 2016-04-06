require 'scarpin/version'
require 'ostruct'
require 'json'
require 'nokogiri'
require 'rest-client'
require 'nori'
require 'gyoku'

require 'scarpin/helpers'
require 'scarpin/api'
require 'scarpin/xml_entity'
require 'scarpin/trait/contains_computers'
require 'scarpin/trait/contains_devices'
require 'scarpin/trait/contains_groups'
require 'scarpin/trait/contains_hosts'
require 'scarpin/trait/contains_interfaces'
require 'scarpin/trait/contains_subnets'
require 'scarpin/resource/group'
require 'scarpin/resource/subnet'
require 'scarpin/resource/host'
require 'scarpin/resource/device'
require 'scarpin/resource/interface'
require 'scarpin/resource/config'
require 'scarpin/resource/view'

module Scarpin
  def self.configure(config_file = File.join(ENV['HOME'], '.scarpin.json'))
    configuration = JSON.parse(File.read(config_file))
    Api.new(configuration)
  end
end
