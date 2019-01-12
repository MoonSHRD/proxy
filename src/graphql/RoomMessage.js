import { GraphQLObjectType, GraphQLNonNull, GraphQLID, GraphQLString } from 'graphql';
import { connectionDefinitions } from 'graphql-relay';

const MessageContent = new GraphQLObjectType({
  name: 'MessageContent',
  fields: {
    body: {
      type: GraphQLString,
    },
  },
});

const RoomMessage = new GraphQLObjectType({
  name: 'RoomMessage',
  fields: {
    id: {
      type: new GraphQLNonNull(GraphQLID),
      resolve: m => m.eventId,
    },
    roomId: {
      type: new GraphQLNonNull(GraphQLString),
    },
    sender: {
      type: GraphQLString,
    },
    age: {
      type: GraphQLString,
      resolve: m => m.unsigned.ageTs,
    },
    content: {
      type: new GraphQLNonNull(MessageContent),
    },
  },
});

const { connectionType: RoomMessageConnection, edgeType: RoomMessageEdge } = connectionDefinitions({
  nodeType: RoomMessage,
});

export { RoomMessageConnection, RoomMessageEdge };
export default RoomMessage;
