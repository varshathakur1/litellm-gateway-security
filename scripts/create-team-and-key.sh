#!/bin/bash
# Example script to create a team + virtual key via LiteLLM Admin API
# Requires the proxy to be running and LITELLM_MASTER_KEY set

PROXY_URL="http://localhost:4000"
MASTER_KEY="${LITELLM_MASTER_KEY:-sk-1234}"

echo "Creating team 'engineering'..."

curl -X POST "${PROXY_URL}/team/new" \
  -H "Authorization: Bearer ${MASTER_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "team_alias": "engineering",
    "max_budget": 100.0,
    "budget_duration": "30d",
    "models": ["gpt-4o", "claude-3-5-sonnet"]
  }'

echo -e "\n\nCreating virtual key for the team..."

curl -X POST "${PROXY_URL}/key/generate" \
  -H "Authorization: Bearer ${MASTER_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "team_id": "<paste-team-id-from-above>",
    "key_alias": "eng-dev-key",
    "max_budget": 50.0,
    "models": ["gpt-4o"]
  }'

echo -e "\n\nDone. Use the returned key as the API key for requests."
