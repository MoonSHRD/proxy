import express from 'express';
import graphqlHTTP from 'express-graphql';
import { createServer } from 'http';
import { execute, subscribe } from 'graphql';
import { SubscriptionServer } from 'subscriptions-transport-ws';
import schema from './graphql/schema';
import db from './db';

const app = express();
const port = process.env.PORT || 4000;

app.use(
  '/graphql',
  graphqlHTTP({
    schema,
    graphiql: true,
    subscriptionsEndpoint: '/subscriptions',
    context: { db },
    formatError: error => ({
      message: error.message,
      locations: error.locations,
      stack: error.stack ? error.stack.split('\n') : [],
      path: error.path,
    }),
  })
);

const server = createServer(app);

server.listen(port, () => {
  // eslint-disable-next-line no-new
  new SubscriptionServer(
    {
      execute,
      subscribe,
      schema,
    },
    {
      server,
      path: '/subscriptions',
    }
  );

  console.log(`App listening on port ${port}...`);
});
