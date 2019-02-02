import { GraphQLNonNull, GraphQLID } from 'graphql';
import { mutationWithClientMutationId, fromGlobalId } from 'graphql-relay';
import { createErrorsType, createMonsterEdge } from '../utils';
import CommunityUser from '../CommunityUser';

const JoinCommunityErrors = createErrorsType('JoinCommunity', ['common', 'communityId']);
const JoinCommunityUserEdge = createMonsterEdge(CommunityUser);

export default mutationWithClientMutationId({
  name: 'JoinCommunity',
  inputFields: {
    communityId: {
      type: new GraphQLNonNull(GraphQLID),
    },
  },
  outputFields: {
    userEdge: {
      type: JoinCommunityUserEdge,
    },
    errors: {
      type: JoinCommunityErrors,
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

      const data = {
        user_id: context.userId,
        community_id: communityId,
      };

      const [userEdge] = await context.db('community_users').insert(data, ['id']);

      // pass id to resolve edge
      return { userEdge };
    } catch (e) {
      if (e.constraint === 'community_users_uniq') {
        return {
          errors: {
            communityId: 'Вы уже присоеденились к этому сообществу.',
          },
        };
      }

      return {
        errors: {
          common: e.message,
        },
      };
    }
  },
});
