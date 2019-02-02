import { GraphQLObjectType, GraphQLNonNull, GraphQLList, GraphQLBoolean, GraphQLID } from 'graphql';
import { connectionArgs, toGlobalId } from 'graphql-relay';
import { monsterResolve, makeAndWhere } from './utils';
import GroupMembership from './GroupMembership';
import { CommunityUserConnection } from './CommunityUser';

export default new GraphQLObjectType({
  name: 'Viewer',
  sqlTable: 'users',
  uniqueKey: 'name',
  fields: () => ({
    id: {
      type: new GraphQLNonNull(GraphQLID),
      resolve: (parent, args, context) => context.userId,
    },
    groupMembership: {
      type: new GraphQLNonNull(new GraphQLList(new GraphQLNonNull(GroupMembership))),
      resolve: monsterResolve,
      args: {
        isAdmin: {
          type: GraphQLBoolean,
        },
      },
      where: makeAndWhere(
        (t, args, ctx) => [`${t}.user_id = %L`, ctx.matrixClient.getUserId()],
        (t, args) => args.isAdmin && [`${t}.is_admin`]
      ),
    },
    joinedCommunityIds: {
      type: new GraphQLNonNull(new GraphQLList(new GraphQLNonNull(GraphQLID))),
      resolve: async (parent, args, context) => {
        const ids = await context
          .db('community_users')
          .where({ user_id: parent.name })
          .pluck('community_id');
        return ids.map(id => toGlobalId('Community', id));
      },
    },
    joinedCommunityUsers: {
      type: CommunityUserConnection,
      sqlPaginate: true,
      args: {
        communityIds: {
          description: 'for check subscription',
          type: new GraphQLList(new GraphQLNonNull(GraphQLID)),
        },
        ...connectionArgs,
      },
      sortKey: {
        order: 'desc',
        key: ['created_at', 'id'],
      },
      sqlBatch: {
        thisKey: 'user_id',
        parentKey: 'name',
      },
    },
  }),
});
