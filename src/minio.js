import { Client } from 'minio';

export default new Client({
  endPoint: process.env.S3_ENDPOINT || 'minio',
  port: 9000,
  useSSL: false,
  accessKey: process.env.S3_ACCESS_KEY || 'secret',
  secretKey: process.env.S3_SECRET_KEY || 'secretsecret',
});
