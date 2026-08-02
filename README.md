# Clinical Semantic KG

**Clinical Hybrid Multi-Agent RDF Knowledge Graph Platform**  
Driving a hospital-wide semantic layer from Epic, Care Everywhere (CCDS), and clinical data using Google ADK + LangGraph.

## Vision

Turn heterogeneous hospital data (Epic FHIR + BigQuery, Care Everywhere CCDS, unstructured notes, analytics databases) into a high-quality, provenanced **RDF/RDFS knowledge graph** that becomes the institution’s **semantic layer** for Clinical Decision Support, GraphRAG, cohort discovery, pharmacovigilance, and interoperability.

## Core Strengths

- **Hybrid extraction**: Classical clinical NLP (spaCy / SciSpaCy / GLiNER / MedSpaCy / SapBERT) + LLM channels (OntoGPT + prompt-driven extractors)
- **Intelligent routing**: Document-type and intent-aware agents decide which tools/channels to activate
- **CLI-first tool calling**: Low token cost, high control, easy extensibility
- **Trust gates**: SHACL validation (configurable flavors including FHIR RDF) + Argilla human-in-the-loop
- **Google ADK + Agents CLI ready**: Scaffold, test, evaluate, and deploy to Cloud Run / Agent Runtime / GKE

## Quick Links

| Document | Description |
|----------|-------------|
| [One-Page Proposal](docs/proposal/one-page-proposal-clinical-semantic-kg.md) | Business value, core strengths, ask |
| [ADR-001](docs/adr/ADR-001-clinical-hybrid-multi-agent-rdf-kg.md) | Architecture Decision Record (tooling, CLI preference, hybrid design) |
| [Layered Architecture](docs/architecture/layered-architecture-clinical-kg.drawio) | Data → Connector → Processing → Consumption |
| [C4 Context + Container](docs/architecture/c4-context-container-clinical-kg.drawio) | People, external systems, and major containers |
| [Detailed Hybrid Architecture](docs/architecture/clinical-hybrid-multi-agent-rdf-kg-architecture.drawio) | Full multi-agent + classical NLP + SHACL + Argilla flow |

Open any `.drawio` file in [app.diagrams.net](https://app.diagrams.net) or the draw.io desktop app.

## Recommended Repository Structure

```text
clinical-semantic-kg/
├── docs/
│   ├── proposal/
│   ├── adr/
│   ├── architecture/          # draw.io diagrams
│   ├── spec/                   # per-agent specifications
│   └── …
├── app/                         # Google ADK / Agents CLI entrypoint
├── src/agentic_layer/           # Core multi-agent implementation
│   ├── agents/
│   ├── channels/                # classical NLP, OntoGPT, iText2KG…
│   ├── adapters/                # FHIR, CCDS, BigQuery, notes
│   ├── graph/                   # Workflow / LangGraph
│   ├── tools/                   # CLI wrappers
│   └── …
├── tests/
├── deployment/                  # Terraform + Cloud Build
├── .github/workflows/
└── …
```

## Status

This repository currently contains the **architecture, proposal, ADR, and diagrams**.  
Implementation of the agentic layer, adapters, and CI/CD is the next phase.

## License

Apache-2.0 (planned)
