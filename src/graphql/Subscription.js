import { GraphQLObjectType, GraphQLString, GraphQLNonNull } from 'graphql';
import { subscriptionWithClientId } from 'graphql-relay-subscription';
import { $$asyncIterator } from 'iterall';
import { camelizeKeys } from 'humps';
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
  subscribe: (args, context) => ({
    next() {
      return context.matrixClient.then(
        client =>
          new Promise(resolve => {
            client.on('Room.timeline', e => {
              if (e.getType() === 'm.room.message') {
                resolve({ value: { event: camelizeKeys(e.event) }, done: false });
              }
            });
          })
      );
    },
    return() {
      return Promise.resolve({ value: undefined, done: true });
    },
    throw(error) {
      return Promise.reject(error);
    },
    [$$asyncIterator]() {
      return this;
    },
  }),
});

export default new GraphQLObjectType({
  name: 'Subscription',
  fields: {
    newRoomMessage,
  },
});
