// Best Buy Reviews API – Node.js example (Node 18+, native fetch, ES module)
// Usage: PILOTERR_API_KEY=your-key node product_reviews.mjs

const params = new URLSearchParams({
  "query": "https://www.bestbuy.com/product/google-nest-doorbell-wired-3rd-gen-latest-model-2k-video-and-gemini-hazel/J39TC8J8W5/sku/12104931/reviews",
});

const response = await fetch(`https://api.piloterr.com/v2/bestbuy/product/reviews?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY },
  signal: AbortSignal.timeout(120_000),
});

if (!response.ok) {
  console.error(`Piloterr error ${response.status}: ${await response.text()}`);
  process.exit(1);
}

console.log(JSON.stringify(await response.json(), null, 2));
