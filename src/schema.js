import { GraphQLSchema, GraphQLObjectType } from 'graphql';
import query from './query';
import subscriptions from './subscriptions';

export default new GraphQLSchema({
  query: new GraphQLObjectType({
    name: 'Query',
    fields: query,
  }),
  subscription: new GraphQLObjectType({
    name: 'Subscription',
    fields: subscriptions,
  }),
});
