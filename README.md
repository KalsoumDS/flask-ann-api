# Flask ANN API

API Flask simple avec endpoint `/ping` retournant `{"status":"ok"}`.

## Utilisation

### Local
```bash
python app/app.py
# http://127.0.0.1:5000/ping
```

### Docker
```bash
docker run --rm -p 5000:5000 oumou08/flask-ann-api:latest
# http://127.0.0.1:5000/ping
```

## Endpoints
- `GET /ping` - Retourne `{"status":"ok"}`
