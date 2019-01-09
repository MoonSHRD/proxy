import { GraphQLObjectType, GraphQLNonNull, GraphQLID, GraphQLString } from 'graphql';

const MessageContent = new GraphQLObjectType({
  name: 'MessageContent',
  fields: {
    body: {
      type: GraphQLString,
    },
  },
});

export default new GraphQLObjectType({
  name: 'RoomMessage',
  fields: {
    id: {
      type: new GraphQLNonNull(GraphQLID),
    },
    roomId: {
      type: new GraphQLNonNull(GraphQLString),
    },
    content: {
      type: new GraphQLNonNull(MessageContent),
    },
  },
});
