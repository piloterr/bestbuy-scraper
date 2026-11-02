# Best Buy Reviews API – Ruby example (stdlib only)
# Usage: PILOTERR_API_KEY=your-key ruby product_reviews.rb
require "json"
require "net/http"
require "uri"

uri = URI("https://api.piloterr.com/v2/bestbuy/product/reviews")
uri.query = URI.encode_www_form('query' => 'https://www.bestbuy.com/product/google-nest-doorbell-wired-3rd-gen-latest-model-2k-video-and-gemini-hazel/J39TC8J8W5/sku/12104931/reviews')

request = Net::HTTP::Get.new(uri)
request["x-api-key"] = ENV.fetch("PILOTERR_API_KEY")

response = Net::HTTP.start(uri.host, uri.port, use_ssl: true, read_timeout: 60) do |http|
  http.request(request)
end

abort "Piloterr error #{response.code}: #{response.body}" unless response.is_a?(Net::HTTPSuccess)

puts JSON.pretty_generate(JSON.parse(response.body))
