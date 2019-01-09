import joinMonster from 'join-monster';
import sdk from 'matrix-js-sdk';
import pgFormat from 'pg-format';

export const monsterResolve = (parent, args, context, resolveInfo) =>
  joinMonster(resolveInfo, { ...context, matrixClient: parent.matrixClient }, sql => context.db.raw(sql));

export const makeAndWhere = (...fns) => (...args) =>
  fns
    .map(f => f(...args))
    .filter(Boolean)
    .map(query => pgFormat(...query))
    .join(' and ');

const matrixCache = {};

export const getCachedMatrixClient = async ({ accessToken, userId }) => {
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
