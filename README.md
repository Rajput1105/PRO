# DataWorks Automation Agent

## Overview
The DataWorks Automation Agent is designed to parse and execute operational and business tasks using an LLM-based approach. The agent automatically handles a variety of predefined tasks related to file processing, data analysis, API interactions, and more.

## Features
### Phase A: Handle Operations Tasks
The agent automates the following operations:
1. **Install `uv` and execute a script**: Ensures `uv` is installed and runs `datagen.py` with the user's email.
2. **Format Markdown file**: Uses `prettier@3.4.2` to format `/data/format.md` in place.
3. **Count Wednesdays in a date list**: Processes `/data/dates.txt` and writes the count to `/data/dates-wednesdays.txt`.
4. **Sort contacts**: Sorts `/data/contacts.json` by `last_name` and `first_name` and saves to `/data/contacts-sorted.json`.
5. **Extract logs**: Finds the first line of the 10 most recent `.log` files in `/data/logs/` and writes them in descending order to `/data/logs-recent.txt`.
6. **Generate a Markdown index**: Extracts H1 titles from Markdown files in `/data/docs/` and creates an index file.
7. **Extract sender’s email from a message**: Uses an LLM to extract and write the sender's email from `/data/email.txt`.
8. **Extract credit card number from an image**: Uses an LLM to extract and write the credit card number from `/data/credit-card.png`.
9. **Find similar comments**: Uses embeddings to find the most similar pair of comments from `/data/comments.txt` and writes them to `/data/comments-similar.txt`.
10. **Calculate total ticket sales**: Queries an SQLite database for total sales of “Gold” tickets and writes the result to `/data/ticket-sales-gold.txt`.

### Phase B: Handle Business Tasks
The agent also ensures:
- Data outside `/data` is never accessed or exfiltrated.
- Data is never deleted.

Additional business tasks supported:
1. **Fetch data from an API and save it**
2. **Clone a git repository and make a commit**
3. **Run SQL queries on SQLite or DuckDB**
4. **Extract data from a website**
5. **Compress or resize an image**
6. **Transcribe audio from an MP3 file**
7. **Convert Markdown to HTML**
8. **Filter a CSV file and return JSON data via an API endpoint**

## Setup & Deployment
### Prerequisites
- Docker or Podman installed
- Publicly accessible GitHub repository with:
  - MIT License file (`LICENSE`)
  - A valid `Dockerfile`
- A public Docker image based on the repository

### Running the Agent
```sh
# Pull the Docker image
podman pull <IMAGE_NAME>
# OR
docker pull <IMAGE_NAME>

# Run the container
podman run -e AIPROXY_TOKEN=$AIPROXY_TOKEN -p 8000:8000 <IMAGE_NAME>
# OR
docker run -e AIPROXY_TOKEN=$AIPROXY_TOKEN -p 8000:8000 <IMAGE_NAME>
```

### Using the Agent
#### Running a Task
```sh
curl -X POST "https://localhost:8000/run?task=Format+/data/format.md+with+prettier+3.4.2"
```
Expected response: HTTP 200 OK.

#### Reading Processed Data
```sh
curl -X GET "https://localhost:8000/read?path=/data/format.md"
```

## Evaluation Criteria
- The repository and Docker image meet all requirements.
- The agent correctly parses and executes variously worded task descriptions.
- Data security constraints are enforced.
- The solution is robust enough to handle additional tasks beyond those listed.

## License
This project is licensed under the MIT License.

