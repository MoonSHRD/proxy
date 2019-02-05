import { GraphQLObjectType, GraphQLNonNull, GraphQLString } from 'graphql';
import { mutationWithClientMutationId } from 'graphql-relay';
import pgFormat from 'pg-format';
import { monsterResolve } from './utils';
import Group from './Group';

import createCommunity from './mutations/createCommunity';
import createRoom from './mutations/createRoom';
import joinCommunity from './mutations/joinCommunity';
import leaveCommunity from './mutations/leaveCommunity';
import uploadFile from './mutations/uploadFile';

const uploadGroupAvatar = mutationWithClientMutationId({
  name: 'UploadGroupAvatar',
  inputFields: {
    groupId: {
      type: new GraphQLNonNull(GraphQLString),
    },
    ext: {
      type: new GraphQLNonNull(GraphQLString),
    },
  },
  outputFields: {
    postURL: {
      type: new GraphQLNonNull(GraphQLString),
    },
    formData: {
      type: new GraphQLNonNull(GraphQLString),
    },
    group: {
      type: new GraphQLNonNull(Group),
      where: (t, args, context) => pgFormat(`group_id = %L`, context.groupId),
      resolve: (parent, args, context, resolveInfo) =>
        monsterResolve(parent, args, { ...context, groupId: parent.groupId }, resolveInfo),
    },
  },
  mutateAndGetPayload: async ({ groupId, ext }, context) => {
    // TODO: check auth, check group

    const objectName = `groupAvatar_${groupId.replace('+', '')}.${ext}`;
    const policy = context.minio.newPostPolicy();
    policy.setKey(objectName);
    policy.setBucket('public');
    policy.setContentLengthRange(1024, 1024 * 1024); // Min upload length is 1KB Max upload size is 1MB

    const expires = new Date();
    expires.setSeconds(600); // 10 minutes
    policy.setExpires(expires);

    const data = await context.minio.presignedPostPolicy(policy);
    const url = `http://localhost:9000/public/${objectName}?version=${+new Date()}`;

    await context
      .db('groups')
      .where({ group_id: groupId })
      .update({
        avatar_url: url,
      });

    return {
      groupId,
      postURL: 'http://localhost:9000/public',
      formData: JSON.stringify(data.formData),
    };
  },
});

export default new GraphQLObjectType({
  name: 'Mutation',
  fields: {
    uploadGroupAvatar,
    createCommunity,
    joinCommunity,
    leaveCommunity,
    createRoom,
    uploadFile,
  },
});
