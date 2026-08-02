# AGENTS.md — Clinical Semantic KG

Source of truth for agent conventions used by Google Agents CLI, coding agents (Gemini CLI, Claude Code, Cursor, etc.), and human contributors.

## Core Agents

| Agent | Responsibility |
|-------|----------------|
| Intent & Tool Selector | Chooses channels/tools based on document type + intent + Tool Capability KG |
| Document Understanding | Structure, sections, tables, context preparation |
| Entity Extraction | Clinical entities, biomarkers, procedures, codes |
| Relationship Extraction | Semantic relations between entities |
| Evidence & Provenance | Source spans, citations, confidence |
| Reconciliation | Merge, dedupe, conflict resolution, canonical output |
| Coreference & Entity Resolution | Within- and cross-document resolution + KB linking |
| SHACL Validation | Configurable shapes (RDF Schema, FHIR RDF, domain) |

## Conventions

- Prefer **CLI-first tool calling** (low token cost, deterministic, versionable).
- All external capabilities (OntoGPT, spaCy pipelines, pySHACL, …) are wrapped as CLI / FunctionTools.
- High-confidence paths may auto-pass; low-confidence / SHACL failures / conflicts go to Argilla HITL.
- Primary representation is **RDF / RDFS** with provenance and confidence as first-class citizens.
- Keep the existing trusted grounding → normalization → RDF pipeline intact.

## Adding a new tool / channel

1. Create a thin CLI wrapper under `src/agentic_layer/tools/`.
2. Register it in `src/agentic_layer/config/tool_capability_kg.yaml`.
3. Expose it via ADK `FunctionTool` in `app/tools.py`.
4. Update the relevant agent spec under `docs/spec/`.
