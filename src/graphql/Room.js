import { GraphQLObjectType, GraphQLString, GraphQLNonNull, GraphQLBoolean, GraphQLID } from 'graphql';
import { connectionArgs, connectionFromArray } from 'graphql-relay';
import { camelizeKeys } from 'humps';

import { nodeInterface } from './Node';
import { RoomMessageConnection } from './RoomMessage';

export default new GraphQLObjectType({
  name: 'Room',
  sqlTable: 'rooms',
  uniqueKey: 'room_id',
  interfaces: [nodeInterface],
  fields: {
    id: {
      type: new GraphQLNonNull(GraphQLID),
      sqlColumn: 'room_id',
    },
    isPublic: {
      type: GraphQLBoolean,
      sqlColumn: 'is_public',
    },
    creator: {
      type: GraphQLString,
    },
    messages: {
      args: connectionArgs,
      type: RoomMessageConnection,
      sqlExpr: t => `
        (select array_agg(t.data) from (
          select json::json as data
            from event_json
           where json::json->>'type' = 'm.room.message'
             and json::json->>'room_id' = ${t}.room_id
           order by (json::json->>'unsigned')::json->>'ageTs' desc
           limit 10
        ) t)
      `,
      resolve: (room, args) => connectionFromArray(room.messages.map(m => camelizeKeys(m)), args),
    },
  },
});
