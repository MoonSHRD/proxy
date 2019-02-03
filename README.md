# Proxy

Start dev server:
```
docker-compose up --build
```

Then open http://localhost:3000/graphiql

Migrate:
```
docker-compose exec -T db psql synapse -U synapse < migrations.sql
```

### Tips

Show only proxy logs
```
docker-compose logs --tail=200 -f proxy
```

Psql:
```
docker-compose exec db psql synapse -U synapse
```

### GraphQL

Join & Leave mutations:
```
mutation {
  joinCommunity(input: { communityId: "Q29tbXVuaXR5OjE=" }) {
    userEdge {
      node {
        id
      }
    }
    errors {
      common
      communityId
    }
  }

  leaveCommunity(input: { communityId: "Q29tbXVuaXR5OjE=" }) {
    deletedId

    errors {
      common
      communityId
    }
  }
}
```
