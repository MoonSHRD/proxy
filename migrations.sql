create table if not exists communities (
  id serial primary key,
  owner_id text not null references users (name),
  name text not null,
  short_description text not null default '',
  avatar_url text,
  user_count int not null default 0,
  general_room_id text not null,
  room_ids text[] not null default '{}',
  tags text[] not null default '{}'
);

-- make sure that all columns exist
select id, owner_id, name, short_description, avatar_url, user_count, room_ids, tags, general_room_id
  from communities
 where false;
