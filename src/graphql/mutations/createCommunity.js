import { GraphQLString, GraphQLNonNull, GraphQLList, GraphQLID } from 'graphql';
import { mutationWithClientMutationId } from 'graphql-relay';
import { createErrorsType } from '../utils';
import { MonsterCommunityEdge } from '../Community';

const CreateCommunityErrors = createErrorsType('CreateCommunity', ['common', 'name']);

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
      type: MonsterCommunityEdge,
    },
    errors: {
      type: CreateCommunityErrors,
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
