# Secure LLM Gateway with LiteLLM Proxy

**Interview-ready project** demonstrating production-grade AI gateway security: per-team virtual keys, budgets, guardrails, and Azure Sentinel logging.

## What This Project Does

This is a **single secure entry point** (LLM Gateway) in front of multiple AI providers (OpenAI, Anthropic, Google, etc.). Instead of giving every team direct API keys, they go through this gateway which enforces:

- **Per-team virtual keys** — teams never see the real provider keys
- **Budgets & rate limits** — hard spend caps per team/key
- **Guardrails** — block prompt injection, PII, toxic content before/after the LLM call
- **Azure Sentinel logging** — every request (success + failure) is logged for security monitoring

## Architecture (High Level)

```
Client / App
    ↓ (uses virtual key)
LiteLLM Proxy (Gateway)
    ├── Auth + Budget check
    ├── Guardrails (pre/post)
    ├── Routing + Load balancing
    ↓
Real LLM Providers (OpenAI, Anthropic, etc.)
    ↓
Logs → Azure Sentinel (security monitoring)
```

## Key Features Demonstrated

| Feature              | Why it matters in interviews                  |
|----------------------|-----------------------------------------------|
| Virtual Keys + Teams | Least privilege, easy revocation              |
| Budgets              | Cost control & runaway prevention             |
| Guardrails           | Prompt injection & data leakage defense       |
| Sentinel Logging     | Observability + security SIEM integration     |
| RBAC / Admin UI      | Enterprise access control                     |

## Quick Start

```bash
# 1. Clone
git clone https://github.com/varshathakur1/litellm-gateway-security.git
cd litellm-gateway-security

# 2. Copy env example
cp .env.example .env
# Fill in your real provider keys + master key

# 3. Start with Docker
docker compose up -d

# 4. Create a team + virtual key (see scripts/)
./scripts/create-team-and-key.sh
```

## Interview Talking Points

1. **Why a gateway?** Direct API keys create sprawl, no central spend control, and hard revocation.
2. **Virtual keys** let you revoke access instantly without rotating the real provider key.
3. **Budgets** are enforced at the gateway level before the request even reaches the LLM.
4. **Guardrails** can be applied per-team or per-key (e.g., stricter rules for customer-facing apps).
5. **Sentinel logging** gives security teams a single place to detect anomalous usage or prompt injection attempts.
6. **Trade-offs**: Added latency (usually <50ms), operational overhead of running the proxy + database.

## Project Structure

```
.
├── README.md
├── docker-compose.yml
├── config.yaml                 # Main LiteLLM proxy config
├── .env.example
├── scripts/
│   ├── create-team-and-key.sh
│   └── test-request.sh
├── docs/
│   ├── architecture.md
│   └── sentinel-setup.md
└── examples/
    └── sample-requests.md
```

## Next Steps / What I Can Extend

- Add Redis for multi-instance budget tracking
- Kubernetes / Helm deployment
- Custom guardrail (code-based or external service)
- OpenTelemetry + Langfuse tracing
- Cost attribution dashboards

---
**Built for interview discussions around AI Security, Platform Engineering, and Responsible AI.**
