require 'rubygems'
require 'sinatra'
require 'erb'
require 'json'

module Eris
  class Server < Sinatra::Base
    JS_HELPER_PATH = File.dirname(__FILE__) + '/../../../js_helpers/'

    def initialize(path=Dir.pwd)
      @path = path
      settings.views = path
      super
    end

    Tilt.register :erb, Tilt[:erubis]
    enable :raise_errors
    disable :show_exceptions

    ['/', '/index.html'].each do |route|
      get route do
        app_info = JSON.parse(File.read(File.join(@path, 'appinfo.json')))

        locals = {
            :app_title => app_info["title"],
            :eris_helper_tags => '<script src="eris-helpers/ErisHelpers.js" type="text/javascript" eris-helpers=true></script>',
            :app_helper_tag => nil,
            :launch_params => params['launchParams']
        }

        app_helper = File.join('spec', 'acceptance', 'helpers', 'AppHelper.js')
        if File.exist?(File.join(@path, app_helper))
          locals[:app_helper_tag] = %Q{<script src="#{app_helper}" type="text/javascript" app-helper=true></script>}
        end
        
        erb :'index.html', :locals => locals
      end
    end

    get '/luna*' do
      req = JSON.parse(params[:req])
      if req["url"] =~ /getCurrentPosition/
        '{"altitude":-10000000,"errorCode":0,"heading":0,"horizAccuracy":-1,"latitude":37.392809,"longitude":-122.040461,"returnValue":true,"timestamp":1307557148000,"velocity":-1,"vertAccuracy":-1}'
      else
        LunaRequest.new(req).execute
      end
    end

    get '/xhrproxy*' do
      response, status_code = ProxiedRequest.new(JSON.parse(params[:req])).execute
      status status_code
      response
    end

    get '/eris-helpers/*' do
      serve_static_files_from(JS_HELPER_PATH, params[:splat].first)
    end

    get '/usr/palm/frameworks/*' do
      config = ErisConfig.new(:config_path => File.join(@path, 'eris_config.json'), :app_root => @path)
      serve_static_files_from(config.enyo_root, params[:splat].first)
    end

    get '*' do
      serve_static_files_from(@path, params[:splat].first)
    end

    def serve_static_files_from(path, filename)
      path_to_static_file = File.expand_path(path + unescape(filename))

      env['sinatra.static_file'] = path_to_static_file
      send_file path_to_static_file, :disposition => nil
    end
  end
end