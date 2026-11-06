<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="Best Buy Scraper API by Piloterr – scrape Best Buy data as JSON" width="100%"></a>
</p>

# Best Buy Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr Best Buy Scraper API** lets you extract public data from Best Buy as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **Best Buy Product API** — Get a Best Buy US or Canada product page: title, price, brand, stock, images, categories and specs via browser rendering.
- **Best Buy Reviews API** — Get customer reviews for a Best Buy product URL: rating, review text, author, photos and pagination.
- **Best Buy Search API** — Search Best Buy US or Canada by keyword or search URL.

Use it for price monitoring, assortment tracking, competitor analysis, product research or catalog enrichment.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [Best Buy Product API](#best-buy-product-api) | `/v2/bestbuy/product` | 2 | Get a Best Buy US or Canada product page |
| [Best Buy Reviews API](#best-buy-reviews-api) | `/v2/bestbuy/product/reviews` | 2 | Get customer reviews for a Best Buy product URL |
| [Best Buy Search API](#best-buy-search-api) | `/v2/bestbuy/search` | 2 | Search Best Buy US or Canada by keyword or search URL. Returns product listings with price, rating and pagination via browser rendering. |

## Table of contents

- [How it works](#how-it-works)
- [Best Buy Product API](#best-buy-product-api)
- [Best Buy Reviews API](#best-buy-reviews-api)
- [Best Buy Search API](#best-buy-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Official SDKs](#official-sdks)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## Best Buy Product API

Get a Best Buy US or Canada product page: title, price, brand, stock, images, categories and specs via browser rendering.

`GET | POST https://api.piloterr.com/v2/bestbuy/product` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Full Best Buy product URL. |
| `return_page_source` | boolean | — | When `true`, return rendered HTML as `{"result": "..."}` instead of JSON. Defaults to `false`. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/bestbuy/product",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "https://www.bestbuy.com/product/gigabyte-aero-x16-copilot-pc-165hz-wqxga-rtx-5070-ryzen-ai-7-350-1tb-ssd-16gb-ddr5-windows-11-lunar-white/J3GWPQC2RQ",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type BestBuyProduct = {
  sku?: string;
  url?: string;
  brand?: string;
  price?: number;
  title?: string;
  images?: string[];
  region?: string;
  currency?: string;
  in_stock?: boolean;
  categories?: string[];
  product_id?: string;
  specifications?: {
    name?: string;
    value?: string;
  }[];
};

const params = new URLSearchParams({
  "query": "https://www.bestbuy.com/product/gigabyte-aero-x16-copilot-pc-165hz-wqxga-rtx-5070-ryzen-ai-7-350-1tb-ssd-16gb-ddr5-windows-11-lunar-white/J3GWPQC2RQ",
});

const response = await fetch(`https://api.piloterr.com/v2/bestbuy/product?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as BestBuyProduct;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/bestbuy/product
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "https://www.bestbuy.com/product/gigabyte-aero-x16-copilot-pc-165hz-wqxga-rtx-5070-ryzen-ai-7-350-1tb-ssd-16gb-ddr5-windows-11-lunar-white/J3GWPQC2RQ"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "sku": "11377127",
  "url": "https://www.bestbuy.com/product/gigabyte-aero-x16-copilot-pc-165hz-wqxga-rtx-5070-ryzen-ai-7-350-1tb-ssd-16gb-ddr5-windows-11-lunar-white…",
  "brand": "GIGABYTE",
  "price": 1932.49,
  "title": "GIGABYTE - AERO X16 Copilot+ PC - 165Hz WQXGA - RTX 5070 - Ryzen AI 7 350 - 1TB SSD 16GB DDR5 - Windows 11 - Lunar White",
  "images": [
    "https://pisces.bbystatic.com/image2/BestBuy_US/images/products/sample.jpg"
  ],
  "region": "com",
  "currency": "USD",
  "in_stock": true,
  "categories": [
    "Computers & Tablets",
    "Laptops"
  ],
  "product_id": "J3GWPQC2RQ",
  "specifications": [
    {
      "name": "Screen Size",
      "value": "16.0 inches"
    }
  ]
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `sku` | string |  |
| `url` | string |  |
| `brand` | string |  |
| `price` | number |  |
| `title` | string |  |
| `images` | string[] |  |
| `region` | string |  |
| `currency` | string |  |
| `in_stock` | boolean |  |
| `categories` | string[] |  |
| `product_id` | string |  |
| `specifications[]` | object[] |  |
| `specifications[].name` | string |  |
| `specifications[].value` | string |  |

## Best Buy Reviews API

Get customer reviews for a Best Buy product URL: rating, review text, author, photos and pagination.

`GET | POST https://api.piloterr.com/v2/bestbuy/product/reviews` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Best Buy product URL or reviews URL. |
| `page` | number | — | Page number, starting at 1. Default 1. A value above 1 overrides page on the Best Buy URL. If this stays at 1, a page already on the URL is kept. |
| `return_page_source` | boolean | — | When true, return the rendered HTML instead of JSON. Default false. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/bestbuy/product/reviews",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "https://www.bestbuy.com/product/google-nest-doorbell-wired-3rd-gen-latest-model-2k-video-and-gemini-hazel/J39TC8J8W5/sku/12104931/reviews",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type BestBuyReviews = {
  results?: {
    sku?: string;
    body?: string;
    title?: string;
    author?: string;
    images?: string[];
    rating?: number;
    region?: string;
    review_id?: string;
    days_owned?: number;
    product_url?: string;
    product_name?: string;
    submitted_at?: string;
    helpful_count?: number;
    is_recommended?: boolean;
    is_incentivized?: boolean;
    not_helpful_count?: number;
    is_verified_purchase?: boolean;
  }[];
  pagination?: {
    next?: string;
    page?: number;
    per_page?: number;
    total_pages?: number;
    total_results?: number;
  };
};

const params = new URLSearchParams({
  "query": "https://www.bestbuy.com/product/google-nest-doorbell-wired-3rd-gen-latest-model-2k-video-and-gemini-hazel/J39TC8J8W5/sku/12104931/reviews",
});

const response = await fetch(`https://api.piloterr.com/v2/bestbuy/product/reviews?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as BestBuyReviews;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/bestbuy/product/reviews
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "https://www.bestbuy.com/product/google-nest-doorbell-wired-3rd-gen-latest-model-2k-video-and-gemini-hazel/J39TC8J8W5/sku/12104931/reviews"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "sku": "6642763",
      "body": "Great doorbell with excellent 2K video quality. The picture is sharp day and night, motion detection is accurate, and alerts are fast and…",
      "title": "Google - Nest Doorbell (wired, 3rd gen)",
      "author": "example",
      "images": [
        "https://pisces.bbystatic.com/image2/BestBuy_US/ugc/photos/thumbnail/1456b7b0bb89940e15b132d7a564bf06.jpg"
      ],
      "rating": 5,
      "region": "com",
      "review_id": "db6638f9-ba34-3be3-a3b2-732603c78ea8",
      "days_owned": 49,
      "product_url": "https://www.bestbuy.com/product/google-nest-doorbell-wired-3rd-gen-latest-model-2k-video-and-gemini-hazel/J39TC8J8W5",
      "product_name": "Google - Nest Doorbell (wired, 3rd gen) - Latest Model - 2K Video and Gemini - Hazel",
      "submitted_at": "2025-12-28T09:51:35.000-06:00",
      "helpful_count": 0,
      "is_recommended": true,
      "is_incentivized": true,
      "not_helpful_count": 0,
      "is_verified_purchase": true
    }
  ],
  "pagination": {
    "next": "https://www.bestbuy.com/product/google-nest-doorbell-wired-3rd-gen-latest-model-2k-video-and-gemini-hazel/J39TC8J8W5/sku/12104931/reviews…",
    "page": 1,
    "per_page": 20,
    "total_pages": 19,
    "total_results": 365
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].sku` | string |  |
| `results[].body` | string |  |
| `results[].title` | string |  |
| `results[].author` | string |  |
| `results[].images` | string[] |  |
| `results[].rating` | integer |  |
| `results[].region` | string |  |
| `results[].review_id` | string |  |
| `results[].days_owned` | integer |  |
| `results[].product_url` | string |  |
| `results[].product_name` | string |  |
| `results[].submitted_at` | string |  |
| `results[].helpful_count` | integer |  |
| `results[].is_recommended` | boolean |  |
| `results[].is_incentivized` | boolean |  |
| `results[].not_helpful_count` | integer |  |
| `results[].is_verified_purchase` | boolean |  |
| `pagination` | object |  |
| `pagination.next` | string |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | integer |  |
| `pagination.total_results` | integer |  |

## Best Buy Search API

Search Best Buy US or Canada by keyword or search URL. Returns product listings with price, rating and pagination via browser rendering.

`GET | POST https://api.piloterr.com/v2/bestbuy/search` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Keyword or full Best Buy search URL. |
| `region` | string | — | Best Buy country when `query` is not a full URL (default: `com`). |
| `page` | number | — | Page number (default: `1`). |
| `sort` | string | — | Sort order (default: `best_selling`). |
| `return_page_source` | boolean | — | When `true`, return rendered HTML as `{"result": "..."}` instead of JSON. Defaults to `false`. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/bestbuy/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "machine",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type BestBuySearch = {
  results?: {
    url?: string;
    type?: string;
    price?: number;
    title?: string;
    currency?: string;
    condition?: string;
    image_url?: string;
    product_id?: string;
  }[];
  pagination?: {
    next?: number;
    page?: number;
    per_page?: number;
    total_pages?: number;
    has_next_page?: boolean;
    total_results?: number;
  };
};

const params = new URLSearchParams({
  "query": "machine",
});

const response = await fetch(`https://api.piloterr.com/v2/bestbuy/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as BestBuySearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/bestbuy/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "machine"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "url": "https://www.bestbuy.com/product/singing-machine-smk302pp-kids-bluetooth-headphones-pink-collectibles-multicolor/J7GW9JWXZ5",
      "type": "product",
      "price": 29.99,
      "title": "Singing Machine - SMK302PP Kids Bluetooth Headphones Pink - COLLECTIBLES - Multicolor",
      "currency": "USD",
      "condition": "new",
      "image_url": "https://pisces.bbystatic.com/image2/BestBuy_US/images/products/014a6bfe-fd8a-413d-a204-49efbdb9baaa.jpg",
      "product_id": "J7GW9JWXZ5"
    }
  ],
  "pagination": {
    "next": 2,
    "page": 1,
    "per_page": 18,
    "total_pages": 763,
    "has_next_page": true,
    "total_results": 13730
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].url` | string |  |
| `results[].type` | string |  |
| `results[].price` | number |  |
| `results[].title` | string |  |
| `results[].currency` | string |  |
| `results[].condition` | string |  |
| `results[].image_url` | string |  |
| `results[].product_id` | string |  |
| `pagination` | object |  |
| `pagination.next` | integer |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | integer |  |
| `pagination.has_next_page` | boolean |  |
| `pagination.total_results` | integer |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Product | Reviews | Search |
|---|---|---|---|
| cURL (Bash) | [`product`](examples/curl/product.sh) | [`product-reviews`](examples/curl/product_reviews.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`product`](examples/php/product.php) | [`product-reviews`](examples/php/product_reviews.php) | [`search`](examples/php/search.php) |
| C# | [`product`](examples/csharp/Product.cs) | [`product-reviews`](examples/csharp/ProductReviews.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`product`](examples/go/product.go) | [`product-reviews`](examples/go/product_reviews.go) | [`search`](examples/go/search.go) |
| Java | [`product`](examples/java/ProductExample.java) | [`product-reviews`](examples/java/ProductReviewsExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`product`](examples/ruby/product.rb) | [`product-reviews`](examples/ruby/product_reviews.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`product`](examples/nodejs/product.mjs) | [`product-reviews`](examples/nodejs/product_reviews.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price monitoring** — Track prices, promotions and availability over time to react to competitors.
- **Assortment & catalog tracking** — Follow new products, delisted items and category changes.
- **Competitor analysis** — Benchmark ranges, brands and positioning across retailers.
- **Product research** — Spot best-sellers and trends from search results.
- **Catalog enrichment** — Pull titles, images and attributes into your PIM or marketplace listings.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — Best Buy plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape Best Buy?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/bestbuy/product` **2**, `/v2/bestbuy/product/reviews` **2**, `/v2/bestbuy/search` **2**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the Best Buy API return?

Each endpoint returns structured JSON: **Best Buy Product** — `sku`, `url`, `brand`, `price`, `title`, `images`; **Best Buy Reviews** — `results[]`, `results[].sku`, `results[].body`, `results[].title`, `results[].author`, `results[].images`; **Best Buy Search** — `results[]`, `results[].url`, `results[].type`, `results[].price`, `results[].title`, `results[].currency`.

### How do I paginate Best Buy results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Can I target a specific country or language?

Yes, use `region` — see the parameter tables above for accepted values.

### Can I get the raw HTML instead of JSON?

Yes. Set `return_page_source=true` and the response becomes `{"result": "..."}` with the page source.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Official SDKs

Use Piloterr from your own language with a typed client:

| SDK | Package | Install |
| --- | --- | --- |
| Node.js | [`@piloterr/sdk`](https://www.npmjs.com/package/@piloterr/sdk) | `npm install @piloterr/sdk` |
| Python | [`piloterr`](https://pypi.org/project/piloterr/) | `pip install piloterr` |
| Go | [`piloterr-go`](https://pkg.go.dev/github.com/piloterr/piloterr-go) | `go get github.com/piloterr/piloterr-go` |
| .NET | [`Piloterr`](https://www.nuget.org/packages/Piloterr) | `dotnet add package Piloterr` |
| Ruby | [`piloterr`](https://rubygems.org/gems/piloterr) | `gem install piloterr` |
| PHP | [`piloterr/sdk`](https://packagist.org/packages/piloterr/sdk) | `composer require piloterr/sdk` |
| Java | [`piloterr-java`](https://github.com/piloterr/piloterr-java) | build from source, see its README |
| CLI | [`@piloterr/cli`](https://www.npmjs.com/package/@piloterr/cli) | `npm install -g @piloterr/cli` |
| MCP server | [`@piloterr/mcp`](https://www.npmjs.com/package/@piloterr/mcp) | `npx -y @piloterr/mcp` |

## Related scrapers

- [About You Scraper API](https://github.com/piloterr/aboutyou-scraper)
- [Action Scraper API](https://github.com/piloterr/action-scraper)
- [Aldi Scraper API](https://github.com/piloterr/aldi-scraper)
- [Alibaba Scraper API](https://github.com/piloterr/alibaba-scraper)
- [AliExpress Scraper API](https://github.com/piloterr/aliexpress-scraper)
- [Allegro Scraper API](https://github.com/piloterr/allegro-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>Best Buy is a trademark of its respective owner. This repository is not affiliated with or endorsed by Best Buy. Examples are released under the MIT license.</sub>
