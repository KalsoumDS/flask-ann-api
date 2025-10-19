# Atelier 3 — Git, GitHub, Docker, CI/CD

Ce dépôt contient une application Flask minimale conteneurisée avec Docker et un workflow GitHub Actions pour construire et publier l'image.

## Démarrer en local
```bash
python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
python app/app.py
# Ouvrir http://127.0.0.1:5000/ping
```

## Docker
```bash
docker build -t flask-ann-api .
# Par défaut (port 5000):
docker run --rm -p 5000:5000 flask-ann-api

# Si le port 5000 est occupé, utilisez la variable d'environnement PORT
# et mappez le même port côté hôte:
docker run --rm -e PORT=5002 -p 5002:5002 flask-ann-api
# Puis ouvrez http://127.0.0.1:5002/ping
```

## GitHub
1. Crée un repo `flask-ann-api` sur GitHub (sans README).
2. Configure les secrets Actions:
   - `DOCKERHUB_USERNAME`
   - `DOCKERHUB_TOKEN`
3. Pousse sur `main` pour déclencher le workflow.

## CI/CD
Le workflow construit et pousse l'image sur Docker Hub avec le tag `latest`.

Image publiée: `oumou08/flask-ann-api:latest`

Exécution depuis Docker Hub:
```bash
docker pull oumou08/flask-ann-api:latest
# Port par défaut (5000)
docker run --rm -p 5000:5000 oumou08/flask-ann-api:latest
# Ou avec PORT personnalisé
docker run --rm -e PORT=5002 -p 5002:5002 oumou08/flask-ann-api:latest
# http://127.0.0.1:5002/ping
```
