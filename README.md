# Proxy

Start dev server:
```
docker-compose up --build
```

Load dump:
```
docker-compose exec -T db psql synapse -U synapse < synapse.sql
```
