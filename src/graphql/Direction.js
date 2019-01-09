import { GraphQLEnumType } from 'graphql';

export default new GraphQLEnumType({
  name: 'Direction',
  values: {
    BACKWARD: { value: 'b' },
    FORWARD: { value: 'b' },
  },
});
