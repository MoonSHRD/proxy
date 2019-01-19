import { GraphQLObjectType, GraphQLString, GraphQLNonNull, GraphQLID, GraphQLList } from 'graphql';
import pgFormat from 'pg-format';
import { monsterResolve, getCachedMatrixClient } from './utils';
import { nodeField } from './Node';
import Viewer from './Viewer';
import User from './User';
import Group from './Group';

export default new GraphQLObjectType({
  name: 'Query',
  fields: {
    node: nodeField,
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
    user: {
      type: User,
      args: {
        id: {
          type: new GraphQLNonNull(GraphQLID),
        },
      },
      where: (t, args) => pgFormat(`${t}.name = %L`, args.id),
      resolve: monsterResolve,
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
    groups: {
      type: new GraphQLNonNull(new GraphQLList(new GraphQLNonNull(Group))),
      resolve: monsterResolve,
    },
  },
});
