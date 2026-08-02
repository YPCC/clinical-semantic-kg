# Clinical Semantic KG

**Clinical Hybrid Multi-Agent RDF Knowledge Graph Platform**  
Driving a hospital-wide semantic layer from Epic, Care Everywhere (CCDS), and clinical data using Google ADK + LangGraph.

---

## Vision

Hospitals sit on a goldmine of fragmented data—Epic FHIR and BigQuery, Care Everywhere CCDS, clinical notes, labs, imaging, pharmacy, and reference terminologies. The vision of **Clinical Semantic KG** is to turn that fragmentation into a living, hospital-wide **RDF semantic layer**: a single, provenanced, queryable source of truth that powers Clinical Decision Support, GraphRAG, cohort discovery, pharmacovigilance, and interoperability.

What makes this project distinctive is *how* we propose to build it. Instead of a multi-year hand-crafted pipeline, we systematically harness **multi-agent systems** and the **Agent Development Lifecycle (AI DLC)** with Google ADK and Agents CLI. Specialist agents (document understanding, entity & relationship extraction, provenance, reconciliation, SHACL validation) are orchestrated, tools are called via clean CLI wrappers, quality is gated by SHACL + Argilla human review, and the whole stack remains extensible and deployable to Cloud Run / Agent Runtime / GKE. The result is a rapid, governable path from heterogeneous clinical data to an enterprise semantic layer.

### Enterprise Layered Architecture

Six layers from Source Systems & Data → Connectivity & Ingestion → Agentic Orchestration & Processing → Semantic Control & Quality Gates → Semantic Knowledge Layer → Consumption & Institutional Value, with cross-cutting Platform/DevOps and Trust/Governance/Security columns.

![Enterprise Layered Architecture](docs/architecture/images/enterprise-layered-architecture.jpg)

### C4 Context Diagram

The Clinical Semantic KG Platform at the centre, surrounded by clinical source systems, human stakeholders (clinicians, researchers, ontology stewards, governance), downstream applications (CDS, GraphRAG, cohort discovery, pharmacovigilance, interoperability), and the supporting tooling (source adapters, hybrid knowledge generation, semantic control).

![C4 Context Diagram](docs/architecture/images/c4-context-diagram.jpg)

These two figures capture the full organisational scope and the agentic engine that realises it.

---

## Current State of the Repository (as of 2026-08-02)

This repository is in the **architecture + scaffolding** phase.

### What is ready

| Area | Status |
|------|--------|
| Vision, one-page proposal, ADR-001 | Complete |
| Architecture diagrams (Layered, C4, Hybrid) | Present (open in diagrams.net) |
| Recommended folder structure | Fully scaffolded |
| `AGENTS.md` (agent conventions) | Present |
| Google ADK entrypoint (`app/`) | Skeleton (root orchestrator placeholder) |
| `src/agentic_layer/` (agents, channels, adapters, graph, tools, config) | Skeleton with placeholders |
| Tool Capability KG skeleton | Present (`tool_capability_kg.yaml`) |
| Makefile, pyproject.toml, Agents CLI manifest | Present |
| Basic CI workflow (PR checks) | Skeleton |
| LICENSE (Apache-2.0) | Present |

### What is **not** yet implemented

- Full agent logic (all specialist agents are placeholders / TODOs)
- Source adapters (FHIR, CCDS, BigQuery, notes)
- Classical NLP channel and LLM tool wrappers (OntoGPT, iText2KG, spaCy pipelines)
- SHACL shapes registry and validation logic
- Argilla HITL integration
- End-to-end extraction workflow / LangGraph graphs
- Comprehensive tests and evaluation datasets
- Terraform / Cloud Build / full deployment configs
- Per-agent specifications under `docs/spec/` (only the README listing them exists)

The repository is ready for **implementation work**, not yet for production use.

---

## Getting Started

### 1. Prerequisites

- Python 3.11+
- [uv](https://github.com/astral-sh/uv) (recommended) or pip
- Git
- (Optional) Google Cloud project + `gcloud` CLI if you plan to deploy later
- (Optional) [Agents CLI](https://adk.dev/) for ADK lifecycle commands

### 2. Clone and install

```bash
git clone https://github.com/YPCC/clinical-semantic-kg.git
cd clinical-semantic-kg

# Install dependencies (uv recommended)
uv sync --group dev

# Or with pip
python -m venv .venv
source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -e ".[dev]"
```

### 3. Explore the documentation and diagrams

```bash
# Key documents
open docs/proposal/one-page-proposal-clinical-semantic-kg.md
open docs/adr/ADR-001-clinical-hybrid-multi-agent-rdf-kg.md
open AGENTS.md

# Architecture diagrams (open in browser or desktop app)
# https://app.diagrams.net  → File → Open from → Device
open docs/architecture/layered-architecture-clinical-kg.drawio
open docs/architecture/c4-context-container-clinical-kg.drawio
open docs/architecture/clinical-hybrid-multi-agent-rdf-kg-architecture.drawio
```

### 4. Common development commands

```bash
make help          # list available targets
make install       # install deps
make lint          # ruff check + format check
make test          # run tests (currently minimal)
make clean         # remove caches
```

### 5. Working with Agents CLI (optional)

```bash
# After installing Agents CLI
agents-cli scaffold enhance --deployment-target cloud_run
# or follow the official Agents CLI quickstart for ADK projects
```

### 6. Recommended next implementation steps

1. Write the individual agent specs under `docs/spec/`.
2. Implement the Intent & Tool Selector + Document Understanding agents.
3. Create the first CLI wrappers (e.g. spaCy pipeline, OntoGPT).
4. Wire a minimal extraction graph (LangGraph or ADK Workflow).
5. Add unit tests and a small evaluation dataset.
6. Configure Argilla and a basic SHACL shapes registry.

---

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
| [AGENTS.md](AGENTS.md) | Agent conventions (source of truth for coding agents) |
| [Layered Architecture](docs/architecture/layered-architecture-clinical-kg.drawio) | Data → Connector → Processing → Consumption |
| [C4 Context + Container](docs/architecture/c4-context-container-clinical-kg.drawio) | People, external systems, and major containers |
| [Detailed Hybrid Architecture](docs/architecture/clinical-hybrid-multi-agent-rdf-kg-architecture.drawio) | Full multi-agent + classical NLP + SHACL + Argilla flow |

Open any `.drawio` file in [app.diagrams.net](https://app.diagrams.net) or the draw.io desktop app.

## License

Apache-2.0
