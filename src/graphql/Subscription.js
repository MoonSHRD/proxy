import { GraphQLObjectType, GraphQLString, GraphQLNonNull } from 'graphql';
import { subscriptionWithClientId } from 'graphql-relay-subscription';
import { PubSub } from 'graphql-subscriptions';
import RoomMessage from './RoomMessage';

const pubsub = new PubSub();

setInterval(() => {
  pubsub.publish('newRoomMessageChannel', {
    message: {
      eventId: 'uniqeventid',
      roomId: 'test',
      content: {
        body: 'test',
        msgtype: 't.text',
      },
    },
  });
}, 1000);

const newRoomMessage = subscriptionWithClientId({
  name: 'NewRoomMessage',
  inputFields: {
    roomId: {
      type: new GraphQLNonNull(GraphQLString),
    },
  },
  outputFields: {
    message: {
      type: new GraphQLNonNull(RoomMessage),
    },
  },
  subscribe: () => pubsub.asyncIterator('newRoomMessageChannel'),
});

export default new GraphQLObjectType({
  name: 'Subscription',
  fields: {
    newRoomMessage,
  },
});
