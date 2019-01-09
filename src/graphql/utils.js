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

    try {
      await client.startClient({ initialSyncLimit: 10 });
    } catch (e) {
      reject(e);
    }

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
