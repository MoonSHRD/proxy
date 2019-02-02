import { GraphQLNonNull, GraphQLID } from 'graphql';
import { mutationWithClientMutationId, fromGlobalId, toGlobalId } from 'graphql-relay';
import { createErrorsType } from '../utils';
import CommunityUser from '../CommunityUser';

const LeaveCommunityErrors = createErrorsType('LeaveCommunity', ['common', 'communityId']);

export default mutationWithClientMutationId({
  name: 'LeaveCommunity',
  inputFields: {
    communityId: {
      type: new GraphQLNonNull(GraphQLID),
    },
  },
  outputFields: {
    deletedId: {
      type: GraphQLID,
    },
    errors: {
      type: LeaveCommunityErrors,
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
      const { type, id: communityId } = fromGlobalId(args.communityId);

      if (type !== 'Community') {
        return {
          errors: {
            communityId: 'invalid type',
          },
        };
      }

      const condition = { user_id: context.userId, community_id: communityId };
      const [rowId] = await context
        .db('community_users')
        .where(condition)
        .del()
        .returning('id');

      if (!rowId) {
        return {
          errors: {
            common: 'Вы не участник сообщества.',
          },
        };
      }

      return {
        deletedId: toGlobalId(CommunityUser.name, rowId),
      };
    } catch (e) {
      return {
        errors: {
          common: e.message,
        },
      };
    }
  },
});
