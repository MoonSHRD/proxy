import { GraphQLObjectType, GraphQLString, GraphQLNonNull, GraphQLBoolean, GraphQLID } from 'graphql';
import { connectionArgs, connectionFromArray } from 'graphql-relay';

import { nodeInterface } from './Node';
import { RoomMessageConnection } from './RoomMessage';

export default new GraphQLObjectType({
  name: 'Room',
  sqlTable: 'rooms',
  uniqueKey: 'room_id',
  interfaces: [nodeInterface],
  fields: {
    id: {
      type: new GraphQLNonNull(GraphQLID),
      sqlColumn: 'room_id',
    },
    isPublic: {
      type: GraphQLBoolean,
      sqlColumn: 'is_public',
    },
    creator: {
      type: GraphQLString,
    },
    messages: {
      args: connectionArgs,
      type: RoomMessageConnection,
      // TODO: load latest messages
      resolve: (room, args) => connectionFromArray([], args),
    },
  },
});
