import { GraphQLObjectType, GraphQLString, GraphQLNonNull, GraphQLID, GraphQLList, GraphQLInt } from 'graphql';

import RoomMessage from './RoomMessage';
import Direction from './Direction';

export default new GraphQLObjectType({
  name: 'Room',
  fields: {
    id: {
      type: new GraphQLNonNull(GraphQLID),
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
