import { GraphQLObjectType, GraphQLString } from 'graphql';

const hello = {
  type: GraphQLString,
  resolve: () => 'world',
};

export default {
  hello,
};
