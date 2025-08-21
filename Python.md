# Create a venv

```bash
sudo apt install python3-venv -y
python3 -m venv venv
source venv/bin/activate
```

# Install requirements

```bash
pip install -r requirements.txt
```

# Export requirements

```bash
pip freeze > requirements.txt
```