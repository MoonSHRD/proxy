COPY public.users (name, password_hash, creation_ts, admin, upgrade_ts, is_guest, appservice_id, consent_version, consent_server_notice_sent) FROM stdin;
@user1:localhost	$2b$12$I0D3ngPmQa4YaS.ia3tN5uMKwj9px6jkYKb/w3x3g7l5f3zBILDui	1547924749	0	\N	0	\N	\N	\N
@user2:localhost	$2b$12$mCZ8BbTs4L/hsfl5/lBH0.rgeq4h8sY7xL8t/loFj1xpREQOVLR4u	1547924929	0	\N	0	\N	\N	\N
\.

COPY public.rooms (room_id, is_public, creator) FROM stdin;
!YvivtdTtsTAmNnsRUw:localhost	f	@user1:localhost
!DwnsPKUkFrUbPENRUr:localhost	f	@user1:localhost
\.

COPY public.room_names (event_id, room_id, name) FROM stdin;
$154792481813sscwS:localhost	!YvivtdTtsTAmNnsRUw:localhost	public
$154792488222ZBqEn:localhost	!lxLGrxbEpguUZULoSC:localhost	public
\.

insert into public.communities (owner_id, name, general_room_id) values
('@user1:localhost', 'first', '!YvivtdTtsTAmNnsRUw:localhost', '{!YvivtdTtsTAmNnsRUw:localhost}'),
('@user1:localhost', 'second', '!DwnsPKUkFrUbPENRUr:localhost', '{!DwnsPKUkFrUbPENRUr:localhost}');
