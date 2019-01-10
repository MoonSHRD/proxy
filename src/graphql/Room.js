import { GraphQLObjectType, GraphQLString, GraphQLNonNull, GraphQLList, GraphQLInt, GraphQLBoolean } from 'graphql';
import { globalIdField } from 'graphql-relay';

import { nodeInterface } from './Node';
import RoomMessage from './RoomMessage';
import Direction from './Direction';

export default new GraphQLObjectType({
  name: 'Room',
  sqlTable: 'rooms',
  uniqueKey: 'room_id',
  interfaces: [nodeInterface],
  fields: {
    id: {
      ...globalIdField(),
      sqlDeps: 'room_id',
    },
    isPublic: {
      type: GraphQLBoolean,
      sqlColumn: 'is_public',
    },
    creator: {
      type: GraphQLString,
    },
    messages: {
      args: {
        from: {
          type: GraphQLString,
        },
        to: {
          type: GraphQLString,
        },
        dir: {
          type: Direction,
        },
        limit: {
          type: GraphQLInt,
        },
      },
      type: new GraphQLNonNull(new GraphQLList(new GraphQLNonNull(RoomMessage))),
    },
  },
});
