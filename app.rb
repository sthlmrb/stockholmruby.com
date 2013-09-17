require "rubygems"
require "bundler"
Bundler.require :default, (ENV["RACK_ENV"] || "development").to_sym

get "/" do
  "Hallå Stockholm hur är läget?!"
end
