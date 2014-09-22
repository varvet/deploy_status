require "deploy_status/version"
require 'sinatra'
require 'socket'

module DeployStatus
  class Server < Sinatra::Base


    get '/' do
      status = if File.exist?("public/version")
                 File.read("public/version").strip
               else
                 "ERROR: no version file found"
               end
      "#{status} | Served by Rails from #{Socket.gethostname}"
    end
  end
end
