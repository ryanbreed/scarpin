$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'
ENV.delete('https_proxy') if ENV.key?('https_proxy')
ENV.delete('http_proxy') if ENV.key?('http_proxy')
SimpleCov.start
require 'scarpin'
