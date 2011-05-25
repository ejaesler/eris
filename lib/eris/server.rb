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
        erb(:'index.html')
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