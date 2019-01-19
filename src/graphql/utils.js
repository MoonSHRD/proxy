import joinMonster from 'join-monster';
import sdk from 'matrix-js-sdk';
import { PubSub } from 'graphql-subscriptions';
import { camelizeKeys } from 'humps';
import { $$asyncIterator } from 'iterall';
import pgFormat from 'pg-format';

export const monsterResolve = (parent, args, context, resolveInfo) =>
  joinMonster(resolveInfo, { ...context, matrixClient: parent && parent.matrixClient }, sql => {
    console.log(sql);
    return context.db.raw(sql);
  });

export const makeAndWhere = (...fns) => (...args) =>
  fns
    .map(f => f(...args))
    .filter(Boolean)
    .map(query => pgFormat(...query))
    .join(' and ');

const matrixCache = {};
export const pubsub = new PubSub();

export const getCachedMatrixClient = async ({ accessToken, userId }) => {
  if (!accessToken) {
    throw new Error('accessToken not found');
  }

  if (!userId) {
    throw new Error('userId not found');
  }

  if (matrixCache[accessToken]) {
    return matrixCache[accessToken];
  }

  const promise = new Promise(async (resolve, reject) => {
    const client = sdk.createClient({
      baseUrl: process.env.MATRIX_ENDPOINT,
      accessToken,
      userId,
    });

    const whoami = (err, data) => {
      if (err || !data || data.user_id !== userId) {
        reject(err);
      } else {
        client.on('Room.timeline', e => {
          pubsub.publish(`room.timeline:${accessToken}`, {
            edge: {
              node: camelizeKeys(e.event),
            },
          });
        });

        resolve(client);
      }
    };

    // eslint-disable-next-line no-underscore-dangle
    client._http.authedRequest(whoami, 'GET', '/account/whoami');
  });

  matrixCache[accessToken] = promise;

  return promise;
};

export const startCachedMatrixClient = async params => {
  const client = await getCachedMatrixClient(params);

  if (!client.proxyStartCount) {
    await client.startClient({ initialSyncLimit: 10 });
    client.proxyStartCount = 1;
  } else {
    client.proxyStartCount += 1;
  }

  return client;
};

export const stopCachedMatrixClient = client => {
  // eslint-disable-next-line no-param-reassign
  client.proxyStartCount -= 1;

  if (client.proxyStartCount === 0) {
    client.stopClient();
  }
};

const identity = x => x;

export const makeMatrixSubscribe = (event, transform = identity) => (args, context) => ({
  next() {
    return context.matrixClient.then(
      client =>
        new Promise(resolve => {
          client.once(event, e => {
            const value = camelizeKeys(transform(e, args, context));

            if (value) {
              resolve({ value, done: false });
            }
          });
        })
    );
  },
  return() {
    return Promise.resolve({ value: undefined, done: true });
  },
  throw(error) {
    return Promise.reject(error);
  },
  [$$asyncIterator]() {
    return this;
  },
});

export const withFilter = (asyncIteratorFn, filterFn) => (args, context, info) => {
  const asyncIterator = asyncIteratorFn(args, context, info);

  const getNextPromise = () =>
    asyncIterator.next().then(payload => {
      if (payload.done === true) {
        return payload;
      }

      return Promise.resolve(filterFn(payload.value, args, context, info))
        .catch(() => false)
        .then(filterResult => {
          if (filterResult === true) {
            return payload;
          }

          // Skip the current value and wait for the next one
          return getNextPromise();
        });
    });

  return {
    next() {
      return getNextPromise();
    },
    return() {
      return asyncIterator.return();
    },
    throw(error) {
      return asyncIterator.throw(error);
    },
    [$$asyncIterator]() {
      return this;
    },
  };
};
