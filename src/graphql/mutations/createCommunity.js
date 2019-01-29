import { GraphQLString, GraphQLNonNull, GraphQLList, GraphQLID } from 'graphql';
import { mutationWithClientMutationId } from 'graphql-relay';
import { createErrorsType, createMonsterEdge } from '../utils';
import Community from '../Community';

const CreateCommunityErrors = createErrorsType('CreateCommunity', ['common', 'name']);
const CreatedCommunityEdge = createMonsterEdge(Community);

export default mutationWithClientMutationId({
  name: 'CreateCommunity',
  inputFields: {
    name: {
      type: new GraphQLNonNull(GraphQLString),
    },
    tags: {
      type: new GraphQLNonNull(new GraphQLList(new GraphQLNonNull(GraphQLID))),
      sqlColumn: 'tags',
    },
  },
  outputFields: {
    edge: {
      type: CreatedCommunityEdge,
    },
    errors: {
      type: CreateCommunityErrors,
    },
  },
  mutateAndGetPayload: async (args, context) => {
    console.log('start');
    if (!context.userId) {
      return {
        errors: {
          common: 'unauthorized',
        },
      };
    }

    try {
      const { room_id: roomId } = await context.matrixClient.createRoom({
        name: 'general',
      });

      const data = {
        ...args,
        owner_id: context.userId,
        general_room_id: roomId,
        room_ids: [roomId],
      };

      const [edge] = await context.db('communities').insert(data, ['id']);

      // pass id to resolve edge
      return { edge };
    } catch (e) {
      return {
        errors: {
          common: e.message,
        },
      };
    }
  },
});
