#!/usr/bin/env bash
# Best Buy Product API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./product.sh
set -euo pipefail

curl -sS -G "https://api.piloterr.com/v2/bestbuy/product" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=https://www.bestbuy.com/product/gigabyte-aero-x16-copilot-pc-165hz-wqxga-rtx-5070-ryzen-ai-7-350-1tb-ssd-16gb-ddr5-windows-11-lunar-white/J3GWPQC2RQ
