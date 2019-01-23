import fetch from 'node-fetch';
import queryString from 'query-string';

const json = res => res.json();

const request = (path, { query, ...options }) => {
  const search = query ? `?${queryString.stringify(query)}` : '';
  const url = `${process.env.MATRIX_ENDPOINT}${path}${search}`;

  return fetch(url, options).then(json);
};

// eslint-disable-next-line import/prefer-default-export
export const whoami = async accessToken => {
  try {
    const response = await request('/_matrix/client/r0/account/whoami', {
      query: { access_token: accessToken },
    });

    return response.user_id;
  } catch (e) {
    console.error(e.gotOptions);

    if (e.body && e.body.errcode === 'M_MISSING_TOKEN') {
      return null;
    }

    throw e;
  }
};
