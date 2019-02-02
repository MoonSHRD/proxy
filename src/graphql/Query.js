import { GraphQLObjectType, GraphQLInt, GraphQLString, GraphQLNonNull, GraphQLID, GraphQLList } from 'graphql';
import pgFormat from 'pg-format';
import { forwardConnectionArgs, fromGlobalId } from 'graphql-relay';
import { monsterResolve, getCachedMatrixClient } from './utils';
import { nodeField } from './Node';
import Viewer from './Viewer';
import User from './User';
import Group from './Group';
import Community, { CommunityConnection } from './Community';

export default new GraphQLObjectType({
  name: 'Query',
  fields: {
    node: nodeField,
    viewer: {
      type: Viewer,
      args: {
        accessToken: {
          type: GraphQLString,
        },
        userId: {
          type: GraphQLString,
        },
      },
      resolve: async (_, args, context) => {
        const matrixClient = await getCachedMatrixClient({
          ...context,
          ...args,
        });

        return {
          matrixClient,
        };
      },
    },
    user: {
      type: User,
      args: {
        id: {
          type: new GraphQLNonNull(GraphQLID),
        },
      },
      where: (t, args) => pgFormat(`${t}.name = %L`, args.id),
      resolve: monsterResolve,
    },
    group: {
      type: Group,
      args: {
        id: {
          type: new GraphQLNonNull(GraphQLID),
        },
      },
      where: (t, args) => pgFormat(`${t}.group_id = %L`, args.id),
      resolve: monsterResolve,
    },
    groups: {
      type: new GraphQLNonNull(new GraphQLList(new GraphQLNonNull(Group))),
      resolve: monsterResolve,
    },
    community: {
      type: Community,
      args: {
        id: {
          type: GraphQLID,
        },
        rowId: {
          type: GraphQLInt,
        },
      },
      where: (t, args) => {
        if (args.id) {
          const { type, id } = fromGlobalId(args.id);

          if (type === 'Community') {
            return `${t}.id = ${id}`;
          }
        }

        if (args.rowId) {
          return `${t}.id = ${args.rowId}`;
        }

        return `1 != 1`;
      },
      resolve: monsterResolve,
    },
    communities: {
      type: CommunityConnection,
      args: {
        ...forwardConnectionArgs,
        search: {
          type: GraphQLString,
        },
      },
      where: (t, args) => {
        if (args.search && args.search.length > 2) {
          return pgFormat(
            `
            to_tsvector('russian', ${t}.name) @@ phraseto_tsquery(%L) or
            to_tsvector('russian', array_to_string(${t}.tags, ' ')) @@ phraseto_tsquery(%L)
          `,
            args.search,
            args.search
          );
        }

        return undefined;
      },
      sqlPaginate: true,
      orderBy: 'id',
      resolve: monsterResolve,
    },
    allCommunityTags: {
      type: new GraphQLNonNull(new GraphQLList(new GraphQLNonNull(GraphQLString))),
      resolve: async (obj, args, { db }) => {
        // TODO: add code
        const { rows } = await db.raw(`
        `);

        return rows[0].tags;
      },
    },
  },
});
