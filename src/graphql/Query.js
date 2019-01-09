import { GraphQLObjectType, GraphQLString } from 'graphql';
import sdk from 'matrix-js-sdk';
import Viewer from './Viewer';

export default new GraphQLObjectType({
  name: 'Query',
  fields: {
    viewer: {
      type: Viewer,
      args: {
        token: {
          type: GraphQLString,
        },
        userId: {
          type: GraphQLString,
        },
      },
      resolve: (_, args) => ({
        matrixClient: sdk.createClient({
          baseUrl: 'https://13.59.234.201.xip.io',
          // TODO: check auth data
          accessToken: args.token,
          userId: args.userId,
        }),
      }),
    },
  },
});
