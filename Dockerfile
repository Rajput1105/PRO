FROM python:3.12-slim-bookworm

# Install required system packages
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates

# Download the latest installer
ADD https://astral.sh/uv/install.sh /uv-installer.sh

# Run the installer then remove it
RUN sh /uv-installer.sh && rm /uv-installer.sh

# Ensure the installed binary is on the PATH
ENV PATH="/root/.local/bin/:$PATH"

WORKDIR /app

# Copy your application files
COPY . /app

# Install required Python dependencies
RUN uv pip install --system fastapi uvicorn requests bs4 python-dotenv markdown duckdb numpy python-dateutil docstring-parser httpx scikit-learn

# Expose the port (if your FastAPI app runs on 8000)
EXPOSE 8000

# Run the FastAPI app with Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]