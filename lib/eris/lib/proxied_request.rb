module Eris
  class ProxiedRequest
    def initialize(params)
      @url = params["url"]
      @body = params["body"]
    end

    def cmd_str
      query_params = @body.collect {|k,v| "#{URI.encode(k.to_s)}=#{URI.encode(v.to_s)}" }.join('&')
      "curl '#{@url}?#{query_params}'"
    end

    def execute
      `#{cmd_str}`
    end
  end
end