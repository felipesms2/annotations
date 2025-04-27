

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
printf "[project]\nname = \"flask-app\"\nversion = \"0.1.0\"\ndependencies = [\n  \"Flask==3.0.0\",\n  \"Werkzeug==3.0.1\"\n]\n\n[build-system]\nrequires = [\"setuptools\", \"wheel\"]\nbuild-backend = \"setuptools.build_meta\"\n" > pyproject.toml && \
pip install --upgrade pip && \
pip install --upgrade build && \
pip install . && \
chmod -R 777 /app
'
```
```zsh
docker run --rm -v "$(pwd):/app" -w /app python:3.11-slim bash -c '
mkdir -p templates static && \
echo "from flask import Flask\napp = Flask(__name__)\n\n@app.route(\"/\")\ndef home():\n    return \"Hello, Flask!\"" > app.py && \
echo "Flask==3.0.0\nWerkzeug==3.0.1\nrequests\nbeautifulsoup4" > requirements.txt && \
pip install --upgrade pip && \
pip install -r requirements.txt && \
chmod -R 777 /app
'

```
