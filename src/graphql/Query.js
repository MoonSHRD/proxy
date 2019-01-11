import { GraphQLObjectType, GraphQLString } from 'graphql';
import { getCachedMatrixClient } from './utils';
import Viewer from './Viewer';

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
  },
});
