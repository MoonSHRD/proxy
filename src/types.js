import { GraphQLObjectType, GraphQLString, GraphQLNonNull } from 'graphql';

export const MessageContent = new GraphQLObjectType({
  name: 'MessageContent',
  fields: {
    body: {
      type: new GraphQLNonNull(GraphQLString),
    },
    msgtype: {
      type: new GraphQLNonNull(GraphQLString),
    },
  },
});

export const RoomMessage = new GraphQLObjectType({
  name: 'RoomMessage',
  fields: {
    eventId: {
      type: new GraphQLNonNull(GraphQLString)
    },
    roomId: {
      type: new GraphQLNonNull(GraphQLString)
    },
    content: {
      type: new GraphQLNonNull(MessageContent)
    },
  },
});
