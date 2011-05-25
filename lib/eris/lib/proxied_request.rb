module Eris
  class ProxiedRequest
    def initialize(params)
      @url = params["url"]
      @body = params["body"]
    end

    def cmd_str
      query_params = @body.collect {|k,v| "#{k}=#{v}" }.join('&')

      "curl '#{@url}?#{query_params}'"
    end

    def execute
      `#{cmd_str}`
    end
  end
end