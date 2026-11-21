# Architecture Deep Dive

## Why a Gateway?

Giving every team a real OpenAI/Anthropic key creates:
- Key sprawl (hard to rotate)
- No central spend control
- No easy way to revoke access
- No place to put guardrails or audit logs

A **LiteLLM Proxy** solves this by sitting in the middle.

## Request Flow

1. Client sends request with a **virtual key** (not the real provider key).
2. Proxy checks:
   - Is the key valid?
   - Does the team/key have remaining budget?
   - Do pre-call guardrails pass (prompt injection, PII, etc.)?
3. If yes → route to the real model (OpenAI, Anthropic, etc.).
4. Apply post-call guardrails if configured.
5. Log success/failure + spend to Azure Sentinel.
6. Return response to client.

## Key Security Concepts Demonstrated

- **Virtual Keys** → least privilege + instant revocation
- **Teams + Budgets** → cost control & chargeback
- **Guardrails** → defense in depth against prompt injection & data leaks
- **Centralized Logging** → security monitoring & compliance

## Interview Tip

Be ready to talk about:
- What happens if the proxy goes down? (fallback strategies)
- How budgets are enforced across multiple proxy instances (Redis)
- How you would add a custom guardrail
- Latency impact and how you measured it
