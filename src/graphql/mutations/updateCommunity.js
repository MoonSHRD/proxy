import { GraphQLString, GraphQLNonNull, GraphQLList, GraphQLID } from 'graphql';
import { mutationWithClientMutationId, fromGlobalId } from 'graphql-relay';
import { createErrorsType } from '../utils';
import { MonsterCommunityEdge } from '../Community';

const UpdateCommunityErrors = createErrorsType('UpdateCommunity', ['common', 'name']);

export default mutationWithClientMutationId({
  name: 'UpdateCommunity',
  inputFields: {
    id: {
      type: new GraphQLNonNull(GraphQLID),
    },
    name: {
      type: GraphQLString,
    },
    tags: {
      type: new GraphQLList(new GraphQLNonNull(GraphQLID)),
      sqlColumn: 'tags',
    },
    avatarUrl: {
      type: GraphQLString,
    },
  },
  outputFields: {
    edge: {
      type: MonsterCommunityEdge,
    },
    errors: {
      type: UpdateCommunityErrors,
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
      const { type, id } = fromGlobalId(args.id);

      if (type !== 'Community') {
        return {
          errors: {
            id: 'invalid type',
          },
        };
      }

      const data = {
        ...args,
        avatar_url: args.avatarUrl
      };

      delete data.id;
      delete data.avatarUrl;

      const [edge] = await context.db('communities').where({ id }).update(data, ['id']);

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
