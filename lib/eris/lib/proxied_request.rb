module Eris
  class ProxiedRequest
    def initialize(params)
      @url = params["url"]
      @body = params["body"]
    end

    def url
      query_params = @body.collect {|k,v| "#{URI.encode(k.to_s)}=#{URI.encode(v.to_s)}" }.join('&')
      "#{@url}?#{query_params}"
    end

    def execute
      response  = Curl::Easy.perform(url)
      [response.body_str, response.response_code]
    end
  end
end