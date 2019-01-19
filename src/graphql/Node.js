import { nodeDefinitions, fromGlobalId } from 'graphql-relay';
import joinMonster from 'join-monster';

const options = { dialect: 'pg' };

// create the node type and interface
const { nodeInterface, nodeField } = nodeDefinitions(
  // this function resolves an ID to an object
  (globalId, context, resolveInfo) => {
    // parse the globalID
    const { type, id } = fromGlobalId(globalId);
    // helper method for getting Nodes from the DB, similar to the parent function.
    // also need to pass it the type name and a where function
    // TODO: check sql injection in id
    return joinMonster.getNode(type, resolveInfo, context, id, sql => context.db.raw(sql), options);
  },
  // this function determines the type. `joinMonster` figures it out
  // for you and attaches the type to the result in the "__type__" property
  // eslint-disable-next-line no-underscore-dangle
  obj => obj.__type__
);

export { nodeInterface, nodeField };
