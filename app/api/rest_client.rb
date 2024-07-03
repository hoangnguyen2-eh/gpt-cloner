require 'net/http'
class RestClient
    def self.call_api(url, method, headers = {}, body = nil)
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = (uri.scheme == 'https')

        request = Net::HTTP.const_get(method.capitalize).new(uri.request_uri)
        headers.each { |key, value| request[key] = value }

        if body.present?
            request.body = body.to_json
        end

        response = http.request(request)
        response.body
    rescue StandardError => e
        Rails.logger.error("Error in RestClient: #{e.message}")
        nil
    end
end
