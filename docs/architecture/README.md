# Architecture Diagrams

This folder contains the architecture diagrams for the **Clinical Semantic KG** platform.

## Files

| File | Description |
|------|-------------|
| `layered-architecture-clinical-kg.drawio` | Layered view: Data → Connector/Agent → Processing/KG Generation → Consumption + external 3rd-party tools, validation & analytics boxes |
| `c4-context-container-clinical-kg.drawio` | C4 Context (people + external systems) and Container (Ingestion, Orchestrator, Extraction Workers, RDF Pipeline, HITL, Query API) views |
| `clinical-hybrid-multi-agent-rdf-kg-architecture.drawio` | Detailed multi-source + multi-agent + classical NLP + SHACL + Argilla end-to-end flow |

## How to view / edit

1. Open any `.drawio` file in [app.diagrams.net](https://app.diagrams.net) (File → Open from → Device) or the free draw.io desktop app.
2. To export high-resolution PNG/SVG/PDF: File → Export as → choose format (recommend 2× or 3× scale for PNG).

## Source of truth

The diagrams were generated programmatically as part of the architecture design work and are kept in sync with the ADRs and the one-page proposal.
