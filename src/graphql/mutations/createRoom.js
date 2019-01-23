import { GraphQLString, GraphQLNonNull, GraphQLID } from 'graphql';
import { mutationWithClientMutationId, fromGlobalId } from 'graphql-relay';
import { createErrorsType, createMonsterEdge } from '../utils';
import Room from '../Room';

const CreateRoomErrors = createErrorsType('CreateRoom', ['common', 'name']);
const CreatedRoomEdge = createMonsterEdge(Room, 'room_id');

export default mutationWithClientMutationId({
  name: 'CreateRoom',
  inputFields: {
    communityId: {
      type: new GraphQLNonNull(GraphQLID),
    },
    name: {
      type: new GraphQLNonNull(GraphQLString),
    },
  },
  outputFields: {
    edge: {
      type: CreatedRoomEdge,
    },
    errors: {
      type: CreateRoomErrors,
    },
  },
  mutateAndGetPayload: async (args, context) => {
    if (!context.userId) {
      return {
        errors: {
          common: 'unauthorized',
        },
      };
    }

    const { type, id: communityId } = fromGlobalId(args.communityId);

    if (type !== 'Community') {
      return {
        errors: {
          common: 'invalid id',
        },
      };
    }

    if (args.name.length < 2) {
      return {
        errors: {
          name: 'to short',
        },
      };
    }

    const { room_id: roomId } = await context.matrixClient.createRoom({
      name: args.name,
    });

    const data = {
      room_ids: context.db.raw('array_append(room_ids, ?)', roomId),
    };

    await context
      .db('communities')
      .update(data)
      .where({ id: communityId });

    return {
      edge: { id: roomId },
    };
  },
});
