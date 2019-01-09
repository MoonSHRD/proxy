import { GraphQLObjectType, GraphQLNonNull, GraphQLBoolean, GraphQLString } from 'graphql';
import Group from './Group';

export default new GraphQLObjectType({
  name: 'GroupMembership',
  sqlTable: 'local_group_membership',
  uniqueKey: ['group_id', 'user_id'],
  fields: {
    groupId: {
      type: new GraphQLNonNull(GraphQLString),
    },
    userId: {
      type: new GraphQLNonNull(GraphQLString),
    },
    isAdmin: {
      type: new GraphQLNonNull(GraphQLBoolean),
      sqlColumn: 'is_admin',
    },
    membership: {
      type: new GraphQLNonNull(GraphQLString),
    },
    isPublicised: {
      type: new GraphQLNonNull(GraphQLBoolean),
      sqlColumn: 'is_publicised',
    },
    content: {
      type: new GraphQLNonNull(GraphQLString),
    },
    group: {
      type: new GraphQLNonNull(Group),
      sqlJoin: (t, groupTable) => `${t}.group_id = ${groupTable}.group_id`,
    },
  },
});
