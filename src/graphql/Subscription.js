import { GraphQLObjectType, GraphQLString, GraphQLNonNull } from 'graphql';
import { subscriptionWithClientId } from 'graphql-relay-subscription';
import { makeMatrixSubscribe } from './utils';
import RoomMessage from './RoomMessage';

const newRoomMessage = subscriptionWithClientId({
  name: 'NewRoomMessage',
  inputFields: {
    roomId: {
      type: new GraphQLNonNull(GraphQLString),
    },
  },
  outputFields: {
    event: {
      type: new GraphQLNonNull(RoomMessage),
    },
  },
  subscribe: makeMatrixSubscribe('Room.timeline', e => e.getType() === 'm.room.message'),
});

export default new GraphQLObjectType({
  name: 'Subscription',
  fields: {
    newRoomMessage,
  },
});
