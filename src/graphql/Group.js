import { GraphQLObjectType, GraphQLNonNull, GraphQLBoolean, GraphQLString, GraphQLID } from 'graphql';
import { nodeInterface } from './Node';

export default new GraphQLObjectType({
  name: 'Group',
  sqlTable: 'groups',
  uniqueKey: 'group_id',
  interfaces: [nodeInterface],
  fields: {
    id: {
      type: new GraphQLNonNull(GraphQLID),
      sqlColumn: 'group_id',
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
