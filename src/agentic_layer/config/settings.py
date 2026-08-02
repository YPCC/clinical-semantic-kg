"""pydantic-settings configuration."""

from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    google_cloud_project: str | None = None
    google_cloud_location: str = "us-central1"

    class Config:
        env_file = ".env"
        extra = "ignore"


settings = Settings()
