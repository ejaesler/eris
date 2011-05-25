require 'rubygems'
require 'sinatra'
require 'erb'

module Eris
  class Server < Sinatra::Base

    JS_HELPER_PATH = File.dirname(__FILE__) + '../../../js_helpers/'

    def initialize(path)
      @path = path
      settings.views = path
      super
    end

    Tilt.register :erb, Tilt[:erubis]
    enable :raise_errors ###################################!!!
    disable :show_exceptions

    ['/', '/index.html'].each do |route|
      get route do
        app_info = JSON.parse(File.read(File.join(@path, 'appinfo.json')))

        locals = {
            :app_title => app_info["title"],
            :enyo_path => "enyo/0.10/framework/enyo.js",
            :eris_helper_tags => '<script src="eris-helpers/ErisHelpers.js" type="text/javascript" eris-helpers=true></script>',
            :app_helper_tags => nil
        }

        app_helpers = File.join('spec', 'helpers', 'AppHelpers.js')

        if File.exist? File.join(@path, app_helpers)
          locals[:app_helper_tags] = %Q{<script src="#{app_helpers}" type="text/javascript" app-helpers=true></script>}
        end

        erb :'index.html', :locals => locals
      end
    end

    get '/luna*' do
      luna_request = LunaRequest.new(JSON.parse(params[:req]))
      luna_request.execute
    end

    get '/xhr/*' do
      # ProxiedXhrRequest
    end

    get '/eris-helpers/*' do
      serve_static_files_from(JS_HELPER_PATH, params[:splat].first)
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