import { GraphQLObjectType, GraphQLNonNull, GraphQLID, GraphQLBoolean } from 'graphql';
import { mutationWithClientMutationId } from 'graphql-relay';

const join = mutationWithClientMutationId({
  name: 'Join',
  inputFields: {
    groupId: {
      type: new GraphQLNonNull(GraphQLID),
    },
  },
  outputFields: {
    success: {
      type: new GraphQLNonNull(GraphQLBoolean),
    },
  },
  mutateAndGetPayload: (/* args, context */) => ({
    success: true,
  }),
});

const leave = mutationWithClientMutationId({
  name: 'Leave',
  inputFields: {
    groupId: {
      type: new GraphQLNonNull(GraphQLID),
    },
  },
  outputFields: {
    success: {
      type: new GraphQLNonNull(GraphQLBoolean),
    },
  },
  mutateAndGetPayload: (/* args, context */) => ({
    success: true,
  }),
});

export default new GraphQLObjectType({
  name: 'Mutation',
  fields: {
    join,
    leave,
  },
});
