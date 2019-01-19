import { GraphQLObjectType, GraphQLNonNull, GraphQLString, GraphQLList } from 'graphql';
import { globalIdField } from 'graphql-relay';
import { nodeInterface } from './Node';
import Group from './Group';

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
