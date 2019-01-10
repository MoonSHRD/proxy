import express from 'express';
import graphqlHTTP from 'express-graphql';
import cors from 'cors';
import { createServer } from 'http';
import { execute, subscribe } from 'graphql';
import { SubscriptionServer } from 'subscriptions-transport-ws';
import { startCachedMatrixClient, stopCachedMatrixClient } from './graphql/utils';
import schema from './graphql/schema';
import db from './db';

const app = express();
const port = process.env.PORT || 4000;

if (process.env.NODE_ENV !== 'production') {
  app.use(cors());
}

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
      onConnect: (params, ws, context) => {
        // eslint-disable-next-line no-param-reassign
        context.matrixClient = startCachedMatrixClient(params);

        return {
          ...params,
          matrixClient: context.matrixClient,
        };
      },
      onDisconnect: (ws, context) => {
        context.matrixClient.then(stopCachedMatrixClient);
      },
    },
    {
      server,
      path: '/subscriptions',
    }
  );

  console.log(`App listening on port ${port}...`);
});
