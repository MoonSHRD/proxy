import { GraphQLObjectType, GraphQLString, GraphQLNonNull } from 'graphql';
import { globalIdField, connectionDefinitions } from 'graphql-relay';
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
