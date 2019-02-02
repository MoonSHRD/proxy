import { GraphQLObjectType, GraphQLString, GraphQLNonNull, GraphQLID } from 'graphql';
import { globalIdField, connectionDefinitions, toGlobalId } from 'graphql-relay';
import Community from './Community';
import User from './User';

const CommunityUser = new GraphQLObjectType({
  name: 'CommunityUser',
  sqlTable: 'community_users',
  uniqueKey: 'id',
  fields: () => ({
    id: {
      ...globalIdField(),
      sqlDeps: ['id'],
    },
    communityId: {
      type: new GraphQLNonNull(GraphQLID),
      sqlDeps: ['community_id'],
      resolve: row => toGlobalId('Community', row.community_id),
    },
    userId: {
      type: new GraphQLNonNull(GraphQLID),
      sqlDeps: ['user_id'],
      resolve: row => toGlobalId('User', row.user_id),
    },
    community: {
      type: new GraphQLNonNull(Community),
      sqlJoin: (t, communityTable) => `${t}.community_id = ${communityTable}.id`,
    },
    user: {
      type: new GraphQLNonNull(User),
      sqlJoin: (t, userTable) => `${t}.user_id = ${userTable}.name`,
    },
    createdAt: {
      type: new GraphQLNonNull(GraphQLString),
      sqlColumn: 'created_at',
    },
  }),
});

const { connectionType: CommunityUserConnection, edgeType: CommunityUserEdge } = connectionDefinitions({
  nodeType: CommunityUser,
});

export { CommunityUserConnection, CommunityUserEdge };

export default CommunityUser;
