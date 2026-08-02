# ADR-001: Architecture for Clinical Hybrid Multi-Agent RDF Knowledge Graph Platform

**Status**: Proposed  
**Date**: 2026-08-02  
**Deciders**: Architecture / Knowledge Engineering / Clinical Informatics  
**Tags**: knowledge-graph, multi-agent, clinical-nlp, RDF, Epic, FHIR, ADK, LangGraph

---

## Context and Problem Statement

We need a production-capable system that extracts high-quality, provenanced RDF/RDFS knowledge graphs from heterogeneous hospital data sources (primarily Epic FHIR + BigQuery, Care Everywhere CCDS, unstructured clinical notes, and secondary analytics databases). The system must:

- Support both structured and unstructured content inside FHIR and CCDS.
- Combine classical high-precision clinical NLP with modern LLM extraction for coverage.
- Preserve an existing trusted grounding / normalization / RDF pipeline.
- Provide configurable quality gates (SHACL) and human review (Argilla).
- Be extensible when new extractors, ontologies or data sources appear.
- Serve as the long-term foundation of a hospital-wide semantic layer.

The architecture must also be operable via CLI for agent tool-calling (low token cost, high control).

## Decision Drivers

- Clinical trust and explainability (provenance, grounding, SHACL).
- Token efficiency and determinism of agent tool use.
- Ability to keep classical NLP (spaCy ecosystem) and LLM channels first-class.
- Minimal disruption to any existing OntoGPT + OAKlib pipeline.
- Clear separation of concerns (data → connector → processing → consumption).
- Future extensibility without rewriting the core orchestration.

## Considered Options

1. Pure end-to-end LLM extraction (single large prompt / agent).
2. Classical NLP only (spaCy / SciSpaCy pipeline extended).
3. Hard-wired hybrid pipeline (fixed sequence of tools).
4. **Multi-agent orchestration with CLI-wrapped tools + intelligent routing** (chosen).
5. Fully in-process Python library composition (no CLI boundary).

## Decision

We adopt a **layered, multi-agent architecture** with the following key choices:

### 1. Layered Architecture
- **Data Layer**: Epic FHIR, BigQuery, CCDS, notes, analytics DBs (source of truth).
- **Connector / Ingestion Layer**: Source adapters + agent-driven Source/Document Type Router + Intent & Tool Selector.
- **Processing / KG Generation Layer**: Classical clinical NLP channel + Multi-agent extraction (5 specialized agents) + Coreference & Entity Resolution + Grounding + RDF/RDFS generation + SHACL Validation.
- **Consumption / Business Layer**: SPARQL/GraphQL, GraphRAG, CDS, analytics applications.
- Cross-cutting: 3rd-party tool box (extensible), Graph Validation services, Analytics & Monitoring.

### 2. Orchestration Runtime
- **Google ADK** (Agent Development Kit) as the primary framework: Workflow Runtime (graph-based, parallel, conditional, HITL), Agents CLI, FunctionTools / AgentTools, evaluation.
- **LangGraph** used where more complex stateful subgraphs are required (optional, complementary).

### 3. Tool Calling Strategy – CLI-First
**All external capabilities are preferentially exposed as CLI tools** (or thin FunctionTool wrappers around CLIs) rather than heavy in-process library imports.

**Rationale**:
- Agents spend far fewer tokens describing and controlling a CLI invocation than loading large library APIs into context.
- Deterministic, versionable, sandboxable, and easy to monitor/log.
- Existing packages (OntoGPT, spaCy pipelines, pySHACL, domain tools) already ship good CLIs or can be given simple entry-points.
- New tools can be added by writing a small CLI wrapper and registering it in the Tool Capability Knowledge Base—no change to agent code.

### 4. Hybrid Extraction Channels
- **Classical channel** (high precision, low cost): spaCy / SciSpaCy backbone → section detection → SciSpaCy + GLiNER NER → MedSpaCy context → SapBERT reranker → multi-KB mapping.
- **LLM channels**: OntoGPT (LinkML template + SPIRES + grounding) and prompt-driven incremental extractors (iText2KG-style).
- **Domain-specific tools** registered the same way.
- All channels feed a shared **Reconciliation + Coreference Agent**.

### 5. Quality & Human-in-the-Loop
- Configurable **SHACL Validation Agent** (flavors: generic RDF Schema, FHIR RDF, LinkML-derived, domain shapes) selected by the Intent Agent.
- **Argilla** for clinical review (Entity Validation, Code Selection, Assertion Review, Relation Review). High-confidence paths bypass HITL; only exceptions are queued.
- Feedback loop improves tool selection rules, thresholds and few-shot examples.

### 6. Primary Representation
RDF / RDFS (with optional OWL) is the system of record. Provenance and confidence are first-class.

## Consequences

### Positive
- Clear separation of concerns and independent evolution of tools.
- Low token cost and high controllability for agents.
- Classical NLP remains a first-class, cost-effective channel.
- Existing trusted pipeline is preserved and only receives higher-quality candidates.
- Extensibility path is simple (CLI + capability registration).
- Supports the long-term vision of a hospital semantic layer.

### Negative / Trade-offs
- Additional engineering for source adapters and CLI wrappers.
- Need to maintain a Tool Capability Knowledge Base (lightweight).
- Orchestration logic itself becomes a new piece of software that must be tested and governed.
- Initial pilot will still require careful SHACL shape design and Argilla task configuration.

### Risks Mitigated
- Hallucination risk reduced by hybrid channels, grounding, SHACL and HITL.
- Vendor / model lock-in reduced by CLI abstraction and multi-channel design.
- Knowledge silos reduced by forcing everything into a common RDF representation with provenance.

## Related Decisions / Follow-ups
- ADR-002: Tool Capability Knowledge Base schema and population process.
- ADR-003: SHACL shapes registry and flavor selection policy.
- ADR-004: Argilla task design and HITL routing policy.
- Pilot scope and success metrics (precision/recall, SHACL conformance, human correction rate, downstream GraphRAG utility).

## References
- Google ADK documentation and Workflow Runtime.
- OntoGPT / SPIRES / OAKlib.
- spaCy / SciSpaCy / GLiNER / MedSpaCy / SapBERT clinical NLP stack.
- pySHACL, Argilla.
- Prior internal diagrams: Hybrid Multi-Agent Extraction, Clinical NLP Pipeline with HITL, full RDF KG lifecycle map.
