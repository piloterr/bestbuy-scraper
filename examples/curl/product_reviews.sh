#!/usr/bin/env bash
# Best Buy Reviews API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./product_reviews.sh
set -euo pipefail

curl -sS --fail-with-body -G "https://api.piloterr.com/v2/bestbuy/product/reviews" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=https://www.bestbuy.com/product/google-nest-doorbell-wired-3rd-gen-latest-model-2k-video-and-gemini-hazel/J39TC8J8W5/sku/12104931/reviews
