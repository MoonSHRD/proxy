import { GraphQLObjectType, GraphQLNonNull, GraphQLString, GraphQLList } from 'graphql';
import { globalIdField, forwardConnectionArgs } from 'graphql-relay';
import { nodeInterface } from './Node';
import Group from './Group';
import { CommunityConnection } from './Community';

export default new GraphQLObjectType({
  name: 'User',
  interfaces: [nodeInterface],
  sqlTable: 'users',
  uniqueKey: 'name',
  fields: {
    id: {
      ...globalIdField(),
      sqlDeps: ['name'],
    },
    name: {
      type: new GraphQLNonNull(GraphQLString),
    },
    ownCommunities: {
      type: CommunityConnection,
      args: forwardConnectionArgs,
      sqlPaginate: true,
      orderBy: {
        id: 'desc',
      },
      sqlJoin: (t, communityTable) => `${t}.name = ${communityTable}.owner_id`,
    },
    ownGroups: {
      type: new GraphQLNonNull(new GraphQLList(new GraphQLNonNull(Group))),
      junction: {
        sqlTable: 'local_group_membership',
        uniqueKey: ['group_id', 'user_id'],
        where: t => `${t}.is_admin`,
        sqlBatch: {
          thisKey: 'user_id',
          parentKey: 'name',
          sqlJoin: (junctionTable, groupTable) => `${junctionTable}.group_id = ${groupTable}.group_id`,
        },
      },
    },
  },
});
