import { GraphQLObjectType, GraphQLString, GraphQLNonNull, GraphQLID } from 'graphql';
import pgFormat from 'pg-format';
import { monsterResolve, getCachedMatrixClient } from './utils';
import Viewer from './Viewer';
import Group from './Group';

export default new GraphQLObjectType({
  name: 'Query',
  fields: {
    viewer: {
      type: Viewer,
      args: {
        accessToken: {
          type: GraphQLString,
        },
        userId: {
          type: GraphQLString,
        },
      },
      resolve: async (_, args, context) => {
        const matrixClient = await getCachedMatrixClient({
          ...context,
          ...args,
        });

        return {
          matrixClient,
        };
      },
    },
    group: {
      type: Group,
      args: {
        id: {
          type: new GraphQLNonNull(GraphQLID),
        },
      },
      where: (t, args) => pgFormat(`${t}.group_id = %L`, args.id),
      resolve: monsterResolve,
    },
  },
});
