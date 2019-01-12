--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6
-- Dumped by pg_dump version 10.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: access_tokens; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.access_tokens (
    id bigint NOT NULL,
    user_id text NOT NULL,
    device_id text,
    token text NOT NULL,
    last_used bigint
);


ALTER TABLE public.access_tokens OWNER TO synapse;

--
-- Name: account_data; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.account_data (
    user_id text NOT NULL,
    account_data_type text NOT NULL,
    stream_id bigint NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.account_data OWNER TO synapse;

--
-- Name: account_data_max_stream_id; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.account_data_max_stream_id (
    lock character(1) DEFAULT 'X'::bpchar NOT NULL,
    stream_id bigint NOT NULL,
    CONSTRAINT private_user_data_max_stream_id_lock_check CHECK ((lock = 'X'::bpchar))
);


ALTER TABLE public.account_data_max_stream_id OWNER TO synapse;

--
-- Name: application_services; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.application_services (
    id bigint NOT NULL,
    url text,
    token text,
    hs_token text,
    sender text
);


ALTER TABLE public.application_services OWNER TO synapse;

--
-- Name: application_services_regex; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.application_services_regex (
    id bigint NOT NULL,
    as_id bigint NOT NULL,
    namespace integer,
    regex text
);


ALTER TABLE public.application_services_regex OWNER TO synapse;

--
-- Name: application_services_state; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.application_services_state (
    as_id text NOT NULL,
    state character varying(5),
    last_txn integer
);


ALTER TABLE public.application_services_state OWNER TO synapse;

--
-- Name: application_services_txns; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.application_services_txns (
    as_id text NOT NULL,
    txn_id integer NOT NULL,
    event_ids text NOT NULL
);


ALTER TABLE public.application_services_txns OWNER TO synapse;

--
-- Name: applied_module_schemas; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.applied_module_schemas (
    module_name text NOT NULL,
    file text NOT NULL
);


ALTER TABLE public.applied_module_schemas OWNER TO synapse;

--
-- Name: applied_schema_deltas; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.applied_schema_deltas (
    version integer NOT NULL,
    file text NOT NULL
);


ALTER TABLE public.applied_schema_deltas OWNER TO synapse;

--
-- Name: appservice_room_list; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.appservice_room_list (
    appservice_id text NOT NULL,
    network_id text NOT NULL,
    room_id text NOT NULL
);


ALTER TABLE public.appservice_room_list OWNER TO synapse;

--
-- Name: appservice_stream_position; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.appservice_stream_position (
    lock character(1) DEFAULT 'X'::bpchar NOT NULL,
    stream_ordering bigint,
    CONSTRAINT appservice_stream_position_lock_check CHECK ((lock = 'X'::bpchar))
);


ALTER TABLE public.appservice_stream_position OWNER TO synapse;

--
-- Name: background_updates; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.background_updates (
    update_name text NOT NULL,
    progress_json text NOT NULL,
    depends_on text
);


ALTER TABLE public.background_updates OWNER TO synapse;

--
-- Name: blocked_rooms; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.blocked_rooms (
    room_id text NOT NULL,
    user_id text NOT NULL
);


ALTER TABLE public.blocked_rooms OWNER TO synapse;

--
-- Name: cache_invalidation_stream; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.cache_invalidation_stream (
    stream_id bigint,
    cache_func text,
    keys text[],
    invalidation_ts bigint
);


ALTER TABLE public.cache_invalidation_stream OWNER TO synapse;

--
-- Name: current_state_delta_stream; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.current_state_delta_stream (
    stream_id bigint NOT NULL,
    room_id text NOT NULL,
    type text NOT NULL,
    state_key text NOT NULL,
    event_id text,
    prev_event_id text
);


ALTER TABLE public.current_state_delta_stream OWNER TO synapse;

--
-- Name: current_state_events; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.current_state_events (
    event_id text NOT NULL,
    room_id text NOT NULL,
    type text NOT NULL,
    state_key text NOT NULL
);


ALTER TABLE public.current_state_events OWNER TO synapse;

--
-- Name: current_state_resets; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.current_state_resets (
    event_stream_ordering bigint NOT NULL
);


ALTER TABLE public.current_state_resets OWNER TO synapse;

--
-- Name: deleted_pushers; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.deleted_pushers (
    stream_id bigint NOT NULL,
    app_id text NOT NULL,
    pushkey text NOT NULL,
    user_id text NOT NULL
);


ALTER TABLE public.deleted_pushers OWNER TO synapse;

--
-- Name: destinations; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.destinations (
    destination text NOT NULL,
    retry_last_ts bigint,
    retry_interval integer
);


ALTER TABLE public.destinations OWNER TO synapse;

--
-- Name: device_federation_inbox; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_federation_inbox (
    origin text NOT NULL,
    message_id text NOT NULL,
    received_ts bigint NOT NULL
);


ALTER TABLE public.device_federation_inbox OWNER TO synapse;

--
-- Name: device_federation_outbox; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_federation_outbox (
    destination text NOT NULL,
    stream_id bigint NOT NULL,
    queued_ts bigint NOT NULL,
    messages_json text NOT NULL
);


ALTER TABLE public.device_federation_outbox OWNER TO synapse;

--
-- Name: device_inbox; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_inbox (
    user_id text NOT NULL,
    device_id text NOT NULL,
    stream_id bigint NOT NULL,
    message_json text NOT NULL
);


ALTER TABLE public.device_inbox OWNER TO synapse;

--
-- Name: device_lists_outbound_last_success; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_lists_outbound_last_success (
    destination text NOT NULL,
    user_id text NOT NULL,
    stream_id bigint NOT NULL
);


ALTER TABLE public.device_lists_outbound_last_success OWNER TO synapse;

--
-- Name: device_lists_outbound_pokes; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_lists_outbound_pokes (
    destination text NOT NULL,
    stream_id bigint NOT NULL,
    user_id text NOT NULL,
    device_id text NOT NULL,
    sent boolean NOT NULL,
    ts bigint NOT NULL
);


ALTER TABLE public.device_lists_outbound_pokes OWNER TO synapse;

--
-- Name: device_lists_remote_cache; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_lists_remote_cache (
    user_id text NOT NULL,
    device_id text NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.device_lists_remote_cache OWNER TO synapse;

--
-- Name: device_lists_remote_extremeties; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_lists_remote_extremeties (
    user_id text NOT NULL,
    stream_id text NOT NULL
);


ALTER TABLE public.device_lists_remote_extremeties OWNER TO synapse;

--
-- Name: device_lists_stream; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_lists_stream (
    stream_id bigint NOT NULL,
    user_id text NOT NULL,
    device_id text NOT NULL
);


ALTER TABLE public.device_lists_stream OWNER TO synapse;

--
-- Name: device_max_stream_id; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.device_max_stream_id (
    stream_id bigint NOT NULL
);


ALTER TABLE public.device_max_stream_id OWNER TO synapse;

--
-- Name: devices; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.devices (
    user_id text NOT NULL,
    device_id text NOT NULL,
    display_name text
);


ALTER TABLE public.devices OWNER TO synapse;

--
-- Name: e2e_device_keys_json; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.e2e_device_keys_json (
    user_id text NOT NULL,
    device_id text NOT NULL,
    ts_added_ms bigint NOT NULL,
    key_json text NOT NULL
);


ALTER TABLE public.e2e_device_keys_json OWNER TO synapse;

--
-- Name: e2e_one_time_keys_json; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.e2e_one_time_keys_json (
    user_id text NOT NULL,
    device_id text NOT NULL,
    algorithm text NOT NULL,
    key_id text NOT NULL,
    ts_added_ms bigint NOT NULL,
    key_json text NOT NULL
);


ALTER TABLE public.e2e_one_time_keys_json OWNER TO synapse;

--
-- Name: e2e_room_keys; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.e2e_room_keys (
    user_id text NOT NULL,
    room_id text NOT NULL,
    session_id text NOT NULL,
    version bigint NOT NULL,
    first_message_index integer,
    forwarded_count integer,
    is_verified boolean,
    session_data text NOT NULL
);


ALTER TABLE public.e2e_room_keys OWNER TO synapse;

--
-- Name: e2e_room_keys_versions; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.e2e_room_keys_versions (
    user_id text NOT NULL,
    version bigint NOT NULL,
    algorithm text NOT NULL,
    auth_data text NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.e2e_room_keys_versions OWNER TO synapse;

--
-- Name: erased_users; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.erased_users (
    user_id text NOT NULL
);


ALTER TABLE public.erased_users OWNER TO synapse;

--
-- Name: event_auth; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_auth (
    event_id text NOT NULL,
    auth_id text NOT NULL,
    room_id text NOT NULL
);


ALTER TABLE public.event_auth OWNER TO synapse;

--
-- Name: event_backward_extremities; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_backward_extremities (
    event_id text NOT NULL,
    room_id text NOT NULL
);


ALTER TABLE public.event_backward_extremities OWNER TO synapse;

--
-- Name: event_content_hashes; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_content_hashes (
    event_id text,
    algorithm text,
    hash bytea
);


ALTER TABLE public.event_content_hashes OWNER TO synapse;

--
-- Name: event_destinations; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_destinations (
    event_id text NOT NULL,
    destination text NOT NULL,
    delivered_ts bigint DEFAULT 0
);


ALTER TABLE public.event_destinations OWNER TO synapse;

--
-- Name: event_edge_hashes; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_edge_hashes (
    event_id text,
    prev_event_id text,
    algorithm text,
    hash bytea
);


ALTER TABLE public.event_edge_hashes OWNER TO synapse;

--
-- Name: event_edges; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_edges (
    event_id text NOT NULL,
    prev_event_id text NOT NULL,
    room_id text NOT NULL,
    is_state boolean NOT NULL
);


ALTER TABLE public.event_edges OWNER TO synapse;

--
-- Name: event_forward_extremities; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_forward_extremities (
    event_id text NOT NULL,
    room_id text NOT NULL
);


ALTER TABLE public.event_forward_extremities OWNER TO synapse;

--
-- Name: event_json; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_json (
    event_id text NOT NULL,
    room_id text NOT NULL,
    internal_metadata text NOT NULL,
    json text NOT NULL
);


ALTER TABLE public.event_json OWNER TO synapse;

--
-- Name: event_push_actions; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_push_actions (
    room_id text NOT NULL,
    event_id text NOT NULL,
    user_id text NOT NULL,
    profile_tag character varying(32),
    actions text NOT NULL,
    topological_ordering bigint,
    stream_ordering bigint,
    notif smallint,
    highlight smallint
);


ALTER TABLE public.event_push_actions OWNER TO synapse;

--
-- Name: event_push_actions_staging; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_push_actions_staging (
    event_id text NOT NULL,
    user_id text NOT NULL,
    actions text NOT NULL,
    notif smallint NOT NULL,
    highlight smallint NOT NULL
);


ALTER TABLE public.event_push_actions_staging OWNER TO synapse;

--
-- Name: event_push_summary; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_push_summary (
    user_id text NOT NULL,
    room_id text NOT NULL,
    notif_count bigint NOT NULL,
    stream_ordering bigint NOT NULL
);


ALTER TABLE public.event_push_summary OWNER TO synapse;

--
-- Name: event_push_summary_stream_ordering; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_push_summary_stream_ordering (
    lock character(1) DEFAULT 'X'::bpchar NOT NULL,
    stream_ordering bigint NOT NULL,
    CONSTRAINT event_push_summary_stream_ordering_lock_check CHECK ((lock = 'X'::bpchar))
);


ALTER TABLE public.event_push_summary_stream_ordering OWNER TO synapse;

--
-- Name: event_reference_hashes; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_reference_hashes (
    event_id text,
    algorithm text,
    hash bytea
);


ALTER TABLE public.event_reference_hashes OWNER TO synapse;

--
-- Name: event_reports; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_reports (
    id bigint NOT NULL,
    received_ts bigint NOT NULL,
    room_id text NOT NULL,
    event_id text NOT NULL,
    user_id text NOT NULL,
    reason text,
    content text
);


ALTER TABLE public.event_reports OWNER TO synapse;

--
-- Name: event_search; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_search (
    event_id text,
    room_id text,
    sender text,
    key text,
    vector tsvector,
    origin_server_ts bigint,
    stream_ordering bigint
);


ALTER TABLE public.event_search OWNER TO synapse;

--
-- Name: event_signatures; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_signatures (
    event_id text,
    signature_name text,
    key_id text,
    signature bytea
);


ALTER TABLE public.event_signatures OWNER TO synapse;

--
-- Name: event_to_state_groups; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.event_to_state_groups (
    event_id text NOT NULL,
    state_group bigint NOT NULL
);


ALTER TABLE public.event_to_state_groups OWNER TO synapse;

--
-- Name: events; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.events (
    stream_ordering integer NOT NULL,
    topological_ordering bigint NOT NULL,
    event_id text NOT NULL,
    type text NOT NULL,
    room_id text NOT NULL,
    content text,
    unrecognized_keys text,
    processed boolean NOT NULL,
    outlier boolean NOT NULL,
    depth bigint DEFAULT 0 NOT NULL,
    origin_server_ts bigint,
    received_ts bigint,
    sender text,
    contains_url boolean
);


ALTER TABLE public.events OWNER TO synapse;

--
-- Name: ex_outlier_stream; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.ex_outlier_stream (
    event_stream_ordering bigint NOT NULL,
    event_id text NOT NULL,
    state_group bigint NOT NULL
);


ALTER TABLE public.ex_outlier_stream OWNER TO synapse;

--
-- Name: federation_stream_position; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.federation_stream_position (
    type text NOT NULL,
    stream_id integer NOT NULL
);


ALTER TABLE public.federation_stream_position OWNER TO synapse;

--
-- Name: feedback; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.feedback (
    event_id text NOT NULL,
    feedback_type text,
    target_event_id text,
    sender text,
    room_id text
);


ALTER TABLE public.feedback OWNER TO synapse;

--
-- Name: group_attestations_remote; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_attestations_remote (
    group_id text NOT NULL,
    user_id text NOT NULL,
    valid_until_ms bigint NOT NULL,
    attestation_json text NOT NULL
);


ALTER TABLE public.group_attestations_remote OWNER TO synapse;

--
-- Name: group_attestations_renewals; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_attestations_renewals (
    group_id text NOT NULL,
    user_id text NOT NULL,
    valid_until_ms bigint NOT NULL
);


ALTER TABLE public.group_attestations_renewals OWNER TO synapse;

--
-- Name: group_invites; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_invites (
    group_id text NOT NULL,
    user_id text NOT NULL
);


ALTER TABLE public.group_invites OWNER TO synapse;

--
-- Name: group_roles; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_roles (
    group_id text NOT NULL,
    role_id text NOT NULL,
    profile text NOT NULL,
    is_public boolean NOT NULL
);


ALTER TABLE public.group_roles OWNER TO synapse;

--
-- Name: group_room_categories; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_room_categories (
    group_id text NOT NULL,
    category_id text NOT NULL,
    profile text NOT NULL,
    is_public boolean NOT NULL
);


ALTER TABLE public.group_room_categories OWNER TO synapse;

--
-- Name: group_rooms; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_rooms (
    group_id text NOT NULL,
    room_id text NOT NULL,
    is_public boolean NOT NULL
);


ALTER TABLE public.group_rooms OWNER TO synapse;

--
-- Name: group_summary_roles; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_summary_roles (
    group_id text NOT NULL,
    role_id text NOT NULL,
    role_order bigint NOT NULL,
    CONSTRAINT group_summary_roles_role_order_check CHECK ((role_order > 0))
);


ALTER TABLE public.group_summary_roles OWNER TO synapse;

--
-- Name: group_summary_room_categories; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_summary_room_categories (
    group_id text NOT NULL,
    category_id text NOT NULL,
    cat_order bigint NOT NULL,
    CONSTRAINT group_summary_room_categories_cat_order_check CHECK ((cat_order > 0))
);


ALTER TABLE public.group_summary_room_categories OWNER TO synapse;

--
-- Name: group_summary_rooms; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_summary_rooms (
    group_id text NOT NULL,
    room_id text NOT NULL,
    category_id text NOT NULL,
    room_order bigint NOT NULL,
    is_public boolean NOT NULL,
    CONSTRAINT group_summary_rooms_room_order_check CHECK ((room_order > 0))
);


ALTER TABLE public.group_summary_rooms OWNER TO synapse;

--
-- Name: group_summary_users; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_summary_users (
    group_id text NOT NULL,
    user_id text NOT NULL,
    role_id text NOT NULL,
    user_order bigint NOT NULL,
    is_public boolean NOT NULL
);


ALTER TABLE public.group_summary_users OWNER TO synapse;

--
-- Name: group_users; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.group_users (
    group_id text NOT NULL,
    user_id text NOT NULL,
    is_admin boolean NOT NULL,
    is_public boolean NOT NULL
);


ALTER TABLE public.group_users OWNER TO synapse;

--
-- Name: groups; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.groups (
    group_id text NOT NULL,
    name text,
    avatar_url text,
    short_description text,
    long_description text,
    is_public boolean NOT NULL,
    join_policy text DEFAULT 'invite'::text NOT NULL
);


ALTER TABLE public.groups OWNER TO synapse;

--
-- Name: guest_access; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.guest_access (
    event_id text NOT NULL,
    room_id text NOT NULL,
    guest_access text NOT NULL
);


ALTER TABLE public.guest_access OWNER TO synapse;

--
-- Name: history_visibility; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.history_visibility (
    event_id text NOT NULL,
    room_id text NOT NULL,
    history_visibility text NOT NULL
);


ALTER TABLE public.history_visibility OWNER TO synapse;

--
-- Name: local_group_membership; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.local_group_membership (
    group_id text NOT NULL,
    user_id text NOT NULL,
    is_admin boolean NOT NULL,
    membership text NOT NULL,
    is_publicised boolean NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.local_group_membership OWNER TO synapse;

--
-- Name: local_group_updates; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.local_group_updates (
    stream_id bigint NOT NULL,
    group_id text NOT NULL,
    user_id text NOT NULL,
    type text NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.local_group_updates OWNER TO synapse;

--
-- Name: local_invites; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.local_invites (
    stream_id bigint NOT NULL,
    inviter text NOT NULL,
    invitee text NOT NULL,
    event_id text NOT NULL,
    room_id text NOT NULL,
    locally_rejected text,
    replaced_by text
);


ALTER TABLE public.local_invites OWNER TO synapse;

--
-- Name: local_media_repository; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.local_media_repository (
    media_id text,
    media_type text,
    media_length integer,
    created_ts bigint,
    upload_name text,
    user_id text,
    quarantined_by text,
    url_cache text,
    last_access_ts bigint
);


ALTER TABLE public.local_media_repository OWNER TO synapse;

--
-- Name: local_media_repository_thumbnails; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.local_media_repository_thumbnails (
    media_id text,
    thumbnail_width integer,
    thumbnail_height integer,
    thumbnail_type text,
    thumbnail_method text,
    thumbnail_length integer
);


ALTER TABLE public.local_media_repository_thumbnails OWNER TO synapse;

--
-- Name: local_media_repository_url_cache; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.local_media_repository_url_cache (
    url text,
    response_code integer,
    etag text,
    expires_ts bigint,
    og text,
    media_id text,
    download_ts bigint
);


ALTER TABLE public.local_media_repository_url_cache OWNER TO synapse;

--
-- Name: monthly_active_users; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.monthly_active_users (
    user_id text NOT NULL,
    "timestamp" bigint NOT NULL
);


ALTER TABLE public.monthly_active_users OWNER TO synapse;

--
-- Name: open_id_tokens; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.open_id_tokens (
    token text NOT NULL,
    ts_valid_until_ms bigint NOT NULL,
    user_id text NOT NULL
);


ALTER TABLE public.open_id_tokens OWNER TO synapse;

--
-- Name: presence; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.presence (
    user_id text NOT NULL,
    state character varying(20),
    status_msg text,
    mtime bigint
);


ALTER TABLE public.presence OWNER TO synapse;

--
-- Name: presence_allow_inbound; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.presence_allow_inbound (
    observed_user_id text NOT NULL,
    observer_user_id text NOT NULL
);


ALTER TABLE public.presence_allow_inbound OWNER TO synapse;

--
-- Name: presence_list; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.presence_list (
    user_id text NOT NULL,
    observed_user_id text NOT NULL,
    accepted boolean NOT NULL
);


ALTER TABLE public.presence_list OWNER TO synapse;

--
-- Name: presence_stream; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.presence_stream (
    stream_id bigint,
    user_id text,
    state text,
    last_active_ts bigint,
    last_federation_update_ts bigint,
    last_user_sync_ts bigint,
    status_msg text,
    currently_active boolean
);


ALTER TABLE public.presence_stream OWNER TO synapse;

--
-- Name: profiles; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.profiles (
    user_id text NOT NULL,
    displayname text,
    avatar_url text
);


ALTER TABLE public.profiles OWNER TO synapse;

--
-- Name: public_room_list_stream; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.public_room_list_stream (
    stream_id bigint NOT NULL,
    room_id text NOT NULL,
    visibility boolean NOT NULL,
    appservice_id text,
    network_id text
);


ALTER TABLE public.public_room_list_stream OWNER TO synapse;

--
-- Name: push_rules; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.push_rules (
    id bigint NOT NULL,
    user_name text NOT NULL,
    rule_id text NOT NULL,
    priority_class smallint NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    conditions text NOT NULL,
    actions text NOT NULL
);


ALTER TABLE public.push_rules OWNER TO synapse;

--
-- Name: push_rules_enable; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.push_rules_enable (
    id bigint NOT NULL,
    user_name text NOT NULL,
    rule_id text NOT NULL,
    enabled smallint
);


ALTER TABLE public.push_rules_enable OWNER TO synapse;

--
-- Name: push_rules_stream; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.push_rules_stream (
    stream_id bigint NOT NULL,
    event_stream_ordering bigint NOT NULL,
    user_id text NOT NULL,
    rule_id text NOT NULL,
    op text NOT NULL,
    priority_class smallint,
    priority integer,
    conditions text,
    actions text
);


ALTER TABLE public.push_rules_stream OWNER TO synapse;

--
-- Name: pusher_throttle; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.pusher_throttle (
    pusher bigint NOT NULL,
    room_id text NOT NULL,
    last_sent_ts bigint,
    throttle_ms bigint
);


ALTER TABLE public.pusher_throttle OWNER TO synapse;

--
-- Name: pushers; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.pushers (
    id bigint NOT NULL,
    user_name text NOT NULL,
    access_token bigint,
    profile_tag text NOT NULL,
    kind text NOT NULL,
    app_id text NOT NULL,
    app_display_name text NOT NULL,
    device_display_name text NOT NULL,
    pushkey text NOT NULL,
    ts bigint NOT NULL,
    lang text,
    data text,
    last_stream_ordering integer,
    last_success bigint,
    failing_since bigint
);


ALTER TABLE public.pushers OWNER TO synapse;

--
-- Name: ratelimit_override; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.ratelimit_override (
    user_id text NOT NULL,
    messages_per_second bigint,
    burst_count bigint
);


ALTER TABLE public.ratelimit_override OWNER TO synapse;

--
-- Name: receipts_graph; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.receipts_graph (
    room_id text NOT NULL,
    receipt_type text NOT NULL,
    user_id text NOT NULL,
    event_ids text NOT NULL,
    data text NOT NULL
);


ALTER TABLE public.receipts_graph OWNER TO synapse;

--
-- Name: receipts_linearized; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.receipts_linearized (
    stream_id bigint NOT NULL,
    room_id text NOT NULL,
    receipt_type text NOT NULL,
    user_id text NOT NULL,
    event_id text NOT NULL,
    data text NOT NULL
);


ALTER TABLE public.receipts_linearized OWNER TO synapse;

--
-- Name: received_transactions; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.received_transactions (
    transaction_id text,
    origin text,
    ts bigint,
    response_code integer,
    response_json bytea,
    has_been_referenced smallint DEFAULT 0
);


ALTER TABLE public.received_transactions OWNER TO synapse;

--
-- Name: redactions; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.redactions (
    event_id text NOT NULL,
    redacts text NOT NULL
);


ALTER TABLE public.redactions OWNER TO synapse;

--
-- Name: rejections; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.rejections (
    event_id text NOT NULL,
    reason text NOT NULL,
    last_check text NOT NULL
);


ALTER TABLE public.rejections OWNER TO synapse;

--
-- Name: remote_media_cache; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.remote_media_cache (
    media_origin text,
    media_id text,
    media_type text,
    created_ts bigint,
    upload_name text,
    media_length integer,
    filesystem_id text,
    last_access_ts bigint,
    quarantined_by text
);


ALTER TABLE public.remote_media_cache OWNER TO synapse;

--
-- Name: remote_media_cache_thumbnails; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.remote_media_cache_thumbnails (
    media_origin text,
    media_id text,
    thumbnail_width integer,
    thumbnail_height integer,
    thumbnail_method text,
    thumbnail_type text,
    thumbnail_length integer,
    filesystem_id text
);


ALTER TABLE public.remote_media_cache_thumbnails OWNER TO synapse;

--
-- Name: remote_profile_cache; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.remote_profile_cache (
    user_id text NOT NULL,
    displayname text,
    avatar_url text,
    last_check bigint NOT NULL
);


ALTER TABLE public.remote_profile_cache OWNER TO synapse;

--
-- Name: room_account_data; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.room_account_data (
    user_id text NOT NULL,
    room_id text NOT NULL,
    account_data_type text NOT NULL,
    stream_id bigint NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.room_account_data OWNER TO synapse;

--
-- Name: room_alias_servers; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.room_alias_servers (
    room_alias text NOT NULL,
    server text NOT NULL
);


ALTER TABLE public.room_alias_servers OWNER TO synapse;

--
-- Name: room_aliases; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.room_aliases (
    room_alias text NOT NULL,
    room_id text NOT NULL,
    creator text
);


ALTER TABLE public.room_aliases OWNER TO synapse;

--
-- Name: room_depth; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.room_depth (
    room_id text NOT NULL,
    min_depth integer NOT NULL
);


ALTER TABLE public.room_depth OWNER TO synapse;

--
-- Name: room_hosts; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.room_hosts (
    room_id text NOT NULL,
    host text NOT NULL
);


ALTER TABLE public.room_hosts OWNER TO synapse;

--
-- Name: room_memberships; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.room_memberships (
    event_id text NOT NULL,
    user_id text NOT NULL,
    sender text NOT NULL,
    room_id text NOT NULL,
    membership text NOT NULL,
    forgotten integer DEFAULT 0,
    display_name text,
    avatar_url text
);


ALTER TABLE public.room_memberships OWNER TO synapse;

--
-- Name: room_names; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.room_names (
    event_id text NOT NULL,
    room_id text NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.room_names OWNER TO synapse;

--
-- Name: room_tags; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.room_tags (
    user_id text NOT NULL,
    room_id text NOT NULL,
    tag text NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.room_tags OWNER TO synapse;

--
-- Name: room_tags_revisions; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.room_tags_revisions (
    user_id text NOT NULL,
    room_id text NOT NULL,
    stream_id bigint NOT NULL
);


ALTER TABLE public.room_tags_revisions OWNER TO synapse;

--
-- Name: rooms; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.rooms (
    room_id text NOT NULL,
    is_public boolean,
    creator text
);


ALTER TABLE public.rooms OWNER TO synapse;

--
-- Name: schema_version; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.schema_version (
    lock character(1) DEFAULT 'X'::bpchar NOT NULL,
    version integer NOT NULL,
    upgraded boolean NOT NULL,
    CONSTRAINT schema_version_lock_check CHECK ((lock = 'X'::bpchar))
);


ALTER TABLE public.schema_version OWNER TO synapse;

--
-- Name: server_keys_json; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.server_keys_json (
    server_name text NOT NULL,
    key_id text NOT NULL,
    from_server text NOT NULL,
    ts_added_ms bigint NOT NULL,
    ts_valid_until_ms bigint NOT NULL,
    key_json bytea NOT NULL
);


ALTER TABLE public.server_keys_json OWNER TO synapse;

--
-- Name: server_signature_keys; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.server_signature_keys (
    server_name text,
    key_id text,
    from_server text,
    ts_added_ms bigint,
    verify_key bytea
);


ALTER TABLE public.server_signature_keys OWNER TO synapse;

--
-- Name: server_tls_certificates; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.server_tls_certificates (
    server_name text,
    fingerprint text,
    from_server text,
    ts_added_ms bigint,
    tls_certificate bytea
);


ALTER TABLE public.server_tls_certificates OWNER TO synapse;

--
-- Name: state_events; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.state_events (
    event_id text NOT NULL,
    room_id text NOT NULL,
    type text NOT NULL,
    state_key text NOT NULL,
    prev_state text
);


ALTER TABLE public.state_events OWNER TO synapse;

--
-- Name: state_forward_extremities; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.state_forward_extremities (
    event_id text NOT NULL,
    room_id text NOT NULL,
    type text NOT NULL,
    state_key text NOT NULL
);


ALTER TABLE public.state_forward_extremities OWNER TO synapse;

--
-- Name: state_group_edges; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.state_group_edges (
    state_group bigint NOT NULL,
    prev_state_group bigint NOT NULL
);


ALTER TABLE public.state_group_edges OWNER TO synapse;

--
-- Name: state_group_id_seq; Type: SEQUENCE; Schema: public; Owner: synapse
--

CREATE SEQUENCE public.state_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.state_group_id_seq OWNER TO synapse;

--
-- Name: state_groups; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.state_groups (
    id bigint NOT NULL,
    room_id text NOT NULL,
    event_id text NOT NULL
);


ALTER TABLE public.state_groups OWNER TO synapse;

--
-- Name: state_groups_state; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.state_groups_state (
    state_group bigint NOT NULL,
    room_id text NOT NULL,
    type text NOT NULL,
    state_key text NOT NULL,
    event_id text NOT NULL
);


ALTER TABLE public.state_groups_state OWNER TO synapse;

--
-- Name: stats_reporting; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.stats_reporting (
    reported_stream_token integer,
    reported_time bigint
);


ALTER TABLE public.stats_reporting OWNER TO synapse;

--
-- Name: stream_ordering_to_exterm; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.stream_ordering_to_exterm (
    stream_ordering bigint NOT NULL,
    room_id text NOT NULL,
    event_id text NOT NULL
);


ALTER TABLE public.stream_ordering_to_exterm OWNER TO synapse;

--
-- Name: threepid_guest_access_tokens; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.threepid_guest_access_tokens (
    medium text,
    address text,
    guest_access_token text,
    first_inviter text
);


ALTER TABLE public.threepid_guest_access_tokens OWNER TO synapse;

--
-- Name: topics; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.topics (
    event_id text NOT NULL,
    room_id text NOT NULL,
    topic text NOT NULL
);


ALTER TABLE public.topics OWNER TO synapse;

--
-- Name: transaction_id_to_pdu; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.transaction_id_to_pdu (
    transaction_id integer,
    destination text,
    pdu_id text,
    pdu_origin text
);


ALTER TABLE public.transaction_id_to_pdu OWNER TO synapse;

--
-- Name: user_daily_visits; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.user_daily_visits (
    user_id text NOT NULL,
    device_id text,
    "timestamp" bigint NOT NULL
);


ALTER TABLE public.user_daily_visits OWNER TO synapse;

--
-- Name: user_directory; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.user_directory (
    user_id text NOT NULL,
    room_id text,
    display_name text,
    avatar_url text
);


ALTER TABLE public.user_directory OWNER TO synapse;

--
-- Name: user_directory_search; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.user_directory_search (
    user_id text NOT NULL,
    vector tsvector
);


ALTER TABLE public.user_directory_search OWNER TO synapse;

--
-- Name: user_directory_stream_pos; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.user_directory_stream_pos (
    lock character(1) DEFAULT 'X'::bpchar NOT NULL,
    stream_id bigint,
    CONSTRAINT user_directory_stream_pos_lock_check CHECK ((lock = 'X'::bpchar))
);


ALTER TABLE public.user_directory_stream_pos OWNER TO synapse;

--
-- Name: user_filters; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.user_filters (
    user_id text,
    filter_id bigint,
    filter_json bytea
);


ALTER TABLE public.user_filters OWNER TO synapse;

--
-- Name: user_ips; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.user_ips (
    user_id text NOT NULL,
    access_token text NOT NULL,
    device_id text,
    ip text NOT NULL,
    user_agent text NOT NULL,
    last_seen bigint NOT NULL
);


ALTER TABLE public.user_ips OWNER TO synapse;

--
-- Name: user_threepids; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.user_threepids (
    user_id text NOT NULL,
    medium text NOT NULL,
    address text NOT NULL,
    validated_at bigint NOT NULL,
    added_at bigint NOT NULL
);


ALTER TABLE public.user_threepids OWNER TO synapse;

--
-- Name: users; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.users (
    name text,
    password_hash text,
    creation_ts bigint,
    admin smallint DEFAULT 0 NOT NULL,
    upgrade_ts bigint,
    is_guest smallint DEFAULT 0 NOT NULL,
    appservice_id text,
    consent_version text,
    consent_server_notice_sent text
);


ALTER TABLE public.users OWNER TO synapse;

--
-- Name: users_in_public_rooms; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.users_in_public_rooms (
    user_id text NOT NULL,
    room_id text NOT NULL
);


ALTER TABLE public.users_in_public_rooms OWNER TO synapse;

--
-- Name: users_pending_deactivation; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.users_pending_deactivation (
    user_id text NOT NULL
);


ALTER TABLE public.users_pending_deactivation OWNER TO synapse;

--
-- Name: users_who_share_rooms; Type: TABLE; Schema: public; Owner: synapse
--

CREATE TABLE public.users_who_share_rooms (
    user_id text NOT NULL,
    other_user_id text NOT NULL,
    room_id text NOT NULL,
    share_private boolean NOT NULL
);


ALTER TABLE public.users_who_share_rooms OWNER TO synapse;

--
-- Data for Name: access_tokens; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.access_tokens (id, user_id, device_id, token, last_used) FROM stdin;
3	@alexes:localhost	OBFWSJWDFN	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjRjaWQgdXNlcl9pZCA9IEBhbGV4ZXM6bG9jYWxob3N0CjAwMTZjaWQgdHlwZSA9IGFjY2VzcwowMDIxY2lkIG5vbmNlID0gd3JFOXlHekB2ZkthaUF1NgowMDJmc2lnbmF0dXJlIPypk90iXBPu3plilpNbr5zCUKqUKqv2c-irAAAbpWOoCg	\N
4	@alexes:localhost	BEAWWZPRKB	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjRjaWQgdXNlcl9pZCA9IEBhbGV4ZXM6bG9jYWxob3N0CjAwMTZjaWQgdHlwZSA9IGFjY2VzcwowMDIxY2lkIG5vbmNlID0gemFAdEo7Q0JQNH43cXdUSAowMDJmc2lnbmF0dXJlIFbUEj7uUMkYYEDnsziXa_wrULIrTNvgZNDRZvELFTT6Cg	\N
5	@alexes:localhost	TRFSWZYCHC	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjRjaWQgdXNlcl9pZCA9IEBhbGV4ZXM6bG9jYWxob3N0CjAwMTZjaWQgdHlwZSA9IGFjY2VzcwowMDIxY2lkIG5vbmNlID0ga1IzQ1BjXndAcmNUR0EuUAowMDJmc2lnbmF0dXJlIEX6YAouq46Jg6NQ-OGU6Cs7HbR5_GcL62z6USXC8CfiCg	\N
7	@alexes1:localhost	UPEFWAYYBJ	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjVjaWQgdXNlcl9pZCA9IEBhbGV4ZXMxOmxvY2FsaG9zdAowMDE2Y2lkIHR5cGUgPSBhY2Nlc3MKMDAyMWNpZCBub25jZSA9IDVQa0ZOY1A5S0tHaWYwX04KMDAyZnNpZ25hdHVyZSDQBCD0UKrXlEUdHXodqqbt796UZRD2KVO8xFhzqF_BZgo	\N
9	@alexes:localhost	AWNENVBLBG	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjRjaWQgdXNlcl9pZCA9IEBhbGV4ZXM6bG9jYWxob3N0CjAwMTZjaWQgdHlwZSA9IGFjY2VzcwowMDIxY2lkIG5vbmNlID0gN3I1clJoOTBzX3FuRmt6ZAowMDJmc2lnbmF0dXJlIJ8CnF2YdQBgaWVuowrINaAhuSp1PLZq3WDRze2Me58lCg	\N
10	@alexes1:localhost	DRFUUIBBAK	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjVjaWQgdXNlcl9pZCA9IEBhbGV4ZXMxOmxvY2FsaG9zdAowMDE2Y2lkIHR5cGUgPSBhY2Nlc3MKMDAyMWNpZCBub25jZSA9IFZ0VHFQaTNJaVkzOHU2ZjQKMDAyZnNpZ25hdHVyZSA3fkJ-mecpNKGNTmxEqCy9v0iu55Wzwudh0H4hhk79pwo	\N
\.


--
-- Data for Name: account_data; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.account_data (user_id, account_data_type, stream_id, content) FROM stdin;
\.


--
-- Data for Name: account_data_max_stream_id; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.account_data_max_stream_id (lock, stream_id) FROM stdin;
X	96
\.


--
-- Data for Name: application_services; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.application_services (id, url, token, hs_token, sender) FROM stdin;
\.


--
-- Data for Name: application_services_regex; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.application_services_regex (id, as_id, namespace, regex) FROM stdin;
\.


--
-- Data for Name: application_services_state; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.application_services_state (as_id, state, last_txn) FROM stdin;
\.


--
-- Data for Name: application_services_txns; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.application_services_txns (as_id, txn_id, event_ids) FROM stdin;
\.


--
-- Data for Name: applied_module_schemas; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.applied_module_schemas (module_name, file) FROM stdin;
\.


--
-- Data for Name: applied_schema_deltas; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.applied_schema_deltas (version, file) FROM stdin;
17	17/drop_indexes.sql
17	17/server_keys.sql
17	17/user_threepids.sql
18	18/server_keys_bigger_ints.sql
19	19/event_index.sql
20	20/__pycache__
20	20/dummy.sql
20	20/pushers.py
21	21/end_to_end_keys.sql
21	21/receipts.sql
22	22/receipts_index.sql
22	22/user_threepids_unique.sql
23	23/drop_state_index.sql
24	24/stats_reporting.sql
25	25/00background_updates.sql
25	25/__pycache__
25	25/fts.py
25	25/guest_access.sql
25	25/history_visibility.sql
25	25/tags.sql
26	26/account_data.sql
27	27/__pycache__
27	27/account_data.sql
27	27/forgotten_memberships.sql
27	27/ts.py
28	28/event_push_actions.sql
28	28/events_room_stream.sql
28	28/public_roms_index.sql
28	28/receipts_user_id_index.sql
28	28/upgrade_times.sql
28	28/users_is_guest.sql
29	29/push_actions.sql
30	30/__pycache__
30	30/alias_creator.sql
30	30/as_users.py
30	30/deleted_pushers.sql
30	30/presence_stream.sql
30	30/public_rooms.sql
30	30/push_rule_stream.sql
30	30/state_stream.sql
30	30/threepid_guest_access_tokens.sql
31	31/__pycache__
31	31/invites.sql
31	31/local_media_repository_url_cache.sql
31	31/pushers.py
31	31/pushers_index.sql
31	31/search_update.py
32	32/events.sql
32	32/openid.sql
32	32/pusher_throttle.sql
32	32/remove_indices.sql
32	32/reports.sql
33	33/__pycache__
33	33/access_tokens_device_index.sql
33	33/devices.sql
33	33/devices_for_e2e_keys.sql
33	33/devices_for_e2e_keys_clear_unknown_device.sql
33	33/event_fields.py
33	33/remote_media_ts.py
33	33/user_ips_index.sql
34	34/__pycache__
34	34/appservice_stream.sql
34	34/cache_stream.py
34	34/device_inbox.sql
34	34/push_display_name_rename.sql
34	34/received_txn_purge.py
35	35/add_state_index.sql
35	35/contains_url.sql
35	35/device_outbox.sql
35	35/device_stream_id.sql
35	35/event_push_actions_index.sql
35	35/public_room_list_change_stream.sql
35	35/state.sql
35	35/state_dedupe.sql
35	35/stream_order_to_extrem.sql
36	36/readd_public_rooms.sql
37	37/__pycache__
37	37/remove_auth_idx.py
37	37/user_threepids.sql
38	38/postgres_fts_gist.sql
39	39/appservice_room_list.sql
39	39/device_federation_stream_idx.sql
39	39/event_push_index.sql
39	39/federation_out_position.sql
39	39/membership_profile.sql
40	40/current_state_idx.sql
40	40/device_inbox.sql
40	40/device_list_streams.sql
40	40/event_push_summary.sql
40	40/pushers.sql
41	41/device_list_stream_idx.sql
41	41/device_outbound_index.sql
41	41/event_search_event_id_idx.sql
41	41/ratelimit.sql
42	42/__pycache__
42	42/current_state_delta.sql
42	42/device_list_last_id.sql
42	42/event_auth_state_only.sql
42	42/user_dir.py
43	43/blocked_rooms.sql
43	43/quarantine_media.sql
43	43/url_cache.sql
43	43/user_share.sql
44	44/expire_url_cache.sql
45	45/group_server.sql
45	45/profile_cache.sql
46	46/drop_refresh_tokens.sql
46	46/drop_unique_deleted_pushers.sql
46	46/group_server.sql
46	46/local_media_repository_url_idx.sql
46	46/user_dir_null_room_ids.sql
46	46/user_dir_typos.sql
47	47/__pycache__
47	47/last_access_media.sql
47	47/postgres_fts_gin.sql
47	47/push_actions_staging.sql
47	47/state_group_seq.py
48	48/__pycache__
48	48/add_user_consent.sql
48	48/add_user_ips_last_seen_index.sql
48	48/deactivated_users.sql
48	48/group_unique_indexes.py
48	48/groups_joinable.sql
49	49/add_user_consent_server_notice_sent.sql
49	49/add_user_daily_visits.sql
49	49/add_user_ips_last_seen_only_index.sql
50	50/__pycache__
50	50/add_creation_ts_users_index.sql
50	50/erasure_store.sql
50	50/make_event_content_nullable.py
51	51/e2e_room_keys.sql
51	51/monthly_active_users.sql
52	52/add_event_to_state_group_index.sql
52	52/device_list_streams_unique_idx.sql
52	52/e2e_room_keys.sql
53	53/drop_sent_transactions.sql
\.


--
-- Data for Name: appservice_room_list; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.appservice_room_list (appservice_id, network_id, room_id) FROM stdin;
\.


--
-- Data for Name: appservice_stream_position; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.appservice_stream_position (lock, stream_ordering) FROM stdin;
X	0
\.


--
-- Data for Name: background_updates; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.background_updates (update_name, progress_json, depends_on) FROM stdin;
\.


--
-- Data for Name: blocked_rooms; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.blocked_rooms (room_id, user_id) FROM stdin;
\.


--
-- Data for Name: cache_invalidation_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.cache_invalidation_stream (stream_id, cache_func, keys, invalidation_ts) FROM stdin;
2	get_user_by_id	{@alexes:localhost}	1547142630059
3	get_users_in_room	{!mpvAGWWPEpWsNydYnN:localhost}	1547142630356
4	get_room_summary	{!mpvAGWWPEpWsNydYnN:localhost}	1547142630356
5	get_current_state_ids	{!mpvAGWWPEpWsNydYnN:localhost}	1547142630357
6	get_rooms_for_user_with_stream_ordering	{@alexes:localhost}	1547142630435
7	is_host_joined	{!mpvAGWWPEpWsNydYnN:localhost,localhost}	1547142630436
8	was_host_joined	{!mpvAGWWPEpWsNydYnN:localhost,localhost}	1547142630438
9	get_users_in_room	{!mpvAGWWPEpWsNydYnN:localhost}	1547142630438
10	get_room_summary	{!mpvAGWWPEpWsNydYnN:localhost}	1547142630438
11	get_current_state_ids	{!mpvAGWWPEpWsNydYnN:localhost}	1547142630439
12	get_users_in_room	{!mpvAGWWPEpWsNydYnN:localhost}	1547142630500
13	get_room_summary	{!mpvAGWWPEpWsNydYnN:localhost}	1547142630501
14	get_current_state_ids	{!mpvAGWWPEpWsNydYnN:localhost}	1547142630501
15	get_users_in_room	{!mpvAGWWPEpWsNydYnN:localhost}	1547142630552
16	get_room_summary	{!mpvAGWWPEpWsNydYnN:localhost}	1547142630552
17	get_current_state_ids	{!mpvAGWWPEpWsNydYnN:localhost}	1547142630553
18	get_users_in_room	{!mpvAGWWPEpWsNydYnN:localhost}	1547142630598
19	get_room_summary	{!mpvAGWWPEpWsNydYnN:localhost}	1547142630599
20	get_current_state_ids	{!mpvAGWWPEpWsNydYnN:localhost}	1547142630599
21	count_e2e_one_time_keys	{@alexes:localhost,OBFWSJWDFN}	1547142630611
22	get_users_in_room	{!mpvAGWWPEpWsNydYnN:localhost}	1547142630643
23	get_room_summary	{!mpvAGWWPEpWsNydYnN:localhost}	1547142630646
24	get_current_state_ids	{!mpvAGWWPEpWsNydYnN:localhost}	1547142630646
25	count_e2e_one_time_keys	{@alexes:localhost,OBFWSJWDFN}	1547142630656
26	count_e2e_one_time_keys	{@alexes:localhost,OBFWSJWDFN}	1547142630702
27	count_e2e_one_time_keys	{@alexes:localhost,OBFWSJWDFN}	1547142630768
28	count_e2e_one_time_keys	{@alexes:localhost,OBFWSJWDFN}	1547142630849
29	count_e2e_one_time_keys	{@alexes:localhost,OBFWSJWDFN}	1547142630928
30	count_e2e_one_time_keys	{@alexes:localhost,OBFWSJWDFN}	1547142630990
31	count_e2e_one_time_keys	{@alexes:localhost,OBFWSJWDFN}	1547142631033
32	count_e2e_one_time_keys	{@alexes:localhost,OBFWSJWDFN}	1547142631094
33	count_e2e_one_time_keys	{@alexes:localhost,OBFWSJWDFN}	1547142631149
34	get_users_in_room	{!CrvkKxgetahhVIwnyX:localhost}	1547142649006
35	get_room_summary	{!CrvkKxgetahhVIwnyX:localhost}	1547142649006
36	get_current_state_ids	{!CrvkKxgetahhVIwnyX:localhost}	1547142649007
37	get_rooms_for_user_with_stream_ordering	{@alexes:localhost}	1547142649044
38	is_host_joined	{!CrvkKxgetahhVIwnyX:localhost,localhost}	1547142649045
39	was_host_joined	{!CrvkKxgetahhVIwnyX:localhost,localhost}	1547142649045
40	get_users_in_room	{!CrvkKxgetahhVIwnyX:localhost}	1547142649046
41	get_room_summary	{!CrvkKxgetahhVIwnyX:localhost}	1547142649046
42	get_current_state_ids	{!CrvkKxgetahhVIwnyX:localhost}	1547142649046
43	get_users_in_room	{!CrvkKxgetahhVIwnyX:localhost}	1547142649087
44	get_room_summary	{!CrvkKxgetahhVIwnyX:localhost}	1547142649087
45	get_current_state_ids	{!CrvkKxgetahhVIwnyX:localhost}	1547142649088
46	get_users_in_room	{!CrvkKxgetahhVIwnyX:localhost}	1547142649137
47	get_room_summary	{!CrvkKxgetahhVIwnyX:localhost}	1547142649138
48	get_current_state_ids	{!CrvkKxgetahhVIwnyX:localhost}	1547142649138
49	get_users_in_room	{!CrvkKxgetahhVIwnyX:localhost}	1547142649177
50	get_room_summary	{!CrvkKxgetahhVIwnyX:localhost}	1547142649177
51	get_current_state_ids	{!CrvkKxgetahhVIwnyX:localhost}	1547142649178
52	get_users_in_room	{!CrvkKxgetahhVIwnyX:localhost}	1547142649215
53	get_room_summary	{!CrvkKxgetahhVIwnyX:localhost}	1547142649215
54	get_current_state_ids	{!CrvkKxgetahhVIwnyX:localhost}	1547142649216
55	get_users_in_room	{!CrvkKxgetahhVIwnyX:localhost}	1547142649254
56	get_room_summary	{!CrvkKxgetahhVIwnyX:localhost}	1547142649254
57	get_current_state_ids	{!CrvkKxgetahhVIwnyX:localhost}	1547142649254
58	get_users_in_room	{!CrvkKxgetahhVIwnyX:localhost}	1547142667757
59	get_room_summary	{!CrvkKxgetahhVIwnyX:localhost}	1547142667758
60	get_current_state_ids	{!CrvkKxgetahhVIwnyX:localhost}	1547142667758
61	get_user_by_id	{@alexes1:localhost}	1547144283414
62	get_users_in_room	{!RgDCNwMiMxKykVVClV:localhost}	1547144283474
63	get_room_summary	{!RgDCNwMiMxKykVVClV:localhost}	1547144283474
64	get_current_state_ids	{!RgDCNwMiMxKykVVClV:localhost}	1547144283475
65	get_rooms_for_user_with_stream_ordering	{@alexes1:localhost}	1547144283545
66	is_host_joined	{!RgDCNwMiMxKykVVClV:localhost,localhost}	1547144283546
67	was_host_joined	{!RgDCNwMiMxKykVVClV:localhost,localhost}	1547144283547
68	get_users_in_room	{!RgDCNwMiMxKykVVClV:localhost}	1547144283547
69	get_room_summary	{!RgDCNwMiMxKykVVClV:localhost}	1547144283550
70	get_current_state_ids	{!RgDCNwMiMxKykVVClV:localhost}	1547144283551
90	count_e2e_one_time_keys	{@alexes1:localhost,UPEFWAYYBJ}	1547144283856
95	count_e2e_one_time_keys	{@alexes:localhost,KADPOZFQWN}	1547144336246
71	get_users_in_room	{!RgDCNwMiMxKykVVClV:localhost}	1547144283600
72	get_room_summary	{!RgDCNwMiMxKykVVClV:localhost}	1547144283600
73	get_current_state_ids	{!RgDCNwMiMxKykVVClV:localhost}	1547144283600
75	get_users_in_room	{!RgDCNwMiMxKykVVClV:localhost}	1547144283650
76	get_room_summary	{!RgDCNwMiMxKykVVClV:localhost}	1547144283651
77	get_current_state_ids	{!RgDCNwMiMxKykVVClV:localhost}	1547144283651
88	count_e2e_one_time_keys	{@alexes1:localhost,UPEFWAYYBJ}	1547144283808
94	count_e2e_one_time_keys	{@alexes:localhost,KADPOZFQWN}	1547144336208
102	count_e2e_one_time_keys	{@alexes:localhost,KADPOZFQWN}	1547144336655
106	get_users_in_room	{!CrvkKxgetahhVIwnyX:localhost}	1547144362822
107	get_room_summary	{!CrvkKxgetahhVIwnyX:localhost}	1547144362824
108	get_current_state_ids	{!CrvkKxgetahhVIwnyX:localhost}	1547144362824
74	count_e2e_one_time_keys	{@alexes1:localhost,UPEFWAYYBJ}	1547144283622
78	count_e2e_one_time_keys	{@alexes1:localhost,UPEFWAYYBJ}	1547144283656
79	count_e2e_one_time_keys	{@alexes1:localhost,UPEFWAYYBJ}	1547144283704
80	get_users_in_room	{!RgDCNwMiMxKykVVClV:localhost}	1547144283705
81	get_room_summary	{!RgDCNwMiMxKykVVClV:localhost}	1547144283706
82	get_current_state_ids	{!RgDCNwMiMxKykVVClV:localhost}	1547144283707
83	count_e2e_one_time_keys	{@alexes1:localhost,UPEFWAYYBJ}	1547144283741
84	get_users_in_room	{!RgDCNwMiMxKykVVClV:localhost}	1547144283751
85	get_room_summary	{!RgDCNwMiMxKykVVClV:localhost}	1547144283752
86	get_current_state_ids	{!RgDCNwMiMxKykVVClV:localhost}	1547144283752
87	count_e2e_one_time_keys	{@alexes1:localhost,UPEFWAYYBJ}	1547144283780
89	count_e2e_one_time_keys	{@alexes1:localhost,UPEFWAYYBJ}	1547144283830
91	count_e2e_one_time_keys	{@alexes1:localhost,UPEFWAYYBJ}	1547144283881
92	count_e2e_one_time_keys	{@alexes1:localhost,UPEFWAYYBJ}	1547144283903
93	count_e2e_one_time_keys	{@alexes:localhost,KADPOZFQWN}	1547144336166
96	count_e2e_one_time_keys	{@alexes:localhost,KADPOZFQWN}	1547144336285
97	count_e2e_one_time_keys	{@alexes:localhost,KADPOZFQWN}	1547144336323
98	count_e2e_one_time_keys	{@alexes:localhost,KADPOZFQWN}	1547144336360
99	count_e2e_one_time_keys	{@alexes:localhost,KADPOZFQWN}	1547144336426
100	count_e2e_one_time_keys	{@alexes:localhost,KADPOZFQWN}	1547144336512
101	count_e2e_one_time_keys	{@alexes:localhost,KADPOZFQWN}	1547144336594
103	get_users_in_room	{!CrvkKxgetahhVIwnyX:localhost}	1547144362783
104	get_room_summary	{!CrvkKxgetahhVIwnyX:localhost}	1547144362784
105	get_current_state_ids	{!CrvkKxgetahhVIwnyX:localhost}	1547144362784
109	get_rooms_for_user_with_stream_ordering	{@alexes1:localhost}	1547144383890
110	is_host_joined	{!CrvkKxgetahhVIwnyX:localhost,localhost}	1547144383891
111	was_host_joined	{!CrvkKxgetahhVIwnyX:localhost,localhost}	1547144383892
112	get_users_in_room	{!CrvkKxgetahhVIwnyX:localhost}	1547144383893
113	get_room_summary	{!CrvkKxgetahhVIwnyX:localhost}	1547144383894
114	get_current_state_ids	{!CrvkKxgetahhVIwnyX:localhost}	1547144383894
115	get_user_by_access_token	{MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjRjaWQgdXNlcl9pZCA9IEBhbGV4ZXM6bG9jYWxob3N0CjAwMTZjaWQgdHlwZSA9IGFjY2VzcwowMDIxY2lkIG5vbmNlID0gcnZDa3lvPUM0R35XOE09egowMDJmc2lnbmF0dXJlIFG0QU44RHnz5cul1xH4d9GupLFUpf-bbnS-hZ5PpuvICg}	1547188095893
116	count_e2e_one_time_keys	{@alexes:localhost,KADPOZFQWN}	1547188095898
117	count_e2e_one_time_keys	{@alexes1:localhost,DRFUUIBBAK}	1547188107057
118	count_e2e_one_time_keys	{@alexes1:localhost,DRFUUIBBAK}	1547188107086
119	count_e2e_one_time_keys	{@alexes1:localhost,DRFUUIBBAK}	1547188107136
120	count_e2e_one_time_keys	{@alexes1:localhost,DRFUUIBBAK}	1547188107194
121	count_e2e_one_time_keys	{@alexes1:localhost,DRFUUIBBAK}	1547188107250
122	count_e2e_one_time_keys	{@alexes1:localhost,DRFUUIBBAK}	1547188107327
123	count_e2e_one_time_keys	{@alexes1:localhost,DRFUUIBBAK}	1547188107394
124	count_e2e_one_time_keys	{@alexes1:localhost,DRFUUIBBAK}	1547188107469
125	count_e2e_one_time_keys	{@alexes1:localhost,DRFUUIBBAK}	1547188107550
126	count_e2e_one_time_keys	{@alexes1:localhost,DRFUUIBBAK}	1547188107638
\.


--
-- Data for Name: current_state_delta_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.current_state_delta_stream (stream_id, room_id, type, state_key, event_id, prev_event_id) FROM stdin;
2	!mpvAGWWPEpWsNydYnN:localhost	m.room.create		$15471426300pPrwQ:localhost	\N
3	!mpvAGWWPEpWsNydYnN:localhost	m.room.member	@alexes:localhost	$15471426301dPFwo:localhost	\N
4	!mpvAGWWPEpWsNydYnN:localhost	m.room.power_levels		$15471426302pIqiF:localhost	\N
5	!mpvAGWWPEpWsNydYnN:localhost	m.room.join_rules		$15471426303YCSmZ:localhost	\N
6	!mpvAGWWPEpWsNydYnN:localhost	m.room.history_visibility		$15471426304BRdxH:localhost	\N
7	!mpvAGWWPEpWsNydYnN:localhost	m.room.guest_access		$15471426305IErDp:localhost	\N
8	!CrvkKxgetahhVIwnyX:localhost	m.room.create		$15471426487fdcng:localhost	\N
9	!CrvkKxgetahhVIwnyX:localhost	m.room.member	@alexes:localhost	$15471426498QYDnP:localhost	\N
10	!CrvkKxgetahhVIwnyX:localhost	m.room.power_levels		$15471426499olYQy:localhost	\N
11	!CrvkKxgetahhVIwnyX:localhost	m.room.join_rules		$154714264910qNuKi:localhost	\N
12	!CrvkKxgetahhVIwnyX:localhost	m.room.history_visibility		$154714264911TWsje:localhost	\N
13	!CrvkKxgetahhVIwnyX:localhost	m.room.guest_access		$154714264912SGfjg:localhost	\N
14	!CrvkKxgetahhVIwnyX:localhost	m.room.name		$154714264913PCUQS:localhost	\N
15	!CrvkKxgetahhVIwnyX:localhost	m.room.related_groups		$154714266714gvEsJ:localhost	\N
17	!RgDCNwMiMxKykVVClV:localhost	m.room.create		$154714428316KLrwW:localhost	\N
18	!RgDCNwMiMxKykVVClV:localhost	m.room.member	@alexes1:localhost	$154714428317sWMac:localhost	\N
19	!RgDCNwMiMxKykVVClV:localhost	m.room.power_levels		$154714428318OamJt:localhost	\N
20	!RgDCNwMiMxKykVVClV:localhost	m.room.join_rules		$154714428319jqvHZ:localhost	\N
21	!RgDCNwMiMxKykVVClV:localhost	m.room.history_visibility		$154714428320dqSvn:localhost	\N
22	!RgDCNwMiMxKykVVClV:localhost	m.room.guest_access		$154714428321iaMIA:localhost	\N
23	!CrvkKxgetahhVIwnyX:localhost	m.room.join_rules		$154714436223plixL:localhost	$154714264910qNuKi:localhost
24	!CrvkKxgetahhVIwnyX:localhost	org.matrix.room.preview_urls		$154714436224LoFLm:localhost	\N
25	!CrvkKxgetahhVIwnyX:localhost	m.room.member	@alexes1:localhost	$154714438325bxgqT:localhost	\N
\.


--
-- Data for Name: current_state_events; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.current_state_events (event_id, room_id, type, state_key) FROM stdin;
$15471426300pPrwQ:localhost	!mpvAGWWPEpWsNydYnN:localhost	m.room.create	
$15471426301dPFwo:localhost	!mpvAGWWPEpWsNydYnN:localhost	m.room.member	@alexes:localhost
$15471426302pIqiF:localhost	!mpvAGWWPEpWsNydYnN:localhost	m.room.power_levels	
$15471426303YCSmZ:localhost	!mpvAGWWPEpWsNydYnN:localhost	m.room.join_rules	
$15471426304BRdxH:localhost	!mpvAGWWPEpWsNydYnN:localhost	m.room.history_visibility	
$15471426305IErDp:localhost	!mpvAGWWPEpWsNydYnN:localhost	m.room.guest_access	
$15471426487fdcng:localhost	!CrvkKxgetahhVIwnyX:localhost	m.room.create	
$15471426498QYDnP:localhost	!CrvkKxgetahhVIwnyX:localhost	m.room.member	@alexes:localhost
$15471426499olYQy:localhost	!CrvkKxgetahhVIwnyX:localhost	m.room.power_levels	
$154714264911TWsje:localhost	!CrvkKxgetahhVIwnyX:localhost	m.room.history_visibility	
$154714264912SGfjg:localhost	!CrvkKxgetahhVIwnyX:localhost	m.room.guest_access	
$154714264913PCUQS:localhost	!CrvkKxgetahhVIwnyX:localhost	m.room.name	
$154714266714gvEsJ:localhost	!CrvkKxgetahhVIwnyX:localhost	m.room.related_groups	
$154714428316KLrwW:localhost	!RgDCNwMiMxKykVVClV:localhost	m.room.create	
$154714428317sWMac:localhost	!RgDCNwMiMxKykVVClV:localhost	m.room.member	@alexes1:localhost
$154714428318OamJt:localhost	!RgDCNwMiMxKykVVClV:localhost	m.room.power_levels	
$154714428319jqvHZ:localhost	!RgDCNwMiMxKykVVClV:localhost	m.room.join_rules	
$154714428320dqSvn:localhost	!RgDCNwMiMxKykVVClV:localhost	m.room.history_visibility	
$154714428321iaMIA:localhost	!RgDCNwMiMxKykVVClV:localhost	m.room.guest_access	
$154714436223plixL:localhost	!CrvkKxgetahhVIwnyX:localhost	m.room.join_rules	
$154714436224LoFLm:localhost	!CrvkKxgetahhVIwnyX:localhost	org.matrix.room.preview_urls	
$154714438325bxgqT:localhost	!CrvkKxgetahhVIwnyX:localhost	m.room.member	@alexes1:localhost
\.


--
-- Data for Name: current_state_resets; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.current_state_resets (event_stream_ordering) FROM stdin;
\.


--
-- Data for Name: deleted_pushers; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.deleted_pushers (stream_id, app_id, pushkey, user_id) FROM stdin;
\.


--
-- Data for Name: destinations; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.destinations (destination, retry_last_ts, retry_interval) FROM stdin;
matrix.org	1547144287473	75000000
\.


--
-- Data for Name: device_federation_inbox; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_federation_inbox (origin, message_id, received_ts) FROM stdin;
\.


--
-- Data for Name: device_federation_outbox; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_federation_outbox (destination, stream_id, queued_ts, messages_json) FROM stdin;
\.


--
-- Data for Name: device_inbox; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_inbox (user_id, device_id, stream_id, message_json) FROM stdin;
\.


--
-- Data for Name: device_lists_outbound_last_success; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_lists_outbound_last_success (destination, user_id, stream_id) FROM stdin;
\.


--
-- Data for Name: device_lists_outbound_pokes; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_lists_outbound_pokes (destination, stream_id, user_id, device_id, sent, ts) FROM stdin;
\.


--
-- Data for Name: device_lists_remote_cache; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_lists_remote_cache (user_id, device_id, content) FROM stdin;
\.


--
-- Data for Name: device_lists_remote_extremeties; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_lists_remote_extremeties (user_id, stream_id) FROM stdin;
\.


--
-- Data for Name: device_lists_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_lists_stream (stream_id, user_id, device_id) FROM stdin;
3	@alexes:localhost	OBFWSJWDFN
4	@alexes:localhost	BEAWWZPRKB
5	@alexes:localhost	TRFSWZYCHC
7	@alexes1:localhost	UPEFWAYYBJ
10	@alexes:localhost	AWNENVBLBG
11	@alexes:localhost	KADPOZFQWN
13	@alexes1:localhost	DRFUUIBBAK
\.


--
-- Data for Name: device_max_stream_id; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.device_max_stream_id (stream_id) FROM stdin;
0
\.


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.devices (user_id, device_id, display_name) FROM stdin;
@alexes:localhost	OBFWSJWDFN	\N
@alexes:localhost	BEAWWZPRKB	\N
@alexes:localhost	TRFSWZYCHC	\N
@alexes1:localhost	UPEFWAYYBJ	\N
@alexes:localhost	AWNENVBLBG	\N
@alexes1:localhost	DRFUUIBBAK	https://riot.im/app/ via Chrome on Linux
\.


--
-- Data for Name: e2e_device_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_device_keys_json (user_id, device_id, ts_added_ms, key_json) FROM stdin;
@alexes:localhost	OBFWSJWDFN	1547142630416	{"algorithms":["m.olm.v1.curve25519-aes-sha2","m.megolm.v1.aes-sha2"],"device_id":"OBFWSJWDFN","keys":{"curve25519:OBFWSJWDFN":"gTu8SDFUze4hIn8MsNjLBYFJh3g8Eip0HLHQPeKaOD0","ed25519:OBFWSJWDFN":"duQ7o2DrFmf7X68jeI/PrXvcuzXdH7HVFYsD0ey13Rs"},"signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"RgBVtry7Ia027ykd6efZkGHwM1JZL1I3k243X6VDQc0V+ZM1OXeqWDULdsrOyhlnF9tGJVcY+NQaDk7nCIJ9Bw"}},"user_id":"@alexes:localhost"}
@alexes1:localhost	UPEFWAYYBJ	1547144283505	{"algorithms":["m.olm.v1.curve25519-aes-sha2","m.megolm.v1.aes-sha2"],"device_id":"UPEFWAYYBJ","keys":{"curve25519:UPEFWAYYBJ":"BoUzz7DumM71FPXTYvuQxAi41xqrrZTf2ASxXE9AvxY","ed25519:UPEFWAYYBJ":"D+34j5kVgQb1E02ZCaOO8SlAQisit5zNZ3Y6Gj4otUo"},"signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"+ArwEx900bpV/UbPBlEXg4N8Us2MA4mSnYTAhntbOw3Ndf0hGptnJ6/1LgRFRunFYEpF/0c6eyb8tzVbN7irCA"}},"user_id":"@alexes1:localhost"}
@alexes1:localhost	DRFUUIBBAK	1547188105652	{"algorithms":["m.olm.v1.curve25519-aes-sha2","m.megolm.v1.aes-sha2"],"device_id":"DRFUUIBBAK","keys":{"curve25519:DRFUUIBBAK":"FYN4pbkALS25J1whjnNs8OSIcpXplxrDcBADyqdv22Y","ed25519:DRFUUIBBAK":"6391CEyTm3fyFA/lt0K6xLf1D+OrRKjdtv2S/F+MRLE"},"signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"hkguvhzOYWpGrkvyfNZ+EzqUwhGaiD+UbJWwCswdpgKmv1rchno9h8E59nyeb/VC02nNzrQqJeNOx9g+HHCzCg"}},"user_id":"@alexes1:localhost"}
\.


--
-- Data for Name: e2e_one_time_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_one_time_keys_json (user_id, device_id, algorithm, key_id, ts_added_ms, key_json) FROM stdin;
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAABQ	1547142630607	{"key":"bVYxWJ8mA1RX6YKesTDt/SbSF4g4G7vp3WKB9HALVmA","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"CydylmA465MUWzaGkNlxO7lIGQ2nRlU3Mp8sUwpc7+sXVddtr2Nsnm+L4WP+bat4f7hY5Qg/z9F3WuDhqD5dBg"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAABA	1547142630607	{"key":"RIwRB2MHPTrs2sKVuDjP+l75OvONreMGuUhDn8S8uFU","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"z7IwLSmC6yu+S2JJmjgtiZNZilTgI58LGTF960y30WaVAhRZ+UkDYFAisBZKmjZD1Yb9YOCcfeYzKtZdq3KOBQ"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAAw	1547142630607	{"key":"Srv/HIQVIMqyAv9x1RzvQn8wzkNQoxWNj1dXyedlrxE","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"U3ohCzxFMfdae5UCyU/v7qXZSUQxPn08B3DD4JU1MdhqlrFfmq12kyxYe+KpYPFV24t0zdmjv2D6rv0CVKKRAw"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAAg	1547142630607	{"key":"OgZ+7V2YFgmHElm55XOvz5nltjeO8+dEenVOF5Kdky8","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"n6H5A/org06VpfQ4MDpoLZe9aYUp2HKOsMMeHPIUeMLe/zjpG4WCr1AQ6ePJFR2BINmt8UlBbDmCikMiXSPcAA"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAAQ	1547142630607	{"key":"H1IMj28c+eysO6a9N8m+y2iZea58mUbrKsHINNea9ms","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"2ev9ql9672k9iF5Ps20dS9hI2umSqX2O9YtSOSlVwoF6d2Tv4afrQ5BxJXdkYkvXDyax3I1K+1QeRIsxL+bTCQ"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAACg	1547142630653	{"key":"Djobab7x1Wka2S4reUi4AljgQFW2IIstFFU9spQRPjk","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"IcU6/hV0WQHRPVTmd2aV98qHKy48hnh1ut2RIISBjPQ2GdYsFUlLT23zBtSz07RrQqTK/8e1wK2vmKEqIOCTBw"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAACQ	1547142630653	{"key":"a/et9SwHrDnaTigMvmPv8U+4F6KE+QQBDPGc5SYOiy4","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"EWOFxqtMYUlq3G8s29ICT5lnG/rAVz093ZwCjkNjMUosjlsq32TSaBHHHQtuheJSo8K9JE6twZZOjm7Qw2xxBw"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAACA	1547142630653	{"key":"27iG2ZxpETmT6Dj/C4F9LnF9vEti5bHQXsp6fbfrvR4","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"xMWBHzO/li9rinY4YwyaUIP/VJD5+ROcO3J4iKuEVjacFRQoD4RkwskIvstzEIARwEH55USs7bv1j3XkBvg0Cw"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAABw	1547142630653	{"key":"BKz6D94nvFqILTtM22ICyv8EOu+KktKjKX4LdGIl3gs","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"1A4X5TgYitK+urpqONS+dEM1qrtQHTW8cNju16o0pOlNIWXe5z37nGdaUmqYyOgh0LMDtcxDTNU2OQLe39jvBA"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAABg	1547142630653	{"key":"R6mfJjWkUZzbn0WUFQtSGrPyr/HgKGJYkhZTulwYrnA","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"IXxDvB4mp+JZG2wIashNjS2MimAFD7T9lE7WdS0ryVTXP1ZGUKzyLmWL+kxihahFaN8gxuQz0TIhiMS2Ze9gAQ"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAADw	1547142630699	{"key":"wsMHOais1KZSnXYDZD2369Fo69ROfdqY7APQMNF1biA","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"CnqpBgpRoItZ7YB+bKO8DzM4VTIa3PszhD/NIrGqAa+d3Lu8er6HRTWXAuXG4BZL51BbZiwhMkFqN0GTLW/IAg"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAADg	1547142630699	{"key":"MCDelNu/HcY2xsKgNmOnZRIUiFZsfzMe3Z1EtB6L4nI","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"JnUFP8yja35AjTTsurKfvXdAfElx+kiOQcV6RnKOUJPXXc85ddt3sbq4G6fbVkv2TclP0JxHWPJKJnzs2U3nAg"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAADQ	1547142630699	{"key":"zhLsCeyUAYKCO3VEaLFNkKw3NQlIWlg1F8//I8t2JRo","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"BOlUS0mWyXtEagTGKSXzKfxOBfWtXltQOD5md8AwCeMtpjku6Ne8coCIcQuozlwVbFas/yVyemmTeNMqJi5WBA"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAADA	1547142630699	{"key":"mYrXeSddnECVb9s7Z0N9361z7R0rZ1nJFGTvcbIIE0U","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"MwdLWns5J6CrqGpwJEIL3Bzraez2+C5Dky6/BXEFxz+Bcktej/cxA2W2DDlHSwQcv/Ej5GouWop047mmsRoEAg"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAACw	1547142630699	{"key":"cOlbt4NPgsE+TDtCee625tJ2dwQ/G1pqY+5FuDk/uXQ","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"RMDpobNmdVpzv1107n/wBvqSuR5awG823FFyszrfKYHaNQD1U66RBzGWiUUy7KnFLRF/Znb1BB4VZHc2utyQAw"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAFA	1547142630752	{"key":"9m0Woit6d4a025a1JiH80a09XH4Y/K0x/k7vdLFBARE","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"DvuFNH0Ry3S8895ZUQl8R3rm3zJUwsYrZSUO6kbPAddh4t8tjrohoEymFxBGHHu2ooN0il34qRPrdADM6qwFDQ"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAEw	1547142630752	{"key":"TIh8gVZLOVukVZ4ZKYYNwTprQoOssOoS0nMsMQyvQTc","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"LFa5NQ+j4n1AKi/Knz1qG6ymcP64/gUSc0Fq+m4LCAPufl+NtKLMGVAQAJjSvPfLH7wPH/qSrEJD7mZWUJcNBA"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAEg	1547142630752	{"key":"Msx7ZW8n6p+tOR/lyugvDS67f6IGP+jAZn+6jCtSwE4","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"bcVAFV/eo2mdTjGrqgqmfNBOhE9DlsrR9FQykhY+chgN4uCOlk0VrypH7DhE3uISBVKAg+iBa3JTIZcPAzJXBQ"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAEQ	1547142630752	{"key":"WFfO4Nw7+CBFIeMWRAalZOykZk7LNYPS4ppmYuRIZT8","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"VY320zroCJHYUiHUPBN45OBRVocXNNOUFRaygkLwOW6v2A/ww3Oi/1vIfBCDx8JcNLJJ0TwVHnToBy9CFzv6Aw"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAEA	1547142630752	{"key":"mN8hQ36bZEEQWiEm3YVMnYbHlcJE6QrrROoysSpxBwA","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"SBgdKl7jzK1kyRpS3jqO5o4Hlk6Qr1W4emgbUmKThF/aetk/tyDoQx79TuKwv4BdHNSWq7G4TxrIgoFYx+QvCw"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAGQ	1547142630839	{"key":"rKvTsRy2C44KE6BLet6b2/+nR0RmpGXhtMYoIBswaj8","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"6ZTlLUoY/vZ5OP3QdP3HQvv7Uxz5mBtzTUeH/WyugeTA/u5hMv2s/Kl+HLOuFd2hPJ89Igv++NT+YCtIV0MiCA"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAGA	1547142630839	{"key":"TW/7hg1Je78vkQ6B8z3m7OLq/87I07vZVM2+OURysWc","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"kSqCKmWaqbVfh8qiF7B/pt15rpCFxtNBh0aWFqgrZE+p3FTQW7GwWV5H1UNhabGedzjbIegScJsFbVbc8iETBQ"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAFw	1547142630839	{"key":"im5sSOclEUrCEfGGp23kgLjaaUoXVZFxjI2aruSxhmk","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"2JviDBjvcw0cQcBlvFxHJsYXhk1DapNd3kUHzlLWo2P2SIXCTnyu7hiwJolGC9W+0N4jFf7LJgP57PVXWk6KBw"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAFg	1547142630839	{"key":"U884Ub/fjeHVfnH/TDZp5biTrDNsHVzxSdmrF4Jgfm4","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"Oa3BajjE4dRDDiCUEP20LKGWOd8rF0/ot6HvzTaal8hg9WrezBejMJc3ij1IBkcceBllr+FKcdIYfGeyO8kVCw"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAFQ	1547142630839	{"key":"fLvefiW81NM3SkMPZ/8um7tZmo5F+D5mAq0EqJJQVhg","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"rIcHTpz314G+wpMeSnxx447DwNo4t2UWOYEtfcoKB/SWa/S7wolnqummE6SIudHbl7l7bD6KHPaUCFL94z9kAQ"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAHg	1547142630919	{"key":"ef0XnbhhO77LoxD39NGCFBIKrlfGUBqxvZUo/IzOgxo","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"2rrNXLq0XKn2QTbw/vSjdZZtHNIPOiuFbEUu0+T5+jjgV3PIoe8M3dr0nsKorcNo6ffI6TnD/qoGAgrEbEj+Bw"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAHQ	1547142630919	{"key":"QDHX325g5zp+A+OsKInxtFqfBUfBMn3cdiCKjPGksUc","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"iWfbdOPXTQnoUVDhYQOwQ9/07isPzbiBnPPZ/SKJ2zYq60M2AOIXppYfR+mtT4czGytzwpl9fXCwWfx+9OiVBg"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAHA	1547142630919	{"key":"isi9woTPpuFkpWsjueOdLNr0V4M5DleGf5pBLdhyGmM","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"J9LgvUAYVV2xq5Toy8a2UYbadOjbFz2Vqr8G0Ra+myn0yUvKxeofODlUYEoLr3bC+yWhGFAZhlkBLP/kQ2ATDQ"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAGw	1547142630919	{"key":"8z0NMiVN5MQ+22ZzUOIZFTG/ZLtaDupDfAm1tFLMhCw","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"Fig/cpTo+YxZW2VWNi9AI7LPEzNATTrpy3vV9mLCmm8oeviNuf8GuEee54M4D2L4BmVL7lGA58OWzSP0C2kfCg"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAGg	1547142630919	{"key":"B8JEriFg4W/RNik95OtCt9EQrz6Sjw+CSykApWFi/1o","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"2mWavboMaxDAmHivcXDKZjVKSwrC7c1relOAFKMbcTFLWJaNm04ZLuU2BEJtgRXzq4luGFKhTWMKnSkJhL44BQ"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAKA	1547142631030	{"key":"YsGxn/fvrBHw8EJWEgLcFRhENsWgjpIwIo8JQIWnum0","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"F35N7MwbgtdIsCO58qhzTt+k0bcuwtWYZ4PXKlCNDbL9mG1GIVP5ghd7FEJbcTb7JDQ2duqFCLqHU4ml4r8fDg"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAJw	1547142631030	{"key":"F53EmTDHMJdzjhPktfbCDxU4Y93W+LdsoYNI+e/C/wg","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"kYL9QQjkQTnDjNTwxJbynqJQTZFv8r2CSMQHwVQTG3txnk5UCm90RBQdx7WuIbFlXDs1JTxsgPUBiSpsFyKhBw"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAJg	1547142631030	{"key":"tJYyRSmx6XrOFbgjtoXXN/V1ISw7q6FjGT+XWdp002w","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"ZHb9sBsDNBt2bM2czO/cnl7QGmFOYVVEedrkpAYz9ub8AOlgziFObS01fneUrOUkG16b7NTYewT9LZB0JBCsAw"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAJQ	1547142631030	{"key":"P+4pZDhP9gjMd3i709rIGkqAz+TQH3519Ry8hEoRLwM","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"VmVjXb7ihsB39NgU8v7BVbi+HNt+ije/98ZxtihdChQYYviYiKi888fFjrXhPJB1viTHUl6qUbanVucDTvyIBw"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAJA	1547142631030	{"key":"vXM6ONMAreoOCDDL19CVpvT1hp+i50HawcLgpnY2W14","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"gPqgXm8N+8+TEr7+oneJr4N+D3byRmXZw4Io7PreIodllDAiC7v4GonBneX8oTXvUtaQapHsJA296xraoLRfAA"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAKA	1547144283852	{"key":"SA6OpPUOftXQTdoiOcXPqL+cuwYaPleiC+vECZLS2z4","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"q8PegA0mc4tz72X2NUXOKERsNz9qRXj7RSYE3WNHFIQ5wcBkMCgmBI1lXlZrjFJ3lsSdBAZ3DJuv3fVtq9IPDw"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAJw	1547144283852	{"key":"lJl77XbcoUr2IqcbSxrbn/c2b9RsBaQJWHjXt169+m0","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"6EnDTh/9TEr6PtTzsEA9JVaakjlbauV1zEfjYmUsfDLNd+KP2IoepltNOPPSB/+NmMAu//JrMA0K4KS73upXCA"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAJg	1547144283852	{"key":"tMMlkm/Zav4S1rvDBdwDYL6zqbVcoGcUB9CqbmycYkY","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"pm/lQnjC6/KpiVFoO3NRwqTEcj67A0DLiMGqLFOVLjNgdoVAkks5DBnFGv3n2OC/b6q1Swmi3Gi9N6jW1euXAA"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAJQ	1547144283852	{"key":"wzYyS0A5b5LkCBSZ5+A/e7HeNwjASiZvFMGiP9uVImk","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"yVy3D9ALhZs/cAk3q9ASEC3cgdBA9XZ/f3+5Sp+brTUAKrtDq6gjbtX5QsIndxk1o+jrVYpruARp0Ifd5dAqCw"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAJA	1547144283852	{"key":"UUeb4m8xQDZpQCb3lAT38M+yRNf7n06fsf8iYdmibjk","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"unp8//QFjUGkMCvgw86Q7CnzZL6iMMJMrvXMqbpan0oebQnFnQmKL1t/KFBkuAgKzuSvh2YYr3ko1xLcsGkWAw"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAIw	1547142630985	{"key":"mP5X2hy0GcEEvXYrVxpPWmeS6ra10F6XrZo1AiJRbjw","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"ezFzq4kA0qX0yFrAnz5uLVgTfJ6FidtNocXnRXIRD+/sjRQnQ9wtcwlcSfH5wcJUQJSYbQoQMBdKRX5/I3g8CA"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAIg	1547142630985	{"key":"WY9+crdBiMPDtUtB7YbQT/XeVNGZZRUNGTUMT0YPgwo","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"i6Te22Qe9dVOdPjwK+xUmNYcE8de8+lVnPAq7Ut1jQl9vHtBR24rDCz+QbGJ0e9i32YPm2Qwl3ZSXthU0+kiAw"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAIQ	1547142630985	{"key":"qPRqw9A9wZYrtvjmWdg1HXx/USQDKioTuDz5TjQTuxg","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"+fzFQw6pMp6jV3yZTsFDh5CQycKQ4gi7v20NF62HHLl58g1Z22ei0NrtuS3KsA7kU3vYFD7Su/vJF07mQYXdAg"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAIA	1547142630985	{"key":"P+XfKfx8VE1mkwmilxDldRVt2i1Ze6u1eBwKgXViCFg","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"/st/TSRcR4LreD49arWcov7nOV5n9zJsn1RZcqpqdPCylWjyiV450qzX1Cc7AI+A0WbnJzzDU8Xtcq76EjtYBw"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAHw	1547142630985	{"key":"P0JsLpjhVvJFcYcsLT771l3gaViUToJuHPhr/iaJEQI","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"ZXKqHQ5b24oBuxX83pq7VMw52XZY8X2GW2nHlb40fiWY6DesjzkfN6sYHk/ATKTmLccLBywhOTfZzIhCHVUPDA"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAALQ	1547142631088	{"key":"3NwGLCFbcSpqVSKwFwZYrjM0P3nA5YzB4uC4JBzdH2c","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"UVgXWFQcJELssETpB2TPrn/jDzP6UudGV44fVhmHgJliRdRV7OsyPE64iM1MElBhrvvS/JMvtyYkpkO3THGgBg"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAALA	1547142631088	{"key":"ByrMoocEjBLyUWx70lBdsTCi2OtPxJl9VIcIaeH5E2Y","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"doxcO8KyF37JXlzJPVN2onA4zBuxA1EJoH/cPUT5dKElgtPuFrmFv7l/3by89UILRzdW8mPmxyV4IqP34dYSCA"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAKw	1547142631088	{"key":"OEgXVcHsjrEeyIXzfb1eoo6Uvyyhi9K8z7t3Wt/KlTs","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"pQbWPX42Zl3eJf1kvrE8+z4WNPLd8BoEFnATxP/81h7Ta9XBJ+kZ0ZVD7bOXz31jn/G9GUPGPA6nDqAU38xICw"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAKg	1547142631088	{"key":"eZASduLp8ZXRtDKFvhJPvPe22hBBSRFTpZIQmqsnxyM","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"fpHAINOQlfxIYP4kt36F+UACkECj2THXFV86f26vI+hBpf8cZQn4iTfmgjlkYfUct8N4PoMGGw4HprKISCnkBA"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAKQ	1547142631088	{"key":"X8qSqThG1ODvOldsdloC3ZwVl6RYRP5s+dLlHRnIUFc","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"lr0PpMzwfHMyJNJP0G1snRu7hwg6wNUBaDKQRu+I6Rm+AzsCdg+TkFw31lEssz25oCJMLgBeYdBd5jSsNtnjAQ"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAMg	1547142631145	{"key":"p503gNzKx+u15sau428U01X6mwUQJsggxZouGL1iiGM","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"Fb3e9cv1tEJ8Fwp6StjzFv3opf541R+V5PjCzMuIp3jeMAcb0s3DHONQiVIRby6ykFmE/wMCo2RgHXIeCnvbCA"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAMQ	1547142631145	{"key":"e0WjtKezGRcr0irzCteUf6cikPFynFnEJjxv1YmYRQ4","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"lSZC69h6Sx9fSZjRnN37N6wcYBKfhyP9kK/plMYnEzvnzOEoSGhdDW61BcD8rNv47ydZ0Ks0sfOAfeBSpmU8DQ"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAAMA	1547142631145	{"key":"8lDO3cpBIvhGBRnb7qKQ9pOpofXHEdNN/88w/rox+Dk","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"dA+PEpTSi6Wm6z+fLinvFg9/sBwkXV1+PQ5ysp49GXtWPZhdGnQoyU8kSxKZs1WDUFCybrLjbCsu8j4uTJ6bDA"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAALw	1547142631145	{"key":"cpaAoOwdEEC4l/SjTLSiXXhktCcq8IWyZjd4GXdfsV0","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"HM8907Eg9mniOkmgNWQ1+sZx5NaRXVJvB83EpiyQrXgXQ3xFe//GhBpvTLN84cC2Cbs+nseI5gmpCEH+Hm2UCQ"}}}
@alexes:localhost	OBFWSJWDFN	signed_curve25519	AAAALg	1547142631145	{"key":"48qTKjB7SwUarKMMmEUKzvmgHSWOKxeJm3PfWoCdmWM","signatures":{"@alexes:localhost":{"ed25519:OBFWSJWDFN":"WqV4dbvTFA6NNUzKmpc76dZ2v2vQYdsYsMr2/4RUxnvysKG5b7Of6dku7y6A0O0VdfistHJCHk3bPlCEzaFxCg"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAABQ	1547144283614	{"key":"/7KQxa67YoK3J0jwFyXaePZQK3eCOL/TWhgehApXW1Q","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"UZ52vnYYjZlZGD0d6Y03iB76zyNEB4ZT6gB1fWQ6LQRlfranzKn76ESzkv4itkgx/Pjl7WrEdHZYaNqON7QqDA"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAABA	1547144283614	{"key":"e1W3qGQRuv5BBhhPLnXkO7l0a/V8aQr0ArZzn7iNDAk","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"k2n6yDw1AL7DUkTqG9dpCE1V8W2Q0q/+mIl0w4UlZwldgZcAl2EP6z+r6HDrWMBunAhxyiJ4cFRVv2RYMSLFCQ"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAAw	1547144283614	{"key":"BhAUoFJ6Atp0C8BdEKHt036HXTKVyIP2JlYPwtuJXT8","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"qpOoJDsjC1jnTlKM3bpFgJUsexpKpU7a8rjwOIQdDXTm+adUcjK3NX6jESFupoLk5iixIB3IAn/rym5F509eDg"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAAg	1547144283614	{"key":"/J0oq7SuI7WBHy1JAhkDNS6dDv/KnqVjVJmBrVI+tno","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"9dn0tE07/7xwDr10T7MR77w3nwvl24lZtNvb34rcR22cnJt4LXLJ/H9GSwRhY0+7RBso9vJBQlmtRi6Fj3/QDg"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAAQ	1547144283614	{"key":"L+l/UBefLsXT4fRNd2NWaiC/WxN9rO5wHbixtnHMwUA","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"6/KGxoaD/ued8NGCnL42QUoEITBSyoOES+KEdoFMM3jqzx+Sjpvv9F0d/YM6Me+xJ1C8odnL4rh1nNP3tFqmBw"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAACg	1547144283648	{"key":"Wtt249BKIMyNFuogljMF7/nmZGtgovFBVHYoA50jAVo","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"WK6vDcFPuqwBHDiP1PdK6Re3/v6hhjGWKxDN/XPtOVjzy1pnUfJ9NrNk7eQttUB0hrmFFZuyWiyv2A3JxcJzAA"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAACQ	1547144283648	{"key":"UFoxvCy0LYGDQb4Zpsiw1RbCl7aReGJyn7srLGtKQE8","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"Tajl9Ln/lGeU86t2vy5hLoXIgNfi0SU1OQINAgKgMw54T7hULfT1o0sPcx6JW1dIpug3seQpMLp0sisx8nFADw"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAACA	1547144283648	{"key":"hEOzh3EuR6zKY0busmdFpyeEdP3m/lcQAB4kIk8I8jE","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"BDt50KjO44XL9X2dZm9oe5QwV31unO9ePIhpwWDTgRuY/UTQK/NhjejUt6gwAyKhzhCLt2aEEP8/MpiLfqeZDQ"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAABw	1547144283648	{"key":"O7FE2nXnCs5WHKM9LhkifgpDlkcSJDgZXz/HqVx2tRk","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"KqGa9uNT1skyJHfbCxwye8/4+YYyVasMiBOUkmKu7aVz/a8oT6RAI/e0ZeMlu09VdQZtcitQxWNnt4Cj16JEDg"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAABg	1547144283648	{"key":"JoKG2Rz9fWuTgoTREbf+b8JNQh+/AOmdBIXYBh2+D1E","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"4J0gtMhopUuVM6ObtlwZKDmcFp6om4SqGhcTtgbytFcT8JuvY3CAreGd86zWX9ZHA2YQUEaZ+Lie/fRFUJFYAQ"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAGQ	1547144283770	{"key":"LZFXKFTpGM5NKpoZGK4MvTLjC11zxT2AFn61Yd+uMjc","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"3qPKJPNCot9XIR4M8g2VRhqfxIuh3D3ogPJVoJb9V7vdRl+S8W1aGsZiOAJXPgX19oL7T5djCwDgqXq6PF7EAw"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAGA	1547144283770	{"key":"2Oinz8UeN7hbW3aRfPryWJA1X3yT7zGOw124YlZqXiQ","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"9KNrd0zr74OoxDeBV6yvpzIYhSXNp7ZSxAJWNQMnJ5kIkOMTXW8dPbMp2eFT/Ouox68u2228DkZ9U3Y8MBZeBQ"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAADw	1547144283697	{"key":"BEUBKtRUgoFkTMRTEyDFTM95btFV85oSTd4UVr1eygM","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"Pl7n54/MSrRtOUuGv/GO2jxJs+ZBZa/rnF5DIIPmkpxMmkQxCwADCez9M8rxR5cblO/XKtS+MCodRkipBjxBCw"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAADg	1547144283697	{"key":"zbs7riG3RhPzKT60oIUx08sQ8XNUD0am1yGUIB2wnmQ","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"AcoIiRkpUKfA+YuzjaHpFrFWxc/6+qDLwSDANTp/ueTi1WvtbuNLIyzJrTT27SKcDR74XvMfmdszOH4lPYWrBw"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAADQ	1547144283697	{"key":"K5XelZXsRA94lNpM/ckzZ7HvyIldTm47bpNDGd8gWRI","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"V2hndZX+GpA/uBJ6NtASYycb1VcUaU0UYRp4y7ta+4pYERS4MALZxNAyvVNly2tb8FxjqiAKImz2z5dgFbNRCg"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAADA	1547144283697	{"key":"R9q8b9UpKkJpAynJK8cScYkbmOm1/MJsf62NcY85Xzw","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"RLanFuDuxGBWEPsrpqj8WC7NAP/xSgpwnXgF9ffg7zKR6wFaJEEN9UyUGfEEUI+yDOSFHKnrUfy6sXSMiuaFCQ"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAACw	1547144283697	{"key":"n0bm19eqaEl0L4gnh8aG485juccVrgsJR+Xm0pjcWg8","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"vPad8g4387XoSSveAgPX3pIFbRuaCindbxhRNJQ+O/Pcz3Kjgg20nonaGQD5wGsPLDnYBARd3qFyvy/h9i12Dw"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAFA	1547144283728	{"key":"MxQnZLrpGC8qNehvO9s8tdkMBwABFYIABgSIARWNKlQ","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"7jfmRGSH/LDCAQpSaxX6oFDH5XnB4lwJGwVuV0sQeUxWU8VdoT81K8YFTdexHgfVISjRCrLx9YxImU2m5JWTBA"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAEw	1547144283728	{"key":"1OIOJ+ySrT12Q5X9FkSTPQZtOCuAbwxMfxT5UkOEGTw","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"QkoIhjIVobV2GaiGYJsxkPAQDS65zOxanz1SFdFicf37xPb5DjoUaE7xPh0PSyYu/du/gMIwTQdnXEmcR64TAg"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAEg	1547144283728	{"key":"lrpRJKY4Ab8rs+LHD97qy6DX88OecfXnVunWHjiM7zQ","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"FfhQVwV1sXG9AyzLvHBaqeC/4pzGtEsLaOaN8aYsNrT71IU1SGH7bDfbni1Gbq6iWoPyeeTyw3EhglBJ5Wn5Dg"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAEQ	1547144283728	{"key":"1jBLsz+usa7fyjZFzjX7oImvAE+CmY603Rbkv+8G+DI","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"UQuk9x6s20VvUH04OHF5TfjrbHoSQZCRrG9m97JwOCVZ6iB/uHwLCmCbqsjaRKU0WpBV7gB6Tdv/M3y4m8C/AQ"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAEA	1547144283728	{"key":"othYKr+Z9oSBnhJMN6Yb5gHEjSXfymwqG1rv8T4lFRI","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"a6ED70baRezZv5NV1/1AKT498hKGpa+XvKWuqqVAQINkVeO+RlA5AzpvmtFlNiyNVFQfo7qXTs7thwDYIe41Aw"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAMg	1547144283900	{"key":"v7X2WXn7j2OUY9yAhuTp0u5/TdSidEwausiH4ErpBRY","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"CKXkDKA+zG05xuo/FwfP55Q4fe2X4slkGP/1iUjVNa2O/giznuNuaTnKha6XapAn/JmGRaU18EmWZQlLXl1QCQ"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAMQ	1547144283900	{"key":"m7+zHiZdfEtDkYbiCX8A6pSQlvUX0vnivaEfpjpYNDw","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"jYZuTiFy+hRAsHmbk48JqGdsc0hwjFZmQAH44Yr4+OqYJehLreW70uhwNIth6IPZTeu/PhL4QAUwrlByRO/DAQ"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAMA	1547144283900	{"key":"/1wXa3o1KzuJquizCfdkA5oFG8HRJBwAeYTMtTAI1xE","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"cQej7J0HyHEKx+f+2yXT5Yl2q2EMcnyOVmzNWYht9IQ07xPz34rOBpFFX+byOH/EaY2B5OFg1Df26tRjF4byAw"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAALw	1547144283900	{"key":"bRyc+OzZAozuwZdhrCvNRMWY0f7d/ixm4mWcu5ZeFA0","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"Xs5rrI8j5cXmK6mLe1xJVszgKGCPi6IoIO99zAAW9JQ9bperNwYJHnAOB0f5LwQmCl1SmhFLAJmAyLaZwRnWCg"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAALg	1547144283900	{"key":"9eVGMNzFoXFDIgVMInd4H/tMsVA07hH4tswBzQ2NTSk","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"kWxP05Kg92df64FuqbEiSBgI9LaiXwdBwkMj6YNYL4LLsMs3syJ2dD6BMim1NKJMGzZ6SbQ6w4Y7Ed0BLObwDA"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAFw	1547144283770	{"key":"n8JUTw4GvU3mcaHwbVkf8tKrDLlhaPPZ6YSRkmGxjRI","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"9V2W9dV436ed7uapQeoTRBaw9/mlKj5mcGylo2xHsd1fE9VlagYniJhXWfbBJ1JaJLE7HRlMogCc/x0cQ+mnBA"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAFg	1547144283770	{"key":"FbGgDtApPxStzVER1/SQ+XAkXPv13OpvAqv4juPxuj0","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"rFV+dD3ydjv55HpgEh0wFgcD03fgUNkws+B9f4f+1bxH8RAxEQDD5FbnjvT1keTFtzWUxyCxQCrjuBixlAmBBQ"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAFQ	1547144283770	{"key":"72HIMXl/ovtVkzphOAfyYLsWUt4Vg08Nyn9s/ssLZQw","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"pCyRczE3RuPa+Pcf7vXKi5yUzWvnNeZ3TQKeRgQYTx3JLcR2kCXDg4qN65bEJ+h4NDXD3aFNDMXWScD6FQusAQ"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAHg	1547144283805	{"key":"46MDJAmAUX2yNvc4xVD1rixZlp3dZgtnn1/BolVHzGE","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"WD7qNULylpNL6C/JwT8Yj2QOt88r86SZPMnaNzRZeisNXfUFYNBZfTLwNrU5i2YMnwq53r9ZJdxaousA8fxjDw"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAHQ	1547144283805	{"key":"Wq8qz88i6/zZaTj+aIGi36jm0wzl60Ocu8P9m3b2IkY","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"59QhgN9wLL1j/V7A5AjjLmSvI6ReJufArk4Bsj1MazAjX0Fdop0vH71brjOt0KkHoo/CjJpRi/6Apj8ghQPnCA"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAHA	1547144283805	{"key":"1klvXKTdFzztWN1g9H1PdxbLqWtDu5Uot1gK/9uW91g","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"l+EXIcuAX412e0tPI1zgy8HEzZcLWRKIT0Q/jFaDgX6kS6MZcBNwtRMglfefF/ErPFe8dihS5CJdjz+R5saUCw"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAGw	1547144283805	{"key":"v0NoH9dIuDvaVYWbFhJ2eAkML+bWi0biohjEA24xJjA","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"O6dJGh/JAa4RKYkqY0GC1bShsFUnJ6c41h8snkeNXBJ3L/mOJZsKJWdm7/k1QPsBD+USKu7RZbJEFcVgzM4+Ag"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAGg	1547144283805	{"key":"Chl4wIEVfpDwHYFHfMCDN2EbvuE9wQTwRb0C3NsHbT0","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"w//hQ48Lqs9ULNdu3vpOewfGP+h4MBLL1SI3u+h7RlWoT59bsv0U/5WdntZD7ys8ZDJelJz74QnQx7CPxpkyCw"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAIw	1547144283827	{"key":"QlnyuAc2tyzaqZwYHcOwGO76+pV9S7u8CvU+bQg56wI","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"jzX1cIzP+ahaGpkgpPNP2mQDrQRM1zVASajw0d91xb7v+Mc5Ynjzod97avU3/2g/2tIqUozrJ3ml85CYmuWDBw"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAIg	1547144283827	{"key":"niMwUkLlcMNfRN3Yo/pdAXFc2P991tFDDEN7W5MR8k8","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"+8PZcfLbruMtgWos0PW+w0J8dBS+FSPWUFcUoGSaUfHLF0lSq5GUl37uBVMKwG36PJUIjNuhAS2h2lOGUHlnCw"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAIQ	1547144283827	{"key":"aZEme0hXaYUIql2ZKC2ty8CZTlnq0BJ6MnzHiAWrMGg","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"3SweHqSDig8c8tZsXo5NeQ5aTLakyL1ML10Chxpw2KcKwycrBfKP1zOb7eQkmXHovg3oz53l2HMmyhc+tRLHCg"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAIA	1547144283827	{"key":"dik1V4cjib76XH548JThBIdcD1i/gNouFX3hQm+QLzY","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"4YFEZsMYjeLfJGy/fpZUdw6Sgj/RHfqTyqpmvr6Pgk33LUfBOb60j03sewRu2V+f/ZHiH3zAsr2jjRYDD9+UBA"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAHw	1547144283827	{"key":"duoVAR5OVY60vr39FMTuKk1XAwaxHdRP26MrLuTkDSw","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"K/duB30BRmMi5KshhracAti9XnFClltgRe5kLMxAYujuZsv+m1Z3GWKL9HyD4JXF6ZRBAHWxmHFNgDIlOoDFCA"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAALQ	1547144283878	{"key":"+kx4oh3QnPcnybj6nvc1gxlH6kCBGe1HHae0RXivFFA","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"Rf9sINOuqrYzeKEQkOJfcgJRpPHZryvO++Km+yRnqW5kh9XYjwUcVCp+8IvxRoA1k1M+DpRpaYmTb8iHIQzzBg"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAALA	1547144283878	{"key":"sMkzebNwnMA2blYKO0b+q+y7GjmkDYQN/v1Oap8IJzM","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"RIAVgz/9Lq3JiGkwPkUC6jM1AfHbg9GilR+CxiDgKm/Vi7Gw4BHckUxjCb9Ywejj8GTH5xZLI70/0Xjhj5+rCg"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAKw	1547144283878	{"key":"FPd7z0X5WCIIRA55jRDEs13SLoCZk1bSFnquwpBCtQA","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"nprrJiLkTJK3wsZXVuIOW7Qr9Z67XXUVqdhgeICRDf1SsHZJ/SSp5r9HFJx2y8M+HCiZq/T/1XsC3B67bFaYCw"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAKg	1547144283878	{"key":"L7sZ6huifdjVTKy9vUE1UQdQlpYVYcs/wW2ImqzG7S0","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"z90Z7QAdHIHtOhvKthG78aj6u8/mYaZHwLgsf0+zeSQ+caEuOXZRuJkSbFJF3mqVZGBht+2DZmuGc9pYb5xnAA"}}}
@alexes1:localhost	UPEFWAYYBJ	signed_curve25519	AAAAKQ	1547144283878	{"key":"gprrkP3v4m0tKZCx/gs76Xj5L/IP5G+gaQu/9oJjD1Q","signatures":{"@alexes1:localhost":{"ed25519:UPEFWAYYBJ":"gcPVHuW5wCEPwCZi+/hEd14TgrUR7afWGI9QlwwVEz+GhsfekZfEp4tAX0xnyFHx8DeYPMP+XjLQIukKdEXWCg"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAABQ	1547188107054	{"key":"V8w0Iun1+90yBlgQi2liXG1tybXCaj+Llbv6tk4A2Hs","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"0SaX0hUUvCDCLt2/wOs0+y0O4DHViXDpnKIz+LbN2Hw1tB9R+vesqTrh1VnpAovC83GG+zySY4ZnhgIcenVoAw"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAABA	1547188107054	{"key":"OShjCt6JAH15iuNwsqf0QPuatGtAiNksrvXJoDnprjs","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"W7Q1e7pgqv9GnqhpLsXvBIBROzFaxUXDq8ssLsLtlA1xYYFfr6FdGG/lD4rnn9Ds9yWOHwqKpNfwOVA/5NonCw"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAAw	1547188107054	{"key":"jMn7coPVbTpkDR3vLKzzOrepKdV+cP1NQTqNDaSRpE0","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"J5dXdHhL6VQNswaaB8HOxG9t62HVHyhazdD4mMBDjZ5MBkpsNRQyNeVl0vqLz0TTBg9JYIzugLHzBoI4xCxiAA"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAAg	1547188107054	{"key":"W1hxEkRqKE+Y8jQQifAO+wRsNZnGuL0fVO7d+2KxWEs","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"EBugF03BGsme4mCESmNcUjSU1MPFGgyIoTV0065q6k+pHsyuLkyH6wK55NeC5bzPI+XHpwVWbgG/YVKg7c9pCw"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAAQ	1547188107054	{"key":"TU3hC0yYdYvpbVehEb9vw9b3Q+HxNaMn99O9vGRBLRw","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"lefh1plmMHuYYilV5xia2eAO7hVl2ksxCFE2lhOcHjPE43FpUJQ8a7OeP1UGj9GjhoRiSlHjdFcpbjSKKTNoCA"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAHg	1547188107318	{"key":"ntyoo/PLdXoDoNI1xgpdZxSQT0WH0GXqoIePXQMLMHk","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"yeXgNnMY2RSYX8e1l9g3Z15YZLpcRnWHgArFBw1UjWsrVviPWWy4GV6GIwv6RTj/kHteMzDfvVxFZfy1WNxAAA"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAHQ	1547188107318	{"key":"hT7xJwUBXjH9Da+xcdBim0RFr5Vyg+FCOq+vy6H7+QA","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"dGgoqbaYoTYcK0J/pmoZYaTjYHdJ/AqVTlJcf7ueEFE0dilS0HySA3Co5tksF3nxjycGeMnRRt1BqxWrMKadDA"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAHA	1547188107318	{"key":"EgLaBozm+NNp4wiq5IkA60JYwep+fSjUkrq3ZnzfVnk","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"CdEduINHVgKKFnyB5Dix+aS2SwKoI5DD3NlnPRVYoegda0AJWjaDee2rqTrIfKFR9MAA9pH3bD0Hj3xopnSJDg"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAGw	1547188107318	{"key":"hvm+joJpjDNnCHRlvXoCttSOSrXK5V4rFRoBGbtI/GU","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"ifz2GjXvBRaSVkjhqpW/jI24lkWTpCCv0HTN8EHIJ8EPia17M2PHFqbaaN7WvsE9l1+oL2AxcDQEYptACCcnAg"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAGg	1547188107318	{"key":"GGVjCvpBYWxq6ncs/xJq4vQhzQD+HUL47vKM4Igq7kk","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"iWpiZLvxNFMPCR+3qmPauTsx2NQEMxuZi21pJUbWfBVhQP06+WDGqTw9OVCSts8MpXnPue0Hye4ZJ9srerxaDA"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAIw	1547188107388	{"key":"TcoXWIkJ4zYZDFNQpAq48fVmzUIv4gkvPOgSXFl5LBc","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"DXPc6LXtUHvZXN3/KhUN7FKIY47r10iXb8gCeX80v+eubuGp//TUo+LJtyiAImbzK5ArGTR+lJOAc54IWxc9Cg"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAIg	1547188107388	{"key":"egIons4bQkZUqxOtpSwKbA+Gx9QqRf86xQ36NYSWylI","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"wCy6dzHYs+hM6k642M5iSYpob0kfEULpH3oMHkEbxI6OJeLbZRqaMrtMScn1x/23xK4e2eQ/gMh8OZ4Z4AtLCA"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAIQ	1547188107388	{"key":"xtn1ODQ62DInB0qaNkepfLqEyB9gNzqnCa3Ncp1nHDk","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"kbx91L4PIeeCHEXc0eowjJcPRdgTFpGi862sgorWei37Ke7a1jK5XKR1nJQRlAa3Jor40U0oBVk7gKZf2jv4DQ"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAIA	1547188107388	{"key":"1gq9si2+dl3U4vMoq0ixOQaoOBuqAt1fI90nS8vW9Bk","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"tU2jhx2nhRN+g/23PVKBzqY+hSGkYicR5mYRAZa6N/5+kn5oqEz9WWmM1w3O3+AAHo+jXpI8+sr9K1oTSM7VBQ"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAHw	1547188107388	{"key":"9d8mYq2PhZDDe+Q4GwwkyPYLlwGpDLUWAR+zDDY2vHg","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"gT+WuGDD1t50gcckl8ipXxKHB/8FyNA6TXEM8GSlBQpPM8G+Y2jKHAA7XUR32Yg75QNvu6D+WLGB37vAP+9hAA"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAKA	1547188107460	{"key":"1kYIU2uKTTCA8x8/C+OfC9biiVzlI69vzjYYSOlxniA","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"yChg6cUVZ+ceBHvVJxrlJtJiBvtSq7xwiFk80RQA8MiBqfsb/7TYqA4AESnlD1uL8i5uSs0kyDK7/3QsZZi2CA"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAJw	1547188107460	{"key":"KFrj8qC8jhHibUWsx5BSWWPKTebNuPrDF7Vc59XbyXQ","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"o5GvbOFfnY9i4qdtLZz8C94sjQiZVvG7/JQufZxo133q0quod937ULlIQmo7wFfddeVQrscKpx6/bZnjXVnEBg"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAJg	1547188107460	{"key":"jp60CLQMp3o4/EFdWwe6VUZTuc7PI4h/1W7x0YQapyo","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"x/rlf4gUIMm53Ihh6FREsgeBM9eCePnfY1rdevEBXwTUg/XUsM7EAWKGXBvGbtarkpj+MMvsE5uINh1ML+YjAw"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAJQ	1547188107460	{"key":"ercZr7cM82yhj2Qr7VLk/qAWvs0smRr9rbn0qhPzziY","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"TOg32YYV2Cc9A3z5pfZXoezsi0rkgS3ETDSF/6HtkMV7LcVTUFkzvSndjjRv6p9EZBWw6GGJWC+3FWGviIAfBQ"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAJA	1547188107460	{"key":"dUeq2QlTyYdr2NTM3lJvS+shv21Tc6PzynKj09cGhWE","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"bqD/tG7/P+ns/SRVhQ7UaWeO65vpkxEfU0OxvOteuTSbsbxSKI5F9bdcOKFouWQUyr4FyF1XkHCTgjNBBAHzAQ"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAMg	1547188107629	{"key":"z4jcvaqYgpmvDSIS/D1Op4b1Q7Aa+0IX5808u+a6ACQ","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"uf9Li9GizwHitSiphiI3DwT0NM2YpPkFzkX5WrV+poQUKh8EDQfx4QqBqIGWIg4qTVnRVnwiqzBjf6gRjF5ZBA"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAMQ	1547188107629	{"key":"EERGhuOAlXaTJlEGgy8unAF6fmjLk5u6Pf2eqMNqKk4","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"m9gqfQVvAEsem2LlOhyKCF1ic9+QLdhELxngXEju/VO0GcPYCgemNlMm8vSKgerHTMhGqikPsF9HzbYHKlAuCg"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAMA	1547188107629	{"key":"2pMfhUy/szQC+YVZ3RWJo0FPKxNOLaM6QL10wwriPyM","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"HIAmEZjgQAAOuOcNeXqkJO82TElbEJI3gvvvp+Da04DHtpF6PMNs9UIKc2HyX6AKGPtE5RfhVvGJnSNAH56lBg"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAALw	1547188107629	{"key":"tjT99FukQ2sckiiAo0UWSMdGHEbI+7ECf1hYBXKiXXA","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"dQcLMINEYnuwlFRQB4nYFSnMadJ2WdZaArLJEMv5LSsx8slEBHIUYrtHGO5oDS/jVA6lgiPocvJJp/s5fKDJBA"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAALg	1547188107629	{"key":"DMHaMsq61/ht+tWcvL4AlisBF0LR/TSAjEc1kx/x9kQ","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"lQjEtL9vd+TEzjeDMgIRhxykrFNqaAcDR4OoLXJ4pd9Ry8y9iwl17GWxHVZYje39lH49y2LPkEJ1DGymDGgxCA"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAFA	1547188107190	{"key":"XE7E3WeUKuFvrYueE1OAzDM8b87vXer7E/6CxxPmslA","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"dxUBBBnaiagmajvUaa11h5k6lpny0HU+MxWNpU4WCVYryPyPTCXxbVEVJL7291d7i/ISyU4NbMeGSEkvtwlXCw"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAEw	1547188107190	{"key":"qheDRzkaSa7PEyXLdqnruImGXFD8wQBFd4RB6sk9AFE","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"dw+aVH6odbg8aMrMFBSNv1fi6B+SJFyB7z4U5FsuqOo0BOsvWhTjU6NHzGYX4xTnm+hhJIAqSHdpKkGxc12yDQ"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAEg	1547188107190	{"key":"WHIiyNvBcCchezSHUqsdxqFv5Jtzt+nar65JsQ6jhDc","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"oYJ7F6xPE6h5twAtDfNyuqErVnHj3o+grHg9x2OhvJllJVps4vtniznSdFN/NNurVrZOeVLLMDW70SHwOkg3Cw"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAEQ	1547188107190	{"key":"UK/LNOHJqz33d2uDRTeqkIpXMtuHzXiXyyOx1RYAmVw","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"DqfxxcrcM5GgZybRhYVt7GYnoSXpBDLIsqweL+ip9xuQ0rmCPhCQlPozFmWHG4DXWD3A+RDj4gb+n40tK1unBg"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAEA	1547188107190	{"key":"m7sim4YSIDym2U4P/JF8b62kAvchFZjlBnXx7akEqnk","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"xvU2gQ7d9emHeWyz1+bFOuk+lXN9p45HqY15Pcans9KUhXYzF5wFXVecXkoSRSVQ/XiVzVMh049DQUTwTyFeDA"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAGQ	1547188107241	{"key":"mw9elNrZ0cUI03/LU/7dnLoJ+96YRWA0eNT3CCRtRX8","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"ydsksSiQaZYj3TrbqPYpjf+QZDgyuPIhReTlCl9Vo1pU27Esex/d/L7hR8BhtL4QXH/ogoLgD8rTDdBxL0IyBg"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAGA	1547188107241	{"key":"dLxaiwNJNeoYHec+ofdi4nDiHlCA6CWBq+39CUCcUSU","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"85PGTYN3Xp8xnLqt2/oabK0tFS2UOBrCdN+/vtRi6PK6wShhfiECQboDGy/N5+mjQr8i/N1ibe/UhKV/aGq4DA"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAFw	1547188107241	{"key":"H5ppOWbY/Bed7EOEtuJRS5dmRJx1KMqVZBvPr/+H4js","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"hx+1/vuJ3FmiUbOrAW+KvPquvfBPGg6MhVuvLWEYkp7XiItTWjuRmnJ+Y5C4NxrkEyPooIh+oyaiecMklamOAA"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAFg	1547188107241	{"key":"YwBR7+P7RVQpHfqrNuzxm0SmXRR7On8lJ0GTAuYaxwc","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"X2qcZB4r2k8M6QMirOu6KtJhdYO18aR7OovtsQnC0qYvCO8mLhmb23jIuFtE+dYE+1gT6B7fxTEB2/n5o6WrAw"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAFQ	1547188107241	{"key":"YfO73uKDXPMjVTRVSwTGVNNtD0McctZm1Fha1nat8Xg","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"+X249kGx+BEt8wF5sUZLwsRJtx/RGJFQiPl12CDz1RHdFvcZJeCSyE0tCcgwsxbD5JX5LEaAFJfcKirnZmLBAg"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAACg	1547188107083	{"key":"IYaSHlUFvWf5jxlUdso+rz0hmK3kiMP5uPK02O+rVhQ","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"VdgihopeA9lRWHkTY+lt2N2r/JWAX5FZuyNNwGN+tR5mu8Fvf3vwFb4/bhZwsqgUEbuPoXAcRiN4jGR7BNZLDQ"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAACQ	1547188107083	{"key":"n+1yNo5MUDmHEDbbkypYgbXoyfrnW5fS4JW+/yzE/mM","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"J+h1ZI3NPm0AQpIPGfux4OVeA8tFw1/m4b2q+XQwDVqh8M63LySezbmr7SBLmpcyTMptjoklpn0xszk9r5twDw"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAACA	1547188107083	{"key":"95LuvY8sGKb+mMcmejR/WKTlmJDv3UOo8p8Hnc5J/xs","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"UUIa1tdm4b+NYOODzFWK6aT3SeEwI8LjVjbj232HMvIu6q+VgNpethRGWqU8Jei0x7akfX+Kj84kYP4Bqbu9CA"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAABw	1547188107083	{"key":"37wDi7iEXklORZjv85YzwNp54fyziptnY8h5mZWMyBY","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"8VxOGKkMoAknjV8+/IZpBt8ENwwNzFfNg2xETM2IMRE17OIV+jqmf9DlsMvC8ocizQLikTeUprP7rO5XpvMjCA"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAABg	1547188107083	{"key":"ow2K3wqCU35wTUDcQdlbv6E5gE9EPHEsFbS0t88gHRs","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"79hH/KMbek6Pjfx2voUg9ksISW4nIIOspnIk79+hIQ5w2VlCsNa1YW3LLCn1e2aquKOn9PmJePt8uHpTbqykAA"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAADw	1547188107127	{"key":"djL2yCswDSx8Bgq/EQWUmNPlH//I5MSK8nbKYx6SpwI","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"nG44P0y3FgNSIGz3ymc2haBMWF/VwuUfjTeegeF/xQHFkOfaV1uP45LPuKGsgdLU9k7YHp5i+aMWsv2/zu13Ag"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAADg	1547188107127	{"key":"U1941aCGVP/23eIShhjg2IRo9shB+ZB4WhmXM0OtjVM","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"wMpQoQoJphw+dN78byMCuuvJvmraNMCSBxaSMSmh+ufo7MmPvS178fDVzwCnCplbKwAfSS8pN/zpI8MxRR/RDA"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAADQ	1547188107127	{"key":"4SwmZ90ZbH5E92c+SUAyNmIYM1iVqptu3g5Vzf733Aw","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"bBB2wua1iYnsGAo06DlFe4nY73DS7l2j8NJWlex29Cq3qQKLflyB5XSzSfE0i9quhWA+nKAMUGnwuOTmWXZ2Ag"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAADA	1547188107127	{"key":"yvFiXCuA+p7OOw08dOOtY+XTOmS+3RHwjuv7w5U8EXA","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"oBN7ixtQRAshgZk5abZ9gjwNDPSszFbfFyeJLQwtc5MKVYl9sOEMEXpAzq/sGmohvxLSXXK3WtHwlqK63VMBCw"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAACw	1547188107127	{"key":"v58p2+g8alXTkPllpVnTCC7gpZm0trHUiG1ky0iWBjg","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"rxgFSil832/CQZCq2MTLSq6+71ngfonDSYh1IGA7Br3xEW35mR1uPMy5qVEGBW4l93bkrAZITb1xB3URkQ/gBQ"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAALQ	1547188107541	{"key":"o0Wi+5ZcmHaMnQbWm7SxX8OLhAOGOopzxg/g/iaUXRs","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"aL077J3D9F+wEII8TI7BY3pL6mhx0Uj1EYdNFUhOlUhcxz9S1Frw1JM7x4DpQlT8mza8GonSC/fjhyTO/UCFAQ"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAALA	1547188107541	{"key":"ktVN+hFCiyvoQR5whj4XaZsfplscaCCDJPBUQh5L/WQ","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"iZjzCyBY8vzY8X/r/15XUMvGEyScxYH2XRSU55Dgfu01TZh2oakPZ3EhE57AuQgngMH0f75lJHhwNooe7sIABw"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAKw	1547188107541	{"key":"DLLLxUrNVbmqRsG0dRD/kZjr8No23+2dt5bt6/4ukGQ","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"TOMcbEXfjwzAQZ/H42Tdgey8rK5Lz7BU8nOzzf+Urpkf4qMG4/YUFkKCh7mr4c6FOV2UC3rR6NNskzVFQr51Bg"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAKg	1547188107541	{"key":"p1Qe72lE+jJkgJa1s1B8O85a/srpY5ihgAceBzm/B0A","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"USOTcIppMlbGBpusyPtu9VUQgBTBtclGOad+aLSYfPM3MhCI5huW8BufPseWvS577NdTZHx0XwVsW5PZqRetDw"}}}
@alexes1:localhost	DRFUUIBBAK	signed_curve25519	AAAAKQ	1547188107541	{"key":"HtAwmbAi/KyQJAEv9LJdEat2lQpV0gJUz+u2ON1MOXo","signatures":{"@alexes1:localhost":{"ed25519:DRFUUIBBAK":"i437PAxpeB5ceLZW7wcJ9FBRhof1oPY3Jvd95pjbGm3iI5+DxG306dFywBzWf8ejbyBqZC7Ev9+s9RM3c2c3Ag"}}}
\.


--
-- Data for Name: e2e_room_keys; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_room_keys (user_id, room_id, session_id, version, first_message_index, forwarded_count, is_verified, session_data) FROM stdin;
\.


--
-- Data for Name: e2e_room_keys_versions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_room_keys_versions (user_id, version, algorithm, auth_data, deleted) FROM stdin;
\.


--
-- Data for Name: erased_users; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.erased_users (user_id) FROM stdin;
\.


--
-- Data for Name: event_auth; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_auth (event_id, auth_id, room_id) FROM stdin;
$15471426301dPFwo:localhost	$15471426300pPrwQ:localhost	!mpvAGWWPEpWsNydYnN:localhost
$15471426302pIqiF:localhost	$15471426300pPrwQ:localhost	!mpvAGWWPEpWsNydYnN:localhost
$15471426302pIqiF:localhost	$15471426301dPFwo:localhost	!mpvAGWWPEpWsNydYnN:localhost
$15471426303YCSmZ:localhost	$15471426300pPrwQ:localhost	!mpvAGWWPEpWsNydYnN:localhost
$15471426303YCSmZ:localhost	$15471426301dPFwo:localhost	!mpvAGWWPEpWsNydYnN:localhost
$15471426303YCSmZ:localhost	$15471426302pIqiF:localhost	!mpvAGWWPEpWsNydYnN:localhost
$15471426304BRdxH:localhost	$15471426302pIqiF:localhost	!mpvAGWWPEpWsNydYnN:localhost
$15471426304BRdxH:localhost	$15471426300pPrwQ:localhost	!mpvAGWWPEpWsNydYnN:localhost
$15471426304BRdxH:localhost	$15471426301dPFwo:localhost	!mpvAGWWPEpWsNydYnN:localhost
$15471426305IErDp:localhost	$15471426302pIqiF:localhost	!mpvAGWWPEpWsNydYnN:localhost
$15471426305IErDp:localhost	$15471426300pPrwQ:localhost	!mpvAGWWPEpWsNydYnN:localhost
$15471426305IErDp:localhost	$15471426301dPFwo:localhost	!mpvAGWWPEpWsNydYnN:localhost
$15471426498QYDnP:localhost	$15471426487fdcng:localhost	!CrvkKxgetahhVIwnyX:localhost
$15471426499olYQy:localhost	$15471426487fdcng:localhost	!CrvkKxgetahhVIwnyX:localhost
$15471426499olYQy:localhost	$15471426498QYDnP:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714264910qNuKi:localhost	$15471426487fdcng:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714264910qNuKi:localhost	$15471426498QYDnP:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714264910qNuKi:localhost	$15471426499olYQy:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714264911TWsje:localhost	$15471426499olYQy:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714264911TWsje:localhost	$15471426487fdcng:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714264911TWsje:localhost	$15471426498QYDnP:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714264912SGfjg:localhost	$15471426499olYQy:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714264912SGfjg:localhost	$15471426487fdcng:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714264912SGfjg:localhost	$15471426498QYDnP:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714264913PCUQS:localhost	$15471426499olYQy:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714264913PCUQS:localhost	$15471426487fdcng:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714264913PCUQS:localhost	$15471426498QYDnP:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714266714gvEsJ:localhost	$15471426499olYQy:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714266714gvEsJ:localhost	$15471426487fdcng:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714266714gvEsJ:localhost	$15471426498QYDnP:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714428317sWMac:localhost	$154714428316KLrwW:localhost	!RgDCNwMiMxKykVVClV:localhost
$154714428318OamJt:localhost	$154714428316KLrwW:localhost	!RgDCNwMiMxKykVVClV:localhost
$154714428318OamJt:localhost	$154714428317sWMac:localhost	!RgDCNwMiMxKykVVClV:localhost
$154714428319jqvHZ:localhost	$154714428316KLrwW:localhost	!RgDCNwMiMxKykVVClV:localhost
$154714428319jqvHZ:localhost	$154714428317sWMac:localhost	!RgDCNwMiMxKykVVClV:localhost
$154714428319jqvHZ:localhost	$154714428318OamJt:localhost	!RgDCNwMiMxKykVVClV:localhost
$154714428320dqSvn:localhost	$154714428318OamJt:localhost	!RgDCNwMiMxKykVVClV:localhost
$154714428320dqSvn:localhost	$154714428316KLrwW:localhost	!RgDCNwMiMxKykVVClV:localhost
$154714428320dqSvn:localhost	$154714428317sWMac:localhost	!RgDCNwMiMxKykVVClV:localhost
$154714428321iaMIA:localhost	$154714428318OamJt:localhost	!RgDCNwMiMxKykVVClV:localhost
$154714428321iaMIA:localhost	$154714428316KLrwW:localhost	!RgDCNwMiMxKykVVClV:localhost
$154714428321iaMIA:localhost	$154714428317sWMac:localhost	!RgDCNwMiMxKykVVClV:localhost
$154714436223plixL:localhost	$15471426499olYQy:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714436223plixL:localhost	$15471426487fdcng:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714436223plixL:localhost	$15471426498QYDnP:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714436224LoFLm:localhost	$15471426499olYQy:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714436224LoFLm:localhost	$15471426487fdcng:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714436224LoFLm:localhost	$15471426498QYDnP:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714438325bxgqT:localhost	$15471426499olYQy:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714438325bxgqT:localhost	$15471426487fdcng:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714438325bxgqT:localhost	$154714436223plixL:localhost	!CrvkKxgetahhVIwnyX:localhost
\.


--
-- Data for Name: event_backward_extremities; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_backward_extremities (event_id, room_id) FROM stdin;
\.


--
-- Data for Name: event_content_hashes; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_content_hashes (event_id, algorithm, hash) FROM stdin;
\.


--
-- Data for Name: event_destinations; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_destinations (event_id, destination, delivered_ts) FROM stdin;
\.


--
-- Data for Name: event_edge_hashes; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_edge_hashes (event_id, prev_event_id, algorithm, hash) FROM stdin;
\.


--
-- Data for Name: event_edges; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_edges (event_id, prev_event_id, room_id, is_state) FROM stdin;
$15471426301dPFwo:localhost	$15471426300pPrwQ:localhost	!mpvAGWWPEpWsNydYnN:localhost	f
$15471426302pIqiF:localhost	$15471426301dPFwo:localhost	!mpvAGWWPEpWsNydYnN:localhost	f
$15471426303YCSmZ:localhost	$15471426302pIqiF:localhost	!mpvAGWWPEpWsNydYnN:localhost	f
$15471426304BRdxH:localhost	$15471426303YCSmZ:localhost	!mpvAGWWPEpWsNydYnN:localhost	f
$15471426305IErDp:localhost	$15471426304BRdxH:localhost	!mpvAGWWPEpWsNydYnN:localhost	f
$15471426498QYDnP:localhost	$15471426487fdcng:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$15471426499olYQy:localhost	$15471426498QYDnP:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714264910qNuKi:localhost	$15471426499olYQy:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714264911TWsje:localhost	$154714264910qNuKi:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714264912SGfjg:localhost	$154714264911TWsje:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714264913PCUQS:localhost	$154714264912SGfjg:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714266714gvEsJ:localhost	$154714264913PCUQS:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714412415WRVyj:localhost	$154714266714gvEsJ:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714428317sWMac:localhost	$154714428316KLrwW:localhost	!RgDCNwMiMxKykVVClV:localhost	f
$154714428318OamJt:localhost	$154714428317sWMac:localhost	!RgDCNwMiMxKykVVClV:localhost	f
$154714428319jqvHZ:localhost	$154714428318OamJt:localhost	!RgDCNwMiMxKykVVClV:localhost	f
$154714428320dqSvn:localhost	$154714428319jqvHZ:localhost	!RgDCNwMiMxKykVVClV:localhost	f
$154714428321iaMIA:localhost	$154714428320dqSvn:localhost	!RgDCNwMiMxKykVVClV:localhost	f
$154714436223plixL:localhost	$154714412415WRVyj:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714436224LoFLm:localhost	$154714412415WRVyj:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714438325bxgqT:localhost	$154714436223plixL:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714438325bxgqT:localhost	$154714436224LoFLm:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714438526deOTX:localhost	$154714438325bxgqT:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714438727XNbHq:localhost	$154714438526deOTX:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714438828svObh:localhost	$154714438727XNbHq:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714438929Suhxq:localhost	$154714438828svObh:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714439530kLEKZ:localhost	$154714438929Suhxq:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714443231YXmpK:localhost	$154714439530kLEKZ:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714446132Evhrh:localhost	$154714443231YXmpK:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714447433aWttn:localhost	$154714446132Evhrh:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714447534UQifj:localhost	$154714447433aWttn:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714447735ZCGXj:localhost	$154714447534UQifj:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714447936SjGma:localhost	$154714447735ZCGXj:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714450937xxzjh:localhost	$154714447936SjGma:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714485938YzCYs:localhost	$154714450937xxzjh:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714489839jNhPb:localhost	$154714485938YzCYs:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714489940llVyn:localhost	$154714489839jNhPb:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714493741nQcWl:localhost	$154714489940llVyn:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714494442vLOzu:localhost	$154714493741nQcWl:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714497443utMjv:localhost	$154714494442vLOzu:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714497944XQHPs:localhost	$154714497443utMjv:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714498345nGKFH:localhost	$154714497944XQHPs:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714504446aiIqN:localhost	$154714498345nGKFH:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714504947xvIss:localhost	$154714504446aiIqN:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714505048dWZpP:localhost	$154714504947xvIss:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714505249jNMbA:localhost	$154714505048dWZpP:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714506450XWsqc:localhost	$154714505249jNMbA:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714508851gyeED:localhost	$154714506450XWsqc:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714513052twTnQ:localhost	$154714508851gyeED:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714513153wozrV:localhost	$154714513052twTnQ:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714514854gxKZt:localhost	$154714513153wozrV:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714516355TZkpl:localhost	$154714514854gxKZt:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714523956frAuI:localhost	$154714516355TZkpl:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714524157LQlkn:localhost	$154714523956frAuI:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714526858lzwnp:localhost	$154714524157LQlkn:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154714527259ArrwP:localhost	$154714526858lzwnp:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154718807060Osxiw:localhost	$154714527259ArrwP:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154718811161PDsGA:localhost	$154718807060Osxiw:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719130162RgkdQ:localhost	$154718811161PDsGA:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719143563hheAg:localhost	$154719130162RgkdQ:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719144064kEzNq:localhost	$154719143563hheAg:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719151365zvWZO:localhost	$154719144064kEzNq:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719152466oQvOE:localhost	$154719151365zvWZO:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719164767efuXJ:localhost	$154719152466oQvOE:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719165168NYIll:localhost	$154719164767efuXJ:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719247969KPEUm:localhost	$154719165168NYIll:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719339270SMjRz:localhost	$154719247969KPEUm:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719344372iKEnw:localhost	$154719339771HhoBo:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719527986LWiBd:localhost	$154719524685MEsPE:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719540493KHAxf:localhost	$154719540392cuLjJ:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719547395BoSSt:localhost	$154719547294JJsmq:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547201566108vIMzG:localhost	$1547201474107QSZzp:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719339771HhoBo:localhost	$154719339270SMjRz:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719378074ykqqG:localhost	$154719347073jkPIF:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719540392cuLjJ:localhost	$154719540291vvcgV:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719547294JJsmq:localhost	$154719540493KHAxf:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719550396cyAjC:localhost	$154719547395BoSSt:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154720071099yrpdB:localhost	$154720043498SQgyh:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719347073jkPIF:localhost	$154719344372iKEnw:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719500977pGQXX:localhost	$154719496876HQbNA:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719537689wbEAt:localhost	$154719537488sBeaz:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547201301103APSbA:localhost	$1547201299102nrFQP:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547209015110ILKew:localhost	$1547203164109HWxxp:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719491875LeoON:localhost	$154719378074ykqqG:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719540290lClpJ:localhost	$154719537689wbEAt:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154720039497BQXbf:localhost	$154719550396cyAjC:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547203164109HWxxp:localhost	$1547201566108vIMzG:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719496876HQbNA:localhost	$154719491875LeoON:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719524685MEsPE:localhost	$154719521084EQDIT:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547209017111VCOtq:localhost	$1547209015110ILKew:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719502078SFZFP:localhost	$154719500977pGQXX:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719505679wchms:localhost	$154719502078SFZFP:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719514682XMEKF:localhost	$154719514481IOBiR:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719519283zKOPF:localhost	$154719514682XMEKF:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719531387IgQOF:localhost	$154719527986LWiBd:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547201298101MsJGQ:localhost	$1547201274100AXvny:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547201299102nrFQP:localhost	$1547201298101MsJGQ:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547201345105jVolj:localhost	$1547201310104XQQzj:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547209037112vjLNr:localhost	$1547209017111VCOtq:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719508580jYTcz:localhost	$154719505679wchms:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154720043498SQgyh:localhost	$154720039497BQXbf:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547201474107QSZzp:localhost	$1547201455106obHen:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719514481IOBiR:localhost	$154719508580jYTcz:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719537488sBeaz:localhost	$154719531387IgQOF:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719521084EQDIT:localhost	$154719519283zKOPF:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154719540291vvcgV:localhost	$154719540290lClpJ:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547201274100AXvny:localhost	$154720071099yrpdB:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547201310104XQQzj:localhost	$1547201301103APSbA:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547201455106obHen:localhost	$1547201345105jVolj:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547209043113TVkrB:localhost	$1547209037112vjLNr:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547209096114BlJbe:localhost	$1547209043113TVkrB:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547209171115HwvmV:localhost	$1547209096114BlJbe:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547209244116RahcN:localhost	$1547209171115HwvmV:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547211554117Elhng:localhost	$1547209244116RahcN:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220025118yFXAz:localhost	$1547211554117Elhng:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220096119DwtHP:localhost	$1547220025118yFXAz:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220105120XlrPA:localhost	$1547220096119DwtHP:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220182121VEzRa:localhost	$1547220105120XlrPA:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220191122fXIkm:localhost	$1547220182121VEzRa:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220193123fBQYD:localhost	$1547220191122fXIkm:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220194124AQdWA:localhost	$1547220193123fBQYD:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220196125pygpM:localhost	$1547220194124AQdWA:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220197126rpVNs:localhost	$1547220196125pygpM:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220198127qDjZB:localhost	$1547220197126rpVNs:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220199128EKqcd:localhost	$1547220198127qDjZB:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220200129xNEFN:localhost	$1547220199128EKqcd:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220219130eqWPP:localhost	$1547220200129xNEFN:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220236131oUTpn:localhost	$1547220219130eqWPP:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220258132jXsNq:localhost	$1547220236131oUTpn:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220271133nWAgW:localhost	$1547220258132jXsNq:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220330134ibkVz:localhost	$1547220271133nWAgW:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220332135nCFHQ:localhost	$1547220330134ibkVz:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220334136ylgXz:localhost	$1547220332135nCFHQ:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220336137dJMop:localhost	$1547220334136ylgXz:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220337138tFafe:localhost	$1547220336137dJMop:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220342139OPXTO:localhost	$1547220337138tFafe:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220358140eyxTo:localhost	$1547220342139OPXTO:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547220502141QlNvD:localhost	$1547220358140eyxTo:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547279183142YOhis:localhost	$1547220502141QlNvD:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547279184143GVbKe:localhost	$1547279183142YOhis:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547279185144ElypB:localhost	$1547279184143GVbKe:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547279186145UMjYo:localhost	$1547279185144ElypB:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547279187146HVLNT:localhost	$1547279186145UMjYo:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547279189147gYZsO:localhost	$1547279187146HVLNT:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547279190148LahLH:localhost	$1547279189147gYZsO:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547279319149EgmWE:localhost	$1547279190148LahLH:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547279319150fMLrf:localhost	$1547279319149EgmWE:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547279319151MaOud:localhost	$1547279319150fMLrf:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547279320152DJzGw:localhost	$1547279319151MaOud:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547279320153eLKOp:localhost	$1547279320152DJzGw:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547279321154qYYIA:localhost	$1547279320153eLKOp:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547279331155MIaaY:localhost	$1547279321154qYYIA:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547279331156JREIt:localhost	$1547279331155MIaaY:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547279332157nmQRp:localhost	$1547279331156JREIt:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547279333158JjmRS:localhost	$1547279332157nmQRp:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547279334159OmRvd:localhost	$1547279333158JjmRS:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547279335160XSwVw:localhost	$1547279334159OmRvd:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547280627161jyqzw:localhost	$1547279335160XSwVw:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547280712162vCSiP:localhost	$1547280627161jyqzw:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547280714163OzTSL:localhost	$1547280712162vCSiP:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547280717164BqYSL:localhost	$1547280714163OzTSL:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547280734165AejNq:localhost	$1547280717164BqYSL:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547280737166XHlsG:localhost	$1547280734165AejNq:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547280753167iiLNC:localhost	$1547280737166XHlsG:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547280755168RTqof:localhost	$1547280753167iiLNC:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547280758169QBLYK:localhost	$1547280755168RTqof:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547280759170XdQji:localhost	$1547280758169QBLYK:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547280764171pBzRc:localhost	$1547280759170XdQji:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547280816172DhRcw:localhost	$1547280764171pBzRc:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547280820173UXJMb:localhost	$1547280816172DhRcw:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547280825174yozNU:localhost	$1547280820173UXJMb:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547280856175DGEZm:localhost	$1547280825174yozNU:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547281038176RAJob:localhost	$1547280856175DGEZm:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547281042177bmAPI:localhost	$1547281038176RAJob:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547281644178FBthK:localhost	$1547281042177bmAPI:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547281718179tyKcU:localhost	$1547281644178FBthK:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547281876180XjrWa:localhost	$1547281718179tyKcU:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282273181ZFMBT:localhost	$1547281876180XjrWa:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282306182UochL:localhost	$1547282273181ZFMBT:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282369183tZBnm:localhost	$1547282306182UochL:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282552184vQlUg:localhost	$1547282369183tZBnm:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282554185Mrxeo:localhost	$1547282552184vQlUg:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282555186bBEHl:localhost	$1547282554185Mrxeo:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282556187hjEiN:localhost	$1547282555186bBEHl:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282564188gOZON:localhost	$1547282556187hjEiN:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282567189pGIuv:localhost	$1547282564188gOZON:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282608190GmCUl:localhost	$1547282567189pGIuv:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282610191tyhdp:localhost	$1547282608190GmCUl:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282611192tMYPw:localhost	$1547282610191tyhdp:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282613193PvaJn:localhost	$1547282611192tMYPw:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282614194gxwNC:localhost	$1547282613193PvaJn:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282625195gAcfj:localhost	$1547282614194gxwNC:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282626196TcRsD:localhost	$1547282625195gAcfj:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282627197zwhxS:localhost	$1547282626196TcRsD:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282629198eGjsr:localhost	$1547282627197zwhxS:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282637199tWnNa:localhost	$1547282629198eGjsr:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282637200HCoQh:localhost	$1547282637199tWnNa:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282637201dRtCQ:localhost	$1547282637200HCoQh:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282637202lPgPc:localhost	$1547282637201dRtCQ:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282638203erEwp:localhost	$1547282637202lPgPc:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282638204RNlYZ:localhost	$1547282638203erEwp:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282638206MMkPI:localhost	$1547282638204RNlYZ:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282643208BfeRU:localhost	$1547282638206MMkPI:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282648210wUJTL:localhost	$1547282643208BfeRU:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282653212xnlDS:localhost	$1547282648210wUJTL:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282658214BrfCn:localhost	$1547282653212xnlDS:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282663217xmKxc:localhost	$1547282658214BrfCn:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282668219nlCAE:localhost	$1547282663217xmKxc:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282673221rajqD:localhost	$1547282668219nlCAE:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$1547282678223Kcqpm:localhost	$1547282673221rajqD:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$15472864650EOLwc:localhost	$1547282678223Kcqpm:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$15472864681LRSdm:localhost	$15472864650EOLwc:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$15472864692BQMAT:localhost	$15472864681LRSdm:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$15472864703LZpNb:localhost	$15472864692BQMAT:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$15472864724KanSK:localhost	$15472864703LZpNb:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$15472864735bRxfM:localhost	$15472864724KanSK:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$15472864756QXetv:localhost	$15472864735bRxfM:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$15472865227IBpem:localhost	$15472864756QXetv:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$15472865308jlsUe:localhost	$15472865227IBpem:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$15472865379qjJPV:localhost	$15472865308jlsUe:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154728654910jVIgS:localhost	$15472865379qjJPV:localhost	!CrvkKxgetahhVIwnyX:localhost	f
$154728655711QTgup:localhost	$154728654910jVIgS:localhost	!CrvkKxgetahhVIwnyX:localhost	f
\.


--
-- Data for Name: event_forward_extremities; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_forward_extremities (event_id, room_id) FROM stdin;
$15471426305IErDp:localhost	!mpvAGWWPEpWsNydYnN:localhost
$154728655711QTgup:localhost	!CrvkKxgetahhVIwnyX:localhost
$154714428321iaMIA:localhost	!RgDCNwMiMxKykVVClV:localhost
\.


--
-- Data for Name: event_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_json (event_id, room_id, internal_metadata, json) FROM stdin;
$15471426300pPrwQ:localhost	!mpvAGWWPEpWsNydYnN:localhost	{"token_id": 3, "stream_ordering": 2}	{"type": "m.room.create", "content": {"room_version": "1", "creator": "@alexes:localhost"}, "room_id": "!mpvAGWWPEpWsNydYnN:localhost", "sender": "@alexes:localhost", "state_key": "", "event_id": "$15471426300pPrwQ:localhost", "origin": "localhost", "origin_server_ts": 1547142630337, "prev_events": [], "depth": 1, "prev_state": [], "auth_events": [], "hashes": {"sha256": "ValCFVaZAQpB2Og6CToODt/bK+83Y5Mlts2/aOYbyeY"}, "signatures": {"localhost": {"ed25519:a_DTGV": "+y7wKT9pW2Wk9MiQ8GBQ2Il1y44vojdw+EGCakyHoqIjBTpK/B9qrZ5TRNolgn/DwlhJl5eWIsGKwFSLCY9BCw"}}, "unsigned": {"age_ts": 1547142630337}}
$15471426301dPFwo:localhost	!mpvAGWWPEpWsNydYnN:localhost	{"token_id": 3, "stream_ordering": 3}	{"type": "m.room.member", "content": {"membership": "join", "displayname": "alexes", "avatar_url": null}, "room_id": "!mpvAGWWPEpWsNydYnN:localhost", "sender": "@alexes:localhost", "state_key": "@alexes:localhost", "membership": "join", "event_id": "$15471426301dPFwo:localhost", "origin": "localhost", "origin_server_ts": 1547142630382, "prev_events": [["$15471426300pPrwQ:localhost", {"sha256": "iJTPdmyNBRgXlIXbsBthrUV15XVGkmY1v9pJbrQXzTc"}]], "depth": 2, "prev_state": [], "auth_events": [["$15471426300pPrwQ:localhost", {"sha256": "iJTPdmyNBRgXlIXbsBthrUV15XVGkmY1v9pJbrQXzTc"}]], "hashes": {"sha256": "45RYyn3K9sYLZDA+X0YdJtD49LhH+t1vPzI2eMHA9tQ"}, "signatures": {"localhost": {"ed25519:a_DTGV": "ewWjf3ERRO1wGIZjHyhrFGDU+o2eg11FUY+6rBhbaYXhQLi4iGZ0KQG1WLwjUgaDEaFJ0WnRR5hi4UI0tPefAg"}}, "unsigned": {"age_ts": 1547142630382}}
$15471426302pIqiF:localhost	!mpvAGWWPEpWsNydYnN:localhost	{"token_id": 3, "stream_ordering": 4}	{"type": "m.room.power_levels", "content": {"users": {"@alexes:localhost": 100, "@riot-bot:matrix.org": 100}, "users_default": 0, "events": {"m.room.name": 50, "m.room.power_levels": 100, "m.room.history_visibility": 100, "m.room.canonical_alias": 50, "m.room.avatar": 50}, "events_default": 0, "state_default": 50, "ban": 50, "kick": 50, "redact": 50, "invite": 0}, "room_id": "!mpvAGWWPEpWsNydYnN:localhost", "sender": "@alexes:localhost", "state_key": "", "event_id": "$15471426302pIqiF:localhost", "origin": "localhost", "origin_server_ts": 1547142630459, "prev_events": [["$15471426301dPFwo:localhost", {"sha256": "IRygIW6/4MbQU3nBnkiUN/hhmgQ537J5o//oyCJZgns"}]], "depth": 3, "prev_state": [], "auth_events": [["$15471426300pPrwQ:localhost", {"sha256": "iJTPdmyNBRgXlIXbsBthrUV15XVGkmY1v9pJbrQXzTc"}], ["$15471426301dPFwo:localhost", {"sha256": "IRygIW6/4MbQU3nBnkiUN/hhmgQ537J5o//oyCJZgns"}]], "hashes": {"sha256": "SYf+xUQ9BVDhNzD67EJn1fbeUBqee6cuc0oVB38l3l0"}, "signatures": {"localhost": {"ed25519:a_DTGV": "0UNZNBPAZ51Lxj/vCDnlr06wcoUujUnLLgwJ9+aNQpxud7h/e2pEEIiBsjebKQrScTe0kuHQwj+CpHJyzuPbBA"}}, "unsigned": {"age_ts": 1547142630459}}
$15471426303YCSmZ:localhost	!mpvAGWWPEpWsNydYnN:localhost	{"token_id": 3, "stream_ordering": 5}	{"type": "m.room.join_rules", "content": {"join_rule": "invite"}, "room_id": "!mpvAGWWPEpWsNydYnN:localhost", "sender": "@alexes:localhost", "state_key": "", "event_id": "$15471426303YCSmZ:localhost", "origin": "localhost", "origin_server_ts": 1547142630519, "prev_events": [["$15471426302pIqiF:localhost", {"sha256": "cCuHSopA88zZtxApYk6EpcB8ltUzsbuanNjVJ4zWbPE"}]], "depth": 4, "prev_state": [], "auth_events": [["$15471426300pPrwQ:localhost", {"sha256": "iJTPdmyNBRgXlIXbsBthrUV15XVGkmY1v9pJbrQXzTc"}], ["$15471426301dPFwo:localhost", {"sha256": "IRygIW6/4MbQU3nBnkiUN/hhmgQ537J5o//oyCJZgns"}], ["$15471426302pIqiF:localhost", {"sha256": "cCuHSopA88zZtxApYk6EpcB8ltUzsbuanNjVJ4zWbPE"}]], "hashes": {"sha256": "GM8rv2rGoWmdYKL5lQbLKq8bRHMp/N3nfoOU/sp9DAs"}, "signatures": {"localhost": {"ed25519:a_DTGV": "kRHKo96vSis6CpQV0OHz2W/qkUAtR2ApvYsR8j7isbhsDyMsFUMCBVqpEtlmhrlqFno4QD91BEuXiP98p+FJDg"}}, "unsigned": {"age_ts": 1547142630519}}
$15471426304BRdxH:localhost	!mpvAGWWPEpWsNydYnN:localhost	{"token_id": 3, "stream_ordering": 6}	{"type": "m.room.history_visibility", "content": {"history_visibility": "shared"}, "room_id": "!mpvAGWWPEpWsNydYnN:localhost", "sender": "@alexes:localhost", "state_key": "", "event_id": "$15471426304BRdxH:localhost", "origin": "localhost", "origin_server_ts": 1547142630566, "prev_events": [["$15471426303YCSmZ:localhost", {"sha256": "QEvPTwLsafmL1VVJVSdIkYo0lrshiwH/XkZu0/VnqN4"}]], "depth": 5, "prev_state": [], "auth_events": [["$15471426302pIqiF:localhost", {"sha256": "cCuHSopA88zZtxApYk6EpcB8ltUzsbuanNjVJ4zWbPE"}], ["$15471426300pPrwQ:localhost", {"sha256": "iJTPdmyNBRgXlIXbsBthrUV15XVGkmY1v9pJbrQXzTc"}], ["$15471426301dPFwo:localhost", {"sha256": "IRygIW6/4MbQU3nBnkiUN/hhmgQ537J5o//oyCJZgns"}]], "hashes": {"sha256": "vBZBJy8DBItmm8tt1s7GSYAssrP+6TcmbEdJXcOWnxA"}, "signatures": {"localhost": {"ed25519:a_DTGV": "p8L729/dIcGUjv41LJ1q8l4LDBaCUF3m6qRk5J3n3OwAjoeeorJwPH4eEKsUyHw2S/IvrqUMDVUG+AGcT9QcBg"}}, "unsigned": {"age_ts": 1547142630566}}
$15471426305IErDp:localhost	!mpvAGWWPEpWsNydYnN:localhost	{"token_id": 3, "stream_ordering": 7}	{"type": "m.room.guest_access", "content": {"guest_access": "can_join"}, "room_id": "!mpvAGWWPEpWsNydYnN:localhost", "sender": "@alexes:localhost", "state_key": "", "event_id": "$15471426305IErDp:localhost", "origin": "localhost", "origin_server_ts": 1547142630616, "prev_events": [["$15471426304BRdxH:localhost", {"sha256": "A/OnIwdCYYUiUa5zBph8bQhThRzhkA3RU+7pz+VOLLA"}]], "depth": 6, "prev_state": [], "auth_events": [["$15471426302pIqiF:localhost", {"sha256": "cCuHSopA88zZtxApYk6EpcB8ltUzsbuanNjVJ4zWbPE"}], ["$15471426300pPrwQ:localhost", {"sha256": "iJTPdmyNBRgXlIXbsBthrUV15XVGkmY1v9pJbrQXzTc"}], ["$15471426301dPFwo:localhost", {"sha256": "IRygIW6/4MbQU3nBnkiUN/hhmgQ537J5o//oyCJZgns"}]], "hashes": {"sha256": "YNLbwMX4LpLco1nzNykSJawQBLmL6CLcOpmXwfPMQAA"}, "signatures": {"localhost": {"ed25519:a_DTGV": "qsVgL60CuDr/3j+Au6+PagsvqjWL3HV2JlKd7Os3Mr53ElcSdlkFuPHGhoZSOdyTEaddrBOXi6jDhyKr94waDg"}}, "unsigned": {"age_ts": 1547142630616}}
$15471426487fdcng:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 3, "stream_ordering": 8}	{"type": "m.room.create", "content": {"room_version": "1", "creator": "@alexes:localhost"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "state_key": "", "event_id": "$15471426487fdcng:localhost", "origin": "localhost", "origin_server_ts": 1547142648991, "prev_events": [], "depth": 1, "prev_state": [], "auth_events": [], "hashes": {"sha256": "U3+9ljmAjTo19ngKfDJfFWl+h4Pgi2WBG0vxS8zzeM0"}, "signatures": {"localhost": {"ed25519:a_DTGV": "vVdcykeHlC6yZsjKFWZCwfuFXoK1abyL1ZXTAhQOUqtQzLHBUg9k4WnG/FVBgd/sZzLVWwjIYslZBjpggxksAA"}}, "unsigned": {"age_ts": 1547142648991}}
$15471426498QYDnP:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 3, "stream_ordering": 9}	{"type": "m.room.member", "content": {"membership": "join", "displayname": "alexes", "avatar_url": null}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "state_key": "@alexes:localhost", "membership": "join", "event_id": "$15471426498QYDnP:localhost", "origin": "localhost", "origin_server_ts": 1547142649024, "prev_events": [["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}]], "depth": 2, "prev_state": [], "auth_events": [["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}]], "hashes": {"sha256": "Bmg2sYwB5XoMxdckTD0j7t80JJ3b83xUB9v3OLdpJOk"}, "signatures": {"localhost": {"ed25519:a_DTGV": "e3NiebLJqCeIdmtVLUUnje9ga6BZxAGwQ1Qsc6irDa1rS6ouvbqE5hLrj16I0bC5SXapUg9viRLbKmWISvhECg"}}, "unsigned": {"age_ts": 1547142649024}}
$15471426499olYQy:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 3, "stream_ordering": 10}	{"type": "m.room.power_levels", "content": {"users": {"@alexes:localhost": 100}, "users_default": 0, "events": {"m.room.name": 50, "m.room.power_levels": 100, "m.room.history_visibility": 100, "m.room.canonical_alias": 50, "m.room.avatar": 50}, "events_default": 0, "state_default": 50, "ban": 50, "kick": 50, "redact": 50, "invite": 0}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "state_key": "", "event_id": "$15471426499olYQy:localhost", "origin": "localhost", "origin_server_ts": 1547142649060, "prev_events": [["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "depth": 3, "prev_state": [], "auth_events": [["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "TMoZN8tQhfjLD75DLZrkJaiaA/z7pxBhT/xTW+yfHwo"}, "signatures": {"localhost": {"ed25519:a_DTGV": "0OETMHqmb1NFPkDeLs1v9/h93yIdebG1OVNqH8cDmiPssTHPe9GiCrKbawVNCgiPPFzjm/c2+puNhdATz8I1AA"}}, "unsigned": {"age_ts": 1547142649060}}
$154714264910qNuKi:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 3, "stream_ordering": 11}	{"type": "m.room.join_rules", "content": {"join_rule": "invite"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "state_key": "", "event_id": "$154714264910qNuKi:localhost", "origin": "localhost", "origin_server_ts": 1547142649104, "prev_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}]], "depth": 4, "prev_state": [], "auth_events": [["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}], ["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}]], "hashes": {"sha256": "Mkal4dmGrZx7fd88iiZTmXV6OCkpi6NHKaclo9Mcvbk"}, "signatures": {"localhost": {"ed25519:a_DTGV": "WO6A9Nq1atyVTc8riDg1dzdZbJX0tjN5mRgNqO8DuHDSe7cfyDwggjzgtaeinzKl+JvaGX06P79XaRZ8GC/9BA"}}, "unsigned": {"age_ts": 1547142649104}}
$154714447433aWttn:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 5, "txn_id": "m1547144474302.0", "stream_ordering": 33}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$154714447433aWttn:localhost", "origin": "localhost", "origin_server_ts": 1547144474335, "prev_events": [["$154714446132Evhrh:localhost", {"sha256": "9u3jJ3A6IUKL7yjsAJIPUDnf/ulIdLsa0+bYgGj/Z4Q"}]], "depth": 19, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "ZbXab0JfPRzm1290LqmH8zY3+liqY2BPDPYJUXi83as"}, "signatures": {"localhost": {"ed25519:a_DTGV": "pKOJDAlU0pMUzosXNZnqHPlJY6jqSCMYlDFEaKfwgAI+kq7ltmfztP5E6yOS6TKHddSETwRe8Dvnh3TwDNzxAw"}}, "unsigned": {"age_ts": 1547144474335}}
$154714447735ZCGXj:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547144477547.7", "stream_ordering": 35}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuaoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714447735ZCGXj:localhost", "origin": "localhost", "origin_server_ts": 1547144477612, "prev_events": [["$154714447534UQifj:localhost", {"sha256": "xQgbikRWbdOUUHIxtDPtrgg42VUZ8frdd5wJRqkkKfI"}]], "depth": 21, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "QMZISxDpfGMRV92fjPQaEFR5o7hDu1snkcmNVPywZgw"}, "signatures": {"localhost": {"ed25519:a_DTGV": "56ihn2JWIk1yxwIjM7h3ZAiUUeP0gBooDsk34X8BkVtTkXtIjmhr2CuzY59nD4qaEvvOcpawIZ+biqZybCQtAg"}}, "unsigned": {"age_ts": 1547144477612}}
$154714489839jNhPb:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 5, "txn_id": "m1547144898118.0", "stream_ordering": 39}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$154714489839jNhPb:localhost", "origin": "localhost", "origin_server_ts": 1547144898155, "prev_events": [["$154714485938YzCYs:localhost", {"sha256": "FHpugwixb4o1QsgZgNA85a3kRn58qj+p8nZre27vZO4"}]], "depth": 25, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "jEagAFpJyKR8hwWTVQ89Ix1w8+sksfCG0QATh/7alCQ"}, "signatures": {"localhost": {"ed25519:a_DTGV": "+eMzMM3wKedCpNNrfqdPsZ8caB+b4J3tuu4r1oO2HtLo0/gQtexzeAVJLhAtuv+sVnA3arQ5FuF+05qUmXDyDQ"}}, "unsigned": {"age_ts": 1547144898155}}
$154714498345nGKFH:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547144983284.2", "stream_ordering": 45}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714498345nGKFH:localhost", "origin": "localhost", "origin_server_ts": 1547144983358, "prev_events": [["$154714497944XQHPs:localhost", {"sha256": "FkdRPgYhAgEwR+/acwogMi4LPNhVdcyRxyNw84EDOrI"}]], "depth": 31, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "nAhrww/O+BcMCbwUeF+SivYMDGJMGtmGDpLQLWPf99Q"}, "signatures": {"localhost": {"ed25519:a_DTGV": "k1/EPNEOIvwMVNvInPlIV6ToXpKP1w4T9rDXIpbmOSVau+tOUDxvKG3GiIR2YldaE4WMH+YsRYUfkDFPreeCCg"}}, "unsigned": {"age_ts": 1547144983358}}
$154714264911TWsje:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 3, "stream_ordering": 12}	{"type": "m.room.history_visibility", "content": {"history_visibility": "shared"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "state_key": "", "event_id": "$154714264911TWsje:localhost", "origin": "localhost", "origin_server_ts": 1547142649149, "prev_events": [["$154714264910qNuKi:localhost", {"sha256": "q2rk8uc+rVyNsUWnlyxezEajV5Q556dhfIM5FLANqOg"}]], "depth": 5, "prev_state": [], "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "+fv5UCXJY7d6tWe/u2b8TW61udMiXrUUavKoJjHgiUU"}, "signatures": {"localhost": {"ed25519:a_DTGV": "ESyI78hHTFkt/UXgavpKMuMo5uZW0Nh/6nCstbfxk88CBvEx9UbDBRa6mTi3jctpKbw0Q4Rl/kThio14VF5yCg"}}, "unsigned": {"age_ts": 1547142649149}}
$154714264913PCUQS:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 3, "stream_ordering": 14}	{"type": "m.room.name", "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "state_key": "", "content": {"name": "firstpublic"}, "event_id": "$154714264913PCUQS:localhost", "origin": "localhost", "origin_server_ts": 1547142649227, "prev_events": [["$154714264912SGfjg:localhost", {"sha256": "0HtnxHaAtCtFZyUyEhfAYR1te6ENBio/AZdZkeXklyk"}]], "depth": 7, "prev_state": [], "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "SEFhYG4zeNSovgv76dTRRQa8BsP4i27r2LNLCKTUQU0"}, "signatures": {"localhost": {"ed25519:a_DTGV": "BGEmgOgmwwsF5uS2vs2xUFk53pkWIE2jhGDOrWBr94bkasVdJjSDXeaFEsy7DvcUCtBIopKI6qp8sL7ZC8sfCA"}}, "unsigned": {"age_ts": 1547142649227}}
$154714485938YzCYs:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547144859208.9", "stream_ordering": 38}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aeo"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714485938YzCYs:localhost", "origin": "localhost", "origin_server_ts": 1547144859276, "prev_events": [["$154714450937xxzjh:localhost", {"sha256": "z7WzbpRiUn7q6OirlLJP0qsfiZMxeg7pAoTIFqA72zw"}]], "depth": 24, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "5WIeaeMm/DmLaycC/d1BwxSwIscN39JqURa2O1vinCA"}, "signatures": {"localhost": {"ed25519:a_DTGV": "E4U7py3+l+3lNZSXDoMP7xKK1rFguTwYTniTCgSDby7d0Bhsq/1SrbaGvb5bg9ZZtYLTFKfP0ToppGYuISAxBA"}}, "unsigned": {"age_ts": 1547144859276}}
$154714494442vLOzu:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547144944082.1", "stream_ordering": 42}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuaoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714494442vLOzu:localhost", "origin": "localhost", "origin_server_ts": 1547144944160, "prev_events": [["$154714493741nQcWl:localhost", {"sha256": "MqLSVB+ENxLdtKNvIZyfv3Y0ALnxW+wUyS/SFC5OESQ"}]], "depth": 28, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "zY3PIM4sfGRNoUdTMJwyWO33HnVJouyO4AURutpE5P8"}, "signatures": {"localhost": {"ed25519:a_DTGV": "+XBJl4cjk4IAEIrH8NLNbyfvpJJKivftl4K2fHcWacs1/4Oe+K/H9DW00RFnc8T4ntGXRQJ/fcuTzFIzhvtuCA"}}, "unsigned": {"age_ts": 1547144944160}}
$154714504947xvIss:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547145049319.4", "stream_ordering": 47}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714504947xvIss:localhost", "origin": "localhost", "origin_server_ts": 1547145049386, "prev_events": [["$154714504446aiIqN:localhost", {"sha256": "Qa5FMhvfLadka8sSd7Z2oHH6pGDI9/yyusk4PYKsksQ"}]], "depth": 33, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "+rn+NW2Q0TVloatD4C4XJhJgbxmFTiwkXaa01VW7azk"}, "signatures": {"localhost": {"ed25519:a_DTGV": "lhfJOgyvYuqK37cSSe7jqmp/XuvV8DoOFdshqhTTzLBmmY8+UDaBXB7C8wypUAb56oKWixb31j2rBAcUrdqTCw"}}, "unsigned": {"age_ts": 1547145049386}}
$154714264912SGfjg:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 3, "stream_ordering": 13}	{"type": "m.room.guest_access", "content": {"guest_access": "can_join"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "state_key": "", "event_id": "$154714264912SGfjg:localhost", "origin": "localhost", "origin_server_ts": 1547142649188, "prev_events": [["$154714264911TWsje:localhost", {"sha256": "Q6olA4+yRBxxJiNRfwT99WxeWbaAfTPn4RfQ54D1YLM"}]], "depth": 6, "prev_state": [], "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "i4hI3O+LXWzId0Uiwxk/bdabRtV7zAuIFdFjeaV4NxE"}, "signatures": {"localhost": {"ed25519:a_DTGV": "erZ3BW0YMIIRHa6lKe478c+EdzK6FnpkxvgY0ohG0QKkP9lMI4+Yi0e8GDj+d8y1aN7/4f6jFaOero9PxYOqCQ"}}, "unsigned": {"age_ts": 1547142649188}}
$154714266714gvEsJ:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 3, "stream_ordering": 15}	{"type": "m.room.related_groups", "content": {"groups": ["+first:localhost"]}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "state_key": "", "event_id": "$154714266714gvEsJ:localhost", "origin": "localhost", "origin_server_ts": 1547142667742, "prev_events": [["$154714264913PCUQS:localhost", {"sha256": "vLcvq/N2LhM/CmO8yw6PpbALiQRN90F9dFJyd+MLbj4"}]], "depth": 8, "prev_state": [], "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "EJ6sgopFeuYcfH6/E2TB0KwZh9vmSBrmsQaTIs5CDAs"}, "signatures": {"localhost": {"ed25519:a_DTGV": "UIN5QATZpJorN0saunXIQfLT53VtmWo5zKdeZ/dDndAQIbR90qJodBszYudO13Vin3HUKrRe9KvCT1zKnUkVAQ"}}, "unsigned": {"age_ts": 1547142667742}}
$154714412415WRVyj:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 3, "txn_id": "m1547144124109.0", "stream_ordering": 16}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$154714412415WRVyj:localhost", "origin": "localhost", "origin_server_ts": 1547144124451, "prev_events": [["$154714266714gvEsJ:localhost", {"sha256": "kSsOoU3oCRGs0dMqHxwfxqfCf2ndzPQWy9Unj48kERY"}]], "depth": 9, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "DFVG9WUgxipahT5s68emUyI0kwae+2JaThIKpZgTWvw"}, "signatures": {"localhost": {"ed25519:a_DTGV": "MdjnmV8xYnwmfGe5N9EB3MvyYFsd0DzCet+7Xj+qHxcguQqDwV3xkj2KDyVY8kY9XbUArqCMsKECoQY9CLMtCQ"}}, "unsigned": {"age_ts": 1547144124451}}
$154714428318OamJt:localhost	!RgDCNwMiMxKykVVClV:localhost	{"token_id": 7, "stream_ordering": 19}	{"type": "m.room.power_levels", "content": {"users": {"@alexes1:localhost": 100, "@riot-bot:matrix.org": 100}, "users_default": 0, "events": {"m.room.name": 50, "m.room.power_levels": 100, "m.room.history_visibility": 100, "m.room.canonical_alias": 50, "m.room.avatar": 50}, "events_default": 0, "state_default": 50, "ban": 50, "kick": 50, "redact": 50, "invite": 0}, "room_id": "!RgDCNwMiMxKykVVClV:localhost", "sender": "@alexes1:localhost", "state_key": "", "event_id": "$154714428318OamJt:localhost", "origin": "localhost", "origin_server_ts": 1547144283571, "prev_events": [["$154714428317sWMac:localhost", {"sha256": "RnB5Rzj606s2HlTdpDc/Hhi+52mMNfryy9DD7LYwAOg"}]], "depth": 3, "prev_state": [], "auth_events": [["$154714428316KLrwW:localhost", {"sha256": "fT7KxIT8axh9gRw7TQqMBKtIpdz9sanwGuFNbcxHURA"}], ["$154714428317sWMac:localhost", {"sha256": "RnB5Rzj606s2HlTdpDc/Hhi+52mMNfryy9DD7LYwAOg"}]], "hashes": {"sha256": "H/6t7JRuCKXsBq66Sl7R+9Vrbn959vrWhP4NJdD9Two"}, "signatures": {"localhost": {"ed25519:a_DTGV": "jZJJHB5TRn0YkgF3xzV6hRMHlzeEanKhJ/IvRe44asfus+7JKWMVjOaT/w0jGkqsV1iCrv56aUfHyEZNlPAOCA"}}, "unsigned": {"age_ts": 1547144283571}}
$154714428319jqvHZ:localhost	!RgDCNwMiMxKykVVClV:localhost	{"token_id": 7, "stream_ordering": 20}	{"type": "m.room.join_rules", "content": {"join_rule": "invite"}, "room_id": "!RgDCNwMiMxKykVVClV:localhost", "sender": "@alexes1:localhost", "state_key": "", "event_id": "$154714428319jqvHZ:localhost", "origin": "localhost", "origin_server_ts": 1547144283618, "prev_events": [["$154714428318OamJt:localhost", {"sha256": "vXOnAQNsW2l9o5uSv8zFZ3b6j6Adr4TGim8DuZZd7V0"}]], "depth": 4, "prev_state": [], "auth_events": [["$154714428316KLrwW:localhost", {"sha256": "fT7KxIT8axh9gRw7TQqMBKtIpdz9sanwGuFNbcxHURA"}], ["$154714428317sWMac:localhost", {"sha256": "RnB5Rzj606s2HlTdpDc/Hhi+52mMNfryy9DD7LYwAOg"}], ["$154714428318OamJt:localhost", {"sha256": "vXOnAQNsW2l9o5uSv8zFZ3b6j6Adr4TGim8DuZZd7V0"}]], "hashes": {"sha256": "MWn1Lfn3E7TKi6fdPY8qS3FoLjAhSlLTZO+wq64FKSk"}, "signatures": {"localhost": {"ed25519:a_DTGV": "E6eRgA/QJNOVfzaBVKURwiRVVIQpdiA1i7qf07nWCccACsBibrDfiLwuM+kydeLDs1zUQHOWJ2onp1pU1rucDg"}}, "unsigned": {"age_ts": 1547144283618}}
$154714436224LoFLm:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 8, "stream_ordering": 24}	{"type": "org.matrix.room.preview_urls", "content": {"disable": true}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "state_key": "", "event_id": "$154714436224LoFLm:localhost", "origin": "localhost", "origin_server_ts": 1547144362764, "prev_events": [["$154714412415WRVyj:localhost", {"sha256": "qxoPB3mwhvKnAQMGJqNW4JBp4lMmmXQ1BOuz8wrPPQE"}]], "depth": 10, "prev_state": [], "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "mK1LG3H2nJGpd1+C99D1nz78VIhWRwVxiGUDWkX9eFo"}, "signatures": {"localhost": {"ed25519:a_DTGV": "GTQFheXz6JbKgNhD5d7JIVi2W2HP960mzo+01rQ7T6EfAs9vJ06FUU8bqG7eVMDNnnpxKxDeCoKnP4k0Aa6WAA"}}, "unsigned": {"age_ts": 1547144362764}}
$154714438325bxgqT:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "stream_ordering": 25}	{"type": "m.room.member", "content": {"membership": "join", "displayname": "alexes1", "avatar_url": null}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "state_key": "@alexes1:localhost", "membership": "join", "event_id": "$154714438325bxgqT:localhost", "origin": "localhost", "origin_server_ts": 1547144383839, "prev_events": [["$154714436223plixL:localhost", {"sha256": "J+L0ubR0yBedekvSDyfsaI7PFj5CsvBa7ay5B9oNjz8"}], ["$154714436224LoFLm:localhost", {"sha256": "KS8Ngr0tdew73M9bujcXrudokAYeBagaRDUsBzq2soc"}]], "depth": 11, "prev_state": [], "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714436223plixL:localhost", {"sha256": "J+L0ubR0yBedekvSDyfsaI7PFj5CsvBa7ay5B9oNjz8"}]], "hashes": {"sha256": "7OXhCowNylfr20c6MMA0/Kf2oFZ9riTrYazsAZ/De1w"}, "signatures": {"localhost": {"ed25519:a_DTGV": "Qi+aMZXd3fjl3vt2AM2Jb9L97SrUutvz59OH0qGpuzA/KTZoa5VZ8zQQe+blgWeLrwHi7DOZIFTwJsQN70SRBQ"}}, "unsigned": {"age_ts": 1547144383839}}
$154714428316KLrwW:localhost	!RgDCNwMiMxKykVVClV:localhost	{"token_id": 7, "stream_ordering": 17}	{"type": "m.room.create", "content": {"room_version": "1", "creator": "@alexes1:localhost"}, "room_id": "!RgDCNwMiMxKykVVClV:localhost", "sender": "@alexes1:localhost", "state_key": "", "event_id": "$154714428316KLrwW:localhost", "origin": "localhost", "origin_server_ts": 1547144283458, "prev_events": [], "depth": 1, "prev_state": [], "auth_events": [], "hashes": {"sha256": "XkfVHpb4R1ull1gHg3qEhAcHAzl9Giv/RhaPoWvkZvA"}, "signatures": {"localhost": {"ed25519:a_DTGV": "57E6ZHG+k8FvURGpURS2usRMa0ugjm4vI/xlfZEM49mDE5Ii1vhzGRPcdBfp5NoMmXPi6hbCxPU+OP1e+BpJCA"}}, "unsigned": {"age_ts": 1547144283458}}
$154714428317sWMac:localhost	!RgDCNwMiMxKykVVClV:localhost	{"token_id": 7, "stream_ordering": 18}	{"type": "m.room.member", "content": {"membership": "join", "displayname": "alexes1", "avatar_url": null}, "room_id": "!RgDCNwMiMxKykVVClV:localhost", "sender": "@alexes1:localhost", "state_key": "@alexes1:localhost", "membership": "join", "event_id": "$154714428317sWMac:localhost", "origin": "localhost", "origin_server_ts": 1547144283510, "prev_events": [["$154714428316KLrwW:localhost", {"sha256": "fT7KxIT8axh9gRw7TQqMBKtIpdz9sanwGuFNbcxHURA"}]], "depth": 2, "prev_state": [], "auth_events": [["$154714428316KLrwW:localhost", {"sha256": "fT7KxIT8axh9gRw7TQqMBKtIpdz9sanwGuFNbcxHURA"}]], "hashes": {"sha256": "g6PdJlxVzk2LgsA2xz1jFA6BMsCj/Lfla1YOwa95xWo"}, "signatures": {"localhost": {"ed25519:a_DTGV": "yJok6Q7XJQfjKnUcuu2Tpw+0VO5lw9kp+6ir47z3WIG5ialzSID2EWOmQWkOyfl/xoRNInhgCSf3iy0HZf+WDw"}}, "unsigned": {"age_ts": 1547144283510}}
$154714428320dqSvn:localhost	!RgDCNwMiMxKykVVClV:localhost	{"token_id": 7, "stream_ordering": 21}	{"type": "m.room.history_visibility", "content": {"history_visibility": "shared"}, "room_id": "!RgDCNwMiMxKykVVClV:localhost", "sender": "@alexes1:localhost", "state_key": "", "event_id": "$154714428320dqSvn:localhost", "origin": "localhost", "origin_server_ts": 1547144283665, "prev_events": [["$154714428319jqvHZ:localhost", {"sha256": "fVjimv0SR92Hpp5VCeGfZrp7zFfUwvsqi64MIKj1Xhw"}]], "depth": 5, "prev_state": [], "auth_events": [["$154714428318OamJt:localhost", {"sha256": "vXOnAQNsW2l9o5uSv8zFZ3b6j6Adr4TGim8DuZZd7V0"}], ["$154714428316KLrwW:localhost", {"sha256": "fT7KxIT8axh9gRw7TQqMBKtIpdz9sanwGuFNbcxHURA"}], ["$154714428317sWMac:localhost", {"sha256": "RnB5Rzj606s2HlTdpDc/Hhi+52mMNfryy9DD7LYwAOg"}]], "hashes": {"sha256": "Snd3XhQJTHXpKYZSzMpNx4xFGYM4FHjgnjoJzcLNG7A"}, "signatures": {"localhost": {"ed25519:a_DTGV": "9unvGoGl9o8ZZBF0gdXdwPZHqN4sMNgvJHge0mpOrDFLJIBUmd2A5/0C1Dem/mAEIS3ftH5X2IGJjqU0os/4CQ"}}, "unsigned": {"age_ts": 1547144283665}}
$154714428321iaMIA:localhost	!RgDCNwMiMxKykVVClV:localhost	{"token_id": 7, "stream_ordering": 22}	{"type": "m.room.guest_access", "content": {"guest_access": "can_join"}, "room_id": "!RgDCNwMiMxKykVVClV:localhost", "sender": "@alexes1:localhost", "state_key": "", "event_id": "$154714428321iaMIA:localhost", "origin": "localhost", "origin_server_ts": 1547144283720, "prev_events": [["$154714428320dqSvn:localhost", {"sha256": "rsEtYcZiumzR8esH2KYdVmAVxa6gRU/lR1x8K94lbhI"}]], "depth": 6, "prev_state": [], "auth_events": [["$154714428318OamJt:localhost", {"sha256": "vXOnAQNsW2l9o5uSv8zFZ3b6j6Adr4TGim8DuZZd7V0"}], ["$154714428316KLrwW:localhost", {"sha256": "fT7KxIT8axh9gRw7TQqMBKtIpdz9sanwGuFNbcxHURA"}], ["$154714428317sWMac:localhost", {"sha256": "RnB5Rzj606s2HlTdpDc/Hhi+52mMNfryy9DD7LYwAOg"}]], "hashes": {"sha256": "lK8M9uHqYMg/2SdlidaWD5WGBtkE98ovsEHSthQmzJI"}, "signatures": {"localhost": {"ed25519:a_DTGV": "+Tf7PaNmCRWkY7XqTmNdmsQaNCq/W7gWAS3YUrlWWwkhartSApnAUc3CckQmQIwLOwVCGH9I/mqup2EptHNgCw"}}, "unsigned": {"age_ts": 1547144283720}}
$154714438526deOTX:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547144385596.0", "stream_ordering": 26}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuaoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714438526deOTX:localhost", "origin": "localhost", "origin_server_ts": 1547144385657, "prev_events": [["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "depth": 12, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "gP+iOiLDG+ZjGGj1Myj9gKU7Err+XZ6exF6MjRxQ6HI"}, "signatures": {"localhost": {"ed25519:a_DTGV": "RJyy7GNQfwzLtbLLlYQYIwH+pgVDtMkNRdR3hOrj/CLkyoBb6NB0WZ6FwKOKn9guBSUFcVj3TIjixDx6XCpkBA"}}, "unsigned": {"age_ts": 1547144385657}}
$154714438727XNbHq:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547144387095.1", "stream_ordering": 27}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuaoeuaoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714438727XNbHq:localhost", "origin": "localhost", "origin_server_ts": 1547144387154, "prev_events": [["$154714438526deOTX:localhost", {"sha256": "QvTzoNbGH0+MmWZL3fqiQV0DynZbOjd9GdeVUy11pTk"}]], "depth": 13, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "SitJcXicjVC4s0GsEmiC7gzFq4WBc2mc4pP+wvxSZ1M"}, "signatures": {"localhost": {"ed25519:a_DTGV": "QAJbytbI1nH5Py5JuP2kT9ztR3RoPrECJ64tLvHxDwvIqRtJfhu6oDtBHuG59cKIYSsMZw3wLqAKZ54hBfsJBQ"}}, "unsigned": {"age_ts": 1547144387154}}
$154714439530kLEKZ:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547144395553.4", "stream_ordering": 30}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714439530kLEKZ:localhost", "origin": "localhost", "origin_server_ts": 1547144395626, "prev_events": [["$154714438929Suhxq:localhost", {"sha256": "ZoghwI2UdV6YsezgRPwy6zLVG/3TtyzgNADoEfq5mTs"}]], "depth": 16, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "U292sSH2pa3zw+6T9ea+wA7hfAcUHM5CdR/8jHIR9TQ"}, "signatures": {"localhost": {"ed25519:a_DTGV": "XgOTZi4CR6NJhP90pCKkfzfGnVoo6GRGvaJ3yjKopbcErkK6zWJSTZJkDJQ3wFiBJoWhYcNDcSZTcnrt7mdaCQ"}}, "unsigned": {"age_ts": 1547144395626}}
$154714436223plixL:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 8, "stream_ordering": 23}	{"type": "m.room.join_rules", "content": {"join_rule": "public"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "state_key": "", "event_id": "$154714436223plixL:localhost", "origin": "localhost", "origin_server_ts": 1547144362760, "prev_events": [["$154714412415WRVyj:localhost", {"sha256": "qxoPB3mwhvKnAQMGJqNW4JBp4lMmmXQ1BOuz8wrPPQE"}]], "depth": 10, "prev_state": [], "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "BUrx1jczSVNqNv6qVe4bXgSBAawe2OecoLrIEmpktVw"}, "signatures": {"localhost": {"ed25519:a_DTGV": "UlhgwSoTggA1iljcTyf3GDlQufLGaUuNuhu5IhV04p7fWXTQelO43M1gnzSvXhGnlIhGm4/010oksUOXDXAsCg"}}, "unsigned": {"age_ts": 1547144362760, "replaces_state": "$154714264910qNuKi:localhost"}}
$154714438828svObh:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547144388331.2", "stream_ordering": 28}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuaoeuaoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714438828svObh:localhost", "origin": "localhost", "origin_server_ts": 1547144388398, "prev_events": [["$154714438727XNbHq:localhost", {"sha256": "V28eSTxrvcj+oF5fvAPEvb1ZXfhbtiG8RenfbFg5Ql0"}]], "depth": 14, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "S2yi8GZse16A4TqPO/yftBMejn4z3WShMbheP46WiJQ"}, "signatures": {"localhost": {"ed25519:a_DTGV": "4RxQNFPqbWesvhamAedEEZkPbGTWjVJYgCGhp0RWd3+AYglKm5inycKKEkGBM2koPXp5w/XBTT0lYfGeSxg1AA"}}, "unsigned": {"age_ts": 1547144388398}}
$154714447936SjGma:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 5, "txn_id": "m1547144479280.2", "stream_ordering": 36}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuaoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$154714447936SjGma:localhost", "origin": "localhost", "origin_server_ts": 1547144479315, "prev_events": [["$154714447735ZCGXj:localhost", {"sha256": "5Fxe8fScymFB5LsJ5gbtKkjizbDVUMuJq4tEzC4K+yU"}]], "depth": 22, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "ntKW4MF5Lrt3d/mMU7VMleX1wtEGmfHUK+Wh8MIFT/s"}, "signatures": {"localhost": {"ed25519:a_DTGV": "hywRg/Z5BC3HRt0RZKrTXRGleVlsTU1r+oUkIAzXF1ZKeSRBmgprrm4xakxYQEUaLiUVS7bPatf8hW4YeEGEBg"}}, "unsigned": {"age_ts": 1547144479315}}
$154714514854gxKZt:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547145147986.10", "stream_ordering": 54}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aeou"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714514854gxKZt:localhost", "origin": "localhost", "origin_server_ts": 1547145148052, "prev_events": [["$154714513153wozrV:localhost", {"sha256": "v0nnki83GywTZAZoLxO0k4bq6DNbcydHQJbq9XBQv3c"}]], "depth": 40, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "cHKJiWRRkYYKNJ3D471Qy/DTRy4pf0S/HLZd9ttMJ+I"}, "signatures": {"localhost": {"ed25519:a_DTGV": "1k73JADiRQLHmqyTejvg0Eo5ArDFOt9Rm2x1sp54PKJMcFnsYnRmgSGOQNHs2UftIFmJvPyTusvr+SZNRENFBw"}}, "unsigned": {"age_ts": 1547145148052}}
$154714438929Suhxq:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547144389261.3", "stream_ordering": 29}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuaoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714438929Suhxq:localhost", "origin": "localhost", "origin_server_ts": 1547144389356, "prev_events": [["$154714438828svObh:localhost", {"sha256": "cbZLD+tlUZ0PQueuC9v/DmGhW1E0YiZB8dr9E26LklA"}]], "depth": 15, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "6r1F/tuXRk4cZjgjt3j2EyCF2ip7nEzXjdteTGctbOs"}, "signatures": {"localhost": {"ed25519:a_DTGV": "5shVwPOlfymmw41+X6af8Py9dlBDQUIwsIpFdKUTezO908kr4at1abn95AuIlmkpen1vQ369GCua4nDMWdGGCg"}}, "unsigned": {"age_ts": 1547144389356}}
$154714443231YXmpK:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547144432549.5", "stream_ordering": 31}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714443231YXmpK:localhost", "origin": "localhost", "origin_server_ts": 1547144432622, "prev_events": [["$154714439530kLEKZ:localhost", {"sha256": "5Or7bbTBLKc0QPaFm0A/blCkijCJ57JYNHeJjVhFO+8"}]], "depth": 17, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "zW9+c/sKeoAjnKj07xbHX79FMVLrk5Atpuikjr7SpQ0"}, "signatures": {"localhost": {"ed25519:a_DTGV": "+rW4q3LB3oJsgbaMn4BxopooIfD20iHTR+DjQLR2DCdbYgQeIAWMR7ZEllJkppoD8daWc7WNGskuCGUwqnTeAg"}}, "unsigned": {"age_ts": 1547144432622}}
$154714513153wozrV:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547145131616.9", "stream_ordering": 53}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714513153wozrV:localhost", "origin": "localhost", "origin_server_ts": 1547145131706, "prev_events": [["$154714513052twTnQ:localhost", {"sha256": "ZMX2sROFQa59mf4895S3pbPmEI1qA052j8cakTnjCiY"}]], "depth": 39, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "UmXgs6oMX/ozSQNgYUneKeFpBLFc6IIcp6UU4WA6yTc"}, "signatures": {"localhost": {"ed25519:a_DTGV": "Jlq6r7CTG5n+RVxWzgpmPOCwIG1W8dmO/X8JidHPSO7ygX6Gm2c00QMakXmG6UFcrZLxzzwNaqxvSktHKJmuBg"}}, "unsigned": {"age_ts": 1547145131706}}
$154714446132Evhrh:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547144461411.6", "stream_ordering": 32}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714446132Evhrh:localhost", "origin": "localhost", "origin_server_ts": 1547144461467, "prev_events": [["$154714443231YXmpK:localhost", {"sha256": "8JZj3O2okillrhlXMWmQb6fbRlulnzhRXFje22RUd9Y"}]], "depth": 18, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "LMg1q/zGphMganUTpsTMdttRL5L2scjewz4I2q/UiEY"}, "signatures": {"localhost": {"ed25519:a_DTGV": "tHBsCOL+jnwGG66YqoXrsuHGJWDOgrFnEtrZG3HXh5GWodpxmZTqWPuYvNYJ42X44MXEIYVgBxegWxPhMmrmDg"}}, "unsigned": {"age_ts": 1547144461467}}
$154714516355TZkpl:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547145163720.11", "stream_ordering": 55}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714516355TZkpl:localhost", "origin": "localhost", "origin_server_ts": 1547145163799, "prev_events": [["$154714514854gxKZt:localhost", {"sha256": "13VqI/llHAEJPS5JHocIR01N9xn3KFTtH6OtwyrUmM4"}]], "depth": 41, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "awqh01iBV8vfJXPRcdC4Ve8FimuYRgos/YC4WxMrCU4"}, "signatures": {"localhost": {"ed25519:a_DTGV": "6GpBzPg0GLnx4bgXGtkHAztVfj1JdFtg/hbsWWiAwt9/AXEtbBKPmM1Ie7AB6MbDh17JKYdWFrA/lWnGj0UjCw"}}, "unsigned": {"age_ts": 1547145163799}}
$154714447534UQifj:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 5, "txn_id": "m1547144475668.1", "stream_ordering": 34}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$154714447534UQifj:localhost", "origin": "localhost", "origin_server_ts": 1547144475700, "prev_events": [["$154714447433aWttn:localhost", {"sha256": "IhOl4Y5z7QPBdYaSncLc2S6aa/Z6o4nmSimOnAQJJBk"}]], "depth": 20, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "CZL9ankUVoC9pEUE6S+qxifBCKz4tUEMFD8T9E1Ts6s"}, "signatures": {"localhost": {"ed25519:a_DTGV": "FcQ75fa9K/t29XgihBRKGcxW85FaOXD8PioqtUjMJ6/AFVSCiKEBlnQ54685OIFZP7+BwB4mUwga+iXosvZjCQ"}}, "unsigned": {"age_ts": 1547144475700}}
$154714497944XQHPs:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547144979504.1", "stream_ordering": 44}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuaoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714497944XQHPs:localhost", "origin": "localhost", "origin_server_ts": 1547144979588, "prev_events": [["$154714497443utMjv:localhost", {"sha256": "Ojry/vdl9X/GkaHgNVKeXPX7S+OmYFL39bhe/Rwmvkg"}]], "depth": 30, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "73wlTRO6OHDtoqgH7SKaarW1YFlvJB/Jrn98hkfIReQ"}, "signatures": {"localhost": {"ed25519:a_DTGV": "VwlwJT4EXgFobrd9fbA7BgnkEputxVCcOOdjJ5C6Y90oJXM7mdU9epwQZvn9fXTKSF+nSHpd4jPiesppIChuCw"}}, "unsigned": {"age_ts": 1547144979588}}
$154714504446aiIqN:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547145044467.3", "stream_ordering": 46}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714504446aiIqN:localhost", "origin": "localhost", "origin_server_ts": 1547145044537, "prev_events": [["$154714498345nGKFH:localhost", {"sha256": "2lWLRDZR8lqYkzPyvRmKmElO1h5nxlMs4m//B4IFQrI"}]], "depth": 32, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "BCAdcAROKWt05l5416W+K2GK1ZWBFGwXV3zb2TgpxGs"}, "signatures": {"localhost": {"ed25519:a_DTGV": "qDPe2iCFhViWHTwFGnLsy9tXjOTur5JXIARxa8Lpp/Ny8zq3ZtA8Pt7DAfOZ7fsSpUNyBwMrcz5TqUmdgQWhDA"}}, "unsigned": {"age_ts": 1547145044537}}
$154714506450XWsqc:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547145064256.7", "stream_ordering": 50}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aeou"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714506450XWsqc:localhost", "origin": "localhost", "origin_server_ts": 1547145064335, "prev_events": [["$154714505249jNMbA:localhost", {"sha256": "Q69gNfZX0CZqgLtC7y2tXx+u0oGoYTLrew55O+QvRn0"}]], "depth": 36, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "A7VcooHQZh8NUpI1qPSPEUIwicNBhVuq6Lte/M2UxrY"}, "signatures": {"localhost": {"ed25519:a_DTGV": "Hf5/vbpzuvtjuYCIvIyKg2M9TVT/1PELcX7isl9+iQywpDxEtMiADibg6oDKh5FQGBA23reNxzq91aDtbYF2AQ"}}, "unsigned": {"age_ts": 1547145064335}}
$154714450937xxzjh:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547144509300.8", "stream_ordering": 37}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "ouea"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714450937xxzjh:localhost", "origin": "localhost", "origin_server_ts": 1547144509384, "prev_events": [["$154714447936SjGma:localhost", {"sha256": "q8MJbU4b6GgW0AfSNnFEsvGjxi3t2SWKe9KARdGMR00"}]], "depth": 23, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "y0G31ctBWg4nAZ19DzKhtbPv6BuWxqRPPhqtHmThySU"}, "signatures": {"localhost": {"ed25519:a_DTGV": "cLQGGJ/xK3w6Nf/hC5SZGziSMd84WzgjOkiFY00O9SmAp5zTAPZox2Uln3OWdHgbzBe45eD/yraKRib+LlrzDw"}}, "unsigned": {"age_ts": 1547144509384}}
$154714493741nQcWl:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547144937525.0", "stream_ordering": 41}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "oeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714493741nQcWl:localhost", "origin": "localhost", "origin_server_ts": 1547144937587, "prev_events": [["$154714489940llVyn:localhost", {"sha256": "FF12jb5wTFdrs3OplbmYv77/QRh97VQWDKZBGK4EyJE"}]], "depth": 27, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "SvwAQHx3044NzqkKJQqyQSNIcR7PccSVukoFjgc2sOg"}, "signatures": {"localhost": {"ed25519:a_DTGV": "4POsvGUpoop5da0zKIFi+R+56vLnVK4OOug7MYfh7i75TexvepAEjD/sN5610Nt8EmmXj/5U74nqHxQnOn5/CA"}}, "unsigned": {"age_ts": 1547144937587}}
$154714497443utMjv:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547144974386.0", "stream_ordering": 43}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714497443utMjv:localhost", "origin": "localhost", "origin_server_ts": 1547144974441, "prev_events": [["$154714494442vLOzu:localhost", {"sha256": "3oPSA5InM3g10Z50emRAGgmJiTVh5g03v4HOAst17wE"}]], "depth": 29, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "CSYhJ0sfh1D3QSL2m3Jxql3u94jrlmYVj1WCopIh8F8"}, "signatures": {"localhost": {"ed25519:a_DTGV": "JkBT6i4EqgHZCikKm9A86cQ/d0Dn4RjeiuUyNBK+fWDSkmdXX3tzdx3QBezPvYXxEcUHcfDzNUkjvL/tyeAvAQ"}}, "unsigned": {"age_ts": 1547144974441}}
$154714505048dWZpP:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547145050602.5", "stream_ordering": 48}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714505048dWZpP:localhost", "origin": "localhost", "origin_server_ts": 1547145050716, "prev_events": [["$154714504947xvIss:localhost", {"sha256": "T2W6h1lsW6jiz+XruA24tQ8BV6veoC1HpzIfWBw5+L8"}]], "depth": 34, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "wLhuIFctbEZ3P1I5+TeumsOMks5lbeZoZHc8IKixDIg"}, "signatures": {"localhost": {"ed25519:a_DTGV": "huq4tf+3vGPBzginQ+YSl/BV1r3zlZ0odA6L+dLYhNJq96vtOEC6pYusfhTXvxXSDqwp0SsQ0BhzOQhP5AYcBw"}}, "unsigned": {"age_ts": 1547145050716}}
$154714489940llVyn:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547144899783.10", "stream_ordering": 40}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714489940llVyn:localhost", "origin": "localhost", "origin_server_ts": 1547144899928, "prev_events": [["$154714489839jNhPb:localhost", {"sha256": "3O3O+oHCsm5MiwOmIjjqhwrsq95/XoDmzqwo0HILaZI"}]], "depth": 26, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "737iMzZhs6lWrsuXBr3w0sNoI7+uBzuFYBJH3unlhjU"}, "signatures": {"localhost": {"ed25519:a_DTGV": "76TotveyJat/nVzzgae7xlOQmcWJzcs9N17kgKFOCook8cjvzm3Mi33ZWCtrZaFSBD6uL2R+t77crQIC9PxGDQ"}}, "unsigned": {"age_ts": 1547144899928}}
$154714505249jNMbA:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547145052100.6", "stream_ordering": 49}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714505249jNMbA:localhost", "origin": "localhost", "origin_server_ts": 1547145052214, "prev_events": [["$154714505048dWZpP:localhost", {"sha256": "8QsbIX6UxogQfZMbJaWkN4R/apm8wxQ00HUVQvYmpTM"}]], "depth": 35, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "u/3CFtBurwQeWKgH6B6iziFAYYJ9Dn2F38B+FZHoS2w"}, "signatures": {"localhost": {"ed25519:a_DTGV": "K0vxJx2ukwvjmyF4T6ay1gEdT9bDn1Qmokd9e2wqb1TvqQnmQnCT3wcMNJsKZNGE+Mq7ic0jREMhhh7Wm+hTDg"}}, "unsigned": {"age_ts": 1547145052214}}
$154714508851gyeED:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547145088874.8", "stream_ordering": 51}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714508851gyeED:localhost", "origin": "localhost", "origin_server_ts": 1547145088941, "prev_events": [["$154714506450XWsqc:localhost", {"sha256": "C545OuXQ2r4ECO/f5JqvVs8UPI2gZl0FscKLYCWBRqA"}]], "depth": 37, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "oOMwGP/9/2wgMu1XCZ2fdXBUJMqyBqz9tfCA4LfZrio"}, "signatures": {"localhost": {"ed25519:a_DTGV": "5xtvNd7gR6k93x36K9qnIsFdVf/6MupNDCozpHoQ9S/IHAytivE/o9zSWXyYhkcR3isKGdqJ7HWio7SHk3J2DQ"}}, "unsigned": {"age_ts": 1547145088941}}
$154714513052twTnQ:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 5, "txn_id": "m1547145130179.0", "stream_ordering": 52}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$154714513052twTnQ:localhost", "origin": "localhost", "origin_server_ts": 1547145130218, "prev_events": [["$154714508851gyeED:localhost", {"sha256": "7F8I6qcNcdTfpujLhXFzRBQHwLAxULBOP2kQIfO6Leg"}]], "depth": 38, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "SFvHGX8cKol0H+k0tU16LU/WLT1vN6hXiABb+ppG7Hg"}, "signatures": {"localhost": {"ed25519:a_DTGV": "pJhlz8rnBX3l68xGdLU56eE+DPWKJSCH+xcZMFVm8IrQa/v46bgz0dI7M313z/2pzic3cj+NADHqOXFIZLisCA"}}, "unsigned": {"age_ts": 1547145130218}}
$154714523956frAuI:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547145239781.12", "stream_ordering": 56}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "oeau"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714523956frAuI:localhost", "origin": "localhost", "origin_server_ts": 1547145239849, "prev_events": [["$154714516355TZkpl:localhost", {"sha256": "wkeGZN2MZr+lui7IJTD6N6okw6r6f5ZdYMOE10snVxM"}]], "depth": 42, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "t2KIYrKO8Oez4+20IDDhbSEhiyjLcHcxfiHt7Drw/0I"}, "signatures": {"localhost": {"ed25519:a_DTGV": "xjBzUluiKapQF7/TBIElqVOtqHNlkpSOhmtru0bNuh48FWz3cbJV3VV/qDfwGQEniFesm2rSRiU8+oQtiGgUCQ"}}, "unsigned": {"age_ts": 1547145239849}}
$154714524157LQlkn:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547145241569.13", "stream_ordering": 57}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714524157LQlkn:localhost", "origin": "localhost", "origin_server_ts": 1547145241632, "prev_events": [["$154714523956frAuI:localhost", {"sha256": "9rgDtfeci6CpjocHxyiz1A7nMIVc1rL1HGOYtHs+vQc"}]], "depth": 43, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "C+hEsFZbUEd14yUfJOGo7WtoUbUf2Atn9tyosojsasg"}, "signatures": {"localhost": {"ed25519:a_DTGV": "6sNvKoD08zPgb231ilelOkzRhS8KQtvJhFVO2T9tMxDTotqyoN5ljCYgNlLndiqeJEAHj5lgX1FWahj6vEjACw"}}, "unsigned": {"age_ts": 1547145241632}}
$154714526858lzwnp:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547145268622.0", "stream_ordering": 58}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714526858lzwnp:localhost", "origin": "localhost", "origin_server_ts": 1547145268693, "prev_events": [["$154714524157LQlkn:localhost", {"sha256": "eahTishm2ItfsyM3rmAn2fzDWRjeNMMBslfL34KW1JI"}]], "depth": 44, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "5iJat6gncq2/IfX+48coezdFJ+n36eVxOMMsxvXyu3Q"}, "signatures": {"localhost": {"ed25519:a_DTGV": "cndcYBUfXDw3XWFmuOjrc5HkHlTFAptTCYnj+JHiMZU2ve/8JV4tLgG9v9KXUkq0MqQePpJY0IdUB5uuMbUBDw"}}, "unsigned": {"age_ts": 1547145268693}}
$154714527259ArrwP:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 7, "txn_id": "m1547145272324.1", "stream_ordering": 59}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "oeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154714527259ArrwP:localhost", "origin": "localhost", "origin_server_ts": 1547145272412, "prev_events": [["$154714526858lzwnp:localhost", {"sha256": "tVmRLxup47+XKfObibLvtEk3s9HpVWJIO1qZhSm2G80"}]], "depth": 45, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "JsiUdB1KEtC0hgx++vooqpvyzOMJM5DXAGMvEmSnhuY"}, "signatures": {"localhost": {"ed25519:a_DTGV": "JQ0FjiCRbxILtUDbBTDbnff6FsruTf2xrXe6EH1rYuT7zN1yKAbMxLy1wWiEyUsfriTjqiYRCPn2bETvGgqyBA"}}, "unsigned": {"age_ts": 1547145272412}}
$154718807060Osxiw:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 8, "txn_id": "m1547188070886.0", "stream_ordering": 60}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$154718807060Osxiw:localhost", "origin": "localhost", "origin_server_ts": 1547188070953, "prev_events": [["$154714527259ArrwP:localhost", {"sha256": "H8cPpe3occ+7hk+Me88st26UWwkolsDC+O03vFvTeLk"}]], "depth": 46, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "6VHvlO9h1E66VPk3GQ1hgZdxnrm+K4YvHE/NwQT4IY4"}, "signatures": {"localhost": {"ed25519:a_DTGV": "2czu9Q9TKG1SQdJgmRsgWyMtjSXylTzeePllkT/LxBJcRKu5Fi8N/TVSHxqSJwqVY0qLcS6p3+g2lhS0fnB8Dw"}}, "unsigned": {"age_ts": 1547188070953}}
$154719339771HhoBo:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547193397640.9", "stream_ordering": 71}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719339771HhoBo:localhost", "origin": "localhost", "origin_server_ts": 1547193397709, "prev_events": [["$154719339270SMjRz:localhost", {"sha256": "UTZTRj6tiwg0IVrAp9yLGS2Jr4dc1VQ1BKnBuQmefhc"}]], "depth": 57, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "PPMvqzp6jAUG6AhcHQ9VZ8JfZM7fR+5MDHTVwHLr7ZQ"}, "signatures": {"localhost": {"ed25519:a_DTGV": "0OCvS60Ex1DC4DYpKrTtbx+e/HIBrn4Y53h4MpGkP2VgUmFwqSLp0WukNg5EWhwDhNWkIn8rJeNSEPWJwpNRCg"}}, "unsigned": {"age_ts": 1547193397709}}
$154719378074ykqqG:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547193780148.12", "stream_ordering": 74}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719378074ykqqG:localhost", "origin": "localhost", "origin_server_ts": 1547193780223, "prev_events": [["$154719347073jkPIF:localhost", {"sha256": "b2R0pJhTFlDuIHeGuRPdWC1NYta4R3q3K/4BXawl2Ro"}]], "depth": 60, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "cSO5kCP5lhUdWuFUecIDxWophXN9mfR6XvmtCPlt6tU"}, "signatures": {"localhost": {"ed25519:a_DTGV": "aU6qb3DvDxXKZnQYK60XUtHZTvZhcjTzIyGR2wg9xBnCkENic/DPqOywjfn/YKxGBz1qGiNmATkEOgnwInxlBw"}}, "unsigned": {"age_ts": 1547193780223}}
$154719540392cuLjJ:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547195403424.2", "stream_ordering": 92}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719540392cuLjJ:localhost", "origin": "localhost", "origin_server_ts": 1547195403479, "prev_events": [["$154719540291vvcgV:localhost", {"sha256": "WkjQ9UySQkkGabzX6NtaRNQ2Xu7wEbSBdx/wlVSw3rM"}]], "depth": 78, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "v3DC49X6t3ZEMlFEQjadzmhKT/n1Ba4sBYC/DyIQ2ak"}, "signatures": {"localhost": {"ed25519:a_DTGV": "8g8pmg/Hz+621LUdqUuOvBNiAbNd7V4spqyRVJPkXVHpb4WuiFQZfgkWh2vc6+GdyrWM/W6kzOepQI+VDkoVAw"}}, "unsigned": {"age_ts": 1547195403479}}
$154719547294JJsmq:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547195472183.4", "stream_ordering": 94}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719547294JJsmq:localhost", "origin": "localhost", "origin_server_ts": 1547195472260, "prev_events": [["$154719540493KHAxf:localhost", {"sha256": "JhHH4+V1moINkvM2E0wGnH6F/iRE4xICcpE9v9o6/lA"}]], "depth": 80, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "sHczsOVbTSntifQVuU5TzzQwRNVaJaOHBnMgdW2fTrA"}, "signatures": {"localhost": {"ed25519:a_DTGV": "CfiHbmjrMI/Iwb5Et4wo9AsOJutyt+MuyuPHx5yAyVTdNWD4IOIj1eMK1dzowau/nhOG/JBTzzxmlaI5XjwXDg"}}, "unsigned": {"age_ts": 1547195472260}}
$154719550396cyAjC:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547195503530.0", "stream_ordering": 96}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aeuo"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719550396cyAjC:localhost", "origin": "localhost", "origin_server_ts": 1547195503581, "prev_events": [["$154719547395BoSSt:localhost", {"sha256": "hWIm6t3s9+6OFkkni21yxy4n9YVjwfchSWd1HprvUGQ"}]], "depth": 82, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "sFBNAYcQWwUCMjg0yefBip80/ykWLMj8hvy58wJZ2eY"}, "signatures": {"localhost": {"ed25519:a_DTGV": "WojYMqyfy0JtbQo6PdeAP0stwGBTPLzihhhnDle7olXanJlzh47oxgNgW0mOghBSi2yGvj9Gq6Axa305oHHgCw"}}, "unsigned": {"age_ts": 1547195503581}}
$154718811161PDsGA:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547188111470.0", "stream_ordering": 61}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154718811161PDsGA:localhost", "origin": "localhost", "origin_server_ts": 1547188111729, "prev_events": [["$154718807060Osxiw:localhost", {"sha256": "KPKrnvmXScKF072fATPTFAfQjkGcQMWvzRT6DlXafeo"}]], "depth": 47, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "Y0I8iw6CfBC4WedXFlSsRqx/ZPP2K/ebWCHIvMNktc4"}, "signatures": {"localhost": {"ed25519:a_DTGV": "PxHZQ1GYNEaV68aWDn+ebVir+qJ9hbMlsXQQJCuQ+JTs3UyowKkCpAhBnlmn2h8sKHVn9+2GXQJEqWsjLi2TAQ"}}, "unsigned": {"age_ts": 1547188111729}}
$154719130162RgkdQ:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547191301663.1", "stream_ordering": 62}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "oeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719130162RgkdQ:localhost", "origin": "localhost", "origin_server_ts": 1547191301746, "prev_events": [["$154718811161PDsGA:localhost", {"sha256": "HtbAwQMHsIvaCa7ch1oOmGhl10Y6wNabBBc0qfCl/TA"}]], "depth": 48, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "YPI/JJu5WQ3yB56aOztofiZPgC8sfjL6JZTbR1boF6s"}, "signatures": {"localhost": {"ed25519:a_DTGV": "O7tQnWo9q+CbFw5yvBvbYvB0Lob7hzZNRvNQBfosN4l6p0MQ9GAYFvgmYUzgQNxJy37rxihTj/E29CA04bgmBg"}}, "unsigned": {"age_ts": 1547191301746}}
$154719143563hheAg:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547191435320.2", "stream_ordering": 63}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719143563hheAg:localhost", "origin": "localhost", "origin_server_ts": 1547191435394, "prev_events": [["$154719130162RgkdQ:localhost", {"sha256": "8w8iHwQO0kx7dRlPKCgSY97c+OXIRIqpbdsjOa8KSJI"}]], "depth": 49, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "P+vypD8NHTfWZ/z8ltI0JneW8W+4MpWtmDVolpZpfI8"}, "signatures": {"localhost": {"ed25519:a_DTGV": "lraQYDsD27AsIOCu/nd7neH9+Iby/6STJRuD1KlUxen43muKo/nlRGygxckhwmzPnMwcl6W9YcWJodT6tUDuAw"}}, "unsigned": {"age_ts": 1547191435394}}
$154719144064kEzNq:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547191440188.3", "stream_ordering": 64}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "oeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719144064kEzNq:localhost", "origin": "localhost", "origin_server_ts": 1547191440252, "prev_events": [["$154719143563hheAg:localhost", {"sha256": "0IDGpVkJjXLrChdD3di6QAfTSgXybsDSxj7Ml4D0LqQ"}]], "depth": 50, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "J4x+/46Z36DE2ytGDI8yrnh9GYWNyltX93g9hk6KE+g"}, "signatures": {"localhost": {"ed25519:a_DTGV": "MLGS/Li6bK782FenSrhsbSOXZW+GrgDKoorAoU/14jpP0qgQl5ZW2tcq9oFMBCONQxP+7gRfD/erea1viISoAw"}}, "unsigned": {"age_ts": 1547191440252}}
$154719151365zvWZO:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547191513868.4", "stream_ordering": 65}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719151365zvWZO:localhost", "origin": "localhost", "origin_server_ts": 1547191513933, "prev_events": [["$154719144064kEzNq:localhost", {"sha256": "9VCbnZmW8udg6X/bZqB22hru5w63ttR36QqPrNMW1as"}]], "depth": 51, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "XqvwCGc7Dnbwv7doX3DMgjmcunrSMIwcHcfG/Fsn+Hk"}, "signatures": {"localhost": {"ed25519:a_DTGV": "+O+z8PAZYcWxcM64BDjumHlEzNQmc89pOH44C/7ZURRb6gRLq0EmeoQ+ToV4x9SUvu1hn5FTBiXS7ZHowugZDQ"}}, "unsigned": {"age_ts": 1547191513933}}
$154719164767efuXJ:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547191647279.0", "stream_ordering": 67}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$154719164767efuXJ:localhost", "origin": "localhost", "origin_server_ts": 1547191647315, "prev_events": [["$154719152466oQvOE:localhost", {"sha256": "/vvrKbBhFPCinMHiHwjWBMIYH+KmKQlq1zcEx6C1aYc"}]], "depth": 53, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "tSpnG2li2r2429Nlhxja2d5HFXnwepkH0xWFxYcncP4"}, "signatures": {"localhost": {"ed25519:a_DTGV": "9ks1kVYpIAFhd5UVdS2MdXbKUtZ20KqFyA0ZCw1YV4wvtJrKgo1eTi1a/NasBy2AJsZqYKz9DRJl6mvN3lYsCQ"}}, "unsigned": {"age_ts": 1547191647315}}
$154719247969KPEUm:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547192478937.7", "stream_ordering": 69}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719247969KPEUm:localhost", "origin": "localhost", "origin_server_ts": 1547192479007, "prev_events": [["$154719165168NYIll:localhost", {"sha256": "wkvBUKhYOaGz5hiM8P7JwuAdeqEp49D8mZRlUE+YhFc"}]], "depth": 55, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "mFLaV31wOqX1P5vdiKdjAKG1G3IR8UCYNy59a8IJKxc"}, "signatures": {"localhost": {"ed25519:a_DTGV": "fP9MeI+vZTlGRG2ZWUazXVJamBE3+8/ZrwFuc4pkfGoR0V6mcMhY+7rtk3D4y3mOWX/JYpum15OAnEerbxGHAA"}}, "unsigned": {"age_ts": 1547192479007}}
$154719152466oQvOE:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547191524010.5", "stream_ordering": 66}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719152466oQvOE:localhost", "origin": "localhost", "origin_server_ts": 1547191524079, "prev_events": [["$154719151365zvWZO:localhost", {"sha256": "dzeJo4H4Maq2A3K1QAbdn9+vCvT4YbQpGcPXNRe7l20"}]], "depth": 52, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "kifpqBW1der7ilpPe64hbrCMUGpDUQ+XkuQTPQ460R0"}, "signatures": {"localhost": {"ed25519:a_DTGV": "1eOWTmgunQSyj9ng8E+jI6juGjL37QGP6rnS5qFPK9NVQwNb+hU3MeQxM85PgMKdGGn0QbL6P9PReRfleT72Cg"}}, "unsigned": {"age_ts": 1547191524079}}
$154719165168NYIll:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547191651087.6", "stream_ordering": 68}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719165168NYIll:localhost", "origin": "localhost", "origin_server_ts": 1547191651156, "prev_events": [["$154719164767efuXJ:localhost", {"sha256": "PNmbfh9ufsGQnYlB6217ZOTAXKkV3H7munsX0YUDlUo"}]], "depth": 54, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "U6GzHNsoZzX7PfRC0U6F2YotrchrdrBr0w6XGtmwN+Y"}, "signatures": {"localhost": {"ed25519:a_DTGV": "G6e0d8bXLqvdlCyKL88OPgjsFHEaq9ehFS7hQwW3Kj9iFJmhrYLqNDGtV0oI16ZvKC6sKNdrnjlS5CHQoj7gBw"}}, "unsigned": {"age_ts": 1547191651156}}
$154719347073jkPIF:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547193470906.11", "stream_ordering": 73}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719347073jkPIF:localhost", "origin": "localhost", "origin_server_ts": 1547193470971, "prev_events": [["$154719344372iKEnw:localhost", {"sha256": "Gh+Xw+J2blJ22bCua+kzmhtEkTbKE0bmAxgEs7Hi21s"}]], "depth": 59, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "zrj8F+m9ws2xhprhSRqCVmQqOZ8FWYCtLHKxj3V7268"}, "signatures": {"localhost": {"ed25519:a_DTGV": "xqx1iL2LgmRNbsWeptghoF9dmr+KbN/R82mOH7+EQyK7Z9ST/+bA48i+ZJsQO5GnDZrmPvCeWN7URKYb9xV5Cg"}}, "unsigned": {"age_ts": 1547193470971}}
$154719500977pGQXX:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547195009399.15", "stream_ordering": 77}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aeou"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719500977pGQXX:localhost", "origin": "localhost", "origin_server_ts": 1547195009476, "prev_events": [["$154719496876HQbNA:localhost", {"sha256": "wXzA8QwKFnBNoSx+1fUP9PDIwPnc7NalAYGaIIuAffw"}]], "depth": 63, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "potwPrehOMPpMQyBJpk2IF8zF2SHuZ1Zrlnk09cVHp4"}, "signatures": {"localhost": {"ed25519:a_DTGV": "B1V7tKeK6Wz/mGEic3t9q9QdTw8mKAA7CELvlctbf8kZocuzVTq/3UJrq4r0IG2pJ+NA9wk/DuNACT7xyjoWBQ"}}, "unsigned": {"age_ts": 1547195009476}}
$154719521084EQDIT:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547195210784.5", "stream_ordering": 84}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719521084EQDIT:localhost", "origin": "localhost", "origin_server_ts": 1547195210852, "prev_events": [["$154719519283zKOPF:localhost", {"sha256": "pGSmO0B2OFCv3mNQNYZF4cFw3bExm8M2dLOiJuZXoWM"}]], "depth": 70, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "LyJr32t9duR+zGOeD4LyzdSSBtWUaSqB20AQ80zXib0"}, "signatures": {"localhost": {"ed25519:a_DTGV": "2+lUQVpq4HnrE4F7AqRC/Wdl9srJIINjvxXH7Ao4jJXAxepD89AVPr0jDuR9L3cRaKFAotGFiyXy4OP3wXYCDQ"}}, "unsigned": {"age_ts": 1547195210852}}
$154719537689wbEAt:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547195376050.3", "stream_ordering": 89}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719537689wbEAt:localhost", "origin": "localhost", "origin_server_ts": 1547195376125, "prev_events": [["$154719537488sBeaz:localhost", {"sha256": "VJtaIIenyXLTJ1kDPeqgj6EyP8BzJvq2PTMqTb3lSVw"}]], "depth": 75, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "eDm/5MxytSzGj3bkiyx4KMz3mlzqXm/+MQQaSOHl5G8"}, "signatures": {"localhost": {"ed25519:a_DTGV": "DLG9/+/sfl4qSFFSUp8WQ+s0uUbqf+sNWOLKxqVJ3nTt8qs+R7nstV0Bh8t/BdmJDUbVrSWQvl+LoknpYzkLBg"}}, "unsigned": {"age_ts": 1547195376125}}
$154719540291vvcgV:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547195402866.1", "stream_ordering": 91}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719540291vvcgV:localhost", "origin": "localhost", "origin_server_ts": 1547195402984, "prev_events": [["$154719540290lClpJ:localhost", {"sha256": "+iINc46Y1o0B1VEsr017kuxh1X94APcPnZUJPDG63IM"}]], "depth": 77, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "n9upq7CzrMZaTTyB1owvFlPkalnCW9a+4q/DSU55OD8"}, "signatures": {"localhost": {"ed25519:a_DTGV": "Hnrp8G+YnXOhCBohju7YJiHme7r4B0E3spnSfnPd/ICAffSMVflZT9bB3892GDsNiv4vAO9l1moj6/q1cNJiCA"}}, "unsigned": {"age_ts": 1547195402984}}
$154719339270SMjRz:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547193392496.8", "stream_ordering": 70}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719339270SMjRz:localhost", "origin": "localhost", "origin_server_ts": 1547193392569, "prev_events": [["$154719247969KPEUm:localhost", {"sha256": "R+vZzRQaJk9ct47jfWCVSPoGbyzsh6aWWy/BqtF9jVk"}]], "depth": 56, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "HZztnIL2V79bDH0fhkqBBDhE/ZrB+yb7QxRRLNKBB3w"}, "signatures": {"localhost": {"ed25519:a_DTGV": "GwC8Q5WAYoqCsuBR3U3DLPvaIrjVaViU+64l+gpVvGugB95GvdBs3VnUJ+0Nr97Qh0rM7FwyTXMyH/In7F35CA"}}, "unsigned": {"age_ts": 1547193392569}}
$154719344372iKEnw:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547193443730.10", "stream_ordering": 72}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719344372iKEnw:localhost", "origin": "localhost", "origin_server_ts": 1547193443794, "prev_events": [["$154719339771HhoBo:localhost", {"sha256": "O5fnX3QaEAKm0C0GMesOaGKFsSNLTfgrTYhLK46pXx0"}]], "depth": 58, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "UCeqtrOUlqbrB1n+L75qvjNpPmYPE49IHf+gnygdaD8"}, "signatures": {"localhost": {"ed25519:a_DTGV": "uT2UcODcBkHD5aZ+BS7wTGU9dnxHL9mKw7Wz75nACgm1+EBvI7Wht4VX24YcnufiQjPeWcMBc4sC1HQnzxkECA"}}, "unsigned": {"age_ts": 1547193443794}}
$154719527986LWiBd:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547195279709.0", "stream_ordering": 86}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719527986LWiBd:localhost", "origin": "localhost", "origin_server_ts": 1547195279780, "prev_events": [["$154719524685MEsPE:localhost", {"sha256": "qBsW3rFOVC1YJe1ERtxRTddJNzp2/Ci7k0u/KkkBe6E"}]], "depth": 72, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "D9Ui/S+N2Hbiqn4AvyWG86TV9+TNgNxg3rSKQ4BlFsQ"}, "signatures": {"localhost": {"ed25519:a_DTGV": "xr5O0FU0BKkAvgab/5OdDti+F/8++ZfbM2HMKeFdIGVKhanTjE3uczB5DuUi700wgFPOtzuCSR+/5pw3QbYrBA"}}, "unsigned": {"age_ts": 1547195279780}}
$154719540493KHAxf:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547195403985.3", "stream_ordering": 93}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719540493KHAxf:localhost", "origin": "localhost", "origin_server_ts": 1547195404040, "prev_events": [["$154719540392cuLjJ:localhost", {"sha256": "4+cWBtdbgx0xrmz6QWc4MzwUD2Lh0hHSHO5ewjllSXw"}]], "depth": 79, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "ZaQMbqSS6QWkuUCoPzogBW/fUYHKMmeBX5BdRCeKBbE"}, "signatures": {"localhost": {"ed25519:a_DTGV": "PImw4H+1AMK9Z79G9+UXgJ1RG9BPMe8jTFXGrzYn+CbMkoeYqrJkbyUkZbhn6/IZL4eX8d+XKeg7EL882AobAQ"}}, "unsigned": {"age_ts": 1547195404040}}
$154719547395BoSSt:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547195473610.5", "stream_ordering": 95}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719547395BoSSt:localhost", "origin": "localhost", "origin_server_ts": 1547195473728, "prev_events": [["$154719547294JJsmq:localhost", {"sha256": "7CpuKAZhUhOYGoAEvdHx6KhDgR8WHu0r1yDJkeQ+AR0"}]], "depth": 81, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "zbGV+5dNIUAiu2nki5EHKAy4My5EGtEbRx0iBl/MUl4"}, "signatures": {"localhost": {"ed25519:a_DTGV": "19bFB9EUpcPjCAQcjNv9/jK0P3/QvX9JMiDc1J0Cgxnktwkq+ZaLdHWMNTSHMqL9selGvtTClgvMG2GiuNd5Cw"}}, "unsigned": {"age_ts": 1547195473728}}
$1547201566108vIMzG:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547201566709.12", "stream_ordering": 108}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$1547201566108vIMzG:localhost", "origin": "localhost", "origin_server_ts": 1547201566830, "prev_events": [["$1547201474107QSZzp:localhost", {"sha256": "KKj6JmgbuKY0wGKD1aMC+odFfff6BVJsb4nyBiwzYpA"}]], "depth": 94, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "6iuUQ+oDYaexr41+R9I6WFONaudjN7Q4bgiFvmK35tM"}, "signatures": {"localhost": {"ed25519:a_DTGV": "l4fKkDzOZi0ZUIfONCtZ5rKxMEY11BtavyUUCPi4mMk4T2S3AsT3JMaIgio+rhSpgEAZHwPqb/otOHE2hicIAQ"}}, "unsigned": {"age_ts": 1547201566830}}
$154719491875LeoON:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547194918586.13", "stream_ordering": 75}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719491875LeoON:localhost", "origin": "localhost", "origin_server_ts": 1547194918655, "prev_events": [["$154719378074ykqqG:localhost", {"sha256": "gHC0HkaY5zaPA4emUtAAIeOskN99QPE8ECpzVHtXqH8"}]], "depth": 61, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "jPNFp/lqEJN7XST3mG58XtKzoFZrlbAPi/jn79tMFq4"}, "signatures": {"localhost": {"ed25519:a_DTGV": "yLViBTlIed/dokpBpNg2HvqYv/Mpbb6Tu0b4sZuyWcFe94HHe9dhMUkCB2rYUj7gZ5FF0C9Ohg9dwGWa68pfCg"}}, "unsigned": {"age_ts": 1547194918655}}
$154719540290lClpJ:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547195401765.0", "stream_ordering": 90}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719540290lClpJ:localhost", "origin": "localhost", "origin_server_ts": 1547195402209, "prev_events": [["$154719537689wbEAt:localhost", {"sha256": "frIV3Ng2bi3hVK2LG7W58MqdCJZuJcrspaoBidb+DlE"}]], "depth": 76, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "VcsJy2k4HUl8D32CewIRnkTkLaFvd3P6Af5/sz9xqik"}, "signatures": {"localhost": {"ed25519:a_DTGV": "h/7TAHCEI/h6roFQHlD6AkWkbYqNX7+jfl+79hjBCKSz93DCefrA7w7MZPjeCbYR/4UiBL1x77I3DeBeM01ECQ"}}, "unsigned": {"age_ts": 1547195402209}}
$154720039497BQXbf:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547200394171.1", "stream_ordering": 97}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "\\u0444\\u0432\\u0430"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154720039497BQXbf:localhost", "origin": "localhost", "origin_server_ts": 1547200394229, "prev_events": [["$154719550396cyAjC:localhost", {"sha256": "233ig4SrYmW9FbJcG7zdKCJzkoSROFw+DMyib3wpFWg"}]], "depth": 83, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "05XgRqIkxemxBeYYy5TZuUDVoabqyuIamO75pYT8nTg"}, "signatures": {"localhost": {"ed25519:a_DTGV": "6VtSViEn4Y+h5p4UFmYn7PRlGdvuevDXtUzxQOzLfsQm8DdCAVIz0TCVb4dHmK0TFLlLgtlLZw57Mgktn67zBQ"}}, "unsigned": {"age_ts": 1547200394229}}
$1547203164109HWxxp:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547203164222.13", "stream_ordering": 109}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$1547203164109HWxxp:localhost", "origin": "localhost", "origin_server_ts": 1547203164276, "prev_events": [["$1547201566108vIMzG:localhost", {"sha256": "S5h2JNpscBKI8gQNj60FI1iOSPwV/lGlDvECfsjkMMo"}]], "depth": 95, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "/XZFmm7P34vGo5GRU6Y8uMxpFe1GZwACbmPiYbI56is"}, "signatures": {"localhost": {"ed25519:a_DTGV": "jlRFuI7zjCMWP4lDjvfWuZxmxLSek8R7CdUA38JsVjjYtfV2LGGBOgSpAj8CXwhL8V5iNffW3CySSJAJIIyTCQ"}}, "unsigned": {"age_ts": 1547203164276}}
$154719496876HQbNA:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547194968477.14", "stream_ordering": 76}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "oaeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719496876HQbNA:localhost", "origin": "localhost", "origin_server_ts": 1547194968541, "prev_events": [["$154719491875LeoON:localhost", {"sha256": "KROZMQ6tXzFtFGqvDx8M654pQfbtAyXK/7s43imVdzI"}]], "depth": 62, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "Rl+88Zy9MMp+44sq0jQpEB/MBZw7erIEDT3tQpE4+28"}, "signatures": {"localhost": {"ed25519:a_DTGV": "5rAk3DU/reHKoFnpqtQLukbOxzpTGi07c3b0XMUePgNJTZaq/vxk3rzMQ5qLmBDR1YOaEgb8UIyJOpGXGmRsAg"}}, "unsigned": {"age_ts": 1547194968541}}
$154719524685MEsPE:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547195246171.0", "stream_ordering": 85}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719524685MEsPE:localhost", "origin": "localhost", "origin_server_ts": 1547195246834, "prev_events": [["$154719521084EQDIT:localhost", {"sha256": "8BSpbnifJeszwcIXIkn9tCcq23iyLAWK6RCblwbzzf4"}]], "depth": 71, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "V2XKwZQ0pcej9S1QtEAEJFiyYUp4yH6bw51p8oMNCbI"}, "signatures": {"localhost": {"ed25519:a_DTGV": "UJ7IDGwg6p3SzTfPlkFDrjbp3wEtW0mHnmZz5JhT/7+XmIH4arGmv1gfG0N2+uenaKBLPxWELmmtnbPqUkJ1Dg"}}, "unsigned": {"age_ts": 1547195246834}}
$1547209017111VCOtq:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547209017833.15", "stream_ordering": 111}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$1547209017111VCOtq:localhost", "origin": "localhost", "origin_server_ts": 1547209017897, "prev_events": [["$1547209015110ILKew:localhost", {"sha256": "7BICDPQNIc+K74+xWQpRfZliDgt1Eiy+1rpMY9aboYY"}]], "depth": 97, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "duCMNptzWikLF2Rb3Bho3Nzas6V/HfLOVdfA2waNsow"}, "signatures": {"localhost": {"ed25519:a_DTGV": "SWZrfAnKkcfrHrQ7IhPFURsd7V4dBy8QyNEYxnAhKOVgC1XxQ70u7b4vJCH97H8O0guMwC+wLRF4KtTh25l9BQ"}}, "unsigned": {"age_ts": 1547209017897}}
$154719502078SFZFP:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547195020355.16", "stream_ordering": 78}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719502078SFZFP:localhost", "origin": "localhost", "origin_server_ts": 1547195020422, "prev_events": [["$154719500977pGQXX:localhost", {"sha256": "X0PYGBc5qj+eB+t0k87Hd5YgtPhdY8cwRKVZjtvwyno"}]], "depth": 64, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "pbiqytYJ3qqLsVb+N5bB3z9oDk7X17SS2rcuINAP34c"}, "signatures": {"localhost": {"ed25519:a_DTGV": "T6vXpM9F/sxoZ16lzZ2Xc6jv0e9KopfmWmDyqdVyqVI6AV5XJOlbhHSsiTa0XR6kU+s4iRyNyboAtBX02VX4Dw"}}, "unsigned": {"age_ts": 1547195020422}}
$154719505679wchms:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547195056673.0", "stream_ordering": 79}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719505679wchms:localhost", "origin": "localhost", "origin_server_ts": 1547195056740, "prev_events": [["$154719502078SFZFP:localhost", {"sha256": "3MuqZge2GlIymcjcPHNZuA5JIybogfSRsgllgniUIG0"}]], "depth": 65, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "6ayXcw55TFO/YxbHbskY3fGfqTZif7gvD8a1kbXDKeo"}, "signatures": {"localhost": {"ed25519:a_DTGV": "/yI8jOCV7rRgyNcbzHnTbJ3ygIEB4W2Joqs6uLm8mLGeJHcXA+r8S3DLPJYTc7ohKkordWnJRurMnD/T6zKnCQ"}}, "unsigned": {"age_ts": 1547195056740}}
$154719514682XMEKF:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547195145953.3", "stream_ordering": 82}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719514682XMEKF:localhost", "origin": "localhost", "origin_server_ts": 1547195146024, "prev_events": [["$154719514481IOBiR:localhost", {"sha256": "ObuJJxACVjj9oayj+FejSbzLAbMG6D1t9CdQlK7oOWY"}]], "depth": 68, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "pewHLuHNLjl8VfHS2TLPhad7/sByBCeVS+TgYYq6gdo"}, "signatures": {"localhost": {"ed25519:a_DTGV": "g8eioJ4KMUS36F2j0k742D+lgbRPxe3Wb4pDRgHz0kqoRikuWaNsraVswbNNQX+Mtqgz37JzIab9Q8YZYlMLCg"}}, "unsigned": {"age_ts": 1547195146024}}
$154719519283zKOPF:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547195192849.4", "stream_ordering": 83}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719519283zKOPF:localhost", "origin": "localhost", "origin_server_ts": 1547195192917, "prev_events": [["$154719514682XMEKF:localhost", {"sha256": "r+pTcV5eecL09/DQ28fM1WwooH8I6ikfij3Mb8h53H8"}]], "depth": 69, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "7Lcjjkwk/wU7oqxPi6XcQqlQvifeWdWr7BCVCHCLwWc"}, "signatures": {"localhost": {"ed25519:a_DTGV": "QRA11QtRqBCQPhnWV4WWPB7ZjgT0V1PcLX38CDOrbjdYxFaSYNXLTTTi3LjzyWK+mr46Tn62kuoCpNQdBO+hDg"}}, "unsigned": {"age_ts": 1547195192917}}
$154719531387IgQOF:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547195313522.1", "stream_ordering": 87}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719531387IgQOF:localhost", "origin": "localhost", "origin_server_ts": 1547195313573, "prev_events": [["$154719527986LWiBd:localhost", {"sha256": "Ql8EyMROSjhpq/A1/zJEAzvdlxGExIAwPzzJJT3p0FM"}]], "depth": 73, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "zQOT85n9ajyq0p19nbNAadG5pNWBe5WcJ2imacD2uks"}, "signatures": {"localhost": {"ed25519:a_DTGV": "JQCrZ9IT5Yr/a6DOvre72o2BoNIWC+FQfouXhJksWYlU931uazvc9MXZ31RWm4z+lXJ36fiVNP/G2J7mvetDBA"}}, "unsigned": {"age_ts": 1547195313573}}
$1547201298101MsJGQ:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547201298245.5", "stream_ordering": 101}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$1547201298101MsJGQ:localhost", "origin": "localhost", "origin_server_ts": 1547201298386, "prev_events": [["$1547201274100AXvny:localhost", {"sha256": "Jms8jNmHn8AZOfU772dRGSqS49u95KoQGGw5RaRRCTU"}]], "depth": 87, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "Vv5YGjcWDK/xo4E4a2pZbBkT5H5Y4AEYqMKWYmMDg40"}, "signatures": {"localhost": {"ed25519:a_DTGV": "W+Xj4NkAms0VaFN+EKLf8h0y5G01FPcwCJvGJwkh5EChFsR9gQyU5rnAOdBlG3pDy7GPqviYEWuSIY5rb44RBg"}}, "unsigned": {"age_ts": 1547201298386}}
$1547201299102nrFQP:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547201299803.6", "stream_ordering": 102}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuaoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$1547201299102nrFQP:localhost", "origin": "localhost", "origin_server_ts": 1547201299865, "prev_events": [["$1547201298101MsJGQ:localhost", {"sha256": "NHiIkAb1Vxg+tlm16GfLN8iC6MN/q8Ee9FfDu2+/5ZM"}]], "depth": 88, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "OzvHhPTASfjgP+pB7FU76teeJeiJdG0gWBiIrMA3Evw"}, "signatures": {"localhost": {"ed25519:a_DTGV": "L3rLNZbUkMsEQVAUu6GpJy5aDjgN8wi2tgxB8udEHCABms1bCHhlon79487mH/oFgJ2kTTTM1Tmd7mdCa9s+Dw"}}, "unsigned": {"age_ts": 1547201299865}}
$154719508580jYTcz:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547195085004.1", "stream_ordering": 80}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719508580jYTcz:localhost", "origin": "localhost", "origin_server_ts": 1547195085140, "prev_events": [["$154719505679wchms:localhost", {"sha256": "qWiomdxb7RuhhZsH9SCiqbHn2QKxsbF32FHMzVw4q4A"}]], "depth": 66, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "vzQOCFeYFfi9QjNfw/VNB9JIRWL7TAlDmj9p+uAwNYE"}, "signatures": {"localhost": {"ed25519:a_DTGV": "9o19Ijec2o+u/62XH0xB8KvlieroPxL0TQhEkWNUyjvPfvqLmPBByPKxYcNv0BaSM7f4ty2QRfttrUU5atKXCw"}}, "unsigned": {"age_ts": 1547195085140}}
$154720043498SQgyh:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547200434135.2", "stream_ordering": 98}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "eouoa"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154720043498SQgyh:localhost", "origin": "localhost", "origin_server_ts": 1547200434215, "prev_events": [["$154720039497BQXbf:localhost", {"sha256": "0rfpuvBG9VJ6CbNjx1zcGzLamClJt/708tgit3EOaR0"}]], "depth": 84, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "xG2oaWbGMxopJdrWNwu5lrNuKgFXO5nHMRy2gX4pfQI"}, "signatures": {"localhost": {"ed25519:a_DTGV": "PCjfLrGjJLG5Lytg7cwPLnLsnJ8jxf0lonv3f0nIbGQ6AAYmknClQwQrNQEe7Hsgjn6Y2+gwKN1oWRRoj1D7AQ"}}, "unsigned": {"age_ts": 1547200434215}}
$1547201474107QSZzp:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547201474715.11", "stream_ordering": 107}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$1547201474107QSZzp:localhost", "origin": "localhost", "origin_server_ts": 1547201474808, "prev_events": [["$1547201455106obHen:localhost", {"sha256": "LedyHYgc6aFayFnxSZXpvnn4jU6EVb3F4ko+iIeQAZI"}]], "depth": 93, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "TM/ifr7hz4by51U4RVJbT1Le3AjvV9sUMq9SS0UWxbs"}, "signatures": {"localhost": {"ed25519:a_DTGV": "Je3yen/YnQ2GjiB4U03rGoog1Yi4NJPVUKLafQbCZ0/D9RDI8NBXJ9aI8/pxNDOjahG1KOPuWPbYL9RjK1VeCA"}}, "unsigned": {"age_ts": 1547201474808}}
$154719514481IOBiR:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547195144349.2", "stream_ordering": 81}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719514481IOBiR:localhost", "origin": "localhost", "origin_server_ts": 1547195144401, "prev_events": [["$154719508580jYTcz:localhost", {"sha256": "i1S6j/TqUy+B6nGIu0YiKaSdJir0AXb1Iv689xmegD8"}]], "depth": 67, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "OEyGPvifeOE62gvQNAH5u/z5yAG3BnL7hw6fkdXiTxM"}, "signatures": {"localhost": {"ed25519:a_DTGV": "kITjwYNpsbLKXOYSBoSjozNg+qlS/sjAcbF2+iVPk8P2jXHi6plaXFzHJUIqhrPzPVKZlAMmdOeZ+xxurZgZDw"}}, "unsigned": {"age_ts": 1547195144401}}
$154719537488sBeaz:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547195374485.2", "stream_ordering": 88}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154719537488sBeaz:localhost", "origin": "localhost", "origin_server_ts": 1547195374543, "prev_events": [["$154719531387IgQOF:localhost", {"sha256": "vuS9kNObOEojMk7DrqCxmmGMGV9ATbkF9yRYeA1Kd6c"}]], "depth": 74, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "xyEaxzu+IECKIEKJgPOn+zAuPhCBxEu3QkOAl7AQEvY"}, "signatures": {"localhost": {"ed25519:a_DTGV": "wFA2HRIFeP4BuWxQiZqcOto9kKeD6hE/0oSP0IdhDGAYjvky77PbPHgUC7jASl85hKCwkfzQrV8OgnePwiMmCA"}}, "unsigned": {"age_ts": 1547195374543}}
$154720071099yrpdB:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547200709978.3", "stream_ordering": 99}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$154720071099yrpdB:localhost", "origin": "localhost", "origin_server_ts": 1547200710055, "prev_events": [["$154720043498SQgyh:localhost", {"sha256": "1a1jPxSQw0THW+5RYjVOGuwBvwCg4IYJzohPM5qOlVI"}]], "depth": 85, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "+VHPJjLQyoCxVAA6Ac9D3Bh5L4jtGdSpvJUu/tUWcug"}, "signatures": {"localhost": {"ed25519:a_DTGV": "FGWe/BfW1CQnfS46w7aJdVNba6f5g6gXtypXk609+y6lrPRVltKfdL5LgRv4CCukxEnEFOdcFpD8mgjM7KAqBA"}}, "unsigned": {"age_ts": 1547200710055}}
$1547201274100AXvny:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547201274243.4", "stream_ordering": 100}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuaoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$1547201274100AXvny:localhost", "origin": "localhost", "origin_server_ts": 1547201274438, "prev_events": [["$154720071099yrpdB:localhost", {"sha256": "F8dC/hIAsfHtymAghaY/QgJH89+3frEcYNDnjgmAKCg"}]], "depth": 86, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "+eXMp2NrWeWXECRZSKjoisu4JX8lFRhu3h0JOPKkujk"}, "signatures": {"localhost": {"ed25519:a_DTGV": "FXWrMf63y7F3I8hkbNJ89MxJEKNH1DpwAGVFot0I58YbUiZBON3Bo+WyUHEb0PUE7adS7zHQVU5zD7058oUIAQ"}}, "unsigned": {"age_ts": 1547201274438}}
$1547201310104XQQzj:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547201310389.8", "stream_ordering": 104}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuaoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$1547201310104XQQzj:localhost", "origin": "localhost", "origin_server_ts": 1547201310442, "prev_events": [["$1547201301103APSbA:localhost", {"sha256": "65JiLba/Y+RwoMgLXA2gLVCtoTrC3q0v9WNVleRC6FM"}]], "depth": 90, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "sr5e5gieXEQOq7amV5eWLk9ZfE/7p6AMEAWmf/cReiE"}, "signatures": {"localhost": {"ed25519:a_DTGV": "78XFeZo4/2DWBVwCTe9cCso0IUdCfsLUkk0q6Y+8Ztp7Bkxsq9eG1vc7MMqjPQB0GEuQ8rTZxUjoEp34vfa4Dg"}}, "unsigned": {"age_ts": 1547201310442}}
$1547201455106obHen:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547201454960.10", "stream_ordering": 106}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$1547201455106obHen:localhost", "origin": "localhost", "origin_server_ts": 1547201455036, "prev_events": [["$1547201345105jVolj:localhost", {"sha256": "//7FFYPs6+kCHIZr0dWqKNd+x/IfP01O3bRbx7cFRCM"}]], "depth": 92, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "10wOai/crcOH/85MY9WTPsfEkwQMizv8awhXJ/NUrtU"}, "signatures": {"localhost": {"ed25519:a_DTGV": "YhBqge1ZXRmKzigPrdkMUKMCnu9EaliLLbyzAZkrXT/DFc5asmMXAPaM1JZzBwc8U757BwPK3cPdPbyO0NSBDA"}}, "unsigned": {"age_ts": 1547201455036}}
$1547209043113TVkrB:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547209043912.17", "stream_ordering": 113}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$1547209043113TVkrB:localhost", "origin": "localhost", "origin_server_ts": 1547209043964, "prev_events": [["$1547209037112vjLNr:localhost", {"sha256": "E7Q5+VfO7ciRXSjxboIVeQNwW3dq4iEXKi4zraOsJws"}]], "depth": 99, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "nlOk7yZdJf3drgOExxD8MVglp2vLmyc26IsSh1GG7D4"}, "signatures": {"localhost": {"ed25519:a_DTGV": "iCnB/tXhfklfXqsS/x0XPrE3qXWHOegDCzbcHY4PAn3Ucw58vtwgPitSkWhxxtdTEf9aGro2qGP+GfrWpp/iDg"}}, "unsigned": {"age_ts": 1547209043964}}
$1547201301103APSbA:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547201301449.7", "stream_ordering": 103}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuaoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$1547201301103APSbA:localhost", "origin": "localhost", "origin_server_ts": 1547201301519, "prev_events": [["$1547201299102nrFQP:localhost", {"sha256": "tUyzJIRsm8r52AlqjRxMnKs56wEYtsCnZXlIKKV/FIs"}]], "depth": 89, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "hHG4tBwL3/Tv5fT6R2pqj9OIdRsTnrDS31SU7vBofFc"}, "signatures": {"localhost": {"ed25519:a_DTGV": "+3LZHL+4bvhtHawwsd6vL7G7n7sWj13NG3W+/9WMN2v9vLGyguC6WRtMoaPdIE2YegrhuZI1zhOiwr3CYepfBw"}}, "unsigned": {"age_ts": 1547201301519}}
$1547209015110ILKew:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547209015179.14", "stream_ordering": 110}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$1547209015110ILKew:localhost", "origin": "localhost", "origin_server_ts": 1547209015256, "prev_events": [["$1547203164109HWxxp:localhost", {"sha256": "LGRazvjXROyspMdpdRBsP1ex2FZd95+ZhRS7BkCI5w8"}]], "depth": 96, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "SroJExZf1l/6hFOQHWs6n9XA/lXFhDLgEr/Lo7A0jjE"}, "signatures": {"localhost": {"ed25519:a_DTGV": "s3S/cm35RAx3qqFpJ5PONyn6qzkJGHlT8bGbpJ9TJXFXBNaWQPhE2D9+TCvS8VSeGbzaki7vTzx4RwRL2BcQAQ"}}, "unsigned": {"age_ts": 1547209015256}}
$1547201345105jVolj:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547201345446.9", "stream_ordering": 105}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$1547201345105jVolj:localhost", "origin": "localhost", "origin_server_ts": 1547201345532, "prev_events": [["$1547201310104XQQzj:localhost", {"sha256": "9pxOYN9D15S2oUitoE+lUH9JcUKV2dx+o+kALEM+E3Q"}]], "depth": 91, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "PsCTnFjye3SHPppcpO0VqvYVhwm5u8+fAYfYnH/TlM0"}, "signatures": {"localhost": {"ed25519:a_DTGV": "fjGTRGTd5jwDdK86NtzGplT9qBd1GwxD3Anmjd44GUurh020JwjnfKZXiXVza7AELhENdx6QlPRo+cswEov5AQ"}}, "unsigned": {"age_ts": 1547201345532}}
$1547209037112vjLNr:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547209037665.16", "stream_ordering": 112}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$1547209037112vjLNr:localhost", "origin": "localhost", "origin_server_ts": 1547209037723, "prev_events": [["$1547209017111VCOtq:localhost", {"sha256": "8NvIQxYsId2YNdb7rh5IVDXeD8pjyUnziBLKCu+53NU"}]], "depth": 98, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "qn7E6ZW97cWgL7EGXn5q4GeItUmAnHKst4HBK34ikYg"}, "signatures": {"localhost": {"ed25519:a_DTGV": "SaZBS7yEoz9M5v0lMgbATlhNKcOR6dadR76HGK/Pha/qL7IM+1cZxEhx4L/RPhWrMNHNyTEz0sJ4xPOD1eXHAQ"}}, "unsigned": {"age_ts": 1547209037723}}
$1547209096114BlJbe:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547209096268.18", "stream_ordering": 114}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$1547209096114BlJbe:localhost", "origin": "localhost", "origin_server_ts": 1547209096338, "prev_events": [["$1547209043113TVkrB:localhost", {"sha256": "oEZeVNVIK5fLs47W9HC5FqPwPaI/XxJgPufWJh9hn5k"}]], "depth": 100, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "bwy0fNRN+W6S8u8O3SlGvO/CZFUKJpYA+wmkmP1Nol0"}, "signatures": {"localhost": {"ed25519:a_DTGV": "1Q9DycvwaTj1WbP0yMypxBCg6JOJkutPh43ZxdUN7bs6Vc0s0cobYwl46nsNYze3TlPmPhGUPm2dD3pcmGjvAg"}}, "unsigned": {"age_ts": 1547209096338}}
$1547209171115HwvmV:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 10, "txn_id": "m1547209170951.19", "stream_ordering": 115}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes1:localhost", "event_id": "$1547209171115HwvmV:localhost", "origin": "localhost", "origin_server_ts": 1547209171015, "prev_events": [["$1547209096114BlJbe:localhost", {"sha256": "l5rJ4yW3C8B/kmXoSGXwq1r0lr84iU3YZZzhmcfv12U"}]], "depth": 101, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$154714438325bxgqT:localhost", {"sha256": "KvIxn3JekH5sLCpRk45Hziux1MxwnHqoFGRNNw53JJA"}]], "hashes": {"sha256": "d9TuZUhcuGKiG3A5nduNd8+eCG3v7eUXxxas7VnDl+c"}, "signatures": {"localhost": {"ed25519:a_DTGV": "PjpoEt6hHnmGKbLMtRGkr6X009mnU4Wp+KxJjvoRh5H3LeaCMF9chzg+RMBq/4OhLeb60Uz3uc8BoNqrfc+DCg"}}, "unsigned": {"age_ts": 1547209171015}}
$1547209244116RahcN:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547209244973.0", "stream_ordering": 116}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547209244116RahcN:localhost", "origin": "localhost", "origin_server_ts": 1547209244988, "prev_events": [["$1547209171115HwvmV:localhost", {"sha256": "DNv8anRMECTPMLLdZaeKfegkoWBoxM7ieeuMIHq+ToU"}]], "depth": 102, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "XUy7t86Oo8JApHRCotcPvfnJKHhXuE49+rFzEqArt5A"}, "signatures": {"localhost": {"ed25519:a_DTGV": "eruxr2/hS3Cua50gkl7hniV6Mo71+Vio/TsLjigBNlBkkxHHNIxAdIbUnqnA1GAjRqLtQsO0J24G+FmFz9uTCw"}}, "unsigned": {"age_ts": 1547209244988}}
$1547211554117Elhng:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547211554953.0", "stream_ordering": 117}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547211554117Elhng:localhost", "origin": "localhost", "origin_server_ts": 1547211554975, "prev_events": [["$1547209244116RahcN:localhost", {"sha256": "ORM2iW5uA3fKHvnLFNOg29vrofCgDSoLoNtT5jkKWnc"}]], "depth": 103, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "pbWZbwukMn/F4NXQUnFWL27+Z0CzLGnh8LrEnTlAjMA"}, "signatures": {"localhost": {"ed25519:a_DTGV": "NVu/KxY7pUA7l/1OWxO3Rm+n/bb8KkRr3xxywOlISkNIxdR7H7kMFGrlWDqDA7FiQsJ/Id+KqLkyhGipGSc0Aw"}}, "unsigned": {"age_ts": 1547211554975}}
$1547220025118yFXAz:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220025407.0", "stream_ordering": 118}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "\\u0444\\u044b\\u0432\\u0430"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220025118yFXAz:localhost", "origin": "localhost", "origin_server_ts": 1547220025443, "prev_events": [["$1547211554117Elhng:localhost", {"sha256": "TO3i2+zJapnVNgu5A/AtyBEPpMfz9TokudWfpfRFtCs"}]], "depth": 104, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "7ab2P/l18q5pBhey7UiU9i86dIieYNxbrau9wE3ZcSU"}, "signatures": {"localhost": {"ed25519:a_DTGV": "O5Kdu5WV/AI9jmrzr8TT213Qwqloo/6cOBeaf6EoPQuOvF6b4vBTKdfMPtfA4udOdTEaRGmaC/oj1xMXdnSKAg"}}, "unsigned": {"age_ts": 1547220025443}}
$1547220096119DwtHP:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220096455.1", "stream_ordering": 119}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220096119DwtHP:localhost", "origin": "localhost", "origin_server_ts": 1547220096494, "prev_events": [["$1547220025118yFXAz:localhost", {"sha256": "nBR/x22f1P+4uDgPGGrOzVxIpgYhf0o8N4VlCF5GlOM"}]], "depth": 105, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "qCLFcNHah+75P4FRezfBUFGxQoCeZkNG5N2fHVTMviI"}, "signatures": {"localhost": {"ed25519:a_DTGV": "+0jDnSV4UsANYz4qPVaLWwzP7oNz1mfB0ppzj3lDhFmBSyp6Czvw0CgZ5hnLYEnwc87CLnUPGTPrg1w0leskCA"}}, "unsigned": {"age_ts": 1547220096494}}
$1547220197126rpVNs:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220197307.5", "stream_ordering": 126}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220197126rpVNs:localhost", "origin": "localhost", "origin_server_ts": 1547220197323, "prev_events": [["$1547220196125pygpM:localhost", {"sha256": "O1gpAYOg7FRUldbNWKHAbblKpxJFqEES1AS+XLyRstg"}]], "depth": 112, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "Fi8WWEX+OB3vnym0zOI/bW+rylFW8eoD/jLIQrjt31U"}, "signatures": {"localhost": {"ed25519:a_DTGV": "QjE+twLem9I5/cZaN4Az/++jfzlTI+nla29HUfw01GosPrRD5ppYe2PkJpNAOp5gxza8Op1PyDRRHU/rxPO+AQ"}}, "unsigned": {"age_ts": 1547220197323}}
$1547220342139OPXTO:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220342965.5", "stream_ordering": 139}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aeou"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220342139OPXTO:localhost", "origin": "localhost", "origin_server_ts": 1547220342997, "prev_events": [["$1547220337138tFafe:localhost", {"sha256": "2xYzH8SlNkzuwzXsvwhHi5pYvkXOqqnDq3FMZ3is4Js"}]], "depth": 125, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "mM5+eTePh7rtxtIuL5lxzeBazYk9Px5M8E53GgN5YAE"}, "signatures": {"localhost": {"ed25519:a_DTGV": "UtFEfgQC0qxbjHl0MLLkbjIqwkkgS/CQI7B3NHurZHI8yL5SmXGRIQr9bW6+UXomLzf5ecBY+KJuMRcAUFxqCw"}}, "unsigned": {"age_ts": 1547220342997}}
$1547279189147gYZsO:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547279189018.5", "stream_ordering": 147}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547279189147gYZsO:localhost", "origin": "localhost", "origin_server_ts": 1547279189057, "prev_events": [["$1547279187146HVLNT:localhost", {"sha256": "IbWPXI8HuRcM4u5Tk/FwUaU11NjPKh05dUfpuQ6XkRM"}]], "depth": 133, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "7NCsdzTAFDurxZF7NEZtljrXGp5WZnzhoI2YklQYsGo"}, "signatures": {"localhost": {"ed25519:a_DTGV": "ZXpFUG4Yuf+bXk+kg0qqdyTeDfU7bjqrE8WP4NHWXZ1Si7bTve7lpAxVj0zcZVgFAuzosimikFV1UvFtr0iVBg"}}, "unsigned": {"age_ts": 1547279189057}}
$1547279319151MaOud:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547279319962.2", "stream_ordering": 151}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "eu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547279319151MaOud:localhost", "origin": "localhost", "origin_server_ts": 1547279319992, "prev_events": [["$1547279319150fMLrf:localhost", {"sha256": "2E95CTFOwQPSayh7eQ7mP6SfVqXJP57v0N4ZOWcowQQ"}]], "depth": 137, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "o+XVdKTeuU2qUnmw9z/Foa6M0aPw+cfZiAxakQ8mu+A"}, "signatures": {"localhost": {"ed25519:a_DTGV": "ZarAK+Rqsn7Y5Q5kxekA33g83iIJPJkoToRrRx1Yza5QO53aALVd4S978g6nXO5wDcy/eDe2upYwi8rsfgchBw"}}, "unsigned": {"age_ts": 1547279319992}}
$1547279331155MIaaY:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547279331113.0", "stream_ordering": 155}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuaoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547279331155MIaaY:localhost", "origin": "localhost", "origin_server_ts": 1547279331146, "prev_events": [["$1547279321154qYYIA:localhost", {"sha256": "BmhCCH9as/SOmdgdpmkh66Nnid4c2pqxj2KU3A9NjUw"}]], "depth": 141, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "fUXdEmoUX6UnIiV7I/gd9g54fKJUe6+Z8CnLb3RlMDI"}, "signatures": {"localhost": {"ed25519:a_DTGV": "f65B2jT8kQ1/JqZg/vNIp7SFOT4sQZEa8bYkZVjtrl5I/GF7sf/PrTl30Y5WH/VpZZg43YUT5ag1vIsf73hiAQ"}}, "unsigned": {"age_ts": 1547279331146}}
$1547280816172DhRcw:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547280816804.0", "stream_ordering": 172}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547280816172DhRcw:localhost", "origin": "localhost", "origin_server_ts": 1547280816844, "prev_events": [["$1547280764171pBzRc:localhost", {"sha256": "GC1XoMul9L/hQwABGyA8gAkMVqtVivfInJrUCldN9dg"}]], "depth": 158, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "kjzCkAyp1pWJ1zhfPeXCIBORdvrBeXSaZp8HXKncaG8"}, "signatures": {"localhost": {"ed25519:a_DTGV": "O5T2NzpskROm8OHEbXcDjmGYwGjCuSy5QesVpU1M5NbKpBr9/67flJuFAdyLzwBr5GT7Nn5WZ0azC1GzXZr3Ag"}}, "unsigned": {"age_ts": 1547280816844}}
$1547220105120XlrPA:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220105594.0", "stream_ordering": 120}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220105120XlrPA:localhost", "origin": "localhost", "origin_server_ts": 1547220105629, "prev_events": [["$1547220096119DwtHP:localhost", {"sha256": "w0XBXucDNqgVeoQYN35F8xVnIgLR+MWrFI+aKe8M12Q"}]], "depth": 106, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "cbG32vrkaYlZ+hnHlZayPsxdLq30yT4cMARFjRKoCwc"}, "signatures": {"localhost": {"ed25519:a_DTGV": "gcf2kC8VyQsOnTtDqO14sc+9eWhlSvfI560Rc3YKYlS3ywUiDY6/sgRcaPEaoWYYwXz2En2vU33/GE8kl5M/Bw"}}, "unsigned": {"age_ts": 1547220105629}}
$1547220182121VEzRa:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220182773.0", "stream_ordering": 121}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220182121VEzRa:localhost", "origin": "localhost", "origin_server_ts": 1547220182801, "prev_events": [["$1547220105120XlrPA:localhost", {"sha256": "KN9HEQW90Ee2w6kR2QxFOEVtBIeidk6vX42NEQQQ1FM"}]], "depth": 107, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "lQgTC4z6gWWcoLQjj3Gq30vCYMgMQ+/rcq+HQAYX5bs"}, "signatures": {"localhost": {"ed25519:a_DTGV": "pOLs/5XABxWs7ldSw27+21454d+3pbct4jQ3JhW8bArRKhVyHJ744o+8Sqyku7Qn2valwvSCS5xrKGy8XMVIDg"}}, "unsigned": {"age_ts": 1547220182801}}
$1547220193123fBQYD:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220193414.2", "stream_ordering": 123}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220193123fBQYD:localhost", "origin": "localhost", "origin_server_ts": 1547220193448, "prev_events": [["$1547220191122fXIkm:localhost", {"sha256": "MWGVRhcEZePW9XLS1aktW1zfcc1jAwkD/DVFwJC3dek"}]], "depth": 109, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "6TpW7InACjcWWJOt3fd1UTwL/itwsAUhxtv4V8rcRhw"}, "signatures": {"localhost": {"ed25519:a_DTGV": "pjjZW0HoNdxlY/TocEoh3WM73rfLMHTOL22Aezveye6zKJ2e2a94sYIDPV2qxKyKDonfax0SHya00uJcElpSBw"}}, "unsigned": {"age_ts": 1547220193448}}
$1547220199128EKqcd:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220199597.7", "stream_ordering": 128}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220199128EKqcd:localhost", "origin": "localhost", "origin_server_ts": 1547220199631, "prev_events": [["$1547220198127qDjZB:localhost", {"sha256": "fkYBzHCsB4ihkhR7443Y1c4qW3XI09kz00/QdhVNV/w"}]], "depth": 114, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "ykKC/5ah66aCXwJuetdCfdHGUZ5niLy0B7ZSqe1K22s"}, "signatures": {"localhost": {"ed25519:a_DTGV": "f+qs4obSG9ojplkt5HTYYKSzNx8K00CJXcy5s+yAgZQcEn3u9vHpibL50eGeoDxSKHDX7o8MQNQgKDag+ObIAw"}}, "unsigned": {"age_ts": 1547220199631}}
$1547220219130eqWPP:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220219342.0", "stream_ordering": 130}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aeou"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220219130eqWPP:localhost", "origin": "localhost", "origin_server_ts": 1547220219400, "prev_events": [["$1547220200129xNEFN:localhost", {"sha256": "rLibM8dUU/FUX0K9NMCB3F7UG2ODsUm2YNAYXPx1t8A"}]], "depth": 116, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "oTl2eiVe1hRqWiHK8YVEUPnHQkZMwD0W1Ql/QTi0B6s"}, "signatures": {"localhost": {"ed25519:a_DTGV": "dZLd71oN2HLccXnjXYKzWazyLqSbQizUWP8hE7Mp+ray+hc72KseTFrMhei/xf70QKzXAeYOLMKys9XVVwc/Cg"}}, "unsigned": {"age_ts": 1547220219400}}
$1547220258132jXsNq:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220258001.1", "stream_ordering": 132}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220258132jXsNq:localhost", "origin": "localhost", "origin_server_ts": 1547220258037, "prev_events": [["$1547220236131oUTpn:localhost", {"sha256": "Db2gUUGYKfFvZ4GJOBJT/rGqjnaFMhhr1MYp9QCaMgg"}]], "depth": 118, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "vqKfFQpH6Nn3CPeJUFdWLeoGfnAVhEPlDecwrK5OqFs"}, "signatures": {"localhost": {"ed25519:a_DTGV": "PvHXhL99DGQFEP3ptsXoi2F5zua/iKHbS1haqnD+TuCtqwr+baH4ixwhASzFgKDz65I1PMastPz2BX+ylgS+DA"}}, "unsigned": {"age_ts": 1547220258037}}
$1547220334136ylgXz:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220334810.2", "stream_ordering": 136}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220334136ylgXz:localhost", "origin": "localhost", "origin_server_ts": 1547220334846, "prev_events": [["$1547220332135nCFHQ:localhost", {"sha256": "8+KiG8Vb+UwQE7cCKqAQohvFk+6IxB50HGZDd+26VhM"}]], "depth": 122, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "jwKvMt9iXvdFoY4BsK2qhVmag/l/FeN33XKWwB7LPBE"}, "signatures": {"localhost": {"ed25519:a_DTGV": "w2xUcYs/UdCDKVa6IWNQwf7z7iRgyYQ0sXOwI4RrHTppG2f1f73GnEYitG9DHpP8CPCBDJ1NZZzNemVSPdPZAA"}}, "unsigned": {"age_ts": 1547220334846}}
$1547220191122fXIkm:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220191670.1", "stream_ordering": 122}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220191122fXIkm:localhost", "origin": "localhost", "origin_server_ts": 1547220191706, "prev_events": [["$1547220182121VEzRa:localhost", {"sha256": "F/VLtwsP76SES7xpYbIwsj0Q7J/7ksYneNgIbskg5vU"}]], "depth": 108, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "9eH25/vWNOuU7HXgierJlGEeAC3IB5hURG+cz7iCeZA"}, "signatures": {"localhost": {"ed25519:a_DTGV": "+rjwl/XqhHu48EvobcW7RQGcnkhlhClrtSUd42TomM670qLMXhL4vHIM6BLJR9XXneaCtZ+yaXo2I4bjBpY7Ag"}}, "unsigned": {"age_ts": 1547220191706}}
$1547220194124AQdWA:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220194705.3", "stream_ordering": 124}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220194124AQdWA:localhost", "origin": "localhost", "origin_server_ts": 1547220194742, "prev_events": [["$1547220193123fBQYD:localhost", {"sha256": "knbmwr7AoBxu4197v5VFx+n4STdCGFQpL5foWdvxf7Y"}]], "depth": 110, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "JDsLSXBJE84StDeJRjjiFSipcIeJFl8RtLBPrM8lHN4"}, "signatures": {"localhost": {"ed25519:a_DTGV": "RnkoZw6+WzyluMSGNH+/UW8L0ZWSK9qCr+qIbJcAE+wIrTnUvpS/OTowzZkpPJpg24NWDx/BGMKa3Lt5waaSCg"}}, "unsigned": {"age_ts": 1547220194742}}
$1547220200129xNEFN:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220200791.8", "stream_ordering": 129}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220200129xNEFN:localhost", "origin": "localhost", "origin_server_ts": 1547220200820, "prev_events": [["$1547220199128EKqcd:localhost", {"sha256": "ooPJ7UdiI9IX/GPZeQ6SFwypmWMZsKnbqf6vI49zUBI"}]], "depth": 115, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "qPUdxJLxKo/BtD4i1+DIoBaZoA4l8w/rMT65RtgTIVk"}, "signatures": {"localhost": {"ed25519:a_DTGV": "ONAU4T1kRJs5n+/wVXvSsFCJR+AFylyljmmHzLMzonXQ90pi42AKx3ZBdVZhgau3Fdvj/BlLJpXipj16hoBAAQ"}}, "unsigned": {"age_ts": 1547220200820}}
$1547220332135nCFHQ:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220332642.1", "stream_ordering": 135}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220332135nCFHQ:localhost", "origin": "localhost", "origin_server_ts": 1547220332678, "prev_events": [["$1547220330134ibkVz:localhost", {"sha256": "lRQ67kx5+9JsFK2aLJ45WhQP6RFHmHwtoUThF07//sg"}]], "depth": 121, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "dNkvj3UpYvnh3XVK+MFC11i4mLFzMYboJibptoAvv2A"}, "signatures": {"localhost": {"ed25519:a_DTGV": "wnJQPIafmnihDG+rkuYgCWEUe9QiIMvRK49dpzxr+qRH5pFlyIddZ1CdPy82COYu44MpiWaxuJFuUWGQwSyJDA"}}, "unsigned": {"age_ts": 1547220332678}}
$1547279186145UMjYo:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547279186622.3", "stream_ordering": 145}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "data"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547279186145UMjYo:localhost", "origin": "localhost", "origin_server_ts": 1547279186657, "prev_events": [["$1547279185144ElypB:localhost", {"sha256": "Zn+nc86mGS8Ja0+EUJ+7KPBBAmLnd9llPlueZEB3nn4"}]], "depth": 131, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "0K6vWZo8q2JzkLZDHZOZrds7B43RvSVkOWvktoFvNds"}, "signatures": {"localhost": {"ed25519:a_DTGV": "iV2rULnL8PjKvw6h9/5ItOqQ9aL8wtn5UYw1C3upd1aGNUjwOtEasQg9SNhqC665K0OL6GmddlputZxC8YQhAg"}}, "unsigned": {"age_ts": 1547279186657}}
$1547279319149EgmWE:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547279319286.0", "stream_ordering": 149}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547279319149EgmWE:localhost", "origin": "localhost", "origin_server_ts": 1547279319332, "prev_events": [["$1547279190148LahLH:localhost", {"sha256": "oTQY9MLBWHTvgRkEZT0xkitZ4Rxfmo+0/k/cPPPSOz0"}]], "depth": 135, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "zPvfkyqayvvXRatfuTfVNu0Mt5az5SMWkFoDCeNRVco"}, "signatures": {"localhost": {"ed25519:a_DTGV": "aUxkZn0UHGua7tL1BbjUhr8X8VZ+igSrPSL4NhEwkb9X9ltFTPySzTXcb0+WAn57wgVT4qQ/bvn+T1eugcoPBQ"}}, "unsigned": {"age_ts": 1547279319332}}
$1547279321154qYYIA:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547279321545.5", "stream_ordering": 154}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuaoeuaoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547279321154qYYIA:localhost", "origin": "localhost", "origin_server_ts": 1547279321588, "prev_events": [["$1547279320153eLKOp:localhost", {"sha256": "ngt8Gjj7KK2YtFWcdUEvdVrn0PXmqI1vEZQE/SlPOhg"}]], "depth": 140, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "vRmMfeB+7pHTPIsMNdd3U8dcH3kAWaWosOVXFIYcT3o"}, "signatures": {"localhost": {"ed25519:a_DTGV": "WUjgmeaLILXBwSOEbKvUtdb9FgRfELoG6oeKmACB/uxXnTKNv2Els0tCfkqDz42eXrRiVoRInAmH4dgTMZwlAQ"}}, "unsigned": {"age_ts": 1547279321588}}
$1547220196125pygpM:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220196140.4", "stream_ordering": 125}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220196125pygpM:localhost", "origin": "localhost", "origin_server_ts": 1547220196174, "prev_events": [["$1547220194124AQdWA:localhost", {"sha256": "uOqihDRkrvRiQPc/TKcQTpDSkY8lJeTDdq3F5qEIHFo"}]], "depth": 111, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "OitibyXfLj+PKw/1QqP/ywa13yudrZ4CWHAP/VC4YeQ"}, "signatures": {"localhost": {"ed25519:a_DTGV": "FtcOyyyHFcT9ODSiyrQHWxiGiOwOCNoQT3URudX04/nJZSpg/ikQmeImOiXTg7qxtlsB3ISFXY0GE49Zo2/XDg"}}, "unsigned": {"age_ts": 1547220196174}}
$1547220198127qDjZB:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220198428.6", "stream_ordering": 127}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220198127qDjZB:localhost", "origin": "localhost", "origin_server_ts": 1547220198460, "prev_events": [["$1547220197126rpVNs:localhost", {"sha256": "Qdelb+8vPTdSvrznZlDlqYpSD+ZeyZma7XN5opTwSd0"}]], "depth": 113, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "pAhLUYcELSrHUOHmxVfargDx3SPwkAj3twvIYnpuAv0"}, "signatures": {"localhost": {"ed25519:a_DTGV": "tZRxd0nTMZYQttoXACw7gz21G8idiBBvijS80iH4mfbUdSqMemU6Ad/Tc226HupDbKN6gB/CoK07rspypigzCQ"}}, "unsigned": {"age_ts": 1547220198460}}
$1547220236131oUTpn:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220236637.0", "stream_ordering": 131}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aeou"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220236131oUTpn:localhost", "origin": "localhost", "origin_server_ts": 1547220236656, "prev_events": [["$1547220219130eqWPP:localhost", {"sha256": "Wro37HWj44PWisFK/lpfcy7T7oEPrFDJbOJ/ErUP3xg"}]], "depth": 117, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "TlIP/iaZsTFDnT7jyu0b0YOizG5FST5gMW0PuC1XcVE"}, "signatures": {"localhost": {"ed25519:a_DTGV": "ClMmaRQo7kW6CTXg5aN2LxkyCbfWQQkyuiDjNZg1xRDmbu/xgGc5VSl+oSGJfFjVp6pTjGpkznL1dl8IpH5NCQ"}}, "unsigned": {"age_ts": 1547220236656}}
$1547220271133nWAgW:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220271653.2", "stream_ordering": 133}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220271133nWAgW:localhost", "origin": "localhost", "origin_server_ts": 1547220271683, "prev_events": [["$1547220258132jXsNq:localhost", {"sha256": "gZNgw6OI08GG2ZClayjfmZ+o3ghDKJQf0HYd2gCtIsQ"}]], "depth": 119, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "AMrvDsA/VrGcU7uhbP1b9NFqJDGiPcRORr2uRHofjQY"}, "signatures": {"localhost": {"ed25519:a_DTGV": "hgxk2I8uSiAVvG0cZpF3cua/IjLBAPIFlB2BIE622usHygbyASk87OabfBDcEfFYH86DG6FjyY3wxaO3yZPbAQ"}}, "unsigned": {"age_ts": 1547220271683}}
$1547220330134ibkVz:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220330381.0", "stream_ordering": 134}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220330134ibkVz:localhost", "origin": "localhost", "origin_server_ts": 1547220330417, "prev_events": [["$1547220271133nWAgW:localhost", {"sha256": "K4sHZcUpYDebOAD3ZXQu/QN2ENzGzT1U0uREkV3oWP0"}]], "depth": 120, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "chVDVbMTK0tvO7e9RXKusQj9lnPPMw1C2rF+qsImUF8"}, "signatures": {"localhost": {"ed25519:a_DTGV": "8VApoCpQTwjsXc+vM1xyHA6S4y8E72Bv1vJBlrVCgcVb9VxqMkZYtDa6QsOThCVxPjiEC/be8k/lHP3MhvtpAw"}}, "unsigned": {"age_ts": 1547220330417}}
$1547220336137dJMop:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220336534.3", "stream_ordering": 137}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220336137dJMop:localhost", "origin": "localhost", "origin_server_ts": 1547220336569, "prev_events": [["$1547220334136ylgXz:localhost", {"sha256": "DVKfcpkrBZOmxRsFxtAZZq9g25RlJ3mm/8fA0Yc5M4c"}]], "depth": 123, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "Imx9Y0eiXGVvL5el8u55RvLxpInQOvX89em7s2Wbufw"}, "signatures": {"localhost": {"ed25519:a_DTGV": "r/VeaIKT0AQbRfSK7hiWXcpe6Qg8LUsCmS49Lt+H31AMfTIWq3GvJM1gZDioq7BuuWsbjemMAHcnP4YJgNR0Cg"}}, "unsigned": {"age_ts": 1547220336569}}
$1547220337138tFafe:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220337948.4", "stream_ordering": 138}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220337138tFafe:localhost", "origin": "localhost", "origin_server_ts": 1547220337984, "prev_events": [["$1547220336137dJMop:localhost", {"sha256": "mATL/3s2AJlp/FR4TBSYB2Miq3u8mBjwSrcF4/Gc0nc"}]], "depth": 124, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "PUthdnuZuK7ybNbJKEzpqOprQt0X966r4ecBmb0EFKM"}, "signatures": {"localhost": {"ed25519:a_DTGV": "aoZbs+fmVzK3KBnoyaHXsz4MZqAL97qPFbDvCDJC6NTWnF4mlB78lY26PlViqPf7fUoE39j0VgMcxcwjdVVJAA"}}, "unsigned": {"age_ts": 1547220337984}}
$1547220358140eyxTo:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220358160.6", "stream_ordering": 140}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuaoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220358140eyxTo:localhost", "origin": "localhost", "origin_server_ts": 1547220358197, "prev_events": [["$1547220342139OPXTO:localhost", {"sha256": "Oq7EKfU5u/PwFs0xWQI3UK3uY+cO6XGoFhqts0MO72k"}]], "depth": 126, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "qTmGZAWyEihQZ2B1/vc7H48p9LoTJ5raTMAu+ah8iA4"}, "signatures": {"localhost": {"ed25519:a_DTGV": "xuDaacDNZFsTzMgbNDZUu/4OXa/VJ3cgtNpX6RE5NWUFk/gKHM1AvIPy6On5xNfI74RYSnloFvT00ug+hpFgAg"}}, "unsigned": {"age_ts": 1547220358197}}
$1547279334159OmRvd:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547279334030.4", "stream_ordering": 159}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuaoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547279334159OmRvd:localhost", "origin": "localhost", "origin_server_ts": 1547279334068, "prev_events": [["$1547279333158JjmRS:localhost", {"sha256": "77ACxL079bO0nroIHkLNnpiIKdb3JdglNvEmicioqb4"}]], "depth": 145, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "ocywNKs7y4dNsgu2ILBSWu7DdU8vN6J2xCm+cDIvR/8"}, "signatures": {"localhost": {"ed25519:a_DTGV": "Hp6tYJVzkjnImMTvjnxGL17Kv7n5hz+4tUFlcDOJPK+3nm4AouVXMNdOyZPiZrQydrWEcvBnyk1wizH4bvk2Aw"}}, "unsigned": {"age_ts": 1547279334068}}
$1547280627161jyqzw:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547280627819.0", "stream_ordering": 161}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547280627161jyqzw:localhost", "origin": "localhost", "origin_server_ts": 1547280627840, "prev_events": [["$1547279335160XSwVw:localhost", {"sha256": "GKVr2PPuhhyT/TZnah9pdoN7q8ZufyeEPiH3WNaJ4ew"}]], "depth": 147, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "zso11ULPShjkreNVjwgISRjUNyYn/RSCX0KmOXhQLUM"}, "signatures": {"localhost": {"ed25519:a_DTGV": "L0I3MAW4ft3Seq7mY4HN8yb7Qbf03jTlH+u+sXnzLLzE+RafL3Iap7D9IaqUo17GSMM7Hkzs/C+4EekJNBLkCA"}}, "unsigned": {"age_ts": 1547280627840}}
$1547280712162vCSiP:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547280712954.0", "stream_ordering": 162}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aeou"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547280712162vCSiP:localhost", "origin": "localhost", "origin_server_ts": 1547280712991, "prev_events": [["$1547280627161jyqzw:localhost", {"sha256": "dsVYyk9ppwlegZeq/k5Yjj2oeKJXyxayQSqDGjbw2cc"}]], "depth": 148, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "MnAU1tAl477NE2nNTfH1Q56ThEwNEXdN4G3Q59qgBkc"}, "signatures": {"localhost": {"ed25519:a_DTGV": "RRcrvm846IkML+Oe8BvXi3o5Wr/VfT/7QTXT3UtOFTnEn2Pnhgg52aRT6OBi/wPbivH1I7aeRPLYb3X16StuBw"}}, "unsigned": {"age_ts": 1547280712991}}
$1547280737166XHlsG:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547280737149.1", "stream_ordering": 166}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547280737166XHlsG:localhost", "origin": "localhost", "origin_server_ts": 1547280737186, "prev_events": [["$1547280734165AejNq:localhost", {"sha256": "QtjUc+J79qwaF5+sxqzYboHcgjOePmBEi2eLI+YK+YI"}]], "depth": 152, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "iRXv7FVYoV9B/yhkESKl29JvZljOPBYnm+jJSsd3c9c"}, "signatures": {"localhost": {"ed25519:a_DTGV": "4Hqmr9993Ps+W4QYGUbAMYjnmkMKxaARTVDFneh66U555Fzyq7YR/FdYKxfBFciJXKWept+p0Bs6ip7yCaLCCg"}}, "unsigned": {"age_ts": 1547280737186}}
$1547280758169QBLYK:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547280758037.2", "stream_ordering": 169}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547280758169QBLYK:localhost", "origin": "localhost", "origin_server_ts": 1547280758076, "prev_events": [["$1547280755168RTqof:localhost", {"sha256": "UI/VkaxSLRjclKb0kMayz0xLxLsVfeENvUl87CHOepU"}]], "depth": 155, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "jOxSowX6YXlRjU8pccerTX7fKtCnmm++6zlnRra4qN0"}, "signatures": {"localhost": {"ed25519:a_DTGV": "1c+8rWv+2WliQieG+x7beXfk1wtMAZ74Nu481IXbfeTnthA5Ez9TGa4nTVD1O/b6UeJz6OKFBaeMz8NCAxPrDQ"}}, "unsigned": {"age_ts": 1547280758076}}
$1547280764171pBzRc:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547280764950.4", "stream_ordering": 171}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "some"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547280764171pBzRc:localhost", "origin": "localhost", "origin_server_ts": 1547280764990, "prev_events": [["$1547280759170XdQji:localhost", {"sha256": "mHtcVhrWpJmkQu9UhC7JL2p9UcJom+RSYG6G553nhqs"}]], "depth": 157, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "o5d0EdZWCNrYd1LIRlxIJdIyfJ2InDcc+Z1oqyf+LGE"}, "signatures": {"localhost": {"ed25519:a_DTGV": "z+fMXp28Hse/ll0R6QNF28uimfzK5KHAHVNsYW3t+C74f2kF8aBeJI3FMTy0pyo2eCjr6p0hZErGg6qFymOeAQ"}}, "unsigned": {"age_ts": 1547280764990}}
$1547220502141QlNvD:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547220502248.0", "stream_ordering": 141}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547220502141QlNvD:localhost", "origin": "localhost", "origin_server_ts": 1547220502284, "prev_events": [["$1547220358140eyxTo:localhost", {"sha256": "5Ls+8iup7lPQSq7D2ki1Wppd3+9wtziLDjps1AUxQUE"}]], "depth": 127, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "h2oUXoJYBbLU5Itj99GZd6O+xfkKis3L5tfOMryOwnY"}, "signatures": {"localhost": {"ed25519:a_DTGV": "GQYc6rG1CEXc0Rj+FxL5scm79DVapn5yS2fxan04+FABWrcLgryu3ljWHmuhfElVmyPw6U7uPz64Gy08R2W9Cw"}}, "unsigned": {"age_ts": 1547220502284}}
$1547279183142YOhis:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547279183350.0", "stream_ordering": 142}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "hello"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547279183142YOhis:localhost", "origin": "localhost", "origin_server_ts": 1547279183389, "prev_events": [["$1547220502141QlNvD:localhost", {"sha256": "iTJ2celQyVUy876mlmcZQoYy3cdBa/leP6jxebIoofw"}]], "depth": 128, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "sXHxmksbstguXmBsU+u/nOhjzEHgY0ShbB9OSRoNU4E"}, "signatures": {"localhost": {"ed25519:a_DTGV": "DBl7fkD2MOPpnObxudyihX2asN9CWDxgxrEp+5NE7GmrJMI7btkGlrCKt8wf3RZSCs0w7FHVa4k8W6y8QkaGAA"}}, "unsigned": {"age_ts": 1547279183389}}
$1547279185144ElypB:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547279185588.2", "stream_ordering": 144}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "some"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547279185144ElypB:localhost", "origin": "localhost", "origin_server_ts": 1547279185624, "prev_events": [["$1547279184143GVbKe:localhost", {"sha256": "viKQCM+RbF9HbUbiKJtHuReLVPAFf97VFNvXAuul+18"}]], "depth": 130, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "FkwnyosaDtoS5M3DOA476POoPm866YaZfkKEb02iheY"}, "signatures": {"localhost": {"ed25519:a_DTGV": "wCb4pKUFG3riB4psU46g+5NTib25EMi6o6+tCWUMGho2TZ8ta/vDkFU7O0Nh+wduk8NvUmTguBcnklCe3JqNCQ"}}, "unsigned": {"age_ts": 1547279185624}}
$1547279320153eLKOp:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547279320453.4", "stream_ordering": 153}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547279320153eLKOp:localhost", "origin": "localhost", "origin_server_ts": 1547279320531, "prev_events": [["$1547279320152DJzGw:localhost", {"sha256": "OtrM2JEB4c8iVCpLGHbXn4sVMN7/VwSUqokOtWgq/S8"}]], "depth": 139, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "mB4Gti8C2RbjQcD6zwko3x8J8PjAaONHRAyiniiz2Iw"}, "signatures": {"localhost": {"ed25519:a_DTGV": "huLGDE0Pi2Qp7alOVJQG9MR9d9bIzaAwMYSzcZnTg7QsTjAmQmPEgIY5juwqmyCfzYLVS8GAsteDkPDuZrHHBQ"}}, "unsigned": {"age_ts": 1547279320531}}
$1547279332157nmQRp:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547279332554.2", "stream_ordering": 157}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuaoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547279332157nmQRp:localhost", "origin": "localhost", "origin_server_ts": 1547279332580, "prev_events": [["$1547279331156JREIt:localhost", {"sha256": "GRD8BT71F+WI8SYPYISWubgVXPhpV8IG231Oa/ez9tY"}]], "depth": 143, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "DXmtfbpF+WbTB0TYyDwsmibY+n99Pf6/iZRlbLI9x3g"}, "signatures": {"localhost": {"ed25519:a_DTGV": "6TmH+G6bx5jlRD3WYF0euG4Dg38ps9ymeZKN10S0lT7K87/7twKdEgpx4YWKxkreruGwK/cLXMxYHtnP6IjCAw"}}, "unsigned": {"age_ts": 1547279332580}}
$1547280753167iiLNC:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547280753206.0", "stream_ordering": 167}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547280753167iiLNC:localhost", "origin": "localhost", "origin_server_ts": 1547280753243, "prev_events": [["$1547280737166XHlsG:localhost", {"sha256": "d/xj7LCHl4KlDyxmvcayz4XuHeSqcz1kNGQp7MOeHn0"}]], "depth": 153, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "gFsVjDK6zryEMPJe+8SCcbjW2fWD95PskGdWhsMl/9E"}, "signatures": {"localhost": {"ed25519:a_DTGV": "DAgHQoCTFsyEHz3jPt+/QcxnuLENjptOCKym+38aShVkIEfWWNcYAZtoCqFviN4pdx+CEKdN8SDHwnuFigvyAA"}}, "unsigned": {"age_ts": 1547280753243}}
$1547280856175DGEZm:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547280856571.0", "stream_ordering": 175}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547280856175DGEZm:localhost", "origin": "localhost", "origin_server_ts": 1547280856607, "prev_events": [["$1547280825174yozNU:localhost", {"sha256": "pRyU+FKhkSU5MNM8FvgMSbo3G/qrPcWghigGrMKBlLU"}]], "depth": 161, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "hogVb2dMua17YM7CcebaCaqxFpTVVRQCKc7lf2P7Xlk"}, "signatures": {"localhost": {"ed25519:a_DTGV": "txewd6JgPo8WGYAfHOrnxgYkwlbafPXTG6PKYMHGcc+U8vIyggDIen+OrLiPNgd6k7BUgOp2iTnbfyfGrKLACQ"}}, "unsigned": {"age_ts": 1547280856607}}
$1547279184143GVbKe:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547279184648.1", "stream_ordering": 143}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547279184143GVbKe:localhost", "origin": "localhost", "origin_server_ts": 1547279184680, "prev_events": [["$1547279183142YOhis:localhost", {"sha256": "T1C55th80B9VpQwtKLMxCVp5IPL+xuivq37God7VvWs"}]], "depth": 129, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "CV4g2u8Z8+I4B9i6PAfCbReF1Pf9QUzNmO3hZEvGZTs"}, "signatures": {"localhost": {"ed25519:a_DTGV": "gZdM99kiLCbdpjwOw84XaDcHpkN1jmz2COu0CbEqS15cMZY0F76oJN7JwXPnQdZieFG4hsr47PkJ2FJlRwHRDw"}}, "unsigned": {"age_ts": 1547279184680}}
$1547279320152DJzGw:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547279320162.3", "stream_ordering": 152}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547279320152DJzGw:localhost", "origin": "localhost", "origin_server_ts": 1547279320178, "prev_events": [["$1547279319151MaOud:localhost", {"sha256": "p35LBq3lIqTUQ4PnuI5zcVp1yLYWggNcJMtOkY8e0iU"}]], "depth": 138, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "hrWDo6OFGt8IsRBkBLKB4J4HI4+aePvuT5MgxrTa0yc"}, "signatures": {"localhost": {"ed25519:a_DTGV": "s2X5UGBIIgbUIyfPjOkgxfsr96OpTyBvKQQPEc4bICF9fAfinfPPLV+5ri5IFPK4tP2ljTNMAW2vBinTdLq8CQ"}}, "unsigned": {"age_ts": 1547279320178}}
$1547279331156JREIt:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547279331862.1", "stream_ordering": 156}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuaoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547279331156JREIt:localhost", "origin": "localhost", "origin_server_ts": 1547279331898, "prev_events": [["$1547279331155MIaaY:localhost", {"sha256": "lNhtLeaF5PKiVuWzRTUjp2fovzjW342BMM3/zXjmbIk"}]], "depth": 142, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "V4Xds2YOUz9iz6IhYF8aNNzwi2Fv1HHeyrsR8nz+eK8"}, "signatures": {"localhost": {"ed25519:a_DTGV": "ubFsXrYfMyvBEMPmBvVZMu8jQKTeteyGgU5OxIEvvzAlr2XrInQQD7LJzbSMKehDIuYpC4ZucXXKwkrIG2GOCQ"}}, "unsigned": {"age_ts": 1547279331898}}
$1547279187146HVLNT:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547279187563.4", "stream_ordering": 146}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "other"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547279187146HVLNT:localhost", "origin": "localhost", "origin_server_ts": 1547279187601, "prev_events": [["$1547279186145UMjYo:localhost", {"sha256": "FeoW3jUI+Nz+KnU2Wgku5N9fy1FjtkvyN5DxSzpFVOE"}]], "depth": 132, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "caVa16JEn1qcP1fCP1NrwMqGb4rFKD2lpT1N7jgLYyA"}, "signatures": {"localhost": {"ed25519:a_DTGV": "iHBo4oU2srivaXel+LzIuK/Q2KBETR9TY0dHKtpresEYlCbJQPG45jzi8lTSlgJGfueiMBbJOy19DyJ6wuuWDw"}}, "unsigned": {"age_ts": 1547279187601}}
$1547279319150fMLrf:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547279319770.1", "stream_ordering": 150}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuao"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547279319150fMLrf:localhost", "origin": "localhost", "origin_server_ts": 1547279319858, "prev_events": [["$1547279319149EgmWE:localhost", {"sha256": "/cegEemrRa5wd5g4e8spJ/yGo1GDGmuasmhW7sOaCcQ"}]], "depth": 136, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "wgK9W4NvbLYkdAMieMyc1GGqUoQybkUFOqX8bPyEmVQ"}, "signatures": {"localhost": {"ed25519:a_DTGV": "OSxYebVm3cZAS12Rl6JraaXrOHaRNQ10nP793kVIwCd+gP4jqU9WZhB0W7omv8k4CbOyETaR//T8YuC29AbBCw"}}, "unsigned": {"age_ts": 1547279319858}}
$1547279190148LahLH:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547279190085.6", "stream_ordering": 148}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547279190148LahLH:localhost", "origin": "localhost", "origin_server_ts": 1547279190117, "prev_events": [["$1547279189147gYZsO:localhost", {"sha256": "8WbOJQJ7kFNk4ClqVwPCUBlyWF3ir+ro381KX8oykt0"}]], "depth": 134, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "0ZvVsKvHF4yRiib5fyX8UkDBD/XtkbbsEWdzOpv9/fw"}, "signatures": {"localhost": {"ed25519:a_DTGV": "b02ZF1RLYA6hADkMVw23JsZ9CZoTnLjNLceqHHXqQ80Y574DeGse/huqEPfsNML2uvfuVM6b1isP7arPWHcuDQ"}}, "unsigned": {"age_ts": 1547279190117}}
$1547280717164BqYSL:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547280717098.2", "stream_ordering": 164}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547280717164BqYSL:localhost", "origin": "localhost", "origin_server_ts": 1547280717134, "prev_events": [["$1547280714163OzTSL:localhost", {"sha256": "U365rKE4lYmk/8CZ7wHMcQg2O9MPozBJfw4YITsx/Mk"}]], "depth": 150, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "gdclCDLinJ6Pglg17M72MnM8j0JsxEIt5kj1TRPvUWg"}, "signatures": {"localhost": {"ed25519:a_DTGV": "x+3JPyaHweYlVs5HdT+pJ3JXGdtDAx9YRPhMyIKam03KC+/wdNxVVfl6YMpvrabAsMb2FzGOkuQvu5D4Jsy6AQ"}}, "unsigned": {"age_ts": 1547280717134}}
$1547280820173UXJMb:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547280820050.1", "stream_ordering": 173}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "some"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547280820173UXJMb:localhost", "origin": "localhost", "origin_server_ts": 1547280820088, "prev_events": [["$1547280816172DhRcw:localhost", {"sha256": "oigjhFa5Sk/ZKJjAogXECy2H48uueV4WqTIOMGUyEZI"}]], "depth": 159, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "G8FS/evK2YDbtLSC0huTF7cLCoTJFIM3ed73+DTMhGg"}, "signatures": {"localhost": {"ed25519:a_DTGV": "pRtlM/eUqYl33U4pTdlazrWGWFixdzWBVZi6iMAd+DHSXnoybXSqZHJYz/quEHnWMp7rAH9vwgV9GiQe7PNNAA"}}, "unsigned": {"age_ts": 1547280820088}}
$1547279333158JjmRS:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547279333286.3", "stream_ordering": 158}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuaoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547279333158JjmRS:localhost", "origin": "localhost", "origin_server_ts": 1547279333320, "prev_events": [["$1547279332157nmQRp:localhost", {"sha256": "8vT9lU4FqSc9VdgD6gf5bA1P08cBX/iPrAhYc6eBJN0"}]], "depth": 144, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "fUhhl2o4/aQ6LW1JNEFOv30H2rPSPeCPOQytAOo+Rok"}, "signatures": {"localhost": {"ed25519:a_DTGV": "5s9VDK5MB1C0cqnVdV8i5ASkFfAa/L97XLwNsQSZFR1pH42n4aTBMUdZgHCebgJCx+6ZXhTEjSEQ9JUL9TuRDA"}}, "unsigned": {"age_ts": 1547279333320}}
$1547280755168RTqof:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547280755737.1", "stream_ordering": 168}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547280755168RTqof:localhost", "origin": "localhost", "origin_server_ts": 1547280755776, "prev_events": [["$1547280753167iiLNC:localhost", {"sha256": "EGqKlesjWv6m9iyUvD/pl9TWRSarV/PskBxm6NMB6hI"}]], "depth": 154, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "b0P6HLuZ3hcy6K4+J25bxt/W7UkhsRleKf8XmvxYr40"}, "signatures": {"localhost": {"ed25519:a_DTGV": "vXLwOfN0mBkspbWMj7R+3yI0oINEfGJeMCI3zGZdU7DSEF2y82g9oD+lEjRN9KodAsipRMvDP+bbtSkuL79DBw"}}, "unsigned": {"age_ts": 1547280755776}}
$1547280759170XdQji:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547280759900.3", "stream_ordering": 170}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547280759170XdQji:localhost", "origin": "localhost", "origin_server_ts": 1547280759943, "prev_events": [["$1547280758169QBLYK:localhost", {"sha256": "y/LZmwDE+dC/dv5tERkofRV1JqFy/dyc8MwM+IKU+y8"}]], "depth": 156, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "BguDei0INkvH7HWc3adIAgPbJQmHllkizwzt/hXkwRU"}, "signatures": {"localhost": {"ed25519:a_DTGV": "MoUNQyr/4vnVG8BMLBTn9JdA+/TlamVV+40s6jYE2VqIKRVyTVbiqnLQPtrhU97U2BY65lI9vHuwzeWFxEc7Cg"}}, "unsigned": {"age_ts": 1547280759943}}
$1547279335160XSwVw:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547279334979.5", "stream_ordering": 160}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuaoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547279335160XSwVw:localhost", "origin": "localhost", "origin_server_ts": 1547279335019, "prev_events": [["$1547279334159OmRvd:localhost", {"sha256": "0s0LUabeh7T6cuBt1ekhxd7hDCW/kQRlbVI9g6Kfx9o"}]], "depth": 146, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "JQ89TnPW6vHjyNMp72/3N7WKH0NBfWcbtgoNMl6OTKk"}, "signatures": {"localhost": {"ed25519:a_DTGV": "tfV57Ln2GaG6RRa/AixR4r0rHk8NQ6q2UP4pg/X99K7tpOyovHB7ktNA6Q2ra5Xg06I7vCxM8tEp280w9184BA"}}, "unsigned": {"age_ts": 1547279335019}}
$1547280714163OzTSL:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547280714727.1", "stream_ordering": 163}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aeou"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547280714163OzTSL:localhost", "origin": "localhost", "origin_server_ts": 1547280714769, "prev_events": [["$1547280712162vCSiP:localhost", {"sha256": "kxHhVgd59Tj/buh/dLaZOEY6BJKnmomcecwOP99CW0k"}]], "depth": 149, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "YnQay4hIKghjXshG4XvioecqB4rAv56ohaEwxFaOQYM"}, "signatures": {"localhost": {"ed25519:a_DTGV": "+x52lR5m2ysOaHK/meRbNp28d47qb5Z4tddM+wpdVXb3bo4fcdEASfhK1II2c77Df1ssBTey8OYz6Kc0qsMGBA"}}, "unsigned": {"age_ts": 1547280714769}}
$1547280734165AejNq:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547280734624.0", "stream_ordering": 165}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547280734165AejNq:localhost", "origin": "localhost", "origin_server_ts": 1547280734647, "prev_events": [["$1547280717164BqYSL:localhost", {"sha256": "0Jtc6mVcZx+BHGm0FaTHRhMWL4gXUVd/25ljVBQTqhU"}]], "depth": 151, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "pRy3pCapJtwAm9IKgocC3KQxI18UA2huZJcjTf/RM7A"}, "signatures": {"localhost": {"ed25519:a_DTGV": "1swneej27AYW80keu434t9WrA70DD5l0aU2bBM5zjcOT6EY+P2rLA6PpQ5Y6ig7R+/+Ydlr8rKBSB5tRFrlqDw"}}, "unsigned": {"age_ts": 1547280734647}}
$1547280825174yozNU:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547280825109.2", "stream_ordering": 174}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "others"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547280825174yozNU:localhost", "origin": "localhost", "origin_server_ts": 1547280825147, "prev_events": [["$1547280820173UXJMb:localhost", {"sha256": "rFEB3W64HuzMoRqP5JlJsrx+rTEQn8OFIeBWNWNyoa8"}]], "depth": 160, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "bDy9tHaeC4KDmvnbdVU+u6k20Pv18n301fk+2iHYGLA"}, "signatures": {"localhost": {"ed25519:a_DTGV": "bCrtVuFAxCwVBIuYi5vHu3D+meoO5QH40jOzKmZndghKN1gkx+fPdLtXILAtw6ct2kp3cLYxLK9wgzpirlGUCg"}}, "unsigned": {"age_ts": 1547280825147}}
$1547281038176RAJob:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547281038532.0", "stream_ordering": 176}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547281038176RAJob:localhost", "origin": "localhost", "origin_server_ts": 1547281038572, "prev_events": [["$1547280856175DGEZm:localhost", {"sha256": "a+9eaCHmXYB7+TVzglfuhqEtk63LP/sdFQfxMoGlaGM"}]], "depth": 162, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "t0QgGCKImX6aedjFz+aBxCyLOvlNQCQNSusqw8Dfmfw"}, "signatures": {"localhost": {"ed25519:a_DTGV": "upa5S2e9Kil3jEHcZJochxV/4rjJB64xv2cQbNM0cvhz3apM1Dq/2tdCooAdr7Ww2Mv5yWcRhQ+WmtYV0gB7Bg"}}, "unsigned": {"age_ts": 1547281038572}}
$1547281042177bmAPI:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547281042115.1", "stream_ordering": 177}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "other"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547281042177bmAPI:localhost", "origin": "localhost", "origin_server_ts": 1547281042153, "prev_events": [["$1547281038176RAJob:localhost", {"sha256": "QYqfP80qtt3sOqz/Vy5iB/aHxLP18B0ZtgVH4HPTfiw"}]], "depth": 163, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "Kt4D3znmZJWtfwdc6icAiyCo3oqAqmSXuj/JU3Ln22Y"}, "signatures": {"localhost": {"ed25519:a_DTGV": "TaCt72DWoX5gZAzfh+gaCITLtw5WITcwyG+zRM8HYyPOQVMNJUvaEle0atFz/3ry0U5kpI1alllWqhyARWoEBA"}}, "unsigned": {"age_ts": 1547281042153}}
$1547281644178FBthK:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547281644007.0", "stream_ordering": 178}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547281644178FBthK:localhost", "origin": "localhost", "origin_server_ts": 1547281644041, "prev_events": [["$1547281042177bmAPI:localhost", {"sha256": "757klvN8rD4kp4GJ5qgfVimIuqu0H5x5NNtG8wtzARU"}]], "depth": 164, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "dg1Zl78jzUHNPvrOlaaCNO6rc+zwNQP1KIIzKOcHPvQ"}, "signatures": {"localhost": {"ed25519:a_DTGV": "whyxTemHd4IxwZV2XCCtFy065035jQrk1A2+xtpTYlk9Ff6Ec4f+1vpF8wBrX8npiX/zFYNETeeTSyq9vDdaCA"}}, "unsigned": {"age_ts": 1547281644041}}
$1547281718179tyKcU:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547281718440.0", "stream_ordering": 179}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547281718179tyKcU:localhost", "origin": "localhost", "origin_server_ts": 1547281718475, "prev_events": [["$1547281644178FBthK:localhost", {"sha256": "b1H70W/SGMtBlcZW0HlMm9xPIjtFvSfMoICnXxZmkY8"}]], "depth": 165, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "NJ98jvxLoJKE0pYx4NAoG2w4yHzsguvm1kBCbefjM08"}, "signatures": {"localhost": {"ed25519:a_DTGV": "kOqtlnqqHb1W0Jbavgmragcn0IDi/I1zK4Qx+5Bvdj3vUdu1u9xBaUhWGqnVxluBVgVEf8O8oV2Gin3ugkrdBA"}}, "unsigned": {"age_ts": 1547281718475}}
$1547281876180XjrWa:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547281876366.0", "stream_ordering": 180}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547281876180XjrWa:localhost", "origin": "localhost", "origin_server_ts": 1547281876404, "prev_events": [["$1547281718179tyKcU:localhost", {"sha256": "CWx8afJduibTeqas8NmgoNc0f+XSPz8xjJgMhAEFBcs"}]], "depth": 166, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "pfEYVsyVuFpv65RtYIrS2rJKLjtZUaHx8/OiFRoV1V8"}, "signatures": {"localhost": {"ed25519:a_DTGV": "x7SEB+1ANdZ73DIfEl1N4RiE5g64LJpEHWey+3iCeCcCRUkxOi5go6wHNLTeYojmGcysIsaGAFTcFfSImX3ZBQ"}}, "unsigned": {"age_ts": 1547281876404}}
$1547282273181ZFMBT:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282273550.0", "stream_ordering": 181}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282273181ZFMBT:localhost", "origin": "localhost", "origin_server_ts": 1547282273572, "prev_events": [["$1547281876180XjrWa:localhost", {"sha256": "Ifo9xEQ5Ql7RIU4Qmtu/2AJnynz5Unf/q+hiLvakG7Y"}]], "depth": 167, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "PW4Eoa14jJMS/2U8CPCcDkv/ZcR9ey72YZSGo1wsIyk"}, "signatures": {"localhost": {"ed25519:a_DTGV": "gF89J8WG4tWYkGI2K2Ya3GBBcoicHnxXeXQnY1gpj1pU7m0lD1BnMh/hpfsS+DNxeIBlFdTuWdgeA/zvs+3CDw"}}, "unsigned": {"age_ts": 1547282273572}}
$1547282306182UochL:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282306498.0", "stream_ordering": 182}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282306182UochL:localhost", "origin": "localhost", "origin_server_ts": 1547282306540, "prev_events": [["$1547282273181ZFMBT:localhost", {"sha256": "FDR1iS/iP+VmTFYb2OQyMhtf/WSxsgbsw1u5zsUZZLg"}]], "depth": 168, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "Zg3M/6vH5+5qigWRSX6kVlX9ksuIa1saIqzswhiBLR4"}, "signatures": {"localhost": {"ed25519:a_DTGV": "W2Rl/ICsOihsi7yhrkHrTFtYQeW3ZL2gd+0hXCaY4+H8QGTkX6t9ThHaxQ83LyF/9Dl1vyFySInrG86k2EQSAA"}}, "unsigned": {"age_ts": 1547282306540}}
$1547282564188gOZON:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282564470.0", "stream_ordering": 188}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282564188gOZON:localhost", "origin": "localhost", "origin_server_ts": 1547282564512, "prev_events": [["$1547282556187hjEiN:localhost", {"sha256": "7hhTU3++OR/6ou5wZD28KBAl7tS0Hbu4/UDsdgLRITE"}]], "depth": 174, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "SA/O2B+bcuNpA4ok1zoA4GJS0+a3Vd6vQpmcn4t8OXk"}, "signatures": {"localhost": {"ed25519:a_DTGV": "GgVq+UnDb1z9QEA7Zm3oC+l2idlZXA0681KOTSYMCeYRdjQsITXU4H7yWJlEesehd4Q7FYCgJl46lQKPrsXHAg"}}, "unsigned": {"age_ts": 1547282564512}}
$1547282637199tWnNa:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282637321.0", "stream_ordering": 199}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeuaoe"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282637199tWnNa:localhost", "origin": "localhost", "origin_server_ts": 1547282637407, "prev_events": [["$1547282629198eGjsr:localhost", {"sha256": "RdotLeISoHE3SxKUawMOySijWNsYv3hWBH2dcx5snLY"}]], "depth": 185, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "EWpVwTbK4jQRSxii/FICb7DkZiV9JODcYClVC9bE4IE"}, "signatures": {"localhost": {"ed25519:a_DTGV": "APwylurJ7vUGHd/by2pLcFxb2LQzwZBNclH5PrjS0l9EECRqa5DGBNza04UOuA+ATw4BJCTrTMpMX1XKEqUhAA"}}, "unsigned": {"age_ts": 1547282637407}}
$1547282638204RNlYZ:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282638126.5", "stream_ordering": 204}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoe"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282638204RNlYZ:localhost", "origin": "localhost", "origin_server_ts": 1547282638188, "prev_events": [["$1547282638203erEwp:localhost", {"sha256": "xmuq+OgAFuJFqPk2ktlESRkSFeVPwNU1gKaA6hamrKQ"}]], "depth": 190, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "fHu3cZIwwJsM44dn64G76SQ3gQZZAJz/nUuB/Wr7wkw"}, "signatures": {"localhost": {"ed25519:a_DTGV": "Oq/rdJ8ATbxrX/ZMUOJ6j8CW/m4edmGebLROAnzBZxq++FF1BbXo+ZxnKgwO5IER67tj9AqfCRMMDPGDO8DVBQ"}}, "unsigned": {"age_ts": 1547282638188}}
$1547282369183tZBnm:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282369213.0", "stream_ordering": 183}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282369183tZBnm:localhost", "origin": "localhost", "origin_server_ts": 1547282369247, "prev_events": [["$1547282306182UochL:localhost", {"sha256": "LSPT0Bi3atwE0GKAcLrGqG22nuh4JRmX/4iVxE2seHk"}]], "depth": 169, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "IQ5W7WSjJVwhPhTfnPdUgAEcS5vJro/DT0efP8YSsys"}, "signatures": {"localhost": {"ed25519:a_DTGV": "IEEBp9KnBbZBO8xJwbZZodyfjnTbin1+7cd7Is392V0GNxXHB5aGlGr0eJ2sHE4sLmr5zSUB7GApoCaCuj9tAA"}}, "unsigned": {"age_ts": 1547282369247}}
$1547282552184vQlUg:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282552447.0", "stream_ordering": 184}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282552184vQlUg:localhost", "origin": "localhost", "origin_server_ts": 1547282552486, "prev_events": [["$1547282369183tZBnm:localhost", {"sha256": "2iSHijw31cjivCr1u3dhBHo6ItASPhTouzweEHwi+Ww"}]], "depth": 170, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "HTMgJIBfi7Za5/YVFeo5M9nihP07ubsLHdOUaDRoGTE"}, "signatures": {"localhost": {"ed25519:a_DTGV": "dYyoceaKBCW4BAO1EyHgrJmAzttya40cpT/Y3TLzLhqX7NBSzScsos+zf5Xss9WMiRSxzowZpc0tyQxv3icMCw"}}, "unsigned": {"age_ts": 1547282552486}}
$1547282554185Mrxeo:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282554400.1", "stream_ordering": 185}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "some"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282554185Mrxeo:localhost", "origin": "localhost", "origin_server_ts": 1547282554434, "prev_events": [["$1547282552184vQlUg:localhost", {"sha256": "Fsh6gHuuGLxHqr50eT0UrwWDptcsDKvyED0chLhPqm8"}]], "depth": 171, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "7q9+8it3gKQJtiCUbwhDBnv5BsoG5uiSZlTN1Nh8amo"}, "signatures": {"localhost": {"ed25519:a_DTGV": "mNMS6UDhPEHBCmXLmwsOk93/DOj0Dkl30yc5ETkcdY8sHZfVrkzDx2igTu/eXUOdjIP6p/M+44++bBRext+jAg"}}, "unsigned": {"age_ts": 1547282554434}}
$1547282555186bBEHl:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282555424.2", "stream_ordering": 186}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "other"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282555186bBEHl:localhost", "origin": "localhost", "origin_server_ts": 1547282555460, "prev_events": [["$1547282554185Mrxeo:localhost", {"sha256": "GGXX2yDnAmokQAi6WuLcIShsTAkxwZKreWuZj+px07A"}]], "depth": 172, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "AwBFtlhyddtO96cH754rT3/997LjpLPQn5caUWBNHvg"}, "signatures": {"localhost": {"ed25519:a_DTGV": "La4nK8yw9nW0/5IEcoQCN2Tfp6i4myfKaQcEGlKWPachUi7k83jeaRvAlSLWqG5WsH4BRvptYfMEQx1Th1NxCg"}}, "unsigned": {"age_ts": 1547282555460}}
$1547282556187hjEiN:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282556487.3", "stream_ordering": 187}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "data"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282556187hjEiN:localhost", "origin": "localhost", "origin_server_ts": 1547282556518, "prev_events": [["$1547282555186bBEHl:localhost", {"sha256": "cwNKN6m1MXfh6H0wvgIGPpMUXBcCDzrYSChrbXSbKUY"}]], "depth": 173, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "Be9b7MkReJydyg7blzAjb0d1asJi7u8KumfXTuau7BQ"}, "signatures": {"localhost": {"ed25519:a_DTGV": "J1I7yl7M8ZyNitnH8Mec1RYT9kGu0DEOekyQ3hAu5kS1vGqZsINfCn5zWkhkuPHYWZJuF3gy3KMqwx0Zz8qKBw"}}, "unsigned": {"age_ts": 1547282556518}}
$1547282567189pGIuv:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282567893.1", "stream_ordering": 189}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "1"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282567189pGIuv:localhost", "origin": "localhost", "origin_server_ts": 1547282567931, "prev_events": [["$1547282564188gOZON:localhost", {"sha256": "vPa9ORIhl8RoALlwi8md55bxJjtC3X9yDgmiPw5gl5I"}]], "depth": 175, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "ExGfp+ngI5XYvO9fqZGv2lh/9iuQ1spH2HlomF7PxsM"}, "signatures": {"localhost": {"ed25519:a_DTGV": "5wTjG78Auy5HHQoDp3Zp2JcleMjgGSjCZ+IKcYJYcOVzcjCbhXPEtFZdvZbB8M2jDlWq8tGYeCAQLQIT5F5+CQ"}}, "unsigned": {"age_ts": 1547282567931}}
$1547282608190GmCUl:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282608518.0", "stream_ordering": 190}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282608190GmCUl:localhost", "origin": "localhost", "origin_server_ts": 1547282608554, "prev_events": [["$1547282567189pGIuv:localhost", {"sha256": "PaBhxJd/Uw5PISUzh4GGr/Ccw+7MyZNFD/6LS37BcjI"}]], "depth": 176, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "WfNJj1wBK3BxBagd2o+Ey51J7GO7qrmjOyXB4MDDou4"}, "signatures": {"localhost": {"ed25519:a_DTGV": "AbnMuvFZqrZ9SfKqzGG2NGqc2rrJ63hXfSfBL2zG6RR6jKsIkEe6+S7z/4Nyn98QgdPaWzwJv0uKnZDyfIo7Ag"}}, "unsigned": {"age_ts": 1547282608554}}
$1547282610191tyhdp:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282610506.1", "stream_ordering": 191}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "some"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282610191tyhdp:localhost", "origin": "localhost", "origin_server_ts": 1547282610540, "prev_events": [["$1547282608190GmCUl:localhost", {"sha256": "Iie/oNXaGlDO2Zs6M1DeW2KZ7njezc0r6WdAsN5/UzU"}]], "depth": 177, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "Vr4hBA5Ka8IQDqb+wzn1jHHjGWnTX1+Mc7H0EO2veIE"}, "signatures": {"localhost": {"ed25519:a_DTGV": "UWIoAueucE9tS9Ottd37DYIg+yQLNzEw2EWPPwDKelwpmsWDWvyG6L1ubObsBtgjdF2a9wzrL/S50gUKPcECAQ"}}, "unsigned": {"age_ts": 1547282610540}}
$1547282637200HCoQh:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282637514.1", "stream_ordering": 200}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "uao"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282637200HCoQh:localhost", "origin": "localhost", "origin_server_ts": 1547282637567, "prev_events": [["$1547282637199tWnNa:localhost", {"sha256": "ZvhMMxqVdFI/vZ2jtc+dF3ermMJ+S/g7KnTDqZOZN5Y"}]], "depth": 186, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "0AVIiV3R+JJm4gZPbhRfCU92wDdcNL1ksfO55Z6qcFc"}, "signatures": {"localhost": {"ed25519:a_DTGV": "myB9pTOP/jZoTsc4cCZYmi2pr0x0IDktoNdy/V5uPaOW4aoPPPbp/gGGFgO/RxFgDHA9CRzN3ziEL9uxFgFzCA"}}, "unsigned": {"age_ts": 1547282637567}}
$1547282653212xnlDS:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282638701.9", "stream_ordering": 208}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "ao"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282653212xnlDS:localhost", "origin": "localhost", "origin_server_ts": 1547282653605, "prev_events": [["$1547282648210wUJTL:localhost", {"sha256": "vpvKx5VaRx+SWjwknLn/vrsofQdnpvtq/im9YwlQYAc"}]], "depth": 194, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "esJUZbB4ddpc3ZBeHaciyx4IlaK6JMXagYj8cKoL0js"}, "signatures": {"localhost": {"ed25519:a_DTGV": "pOYG03xGJXmybSQy76PFH7t48C1PWkijQxNkcd7lpUuKi/WlKVSW/2W7CWtDhM84hJTjlmfAa1Bpe7gfTDZVBQ"}}, "unsigned": {"age_ts": 1547282653605}}
$1547282611192tMYPw:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282611795.2", "stream_ordering": 192}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "data"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282611192tMYPw:localhost", "origin": "localhost", "origin_server_ts": 1547282611828, "prev_events": [["$1547282610191tyhdp:localhost", {"sha256": "LanbfUwF9cNLCH/2w6RnERvPyjLRrObQCj9zTUr89NQ"}]], "depth": 178, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "VHnGYs6OchKVaNmABbVrDXKl0ULFQmKAL9kxjJOt2mw"}, "signatures": {"localhost": {"ed25519:a_DTGV": "5m8hXWrYteodxlMOD86pNk3lHexQKWMqvPJ5lGC05/+Pc8bC+WxGOQmYE5tmGeb3H2MJKhKYkzXZuA11Q16wBA"}}, "unsigned": {"age_ts": 1547282611828}}
$1547282613193PvaJn:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282613264.3", "stream_ordering": 193}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "others"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282613193PvaJn:localhost", "origin": "localhost", "origin_server_ts": 1547282613308, "prev_events": [["$1547282611192tMYPw:localhost", {"sha256": "Con9AEOPNalYartb6xuU0cl78Xo/TRf2ZHY193QxgPk"}]], "depth": 179, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "dVDM80xK1qIvoUc0IrjTt+f+PW+4Ykv5Awe6AklPiAI"}, "signatures": {"localhost": {"ed25519:a_DTGV": "27kQijYyToLEvafouWw0H7pT2kIFdAdL0tHJ0D71ObqX81oMfU3KeDCJlY5waL1jjV031nRUFitF4r624UcIAg"}}, "unsigned": {"age_ts": 1547282613308}}
$1547282614194gxwNC:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282614500.4", "stream_ordering": 194}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282614194gxwNC:localhost", "origin": "localhost", "origin_server_ts": 1547282614525, "prev_events": [["$1547282613193PvaJn:localhost", {"sha256": "7WmoRceo3sJQRF8qp645yLy+57H1EC9P5ySiMDNE0LQ"}]], "depth": 180, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "W722z66w6TxjhuytDh72FlJbBHS1HPkhFjN1LLIz4IQ"}, "signatures": {"localhost": {"ed25519:a_DTGV": "B4URfNbudDaFIaUR+KJLEfGvIgtjoeAMBZLZmAcsma8yo3KrB7ljtLwWN0Dz/w0IK27m8Lfc/IsUGMRuswvuCw"}}, "unsigned": {"age_ts": 1547282614525}}
$1547282627197zwhxS:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282627881.2", "stream_ordering": 197}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "then"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282627197zwhxS:localhost", "origin": "localhost", "origin_server_ts": 1547282627901, "prev_events": [["$1547282626196TcRsD:localhost", {"sha256": "RB8KTgTlNy3ikf9TedcGLhuuKoXANml/idDe7RDhqNQ"}]], "depth": 183, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "cXWiZs9aBS4XrX1YJUyZxjwhAUuYsns9EI6TyKJ0DwM"}, "signatures": {"localhost": {"ed25519:a_DTGV": "JA6C9T2LvtSFe4fjfY7TgI5RjeJYqqZtthwMRNEIgKB4m3myADmaMC3j2Tl61mVRigZMevxHMkO/0/9ofgKjBA"}}, "unsigned": {"age_ts": 1547282627901}}
$1547282629198eGjsr:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282629159.3", "stream_ordering": 198}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "others"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282629198eGjsr:localhost", "origin": "localhost", "origin_server_ts": 1547282629212, "prev_events": [["$1547282627197zwhxS:localhost", {"sha256": "vb5RuQ9pmd7fLoPyiTfLTMhlI1eUg3VIEuqCWPIURKk"}]], "depth": 184, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "Hb2MH7CKu9fmDDEgmY5OV5+70ntYCYx8RlmzxQA2SLU"}, "signatures": {"localhost": {"ed25519:a_DTGV": "+yWVVtfm5r6FoPxDFQ9ZVfw0wVUjYGdCZtvKKOq23mipElyVvQv0yAC2X+vXhlKLp0B4SDruaxjbfZlCg5VvDg"}}, "unsigned": {"age_ts": 1547282629212}}
$1547282637201dRtCQ:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282637670.2", "stream_ordering": 201}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "eu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282637201dRtCQ:localhost", "origin": "localhost", "origin_server_ts": 1547282637728, "prev_events": [["$1547282637200HCoQh:localhost", {"sha256": "0EP7+xRSxD1Kt/Q4cVCWtw2JOq1lAquXYqDdzO+M4LQ"}]], "depth": 187, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "1wuLmqQn5wsRTIbes5mYdKjxJHDBzTybwn9WZPXaHOk"}, "signatures": {"localhost": {"ed25519:a_DTGV": "gr2IfEgSeow2coXEy43onCrzUCN7+1UZMWkVt/NctFjiIVed3spBIhC2zpfNeJB4vbKA+C2blrRG2w+aOFypDw"}}, "unsigned": {"age_ts": 1547282637728}}
$1547282637202lPgPc:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282637810.3", "stream_ordering": 202}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282637202lPgPc:localhost", "origin": "localhost", "origin_server_ts": 1547282637854, "prev_events": [["$1547282637201dRtCQ:localhost", {"sha256": "Rzo5rqP8Vhr9j4bRmiPJw4bqW8p9x47k3raAgYrduMk"}]], "depth": 188, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "xlYWtBaViWtKSPaG6Se2Gs0M7I4LPHI5/HPLzW525/Q"}, "signatures": {"localhost": {"ed25519:a_DTGV": "GO86DyAIPzmQiizpStLRL3lKRvYI9w2Dqnd88X8uzNYm/kpvTcZXFnSNauSzNZZdW3x5ijluRuuTGIF4Avd6Cw"}}, "unsigned": {"age_ts": 1547282637854}}
$1547282625195gAcfj:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282625670.0", "stream_ordering": 195}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "some"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282625195gAcfj:localhost", "origin": "localhost", "origin_server_ts": 1547282625718, "prev_events": [["$1547282614194gxwNC:localhost", {"sha256": "XehW3R+NeBTDnQX1vE8OHXzzPGptw3E0ax8KU5KIX/o"}]], "depth": 181, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "M3N/P1Gh0BKAnGU/QBwd1d7F13Vlx59v0o33S5hCg5o"}, "signatures": {"localhost": {"ed25519:a_DTGV": "XV7z4biNysJdduPnalyBS31fMkMs16rJ46Pw/mv/XficNRL+RkcO0vDbw/uu+/ihwi8ohApCujLy8NewSHH0Ag"}}, "unsigned": {"age_ts": 1547282625718}}
$1547282626196TcRsD:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282626842.1", "stream_ordering": 196}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "data"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282626196TcRsD:localhost", "origin": "localhost", "origin_server_ts": 1547282626890, "prev_events": [["$1547282625195gAcfj:localhost", {"sha256": "1JrMwZgIFDzWQ1xcPNTro+pFugUkg6R80WdD6ZBJCuA"}]], "depth": 182, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "mWfEX500nb5hor9m7L6H6bzaaOTUzlwwDa43JDwIKSw"}, "signatures": {"localhost": {"ed25519:a_DTGV": "kWcmRopFXJs6Q314+yAVf0QmRKCULo1wcXbN4AJoCwR5Yv1PBNhLKlk+zctPl9yNB0IlhTtWjN2gomukTsrRCA"}}, "unsigned": {"age_ts": 1547282626890}}
$1547282638203erEwp:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282637998.4", "stream_ordering": 203}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282638203erEwp:localhost", "origin": "localhost", "origin_server_ts": 1547282638034, "prev_events": [["$1547282637202lPgPc:localhost", {"sha256": "iULzqxwv4j1BSmG2Hob43G/Pu1GNUW/NajH1oROskWo"}]], "depth": 189, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "SyJwl5wdbbESTnWZgCMw/HsF80cDQAbZ5mhIHkxXA5Y"}, "signatures": {"localhost": {"ed25519:a_DTGV": "DwZD/ui7am/VEg0eKkLhfDOQIyo0L2mCI0rWvCpx3ldKNRPukeFa0glxHZGZZEA43aKxzAvyBhlbPC6gQZ+vCQ"}}, "unsigned": {"age_ts": 1547282638034}}
$1547282648210wUJTL:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282638541.8", "stream_ordering": 207}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "aoeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282648210wUJTL:localhost", "origin": "localhost", "origin_server_ts": 1547282648588, "prev_events": [["$1547282643208BfeRU:localhost", {"sha256": "gq1csAlR42VBQdht3ysHFFgg/kFOkp3uEGop9PjvTjc"}]], "depth": 193, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "CXrQNwtuAkqpoWMKCUsDttSKVPxK+nmmpTZip7b8ckw"}, "signatures": {"localhost": {"ed25519:a_DTGV": "Xjf5P4MGtDnY7ZYBgXQG7iUFz9U1xzWOC+IJcz+xh+eRXpADYfsibp92y3jAmdNy34Qk/J+Z3QUm1SZzYc8HBw"}}, "unsigned": {"age_ts": 1547282648588}}
$1547282668219nlCAE:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282664375.1", "stream_ordering": 211}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "1"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282668219nlCAE:localhost", "origin": "localhost", "origin_server_ts": 1547282668578, "prev_events": [["$1547282663217xmKxc:localhost", {"sha256": "9OV7F2MZjeciotCkkmGMf8r7jtPUx/ww2tb1kXmLzb8"}]], "depth": 197, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "G+ut6wBYgNsyCfa1vuMRFqlsFCrNUt+exC2963LnyaE"}, "signatures": {"localhost": {"ed25519:a_DTGV": "PCKJMHvvJBatExsgz4koUy16J59n8HdxnnPX70W4q5zvFp8ljWPUDTnX5OpkuHd4KpyzxzmU15GTBbKEvSFuDA"}}, "unsigned": {"age_ts": 1547282668578}}
$1547282638206MMkPI:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282638293.6", "stream_ordering": 205}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "ua"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282638206MMkPI:localhost", "origin": "localhost", "origin_server_ts": 1547282638591, "prev_events": [["$1547282638204RNlYZ:localhost", {"sha256": "RblwuPhWUEAbnnZ3Z/X35bUwvXIOe4dd1GgGVaT/WmY"}]], "depth": 191, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "1+X8rYgSUp/B+Lq9PntALiows30Y/OBDqq8W2cZeHbE"}, "signatures": {"localhost": {"ed25519:a_DTGV": "E4wQDcz74ADmbOOIZCVH2sKaNTG/JwIUPyFP8iGa3ttm/ebJsuycCQXf2GbH0Ut1tqtGAGdE3a0D2U9Bf0L4Aw"}}, "unsigned": {"age_ts": 1547282638591}}
$1547282643208BfeRU:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282638406.7", "stream_ordering": 206}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "oeu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282643208BfeRU:localhost", "origin": "localhost", "origin_server_ts": 1547282643616, "prev_events": [["$1547282638206MMkPI:localhost", {"sha256": "Tp2+8LddqJp+xyukw4oZdOjAX7vwrFWbiidio0VEHcg"}]], "depth": 192, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "h4Wkg8IEIRrn0dkchurrmfBj3fdCSDGvrMmXC5Ru6FA"}, "signatures": {"localhost": {"ed25519:a_DTGV": "E1Y4H+9eoocOO34a2lquf29JcufQQobRWjTCx7GfhEvS+ImZA8QCHgUtZyRDq+wr933GOQ0iAhM0AKQEtLKfAQ"}}, "unsigned": {"age_ts": 1547282643616}}
$1547282658214BrfCn:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282638849.10", "stream_ordering": 209}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "eu"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282658214BrfCn:localhost", "origin": "localhost", "origin_server_ts": 1547282658574, "prev_events": [["$1547282653212xnlDS:localhost", {"sha256": "lcv0MuBkT0WJJpK+1NLcHl6i8AqUbCdQQoJ2DTu/ibE"}]], "depth": 195, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "dJ6To976uxRSS6hsvDt4JRYdcJqD8/zVopq264uNQ6o"}, "signatures": {"localhost": {"ed25519:a_DTGV": "UhYyUsLOMIeZuXd+vVf65p27fpeML1ZMz13VgdrOqFlMPxRsDBBT67sQKbt83xN8eD8OdeyR307ShQaacqwpAw"}}, "unsigned": {"age_ts": 1547282658574}}
$1547282673221rajqD:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282667341.2", "stream_ordering": 212}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282673221rajqD:localhost", "origin": "localhost", "origin_server_ts": 1547282673581, "prev_events": [["$1547282668219nlCAE:localhost", {"sha256": "NSpfO6LRRz0RsdyvF9OpQJcVsG3m7f4Ap3a664ivfV4"}]], "depth": 198, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "4XFwnQEBLhAG9lvH1iL6I5e0NTkfBcw3WlA24cN+gNY"}, "signatures": {"localhost": {"ed25519:a_DTGV": "uDiuwXw6CoDUB2ms86QE/w8fVJIGS+pVbMhMpPafToYWwk0WH565VJEudFj5Xer3WVMQlFpD/63q/IKVbbl7AQ"}}, "unsigned": {"age_ts": 1547282673581}}
$1547282663217xmKxc:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282663404.0", "stream_ordering": 210}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "hello"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282663217xmKxc:localhost", "origin": "localhost", "origin_server_ts": 1547282663580, "prev_events": [["$1547282658214BrfCn:localhost", {"sha256": "d9WxW9FFlyWI3gdt3pZ8+ROJHYuvKP/8sGoIZmgzgxM"}]], "depth": 196, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "8zkT72INP0ayfduzwNGNgJMYbvOIMtgyS3hq7so6wH0"}, "signatures": {"localhost": {"ed25519:a_DTGV": "OiWBEUYEdN43C/0x8jLaNHBJn31eXWTleRarxvd3fzZMSWsNBWMl+RVRdUeqB5/rkOAiPyjTHgbHrNillOc4Aw"}}, "unsigned": {"age_ts": 1547282663580}}
$1547282678223Kcqpm:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547282676836.3", "stream_ordering": 213}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "others"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$1547282678223Kcqpm:localhost", "origin": "localhost", "origin_server_ts": 1547282678581, "prev_events": [["$1547282673221rajqD:localhost", {"sha256": "ptZCoaTWHD+GgHdGAr9WS7QVzAq7BxqxVJH1Ic0F40k"}]], "depth": 199, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "r9QuK7cHAVws9vsUpsMeUhKsot49Yx2d96AB6A5ig9o"}, "signatures": {"localhost": {"ed25519:a_DTGV": "Obg+xLUWoZLyrUUHNGUXQ8A3Cb3t++Jbu+9+dDFuq74IAuoBhe9ehlsy5FDsT4t+06B8XEvErpCcPv18+P+qBA"}}, "unsigned": {"age_ts": 1547282678581}}
$15472864650EOLwc:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547286465921.0", "stream_ordering": 214}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$15472864650EOLwc:localhost", "origin": "localhost", "origin_server_ts": 1547286465959, "prev_events": [["$1547282678223Kcqpm:localhost", {"sha256": "rtK7pPdnSpt5oaNTsOIWs1P6m1ixNDZTnF6k8b8vD1g"}]], "depth": 200, "auth_events": [["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}], ["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}]], "hashes": {"sha256": "NmCjy3tXyxs5CiFKKTry/ys5+C8L5zStWqg7zlbPodw"}, "signatures": {"localhost": {"ed25519:a_DTGV": "afjo5LHBFZS5INnZ1bSjzeQsalNl/zE32o5bz2dxJx+O5n9SUzIASfvf3J1CdmKcBAg4A+CfQsxgafJE2TuGCQ"}}, "unsigned": {"age_ts": 1547286465959}}
$15472864681LRSdm:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547286468444.1", "stream_ordering": 215}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "some"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$15472864681LRSdm:localhost", "origin": "localhost", "origin_server_ts": 1547286468481, "prev_events": [["$15472864650EOLwc:localhost", {"sha256": "e6cDrkkFgxmeS/J3vIrHmo/d1IGomRT+1jYGFtyY9sc"}]], "depth": 201, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "8NdhEj6E/JO0aYaj8D85LjXXUIIW55mZttIBVr0sU/g"}, "signatures": {"localhost": {"ed25519:a_DTGV": "/Iuuj58rP4UyLXWql4cNZqAB9I7s8n7jnCOEvxNMdnvvX/sUBHsZhKkUu6SN0i2Dg3ZEvKE+iihCTcQ02ipCDQ"}}, "unsigned": {"age_ts": 1547286468481}}
$15472864692BQMAT:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547286469575.2", "stream_ordering": 216}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "other"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$15472864692BQMAT:localhost", "origin": "localhost", "origin_server_ts": 1547286469613, "prev_events": [["$15472864681LRSdm:localhost", {"sha256": "FePKvMMaLjHeAaONt+y0Z1rE7HhLNgVMbqXbtJPKNOw"}]], "depth": 202, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "SsuyD1GJyGJokkVFmG7i0Tpy4zPkQIUnRr8WXd01vCs"}, "signatures": {"localhost": {"ed25519:a_DTGV": "JkbBAGlpMGfnEJsGNcpW8XiyfIU3QqhUHXCm9PA2p/yAzh9KhNvfmnCxF7MNWCdL01AF40ytg5Jbfel6akcxAA"}}, "unsigned": {"age_ts": 1547286469613}}
$15472864703LZpNb:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547286470517.3", "stream_ordering": 217}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "data"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$15472864703LZpNb:localhost", "origin": "localhost", "origin_server_ts": 1547286470552, "prev_events": [["$15472864692BQMAT:localhost", {"sha256": "FOtwYa4YY+jAWqMPC2L0DyWAX7WK2Nbr9Sxy5P0Wq0E"}]], "depth": 203, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "5PtLHs1QP4eJ1YULDyTXhwHThWpuy5Opl5n1MzKiT8w"}, "signatures": {"localhost": {"ed25519:a_DTGV": "NztsvtlcM0cLiteeiByizAVpn2JcJyxcLKigWO8gawzHiAlQvsoDc9yq+6GMozQlXalea1DMaEuDOH5llu7eBQ"}}, "unsigned": {"age_ts": 1547286470552}}
$15472864724KanSK:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547286472534.4", "stream_ordering": 218}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "test"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$15472864724KanSK:localhost", "origin": "localhost", "origin_server_ts": 1547286472565, "prev_events": [["$15472864703LZpNb:localhost", {"sha256": "gBmxg9f6oxMMBLS1wG861sh2qYW4hOz98MO4UFvwJT4"}]], "depth": 204, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "34DeZss4yZbOQn05i4n31Ask8ctbEuuR7YAMvE/v7XE"}, "signatures": {"localhost": {"ed25519:a_DTGV": "hS+9yx5Nct/LgVLXne3wVFKP4toXadh3FHMhKI9Qrv4TRPtwhRvmPUQi2BBriIhwVH8tKoUA/W3R7szz+XQsDw"}}, "unsigned": {"age_ts": 1547286472565}}
$15472864735bRxfM:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547286473544.5", "stream_ordering": 219}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "hello"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$15472864735bRxfM:localhost", "origin": "localhost", "origin_server_ts": 1547286473578, "prev_events": [["$15472864724KanSK:localhost", {"sha256": "ELmWRHBo8IaIOotwwfHqOjjlCKgXJXGCzc5YRneErhk"}]], "depth": 205, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "1EOcu35eTT5dRc5ekR8Ik1upmmmVMypamyqfbhQMFw0"}, "signatures": {"localhost": {"ed25519:a_DTGV": "XKYVALLXY0T2RJz5KOrnP1cPGbqb5pVqBDTWjjADsDyaSKZH4QA8SttoMcqsOsCWmWA0dtumMIUaebC9EvpkBw"}}, "unsigned": {"age_ts": 1547286473578}}
$15472864756QXetv:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547286475839.6", "stream_ordering": 220}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "pipec"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$15472864756QXetv:localhost", "origin": "localhost", "origin_server_ts": 1547286475875, "prev_events": [["$15472864735bRxfM:localhost", {"sha256": "NMTirac7/w1ZYMb0GPJCVray4ZdUW2Xs4am+iywZ9A8"}]], "depth": 206, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "BvWrfIjyCvuDWGr/NrKsTNWFOe+d/KbMJ/alog3oyXs"}, "signatures": {"localhost": {"ed25519:a_DTGV": "1qY82y3+29xFc31rcFDMMeZp6UCwGpSIsdMCZcfH/fMULRNHyp+VOxVtujvkk7Vq/IHqeXmbkGk3ZEpJyLzsCg"}}, "unsigned": {"age_ts": 1547286475875}}
$15472865227IBpem:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547286522248.7", "stream_ordering": 221}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "We will use modifyVars provided by less.js to override the default values of the variables, You can use this example as a live playground. We now introduce some popular way to do it depends on different workflow."}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$15472865227IBpem:localhost", "origin": "localhost", "origin_server_ts": 1547286522291, "prev_events": [["$15472864756QXetv:localhost", {"sha256": "qcCnfeqZiBtKnW+t0FHPceIUs97RWfIh+xUogP6dQ3g"}]], "depth": 207, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "fk5IpilfbDajwG7ETQs21Ly9epSP+skPy+4A0ab6ZmQ"}, "signatures": {"localhost": {"ed25519:a_DTGV": "vVrZRgV6mUquZDWrnioT9lplhLmC5wN6D9HkGeWT5RIrRgwa2SniDSZl7RA++l5KgNLwOGLCp/WD9Kgd/4f2BQ"}}, "unsigned": {"age_ts": 1547286522291}}
$154728654910jVIgS:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547286549429.10", "stream_ordering": 224}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "How to avoid modifying global styles?"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$154728654910jVIgS:localhost", "origin": "localhost", "origin_server_ts": 1547286549464, "prev_events": [["$15472865379qjJPV:localhost", {"sha256": "gq3nnJTS+ymV4hAwdw2wS5sVJk3jtALol1B4B/PWbOc"}]], "depth": 210, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "hfsFHB+TeIR3ecS58z1KLIIPX+5/YiBYLNvGyCC2JgI"}, "signatures": {"localhost": {"ed25519:a_DTGV": "Nkd5VQGeA4JID6JHH7tmFCHIEWI7+J/8FsDao0U+807S2dCmll95Rb1ufbniYNWfll9ujqiGXj55fBDhVdCQCg"}}, "unsigned": {"age_ts": 1547286549464}}
$15472865308jlsUe:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547286530255.8", "stream_ordering": 222}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "Note that do not exclude antd package in node_modules when using less-loader."}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$15472865308jlsUe:localhost", "origin": "localhost", "origin_server_ts": 1547286530288, "prev_events": [["$15472865227IBpem:localhost", {"sha256": "JZD3Eq5fcy7Qt7IQjQVlrEdYkTSShvP6p1QQr78Ux5k"}]], "depth": 208, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "iHOV1ic6kNu1AVTSSVsJdPKylBErfYox1l9h12AjJug"}, "signatures": {"localhost": {"ed25519:a_DTGV": "gbAWjegLCHh4p6OGnDbQRtyv9Q2xHkBPXVTealDWsTiwXhl2k4c4T5AcM1up0k1bL7RqaTjNWf492VVpVuDDDA"}}, "unsigned": {"age_ts": 1547286530288}}
$15472865379qjJPV:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547286537216.9", "stream_ordering": 223}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "Import Ant Design styles by less entry"}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$15472865379qjJPV:localhost", "origin": "localhost", "origin_server_ts": 1547286537254, "prev_events": [["$15472865308jlsUe:localhost", {"sha256": "s2th3ARInjLNN2oNbtJIaUrwykPrWZ73jnk+/LWWBHQ"}]], "depth": 209, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "kKg7xBayNuAoxgCq/NwcUll8aLIbOzjmt87cCgOr/ys"}, "signatures": {"localhost": {"ed25519:a_DTGV": "/WqkfSI+iodJVDYDTT7oaEjjvY+ofupRlZbjdBn+KGCTdyWbJCPWl8vx7a1Eojzi/TIbc0mKgMRUUuQbDP3MDw"}}, "unsigned": {"age_ts": 1547286537254}}
$154728655711QTgup:localhost	!CrvkKxgetahhVIwnyX:localhost	{"token_id": 9, "txn_id": "m1547286557013.11", "stream_ordering": 225}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "Currently ant-design is designed as a whole experience and modify global styles (eg body etc). If you need to integrate ant-design as a part of an existing website, it's likely you want to prevent ant-design to override global styles."}, "room_id": "!CrvkKxgetahhVIwnyX:localhost", "sender": "@alexes:localhost", "event_id": "$154728655711QTgup:localhost", "origin": "localhost", "origin_server_ts": 1547286557049, "prev_events": [["$154728654910jVIgS:localhost", {"sha256": "to9zSUhZ5SFRe6pRBXag5o8+OKMLajJGlwlPNf0R59k"}]], "depth": 211, "auth_events": [["$15471426499olYQy:localhost", {"sha256": "CURPUI9KG9UckLozPC9Wl98GUj4yQvjkUwggOoAt5iY"}], ["$15471426487fdcng:localhost", {"sha256": "IeT1SKbVVBrE2fCGzt15KNYosNZrEwuceaU0XxgDWaM"}], ["$15471426498QYDnP:localhost", {"sha256": "HTv+DCrfDePIHUj03PF8UTFC2mg80Ex07MbNY1u0QrM"}]], "hashes": {"sha256": "yT3Pc1ZGJZYDTNHPJ5tWj3d8lOxFJwSugJ/fTUXe6Yw"}, "signatures": {"localhost": {"ed25519:a_DTGV": "sHed4I3Ck4tXBZpCpWAd8o8RgnhHf6V1L7qvbuZUalYkUCd9r20TTiZqWPo5YF6Awm75GG+y2loiAMyiyUq+AQ"}}, "unsigned": {"age_ts": 1547286557049}}
\.


--
-- Data for Name: event_push_actions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_push_actions (room_id, event_id, user_id, profile_tag, actions, topological_ordering, stream_ordering, notif, highlight) FROM stdin;
!CrvkKxgetahhVIwnyX:localhost	$154720039497BQXbf:localhost	@alexes:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	83	97	1	0
!CrvkKxgetahhVIwnyX:localhost	$154720043498SQgyh:localhost	@alexes:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	84	98	1	0
!CrvkKxgetahhVIwnyX:localhost	$154720071099yrpdB:localhost	@alexes:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	85	99	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547201274100AXvny:localhost	@alexes:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	86	100	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547201298101MsJGQ:localhost	@alexes:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	87	101	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547201299102nrFQP:localhost	@alexes:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	88	102	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547201301103APSbA:localhost	@alexes:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	89	103	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547201310104XQQzj:localhost	@alexes:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	90	104	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547201345105jVolj:localhost	@alexes:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	91	105	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547201455106obHen:localhost	@alexes:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	92	106	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547201474107QSZzp:localhost	@alexes:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	93	107	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547201566108vIMzG:localhost	@alexes:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	94	108	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547203164109HWxxp:localhost	@alexes:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	95	109	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547209015110ILKew:localhost	@alexes:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	96	110	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547209017111VCOtq:localhost	@alexes:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	97	111	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547209037112vjLNr:localhost	@alexes:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	98	112	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547209043113TVkrB:localhost	@alexes:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	99	113	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547209096114BlJbe:localhost	@alexes:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	100	114	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547209171115HwvmV:localhost	@alexes:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	101	115	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547209244116RahcN:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	102	116	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547211554117Elhng:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	103	117	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220025118yFXAz:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	104	118	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220096119DwtHP:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	105	119	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220105120XlrPA:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	106	120	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220182121VEzRa:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	107	121	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220191122fXIkm:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	108	122	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220193123fBQYD:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	109	123	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220194124AQdWA:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	110	124	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220196125pygpM:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	111	125	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220197126rpVNs:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	112	126	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220198127qDjZB:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	113	127	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220199128EKqcd:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	114	128	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220200129xNEFN:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	115	129	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220219130eqWPP:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	116	130	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220236131oUTpn:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	117	131	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547279187146HVLNT:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	132	146	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547279319150fMLrf:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	136	150	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220258132jXsNq:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	118	132	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220334136ylgXz:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	122	136	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220358140eyxTo:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	126	140	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220271133nWAgW:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	119	133	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547279184143GVbKe:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	129	143	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547279320152DJzGw:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	138	152	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220330134ibkVz:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	120	134	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547279183142YOhis:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	128	142	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547279185144ElypB:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	130	144	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547279320153eLKOp:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	139	153	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220332135nCFHQ:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	121	135	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547279186145UMjYo:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	131	145	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220336137dJMop:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	123	137	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220337138tFafe:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	124	138	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547279190148LahLH:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	134	148	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220342139OPXTO:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	125	139	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547279189147gYZsO:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	133	147	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547279319151MaOud:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	137	151	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547220502141QlNvD:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	127	141	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547279319149EgmWE:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	135	149	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547279321154qYYIA:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	140	154	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547279331155MIaaY:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	141	155	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547279331156JREIt:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	142	156	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547279332157nmQRp:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	143	157	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547279333158JjmRS:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	144	158	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547279334159OmRvd:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	145	159	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547279335160XSwVw:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	146	160	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547280627161jyqzw:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	147	161	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547280712162vCSiP:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	148	162	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547280714163OzTSL:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	149	163	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547280717164BqYSL:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	150	164	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547280734165AejNq:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	151	165	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547280737166XHlsG:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	152	166	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547280753167iiLNC:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	153	167	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547280755168RTqof:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	154	168	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547280758169QBLYK:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	155	169	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547280759170XdQji:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	156	170	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547280764171pBzRc:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	157	171	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547280816172DhRcw:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	158	172	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547280820173UXJMb:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	159	173	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547280825174yozNU:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	160	174	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547280856175DGEZm:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	161	175	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547281038176RAJob:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	162	176	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547281042177bmAPI:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	163	177	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547281644178FBthK:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	164	178	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547281718179tyKcU:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	165	179	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547281876180XjrWa:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	166	180	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282273181ZFMBT:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	167	181	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282306182UochL:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	168	182	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282369183tZBnm:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	169	183	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282552184vQlUg:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	170	184	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282554185Mrxeo:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	171	185	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282555186bBEHl:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	172	186	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282556187hjEiN:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	173	187	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282608190GmCUl:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	176	190	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282625195gAcfj:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	181	195	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282626196TcRsD:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	182	196	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282668219nlCAE:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	197	211	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282564188gOZON:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	174	188	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282637199tWnNa:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	185	199	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282638204RNlYZ:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	190	204	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282567189pGIuv:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	175	189	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282663217xmKxc:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	196	210	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282610191tyhdp:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	177	191	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282637200HCoQh:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	186	200	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282653212xnlDS:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	194	208	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282611192tMYPw:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	178	192	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282637201dRtCQ:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	187	201	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282643208BfeRU:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	192	206	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282613193PvaJn:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	179	193	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282614194gxwNC:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	180	194	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282627197zwhxS:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	183	197	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282629198eGjsr:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	184	198	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282637202lPgPc:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	188	202	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282638206MMkPI:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	191	205	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282658214BrfCn:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	195	209	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282673221rajqD:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	198	212	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282638203erEwp:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	189	203	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282648210wUJTL:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	193	207	1	0
!CrvkKxgetahhVIwnyX:localhost	$1547282678223Kcqpm:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	199	213	1	0
!CrvkKxgetahhVIwnyX:localhost	$15472864650EOLwc:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	200	214	1	0
!CrvkKxgetahhVIwnyX:localhost	$15472864681LRSdm:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	201	215	1	0
!CrvkKxgetahhVIwnyX:localhost	$15472864692BQMAT:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	202	216	1	0
!CrvkKxgetahhVIwnyX:localhost	$15472864703LZpNb:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	203	217	1	0
!CrvkKxgetahhVIwnyX:localhost	$15472864724KanSK:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	204	218	1	0
!CrvkKxgetahhVIwnyX:localhost	$15472864735bRxfM:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	205	219	1	0
!CrvkKxgetahhVIwnyX:localhost	$15472864756QXetv:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	206	220	1	0
!CrvkKxgetahhVIwnyX:localhost	$15472865227IBpem:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	207	221	1	0
!CrvkKxgetahhVIwnyX:localhost	$15472865308jlsUe:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	208	222	1	0
!CrvkKxgetahhVIwnyX:localhost	$15472865379qjJPV:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	209	223	1	0
!CrvkKxgetahhVIwnyX:localhost	$154728654910jVIgS:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	210	224	1	0
!CrvkKxgetahhVIwnyX:localhost	$154728655711QTgup:localhost	@alexes1:localhost	\N	["notify", {"set_tweak": "sound", "value": "default"}, {"set_tweak": "highlight", "value": false}]	211	225	1	0
\.


--
-- Data for Name: event_push_actions_staging; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_push_actions_staging (event_id, user_id, actions, notif, highlight) FROM stdin;
\.


--
-- Data for Name: event_push_summary; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_push_summary (user_id, room_id, notif_count, stream_ordering) FROM stdin;
@alexes:localhost	!CrvkKxgetahhVIwnyX:localhost	35	96
\.


--
-- Data for Name: event_push_summary_stream_ordering; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_push_summary_stream_ordering (lock, stream_ordering) FROM stdin;
X	97
\.


--
-- Data for Name: event_reference_hashes; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_reference_hashes (event_id, algorithm, hash) FROM stdin;
$15471426300pPrwQ:localhost	sha256	\\x8894cf766c8d0518179485dbb01b61ad4575e57546926635bfda496eb417cd37
$15471426301dPFwo:localhost	sha256	\\x211ca0216ebfe0c6d05379c19e489437f8619a0439dfb279a3ffe8c82259827b
$15471426302pIqiF:localhost	sha256	\\x702b874a8a40f3ccd9b71029624e84a5c07c96d533b1bb9a9cd8d5278cd66cf1
$15471426303YCSmZ:localhost	sha256	\\x404bcf4f02ec69f98bd55549552748918a3496bb218b01ff5e466ed3f567a8de
$15471426304BRdxH:localhost	sha256	\\x03f3a723074261852251ae7306987c6d0853851ce1900dd153eee9cfe54e2cb0
$15471426305IErDp:localhost	sha256	\\x76ae29d77f527197c2f5dc0442241288c1e7f755dc20618f575312b4ef4e3c11
$15471426487fdcng:localhost	sha256	\\x21e4f548a6d5541ac4d9f086cedd7928d628b0d66b130b9c79a5345f180359a3
$15471426498QYDnP:localhost	sha256	\\x1d3bfe0c2adf0de3c81d48f4dcf17c513142da683cd04c74ecc6cd635bb442b3
$15471426499olYQy:localhost	sha256	\\x09444f508f4a1bd51c90ba333c2f5697df06523e3242f8e45308203a802de626
$154714264910qNuKi:localhost	sha256	\\xab6ae4f2e73ead5c8db145a7972c5ecc46a3579439e7a7617c833914b00da8e8
$154714264911TWsje:localhost	sha256	\\x43aa25038fb2441c712623517f04fdf56c5e59b6807d33e7e117d0e780f560b3
$154714264912SGfjg:localhost	sha256	\\xd07b67c47680b42b456725321217c0611d6d7ba10d062a3f01975991e5e49729
$154714264913PCUQS:localhost	sha256	\\xbcb72fabf3762e133f0a63bccb0e8fa5b00b89044df7417d74527277e30b6e3e
$154714266714gvEsJ:localhost	sha256	\\x912b0ea14de80911acd1d32a1f1c1fc6a7c27f69ddccf416cbd5278f8f241116
$154714412415WRVyj:localhost	sha256	\\xab1a0f0779b086f2a701030626a356e09069e2532699743504ebb3f30acf3d01
$154714428316KLrwW:localhost	sha256	\\x7d3ecac484fc6b187d811c3b4d0a8c04ab48a5dcfdb1a9f01ae14d6dcc475110
$154714428317sWMac:localhost	sha256	\\x4670794738fad3ab361e54dda4373f1e18bee7698c35faf2cbd0c3ecb63000e8
$154714428318OamJt:localhost	sha256	\\xbd73a701036c5b697da39b92bfccc56776fa8fa01daf84c68a6f03b9965ded5d
$154714428319jqvHZ:localhost	sha256	\\x7d58e29afd1247dd87a69e5509e19f66ba7bcc57d4c2fb2a8bae0c20a8f55e1c
$154714428320dqSvn:localhost	sha256	\\xaec12d61c662ba6cd1f1eb07d8a61d566015c5aea0454fe5475c7c2bde256e12
$154714428321iaMIA:localhost	sha256	\\xbdf19cec61d36ffed858e95d7fe07be700a05157694cb08cbffbfd1e1469d002
$154714436223plixL:localhost	sha256	\\x27e2f4b9b474c8179d7a4bd20f27ec688ecf163e42b2f05aedacb907da0d8f3f
$154714436224LoFLm:localhost	sha256	\\x292f0d82bd2d75ec3bdccf5bba3717aee76890061e05a81a44352c073ab6b287
$154714438325bxgqT:localhost	sha256	\\x2af2319f725e907e6c2c2a51938e47ce2bb1d4cc709c7aa814644d370e772490
$154714438526deOTX:localhost	sha256	\\x42f4f3a0d6c61f4f8c99664bddfaa2415d03ca765b3a377d19d795532d75a539
$154714438727XNbHq:localhost	sha256	\\x576f1e493c6bbdc8fea05e5fbc03c4bdbd595df85bb621bc45e9df6c5839425d
$154714438828svObh:localhost	sha256	\\x71b64b0feb65519d0f42e7ae0bdbff0e61a15b5134622641f1dafd136e8b9250
$154714438929Suhxq:localhost	sha256	\\x668821c08d94755e98b1ece044fc32eb32d51bfdd3b72ce03400e811fab9993b
$154714439530kLEKZ:localhost	sha256	\\xe4eafb6db4c12ca73440f6859b403f6e50a48a3089e7b2583477898d58453bef
$154714443231YXmpK:localhost	sha256	\\xf09663dceda8922965ae19573169906fa7db465ba59f38515c58dedb645477d6
$154714446132Evhrh:localhost	sha256	\\xf6ede327703a21428bef28ec00920f5039dffee94874bb1ad3e6d88068ff6784
$154714447433aWttn:localhost	sha256	\\x2213a5e18e73ed03c17586929dc2dcd92e9a6bf67aa389e64a298e9c04092419
$154714447534UQifj:localhost	sha256	\\xc5081b8a44566dd394507231b433edae0838d95519f1fadd779c0946a92429f2
$154714447735ZCGXj:localhost	sha256	\\xe45c5ef1f49cca6141e4bb09e606ed2a48e2cdb0d550cb89ab8b44cc2e0afb25
$154714447936SjGma:localhost	sha256	\\xabc3096d4e1be86816d007d2367144b2f1a3c62dedd9258a7bd28045d18c474d
$154714450937xxzjh:localhost	sha256	\\xcfb5b36e9462527eeae8e8ab94b24fd2ab1f8993317a0ee90284c816a03bdb3c
$154714485938YzCYs:localhost	sha256	\\x147a6e8308b16f8a3542c81980d03ce5ade4467e7caa3fa9f2766b7b6eef64ee
$154714489839jNhPb:localhost	sha256	\\xdcedcefa81c2b26e4c8b03a62238ea870aecabde7f5e80e6ceac28d0720b6992
$154714489940llVyn:localhost	sha256	\\x145d768dbe704c576bb373a995b998bfbeff41187ded54160ca64118ae04c891
$154714493741nQcWl:localhost	sha256	\\x32a2d2541f843712ddb4a36f219c9fbf763400b9f15bec14c92fd2142e4e1124
$154714494442vLOzu:localhost	sha256	\\xde83d2039227337835d19e747a64401a0989893561e60d37bf81ce02cb75ef01
$154714497443utMjv:localhost	sha256	\\x3a3af2fef765f57fc691a1e035529e5cf5fb4be3a66052f7f5b85efd1c26be48
$154714497944XQHPs:localhost	sha256	\\x1647513e062102013047efda730a20322e0b3cd85575cc91c72370f381033ab2
$154714498345nGKFH:localhost	sha256	\\xda558b443651f25a989333f2bd198a98494ed61e67c6532ce26fff07820542b2
$154714504446aiIqN:localhost	sha256	\\x41ae45321bdf2da7646bcb1277b676a071faa460c8f7fcb2bac9383d82ac92c4
$154714504947xvIss:localhost	sha256	\\x4f65ba87596c5ba8e2cfe5ebb80db8b50f0157abdea02d47a7321f581c39f8bf
$154714505048dWZpP:localhost	sha256	\\xf10b1b217e94c688107d931b25a5a437847f6a99bcc31434d0751542f626a533
$154714505249jNMbA:localhost	sha256	\\x43af6035f657d0266a80bb42ef2dad5f1faed281a86132eb7b0e793be42f467d
$154714506450XWsqc:localhost	sha256	\\x0b9e393ae5d0dabe0408efdfe49aaf56cf143c8da0665d05b1c28b60258146a0
$154714508851gyeED:localhost	sha256	\\xec5f08eaa70d71d4dfa6e8cb857173441407c0b03150b04e3f691021f3ba2de8
$154714513052twTnQ:localhost	sha256	\\x64c5f6b1138541ae7d99fe3cf794b7a5b3e6108d6a034e768fc71a9139e30a26
$154714513153wozrV:localhost	sha256	\\xbf49e7922f371b2c136406682f13b49386eae8335b7327474096eaf57050bf77
$154714514854gxKZt:localhost	sha256	\\xd7756a23f9651c01093d2e491e8708474d4df719f72854ed1fa3adc32ad498ce
$154714516355TZkpl:localhost	sha256	\\xc2478664dd8c66bfa5ba2ec82530fa37aa24c3aafa7f965d60c384d74b275713
$154714523956frAuI:localhost	sha256	\\xf6b803b5f79c8ba0a98e8707c728b3d40ee730855cd6b2f51c6398b47b3ebd07
$154714524157LQlkn:localhost	sha256	\\x79a8538ac866d88b5fb32337ae6027d9fcc35918de34c301b257cbdf8296d492
$154714526858lzwnp:localhost	sha256	\\xb559912f1ba9e3bf9729f39b89b2efb44937b3d1e95562483b5a998529b61bcd
$154714527259ArrwP:localhost	sha256	\\x1fc70fa5ede871cfbb864f8c7bcf2cb76e945b092896c0c2f8ed37bc5bd378b9
$154718807060Osxiw:localhost	sha256	\\x28f2ab9ef99749c285d3bd9f0133d31407d08e419c40c5afcd14fa0e55da7dea
$154718811161PDsGA:localhost	sha256	\\x1ed6c0c10307b08bda09aedc875a0e986865d7463ac0d69b041734a9f0a5fd30
$154719130162RgkdQ:localhost	sha256	\\xf30f221f040ed24c7b75194f28281263dedcf8e5c8448aa96ddb2339af0a4892
$154719143563hheAg:localhost	sha256	\\xd080c6a559098d72eb0a1743ddd8ba4007d34a05f26ec0d2c63ecc9780f42ea4
$154719144064kEzNq:localhost	sha256	\\xf5509b9d9996f2e760e97fdb66a076da1aeee70eb7b6d477e90a8facd316d5ab
$154719151365zvWZO:localhost	sha256	\\x773789a381f831aab60372b54006dd9fdfaf0af4f861b42919c3d73517bb976d
$154719152466oQvOE:localhost	sha256	\\xfefbeb29b06114f0a29cc1e21f08d604c2181fe2a629096ad73704c7a0b56987
$154719164767efuXJ:localhost	sha256	\\x3cd99b7e1f6e7ec1909d8941eb6d7b64e4c05ca915dc7ee6ba7b17d18503954a
$154719165168NYIll:localhost	sha256	\\xc24bc150a85839a1b3e6188cf0fec9c2e01d7aa129e3d0fc999465504f988457
$154719247969KPEUm:localhost	sha256	\\x47ebd9cd141a264f5cb78ee37d609548fa066f2cec87a6965b2fc1aad17d8d59
$154719339270SMjRz:localhost	sha256	\\x513653463ead8b0834215ac0a7dc8b192d89af875cd5543504a9c1b9099e7e17
$154719339771HhoBo:localhost	sha256	\\x3b97e75f741a1002a6d02d0631eb0e686285b1234b4df82b4d884b2b8ea95f1d
$154719344372iKEnw:localhost	sha256	\\x1a1f97c3e2766e5276d9b0ae6be9339a1b449136ca1346e6031804b3b1e2db5b
$154719347073jkPIF:localhost	sha256	\\x6f6474a498531650ee207786b913dd582d4d62d6b8477ab72bfe015dac25d91a
$154719378074ykqqG:localhost	sha256	\\x8070b41e4698e7368f0387a652d00021e3ac90df7d40f13c102a73547b57a87f
$154719491875LeoON:localhost	sha256	\\x291399310ead5f316d146aaf0f1f0ceb9e2941f6ed0325caffbb38de29957732
$154719496876HQbNA:localhost	sha256	\\xc17cc0f10c0a16704da12c7ed5f50ff4f0c8c0f9dcecd6a501819a208b807dfc
$154719500977pGQXX:localhost	sha256	\\x5f43d8181739aa3f9e07eb7493cec7779620b4f85d63c73044a5598edbf0ca7a
$154719502078SFZFP:localhost	sha256	\\xdccbaa6607b61a523299c8dc3c7359b80e492326e881f491b20965827894206d
$154719505679wchms:localhost	sha256	\\xa968a899dc5bed1ba1859b07f520a2a9b1e7d902b1b1b177d851cccd5c38ab80
$154719508580jYTcz:localhost	sha256	\\x8b54ba8ff4ea532f81ea7188bb462229a49d262af40176f522febcf7199e803f
$154719514481IOBiR:localhost	sha256	\\x39bb892710025638fda1aca3f857a349bccb01b306e83d6df4275094aee83966
$154719514682XMEKF:localhost	sha256	\\xafea53715e5e79c2f4f7f0d0dbc7ccd56c28a07f08ea291f8a3dcc6fc879dc7f
$154719519283zKOPF:localhost	sha256	\\xa464a63b40763850afde6350358645e1c170ddb1319bc33674b3a226e657a163
$154719531387IgQOF:localhost	sha256	\\xbee4bd90d39b384a23324ec3aea0b19a618c195f404db905f72458780d4a77a7
$1547201298101MsJGQ:localhost	sha256	\\x3478889006f557183eb659b5e867cb37c882e8c37fabc11ef457c3bb6fbfe593
$1547201299102nrFQP:localhost	sha256	\\xb54cb324846c9bcaf9d8096a8d1c4c9cab39eb0118b6c0a765794828a57f148b
$1547201345105jVolj:localhost	sha256	\\xfffec51583ecebe9021c866bd1d5aa28d77ec7f21f3f4d4eddb45bc7b7054423
$1547209037112vjLNr:localhost	sha256	\\x13b439f957ceedc8915d28f16e82157903705b776ae221172a2e33ada3ac270b
$154719521084EQDIT:localhost	sha256	\\xf014a96e789f25eb33c1c2172249fdb4272adb78b22c058ae9109b9706f3cdfe
$154719540291vvcgV:localhost	sha256	\\x5a48d0f54c9242490669bcd7e8db5a44d4365eeef011b481771ff09554b0deb3
$1547201274100AXvny:localhost	sha256	\\x266b3c8cd9879fc01939f53bef6751192a92e3dbbde4aa10186c3945a4510935
$1547201310104XQQzj:localhost	sha256	\\xf69c4e60df43d794b6a148ada04fa5507f49714295d9dc7ea3e9002c433e1374
$1547201455106obHen:localhost	sha256	\\x2de7721d881ce9a15ac859f14995e9be79f88d4e8455bdc5e24a3e8887900192
$1547209043113TVkrB:localhost	sha256	\\xa0465e54d5482b97cbb38ed6f470b916a3f03da23f5f12603ee7d6261f619f99
$154719524685MEsPE:localhost	sha256	\\xa81b16deb14e542d5825ed4446dc514dd749373a76fc28bb934bbf2a49017ba1
$1547209017111VCOtq:localhost	sha256	\\xf0dbc843162c21dd9835d6fbae1e485435de0fca63c949f38812ca0aefb9dcd5
$154719527986LWiBd:localhost	sha256	\\x425f04c8c44e4a3869abf035ff3244033bdd971184c480303f3cc9253de9d053
$154719540493KHAxf:localhost	sha256	\\x2611c7e3e5759a820d92f336134c069c7e85fe2444e3120272913dbfda3afe50
$154719547395BoSSt:localhost	sha256	\\x856226eaddecf7ee8e1649278b6d72c72e27f58563c1f7214967751e9aef5064
$1547201566108vIMzG:localhost	sha256	\\x4b987624da6c701288f2040d8fad0523588e48fc15fe51a50ef1027ec8e430ca
$154719537488sBeaz:localhost	sha256	\\x549b5a2087a7c972d32759033deaa08fa1323fc07326fab63d332a4dbde5495c
$154719537689wbEAt:localhost	sha256	\\x7eb215dcd8366e2de154ad8b1bb5b9f0ca9d08966e25caeca5aa0189d6fe0e51
$1547201301103APSbA:localhost	sha256	\\xeb92622db6bf63e470a0c80b5c0da02d50ada13ac2dead2ff5635595e442e853
$1547209015110ILKew:localhost	sha256	\\xec12020cf40d21cf8aef8fb1590a517d99620e0b75122cbed6ba4c63d69ba186
$154719540290lClpJ:localhost	sha256	\\xfa220d738e98d68d01d5512caf4d7b92ec61d57f7800f70f9d95093c31badc83
$154720039497BQXbf:localhost	sha256	\\xd2b7e9baf046f5527a09b363c75cdc1b32da982949b7fef4f2d822b7710e691d
$1547203164109HWxxp:localhost	sha256	\\x2c645acef8d744ecaca4c76975106c3f57b1d8565df79f998514bb064088e70f
$154719540392cuLjJ:localhost	sha256	\\xe3e71606d75b831d31ae6cfa416738333c140f62e1d211d21cee5ec23965497c
$154719547294JJsmq:localhost	sha256	\\xec2a6e2806615213981a8004bdd1f1e8a843811f161eed2bd720c991e43e011d
$154719550396cyAjC:localhost	sha256	\\xdb7de28384ab6265bd15b25c1bbcdd282273928491385c3e0ccca26f7c291568
$154720071099yrpdB:localhost	sha256	\\x17c742fe1200b1f1edca602085a63f420247f3dfb77eb11c60d0e78e09802828
$154720043498SQgyh:localhost	sha256	\\xd5ad633f1490c344c75bee5162354e1aec01bf00a0e08609ce884f339a8e9552
$1547201474107QSZzp:localhost	sha256	\\x28a8fa26681bb8a634c06283d5a302fa87457df7fa05526c6f89f2062c336290
$1547209096114BlJbe:localhost	sha256	\\x979ac9e325b70bc07f9265e84865f0ab5af496bf38894dd8659ce199c7efd765
$1547209171115HwvmV:localhost	sha256	\\x0cdbfc6a744c1024cf30b2dd65a78a7de824a16068c4cee279eb8c207abe4e85
$1547209244116RahcN:localhost	sha256	\\x391336896e6e0377ca1ef9cb14d3a0dbdbeba1f0a00d2a0ba0db53e6390a5a77
$1547211554117Elhng:localhost	sha256	\\x4cede2dbecc96a99d5360bb903f02dc8110fa4c7f3f53a24b9d59fa5f445b42b
$1547220025118yFXAz:localhost	sha256	\\x9c147fc76d9fd4ffb8b8380f186acecd5c48a606217f4a3c378565085e4694e3
$1547220096119DwtHP:localhost	sha256	\\xc345c15ee70336a8157a8418377e45f315672202d1f8c5ab148f9a29ef0cd764
$1547220105120XlrPA:localhost	sha256	\\x28df471105bdd047b6c3a911d90c4538456d0487a2764eaf5f8d8d110410d453
$1547220182121VEzRa:localhost	sha256	\\x17f54bb70b0fefa4844bbc6961b230b23d10ec9ffb92c62778d8086ec920e6f5
$1547220191122fXIkm:localhost	sha256	\\x31619546170465e3d6f572d2d5a92d5b5cdf71cd63030903fc3545c090b775e9
$1547220193123fBQYD:localhost	sha256	\\x9276e6c2bec0a01c6ee35f7bbf9545c7e9f84937421854292f97e859dbf17fb6
$1547220194124AQdWA:localhost	sha256	\\xb8eaa2843464aef46240f73f4ca7104e90d2918f2525e4c376adc5e6a1081c5a
$1547220196125pygpM:localhost	sha256	\\x3b58290183a0ec545495d6cd58a1c06db94aa71245a84112d404be5cbc91b2d8
$1547220197126rpVNs:localhost	sha256	\\x41d7a56fef2f3d3752bebce76650e5a98a520fe65ec9999aed7379a294f049dd
$1547220198127qDjZB:localhost	sha256	\\x7e4601cc70ac0788a192147be38dd8d5ce2a5b75c8d3d933d34fd076154d57fc
$1547220199128EKqcd:localhost	sha256	\\xa283c9ed476223d217fc63d9790e92170ca9996319b0a9dba9feaf238f735012
$1547220200129xNEFN:localhost	sha256	\\xacb89b33c75453f1545f42bd34c081dc5ed41b6383b149b660d0185cfc75b7c0
$1547220219130eqWPP:localhost	sha256	\\x5aba37ec75a3e383d68ac14afe5a5f732ed3ee810fac50c96ce27f12b50fdf18
$1547220236131oUTpn:localhost	sha256	\\x0dbda051419829f16f678189381253feb1aa8e768532186bd4c629f5009a3208
$1547220258132jXsNq:localhost	sha256	\\x819360c3a388d3c186d990a56b28df999fa8de084328941fd0761dda00ad22c4
$1547220271133nWAgW:localhost	sha256	\\x2b8b0765c52960379b3800f765742efd037610dcc6cd3d54d2e444915de858fd
$1547220330134ibkVz:localhost	sha256	\\x95143aee4c79fbd26c14ad9a2c9e395a140fe91147987c2da144e1174efffec8
$1547220332135nCFHQ:localhost	sha256	\\xf3e2a21bc55bf94c1013b7022aa010a21bc593ee88c41e741c664377edba5613
$1547220334136ylgXz:localhost	sha256	\\x0d529f72992b0593a6c51b05c6d01966af60db94652779a6ffc7c0d187393387
$1547220336137dJMop:localhost	sha256	\\x9804cbff7b36009969fc54784c1498076322ab7bbc9818f04ab705e3f19cd277
$1547220337138tFafe:localhost	sha256	\\xdb16331fc4a5364ceec335ecbf08478b9a58be45ceaaa9c3ab714c6778ace09b
$1547220342139OPXTO:localhost	sha256	\\x3aaec429f539bbf3f016cd3159023750adee63e70ee971a8161aadb3430eef69
$1547220358140eyxTo:localhost	sha256	\\xe4bb3ef22ba9ee53d04aaec3da48b55a9a5ddfef70b7388b0e3a6cd405314141
$1547220502141QlNvD:localhost	sha256	\\x89327671e950c95532f3bea6966719428632ddc7416bf95e3fa8f179b228a1fc
$1547279183142YOhis:localhost	sha256	\\x4f50b9e6d87cd01f55a50c2d28b331095a7920f2fec6e8afab7ec6a1ded5bd6b
$1547279184143GVbKe:localhost	sha256	\\xbe229008cf916c5f476d46e2289b47b9178b54f0057fded514dbd702eba5fb5f
$1547279185144ElypB:localhost	sha256	\\x667fa773cea6192f096b4f84509fbb28f0410262e777d9653e5b9e6440779e7e
$1547279186145UMjYo:localhost	sha256	\\x15ea16de3508f8dcfe2a75365a092ee4df5fcb5163b64bf23790f14b3a4554e1
$1547279187146HVLNT:localhost	sha256	\\x21b58f5c8f07b9170ce2ee5393f17051a535d4d8cf2a1d397547e9b90e979113
$1547279189147gYZsO:localhost	sha256	\\xf166ce25027b905364e0296a5703c2501972585de2afeae8dfcd4a5fca3292dd
$1547279190148LahLH:localhost	sha256	\\xa13418f4c2c15874ef811904653d31922b59e11c5f9a8fb4fe4fdc3cf3d23b3d
$1547279319149EgmWE:localhost	sha256	\\xfdc7a011e9ab45ae707798387bcb2927fc86a351831a6b9ab26856eec39a09c4
$1547279319150fMLrf:localhost	sha256	\\xd84f7909314ec103d26b287b790ee63fa49f56a5c93f9eefd0de19396728c104
$1547279319151MaOud:localhost	sha256	\\xa77e4b06ade522a4d44383e7b88e73715a75c8b61682035c24cb4e918f1ed225
$1547279320152DJzGw:localhost	sha256	\\x3adaccd89101e1cf22542a4b1876d79f8b1530deff570494aa890eb5682afd2f
$1547279320153eLKOp:localhost	sha256	\\x9e0b7c1a38fb28ad98b4559c75412f755ae7d0f5e6a88d6f119404fd294f3a18
$1547279321154qYYIA:localhost	sha256	\\x066842087f5ab3f48e99d81da66921eba36789de1cda9ab18f6294dc0f4d8d4c
$1547279331155MIaaY:localhost	sha256	\\x94d86d2de685e4f2a256e5b3453523a767e8bf38d6df8d8130cdffcd78e66c89
$1547279331156JREIt:localhost	sha256	\\x1910fc053ef517e588f1260f608496b9b8155cf86957c206db7d4e6bf7b3f6d6
$1547279332157nmQRp:localhost	sha256	\\xf2f4fd954e05a9273d55d803ea07f96c0d4fd3c7015ff88fac085873a78124dd
$1547279333158JjmRS:localhost	sha256	\\xefb002c4bd3bf5b3b49eba081e42cd9e988829d6f725d82536f12689c8a8a9be
$1547279334159OmRvd:localhost	sha256	\\xd2cd0b51a6de87b4fa72e06dd5e921c5dee10c25bf9104656d523d83a29fc7da
$1547279335160XSwVw:localhost	sha256	\\x18a56bd8f3ee861c93fd36676a1f6976837babc66e7f27843e21f758d689e1ec
$1547280627161jyqzw:localhost	sha256	\\x76c558ca4f69a7095e8197aafe4e588e3da878a257cb16b2412a831a36f0d9c7
$1547280712162vCSiP:localhost	sha256	\\x9311e1560779f538ff6ee87f74b69938463a0492a79a899c79cc0e3fdf425b49
$1547280714163OzTSL:localhost	sha256	\\x537eb9aca1389589a4ffc099ef01cc7108363bd30fa330497f0e18213b31fcc9
$1547280717164BqYSL:localhost	sha256	\\xd09b5cea655c671f811c69b415a4c74613162f881751577fdb9963541413aa15
$1547280734165AejNq:localhost	sha256	\\x42d8d473e27bf6ac1a179facc6acd86e81dc82339e3e60448b678b23e60af982
$1547280737166XHlsG:localhost	sha256	\\x77fc63ecb0879782a50f2c66bdc6b2cf85ee1de4aa733d64346429ecc39e1e7d
$1547280753167iiLNC:localhost	sha256	\\x106a8a95eb235afea6f62c94bc3fe997d4d64526ab57f3ec901c66e8d301ea12
$1547280755168RTqof:localhost	sha256	\\x508fd591ac522d18dc94a6f490c6b2cf4c4bc4bb157de10dbd497cec21ce7a95
$1547280758169QBLYK:localhost	sha256	\\xcbf2d99b00c4f9d0bf76fe6d1119287d157526a172fddc9cf0cc0cf88294fb2f
$1547280759170XdQji:localhost	sha256	\\x987b5c561ad6a499a442ef54842ec92f6a7d51c2689be452606e86e79de786ab
$1547280764171pBzRc:localhost	sha256	\\x182d57a0cba5f4bfe14300011b203c80090c56ab558af7c89c9ad40a574df5d8
$1547280816172DhRcw:localhost	sha256	\\xa228238456b94a4fd92898c0a205c40b2d87e3cbae795e16a9320e3065321192
$1547280820173UXJMb:localhost	sha256	\\xac5101dd6eb81eeccca11a8fe49949b2bc7ead31109fc38521e056356372a1af
$1547280825174yozNU:localhost	sha256	\\xa51c94f852a191253930d33c16f80c49ba371bfaab3dc5a0862806acc28194b5
$1547280856175DGEZm:localhost	sha256	\\x6bef5e6821e65d807bf935738257ee86a12d93adcb3ffb1d1507f13281a56863
$1547281038176RAJob:localhost	sha256	\\x418a9f3fcd2ab6ddec3aacff572e6207f687c4b3f5f01d19b60547e073d37e2c
$1547281042177bmAPI:localhost	sha256	\\xef9ee496f37cac3e24a78189e6a81f562988baabb41f9c7934db46f30b730115
$1547281644178FBthK:localhost	sha256	\\x6f51fbd16fd218cb4195c656d0794c9bdc4f223b45bd27cca080a75f1666918f
$1547281718179tyKcU:localhost	sha256	\\x096c7c69f25dba26d37aa6acf0d9a0a0d7347fe5d23f3f318c980c84010505cb
$1547281876180XjrWa:localhost	sha256	\\x21fa3dc44439425ed1214e109adbbfd80267ca7cf95277ffabe8622ef6a41bb6
$1547282273181ZFMBT:localhost	sha256	\\x143475892fe23fe5664c561bd8e432321b5ffd64b1b206ecc35bb9cec51964b8
$1547282306182UochL:localhost	sha256	\\x2d23d3d018b76adc04d0628070bac6a86db69ee878251997ff8895c44dac7879
$1547282369183tZBnm:localhost	sha256	\\xda24878a3c37d5c8e2bc2af5bb7761047a3a22d0123e14e8bb3c1e107c22f96c
$1547282552184vQlUg:localhost	sha256	\\x16c87a807bae18bc47aabe74793d14af0583a6d72c0cabf2103d1c84b84faa6f
$1547282554185Mrxeo:localhost	sha256	\\x1865d7db20e7026a244008ba5ae2dc21286c4c0931c192ab796b998fea71d3b0
$1547282555186bBEHl:localhost	sha256	\\x73034a37a9b53177e1e87d30be02063e93145c17020f3ad848286b6d749b2946
$1547282556187hjEiN:localhost	sha256	\\xee1853537fbe391ffaa2ee70643dbc281025eed4b41dbbb8fd40ec7602d12131
$1547282564188gOZON:localhost	sha256	\\xbcf6bd39122197c46800b9708bc99de796f1263b42dd7f720e09a23f0e609792
$1547282567189pGIuv:localhost	sha256	\\x3da061c4977f530e4f212533878186aff09cc3eeccc993450ffe8b4b7ec17232
$1547282608190GmCUl:localhost	sha256	\\x2227bfa0d5da1a50ced99b3a3350de5b6299ee78decdcd2be96740b0de7f5335
$1547282610191tyhdp:localhost	sha256	\\x2da9db7d4c05f5c34b087ff6c3a467111bcfca32d1ace6d00a3f734d4afcf4d4
$1547282611192tMYPw:localhost	sha256	\\x0a89fd00438f35a9586abb5beb1b94d1c97bf17a3f4d17f6647635f7743180f9
$1547282613193PvaJn:localhost	sha256	\\xed69a845c7a8dec250445f2aa7ae39c8bcbee7b1f5102f4fe724a2303344d0b4
$1547282614194gxwNC:localhost	sha256	\\x5de856dd1f8d7814c39d05f5bc4f0e1d7cf33c6a6dc371346b1f0a5392885ffa
$1547282627197zwhxS:localhost	sha256	\\xbdbe51b90f6999dedf2e83f28937cb4cc86523579483754812ea8258f21444a9
$1547282629198eGjsr:localhost	sha256	\\x45da2d2de212a071374b12946b030ec928a358db18bf7856047d9d731e6c9cb6
$1547282637202lPgPc:localhost	sha256	\\x8942f3ab1c2fe23d414a61b61e86f8dc6fcfbb518d516fcd6a31f5a113ac916a
$1547282638206MMkPI:localhost	sha256	\\x4e9dbef0b75da89a7ec72ba4c38a1974e8c05fbbf0ac559b8a2762a345441dc8
$1547282658214BrfCn:localhost	sha256	\\x77d5b15bd145972588de076dde967cf913891d8baf28fffcb06a086668338313
$1547282673221rajqD:localhost	sha256	\\xa6d642a1a4d61c3f8680774602bf564bb415cc0abb071ab15491f521cd05e349
$1547282625195gAcfj:localhost	sha256	\\xd49accc19808143cd6435c5c3cd4eba3ea45ba052483a47cd16743e990490ae0
$1547282626196TcRsD:localhost	sha256	\\x441f0a4e04e5372de291ff5379d7062e1bae2a85c036697f89d0deed10e1a8d4
$1547282668219nlCAE:localhost	sha256	\\x352a5f3ba2d1473d11b1dcaf17d3a9409715b06de6edfe00a776baeb88af7d5e
$1547282637199tWnNa:localhost	sha256	\\x66f84c331a9574523fbd9da3b5cf9d1777ab98c27e4bf83b2a74c3a993993796
$1547282638204RNlYZ:localhost	sha256	\\x45b970b8f85650401b9e767767f5f7e5b530bd720e7b875dd4680655a4ff5a66
$1547282637200HCoQh:localhost	sha256	\\xd043fbfb1452c43d4ab7f438715096b70d893aad6502ab9762a0ddccef8ce0b4
$1547282653212xnlDS:localhost	sha256	\\x95cbf432e0644f45892692bed4d2dc1e5ea2f00a946c27504282760d3bbf89b1
$1547282637201dRtCQ:localhost	sha256	\\x473a39aea3fc561afd8f86d19a23c9c386ea5bca7dc78ee4deb680818addb8c9
$1547282638203erEwp:localhost	sha256	\\xc66baaf8e80016e245a8f93692d94449191215e54fc0d53580a680ea16a6aca4
$1547282643208BfeRU:localhost	sha256	\\x82ad5cb00951e3654141d86ddf2b07145820fe414e929dee106a29f4f8ef4e37
$1547282648210wUJTL:localhost	sha256	\\xbe9bcac7955a471f925a3c249cb9ffbebb287d0767a6fb6afe29bd6309506007
$1547282663217xmKxc:localhost	sha256	\\xf4e57b1763198de722a2d0a492618c7fcafb8ed3d4c7fc30dad6f591798bcdbf
$1547282678223Kcqpm:localhost	sha256	\\xaed2bba4f7674a9b79a1a353b0e216b353fa9b58b13436539c5ea4f1bf2f0f58
$15472864650EOLwc:localhost	sha256	\\x7ba703ae490583199e4bf277bc8ac79a8fddd481a89914fed6360616dc98f6c7
$15472864681LRSdm:localhost	sha256	\\x15e3cabcc31a2e31de01a38db7ecb4675ac4ec784b36054c6ea5dbb493ca34ec
$15472864692BQMAT:localhost	sha256	\\x14eb7061ae1863e8c05aa30f0b62f40f25805fb58ad8d6ebf52c72e4fd16ab41
$15472864703LZpNb:localhost	sha256	\\x8019b183d7faa3130c04b4b5c06f3ad6c876a985b884ecfdf0c3b8505bf0253e
$15472864724KanSK:localhost	sha256	\\x10b996447068f086883a8b70c1f1ea3a38e508a817257182cdce58467784ae19
$15472864735bRxfM:localhost	sha256	\\x34c4e2ada73bff0d5960c6f418f24256b6b2e197545b65ece1a9be8b2c19f40f
$15472864756QXetv:localhost	sha256	\\xa9c0a77dea99881b4a9d6fadd051cf71e214b3ded159f221fb152880fe9d4378
$15472865227IBpem:localhost	sha256	\\x2590f712ae5f732ed0b7b2108d0565ac475891349286f3faa75410afbf14c799
$15472865308jlsUe:localhost	sha256	\\xb36b61dc04489e32cd376a0d6ed248694af0ca43eb599ef78e793efcb5960474
$15472865379qjJPV:localhost	sha256	\\x82ade79c94d2fb2995e21030770db04b9b15264de3b402e897507807f3d66ce7
$154728654910jVIgS:localhost	sha256	\\xb68f73494859e521517baa510576a0e68f3e38a30b6a324697094f35fd11e7d9
$154728655711QTgup:localhost	sha256	\\xcf14e11dcb5a045c19cdd1d88782bc28df6527e30fac0fb2514ed01a7717565b
\.


--
-- Data for Name: event_reports; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_reports (id, received_ts, room_id, event_id, user_id, reason, content) FROM stdin;
\.


--
-- Data for Name: event_search; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_search (event_id, room_id, sender, key, vector, origin_server_ts, stream_ordering) FROM stdin;
$154714264913PCUQS:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.name	'firstpubl':1	1547142649227	14
$154714412415WRVyj:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547144124451	16
$154714438526deOTX:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuaoeu':1	1547144385657	26
$154714438727XNbHq:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuaoeuaoeu':1	1547144387154	27
$154714438828svObh:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuaoeuaoeu':1	1547144388398	28
$154714438929Suhxq:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuaoeu':1	1547144389356	29
$154714439530kLEKZ:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547144395626	30
$154714443231YXmpK:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547144432622	31
$154714446132Evhrh:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547144461467	32
$154714447433aWttn:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547144474335	33
$154714447534UQifj:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547144475700	34
$154714447735ZCGXj:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuaoeu':1	1547144477612	35
$154714447936SjGma:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuaoeu':1	1547144479315	36
$154714450937xxzjh:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'ouea':1	1547144509384	37
$154714485938YzCYs:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aeo':1	1547144859276	38
$154714489839jNhPb:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547144898155	39
$154714489940llVyn:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547144899928	40
$154714493741nQcWl:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'oeu':1	1547144937587	41
$154714494442vLOzu:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuaoeu':1	1547144944160	42
$154714497443utMjv:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547144974441	43
$154714497944XQHPs:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuaoeu':1	1547144979588	44
$154714498345nGKFH:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547144983358	45
$154714504446aiIqN:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547145044537	46
$154714504947xvIss:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547145049386	47
$154714505048dWZpP:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547145050716	48
$154714505249jNMbA:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547145052214	49
$154714506450XWsqc:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aeou':1	1547145064335	50
$154714508851gyeED:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547145088941	51
$154714513052twTnQ:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547145130218	52
$154714513153wozrV:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547145131706	53
$154714514854gxKZt:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aeou':1	1547145148052	54
$154714516355TZkpl:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547145163799	55
$154714523956frAuI:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'oeau':1	1547145239849	56
$154714524157LQlkn:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aeu':1	1547145241632	57
$154714526858lzwnp:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547145268693	58
$154714527259ArrwP:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'oeu':1	1547145272412	59
$154718807060Osxiw:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547188070953	60
$154718811161PDsGA:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547188111729	61
$154719130162RgkdQ:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'oeu':1	1547191301746	62
$154719143563hheAg:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547191435394	63
$154719144064kEzNq:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'oeu':1	1547191440252	64
$154719151365zvWZO:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547191513933	65
$154719152466oQvOE:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547191524079	66
$154719164767efuXJ:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547191647315	67
$154719165168NYIll:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547191651156	68
$154719247969KPEUm:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547192479007	69
$154719339270SMjRz:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547193392569	70
$154719339771HhoBo:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547193397709	71
$154719344372iKEnw:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547193443794	72
$154719347073jkPIF:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547193470971	73
$154719378074ykqqG:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547193780223	74
$154719491875LeoON:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547194918655	75
$154719496876HQbNA:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'oaeu':1	1547194968541	76
$154719500977pGQXX:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aeou':1	1547195009476	77
$154719502078SFZFP:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547195020422	78
$154719505679wchms:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547195056740	79
$154719508580jYTcz:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547195085140	80
$154719514481IOBiR:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547195144401	81
$154719514682XMEKF:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547195146024	82
$154719519283zKOPF:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547195192917	83
$154719521084EQDIT:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547195210852	84
$154719531387IgQOF:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547195313573	87
$154719540291vvcgV:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547195402984	91
$1547201274100AXvny:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuaoeu':1	1547201274438	100
$1547201298101MsJGQ:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547201298386	101
$1547201299102nrFQP:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuaoeu':1	1547201299865	102
$1547201310104XQQzj:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuaoeu':1	1547201310442	104
$1547201345105jVolj:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547201345532	105
$1547201455106obHen:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547201455036	106
$1547209037112vjLNr:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547209037723	112
$1547209043113TVkrB:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547209043964	113
$1547220194124AQdWA:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aeu':1	1547220194742	124
$1547220200129xNEFN:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547220200820	129
$154719524685MEsPE:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547195246834	85
$154719527986LWiBd:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547195279780	86
$154719540493KHAxf:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547195404040	93
$154719547395BoSSt:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547195473728	95
$1547201566108vIMzG:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547201566830	108
$1547209017111VCOtq:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547209017897	111
$1547220025118yFXAz:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'фыва':1	1547220025443	118
$1547220196125pygpM:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547220196174	125
$1547220198127qDjZB:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547220198460	127
$154719537488sBeaz:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547195374543	88
$1547209096114BlJbe:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547209096338	114
$1547220191122fXIkm:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547220191706	122
$154719537689wbEAt:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547195376125	89
$1547201301103APSbA:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuaoeu':1	1547201301519	103
$1547209015110ILKew:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547209015256	110
$154719540290lClpJ:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547195402209	90
$154719540392cuLjJ:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547195403479	92
$154719547294JJsmq:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547195472260	94
$154719550396cyAjC:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aeuo':1	1547195503581	96
$154720039497BQXbf:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'фва':1	1547200394229	97
$154720071099yrpdB:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547200710055	99
$1547203164109HWxxp:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547203164276	109
$1547220182121VEzRa:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547220182801	121
$1547220193123fBQYD:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547220193448	123
$1547220219130eqWPP:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aeou':1	1547220219400	130
$154720043498SQgyh:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'eouoa':1	1547200434215	98
$1547201474107QSZzp:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547201474808	107
$1547209171115HwvmV:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547209171015	115
$1547209244116RahcN:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547209244988	116
$1547211554117Elhng:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547211554975	117
$1547220096119DwtHP:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547220096494	119
$1547220105120XlrPA:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547220105629	120
$1547220197126rpVNs:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aeu':1	1547220197323	126
$1547220199128EKqcd:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547220199631	128
$1547220236131oUTpn:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aeou':1	1547220236656	131
$1547220258132jXsNq:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547220258037	132
$1547220271133nWAgW:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547220271683	133
$1547220330134ibkVz:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547220330417	134
$1547220332135nCFHQ:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547220332678	135
$1547220334136ylgXz:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547220334846	136
$1547220336137dJMop:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547220336569	137
$1547220337138tFafe:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547220337984	138
$1547220342139OPXTO:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aeou':1	1547220342997	139
$1547220358140eyxTo:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuaoeu':1	1547220358197	140
$1547220502141QlNvD:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547220502284	141
$1547279183142YOhis:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'hello':1	1547279183389	142
$1547279184143GVbKe:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547279184680	143
$1547279185144ElypB:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body		1547279185624	144
$1547279186145UMjYo:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'data':1	1547279186657	145
$1547279187146HVLNT:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body		1547279187601	146
$1547279189147gYZsO:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547279189057	147
$1547279190148LahLH:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547279190117	148
$1547279319149EgmWE:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547279319332	149
$1547279319150fMLrf:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuao':1	1547279319858	150
$1547279319151MaOud:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'eu':1	1547279319992	151
$1547279320152DJzGw:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547279320178	152
$1547279320153eLKOp:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547279320531	153
$1547279321154qYYIA:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuaoeuaoeu':1	1547279321588	154
$1547279331155MIaaY:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuaoeu':1	1547279331146	155
$1547279331156JREIt:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuaoeu':1	1547279331898	156
$1547279332157nmQRp:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuaoeu':1	1547279332580	157
$1547279333158JjmRS:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuaoeu':1	1547279333320	158
$1547279334159OmRvd:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuaoeu':1	1547279334068	159
$1547279335160XSwVw:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuaoeu':1	1547279335019	160
$1547280627161jyqzw:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547280627840	161
$1547280712162vCSiP:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aeou':1	1547280712991	162
$1547280714163OzTSL:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aeou':1	1547280714769	163
$1547280717164BqYSL:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547280717134	164
$1547280734165AejNq:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547280734647	165
$1547280737166XHlsG:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547280737186	166
$1547280753167iiLNC:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547280753243	167
$1547280755168RTqof:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547280755776	168
$1547280758169QBLYK:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547280758076	169
$1547280759170XdQji:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547280759943	170
$1547280764171pBzRc:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body		1547280764990	171
$1547280816172DhRcw:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547280816844	172
$1547280820173UXJMb:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body		1547280820088	173
$1547280825174yozNU:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'other':1	1547280825147	174
$1547280856175DGEZm:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547280856607	175
$1547281038176RAJob:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547281038572	176
$1547281042177bmAPI:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body		1547281042153	177
$1547281644178FBthK:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547281644041	178
$1547281718179tyKcU:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547281718475	179
$1547282555186bBEHl:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body		1547282555460	186
$1547281876180XjrWa:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547281876404	180
$1547282610191tyhdp:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body		1547282610540	191
$1547282273181ZFMBT:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547282273572	181
$1547282611192tMYPw:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'data':1	1547282611828	192
$1547282306182UochL:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547282306540	182
$1547282564188gOZON:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547282564512	188
$1547282369183tZBnm:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547282369247	183
$1547282554185Mrxeo:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body		1547282554434	185
$1547282567189pGIuv:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'1':1	1547282567931	189
$1547282552184vQlUg:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547282552486	184
$1547282556187hjEiN:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'data':1	1547282556518	187
$1547282608190GmCUl:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547282608554	190
$1547282613193PvaJn:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'other':1	1547282613308	193
$1547282614194gxwNC:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547282614525	194
$1547282625195gAcfj:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body		1547282625718	195
$1547282626196TcRsD:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'data':1	1547282626890	196
$1547282627197zwhxS:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body		1547282627901	197
$1547282629198eGjsr:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'other':1	1547282629212	198
$1547282637199tWnNa:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeuaoe':1	1547282637407	199
$1547282637200HCoQh:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'uao':1	1547282637567	200
$1547282637201dRtCQ:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'eu':1	1547282637728	201
$1547282637202lPgPc:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547282637854	202
$1547282638203erEwp:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547282638034	203
$1547282638204RNlYZ:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoe':1	1547282638188	204
$1547282638206MMkPI:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'ua':1	1547282638591	205
$1547282643208BfeRU:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'oeu':1	1547282643616	206
$1547282648210wUJTL:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'aoeu':1	1547282648588	207
$1547282653212xnlDS:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'ao':1	1547282653605	208
$1547282658214BrfCn:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'eu':1	1547282658574	209
$1547282663217xmKxc:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'hello':1	1547282663580	210
$1547282668219nlCAE:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'1':1	1547282668578	211
$1547282673221rajqD:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547282673581	212
$1547282678223Kcqpm:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'other':1	1547282678581	213
$15472864650EOLwc:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547286465959	214
$15472864681LRSdm:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body		1547286468481	215
$15472864692BQMAT:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body		1547286469613	216
$15472864703LZpNb:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'data':1	1547286470552	217
$15472864724KanSK:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'test':1	1547286472565	218
$15472864735bRxfM:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'hello':1	1547286473578	219
$15472864756QXetv:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'pipec':1	1547286475875	220
$15472865227IBpem:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'default':11 'depend':34 'differ':36 'exampl':20 'introduc':27 'less.js':7 'live':23 'modifyvar':4 'overrid':9 'playground':24 'popular':29 'provid':5 'use':3,18 'valu':12 'variabl':15 'way':30 'workflow':37	1547286522291	221
$15472865308jlsUe:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'antd':6 'exclud':5 'less':14 'less-load':13 'loader':15 'modul':10 'node':9 'note':1 'packag':7 'use':12	1547286530288	222
$15472865379qjJPV:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'ant':2 'design':3 'entri':7 'import':1 'less':6 'style':4	1547286537254	223
$154728654910jVIgS:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'avoid':3 'global':5 'modifi':4 'style':6	1547286549464	224
$154728655711QTgup:localhost	!CrvkKxgetahhVIwnyX:localhost	\N	content.body	'ant':3,24,41 'ant-design':2,23,40 'bodi':16 'current':1 'design':4,6,25,42 'eg':15 'etc':17 'exist':31 'experi':10 'global':13,45 'integr':22 'like':35 'modifi':12 'need':20 'overrid':44 'part':28 'prevent':39 'style':14,46 'want':37 'websit':32 'whole':9	1547286557049	225
\.


--
-- Data for Name: event_signatures; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_signatures (event_id, signature_name, key_id, signature) FROM stdin;
\.


--
-- Data for Name: event_to_state_groups; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_to_state_groups (event_id, state_group) FROM stdin;
$15471426300pPrwQ:localhost	1
$15471426301dPFwo:localhost	2
$15471426302pIqiF:localhost	3
$15471426303YCSmZ:localhost	4
$15471426304BRdxH:localhost	5
$15471426305IErDp:localhost	6
$15471426487fdcng:localhost	8
$15471426498QYDnP:localhost	9
$15471426499olYQy:localhost	10
$154714264910qNuKi:localhost	11
$154714264911TWsje:localhost	12
$154714264912SGfjg:localhost	13
$154714264913PCUQS:localhost	14
$154714266714gvEsJ:localhost	15
$154714412415WRVyj:localhost	15
$154714428316KLrwW:localhost	16
$154714428317sWMac:localhost	17
$154714428318OamJt:localhost	18
$154714428319jqvHZ:localhost	19
$154714428320dqSvn:localhost	20
$154714428321iaMIA:localhost	21
$154714436223plixL:localhost	23
$154714436224LoFLm:localhost	24
$154714438325bxgqT:localhost	25
$154714438526deOTX:localhost	25
$154714438727XNbHq:localhost	25
$154714438828svObh:localhost	25
$154714438929Suhxq:localhost	25
$154714439530kLEKZ:localhost	25
$154714443231YXmpK:localhost	25
$154714446132Evhrh:localhost	25
$154714447433aWttn:localhost	25
$154714447534UQifj:localhost	25
$154714447735ZCGXj:localhost	25
$154714447936SjGma:localhost	25
$154714450937xxzjh:localhost	25
$154714485938YzCYs:localhost	25
$154714489839jNhPb:localhost	25
$154714489940llVyn:localhost	25
$154714493741nQcWl:localhost	25
$154714494442vLOzu:localhost	25
$154714497443utMjv:localhost	25
$154714497944XQHPs:localhost	25
$154714498345nGKFH:localhost	25
$154714504446aiIqN:localhost	25
$154714504947xvIss:localhost	25
$154714505048dWZpP:localhost	25
$154714505249jNMbA:localhost	25
$154714506450XWsqc:localhost	25
$154714508851gyeED:localhost	25
$154714513052twTnQ:localhost	25
$154714513153wozrV:localhost	25
$154714514854gxKZt:localhost	25
$154714516355TZkpl:localhost	25
$154714523956frAuI:localhost	25
$154714524157LQlkn:localhost	25
$154714526858lzwnp:localhost	25
$154714527259ArrwP:localhost	25
$154718807060Osxiw:localhost	25
$154718811161PDsGA:localhost	25
$154719130162RgkdQ:localhost	25
$154719143563hheAg:localhost	25
$154719144064kEzNq:localhost	25
$154719151365zvWZO:localhost	25
$154719152466oQvOE:localhost	25
$154719164767efuXJ:localhost	25
$154719165168NYIll:localhost	25
$154719247969KPEUm:localhost	25
$154719339270SMjRz:localhost	25
$154719339771HhoBo:localhost	25
$154719344372iKEnw:localhost	25
$154719347073jkPIF:localhost	25
$154719378074ykqqG:localhost	25
$154719491875LeoON:localhost	25
$154719496876HQbNA:localhost	25
$154719500977pGQXX:localhost	25
$154719502078SFZFP:localhost	25
$154719505679wchms:localhost	25
$154719508580jYTcz:localhost	25
$154719514481IOBiR:localhost	25
$154719514682XMEKF:localhost	25
$154719519283zKOPF:localhost	25
$154719521084EQDIT:localhost	25
$154719524685MEsPE:localhost	25
$154719527986LWiBd:localhost	25
$154719531387IgQOF:localhost	25
$154719537488sBeaz:localhost	25
$154719537689wbEAt:localhost	25
$154719540290lClpJ:localhost	25
$154719540291vvcgV:localhost	25
$154719540392cuLjJ:localhost	25
$154719540493KHAxf:localhost	25
$154719547294JJsmq:localhost	25
$154719547395BoSSt:localhost	25
$154719550396cyAjC:localhost	25
$154720039497BQXbf:localhost	25
$154720043498SQgyh:localhost	25
$154720071099yrpdB:localhost	25
$1547201274100AXvny:localhost	25
$1547201298101MsJGQ:localhost	25
$1547201299102nrFQP:localhost	25
$1547201301103APSbA:localhost	25
$1547201310104XQQzj:localhost	25
$1547201345105jVolj:localhost	25
$1547201455106obHen:localhost	25
$1547201474107QSZzp:localhost	25
$1547201566108vIMzG:localhost	25
$1547203164109HWxxp:localhost	25
$1547209015110ILKew:localhost	25
$1547209017111VCOtq:localhost	25
$1547209037112vjLNr:localhost	25
$1547209043113TVkrB:localhost	25
$1547209096114BlJbe:localhost	25
$1547209171115HwvmV:localhost	25
$1547209244116RahcN:localhost	25
$1547211554117Elhng:localhost	25
$1547220025118yFXAz:localhost	25
$1547220096119DwtHP:localhost	25
$1547220105120XlrPA:localhost	25
$1547220182121VEzRa:localhost	25
$1547220191122fXIkm:localhost	25
$1547279319149EgmWE:localhost	25
$1547279321154qYYIA:localhost	25
$1547220193123fBQYD:localhost	25
$1547220194124AQdWA:localhost	25
$1547220200129xNEFN:localhost	25
$1547220219130eqWPP:localhost	25
$1547220258132jXsNq:localhost	25
$1547220332135nCFHQ:localhost	25
$1547220334136ylgXz:localhost	25
$1547220358140eyxTo:localhost	25
$1547279186145UMjYo:localhost	25
$1547279333158JjmRS:localhost	25
$1547279334159OmRvd:localhost	25
$1547280627161jyqzw:localhost	25
$1547280712162vCSiP:localhost	25
$1547280737166XHlsG:localhost	25
$1547280755168RTqof:localhost	25
$1547280758169QBLYK:localhost	25
$1547280759170XdQji:localhost	25
$1547280764171pBzRc:localhost	25
$1547220196125pygpM:localhost	25
$1547220236131oUTpn:localhost	25
$1547279187146HVLNT:localhost	25
$1547279319150fMLrf:localhost	25
$1547220197126rpVNs:localhost	25
$1547220198127qDjZB:localhost	25
$1547220271133nWAgW:localhost	25
$1547220342139OPXTO:localhost	25
$1547279184143GVbKe:localhost	25
$1547279189147gYZsO:localhost	25
$1547279319151MaOud:localhost	25
$1547279320152DJzGw:localhost	25
$1547279331155MIaaY:localhost	25
$1547279331156JREIt:localhost	25
$1547280816172DhRcw:localhost	25
$1547280825174yozNU:localhost	25
$1547220199128EKqcd:localhost	25
$1547220330134ibkVz:localhost	25
$1547220336137dJMop:localhost	25
$1547220337138tFafe:localhost	25
$1547220502141QlNvD:localhost	25
$1547279183142YOhis:localhost	25
$1547279185144ElypB:localhost	25
$1547279190148LahLH:localhost	25
$1547279320153eLKOp:localhost	25
$1547279332157nmQRp:localhost	25
$1547279335160XSwVw:localhost	25
$1547280714163OzTSL:localhost	25
$1547280717164BqYSL:localhost	25
$1547280734165AejNq:localhost	25
$1547280753167iiLNC:localhost	25
$1547280820173UXJMb:localhost	25
$1547280856175DGEZm:localhost	25
$1547281038176RAJob:localhost	25
$1547281042177bmAPI:localhost	25
$1547281644178FBthK:localhost	25
$1547281718179tyKcU:localhost	25
$1547281876180XjrWa:localhost	25
$1547282273181ZFMBT:localhost	25
$1547282306182UochL:localhost	25
$1547282369183tZBnm:localhost	25
$1547282552184vQlUg:localhost	25
$1547282554185Mrxeo:localhost	25
$1547282555186bBEHl:localhost	25
$1547282556187hjEiN:localhost	25
$1547282564188gOZON:localhost	25
$1547282567189pGIuv:localhost	25
$1547282608190GmCUl:localhost	25
$1547282610191tyhdp:localhost	25
$1547282611192tMYPw:localhost	25
$1547282613193PvaJn:localhost	25
$1547282614194gxwNC:localhost	25
$1547282625195gAcfj:localhost	25
$1547282626196TcRsD:localhost	25
$1547282627197zwhxS:localhost	25
$1547282629198eGjsr:localhost	25
$1547282637199tWnNa:localhost	25
$1547282637200HCoQh:localhost	25
$1547282637201dRtCQ:localhost	25
$1547282637202lPgPc:localhost	25
$1547282638203erEwp:localhost	25
$1547282638204RNlYZ:localhost	25
$1547282638206MMkPI:localhost	25
$1547282643208BfeRU:localhost	25
$1547282648210wUJTL:localhost	25
$1547282653212xnlDS:localhost	25
$1547282658214BrfCn:localhost	25
$1547282663217xmKxc:localhost	25
$1547282668219nlCAE:localhost	25
$1547282673221rajqD:localhost	25
$1547282678223Kcqpm:localhost	25
$15472864650EOLwc:localhost	25
$15472864681LRSdm:localhost	25
$15472864692BQMAT:localhost	25
$15472864703LZpNb:localhost	25
$15472864724KanSK:localhost	25
$15472864735bRxfM:localhost	25
$15472864756QXetv:localhost	25
$15472865227IBpem:localhost	25
$15472865308jlsUe:localhost	25
$15472865379qjJPV:localhost	25
$154728654910jVIgS:localhost	25
$154728655711QTgup:localhost	25
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.events (stream_ordering, topological_ordering, event_id, type, room_id, content, unrecognized_keys, processed, outlier, depth, origin_server_ts, received_ts, sender, contains_url) FROM stdin;
2	1	$15471426300pPrwQ:localhost	m.room.create	!mpvAGWWPEpWsNydYnN:localhost	\N	\N	t	f	1	1547142630337	1547142630360	@alexes:localhost	f
3	2	$15471426301dPFwo:localhost	m.room.member	!mpvAGWWPEpWsNydYnN:localhost	\N	\N	t	f	2	1547142630382	1547142630443	@alexes:localhost	f
4	3	$15471426302pIqiF:localhost	m.room.power_levels	!mpvAGWWPEpWsNydYnN:localhost	\N	\N	t	f	3	1547142630459	1547142630503	@alexes:localhost	f
5	4	$15471426303YCSmZ:localhost	m.room.join_rules	!mpvAGWWPEpWsNydYnN:localhost	\N	\N	t	f	4	1547142630519	1547142630556	@alexes:localhost	f
6	5	$15471426304BRdxH:localhost	m.room.history_visibility	!mpvAGWWPEpWsNydYnN:localhost	\N	\N	t	f	5	1547142630566	1547142630604	@alexes:localhost	f
7	6	$15471426305IErDp:localhost	m.room.guest_access	!mpvAGWWPEpWsNydYnN:localhost	\N	\N	t	f	6	1547142630616	1547142630648	@alexes:localhost	f
8	1	$15471426487fdcng:localhost	m.room.create	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	1	1547142648991	1547142649010	@alexes:localhost	f
9	2	$15471426498QYDnP:localhost	m.room.member	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	2	1547142649024	1547142649049	@alexes:localhost	f
10	3	$15471426499olYQy:localhost	m.room.power_levels	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	3	1547142649060	1547142649092	@alexes:localhost	f
11	4	$154714264910qNuKi:localhost	m.room.join_rules	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	4	1547142649104	1547142649139	@alexes:localhost	f
12	5	$154714264911TWsje:localhost	m.room.history_visibility	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	5	1547142649149	1547142649179	@alexes:localhost	f
13	6	$154714264912SGfjg:localhost	m.room.guest_access	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	6	1547142649188	1547142649218	@alexes:localhost	f
14	7	$154714264913PCUQS:localhost	m.room.name	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	7	1547142649227	1547142649257	@alexes:localhost	f
15	8	$154714266714gvEsJ:localhost	m.room.related_groups	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	8	1547142667742	1547142667760	@alexes:localhost	f
16	9	$154714412415WRVyj:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	9	1547144124451	1547144124459	@alexes:localhost	f
17	1	$154714428316KLrwW:localhost	m.room.create	!RgDCNwMiMxKykVVClV:localhost	\N	\N	t	f	1	1547144283458	1547144283477	@alexes1:localhost	f
18	2	$154714428317sWMac:localhost	m.room.member	!RgDCNwMiMxKykVVClV:localhost	\N	\N	t	f	2	1547144283510	1547144283556	@alexes1:localhost	f
19	3	$154714428318OamJt:localhost	m.room.power_levels	!RgDCNwMiMxKykVVClV:localhost	\N	\N	t	f	3	1547144283571	1547144283603	@alexes1:localhost	f
20	4	$154714428319jqvHZ:localhost	m.room.join_rules	!RgDCNwMiMxKykVVClV:localhost	\N	\N	t	f	4	1547144283618	1547144283656	@alexes1:localhost	f
21	5	$154714428320dqSvn:localhost	m.room.history_visibility	!RgDCNwMiMxKykVVClV:localhost	\N	\N	t	f	5	1547144283665	1547144283710	@alexes1:localhost	f
22	6	$154714428321iaMIA:localhost	m.room.guest_access	!RgDCNwMiMxKykVVClV:localhost	\N	\N	t	f	6	1547144283720	1547144283755	@alexes1:localhost	f
23	10	$154714436223plixL:localhost	m.room.join_rules	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	10	1547144362760	1547144362791	@alexes:localhost	f
24	10	$154714436224LoFLm:localhost	org.matrix.room.preview_urls	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	10	1547144362764	1547144362842	@alexes:localhost	f
25	11	$154714438325bxgqT:localhost	m.room.member	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	11	1547144383839	1547144383900	@alexes1:localhost	f
26	12	$154714438526deOTX:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	12	1547144385657	1547144385682	@alexes1:localhost	f
27	13	$154714438727XNbHq:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	13	1547144387154	1547144387168	@alexes1:localhost	f
28	14	$154714438828svObh:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	14	1547144388398	1547144388413	@alexes1:localhost	f
29	15	$154714438929Suhxq:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	15	1547144389356	1547144389384	@alexes1:localhost	f
30	16	$154714439530kLEKZ:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	16	1547144395626	1547144395640	@alexes1:localhost	f
31	17	$154714443231YXmpK:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	17	1547144432622	1547144432635	@alexes1:localhost	f
32	18	$154714446132Evhrh:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	18	1547144461467	1547144461480	@alexes1:localhost	f
33	19	$154714447433aWttn:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	19	1547144474335	1547144474351	@alexes:localhost	f
34	20	$154714447534UQifj:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	20	1547144475700	1547144475715	@alexes:localhost	f
35	21	$154714447735ZCGXj:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	21	1547144477612	1547144477630	@alexes1:localhost	f
36	22	$154714447936SjGma:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	22	1547144479315	1547144479327	@alexes:localhost	f
37	23	$154714450937xxzjh:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	23	1547144509384	1547144509398	@alexes1:localhost	f
38	24	$154714485938YzCYs:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	24	1547144859276	1547144859295	@alexes1:localhost	f
39	25	$154714489839jNhPb:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	25	1547144898155	1547144898171	@alexes:localhost	f
40	26	$154714489940llVyn:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	26	1547144899928	1547144899965	@alexes1:localhost	f
41	27	$154714493741nQcWl:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	27	1547144937587	1547144937608	@alexes1:localhost	f
42	28	$154714494442vLOzu:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	28	1547144944160	1547144944179	@alexes1:localhost	f
43	29	$154714497443utMjv:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	29	1547144974441	1547144974460	@alexes1:localhost	f
44	30	$154714497944XQHPs:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	30	1547144979588	1547144979608	@alexes1:localhost	f
45	31	$154714498345nGKFH:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	31	1547144983358	1547144983373	@alexes1:localhost	f
46	32	$154714504446aiIqN:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	32	1547145044537	1547145044554	@alexes1:localhost	f
50	36	$154714506450XWsqc:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	36	1547145064335	1547145064348	@alexes1:localhost	f
47	33	$154714504947xvIss:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	33	1547145049386	1547145049397	@alexes1:localhost	f
48	34	$154714505048dWZpP:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	34	1547145050716	1547145050753	@alexes1:localhost	f
49	35	$154714505249jNMbA:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	35	1547145052214	1547145052263	@alexes1:localhost	f
51	37	$154714508851gyeED:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	37	1547145088941	1547145088959	@alexes1:localhost	f
52	38	$154714513052twTnQ:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	38	1547145130218	1547145130230	@alexes:localhost	f
53	39	$154714513153wozrV:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	39	1547145131706	1547145131720	@alexes1:localhost	f
54	40	$154714514854gxKZt:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	40	1547145148052	1547145148067	@alexes1:localhost	f
55	41	$154714516355TZkpl:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	41	1547145163799	1547145163811	@alexes1:localhost	f
56	42	$154714523956frAuI:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	42	1547145239849	1547145239866	@alexes1:localhost	f
57	43	$154714524157LQlkn:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	43	1547145241632	1547145241648	@alexes1:localhost	f
58	44	$154714526858lzwnp:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	44	1547145268693	1547145268710	@alexes1:localhost	f
59	45	$154714527259ArrwP:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	45	1547145272412	1547145272424	@alexes1:localhost	f
60	46	$154718807060Osxiw:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	46	1547188070953	1547188070974	@alexes:localhost	f
61	47	$154718811161PDsGA:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	47	1547188111729	1547188111745	@alexes1:localhost	f
62	48	$154719130162RgkdQ:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	48	1547191301746	1547191301760	@alexes1:localhost	f
63	49	$154719143563hheAg:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	49	1547191435394	1547191435407	@alexes1:localhost	f
64	50	$154719144064kEzNq:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	50	1547191440252	1547191440276	@alexes1:localhost	f
65	51	$154719151365zvWZO:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	51	1547191513933	1547191513947	@alexes1:localhost	f
66	52	$154719152466oQvOE:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	52	1547191524079	1547191524093	@alexes1:localhost	f
67	53	$154719164767efuXJ:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	53	1547191647315	1547191647380	@alexes:localhost	f
68	54	$154719165168NYIll:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	54	1547191651156	1547191651171	@alexes1:localhost	f
69	55	$154719247969KPEUm:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	55	1547192479007	1547192479021	@alexes1:localhost	f
70	56	$154719339270SMjRz:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	56	1547193392569	1547193392580	@alexes1:localhost	f
71	57	$154719339771HhoBo:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	57	1547193397709	1547193397722	@alexes1:localhost	f
72	58	$154719344372iKEnw:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	58	1547193443794	1547193443808	@alexes1:localhost	f
73	59	$154719347073jkPIF:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	59	1547193470971	1547193470983	@alexes1:localhost	f
74	60	$154719378074ykqqG:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	60	1547193780223	1547193780237	@alexes1:localhost	f
75	61	$154719491875LeoON:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	61	1547194918655	1547194918671	@alexes1:localhost	f
76	62	$154719496876HQbNA:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	62	1547194968541	1547194968556	@alexes1:localhost	f
77	63	$154719500977pGQXX:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	63	1547195009476	1547195009490	@alexes1:localhost	f
78	64	$154719502078SFZFP:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	64	1547195020422	1547195020439	@alexes1:localhost	f
79	65	$154719505679wchms:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	65	1547195056740	1547195056754	@alexes1:localhost	f
80	66	$154719508580jYTcz:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	66	1547195085140	1547195085154	@alexes1:localhost	f
81	67	$154719514481IOBiR:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	67	1547195144401	1547195144416	@alexes1:localhost	f
82	68	$154719514682XMEKF:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	68	1547195146024	1547195146039	@alexes1:localhost	f
83	69	$154719519283zKOPF:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	69	1547195192917	1547195192935	@alexes1:localhost	f
84	70	$154719521084EQDIT:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	70	1547195210852	1547195210866	@alexes1:localhost	f
85	71	$154719524685MEsPE:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	71	1547195246834	1547195246845	@alexes1:localhost	f
86	72	$154719527986LWiBd:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	72	1547195279780	1547195279795	@alexes1:localhost	f
87	73	$154719531387IgQOF:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	73	1547195313573	1547195313632	@alexes1:localhost	f
88	74	$154719537488sBeaz:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	74	1547195374543	1547195374559	@alexes1:localhost	f
89	75	$154719537689wbEAt:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	75	1547195376125	1547195376138	@alexes1:localhost	f
90	76	$154719540290lClpJ:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	76	1547195402209	1547195402220	@alexes1:localhost	f
91	77	$154719540291vvcgV:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	77	1547195402984	1547195403012	@alexes1:localhost	f
92	78	$154719540392cuLjJ:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	78	1547195403479	1547195403497	@alexes1:localhost	f
93	79	$154719540493KHAxf:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	79	1547195404040	1547195404082	@alexes1:localhost	f
94	80	$154719547294JJsmq:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	80	1547195472260	1547195472271	@alexes1:localhost	f
95	81	$154719547395BoSSt:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	81	1547195473728	1547195473743	@alexes1:localhost	f
96	82	$154719550396cyAjC:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	82	1547195503581	1547195503598	@alexes1:localhost	f
97	83	$154720039497BQXbf:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	83	1547200394229	1547200394245	@alexes1:localhost	f
98	84	$154720043498SQgyh:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	84	1547200434215	1547200434232	@alexes1:localhost	f
99	85	$154720071099yrpdB:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	85	1547200710055	1547200710074	@alexes1:localhost	f
100	86	$1547201274100AXvny:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	86	1547201274438	1547201274449	@alexes1:localhost	f
104	90	$1547201310104XQQzj:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	90	1547201310442	1547201310457	@alexes1:localhost	f
106	92	$1547201455106obHen:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	92	1547201455036	1547201455053	@alexes1:localhost	f
113	99	$1547209043113TVkrB:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	99	1547209043964	1547209043979	@alexes1:localhost	f
101	87	$1547201298101MsJGQ:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	87	1547201298386	1547201298407	@alexes1:localhost	f
102	88	$1547201299102nrFQP:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	88	1547201299865	1547201299880	@alexes1:localhost	f
105	91	$1547201345105jVolj:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	91	1547201345532	1547201345542	@alexes1:localhost	f
112	98	$1547209037112vjLNr:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	98	1547209037723	1547209037737	@alexes1:localhost	f
103	89	$1547201301103APSbA:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	89	1547201301519	1547201301535	@alexes1:localhost	f
110	96	$1547209015110ILKew:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	96	1547209015256	1547209015305	@alexes1:localhost	f
107	93	$1547201474107QSZzp:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	93	1547201474808	1547201474819	@alexes1:localhost	f
108	94	$1547201566108vIMzG:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	94	1547201566830	1547201566857	@alexes1:localhost	f
109	95	$1547203164109HWxxp:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	95	1547203164276	1547203164297	@alexes1:localhost	f
111	97	$1547209017111VCOtq:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	97	1547209017897	1547209017910	@alexes1:localhost	f
114	100	$1547209096114BlJbe:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	100	1547209096338	1547209096355	@alexes1:localhost	f
115	101	$1547209171115HwvmV:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	101	1547209171015	1547209171036	@alexes1:localhost	f
116	102	$1547209244116RahcN:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	102	1547209244988	1547209245001	@alexes:localhost	f
117	103	$1547211554117Elhng:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	103	1547211554975	1547211554994	@alexes:localhost	f
118	104	$1547220025118yFXAz:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	104	1547220025443	1547220025474	@alexes:localhost	f
119	105	$1547220096119DwtHP:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	105	1547220096494	1547220096510	@alexes:localhost	f
120	106	$1547220105120XlrPA:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	106	1547220105629	1547220105643	@alexes:localhost	f
121	107	$1547220182121VEzRa:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	107	1547220182801	1547220182815	@alexes:localhost	f
122	108	$1547220191122fXIkm:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	108	1547220191706	1547220191721	@alexes:localhost	f
123	109	$1547220193123fBQYD:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	109	1547220193448	1547220193460	@alexes:localhost	f
124	110	$1547220194124AQdWA:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	110	1547220194742	1547220194754	@alexes:localhost	f
125	111	$1547220196125pygpM:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	111	1547220196174	1547220196187	@alexes:localhost	f
126	112	$1547220197126rpVNs:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	112	1547220197323	1547220197337	@alexes:localhost	f
127	113	$1547220198127qDjZB:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	113	1547220198460	1547220198474	@alexes:localhost	f
128	114	$1547220199128EKqcd:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	114	1547220199631	1547220199643	@alexes:localhost	f
129	115	$1547220200129xNEFN:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	115	1547220200820	1547220200832	@alexes:localhost	f
130	116	$1547220219130eqWPP:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	116	1547220219400	1547220219433	@alexes:localhost	f
131	117	$1547220236131oUTpn:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	117	1547220236656	1547220236667	@alexes:localhost	f
132	118	$1547220258132jXsNq:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	118	1547220258037	1547220258052	@alexes:localhost	f
133	119	$1547220271133nWAgW:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	119	1547220271683	1547220271697	@alexes:localhost	f
134	120	$1547220330134ibkVz:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	120	1547220330417	1547220330429	@alexes:localhost	f
135	121	$1547220332135nCFHQ:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	121	1547220332678	1547220332693	@alexes:localhost	f
136	122	$1547220334136ylgXz:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	122	1547220334846	1547220334861	@alexes:localhost	f
137	123	$1547220336137dJMop:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	123	1547220336569	1547220336585	@alexes:localhost	f
138	124	$1547220337138tFafe:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	124	1547220337984	1547220337999	@alexes:localhost	f
139	125	$1547220342139OPXTO:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	125	1547220342997	1547220343023	@alexes:localhost	f
140	126	$1547220358140eyxTo:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	126	1547220358197	1547220358214	@alexes:localhost	f
141	127	$1547220502141QlNvD:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	127	1547220502284	1547220502304	@alexes:localhost	f
142	128	$1547279183142YOhis:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	128	1547279183389	1547279183406	@alexes:localhost	f
143	129	$1547279184143GVbKe:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	129	1547279184680	1547279184697	@alexes:localhost	f
144	130	$1547279185144ElypB:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	130	1547279185624	1547279185640	@alexes:localhost	f
145	131	$1547279186145UMjYo:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	131	1547279186657	1547279186672	@alexes:localhost	f
146	132	$1547279187146HVLNT:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	132	1547279187601	1547279187621	@alexes:localhost	f
147	133	$1547279189147gYZsO:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	133	1547279189057	1547279189070	@alexes:localhost	f
148	134	$1547279190148LahLH:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	134	1547279190117	1547279190134	@alexes:localhost	f
149	135	$1547279319149EgmWE:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	135	1547279319332	1547279319367	@alexes:localhost	f
150	136	$1547279319150fMLrf:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	136	1547279319858	1547279319877	@alexes:localhost	f
151	137	$1547279319151MaOud:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	137	1547279319992	1547279320003	@alexes:localhost	f
152	138	$1547279320152DJzGw:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	138	1547279320178	1547279320193	@alexes:localhost	f
153	139	$1547279320153eLKOp:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	139	1547279320531	1547279320567	@alexes:localhost	f
154	140	$1547279321154qYYIA:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	140	1547279321588	1547279321626	@alexes:localhost	f
155	141	$1547279331155MIaaY:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	141	1547279331146	1547279331162	@alexes:localhost	f
156	142	$1547279331156JREIt:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	142	1547279331898	1547279331913	@alexes:localhost	f
157	143	$1547279332157nmQRp:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	143	1547279332580	1547279332599	@alexes:localhost	f
158	144	$1547279333158JjmRS:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	144	1547279333320	1547279333336	@alexes:localhost	f
168	154	$1547280755168RTqof:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	154	1547280755776	1547280755789	@alexes:localhost	f
170	156	$1547280759170XdQji:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	156	1547280759943	1547280759954	@alexes:localhost	f
159	145	$1547279334159OmRvd:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	145	1547279334068	1547279334083	@alexes:localhost	f
161	147	$1547280627161jyqzw:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	147	1547280627840	1547280627855	@alexes:localhost	f
162	148	$1547280712162vCSiP:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	148	1547280712991	1547280713003	@alexes:localhost	f
166	152	$1547280737166XHlsG:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	152	1547280737186	1547280737198	@alexes:localhost	f
169	155	$1547280758169QBLYK:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	155	1547280758076	1547280758094	@alexes:localhost	f
171	157	$1547280764171pBzRc:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	157	1547280764990	1547280765005	@alexes:localhost	f
160	146	$1547279335160XSwVw:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	146	1547279335019	1547279335036	@alexes:localhost	f
163	149	$1547280714163OzTSL:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	149	1547280714769	1547280714782	@alexes:localhost	f
165	151	$1547280734165AejNq:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	151	1547280734647	1547280734660	@alexes:localhost	f
164	150	$1547280717164BqYSL:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	150	1547280717134	1547280717153	@alexes:localhost	f
173	159	$1547280820173UXJMb:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	159	1547280820088	1547280820102	@alexes:localhost	f
167	153	$1547280753167iiLNC:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	153	1547280753243	1547280753257	@alexes:localhost	f
175	161	$1547280856175DGEZm:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	161	1547280856607	1547280856621	@alexes:localhost	f
172	158	$1547280816172DhRcw:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	158	1547280816844	1547280816859	@alexes:localhost	f
174	160	$1547280825174yozNU:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	160	1547280825147	1547280825170	@alexes:localhost	f
176	162	$1547281038176RAJob:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	162	1547281038572	1547281038587	@alexes:localhost	f
177	163	$1547281042177bmAPI:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	163	1547281042153	1547281042165	@alexes:localhost	f
178	164	$1547281644178FBthK:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	164	1547281644041	1547281644063	@alexes:localhost	f
179	165	$1547281718179tyKcU:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	165	1547281718475	1547281718494	@alexes:localhost	f
180	166	$1547281876180XjrWa:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	166	1547281876404	1547281876420	@alexes:localhost	f
181	167	$1547282273181ZFMBT:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	167	1547282273572	1547282273586	@alexes:localhost	f
182	168	$1547282306182UochL:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	168	1547282306540	1547282306556	@alexes:localhost	f
183	169	$1547282369183tZBnm:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	169	1547282369247	1547282369260	@alexes:localhost	f
184	170	$1547282552184vQlUg:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	170	1547282552486	1547282552501	@alexes:localhost	f
185	171	$1547282554185Mrxeo:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	171	1547282554434	1547282554446	@alexes:localhost	f
186	172	$1547282555186bBEHl:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	172	1547282555460	1547282555477	@alexes:localhost	f
187	173	$1547282556187hjEiN:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	173	1547282556518	1547282556573	@alexes:localhost	f
188	174	$1547282564188gOZON:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	174	1547282564512	1547282564527	@alexes:localhost	f
189	175	$1547282567189pGIuv:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	175	1547282567931	1547282567945	@alexes:localhost	f
190	176	$1547282608190GmCUl:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	176	1547282608554	1547282608572	@alexes:localhost	f
191	177	$1547282610191tyhdp:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	177	1547282610540	1547282610555	@alexes:localhost	f
192	178	$1547282611192tMYPw:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	178	1547282611828	1547282611843	@alexes:localhost	f
193	179	$1547282613193PvaJn:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	179	1547282613308	1547282613336	@alexes:localhost	f
194	180	$1547282614194gxwNC:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	180	1547282614525	1547282614538	@alexes:localhost	f
195	181	$1547282625195gAcfj:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	181	1547282625718	1547282625758	@alexes:localhost	f
196	182	$1547282626196TcRsD:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	182	1547282626890	1547282626936	@alexes:localhost	f
197	183	$1547282627197zwhxS:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	183	1547282627901	1547282627915	@alexes:localhost	f
198	184	$1547282629198eGjsr:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	184	1547282629212	1547282629251	@alexes:localhost	f
199	185	$1547282637199tWnNa:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	185	1547282637407	1547282637426	@alexes:localhost	f
200	186	$1547282637200HCoQh:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	186	1547282637567	1547282637582	@alexes:localhost	f
201	187	$1547282637201dRtCQ:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	187	1547282637728	1547282637747	@alexes:localhost	f
202	188	$1547282637202lPgPc:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	188	1547282637854	1547282637870	@alexes:localhost	f
203	189	$1547282638203erEwp:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	189	1547282638034	1547282638052	@alexes:localhost	f
204	190	$1547282638204RNlYZ:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	190	1547282638188	1547282638202	@alexes:localhost	f
205	191	$1547282638206MMkPI:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	191	1547282638591	1547282638605	@alexes:localhost	f
206	192	$1547282643208BfeRU:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	192	1547282643616	1547282643647	@alexes:localhost	f
207	193	$1547282648210wUJTL:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	193	1547282648588	1547282648630	@alexes:localhost	f
208	194	$1547282653212xnlDS:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	194	1547282653605	1547282653641	@alexes:localhost	f
209	195	$1547282658214BrfCn:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	195	1547282658574	1547282658588	@alexes:localhost	f
210	196	$1547282663217xmKxc:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	196	1547282663580	1547282663604	@alexes:localhost	f
211	197	$1547282668219nlCAE:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	197	1547282668578	1547282668609	@alexes:localhost	f
212	198	$1547282673221rajqD:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	198	1547282673581	1547282673612	@alexes:localhost	f
213	199	$1547282678223Kcqpm:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	199	1547282678581	1547282678613	@alexes:localhost	f
214	200	$15472864650EOLwc:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	200	1547286465959	1547286466004	@alexes:localhost	f
215	201	$15472864681LRSdm:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	201	1547286468481	1547286468499	@alexes:localhost	f
216	202	$15472864692BQMAT:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	202	1547286469613	1547286469627	@alexes:localhost	f
217	203	$15472864703LZpNb:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	203	1547286470552	1547286470565	@alexes:localhost	f
218	204	$15472864724KanSK:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	204	1547286472565	1547286472578	@alexes:localhost	f
219	205	$15472864735bRxfM:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	205	1547286473578	1547286473590	@alexes:localhost	f
220	206	$15472864756QXetv:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	206	1547286475875	1547286475891	@alexes:localhost	f
221	207	$15472865227IBpem:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	207	1547286522291	1547286522307	@alexes:localhost	f
224	210	$154728654910jVIgS:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	210	1547286549464	1547286549477	@alexes:localhost	f
222	208	$15472865308jlsUe:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	208	1547286530288	1547286530301	@alexes:localhost	f
223	209	$15472865379qjJPV:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	209	1547286537254	1547286537268	@alexes:localhost	f
225	211	$154728655711QTgup:localhost	m.room.message	!CrvkKxgetahhVIwnyX:localhost	\N	\N	t	f	211	1547286557049	1547286557064	@alexes:localhost	f
\.


--
-- Data for Name: ex_outlier_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.ex_outlier_stream (event_stream_ordering, event_id, state_group) FROM stdin;
\.


--
-- Data for Name: federation_stream_position; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.federation_stream_position (type, stream_id) FROM stdin;
federation	-1
events	225
\.


--
-- Data for Name: feedback; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.feedback (event_id, feedback_type, target_event_id, sender, room_id) FROM stdin;
\.


--
-- Data for Name: group_attestations_remote; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_attestations_remote (group_id, user_id, valid_until_ms, attestation_json) FROM stdin;
\.


--
-- Data for Name: group_attestations_renewals; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_attestations_renewals (group_id, user_id, valid_until_ms) FROM stdin;
\.


--
-- Data for Name: group_invites; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_invites (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: group_roles; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_roles (group_id, role_id, profile, is_public) FROM stdin;
\.


--
-- Data for Name: group_room_categories; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_room_categories (group_id, category_id, profile, is_public) FROM stdin;
\.


--
-- Data for Name: group_rooms; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_rooms (group_id, room_id, is_public) FROM stdin;
+first:localhost	!CrvkKxgetahhVIwnyX:localhost	f
\.


--
-- Data for Name: group_summary_roles; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_summary_roles (group_id, role_id, role_order) FROM stdin;
\.


--
-- Data for Name: group_summary_room_categories; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_summary_room_categories (group_id, category_id, cat_order) FROM stdin;
\.


--
-- Data for Name: group_summary_rooms; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_summary_rooms (group_id, room_id, category_id, room_order, is_public) FROM stdin;
\.


--
-- Data for Name: group_summary_users; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_summary_users (group_id, user_id, role_id, user_order, is_public) FROM stdin;
\.


--
-- Data for Name: group_users; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.group_users (group_id, user_id, is_admin, is_public) FROM stdin;
+first:localhost	@alexes:localhost	t	t
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.groups (group_id, name, avatar_url, short_description, long_description, is_public, join_policy) FROM stdin;
+first:localhost	first	\N	\N	\N	t	invite
\.


--
-- Data for Name: guest_access; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.guest_access (event_id, room_id, guest_access) FROM stdin;
$15471426305IErDp:localhost	!mpvAGWWPEpWsNydYnN:localhost	can_join
$154714264912SGfjg:localhost	!CrvkKxgetahhVIwnyX:localhost	can_join
$154714428321iaMIA:localhost	!RgDCNwMiMxKykVVClV:localhost	can_join
\.


--
-- Data for Name: history_visibility; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.history_visibility (event_id, room_id, history_visibility) FROM stdin;
$15471426304BRdxH:localhost	!mpvAGWWPEpWsNydYnN:localhost	shared
$154714264911TWsje:localhost	!CrvkKxgetahhVIwnyX:localhost	shared
$154714428320dqSvn:localhost	!RgDCNwMiMxKykVVClV:localhost	shared
\.


--
-- Data for Name: local_group_membership; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.local_group_membership (group_id, user_id, is_admin, membership, is_publicised, content) FROM stdin;
+first:localhost	@alexes:localhost	t	join	f	{}
\.


--
-- Data for Name: local_group_updates; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.local_group_updates (stream_id, group_id, user_id, type, content) FROM stdin;
2	+first:localhost	@alexes:localhost	membership	{"membership": "join", "content": {}}
\.


--
-- Data for Name: local_invites; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.local_invites (stream_id, inviter, invitee, event_id, room_id, locally_rejected, replaced_by) FROM stdin;
\.


--
-- Data for Name: local_media_repository; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.local_media_repository (media_id, media_type, media_length, created_ts, upload_name, user_id, quarantined_by, url_cache, last_access_ts) FROM stdin;
\.


--
-- Data for Name: local_media_repository_thumbnails; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.local_media_repository_thumbnails (media_id, thumbnail_width, thumbnail_height, thumbnail_type, thumbnail_method, thumbnail_length) FROM stdin;
\.


--
-- Data for Name: local_media_repository_url_cache; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.local_media_repository_url_cache (url, response_code, etag, expires_ts, og, media_id, download_ts) FROM stdin;
\.


--
-- Data for Name: monthly_active_users; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.monthly_active_users (user_id, "timestamp") FROM stdin;
\.


--
-- Data for Name: open_id_tokens; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.open_id_tokens (token, ts_valid_until_ms, user_id) FROM stdin;
VcmNmmBRyHvotoiTiVTdKtCE	1547146249487	@alexes:localhost
fyJuKHyNwgqmLgFVbfZuNhTO	1547146249499	@alexes:localhost
tGLAEqFfCeHqKNHEhcjDjxHs	1547146249512	@alexes:localhost
RrrpQqbwxNVtRHSSPOhrPQLo	1547147722706	@alexes:localhost
cQBTRBQjdbyruAVboKQPYipt	1547147722709	@alexes:localhost
DDfyvCGrafBmpWWgBVgBzZYt	1547147722716	@alexes:localhost
vASihARRMcSVkosXuyJWdrnw	1547147780380	@alexes:localhost
fGrwtqtDsVUBwsvCxVJaNtEr	1547147780393	@alexes:localhost
oOhRGPYxuHMyLBoJggkCGWQH	1547147780398	@alexes:localhost
fWZMoRbQgxVIzhokLNkRtjCl	1547147937120	@alexes:localhost
WkPZpxQPRaaUnPTvLegazasY	1547147937127	@alexes:localhost
VmwYlYlSwjTGbcLloRZqWCOi	1547147937139	@alexes:localhost
jnLKVBvHAjFpRswMIhUtgKBA	1547147938486	@alexes:localhost
lcKLGDQhINrSlCoDrcCGPvKm	1547147938575	@alexes:localhost
ixHPDhnDNALSTwpGrmrLdoaN	1547147938593	@alexes:localhost
RjcKUMNzGQXfPAndKsZiIQDH	1547147962942	@alexes:localhost
fbmkmWxxGjaWgepiJquUgvRD	1547147976700	@alexes:localhost
BDZrayqTQKpNquwGAlbgaTza	1547147976710	@alexes:localhost
HdEqRbMaVeoPKMxrJbKoqzZH	1547147976722	@alexes:localhost
FsELUxFKCDLsNnPxnhqoCMZL	1547147977615	@alexes:localhost
yFERHibthkdiWYnCggPGPTTK	1547147977685	@alexes:localhost
zZxjcdNLtrSYDnAjZtMVWnOE	1547147977702	@alexes:localhost
tpfnFwPYFhlPcjuAKqJkekhz	1547147984211	@alexes1:localhost
LRYRqyFrpPUkNBGtbwHyuQMb	1547147984213	@alexes1:localhost
LZiFzaWMulIkJcfDCgLelrsB	1547147984232	@alexes1:localhost
IDyPlbmDRdJFwKPmexRCSjsu	1547148530378	@alexes1:localhost
fUyskAIGAHJWAXeTchOVbMlx	1547148530384	@alexes1:localhost
jWJbqoXfJuiYgldffWAKgyyO	1547148530387	@alexes1:localhost
dNBnyoXfUCOIcDerUxDSXldt	1547148566396	@alexes1:localhost
rBHChqStLjNfOIrJttZTPxHY	1547148566432	@alexes1:localhost
ujPgFFFQqagqLIlApCvlnIpl	1547148566444	@alexes1:localhost
iiHoEGWPOtbpbzRDAAGNzCXe	1547148859807	@alexes1:localhost
HPPHHFpvTxXlZDPYmwKkXwQJ	1547148859821	@alexes1:localhost
mrZMkuLyoIBkHHUFdojAxKJf	1547148859827	@alexes1:localhost
JDgETsYDlSMZSSjMEGnTKsMs	1547191710193	@alexes1:localhost
gaLwJkdvPeqynIgjxIlwlIMQ	1547191710212	@alexes1:localhost
GwAsQoTkLfIhwirnREZXfCwR	1547191710227	@alexes1:localhost
YySAyKeXfgGEVucZKzbbvmzB	1547198650877	@alexes1:localhost
AgyZwyBgSWvDAuSGDaoCaCNs	1547198650887	@alexes1:localhost
krnPgvyctqgBUhSonYWopobB	1547198650891	@alexes1:localhost
irwBNHzSqXnVrBCSUxFmpsga	1547198845091	@alexes1:localhost
yMPzfyypKYBIiMrXeNZpEVVT	1547198845115	@alexes1:localhost
TgnrDVMuNGdjaBNWBdeHykoA	1547198845126	@alexes1:localhost
mvoHvKlBELcmsLWaazFBSgNV	1547198864242	@alexes1:localhost
qlWWdxItRcWJNXLORnMMOHCd	1547198864253	@alexes1:localhost
NYxRxgokElFDLCMLzQiCiTWI	1547198864258	@alexes1:localhost
AevQySUGoFDQCXPqlhKKsnXp	1547198999381	@alexes1:localhost
cyogRicjFtSxbcxijmNCDZmH	1547198999405	@alexes1:localhost
AcwChGZprmYKCvWCQeswhCKi	1547198999419	@alexes1:localhost
PtMgFAQbzVxRjeYNbMeqgCGc	1547199099532	@alexes1:localhost
DRKCRHnyVfqqMdQiHertRxvG	1547199099557	@alexes1:localhost
WryHPxHOKKqZfrTVHTPEurOH	1547199099568	@alexes1:localhost
RreqbSsselBqsQBLQBsTOVYF	1547204873115	@alexes1:localhost
OGQojJICDFjrPPFtkUSWOvSZ	1547204873124	@alexes1:localhost
QJNkPtPYeIPCEnNUuUSyaMgu	1547204873138	@alexes1:localhost
OvMzAxlKRoooBPHvyMuutNyi	1547212694708	@alexes1:localhost
\.


--
-- Data for Name: presence; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.presence (user_id, state, status_msg, mtime) FROM stdin;
\.


--
-- Data for Name: presence_allow_inbound; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.presence_allow_inbound (observed_user_id, observer_user_id) FROM stdin;
\.


--
-- Data for Name: presence_list; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.presence_list (user_id, observed_user_id, accepted) FROM stdin;
\.


--
-- Data for Name: presence_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.presence_stream (stream_id, user_id, state, last_active_ts, last_federation_update_ts, last_user_sync_ts, status_msg, currently_active) FROM stdin;
1998	@alexes1:localhost	offline	1547286071683	1547286139427	1547286101711	\N	t
2004	@alexes:localhost	online	1547286505932	1547286256478	1547286505932	\N	t
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.profiles (user_id, displayname, avatar_url) FROM stdin;
alexes	alexes	\N
alexes1	alexes1	\N
\.


--
-- Data for Name: public_room_list_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.public_room_list_stream (stream_id, room_id, visibility, appservice_id, network_id) FROM stdin;
\.


--
-- Data for Name: push_rules; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.push_rules (id, user_name, rule_id, priority_class, priority, conditions, actions) FROM stdin;
\.


--
-- Data for Name: push_rules_enable; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.push_rules_enable (id, user_name, rule_id, enabled) FROM stdin;
\.


--
-- Data for Name: push_rules_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.push_rules_stream (stream_id, event_stream_ordering, user_id, rule_id, op, priority_class, priority, conditions, actions) FROM stdin;
\.


--
-- Data for Name: pusher_throttle; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.pusher_throttle (pusher, room_id, last_sent_ts, throttle_ms) FROM stdin;
\.


--
-- Data for Name: pushers; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.pushers (id, user_name, access_token, profile_tag, kind, app_id, app_display_name, device_display_name, pushkey, ts, lang, data, last_stream_ordering, last_success, failing_since) FROM stdin;
\.


--
-- Data for Name: ratelimit_override; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.ratelimit_override (user_id, messages_per_second, burst_count) FROM stdin;
\.


--
-- Data for Name: receipts_graph; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.receipts_graph (room_id, receipt_type, user_id, event_ids, data) FROM stdin;
!CrvkKxgetahhVIwnyX:localhost	m.read	@alexes:localhost	["$154714527259ArrwP:localhost"]	{"ts": 1547188069630}
!CrvkKxgetahhVIwnyX:localhost	m.read	@alexes1:localhost	["$154719164767efuXJ:localhost"]	{"ts": 1547191650920}
\.


--
-- Data for Name: receipts_linearized; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.receipts_linearized (stream_id, room_id, receipt_type, user_id, event_id, data) FROM stdin;
7	!CrvkKxgetahhVIwnyX:localhost	m.read	@alexes:localhost	$154714527259ArrwP:localhost	{"ts": 1547188069630}
9	!CrvkKxgetahhVIwnyX:localhost	m.read	@alexes1:localhost	$154719164767efuXJ:localhost	{"ts": 1547191650920}
\.


--
-- Data for Name: received_transactions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.received_transactions (transaction_id, origin, ts, response_code, response_json, has_been_referenced) FROM stdin;
\.


--
-- Data for Name: redactions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.redactions (event_id, redacts) FROM stdin;
\.


--
-- Data for Name: rejections; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.rejections (event_id, reason, last_check) FROM stdin;
\.


--
-- Data for Name: remote_media_cache; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.remote_media_cache (media_origin, media_id, media_type, created_ts, upload_name, media_length, filesystem_id, last_access_ts, quarantined_by) FROM stdin;
\.


--
-- Data for Name: remote_media_cache_thumbnails; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.remote_media_cache_thumbnails (media_origin, media_id, thumbnail_width, thumbnail_height, thumbnail_method, thumbnail_type, thumbnail_length, filesystem_id) FROM stdin;
\.


--
-- Data for Name: remote_profile_cache; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.remote_profile_cache (user_id, displayname, avatar_url, last_check) FROM stdin;
\.


--
-- Data for Name: room_account_data; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_account_data (user_id, room_id, account_data_type, stream_id, content) FROM stdin;
@alexes:localhost	!mpvAGWWPEpWsNydYnN:localhost	m.fully_read	6	{"event_id": "$15471426305IErDp:localhost"}
@alexes:localhost	!CrvkKxgetahhVIwnyX:localhost	org.matrix.room.preview_urls	7	{"disable": false}
@alexes1:localhost	!CrvkKxgetahhVIwnyX:localhost	m.fully_read	96	{"event_id": "$1547209171115HwvmV:localhost"}
@alexes:localhost	!CrvkKxgetahhVIwnyX:localhost	m.fully_read	44	{"event_id": "$154718807060Osxiw:localhost"}
\.


--
-- Data for Name: room_alias_servers; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_alias_servers (room_alias, server) FROM stdin;
\.


--
-- Data for Name: room_aliases; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_aliases (room_alias, room_id, creator) FROM stdin;
\.


--
-- Data for Name: room_depth; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_depth (room_id, min_depth) FROM stdin;
!mpvAGWWPEpWsNydYnN:localhost	1
!CrvkKxgetahhVIwnyX:localhost	1
!RgDCNwMiMxKykVVClV:localhost	1
\.


--
-- Data for Name: room_hosts; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_hosts (room_id, host) FROM stdin;
\.


--
-- Data for Name: room_memberships; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_memberships (event_id, user_id, sender, room_id, membership, forgotten, display_name, avatar_url) FROM stdin;
$15471426301dPFwo:localhost	@alexes:localhost	@alexes:localhost	!mpvAGWWPEpWsNydYnN:localhost	join	0	alexes	\N
$15471426498QYDnP:localhost	@alexes:localhost	@alexes:localhost	!CrvkKxgetahhVIwnyX:localhost	join	0	alexes	\N
$154714428317sWMac:localhost	@alexes1:localhost	@alexes1:localhost	!RgDCNwMiMxKykVVClV:localhost	join	0	alexes1	\N
$154714438325bxgqT:localhost	@alexes1:localhost	@alexes1:localhost	!CrvkKxgetahhVIwnyX:localhost	join	0	alexes1	\N
\.


--
-- Data for Name: room_names; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_names (event_id, room_id, name) FROM stdin;
$154714264913PCUQS:localhost	!CrvkKxgetahhVIwnyX:localhost	firstpublic
\.


--
-- Data for Name: room_tags; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_tags (user_id, room_id, tag, content) FROM stdin;
\.


--
-- Data for Name: room_tags_revisions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_tags_revisions (user_id, room_id, stream_id) FROM stdin;
\.


--
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.rooms (room_id, is_public, creator) FROM stdin;
!mpvAGWWPEpWsNydYnN:localhost	f	@alexes:localhost
!CrvkKxgetahhVIwnyX:localhost	f	@alexes:localhost
!RgDCNwMiMxKykVVClV:localhost	f	@alexes1:localhost
\.


--
-- Data for Name: schema_version; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.schema_version (lock, version, upgraded) FROM stdin;
X	53	t
\.


--
-- Data for Name: server_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.server_keys_json (server_name, key_id, from_server, ts_added_ms, ts_valid_until_ms, key_json) FROM stdin;
\.


--
-- Data for Name: server_signature_keys; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.server_signature_keys (server_name, key_id, from_server, ts_added_ms, verify_key) FROM stdin;
\.


--
-- Data for Name: server_tls_certificates; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.server_tls_certificates (server_name, fingerprint, from_server, ts_added_ms, tls_certificate) FROM stdin;
\.


--
-- Data for Name: state_events; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.state_events (event_id, room_id, type, state_key, prev_state) FROM stdin;
$15471426300pPrwQ:localhost	!mpvAGWWPEpWsNydYnN:localhost	m.room.create		\N
$15471426301dPFwo:localhost	!mpvAGWWPEpWsNydYnN:localhost	m.room.member	@alexes:localhost	\N
$15471426302pIqiF:localhost	!mpvAGWWPEpWsNydYnN:localhost	m.room.power_levels		\N
$15471426303YCSmZ:localhost	!mpvAGWWPEpWsNydYnN:localhost	m.room.join_rules		\N
$15471426304BRdxH:localhost	!mpvAGWWPEpWsNydYnN:localhost	m.room.history_visibility		\N
$15471426305IErDp:localhost	!mpvAGWWPEpWsNydYnN:localhost	m.room.guest_access		\N
$15471426487fdcng:localhost	!CrvkKxgetahhVIwnyX:localhost	m.room.create		\N
$15471426498QYDnP:localhost	!CrvkKxgetahhVIwnyX:localhost	m.room.member	@alexes:localhost	\N
$15471426499olYQy:localhost	!CrvkKxgetahhVIwnyX:localhost	m.room.power_levels		\N
$154714264910qNuKi:localhost	!CrvkKxgetahhVIwnyX:localhost	m.room.join_rules		\N
$154714264911TWsje:localhost	!CrvkKxgetahhVIwnyX:localhost	m.room.history_visibility		\N
$154714264912SGfjg:localhost	!CrvkKxgetahhVIwnyX:localhost	m.room.guest_access		\N
$154714264913PCUQS:localhost	!CrvkKxgetahhVIwnyX:localhost	m.room.name		\N
$154714266714gvEsJ:localhost	!CrvkKxgetahhVIwnyX:localhost	m.room.related_groups		\N
$154714428316KLrwW:localhost	!RgDCNwMiMxKykVVClV:localhost	m.room.create		\N
$154714428317sWMac:localhost	!RgDCNwMiMxKykVVClV:localhost	m.room.member	@alexes1:localhost	\N
$154714428318OamJt:localhost	!RgDCNwMiMxKykVVClV:localhost	m.room.power_levels		\N
$154714428319jqvHZ:localhost	!RgDCNwMiMxKykVVClV:localhost	m.room.join_rules		\N
$154714428320dqSvn:localhost	!RgDCNwMiMxKykVVClV:localhost	m.room.history_visibility		\N
$154714428321iaMIA:localhost	!RgDCNwMiMxKykVVClV:localhost	m.room.guest_access		\N
$154714436223plixL:localhost	!CrvkKxgetahhVIwnyX:localhost	m.room.join_rules		\N
$154714436224LoFLm:localhost	!CrvkKxgetahhVIwnyX:localhost	org.matrix.room.preview_urls		\N
$154714438325bxgqT:localhost	!CrvkKxgetahhVIwnyX:localhost	m.room.member	@alexes1:localhost	\N
\.


--
-- Data for Name: state_forward_extremities; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.state_forward_extremities (event_id, room_id, type, state_key) FROM stdin;
\.


--
-- Data for Name: state_group_edges; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.state_group_edges (state_group, prev_state_group) FROM stdin;
2	1
3	2
4	3
5	4
6	5
7	6
9	8
10	9
11	10
12	11
13	12
14	13
15	14
17	16
18	17
19	18
20	19
21	20
22	21
23	15
24	15
25	24
\.


--
-- Data for Name: state_groups; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.state_groups (id, room_id, event_id) FROM stdin;
1	!mpvAGWWPEpWsNydYnN:localhost	$15471426300pPrwQ:localhost
2	!mpvAGWWPEpWsNydYnN:localhost	$15471426301dPFwo:localhost
3	!mpvAGWWPEpWsNydYnN:localhost	$15471426302pIqiF:localhost
4	!mpvAGWWPEpWsNydYnN:localhost	$15471426303YCSmZ:localhost
5	!mpvAGWWPEpWsNydYnN:localhost	$15471426304BRdxH:localhost
6	!mpvAGWWPEpWsNydYnN:localhost	$15471426305IErDp:localhost
7	!mpvAGWWPEpWsNydYnN:localhost	$15471426306pOArX:localhost
8	!CrvkKxgetahhVIwnyX:localhost	$15471426487fdcng:localhost
9	!CrvkKxgetahhVIwnyX:localhost	$15471426498QYDnP:localhost
10	!CrvkKxgetahhVIwnyX:localhost	$15471426499olYQy:localhost
11	!CrvkKxgetahhVIwnyX:localhost	$154714264910qNuKi:localhost
12	!CrvkKxgetahhVIwnyX:localhost	$154714264911TWsje:localhost
13	!CrvkKxgetahhVIwnyX:localhost	$154714264912SGfjg:localhost
14	!CrvkKxgetahhVIwnyX:localhost	$154714264913PCUQS:localhost
15	!CrvkKxgetahhVIwnyX:localhost	$154714266714gvEsJ:localhost
16	!RgDCNwMiMxKykVVClV:localhost	$154714428316KLrwW:localhost
17	!RgDCNwMiMxKykVVClV:localhost	$154714428317sWMac:localhost
18	!RgDCNwMiMxKykVVClV:localhost	$154714428318OamJt:localhost
19	!RgDCNwMiMxKykVVClV:localhost	$154714428319jqvHZ:localhost
20	!RgDCNwMiMxKykVVClV:localhost	$154714428320dqSvn:localhost
21	!RgDCNwMiMxKykVVClV:localhost	$154714428321iaMIA:localhost
22	!RgDCNwMiMxKykVVClV:localhost	$154714428322njFKf:localhost
23	!CrvkKxgetahhVIwnyX:localhost	$154714436223plixL:localhost
24	!CrvkKxgetahhVIwnyX:localhost	$154714436224LoFLm:localhost
25	!CrvkKxgetahhVIwnyX:localhost	$154714438325bxgqT:localhost
\.


--
-- Data for Name: state_groups_state; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.state_groups_state (state_group, room_id, type, state_key, event_id) FROM stdin;
1	!mpvAGWWPEpWsNydYnN:localhost	m.room.create		$15471426300pPrwQ:localhost
2	!mpvAGWWPEpWsNydYnN:localhost	m.room.member	@alexes:localhost	$15471426301dPFwo:localhost
3	!mpvAGWWPEpWsNydYnN:localhost	m.room.power_levels		$15471426302pIqiF:localhost
4	!mpvAGWWPEpWsNydYnN:localhost	m.room.join_rules		$15471426303YCSmZ:localhost
5	!mpvAGWWPEpWsNydYnN:localhost	m.room.history_visibility		$15471426304BRdxH:localhost
6	!mpvAGWWPEpWsNydYnN:localhost	m.room.guest_access		$15471426305IErDp:localhost
7	!mpvAGWWPEpWsNydYnN:localhost	m.room.member	@riot-bot:matrix.org	$15471426306pOArX:localhost
8	!CrvkKxgetahhVIwnyX:localhost	m.room.create		$15471426487fdcng:localhost
9	!CrvkKxgetahhVIwnyX:localhost	m.room.member	@alexes:localhost	$15471426498QYDnP:localhost
10	!CrvkKxgetahhVIwnyX:localhost	m.room.power_levels		$15471426499olYQy:localhost
11	!CrvkKxgetahhVIwnyX:localhost	m.room.join_rules		$154714264910qNuKi:localhost
12	!CrvkKxgetahhVIwnyX:localhost	m.room.history_visibility		$154714264911TWsje:localhost
13	!CrvkKxgetahhVIwnyX:localhost	m.room.guest_access		$154714264912SGfjg:localhost
14	!CrvkKxgetahhVIwnyX:localhost	m.room.name		$154714264913PCUQS:localhost
15	!CrvkKxgetahhVIwnyX:localhost	m.room.related_groups		$154714266714gvEsJ:localhost
16	!RgDCNwMiMxKykVVClV:localhost	m.room.create		$154714428316KLrwW:localhost
17	!RgDCNwMiMxKykVVClV:localhost	m.room.member	@alexes1:localhost	$154714428317sWMac:localhost
18	!RgDCNwMiMxKykVVClV:localhost	m.room.power_levels		$154714428318OamJt:localhost
19	!RgDCNwMiMxKykVVClV:localhost	m.room.join_rules		$154714428319jqvHZ:localhost
20	!RgDCNwMiMxKykVVClV:localhost	m.room.history_visibility		$154714428320dqSvn:localhost
21	!RgDCNwMiMxKykVVClV:localhost	m.room.guest_access		$154714428321iaMIA:localhost
22	!RgDCNwMiMxKykVVClV:localhost	m.room.member	@riot-bot:matrix.org	$154714428322njFKf:localhost
23	!CrvkKxgetahhVIwnyX:localhost	m.room.join_rules		$154714436223plixL:localhost
24	!CrvkKxgetahhVIwnyX:localhost	org.matrix.room.preview_urls		$154714436224LoFLm:localhost
25	!CrvkKxgetahhVIwnyX:localhost	m.room.join_rules		$154714436223plixL:localhost
25	!CrvkKxgetahhVIwnyX:localhost	m.room.member	@alexes1:localhost	$154714438325bxgqT:localhost
\.


--
-- Data for Name: stats_reporting; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stats_reporting (reported_stream_token, reported_time) FROM stdin;
\.


--
-- Data for Name: stream_ordering_to_exterm; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.stream_ordering_to_exterm (stream_ordering, room_id, event_id) FROM stdin;
2	!mpvAGWWPEpWsNydYnN:localhost	$15471426300pPrwQ:localhost
3	!mpvAGWWPEpWsNydYnN:localhost	$15471426301dPFwo:localhost
4	!mpvAGWWPEpWsNydYnN:localhost	$15471426302pIqiF:localhost
5	!mpvAGWWPEpWsNydYnN:localhost	$15471426303YCSmZ:localhost
6	!mpvAGWWPEpWsNydYnN:localhost	$15471426304BRdxH:localhost
7	!mpvAGWWPEpWsNydYnN:localhost	$15471426305IErDp:localhost
8	!CrvkKxgetahhVIwnyX:localhost	$15471426487fdcng:localhost
9	!CrvkKxgetahhVIwnyX:localhost	$15471426498QYDnP:localhost
10	!CrvkKxgetahhVIwnyX:localhost	$15471426499olYQy:localhost
11	!CrvkKxgetahhVIwnyX:localhost	$154714264910qNuKi:localhost
12	!CrvkKxgetahhVIwnyX:localhost	$154714264911TWsje:localhost
13	!CrvkKxgetahhVIwnyX:localhost	$154714264912SGfjg:localhost
14	!CrvkKxgetahhVIwnyX:localhost	$154714264913PCUQS:localhost
15	!CrvkKxgetahhVIwnyX:localhost	$154714266714gvEsJ:localhost
16	!CrvkKxgetahhVIwnyX:localhost	$154714412415WRVyj:localhost
17	!RgDCNwMiMxKykVVClV:localhost	$154714428316KLrwW:localhost
18	!RgDCNwMiMxKykVVClV:localhost	$154714428317sWMac:localhost
19	!RgDCNwMiMxKykVVClV:localhost	$154714428318OamJt:localhost
20	!RgDCNwMiMxKykVVClV:localhost	$154714428319jqvHZ:localhost
21	!RgDCNwMiMxKykVVClV:localhost	$154714428320dqSvn:localhost
22	!RgDCNwMiMxKykVVClV:localhost	$154714428321iaMIA:localhost
23	!CrvkKxgetahhVIwnyX:localhost	$154714436223plixL:localhost
24	!CrvkKxgetahhVIwnyX:localhost	$154714436223plixL:localhost
24	!CrvkKxgetahhVIwnyX:localhost	$154714436224LoFLm:localhost
25	!CrvkKxgetahhVIwnyX:localhost	$154714438325bxgqT:localhost
26	!CrvkKxgetahhVIwnyX:localhost	$154714438526deOTX:localhost
27	!CrvkKxgetahhVIwnyX:localhost	$154714438727XNbHq:localhost
28	!CrvkKxgetahhVIwnyX:localhost	$154714438828svObh:localhost
29	!CrvkKxgetahhVIwnyX:localhost	$154714438929Suhxq:localhost
30	!CrvkKxgetahhVIwnyX:localhost	$154714439530kLEKZ:localhost
31	!CrvkKxgetahhVIwnyX:localhost	$154714443231YXmpK:localhost
32	!CrvkKxgetahhVIwnyX:localhost	$154714446132Evhrh:localhost
33	!CrvkKxgetahhVIwnyX:localhost	$154714447433aWttn:localhost
34	!CrvkKxgetahhVIwnyX:localhost	$154714447534UQifj:localhost
35	!CrvkKxgetahhVIwnyX:localhost	$154714447735ZCGXj:localhost
36	!CrvkKxgetahhVIwnyX:localhost	$154714447936SjGma:localhost
37	!CrvkKxgetahhVIwnyX:localhost	$154714450937xxzjh:localhost
38	!CrvkKxgetahhVIwnyX:localhost	$154714485938YzCYs:localhost
39	!CrvkKxgetahhVIwnyX:localhost	$154714489839jNhPb:localhost
40	!CrvkKxgetahhVIwnyX:localhost	$154714489940llVyn:localhost
41	!CrvkKxgetahhVIwnyX:localhost	$154714493741nQcWl:localhost
42	!CrvkKxgetahhVIwnyX:localhost	$154714494442vLOzu:localhost
43	!CrvkKxgetahhVIwnyX:localhost	$154714497443utMjv:localhost
44	!CrvkKxgetahhVIwnyX:localhost	$154714497944XQHPs:localhost
45	!CrvkKxgetahhVIwnyX:localhost	$154714498345nGKFH:localhost
46	!CrvkKxgetahhVIwnyX:localhost	$154714504446aiIqN:localhost
47	!CrvkKxgetahhVIwnyX:localhost	$154714504947xvIss:localhost
48	!CrvkKxgetahhVIwnyX:localhost	$154714505048dWZpP:localhost
49	!CrvkKxgetahhVIwnyX:localhost	$154714505249jNMbA:localhost
50	!CrvkKxgetahhVIwnyX:localhost	$154714506450XWsqc:localhost
51	!CrvkKxgetahhVIwnyX:localhost	$154714508851gyeED:localhost
52	!CrvkKxgetahhVIwnyX:localhost	$154714513052twTnQ:localhost
53	!CrvkKxgetahhVIwnyX:localhost	$154714513153wozrV:localhost
54	!CrvkKxgetahhVIwnyX:localhost	$154714514854gxKZt:localhost
55	!CrvkKxgetahhVIwnyX:localhost	$154714516355TZkpl:localhost
56	!CrvkKxgetahhVIwnyX:localhost	$154714523956frAuI:localhost
57	!CrvkKxgetahhVIwnyX:localhost	$154714524157LQlkn:localhost
58	!CrvkKxgetahhVIwnyX:localhost	$154714526858lzwnp:localhost
59	!CrvkKxgetahhVIwnyX:localhost	$154714527259ArrwP:localhost
60	!CrvkKxgetahhVIwnyX:localhost	$154718807060Osxiw:localhost
61	!CrvkKxgetahhVIwnyX:localhost	$154718811161PDsGA:localhost
62	!CrvkKxgetahhVIwnyX:localhost	$154719130162RgkdQ:localhost
63	!CrvkKxgetahhVIwnyX:localhost	$154719143563hheAg:localhost
64	!CrvkKxgetahhVIwnyX:localhost	$154719144064kEzNq:localhost
65	!CrvkKxgetahhVIwnyX:localhost	$154719151365zvWZO:localhost
66	!CrvkKxgetahhVIwnyX:localhost	$154719152466oQvOE:localhost
67	!CrvkKxgetahhVIwnyX:localhost	$154719164767efuXJ:localhost
68	!CrvkKxgetahhVIwnyX:localhost	$154719165168NYIll:localhost
69	!CrvkKxgetahhVIwnyX:localhost	$154719247969KPEUm:localhost
70	!CrvkKxgetahhVIwnyX:localhost	$154719339270SMjRz:localhost
71	!CrvkKxgetahhVIwnyX:localhost	$154719339771HhoBo:localhost
72	!CrvkKxgetahhVIwnyX:localhost	$154719344372iKEnw:localhost
73	!CrvkKxgetahhVIwnyX:localhost	$154719347073jkPIF:localhost
74	!CrvkKxgetahhVIwnyX:localhost	$154719378074ykqqG:localhost
75	!CrvkKxgetahhVIwnyX:localhost	$154719491875LeoON:localhost
76	!CrvkKxgetahhVIwnyX:localhost	$154719496876HQbNA:localhost
77	!CrvkKxgetahhVIwnyX:localhost	$154719500977pGQXX:localhost
78	!CrvkKxgetahhVIwnyX:localhost	$154719502078SFZFP:localhost
79	!CrvkKxgetahhVIwnyX:localhost	$154719505679wchms:localhost
80	!CrvkKxgetahhVIwnyX:localhost	$154719508580jYTcz:localhost
81	!CrvkKxgetahhVIwnyX:localhost	$154719514481IOBiR:localhost
82	!CrvkKxgetahhVIwnyX:localhost	$154719514682XMEKF:localhost
83	!CrvkKxgetahhVIwnyX:localhost	$154719519283zKOPF:localhost
87	!CrvkKxgetahhVIwnyX:localhost	$154719531387IgQOF:localhost
101	!CrvkKxgetahhVIwnyX:localhost	$1547201298101MsJGQ:localhost
102	!CrvkKxgetahhVIwnyX:localhost	$1547201299102nrFQP:localhost
105	!CrvkKxgetahhVIwnyX:localhost	$1547201345105jVolj:localhost
84	!CrvkKxgetahhVIwnyX:localhost	$154719521084EQDIT:localhost
91	!CrvkKxgetahhVIwnyX:localhost	$154719540291vvcgV:localhost
100	!CrvkKxgetahhVIwnyX:localhost	$1547201274100AXvny:localhost
104	!CrvkKxgetahhVIwnyX:localhost	$1547201310104XQQzj:localhost
106	!CrvkKxgetahhVIwnyX:localhost	$1547201455106obHen:localhost
85	!CrvkKxgetahhVIwnyX:localhost	$154719524685MEsPE:localhost
86	!CrvkKxgetahhVIwnyX:localhost	$154719527986LWiBd:localhost
93	!CrvkKxgetahhVIwnyX:localhost	$154719540493KHAxf:localhost
95	!CrvkKxgetahhVIwnyX:localhost	$154719547395BoSSt:localhost
88	!CrvkKxgetahhVIwnyX:localhost	$154719537488sBeaz:localhost
89	!CrvkKxgetahhVIwnyX:localhost	$154719537689wbEAt:localhost
103	!CrvkKxgetahhVIwnyX:localhost	$1547201301103APSbA:localhost
90	!CrvkKxgetahhVIwnyX:localhost	$154719540290lClpJ:localhost
97	!CrvkKxgetahhVIwnyX:localhost	$154720039497BQXbf:localhost
92	!CrvkKxgetahhVIwnyX:localhost	$154719540392cuLjJ:localhost
94	!CrvkKxgetahhVIwnyX:localhost	$154719547294JJsmq:localhost
96	!CrvkKxgetahhVIwnyX:localhost	$154719550396cyAjC:localhost
99	!CrvkKxgetahhVIwnyX:localhost	$154720071099yrpdB:localhost
98	!CrvkKxgetahhVIwnyX:localhost	$154720043498SQgyh:localhost
107	!CrvkKxgetahhVIwnyX:localhost	$1547201474107QSZzp:localhost
108	!CrvkKxgetahhVIwnyX:localhost	$1547201566108vIMzG:localhost
109	!CrvkKxgetahhVIwnyX:localhost	$1547203164109HWxxp:localhost
110	!CrvkKxgetahhVIwnyX:localhost	$1547209015110ILKew:localhost
111	!CrvkKxgetahhVIwnyX:localhost	$1547209017111VCOtq:localhost
112	!CrvkKxgetahhVIwnyX:localhost	$1547209037112vjLNr:localhost
113	!CrvkKxgetahhVIwnyX:localhost	$1547209043113TVkrB:localhost
114	!CrvkKxgetahhVIwnyX:localhost	$1547209096114BlJbe:localhost
115	!CrvkKxgetahhVIwnyX:localhost	$1547209171115HwvmV:localhost
116	!CrvkKxgetahhVIwnyX:localhost	$1547209244116RahcN:localhost
117	!CrvkKxgetahhVIwnyX:localhost	$1547211554117Elhng:localhost
118	!CrvkKxgetahhVIwnyX:localhost	$1547220025118yFXAz:localhost
119	!CrvkKxgetahhVIwnyX:localhost	$1547220096119DwtHP:localhost
120	!CrvkKxgetahhVIwnyX:localhost	$1547220105120XlrPA:localhost
121	!CrvkKxgetahhVIwnyX:localhost	$1547220182121VEzRa:localhost
122	!CrvkKxgetahhVIwnyX:localhost	$1547220191122fXIkm:localhost
123	!CrvkKxgetahhVIwnyX:localhost	$1547220193123fBQYD:localhost
124	!CrvkKxgetahhVIwnyX:localhost	$1547220194124AQdWA:localhost
125	!CrvkKxgetahhVIwnyX:localhost	$1547220196125pygpM:localhost
126	!CrvkKxgetahhVIwnyX:localhost	$1547220197126rpVNs:localhost
127	!CrvkKxgetahhVIwnyX:localhost	$1547220198127qDjZB:localhost
128	!CrvkKxgetahhVIwnyX:localhost	$1547220199128EKqcd:localhost
129	!CrvkKxgetahhVIwnyX:localhost	$1547220200129xNEFN:localhost
130	!CrvkKxgetahhVIwnyX:localhost	$1547220219130eqWPP:localhost
131	!CrvkKxgetahhVIwnyX:localhost	$1547220236131oUTpn:localhost
132	!CrvkKxgetahhVIwnyX:localhost	$1547220258132jXsNq:localhost
133	!CrvkKxgetahhVIwnyX:localhost	$1547220271133nWAgW:localhost
134	!CrvkKxgetahhVIwnyX:localhost	$1547220330134ibkVz:localhost
135	!CrvkKxgetahhVIwnyX:localhost	$1547220332135nCFHQ:localhost
136	!CrvkKxgetahhVIwnyX:localhost	$1547220334136ylgXz:localhost
137	!CrvkKxgetahhVIwnyX:localhost	$1547220336137dJMop:localhost
138	!CrvkKxgetahhVIwnyX:localhost	$1547220337138tFafe:localhost
139	!CrvkKxgetahhVIwnyX:localhost	$1547220342139OPXTO:localhost
140	!CrvkKxgetahhVIwnyX:localhost	$1547220358140eyxTo:localhost
141	!CrvkKxgetahhVIwnyX:localhost	$1547220502141QlNvD:localhost
142	!CrvkKxgetahhVIwnyX:localhost	$1547279183142YOhis:localhost
143	!CrvkKxgetahhVIwnyX:localhost	$1547279184143GVbKe:localhost
144	!CrvkKxgetahhVIwnyX:localhost	$1547279185144ElypB:localhost
145	!CrvkKxgetahhVIwnyX:localhost	$1547279186145UMjYo:localhost
146	!CrvkKxgetahhVIwnyX:localhost	$1547279187146HVLNT:localhost
147	!CrvkKxgetahhVIwnyX:localhost	$1547279189147gYZsO:localhost
148	!CrvkKxgetahhVIwnyX:localhost	$1547279190148LahLH:localhost
149	!CrvkKxgetahhVIwnyX:localhost	$1547279319149EgmWE:localhost
150	!CrvkKxgetahhVIwnyX:localhost	$1547279319150fMLrf:localhost
151	!CrvkKxgetahhVIwnyX:localhost	$1547279319151MaOud:localhost
152	!CrvkKxgetahhVIwnyX:localhost	$1547279320152DJzGw:localhost
153	!CrvkKxgetahhVIwnyX:localhost	$1547279320153eLKOp:localhost
154	!CrvkKxgetahhVIwnyX:localhost	$1547279321154qYYIA:localhost
155	!CrvkKxgetahhVIwnyX:localhost	$1547279331155MIaaY:localhost
156	!CrvkKxgetahhVIwnyX:localhost	$1547279331156JREIt:localhost
157	!CrvkKxgetahhVIwnyX:localhost	$1547279332157nmQRp:localhost
158	!CrvkKxgetahhVIwnyX:localhost	$1547279333158JjmRS:localhost
159	!CrvkKxgetahhVIwnyX:localhost	$1547279334159OmRvd:localhost
160	!CrvkKxgetahhVIwnyX:localhost	$1547279335160XSwVw:localhost
161	!CrvkKxgetahhVIwnyX:localhost	$1547280627161jyqzw:localhost
162	!CrvkKxgetahhVIwnyX:localhost	$1547280712162vCSiP:localhost
163	!CrvkKxgetahhVIwnyX:localhost	$1547280714163OzTSL:localhost
164	!CrvkKxgetahhVIwnyX:localhost	$1547280717164BqYSL:localhost
165	!CrvkKxgetahhVIwnyX:localhost	$1547280734165AejNq:localhost
166	!CrvkKxgetahhVIwnyX:localhost	$1547280737166XHlsG:localhost
167	!CrvkKxgetahhVIwnyX:localhost	$1547280753167iiLNC:localhost
168	!CrvkKxgetahhVIwnyX:localhost	$1547280755168RTqof:localhost
169	!CrvkKxgetahhVIwnyX:localhost	$1547280758169QBLYK:localhost
170	!CrvkKxgetahhVIwnyX:localhost	$1547280759170XdQji:localhost
171	!CrvkKxgetahhVIwnyX:localhost	$1547280764171pBzRc:localhost
172	!CrvkKxgetahhVIwnyX:localhost	$1547280816172DhRcw:localhost
173	!CrvkKxgetahhVIwnyX:localhost	$1547280820173UXJMb:localhost
174	!CrvkKxgetahhVIwnyX:localhost	$1547280825174yozNU:localhost
175	!CrvkKxgetahhVIwnyX:localhost	$1547280856175DGEZm:localhost
176	!CrvkKxgetahhVIwnyX:localhost	$1547281038176RAJob:localhost
177	!CrvkKxgetahhVIwnyX:localhost	$1547281042177bmAPI:localhost
178	!CrvkKxgetahhVIwnyX:localhost	$1547281644178FBthK:localhost
179	!CrvkKxgetahhVIwnyX:localhost	$1547281718179tyKcU:localhost
180	!CrvkKxgetahhVIwnyX:localhost	$1547281876180XjrWa:localhost
181	!CrvkKxgetahhVIwnyX:localhost	$1547282273181ZFMBT:localhost
182	!CrvkKxgetahhVIwnyX:localhost	$1547282306182UochL:localhost
183	!CrvkKxgetahhVIwnyX:localhost	$1547282369183tZBnm:localhost
184	!CrvkKxgetahhVIwnyX:localhost	$1547282552184vQlUg:localhost
185	!CrvkKxgetahhVIwnyX:localhost	$1547282554185Mrxeo:localhost
186	!CrvkKxgetahhVIwnyX:localhost	$1547282555186bBEHl:localhost
187	!CrvkKxgetahhVIwnyX:localhost	$1547282556187hjEiN:localhost
196	!CrvkKxgetahhVIwnyX:localhost	$1547282626196TcRsD:localhost
211	!CrvkKxgetahhVIwnyX:localhost	$1547282668219nlCAE:localhost
188	!CrvkKxgetahhVIwnyX:localhost	$1547282564188gOZON:localhost
199	!CrvkKxgetahhVIwnyX:localhost	$1547282637199tWnNa:localhost
204	!CrvkKxgetahhVIwnyX:localhost	$1547282638204RNlYZ:localhost
189	!CrvkKxgetahhVIwnyX:localhost	$1547282567189pGIuv:localhost
210	!CrvkKxgetahhVIwnyX:localhost	$1547282663217xmKxc:localhost
190	!CrvkKxgetahhVIwnyX:localhost	$1547282608190GmCUl:localhost
195	!CrvkKxgetahhVIwnyX:localhost	$1547282625195gAcfj:localhost
191	!CrvkKxgetahhVIwnyX:localhost	$1547282610191tyhdp:localhost
200	!CrvkKxgetahhVIwnyX:localhost	$1547282637200HCoQh:localhost
208	!CrvkKxgetahhVIwnyX:localhost	$1547282653212xnlDS:localhost
192	!CrvkKxgetahhVIwnyX:localhost	$1547282611192tMYPw:localhost
201	!CrvkKxgetahhVIwnyX:localhost	$1547282637201dRtCQ:localhost
206	!CrvkKxgetahhVIwnyX:localhost	$1547282643208BfeRU:localhost
193	!CrvkKxgetahhVIwnyX:localhost	$1547282613193PvaJn:localhost
194	!CrvkKxgetahhVIwnyX:localhost	$1547282614194gxwNC:localhost
197	!CrvkKxgetahhVIwnyX:localhost	$1547282627197zwhxS:localhost
198	!CrvkKxgetahhVIwnyX:localhost	$1547282629198eGjsr:localhost
202	!CrvkKxgetahhVIwnyX:localhost	$1547282637202lPgPc:localhost
203	!CrvkKxgetahhVIwnyX:localhost	$1547282638203erEwp:localhost
205	!CrvkKxgetahhVIwnyX:localhost	$1547282638206MMkPI:localhost
207	!CrvkKxgetahhVIwnyX:localhost	$1547282648210wUJTL:localhost
209	!CrvkKxgetahhVIwnyX:localhost	$1547282658214BrfCn:localhost
212	!CrvkKxgetahhVIwnyX:localhost	$1547282673221rajqD:localhost
213	!CrvkKxgetahhVIwnyX:localhost	$1547282678223Kcqpm:localhost
214	!CrvkKxgetahhVIwnyX:localhost	$15472864650EOLwc:localhost
215	!CrvkKxgetahhVIwnyX:localhost	$15472864681LRSdm:localhost
216	!CrvkKxgetahhVIwnyX:localhost	$15472864692BQMAT:localhost
217	!CrvkKxgetahhVIwnyX:localhost	$15472864703LZpNb:localhost
218	!CrvkKxgetahhVIwnyX:localhost	$15472864724KanSK:localhost
219	!CrvkKxgetahhVIwnyX:localhost	$15472864735bRxfM:localhost
220	!CrvkKxgetahhVIwnyX:localhost	$15472864756QXetv:localhost
221	!CrvkKxgetahhVIwnyX:localhost	$15472865227IBpem:localhost
222	!CrvkKxgetahhVIwnyX:localhost	$15472865308jlsUe:localhost
223	!CrvkKxgetahhVIwnyX:localhost	$15472865379qjJPV:localhost
224	!CrvkKxgetahhVIwnyX:localhost	$154728654910jVIgS:localhost
225	!CrvkKxgetahhVIwnyX:localhost	$154728655711QTgup:localhost
\.


--
-- Data for Name: threepid_guest_access_tokens; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.threepid_guest_access_tokens (medium, address, guest_access_token, first_inviter) FROM stdin;
\.


--
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.topics (event_id, room_id, topic) FROM stdin;
\.


--
-- Data for Name: transaction_id_to_pdu; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.transaction_id_to_pdu (transaction_id, destination, pdu_id, pdu_origin) FROM stdin;
\.


--
-- Data for Name: user_daily_visits; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_daily_visits (user_id, device_id, "timestamp") FROM stdin;
@alexes:localhost	OBFWSJWDFN	1547078400000
@alexes:localhost	BEAWWZPRKB	1547078400000
@alexes:localhost	TRFSWZYCHC	1547078400000
@alexes1:localhost	UPEFWAYYBJ	1547078400000
@alexes:localhost	KADPOZFQWN	1547078400000
@alexes1:localhost	UPEFWAYYBJ	1547164800000
@alexes:localhost	KADPOZFQWN	1547164800000
@alexes:localhost	TRFSWZYCHC	1547164800000
@alexes:localhost	AWNENVBLBG	1547164800000
@alexes1:localhost	DRFUUIBBAK	1547164800000
@alexes1:localhost	DRFUUIBBAK	1547251200000
@alexes:localhost	AWNENVBLBG	1547251200000
@alexes:localhost	TRFSWZYCHC	1547251200000
\.


--
-- Data for Name: user_directory; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory (user_id, room_id, display_name, avatar_url) FROM stdin;
@alexes:localhost	!mpvAGWWPEpWsNydYnN:localhost	alexes	\N
@alexes1:localhost	!RgDCNwMiMxKykVVClV:localhost	alexes1	\N
\.


--
-- Data for Name: user_directory_search; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory_search (user_id, vector) FROM stdin;
@alexes:localhost	'alex':1A,3B 'localhost':2
@alexes1:localhost	'alexes1':1A,3B 'localhost':2
\.


--
-- Data for Name: user_directory_stream_pos; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory_stream_pos (lock, stream_id) FROM stdin;
X	25
\.


--
-- Data for Name: user_filters; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_filters (user_id, filter_id, filter_json) FROM stdin;
alexes	0	\\x7b22726f6f6d223a7b227374617465223a7b226c617a795f6c6f61645f6d656d62657273223a747275657d7d7d
alexes	1	\\x7b22726f6f6d223a7b2274696d656c696e65223a7b226c696d6974223a31307d7d7d
alexes1	0	\\x7b22726f6f6d223a7b227374617465223a7b226c617a795f6c6f61645f6d656d62657273223a747275657d7d7d
\.


--
-- Data for Name: user_ips; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_ips (user_id, access_token, device_id, ip, user_agent, last_seen) FROM stdin;
@alexes:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjRjaWQgdXNlcl9pZCA9IEBhbGV4ZXM6bG9jYWxob3N0CjAwMTZjaWQgdHlwZSA9IGFjY2VzcwowMDIxY2lkIG5vbmNlID0gemFAdEo7Q0JQNH43cXdUSAowMDJmc2lnbmF0dXJlIFbUEj7uUMkYYEDnsziXa_wrULIrTNvgZNDRZvELFTT6Cg	BEAWWZPRKB	::ffff:172.30.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.92 Safari/537.36	1547143090503
@alexes:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjRjaWQgdXNlcl9pZCA9IEBhbGV4ZXM6bG9jYWxob3N0CjAwMTZjaWQgdHlwZSA9IGFjY2VzcwowMDIxY2lkIG5vbmNlID0ga1IzQ1BjXndAcmNUR0EuUAowMDJmc2lnbmF0dXJlIEX6YAouq46Jg6NQ-OGU6Cs7HbR5_GcL62z6USXC8CfiCg	TRFSWZYCHC	::ffff:172.30.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.92 Safari/537.36	1547187872654
@alexes:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjRjaWQgdXNlcl9pZCA9IEBhbGV4ZXM6bG9jYWxob3N0CjAwMTZjaWQgdHlwZSA9IGFjY2VzcwowMDIxY2lkIG5vbmNlID0gd3JFOXlHekB2ZkthaUF1NgowMDJmc2lnbmF0dXJlIPypk90iXBPu3plilpNbr5zCUKqUKqv2c-irAAAbpWOoCg	OBFWSJWDFN	::ffff:172.30.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.92 Safari/537.36	1547144154910
@alexes:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjRjaWQgdXNlcl9pZCA9IEBhbGV4ZXM6bG9jYWxob3N0CjAwMTZjaWQgdHlwZSA9IGFjY2VzcwowMDIxY2lkIG5vbmNlID0gcnZDa3lvPUM0R35XOE09egowMDJmc2lnbmF0dXJlIFG0QU44RHnz5cul1xH4d9GupLFUpf-bbnS-hZ5PpuvICg	KADPOZFQWN	::ffff:172.30.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.92 Safari/537.36	1547188004442
@alexes1:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjVjaWQgdXNlcl9pZCA9IEBhbGV4ZXMxOmxvY2FsaG9zdAowMDE2Y2lkIHR5cGUgPSBhY2Nlc3MKMDAyMWNpZCBub25jZSA9IFZ0VHFQaTNJaVkzOHU2ZjQKMDAyZnNpZ25hdHVyZSA3fkJ-mecpNKGNTmxEqCy9v0iu55Wzwudh0H4hhk79pwo	DRFUUIBBAK	::ffff:172.30.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.92 Safari/537.36	1547286011571
@alexes:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjRjaWQgdXNlcl9pZCA9IEBhbGV4ZXM6bG9jYWxob3N0CjAwMTZjaWQgdHlwZSA9IGFjY2VzcwowMDIxY2lkIG5vbmNlID0ga1IzQ1BjXndAcmNUR0EuUAowMDJmc2lnbmF0dXJlIEX6YAouq46Jg6NQ-OGU6Cs7HbR5_GcL62z6USXC8CfiCg	TRFSWZYCHC	::ffff:172.30.0.4		1547286051866
@alexes:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjRjaWQgdXNlcl9pZCA9IEBhbGV4ZXM6bG9jYWxob3N0CjAwMTZjaWQgdHlwZSA9IGFjY2VzcwowMDIxY2lkIG5vbmNlID0gN3I1clJoOTBzX3FuRmt6ZAowMDJmc2lnbmF0dXJlIJ8CnF2YdQBgaWVuowrINaAhuSp1PLZq3WDRze2Me58lCg	AWNENVBLBG	::ffff:172.30.0.4		1547286505928
@alexes:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjRjaWQgdXNlcl9pZCA9IEBhbGV4ZXM6bG9jYWxob3N0CjAwMTZjaWQgdHlwZSA9IGFjY2VzcwowMDIxY2lkIG5vbmNlID0gN3I1clJoOTBzX3FuRmt6ZAowMDJmc2lnbmF0dXJlIJ8CnF2YdQBgaWVuowrINaAhuSp1PLZq3WDRze2Me58lCg	AWNENVBLBG	::ffff:172.30.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.92 Safari/537.36	1547286530288
@alexes1:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjVjaWQgdXNlcl9pZCA9IEBhbGV4ZXMxOmxvY2FsaG9zdAowMDE2Y2lkIHR5cGUgPSBhY2Nlc3MKMDAyMWNpZCBub25jZSA9IDVQa0ZOY1A5S0tHaWYwX04KMDAyZnNpZ25hdHVyZSDQBCD0UKrXlEUdHXodqqbt796UZRD2KVO8xFhzqF_BZgo	UPEFWAYYBJ	::ffff:172.30.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.92 Safari/537.36	1547186886758
\.


--
-- Data for Name: user_threepids; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_threepids (user_id, medium, address, validated_at, added_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.users (name, password_hash, creation_ts, admin, upgrade_ts, is_guest, appservice_id, consent_version, consent_server_notice_sent) FROM stdin;
@alexes:localhost	$2b$12$tMxD/y3Mf0VtVY5YBb75eueti8pW6/G.i08D2e63ltezdvOLNinKe	1547142630	0	\N	0	\N	\N	\N
@alexes1:localhost	$2b$12$YDOR5kB4EZJG6GK3Q9x5SuvUNWK7lrfOtWcTzUZCEYId47BhHjYE2	1547144283	0	\N	0	\N	\N	\N
\.


--
-- Data for Name: users_in_public_rooms; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.users_in_public_rooms (user_id, room_id) FROM stdin;
@alexes:localhost	!CrvkKxgetahhVIwnyX:localhost
@alexes1:localhost	!CrvkKxgetahhVIwnyX:localhost
\.


--
-- Data for Name: users_pending_deactivation; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.users_pending_deactivation (user_id) FROM stdin;
\.


--
-- Data for Name: users_who_share_rooms; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.users_who_share_rooms (user_id, other_user_id, room_id, share_private) FROM stdin;
@alexes:localhost	@alexes1:localhost	!CrvkKxgetahhVIwnyX:localhost	f
@alexes1:localhost	@alexes:localhost	!CrvkKxgetahhVIwnyX:localhost	f
\.


--
-- Name: state_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.state_group_id_seq', 25, true);


--
-- Name: access_tokens access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.access_tokens
    ADD CONSTRAINT access_tokens_pkey PRIMARY KEY (id);


--
-- Name: access_tokens access_tokens_token_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.access_tokens
    ADD CONSTRAINT access_tokens_token_key UNIQUE (token);


--
-- Name: account_data account_data_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.account_data
    ADD CONSTRAINT account_data_uniqueness UNIQUE (user_id, account_data_type);


--
-- Name: application_services application_services_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.application_services
    ADD CONSTRAINT application_services_pkey PRIMARY KEY (id);


--
-- Name: application_services_regex application_services_regex_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.application_services_regex
    ADD CONSTRAINT application_services_regex_pkey PRIMARY KEY (id);


--
-- Name: application_services_state application_services_state_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.application_services_state
    ADD CONSTRAINT application_services_state_pkey PRIMARY KEY (as_id);


--
-- Name: application_services application_services_token_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.application_services
    ADD CONSTRAINT application_services_token_key UNIQUE (token);


--
-- Name: application_services_txns application_services_txns_as_id_txn_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.application_services_txns
    ADD CONSTRAINT application_services_txns_as_id_txn_id_key UNIQUE (as_id, txn_id);


--
-- Name: applied_module_schemas applied_module_schemas_module_name_file_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.applied_module_schemas
    ADD CONSTRAINT applied_module_schemas_module_name_file_key UNIQUE (module_name, file);


--
-- Name: applied_schema_deltas applied_schema_deltas_version_file_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.applied_schema_deltas
    ADD CONSTRAINT applied_schema_deltas_version_file_key UNIQUE (version, file);


--
-- Name: appservice_stream_position appservice_stream_position_lock_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.appservice_stream_position
    ADD CONSTRAINT appservice_stream_position_lock_key UNIQUE (lock);


--
-- Name: background_updates background_updates_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.background_updates
    ADD CONSTRAINT background_updates_uniqueness UNIQUE (update_name);


--
-- Name: current_state_events current_state_events_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.current_state_events
    ADD CONSTRAINT current_state_events_event_id_key UNIQUE (event_id);


--
-- Name: current_state_events current_state_events_room_id_type_state_key_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.current_state_events
    ADD CONSTRAINT current_state_events_room_id_type_state_key_key UNIQUE (room_id, type, state_key);


--
-- Name: current_state_resets current_state_resets_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.current_state_resets
    ADD CONSTRAINT current_state_resets_pkey PRIMARY KEY (event_stream_ordering);


--
-- Name: destinations destinations_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.destinations
    ADD CONSTRAINT destinations_pkey PRIMARY KEY (destination);


--
-- Name: devices device_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT device_uniqueness UNIQUE (user_id, device_id);


--
-- Name: e2e_device_keys_json e2e_device_keys_json_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.e2e_device_keys_json
    ADD CONSTRAINT e2e_device_keys_json_uniqueness UNIQUE (user_id, device_id);


--
-- Name: e2e_one_time_keys_json e2e_one_time_keys_json_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.e2e_one_time_keys_json
    ADD CONSTRAINT e2e_one_time_keys_json_uniqueness UNIQUE (user_id, device_id, algorithm, key_id);


--
-- Name: event_backward_extremities event_backward_extremities_event_id_room_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_backward_extremities
    ADD CONSTRAINT event_backward_extremities_event_id_room_id_key UNIQUE (event_id, room_id);


--
-- Name: event_content_hashes event_content_hashes_event_id_algorithm_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_content_hashes
    ADD CONSTRAINT event_content_hashes_event_id_algorithm_key UNIQUE (event_id, algorithm);


--
-- Name: event_destinations event_destinations_event_id_destination_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_destinations
    ADD CONSTRAINT event_destinations_event_id_destination_key UNIQUE (event_id, destination);


--
-- Name: event_edge_hashes event_edge_hashes_event_id_prev_event_id_algorithm_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_edge_hashes
    ADD CONSTRAINT event_edge_hashes_event_id_prev_event_id_algorithm_key UNIQUE (event_id, prev_event_id, algorithm);


--
-- Name: event_edges event_edges_event_id_prev_event_id_room_id_is_state_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_edges
    ADD CONSTRAINT event_edges_event_id_prev_event_id_room_id_is_state_key UNIQUE (event_id, prev_event_id, room_id, is_state);


--
-- Name: event_forward_extremities event_forward_extremities_event_id_room_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_forward_extremities
    ADD CONSTRAINT event_forward_extremities_event_id_room_id_key UNIQUE (event_id, room_id);


--
-- Name: event_push_actions event_id_user_id_profile_tag_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_push_actions
    ADD CONSTRAINT event_id_user_id_profile_tag_uniqueness UNIQUE (room_id, event_id, user_id, profile_tag);


--
-- Name: event_json event_json_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_json
    ADD CONSTRAINT event_json_event_id_key UNIQUE (event_id);


--
-- Name: event_push_summary_stream_ordering event_push_summary_stream_ordering_lock_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_push_summary_stream_ordering
    ADD CONSTRAINT event_push_summary_stream_ordering_lock_key UNIQUE (lock);


--
-- Name: event_reference_hashes event_reference_hashes_event_id_algorithm_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_reference_hashes
    ADD CONSTRAINT event_reference_hashes_event_id_algorithm_key UNIQUE (event_id, algorithm);


--
-- Name: event_reports event_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_reports
    ADD CONSTRAINT event_reports_pkey PRIMARY KEY (id);


--
-- Name: event_signatures event_signatures_event_id_signature_name_key_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_signatures
    ADD CONSTRAINT event_signatures_event_id_signature_name_key_id_key UNIQUE (event_id, signature_name, key_id);


--
-- Name: event_to_state_groups event_to_state_groups_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.event_to_state_groups
    ADD CONSTRAINT event_to_state_groups_event_id_key UNIQUE (event_id);


--
-- Name: events events_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_event_id_key UNIQUE (event_id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (stream_ordering);


--
-- Name: ex_outlier_stream ex_outlier_stream_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.ex_outlier_stream
    ADD CONSTRAINT ex_outlier_stream_pkey PRIMARY KEY (event_stream_ordering);


--
-- Name: feedback feedback_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_event_id_key UNIQUE (event_id);


--
-- Name: group_roles group_roles_group_id_role_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.group_roles
    ADD CONSTRAINT group_roles_group_id_role_id_key UNIQUE (group_id, role_id);


--
-- Name: group_room_categories group_room_categories_group_id_category_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.group_room_categories
    ADD CONSTRAINT group_room_categories_group_id_category_id_key UNIQUE (group_id, category_id);


--
-- Name: group_summary_roles group_summary_roles_group_id_role_id_role_order_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.group_summary_roles
    ADD CONSTRAINT group_summary_roles_group_id_role_id_role_order_key UNIQUE (group_id, role_id, role_order);


--
-- Name: group_summary_room_categories group_summary_room_categories_group_id_category_id_cat_orde_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.group_summary_room_categories
    ADD CONSTRAINT group_summary_room_categories_group_id_category_id_cat_orde_key UNIQUE (group_id, category_id, cat_order);


--
-- Name: group_summary_rooms group_summary_rooms_group_id_category_id_room_id_room_order_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.group_summary_rooms
    ADD CONSTRAINT group_summary_rooms_group_id_category_id_room_id_room_order_key UNIQUE (group_id, category_id, room_id, room_order);


--
-- Name: guest_access guest_access_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.guest_access
    ADD CONSTRAINT guest_access_event_id_key UNIQUE (event_id);


--
-- Name: history_visibility history_visibility_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.history_visibility
    ADD CONSTRAINT history_visibility_event_id_key UNIQUE (event_id);


--
-- Name: local_media_repository local_media_repository_media_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.local_media_repository
    ADD CONSTRAINT local_media_repository_media_id_key UNIQUE (media_id);


--
-- Name: local_media_repository_thumbnails local_media_repository_thumbn_media_id_thumbnail_width_thum_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.local_media_repository_thumbnails
    ADD CONSTRAINT local_media_repository_thumbn_media_id_thumbnail_width_thum_key UNIQUE (media_id, thumbnail_width, thumbnail_height, thumbnail_type);


--
-- Name: user_threepids medium_address; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.user_threepids
    ADD CONSTRAINT medium_address UNIQUE (medium, address);


--
-- Name: open_id_tokens open_id_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.open_id_tokens
    ADD CONSTRAINT open_id_tokens_pkey PRIMARY KEY (token);


--
-- Name: presence_allow_inbound presence_allow_inbound_observed_user_id_observer_user_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.presence_allow_inbound
    ADD CONSTRAINT presence_allow_inbound_observed_user_id_observer_user_id_key UNIQUE (observed_user_id, observer_user_id);


--
-- Name: presence_list presence_list_user_id_observed_user_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.presence_list
    ADD CONSTRAINT presence_list_user_id_observed_user_id_key UNIQUE (user_id, observed_user_id);


--
-- Name: presence presence_user_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.presence
    ADD CONSTRAINT presence_user_id_key UNIQUE (user_id);


--
-- Name: account_data_max_stream_id private_user_data_max_stream_id_lock_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.account_data_max_stream_id
    ADD CONSTRAINT private_user_data_max_stream_id_lock_key UNIQUE (lock);


--
-- Name: profiles profiles_user_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_user_id_key UNIQUE (user_id);


--
-- Name: push_rules_enable push_rules_enable_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.push_rules_enable
    ADD CONSTRAINT push_rules_enable_pkey PRIMARY KEY (id);


--
-- Name: push_rules_enable push_rules_enable_user_name_rule_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.push_rules_enable
    ADD CONSTRAINT push_rules_enable_user_name_rule_id_key UNIQUE (user_name, rule_id);


--
-- Name: push_rules push_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.push_rules
    ADD CONSTRAINT push_rules_pkey PRIMARY KEY (id);


--
-- Name: push_rules push_rules_user_name_rule_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.push_rules
    ADD CONSTRAINT push_rules_user_name_rule_id_key UNIQUE (user_name, rule_id);


--
-- Name: pusher_throttle pusher_throttle_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.pusher_throttle
    ADD CONSTRAINT pusher_throttle_pkey PRIMARY KEY (pusher, room_id);


--
-- Name: pushers pushers2_app_id_pushkey_user_name_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.pushers
    ADD CONSTRAINT pushers2_app_id_pushkey_user_name_key UNIQUE (app_id, pushkey, user_name);


--
-- Name: pushers pushers2_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.pushers
    ADD CONSTRAINT pushers2_pkey PRIMARY KEY (id);


--
-- Name: receipts_graph receipts_graph_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.receipts_graph
    ADD CONSTRAINT receipts_graph_uniqueness UNIQUE (room_id, receipt_type, user_id);


--
-- Name: receipts_linearized receipts_linearized_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.receipts_linearized
    ADD CONSTRAINT receipts_linearized_uniqueness UNIQUE (room_id, receipt_type, user_id);


--
-- Name: received_transactions received_transactions_transaction_id_origin_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.received_transactions
    ADD CONSTRAINT received_transactions_transaction_id_origin_key UNIQUE (transaction_id, origin);


--
-- Name: redactions redactions_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.redactions
    ADD CONSTRAINT redactions_event_id_key UNIQUE (event_id);


--
-- Name: rejections rejections_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.rejections
    ADD CONSTRAINT rejections_event_id_key UNIQUE (event_id);


--
-- Name: remote_media_cache remote_media_cache_media_origin_media_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.remote_media_cache
    ADD CONSTRAINT remote_media_cache_media_origin_media_id_key UNIQUE (media_origin, media_id);


--
-- Name: remote_media_cache_thumbnails remote_media_cache_thumbnails_media_origin_media_id_thumbna_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.remote_media_cache_thumbnails
    ADD CONSTRAINT remote_media_cache_thumbnails_media_origin_media_id_thumbna_key UNIQUE (media_origin, media_id, thumbnail_width, thumbnail_height, thumbnail_type);


--
-- Name: room_account_data room_account_data_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.room_account_data
    ADD CONSTRAINT room_account_data_uniqueness UNIQUE (user_id, room_id, account_data_type);


--
-- Name: room_aliases room_aliases_room_alias_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.room_aliases
    ADD CONSTRAINT room_aliases_room_alias_key UNIQUE (room_alias);


--
-- Name: room_depth room_depth_room_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.room_depth
    ADD CONSTRAINT room_depth_room_id_key UNIQUE (room_id);


--
-- Name: room_hosts room_hosts_room_id_host_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.room_hosts
    ADD CONSTRAINT room_hosts_room_id_host_key UNIQUE (room_id, host);


--
-- Name: room_memberships room_memberships_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.room_memberships
    ADD CONSTRAINT room_memberships_event_id_key UNIQUE (event_id);


--
-- Name: room_names room_names_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.room_names
    ADD CONSTRAINT room_names_event_id_key UNIQUE (event_id);


--
-- Name: room_tags_revisions room_tag_revisions_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.room_tags_revisions
    ADD CONSTRAINT room_tag_revisions_uniqueness UNIQUE (user_id, room_id);


--
-- Name: room_tags room_tag_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.room_tags
    ADD CONSTRAINT room_tag_uniqueness UNIQUE (user_id, room_id, tag);


--
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (room_id);


--
-- Name: schema_version schema_version_lock_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.schema_version
    ADD CONSTRAINT schema_version_lock_key UNIQUE (lock);


--
-- Name: server_keys_json server_keys_json_uniqueness; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.server_keys_json
    ADD CONSTRAINT server_keys_json_uniqueness UNIQUE (server_name, key_id, from_server);


--
-- Name: server_signature_keys server_signature_keys_server_name_key_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.server_signature_keys
    ADD CONSTRAINT server_signature_keys_server_name_key_id_key UNIQUE (server_name, key_id);


--
-- Name: server_tls_certificates server_tls_certificates_server_name_fingerprint_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.server_tls_certificates
    ADD CONSTRAINT server_tls_certificates_server_name_fingerprint_key UNIQUE (server_name, fingerprint);


--
-- Name: state_events state_events_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.state_events
    ADD CONSTRAINT state_events_event_id_key UNIQUE (event_id);


--
-- Name: state_forward_extremities state_forward_extremities_event_id_room_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.state_forward_extremities
    ADD CONSTRAINT state_forward_extremities_event_id_room_id_key UNIQUE (event_id, room_id);


--
-- Name: state_groups state_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.state_groups
    ADD CONSTRAINT state_groups_pkey PRIMARY KEY (id);


--
-- Name: topics topics_event_id_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_event_id_key UNIQUE (event_id);


--
-- Name: transaction_id_to_pdu transaction_id_to_pdu_transaction_id_destination_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.transaction_id_to_pdu
    ADD CONSTRAINT transaction_id_to_pdu_transaction_id_destination_key UNIQUE (transaction_id, destination);


--
-- Name: user_directory_stream_pos user_directory_stream_pos_lock_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.user_directory_stream_pos
    ADD CONSTRAINT user_directory_stream_pos_lock_key UNIQUE (lock);


--
-- Name: users users_name_key; Type: CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_name_key UNIQUE (name);


--
-- Name: access_tokens_device_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX access_tokens_device_id ON public.access_tokens USING btree (user_id, device_id);


--
-- Name: account_data_stream_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX account_data_stream_id ON public.account_data USING btree (user_id, stream_id);


--
-- Name: application_services_txns_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX application_services_txns_id ON public.application_services_txns USING btree (as_id);


--
-- Name: appservice_room_list_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX appservice_room_list_idx ON public.appservice_room_list USING btree (appservice_id, network_id, room_id);


--
-- Name: blocked_rooms_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX blocked_rooms_idx ON public.blocked_rooms USING btree (room_id);


--
-- Name: cache_invalidation_stream_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX cache_invalidation_stream_id ON public.cache_invalidation_stream USING btree (stream_id);


--
-- Name: current_state_delta_stream_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX current_state_delta_stream_idx ON public.current_state_delta_stream USING btree (stream_id);


--
-- Name: current_state_events_member_index; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX current_state_events_member_index ON public.current_state_events USING btree (state_key) WHERE (type = 'm.room.member'::text);


--
-- Name: deleted_pushers_stream_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX deleted_pushers_stream_id ON public.deleted_pushers USING btree (stream_id);


--
-- Name: device_federation_inbox_sender_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_federation_inbox_sender_id ON public.device_federation_inbox USING btree (origin, message_id);


--
-- Name: device_federation_outbox_destination_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_federation_outbox_destination_id ON public.device_federation_outbox USING btree (destination, stream_id);


--
-- Name: device_federation_outbox_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_federation_outbox_id ON public.device_federation_outbox USING btree (stream_id);


--
-- Name: device_inbox_stream_id_user_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_inbox_stream_id_user_id ON public.device_inbox USING btree (stream_id, user_id);


--
-- Name: device_inbox_user_stream_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_inbox_user_stream_id ON public.device_inbox USING btree (user_id, device_id, stream_id);


--
-- Name: device_lists_outbound_last_success_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_lists_outbound_last_success_idx ON public.device_lists_outbound_last_success USING btree (destination, user_id, stream_id);


--
-- Name: device_lists_outbound_pokes_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_lists_outbound_pokes_id ON public.device_lists_outbound_pokes USING btree (destination, stream_id);


--
-- Name: device_lists_outbound_pokes_stream; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_lists_outbound_pokes_stream ON public.device_lists_outbound_pokes USING btree (stream_id);


--
-- Name: device_lists_outbound_pokes_user; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_lists_outbound_pokes_user ON public.device_lists_outbound_pokes USING btree (destination, user_id);


--
-- Name: device_lists_remote_cache_unique_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX device_lists_remote_cache_unique_id ON public.device_lists_remote_cache USING btree (user_id, device_id);


--
-- Name: device_lists_remote_extremeties_unique_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX device_lists_remote_extremeties_unique_idx ON public.device_lists_remote_extremeties USING btree (user_id);


--
-- Name: device_lists_stream_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_lists_stream_id ON public.device_lists_stream USING btree (stream_id, user_id);


--
-- Name: device_lists_stream_user_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX device_lists_stream_user_id ON public.device_lists_stream USING btree (user_id, device_id);


--
-- Name: e2e_room_keys_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX e2e_room_keys_idx ON public.e2e_room_keys USING btree (user_id, room_id, session_id);


--
-- Name: e2e_room_keys_versions_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX e2e_room_keys_versions_idx ON public.e2e_room_keys_versions USING btree (user_id, version);


--
-- Name: erased_users_user; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX erased_users_user ON public.erased_users USING btree (user_id);


--
-- Name: ev_b_extrem_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX ev_b_extrem_id ON public.event_backward_extremities USING btree (event_id);


--
-- Name: ev_b_extrem_room; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX ev_b_extrem_room ON public.event_backward_extremities USING btree (room_id);


--
-- Name: ev_edges_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX ev_edges_id ON public.event_edges USING btree (event_id);


--
-- Name: ev_edges_prev_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX ev_edges_prev_id ON public.event_edges USING btree (prev_event_id);


--
-- Name: ev_extrem_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX ev_extrem_id ON public.event_forward_extremities USING btree (event_id);


--
-- Name: ev_extrem_room; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX ev_extrem_room ON public.event_forward_extremities USING btree (room_id);


--
-- Name: evauth_edges_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX evauth_edges_id ON public.event_auth USING btree (event_id);


--
-- Name: event_contains_url_index; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_contains_url_index ON public.events USING btree (room_id, topological_ordering, stream_ordering) WHERE ((contains_url = true) AND (outlier = false));


--
-- Name: event_json_room_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_json_room_id ON public.event_json USING btree (room_id);


--
-- Name: event_push_actions_highlights_index; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_push_actions_highlights_index ON public.event_push_actions USING btree (user_id, room_id, topological_ordering, stream_ordering) WHERE (highlight = 1);


--
-- Name: event_push_actions_rm_tokens; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_push_actions_rm_tokens ON public.event_push_actions USING btree (user_id, room_id, topological_ordering, stream_ordering);


--
-- Name: event_push_actions_room_id_user_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_push_actions_room_id_user_id ON public.event_push_actions USING btree (room_id, user_id);


--
-- Name: event_push_actions_staging_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_push_actions_staging_id ON public.event_push_actions_staging USING btree (event_id);


--
-- Name: event_push_actions_stream_ordering; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_push_actions_stream_ordering ON public.event_push_actions USING btree (stream_ordering, user_id);


--
-- Name: event_push_actions_u_highlight; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_push_actions_u_highlight ON public.event_push_actions USING btree (user_id, stream_ordering);


--
-- Name: event_push_summary_user_rm; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_push_summary_user_rm ON public.event_push_summary USING btree (user_id, room_id);


--
-- Name: event_reference_hashes_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_reference_hashes_id ON public.event_reference_hashes USING btree (event_id);


--
-- Name: event_search_ev_ridx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_search_ev_ridx ON public.event_search USING btree (room_id);


--
-- Name: event_search_event_id_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX event_search_event_id_idx ON public.event_search USING btree (event_id);


--
-- Name: event_search_fts_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_search_fts_idx ON public.event_search USING gin (vector);


--
-- Name: event_to_state_groups_sg_index; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX event_to_state_groups_sg_index ON public.event_to_state_groups USING btree (state_group);


--
-- Name: events_order_room; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX events_order_room ON public.events USING btree (room_id, topological_ordering, stream_ordering);


--
-- Name: events_room_stream; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX events_room_stream ON public.events USING btree (room_id, stream_ordering);


--
-- Name: events_ts; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX events_ts ON public.events USING btree (origin_server_ts, stream_ordering);


--
-- Name: group_attestations_remote_g_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX group_attestations_remote_g_idx ON public.group_attestations_remote USING btree (group_id, user_id);


--
-- Name: group_attestations_remote_u_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX group_attestations_remote_u_idx ON public.group_attestations_remote USING btree (user_id);


--
-- Name: group_attestations_remote_v_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX group_attestations_remote_v_idx ON public.group_attestations_remote USING btree (valid_until_ms);


--
-- Name: group_attestations_renewals_g_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX group_attestations_renewals_g_idx ON public.group_attestations_renewals USING btree (group_id, user_id);


--
-- Name: group_attestations_renewals_u_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX group_attestations_renewals_u_idx ON public.group_attestations_renewals USING btree (user_id);


--
-- Name: group_attestations_renewals_v_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX group_attestations_renewals_v_idx ON public.group_attestations_renewals USING btree (valid_until_ms);


--
-- Name: group_invites_g_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX group_invites_g_idx ON public.group_invites USING btree (group_id, user_id);


--
-- Name: group_invites_u_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX group_invites_u_idx ON public.group_invites USING btree (user_id);


--
-- Name: group_rooms_g_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX group_rooms_g_idx ON public.group_rooms USING btree (group_id, room_id);


--
-- Name: group_rooms_r_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX group_rooms_r_idx ON public.group_rooms USING btree (room_id);


--
-- Name: group_summary_rooms_g_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX group_summary_rooms_g_idx ON public.group_summary_rooms USING btree (group_id, room_id, category_id);


--
-- Name: group_summary_users_g_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX group_summary_users_g_idx ON public.group_summary_users USING btree (group_id);


--
-- Name: group_users_g_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX group_users_g_idx ON public.group_users USING btree (group_id, user_id);


--
-- Name: group_users_u_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX group_users_u_idx ON public.group_users USING btree (user_id);


--
-- Name: groups_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX groups_idx ON public.groups USING btree (group_id);


--
-- Name: local_group_membership_g_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX local_group_membership_g_idx ON public.local_group_membership USING btree (group_id);


--
-- Name: local_group_membership_u_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX local_group_membership_u_idx ON public.local_group_membership USING btree (user_id, group_id);


--
-- Name: local_invites_for_user_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX local_invites_for_user_idx ON public.local_invites USING btree (invitee, locally_rejected, replaced_by, room_id);


--
-- Name: local_invites_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX local_invites_id ON public.local_invites USING btree (stream_id);


--
-- Name: local_media_repository_thumbnails_media_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX local_media_repository_thumbnails_media_id ON public.local_media_repository_thumbnails USING btree (media_id);


--
-- Name: local_media_repository_url_cache_by_url_download_ts; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX local_media_repository_url_cache_by_url_download_ts ON public.local_media_repository_url_cache USING btree (url, download_ts);


--
-- Name: local_media_repository_url_cache_expires_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX local_media_repository_url_cache_expires_idx ON public.local_media_repository_url_cache USING btree (expires_ts);


--
-- Name: local_media_repository_url_cache_media_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX local_media_repository_url_cache_media_idx ON public.local_media_repository_url_cache USING btree (media_id);


--
-- Name: local_media_repository_url_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX local_media_repository_url_idx ON public.local_media_repository USING btree (created_ts) WHERE (url_cache IS NOT NULL);


--
-- Name: monthly_active_users_time_stamp; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX monthly_active_users_time_stamp ON public.monthly_active_users USING btree ("timestamp");


--
-- Name: monthly_active_users_users; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX monthly_active_users_users ON public.monthly_active_users USING btree (user_id);


--
-- Name: open_id_tokens_ts_valid_until_ms; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX open_id_tokens_ts_valid_until_ms ON public.open_id_tokens USING btree (ts_valid_until_ms);


--
-- Name: presence_list_user_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX presence_list_user_id ON public.presence_list USING btree (user_id);


--
-- Name: presence_stream_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX presence_stream_id ON public.presence_stream USING btree (stream_id, user_id);


--
-- Name: presence_stream_user_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX presence_stream_user_id ON public.presence_stream USING btree (user_id);


--
-- Name: public_room_index; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX public_room_index ON public.rooms USING btree (is_public);


--
-- Name: public_room_list_stream_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX public_room_list_stream_idx ON public.public_room_list_stream USING btree (stream_id);


--
-- Name: public_room_list_stream_rm_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX public_room_list_stream_rm_idx ON public.public_room_list_stream USING btree (room_id, stream_id);


--
-- Name: push_rules_enable_user_name; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX push_rules_enable_user_name ON public.push_rules_enable USING btree (user_name);


--
-- Name: push_rules_stream_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX push_rules_stream_id ON public.push_rules_stream USING btree (stream_id);


--
-- Name: push_rules_stream_user_stream_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX push_rules_stream_user_stream_id ON public.push_rules_stream USING btree (user_id, stream_id);


--
-- Name: push_rules_user_name; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX push_rules_user_name ON public.push_rules USING btree (user_name);


--
-- Name: ratelimit_override_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX ratelimit_override_idx ON public.ratelimit_override USING btree (user_id);


--
-- Name: receipts_linearized_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX receipts_linearized_id ON public.receipts_linearized USING btree (stream_id);


--
-- Name: receipts_linearized_room_stream; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX receipts_linearized_room_stream ON public.receipts_linearized USING btree (room_id, stream_id);


--
-- Name: receipts_linearized_user; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX receipts_linearized_user ON public.receipts_linearized USING btree (user_id);


--
-- Name: received_transactions_ts; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX received_transactions_ts ON public.received_transactions USING btree (ts);


--
-- Name: redactions_redacts; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX redactions_redacts ON public.redactions USING btree (redacts);


--
-- Name: remote_profile_cache_time; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX remote_profile_cache_time ON public.remote_profile_cache USING btree (last_check);


--
-- Name: remote_profile_cache_user_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX remote_profile_cache_user_id ON public.remote_profile_cache USING btree (user_id);


--
-- Name: room_account_data_stream_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX room_account_data_stream_id ON public.room_account_data USING btree (user_id, stream_id);


--
-- Name: room_alias_servers_alias; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX room_alias_servers_alias ON public.room_alias_servers USING btree (room_alias);


--
-- Name: room_aliases_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX room_aliases_id ON public.room_aliases USING btree (room_id);


--
-- Name: room_depth_room; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX room_depth_room ON public.room_depth USING btree (room_id);


--
-- Name: room_memberships_room_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX room_memberships_room_id ON public.room_memberships USING btree (room_id);


--
-- Name: room_memberships_user_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX room_memberships_user_id ON public.room_memberships USING btree (user_id);


--
-- Name: room_names_room_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX room_names_room_id ON public.room_names USING btree (room_id);


--
-- Name: st_extrem_keys; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX st_extrem_keys ON public.state_forward_extremities USING btree (room_id, type, state_key);


--
-- Name: state_group_edges_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX state_group_edges_idx ON public.state_group_edges USING btree (state_group);


--
-- Name: state_group_edges_prev_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX state_group_edges_prev_idx ON public.state_group_edges USING btree (prev_state_group);


--
-- Name: state_groups_state_type_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX state_groups_state_type_idx ON public.state_groups_state USING btree (state_group, type, state_key);


--
-- Name: stream_ordering_to_exterm_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX stream_ordering_to_exterm_idx ON public.stream_ordering_to_exterm USING btree (stream_ordering);


--
-- Name: stream_ordering_to_exterm_rm_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX stream_ordering_to_exterm_rm_idx ON public.stream_ordering_to_exterm USING btree (room_id, stream_ordering);


--
-- Name: threepid_guest_access_tokens_index; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX threepid_guest_access_tokens_index ON public.threepid_guest_access_tokens USING btree (medium, address);


--
-- Name: topics_room_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX topics_room_id ON public.topics USING btree (room_id);


--
-- Name: transaction_id_to_pdu_dest; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX transaction_id_to_pdu_dest ON public.transaction_id_to_pdu USING btree (destination);


--
-- Name: user_daily_visits_ts_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_daily_visits_ts_idx ON public.user_daily_visits USING btree ("timestamp");


--
-- Name: user_daily_visits_uts_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_daily_visits_uts_idx ON public.user_daily_visits USING btree (user_id, "timestamp");


--
-- Name: user_directory_room_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_directory_room_idx ON public.user_directory USING btree (room_id);


--
-- Name: user_directory_search_fts_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_directory_search_fts_idx ON public.user_directory_search USING gin (vector);


--
-- Name: user_directory_search_user_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX user_directory_search_user_idx ON public.user_directory_search USING btree (user_id);


--
-- Name: user_directory_user_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX user_directory_user_idx ON public.user_directory USING btree (user_id);


--
-- Name: user_filters_by_user_id_filter_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_filters_by_user_id_filter_id ON public.user_filters USING btree (user_id, filter_id);


--
-- Name: user_ips_device_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_ips_device_id ON public.user_ips USING btree (user_id, device_id, last_seen);


--
-- Name: user_ips_last_seen; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_ips_last_seen ON public.user_ips USING btree (user_id, last_seen);


--
-- Name: user_ips_last_seen_only; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_ips_last_seen_only ON public.user_ips USING btree (last_seen);


--
-- Name: user_ips_user_ip; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_ips_user_ip ON public.user_ips USING btree (user_id, access_token, ip);


--
-- Name: user_threepids_medium_address; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_threepids_medium_address ON public.user_threepids USING btree (medium, address);


--
-- Name: user_threepids_user_id; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX user_threepids_user_id ON public.user_threepids USING btree (user_id);


--
-- Name: users_creation_ts; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX users_creation_ts ON public.users USING btree (creation_ts);


--
-- Name: users_in_public_rooms_room_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX users_in_public_rooms_room_idx ON public.users_in_public_rooms USING btree (room_id);


--
-- Name: users_in_public_rooms_user_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX users_in_public_rooms_user_idx ON public.users_in_public_rooms USING btree (user_id);


--
-- Name: users_who_share_rooms_o_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX users_who_share_rooms_o_idx ON public.users_who_share_rooms USING btree (other_user_id);


--
-- Name: users_who_share_rooms_r_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE INDEX users_who_share_rooms_r_idx ON public.users_who_share_rooms USING btree (room_id);


--
-- Name: users_who_share_rooms_u_idx; Type: INDEX; Schema: public; Owner: synapse
--

CREATE UNIQUE INDEX users_who_share_rooms_u_idx ON public.users_who_share_rooms USING btree (user_id, other_user_id);


--
-- Name: application_services_regex application_services_regex_as_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: synapse
--

ALTER TABLE ONLY public.application_services_regex
    ADD CONSTRAINT application_services_regex_as_id_fkey FOREIGN KEY (as_id) REFERENCES public.application_services(id);


--
-- PostgreSQL database dump complete
--

