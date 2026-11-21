# Azure Sentinel Logging Setup

LiteLLM can send every request (success + failure) to Azure Sentinel for security monitoring.

## High-level Steps

1. Create a Log Analytics Workspace in Azure.
2. Enable Azure Sentinel on that workspace.
3. Create a custom table (or use the built-in HTTP Data Collector).
4. Get the Workspace ID and Primary Key.
5. Add the credentials to your LiteLLM config / environment.

## Example config snippet

```yaml
litellm_settings:
  success_callback: ["azure_sentinel"]
  failure_callback: ["azure_sentinel"]

# Environment variables expected by the callback:
# AZURE_SENTINEL_WORKSPACE_ID
# AZURE_SENTINEL_PRIMARY_KEY
```

## What gets logged

- Timestamp
- Team / key alias
- Model used
- Tokens in/out
- Spend
- Guardrail decisions (blocked/allowed)
- Error messages (if any)

This gives security teams a single place to detect:
- Unusual spend spikes
- Prompt injection attempts
- Key misuse
- Data exfiltration patterns
