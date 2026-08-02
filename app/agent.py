"""Root orchestrator agent / workflow for Clinical Semantic KG."""

from google.adk import Agent

# Placeholder — will be replaced by full multi-agent Workflow
root_agent = Agent(
    name="clinical_semantic_kg_orchestrator",
    model="gemini-2.0-flash",
    instruction=(
        "You are the root orchestrator for the Clinical Semantic KG platform. "
        "You route documents to the appropriate extraction channels and agents, "
        "coordinate reconciliation, grounding, SHACL validation, and HITL."
    ),
    tools=[],  # populated from app/tools.py
)
