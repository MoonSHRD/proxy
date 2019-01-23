import { GraphQLObjectType, GraphQLNonNull, GraphQLList, GraphQLBoolean, GraphQLID } from 'graphql';
import { monsterResolve, makeAndWhere } from './utils';
import GroupMembership from './GroupMembership';
import Room from './Room';

export default new GraphQLObjectType({
  name: 'Viewer',
  fields: {
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
  },
});
