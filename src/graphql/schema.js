import { GraphQLSchema } from 'graphql';
import subscription from './Subscription';
import query from './Query';

export default new GraphQLSchema({
  query,
  subscription,
});
