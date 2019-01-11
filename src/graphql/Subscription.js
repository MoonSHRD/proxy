import { GraphQLObjectType, GraphQLNonNull, GraphQLID } from 'graphql';
import { subscriptionWithClientId } from 'graphql-relay-subscription';
import { pubsub, withFilter } from './utils';
import { RoomMessageEdge } from './RoomMessage';

const newRoomMessage = subscriptionWithClientId({
  name: 'NewRoomMessage',
  inputFields: {
    roomId: {
      type: new GraphQLNonNull(GraphQLID),
    },
  },
  outputFields: {
    edge: {
      type: new GraphQLNonNull(RoomMessageEdge),
    },
  },
  subscribe: withFilter(
    (_, context) => pubsub.asyncIterator(`room.timeline:${context.accessToken}`),
    (payload, args) => payload.edge.node.type === 'm.room.message' && payload.edge.node.roomId === args.roomId
  ),
});

export default new GraphQLObjectType({
  name: 'Subscription',
  fields: {
    newRoomMessage,
  },
});
