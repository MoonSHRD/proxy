import express from 'express';
import graphqlHTTP from 'express-graphql';
import cors from 'cors';
import sdk from 'matrix-js-sdk';
import { createServer } from 'http';
import { execute, subscribe } from 'graphql';
import { SubscriptionServer } from 'subscriptions-transport-ws';
import { startCachedMatrixClient, stopCachedMatrixClient } from './graphql/utils';
import schema from './graphql/schema';
import db from './db';
import minio from './minio';

const app = express();
const port = process.env.PORT || 4000;

if (process.env.NODE_ENV !== 'production') {
  app.use(cors());
}

const formatError = error => {
  console.log(error);

  return {
    message: error.message,
    locations: error.locations,
    stack: error.stack ? error.stack.split('\n') : [],
    path: error.path,
  };
};

app.use(
  '/graphql',
  graphqlHTTP(req => ({
    schema,
    graphiql: true,
    subscriptionsEndpoint: '/subscriptions',
    context: {
      db,
      minio,
      matrixClient: sdk.createClient({
        baseUrl: process.env.MATRIX_ENDPOINT,
        accessToken: req.get('X-Access-Token'),
        userId: req.get('X-User-ID'),
      }),
      accessToken: req.get('X-Access-Token'),
      userId: req.get('X-User-ID'),
    },
    formatError,
  }))
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
        console.log('params', params);
        // eslint-disable-next-line no-param-reassign
        context.matrixClient = startCachedMatrixClient(params).catch(e => {
          console.error('catch matrix error', e);
          ws.close();
        });

        return {
          ...params,
          matrixClient: context.matrixClient,
        };
      },
      onDisconnect: (ws, context) => {
        if (context.matrixClient) {
          context.matrixClient.then(stopCachedMatrixClient);
        }
      },
    },
    {
      server,
      path: '/subscriptions',
    }
  );

  console.log(`App listening on port ${port}...`);
});
