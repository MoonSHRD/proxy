import { GraphQLObjectType, GraphQLNonNull, GraphQLBoolean, GraphQLString, GraphQLID, GraphQLList } from 'graphql';
import { connectionDefinitions } from 'graphql-relay';
import { nodeInterface } from './Node';
import Room from './Room';

const Group = new GraphQLObjectType({
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
    rooms: {
      type: new GraphQLNonNull(new GraphQLList(new GraphQLNonNull(Room))),
      junction: {
        sqlTable: 'group_rooms',
        uniqueKey: ['group_id', 'room_id'],
        sqlBatch: {
          thisKey: 'group_id',
          parentKey: 'group_id',
          sqlJoin: (junctionTable, roomTable) => `${junctionTable}.room_id = ${roomTable}.room_id`,
        },
      },
    },
  },
});

const { connectionType: GroupConnection, edgeType: GroupEdge } = connectionDefinitions({
  nodeType: Group,
});

export { GroupConnection, GroupEdge };
export default Group;
