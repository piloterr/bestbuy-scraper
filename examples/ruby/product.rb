# Best Buy Product API – Ruby example (stdlib only)
# Usage: PILOTERR_API_KEY=your-key ruby product.rb
require "json"
require "net/http"
require "uri"

uri = URI("https://api.piloterr.com/v2/bestbuy/product")
uri.query = URI.encode_www_form('query' => 'https://www.bestbuy.com/product/gigabyte-aero-x16-copilot-pc-165hz-wqxga-rtx-5070-ryzen-ai-7-350-1tb-ssd-16gb-ddr5-windows-11-lunar-white/J3GWPQC2RQ')

request = Net::HTTP::Get.new(uri)
request["x-api-key"] = ENV.fetch("PILOTERR_API_KEY")

response = Net::HTTP.start(uri.host, uri.port, use_ssl: true, read_timeout: 60) do |http|
  http.request(request)
end

abort "Piloterr error #{response.code}: #{response.body}" unless response.is_a?(Net::HTTPSuccess)

puts JSON.pretty_generate(JSON.parse(response.body))
