require 'json'

module Eris
  class LunaRequest

    attr_reader :service

    def initialize(options)
      @service = options["url"]
      @body = JSON.generate(options["body"])
    end

    def params
      param_str = @body.dup
      param_str.gsub!('\\n') { '\\\\\\n' } # Yes, this escapes NEWLINES (block form needed)
      param_str.gsub!(' ', '\\ ') # escape spaces
      param_str.gsub!(/'/) { %q('\\\\\'') } # escape single quotes (block form needed)
      param_str
    end

    def cmd_str
      "novacom run file://usr/bin/luna-send -- -n 1 -a com.palm.configurator -i #{@service} '#{params}'"
    end

    def execute
      @luna_response = `#{cmd_str}`
#    log_request
      log_bad_json
      @luna_response
    end

    def log_request
      puts "\n\n====> BODY PARAMS <===="
      pp @body
      puts "\n\n====> NOVACOM REQUEST <===="
      puts "Sending #{cmd_str}"
      puts "\n\n====> NOVACOM RESPONSE <===="
      puts @luna_response
    end

    def log_bad_json
      begin
        JSON.parse(@luna_response)
      rescue
        puts "BAD JSON FROM LUNA"
        puts "Request: #{cmd_str}"
        puts "Respose: #{@luna_response}"
      end
    end
  end
end