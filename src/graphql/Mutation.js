import { GraphQLObjectType, GraphQLNonNull, GraphQLID, GraphQLBoolean, GraphQLString } from 'graphql';
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

const uploadContent = mutationWithClientMutationId({
  name: 'UploadContent',
  inputFields: {
    file: {
      type: new GraphQLNonNull(GraphQLString),
    },
  },
  outputFields: {
    contentUri: {
      type: new GraphQLNonNull(GraphQLString),
    },
  },
  mutateAndGetPayload: async ({ file }, ctx) => {
    const opts = {
      onlyContentUri: true,
    };

    console.log(ctx);

    // const res = await ctx.matrixClient.uploadContent(file, opts);
    // console.log(res);

    // return res;
    return 'asdad';
  }
});

export default new GraphQLObjectType({
  name: 'Mutation',
  fields: {
    join,
    leave,
    uploadContent,
  },
});
