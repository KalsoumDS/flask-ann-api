# Rapport Académique — Atelier 3: Git, GitHub, Docker, CI/CD

Auteur: Kalsoum (KalsoumDS)
Filière/Niveau: [à compléter]
Date: $(date +%Y-%m-%d)
Encadrant: [à compléter]

## Résumé
Cet atelier met en œuvre un pipeline CI/CD simple pour une API Flask. Le code est versionné sur GitHub, conteneurisé via Docker et l'image est construite et publiée automatiquement sur Docker Hub à chaque push sur `main`. Le résultat est validé par l'appel de l'endpoint `/ping` retournant `{"status":"ok"}`.

Mots-clés: Git, GitHub, Docker, CI/CD, GitHub Actions, Docker Hub, Flask

---

## 1. Introduction
L'objectif principal est d'appliquer les notions de contrôle de version, dockerisation et intégration continue décrites dans le document « Atelier 3 — Introduction à Git, GitHub et Intégration avec Docker ». Nous suivons strictement les étapes prescrites afin d'obtenir une image `flask-ann-api:latest` publiée sur Docker Hub et exécutable sur toute machine disposant de Docker.

### 1.1 Outils utilisés
- Git: système de contrôle de version distribué
- GitHub: hébergement/coopération autour du code
- Docker: isolation et portabilité de l'application
- GitHub Actions: automatisation des builds/tests/déploiements

---

## 2. Méthodologie (étapes du PDF)
1) Initialisation du dépôt Git local et premier commit
2) Ajout d'un `.gitignore`
3) Création d'un dépôt GitHub vide `flask-ann-api` et push de `main`
4) Dockerisation de l'app Flask et test local
5) Mise en place de GitHub Actions (CI/CD) avec secrets Docker Hub
6) Vérification du workflow et publication automatique sur Docker Hub
7) Exécution de l'image publiée et test de l'endpoint `/ping`

---

## 3. Implémentation
### 3.1 Structure du projet
- `app/app.py`: API Flask minimale exposant `/ping`
- `requirements.txt`: dépendances Python
- `Dockerfile`: recette de construction de l'image
- `.github/workflows/docker-image.yml`: workflow CI/CD
- `.gitignore`: exclusions Git

### 3.2 Code applicatif (extrait)
```python
from flask import Flask, jsonify

app = Flask(__name__)

@app.get('/ping')
def ping():
    return jsonify({"status": "ok"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

### 3.3 Dockerfile (extrait)
```Dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
COPY app /app/app
EXPOSE 5000
CMD ["gunicorn", "-w", "2", "-b", "0.0.0.0:5000", "app.app:app"]
```

### 3.4 Workflow CI/CD (extrait)
```yaml
name: Build & Push Docker Image
on:
  push:
    branches: [ "main" ]
jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}
      - uses: docker/build-push-action@v6
        with:
          context: .
          push: true
          tags: ${{ secrets.DOCKERHUB_USERNAME }}/flask-ann-api:latest
```

---

## 4. Résultats
- Push Git réussi sur `main` (URL dépôt: https://github.com/KalsoumDS/flask-ann-api)
- Workflow GitHub Actions: Success
- Image publiée: `oumou08/flask-ann-api:latest` (Docker Hub)
- Exécution locale:
```bash
docker pull oumou08/flask-ann-api:latest
docker run --rm -p 5000:5000 oumou08/flask-ann-api:latest
# Test: http://127.0.0.1:5000/ping -> {"status":"ok"}
```

> Captures à insérer: Actions (Success), Docker Hub (repo créé), navigateur/Postman (réponse OK)

---

## 5. Discussion
- Gestion des jetons:
  - PAT GitHub avec scope `workflow` requis pour pousser le fichier YAML
  - Docker Hub Access Token avec droits Read & Write nécessaire pour le push
- Compatibilité ARM/AMD64 sur macOS Apple Silicon: avertissement anodin lors du run
- Bonnes pratiques: ne jamais partager les jetons; stocker dans GitHub Secrets

---

## 6. Conclusion
L'atelier est réalisé conformément au PDF. À chaque push sur `main`, une image Docker est construite et publiée automatiquement sur Docker Hub, et l'application `/ping` est accessible après `docker run`.

---

## 7. Travaux futurs (extensions du PDF)
- Ajouter des tests unitaires exécutés avant `build-push`
- Tagguer des versions (ex: `v1.0.0`) et publier des releases
- Déployer vers un service managé (Cloud Run/Kubernetes)

---

## 8. Annexes
### 8.1 Commandes clés
```bash
git init && git add . && git commit -m "Initialisation du projet Flask avec Docker"
git remote add origin https://github.com/KalsoumDS/flask-ann-api.git
git branch -M main && git push -u origin main

docker build -t flask-ann-api .
docker run -p 5000:5000 flask-ann-api

git commit -m "Ajout du Dockerfile et test réussi" && git push

git commit --allow-empty -m "trigger CI" && git push

docker pull oumou08/flask-ann-api:latest
# docker run --rm -p 5001:5000 oumou08/flask-ann-api:latest
```

### 8.2 Liens
- Dépôt GitHub: https://github.com/KalsoumDS/flask-ann-api
- Docker Hub (namespace utilisateur): https://hub.docker.com/u/oumou08
- Répertoire image (après premier push): https://hub.docker.com/r/oumou08/flask-ann-api

### 8.3 Captures (à insérer par l'étudiant)
1) Terminal: `git init`, premier commit
2) Page GitHub du dépôt vide puis après push
3) Build Docker local OK
4) Test `/ping` en local
5) Secrets GitHub créés (noms masqués)
6) Workflow Actions: Success
7) Docker Hub: image `flask-ann-api:latest`
8) Pull/run depuis Docker Hub et `/ping`

