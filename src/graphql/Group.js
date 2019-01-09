import { GraphQLObjectType, GraphQLNonNull, GraphQLBoolean, GraphQLString } from 'graphql';

export default new GraphQLObjectType({
  name: 'Group',
  sqlTable: 'groups',
  uniqueKey: 'group_id',
  fields: {
    groupId: {
      type: new GraphQLNonNull(GraphQLString),
    },
    name: {
      type: GraphQLString,
    },
    avatarUrl: {
      type: GraphQLString,
      sqlColumn: 'avatar_url',
    },
    shortDescription: {
      type: GraphQLString,
      sqlColumn: 'short_description',
    },
    longDescription: {
      type: GraphQLString,
      sqlColumn: 'long_description',
    },
    isPublic: {
      type: GraphQLBoolean,
      sqlColumn: 'is_public',
    },
    joinPolicy: {
      type: GraphQLString,
      sqlColumn: 'join_policy',
    },
  },
});
