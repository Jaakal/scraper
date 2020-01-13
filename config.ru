$:.unshift File.expand_path("../", __FILE__)
require 'rubygems'
require 'sinatra'
require './application_controller'

AsyncTest.run!
