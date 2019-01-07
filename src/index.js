import express from 'express';
import graphqlHTTP from 'express-graphql';
import { createServer } from 'http';
import { execute, subscribe } from 'graphql';
import { SubscriptionServer } from 'subscriptions-transport-ws';
import schema from './schema';

const app = express();

app.use('/graphql', graphqlHTTP({
  schema: schema,
  graphiql: true,
  subscriptionsEndpoint: '/subscriptions',
}));

const server = createServer(app);

server.listen(4000, () => {
  new SubscriptionServer({
    execute,
    subscribe,
    schema,
  }, {
    server,
    path: '/subscriptions',
  });
});
