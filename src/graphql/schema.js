import { GraphQLSchema } from 'graphql';
import subscription from './Subscription';
import query from './Query';
import mutation from './Mutation';

export default new GraphQLSchema({
  query,
  subscription,
  mutation,
});
