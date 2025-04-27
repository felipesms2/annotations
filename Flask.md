

## Create via docker container

```bash
docker run --rm -v "$(pwd):/app" -w /app python:3.11-slim bash -c \
"mkdir -p templates static && \
echo 'from flask import Flask\napp = Flask(__name__)\n\n@app.route(\"/\")\ndef home():\n    return \"Hello, Flask!\"' > app.py && \
echo 'Flask==3.0.0\nWerkzeug==3.0.1' > requirements.txt && \
pip install -r requirements.txt && \
chmod -R 777 /app"
```

```zsh
docker run --rm -v "$(pwd):/app" -w /app python:3.11-slim bash -c '
mkdir -p templates static && \
echo "from flask import Flask\napp = Flask(__name__)\n\n@app.route(\"/\")\ndef home():\n    return \"Hello, Flask!\"" > app.py && \
echo "Flask==3.0.0\nWerkzeug==3.0.1" > requirements.txt && \
pip install -r requirements.txt && \
chmod -R 777 /app
'
```
