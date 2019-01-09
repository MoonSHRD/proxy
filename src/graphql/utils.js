import joinMonster from 'join-monster';
import pgFormat from 'pg-format';

export const monsterResolve = (parent, args, context, resolveInfo) =>
  joinMonster(resolveInfo, { ...context, matrixClient: parent.matrixClient }, sql => context.db.raw(sql));

export const makeAndWhere = (...fns) => (...args) =>
  fns
    .map(f => f(...args))
    .filter(Boolean)
    .map(query => pgFormat(...query))
    .join(' and ');
