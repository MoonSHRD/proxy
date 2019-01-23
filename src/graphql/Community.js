import { GraphQLObjectType, GraphQLNonNull, GraphQLString, GraphQLID, GraphQLList, GraphQLInt } from 'graphql';
import { globalIdField, connectionDefinitions } from 'graphql-relay';

const Community = new GraphQLObjectType({
  name: 'Community',
  sqlTable: 'communities',
  uniqueKey: 'id',
  fields: {
    id: {
      ...globalIdField(),
      sqlDeps: ['id'],
    },
    rowId: {
      type: new GraphQLNonNull(GraphQLInt),
      sqlColumn: 'id',
    },
    ownerId: {
      type: new GraphQLNonNull(GraphQLID),
      sqlColumn: 'owner_id',
    },
    name: {
      type: new GraphQLNonNull(GraphQLString),
    },
    shortDescription: {
      type: new GraphQLNonNull(GraphQLString),
      sqlColumn: 'short_description',
    },
    avatarUrl: {
      type: GraphQLString,
      sqlColumn: 'avatar_url',
    },
    userCount: {
      type: new GraphQLNonNull(GraphQLInt),
      sqlColumn: 'user_count',
    },
    roomIds: {
      type: new GraphQLNonNull(new GraphQLList(new GraphQLNonNull(GraphQLID))),
      sqlColumn: 'room_ids',
    },
    tags: {
      type: new GraphQLNonNull(new GraphQLList(new GraphQLNonNull(GraphQLID))),
      sqlColumn: 'tags',
    },
    generalRoomId: {
      type: new GraphQLNonNull(GraphQLID),
      sqlColumn: 'general_room_id',
    },
  },
});

const { connectionType: CommunityConnection, edgeType: CommunityEdge } = connectionDefinitions({
  nodeType: Community,
});

export { CommunityConnection, CommunityEdge };

export default Community;
