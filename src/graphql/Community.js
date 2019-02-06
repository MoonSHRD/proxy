import { GraphQLObjectType, GraphQLNonNull, GraphQLString, GraphQLID, GraphQLList, GraphQLInt } from 'graphql';
import { globalIdField, connectionDefinitions, connectionArgs } from 'graphql-relay';
import { RoomConnection } from './Room';
import { CommunityUserConnection } from './CommunityUser';
import { createMonsterEdge } from './utils';

const Community = new GraphQLObjectType({
  name: 'Community',
  sqlTable: 'communities',
  uniqueKey: 'id',
  fields: () => ({
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
    rooms: {
      type: RoomConnection,
      args: connectionArgs,
      sqlPaginate: true,
      orderBy: 'room_id',
      sqlJoin: (t, roomTable) => `${roomTable}.room_id = any (${t}.room_ids)`,
    },
    communityUsers: {
      type: CommunityUserConnection,
      args: connectionArgs,
      sqlPaginate: true,
      orderBy: 'created_at',
      sqlJoin: (t, communityUserTable) => `${t}.id = ${communityUserTable}.community_id`,
    },
  }),
});

const MonsterCommunityEdge = createMonsterEdge(Community);

const { connectionType: CommunityConnection, edgeType: CommunityEdge } = connectionDefinitions({
  nodeType: Community,
});

export { CommunityConnection, CommunityEdge, MonsterCommunityEdge };

export default Community;
