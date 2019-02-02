import { GraphQLObjectType, GraphQLNonNull, GraphQLList, GraphQLBoolean, GraphQLID } from 'graphql';
import { connectionArgs } from 'graphql-relay';
import { monsterResolve, makeAndWhere } from './utils';
import GroupMembership from './GroupMembership';
import { CommunityUserConnection } from './CommunityUser';
import Room from './Room';

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
    joinedCommunityUsers: {
      type: CommunityUserConnection,
      sqlPaginate: true,
      args: connectionArgs,
      sortKey: {
        order: 'desc',
        key: ['created_at', 'id'],
      },
      sqlBatch: {
        thisKey: 'user_id',
        parentKey: 'name',
      },
    },
    room: {
      type: Room,
      resolve: monsterResolve,
      args: {
        id: {
          type: new GraphQLNonNull(GraphQLID),
        },
      },
      where: makeAndWhere(
        // TODO: check access
        (t, args) => [`${t}.room_id = %L`, args.id]
      ),
    },
  }),
});
