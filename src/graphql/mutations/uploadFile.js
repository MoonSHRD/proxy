import { GraphQLObjectType, GraphQLString, GraphQLNonNull } from 'graphql';
import { mutationWithClientMutationId } from 'graphql-relay';
import uuid from 'uuid/v4';
import path from 'path';
import { createErrorsType } from '../utils';

const UploadFileErrors = createErrorsType('UploadFile', ['common', 'name']);

const PresignedPostPolicy = new GraphQLObjectType({
  name: 'PresignedPostPolicy',
  fields: {
    url: {
      type: new GraphQLNonNull(GraphQLString),
    },
    data: {
      type: new GraphQLNonNull(GraphQLString),
    },
  },
});

export default mutationWithClientMutationId({
  name: 'UploadFile',
  inputFields: {
    name: {
      type: new GraphQLNonNull(GraphQLString),
    },
  },
  outputFields: {
    policy: {
      type: PresignedPostPolicy,
    },
    errors: {
      type: UploadFileErrors,
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
      const data = {
        object_name: uuid() + path.extname(args.name),
        owner_id: context.userId,
      };

      const policy = context.minio.newPostPolicy();
      policy.setKey(data.object_name);
      policy.setBucket('public');
      policy.setContentLengthRange(1024, 1024 * 1024); // Min upload length is 1KB Max upload size is 1MB

      const expires = new Date();
      expires.setSeconds(600); // 10 minutes
      policy.setExpires(expires);

      const presignedPolicy = await context.minio.presignedPostPolicy(policy);

      await context.db('user_files').insert(data);

      return {
        policy: {
          // url: `${presignedPolicy.postURL}/${data.object_name}`,
          url: `http://localhost:9000/public/${data.object_name}`,
          data: JSON.stringify(presignedPolicy.formData),
        },
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
