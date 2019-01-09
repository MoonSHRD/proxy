import { GraphQLObjectType, GraphQLNonNull, GraphQLList, GraphQLBoolean } from 'graphql';
import { monsterResolve, makeAndWhere } from './utils';
import GroupMembership from './GroupMembership';

export default new GraphQLObjectType({
  name: 'Viewer',
  fields: {
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
  },
});
