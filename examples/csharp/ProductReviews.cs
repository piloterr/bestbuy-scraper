// Best Buy Reviews API – C# example (.NET 6+, top-level statements)
// Usage: dotnet new console -n Piloterr && copy this file to Program.cs
//        PILOTERR_API_KEY=your-key dotnet run
using System.Text.Json;

var apiKey = Environment.GetEnvironmentVariable("PILOTERR_API_KEY")
    ?? throw new InvalidOperationException("Set PILOTERR_API_KEY");

using var http = new HttpClient { Timeout = TimeSpan.FromSeconds(120) };
http.DefaultRequestHeaders.Add("x-api-key", apiKey);

var query =
    "query=" + Uri.EscapeDataString("https://www.bestbuy.com/product/google-nest-doorbell-wired-3rd-gen-latest-model-2k-video-and-gemini-hazel/J39TC8J8W5/sku/12104931/reviews");

var response = await http.GetAsync("https://api.piloterr.com/v2/bestbuy/product/reviews?" + query);
var body = await response.Content.ReadAsStringAsync();
if (!response.IsSuccessStatusCode)
{
    Console.Error.WriteLine($"Piloterr error {(int)response.StatusCode}: {body}");
    return;
}

using var doc = JsonDocument.Parse(body);
Console.WriteLine(JsonSerializer.Serialize(doc, new JsonSerializerOptions { WriteIndented = true }));
