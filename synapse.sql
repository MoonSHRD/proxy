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
6	@user1:localhost	DZEFOEKZYR	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEB1c2VyMTpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSAuYXFXLl5mUWFzajZWWm9fCjAwMmZzaWduYXR1cmUgp-mt0uZgGfYKIdmKNJy_9UT-r78ArZmUU9ei-ynIWGcK	\N
7	@user2:localhost	IJWYZRUMUD	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEB1c2VyMjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBkczZraE0qTjVMOipsKmduCjAwMmZzaWduYXR1cmUgge-PObH-j2PX7A-mKSn6YN8FsoXu2PGUaoI4CK3N_t0K	\N
9	@user2:localhost	SZDGWSGKHC	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEB1c2VyMjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBaMkY5QiM9Y0JGSTpCcCM7CjAwMmZzaWduYXR1cmUgjuACnNh8k3chc2EchVVDjmkI9X1tXKrk03VmuXW1yUwK	\N
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
X	9
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
2	get_user_by_id	{@user1:localhost}	1547924749848
3	get_users_in_room	{!YvivtdTtsTAmNnsRUw:localhost}	1547924750089
4	get_room_summary	{!YvivtdTtsTAmNnsRUw:localhost}	1547924750089
5	get_current_state_ids	{!YvivtdTtsTAmNnsRUw:localhost}	1547924750089
6	get_rooms_for_user_with_stream_ordering	{@user1:localhost}	1547924750173
7	is_host_joined	{!YvivtdTtsTAmNnsRUw:localhost,localhost}	1547924750175
8	was_host_joined	{!YvivtdTtsTAmNnsRUw:localhost,localhost}	1547924750176
9	get_users_in_room	{!YvivtdTtsTAmNnsRUw:localhost}	1547924750176
10	get_room_summary	{!YvivtdTtsTAmNnsRUw:localhost}	1547924750178
11	get_current_state_ids	{!YvivtdTtsTAmNnsRUw:localhost}	1547924750179
12	get_users_in_room	{!YvivtdTtsTAmNnsRUw:localhost}	1547924750240
13	get_room_summary	{!YvivtdTtsTAmNnsRUw:localhost}	1547924750240
14	get_current_state_ids	{!YvivtdTtsTAmNnsRUw:localhost}	1547924750240
15	get_users_in_room	{!YvivtdTtsTAmNnsRUw:localhost}	1547924750288
16	get_room_summary	{!YvivtdTtsTAmNnsRUw:localhost}	1547924750288
17	get_current_state_ids	{!YvivtdTtsTAmNnsRUw:localhost}	1547924750289
18	get_users_in_room	{!YvivtdTtsTAmNnsRUw:localhost}	1547924750324
19	get_room_summary	{!YvivtdTtsTAmNnsRUw:localhost}	1547924750324
20	get_current_state_ids	{!YvivtdTtsTAmNnsRUw:localhost}	1547924750324
21	count_e2e_one_time_keys	{@user1:localhost,HBSKQKGJTX}	1547924750354
22	get_users_in_room	{!YvivtdTtsTAmNnsRUw:localhost}	1547924750381
23	get_room_summary	{!YvivtdTtsTAmNnsRUw:localhost}	1547924750381
24	get_current_state_ids	{!YvivtdTtsTAmNnsRUw:localhost}	1547924750382
25	count_e2e_one_time_keys	{@user1:localhost,HBSKQKGJTX}	1547924750392
26	count_e2e_one_time_keys	{@user1:localhost,HBSKQKGJTX}	1547924750433
27	count_e2e_one_time_keys	{@user1:localhost,HBSKQKGJTX}	1547924750474
28	count_e2e_one_time_keys	{@user1:localhost,HBSKQKGJTX}	1547924750511
29	count_e2e_one_time_keys	{@user1:localhost,HBSKQKGJTX}	1547924750543
30	count_e2e_one_time_keys	{@user1:localhost,HBSKQKGJTX}	1547924750598
31	count_e2e_one_time_keys	{@user1:localhost,HBSKQKGJTX}	1547924750673
32	count_e2e_one_time_keys	{@user1:localhost,HBSKQKGJTX}	1547924750721
33	count_e2e_one_time_keys	{@user1:localhost,HBSKQKGJTX}	1547924750772
34	get_users_in_room	{!DwnsPKUkFrUbPENRUr:localhost}	1547924817947
35	get_room_summary	{!DwnsPKUkFrUbPENRUr:localhost}	1547924817947
36	get_current_state_ids	{!DwnsPKUkFrUbPENRUr:localhost}	1547924817948
37	get_rooms_for_user_with_stream_ordering	{@user1:localhost}	1547924817994
38	is_host_joined	{!DwnsPKUkFrUbPENRUr:localhost,localhost}	1547924817995
39	was_host_joined	{!DwnsPKUkFrUbPENRUr:localhost,localhost}	1547924817995
40	get_users_in_room	{!DwnsPKUkFrUbPENRUr:localhost}	1547924817995
41	get_room_summary	{!DwnsPKUkFrUbPENRUr:localhost}	1547924817995
42	get_current_state_ids	{!DwnsPKUkFrUbPENRUr:localhost}	1547924817995
43	get_users_in_room	{!DwnsPKUkFrUbPENRUr:localhost}	1547924818046
44	get_room_summary	{!DwnsPKUkFrUbPENRUr:localhost}	1547924818046
45	get_current_state_ids	{!DwnsPKUkFrUbPENRUr:localhost}	1547924818047
46	get_users_in_room	{!DwnsPKUkFrUbPENRUr:localhost}	1547924818112
47	get_room_summary	{!DwnsPKUkFrUbPENRUr:localhost}	1547924818112
48	get_current_state_ids	{!DwnsPKUkFrUbPENRUr:localhost}	1547924818112
49	get_users_in_room	{!DwnsPKUkFrUbPENRUr:localhost}	1547924818159
50	get_room_summary	{!DwnsPKUkFrUbPENRUr:localhost}	1547924818159
51	get_current_state_ids	{!DwnsPKUkFrUbPENRUr:localhost}	1547924818159
52	get_users_in_room	{!DwnsPKUkFrUbPENRUr:localhost}	1547924818202
53	get_room_summary	{!DwnsPKUkFrUbPENRUr:localhost}	1547924818202
54	get_current_state_ids	{!DwnsPKUkFrUbPENRUr:localhost}	1547924818203
55	get_users_in_room	{!DwnsPKUkFrUbPENRUr:localhost}	1547924818252
56	get_room_summary	{!DwnsPKUkFrUbPENRUr:localhost}	1547924818253
57	get_current_state_ids	{!DwnsPKUkFrUbPENRUr:localhost}	1547924818253
58	get_users_in_room	{!DwnsPKUkFrUbPENRUr:localhost}	1547924835655
59	get_room_summary	{!DwnsPKUkFrUbPENRUr:localhost}	1547924835655
60	get_current_state_ids	{!DwnsPKUkFrUbPENRUr:localhost}	1547924835656
61	get_rooms_for_user_with_stream_ordering	{@user1:localhost}	1547924844151
62	is_host_joined	{!YvivtdTtsTAmNnsRUw:localhost,localhost}	1547924844151
63	was_host_joined	{!YvivtdTtsTAmNnsRUw:localhost,localhost}	1547924844152
64	get_users_in_room	{!YvivtdTtsTAmNnsRUw:localhost}	1547924844153
65	get_room_summary	{!YvivtdTtsTAmNnsRUw:localhost}	1547924844154
66	get_current_state_ids	{!YvivtdTtsTAmNnsRUw:localhost}	1547924844154
67	get_users_in_room	{!lxLGrxbEpguUZULoSC:localhost}	1547924882191
68	get_room_summary	{!lxLGrxbEpguUZULoSC:localhost}	1547924882191
69	get_current_state_ids	{!lxLGrxbEpguUZULoSC:localhost}	1547924882192
70	get_rooms_for_user_with_stream_ordering	{@user1:localhost}	1547924882239
71	is_host_joined	{!lxLGrxbEpguUZULoSC:localhost,localhost}	1547924882240
72	was_host_joined	{!lxLGrxbEpguUZULoSC:localhost,localhost}	1547924882240
73	get_users_in_room	{!lxLGrxbEpguUZULoSC:localhost}	1547924882240
74	get_room_summary	{!lxLGrxbEpguUZULoSC:localhost}	1547924882241
75	get_current_state_ids	{!lxLGrxbEpguUZULoSC:localhost}	1547924882241
76	get_users_in_room	{!lxLGrxbEpguUZULoSC:localhost}	1547924882303
77	get_room_summary	{!lxLGrxbEpguUZULoSC:localhost}	1547924882303
78	get_current_state_ids	{!lxLGrxbEpguUZULoSC:localhost}	1547924882304
79	get_users_in_room	{!lxLGrxbEpguUZULoSC:localhost}	1547924882365
80	get_room_summary	{!lxLGrxbEpguUZULoSC:localhost}	1547924882366
81	get_current_state_ids	{!lxLGrxbEpguUZULoSC:localhost}	1547924882367
82	get_users_in_room	{!lxLGrxbEpguUZULoSC:localhost}	1547924882449
83	get_room_summary	{!lxLGrxbEpguUZULoSC:localhost}	1547924882449
84	get_current_state_ids	{!lxLGrxbEpguUZULoSC:localhost}	1547924882450
85	get_users_in_room	{!lxLGrxbEpguUZULoSC:localhost}	1547924882491
86	get_room_summary	{!lxLGrxbEpguUZULoSC:localhost}	1547924882492
87	get_current_state_ids	{!lxLGrxbEpguUZULoSC:localhost}	1547924882493
88	get_users_in_room	{!lxLGrxbEpguUZULoSC:localhost}	1547924882534
89	get_room_summary	{!lxLGrxbEpguUZULoSC:localhost}	1547924882534
90	get_current_state_ids	{!lxLGrxbEpguUZULoSC:localhost}	1547924882534
91	get_users_in_room	{!lxLGrxbEpguUZULoSC:localhost}	1547924909374
92	get_room_summary	{!lxLGrxbEpguUZULoSC:localhost}	1547924909374
93	get_current_state_ids	{!lxLGrxbEpguUZULoSC:localhost}	1547924909375
94	get_user_by_access_token	{MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEB1c2VyMTpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBXa3pzVzhuTlZVbnhONkI3CjAwMmZzaWduYXR1cmUg8ZPiEzFO-7954suYD8UQRvI52-AQ9az7TYfJ3FFNHyIK}	1547924920216
95	count_e2e_one_time_keys	{@user1:localhost,HBSKQKGJTX}	1547924920221
96	get_user_by_id	{@user2:localhost}	1547924929873
97	get_users_in_room	{!tHjklMrpyrzHaqkxRt:localhost}	1547924929948
98	get_room_summary	{!tHjklMrpyrzHaqkxRt:localhost}	1547924929949
99	get_current_state_ids	{!tHjklMrpyrzHaqkxRt:localhost}	1547924929949
106	get_users_in_room	{!tHjklMrpyrzHaqkxRt:localhost}	1547924930080
107	get_room_summary	{!tHjklMrpyrzHaqkxRt:localhost}	1547924930080
108	get_current_state_ids	{!tHjklMrpyrzHaqkxRt:localhost}	1547924930082
109	get_users_in_room	{!tHjklMrpyrzHaqkxRt:localhost}	1547924930122
110	get_room_summary	{!tHjklMrpyrzHaqkxRt:localhost}	1547924930123
111	get_current_state_ids	{!tHjklMrpyrzHaqkxRt:localhost}	1547924930123
112	get_users_in_room	{!tHjklMrpyrzHaqkxRt:localhost}	1547924930176
113	get_room_summary	{!tHjklMrpyrzHaqkxRt:localhost}	1547924930177
114	get_current_state_ids	{!tHjklMrpyrzHaqkxRt:localhost}	1547924930177
115	get_users_in_room	{!tHjklMrpyrzHaqkxRt:localhost}	1547924930211
116	get_room_summary	{!tHjklMrpyrzHaqkxRt:localhost}	1547924930211
117	get_current_state_ids	{!tHjklMrpyrzHaqkxRt:localhost}	1547924930211
118	count_e2e_one_time_keys	{@user2:localhost,WZGSJQWHEI}	1547924931573
120	count_e2e_one_time_keys	{@user2:localhost,WZGSJQWHEI}	1547924931668
121	count_e2e_one_time_keys	{@user2:localhost,WZGSJQWHEI}	1547924931737
123	count_e2e_one_time_keys	{@user2:localhost,WZGSJQWHEI}	1547924931845
124	count_e2e_one_time_keys	{@user2:localhost,WZGSJQWHEI}	1547924931899
127	count_e2e_one_time_keys	{@user2:localhost,WZGSJQWHEI}	1547924932093
100	get_rooms_for_user_with_stream_ordering	{@user2:localhost}	1547924930023
101	is_host_joined	{!tHjklMrpyrzHaqkxRt:localhost,localhost}	1547924930023
102	was_host_joined	{!tHjklMrpyrzHaqkxRt:localhost,localhost}	1547924930024
103	get_users_in_room	{!tHjklMrpyrzHaqkxRt:localhost}	1547924930025
104	get_room_summary	{!tHjklMrpyrzHaqkxRt:localhost}	1547924930025
105	get_current_state_ids	{!tHjklMrpyrzHaqkxRt:localhost}	1547924930026
119	count_e2e_one_time_keys	{@user2:localhost,WZGSJQWHEI}	1547924931604
122	count_e2e_one_time_keys	{@user2:localhost,WZGSJQWHEI}	1547924931801
125	count_e2e_one_time_keys	{@user2:localhost,WZGSJQWHEI}	1547924931955
126	count_e2e_one_time_keys	{@user2:localhost,WZGSJQWHEI}	1547924932022
128	get_user_by_access_token	{MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEB1c2VyMjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSAtUmR4XzJDQUFXaXdDNCpzCjAwMmZzaWduYXR1cmUgAfHRNSJ9c0dYCzEjg1MuMDkNjUbFM9bIHbEW9R1xMgsK}	1547925058764
129	count_e2e_one_time_keys	{@user2:localhost,WZGSJQWHEI}	1547925058770
130	count_e2e_one_time_keys	{@user1:localhost,IQFCTAEHOC}	1547925062177
131	count_e2e_one_time_keys	{@user1:localhost,IQFCTAEHOC}	1547925062249
132	count_e2e_one_time_keys	{@user1:localhost,IQFCTAEHOC}	1547925062324
133	count_e2e_one_time_keys	{@user1:localhost,IQFCTAEHOC}	1547925062381
134	count_e2e_one_time_keys	{@user1:localhost,IQFCTAEHOC}	1547925062453
135	count_e2e_one_time_keys	{@user1:localhost,IQFCTAEHOC}	1547925062495
136	count_e2e_one_time_keys	{@user1:localhost,IQFCTAEHOC}	1547925062529
137	count_e2e_one_time_keys	{@user1:localhost,IQFCTAEHOC}	1547925062563
138	count_e2e_one_time_keys	{@user1:localhost,IQFCTAEHOC}	1547925062596
139	count_e2e_one_time_keys	{@user1:localhost,IQFCTAEHOC}	1547925062632
140	get_rooms_for_user_with_stream_ordering	{@user2:localhost}	1547925076683
141	is_host_joined	{!DwnsPKUkFrUbPENRUr:localhost,localhost}	1547925076683
142	was_host_joined	{!DwnsPKUkFrUbPENRUr:localhost,localhost}	1547925076684
143	get_users_in_room	{!DwnsPKUkFrUbPENRUr:localhost}	1547925076684
144	get_room_summary	{!DwnsPKUkFrUbPENRUr:localhost}	1547925076684
145	get_current_state_ids	{!DwnsPKUkFrUbPENRUr:localhost}	1547925076685
146	get_user_by_access_token	{MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEB1c2VyMTpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBORzBINlZ5QiNVODdsOm9fCjAwMmZzaWduYXR1cmUgGBYB0ctrWDLNFKZaRBLpaH4eYOgjrctaMTgT8TEaRPUK}	1547925139890
147	count_e2e_one_time_keys	{@user1:localhost,IQFCTAEHOC}	1547925139896
148	count_e2e_one_time_keys	{@user2:localhost,SZDGWSGKHC}	1547925143936
149	count_e2e_one_time_keys	{@user2:localhost,SZDGWSGKHC}	1547925144004
150	count_e2e_one_time_keys	{@user2:localhost,SZDGWSGKHC}	1547925144069
151	count_e2e_one_time_keys	{@user2:localhost,SZDGWSGKHC}	1547925144121
152	count_e2e_one_time_keys	{@user2:localhost,SZDGWSGKHC}	1547925144172
153	count_e2e_one_time_keys	{@user2:localhost,SZDGWSGKHC}	1547925144220
154	count_e2e_one_time_keys	{@user2:localhost,SZDGWSGKHC}	1547925144281
155	count_e2e_one_time_keys	{@user2:localhost,SZDGWSGKHC}	1547925144339
156	count_e2e_one_time_keys	{@user2:localhost,SZDGWSGKHC}	1547925144374
157	count_e2e_one_time_keys	{@user2:localhost,SZDGWSGKHC}	1547925144410
158	get_rooms_for_user_with_stream_ordering	{@user2:localhost}	1547925149694
159	is_host_joined	{!DwnsPKUkFrUbPENRUr:localhost,localhost}	1547925149695
160	was_host_joined	{!DwnsPKUkFrUbPENRUr:localhost,localhost}	1547925149696
161	get_users_in_room	{!DwnsPKUkFrUbPENRUr:localhost}	1547925149696
162	get_room_summary	{!DwnsPKUkFrUbPENRUr:localhost}	1547925149697
163	get_current_state_ids	{!DwnsPKUkFrUbPENRUr:localhost}	1547925149698
\.


--
-- Data for Name: current_state_delta_stream; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.current_state_delta_stream (stream_id, room_id, type, state_key, event_id, prev_event_id) FROM stdin;
2	!YvivtdTtsTAmNnsRUw:localhost	m.room.create		$15479247500OKKlI:localhost	\N
3	!YvivtdTtsTAmNnsRUw:localhost	m.room.member	@user1:localhost	$15479247501iUNIP:localhost	\N
4	!YvivtdTtsTAmNnsRUw:localhost	m.room.power_levels		$15479247502PzwLU:localhost	\N
5	!YvivtdTtsTAmNnsRUw:localhost	m.room.join_rules		$15479247503HdRXi:localhost	\N
6	!YvivtdTtsTAmNnsRUw:localhost	m.room.history_visibility		$15479247504DWCIT:localhost	\N
7	!YvivtdTtsTAmNnsRUw:localhost	m.room.guest_access		$15479247505lMKFc:localhost	\N
8	!DwnsPKUkFrUbPENRUr:localhost	m.room.create		$15479248177pgEuD:localhost	\N
9	!DwnsPKUkFrUbPENRUr:localhost	m.room.member	@user1:localhost	$15479248178PDnSR:localhost	\N
10	!DwnsPKUkFrUbPENRUr:localhost	m.room.power_levels		$15479248189maFVd:localhost	\N
11	!DwnsPKUkFrUbPENRUr:localhost	m.room.join_rules		$154792481810eHTrj:localhost	\N
12	!DwnsPKUkFrUbPENRUr:localhost	m.room.history_visibility		$154792481811UJmBV:localhost	\N
13	!DwnsPKUkFrUbPENRUr:localhost	m.room.guest_access		$154792481812FTgOr:localhost	\N
14	!DwnsPKUkFrUbPENRUr:localhost	m.room.name		$154792481813sscwS:localhost	\N
15	!DwnsPKUkFrUbPENRUr:localhost	m.room.related_groups		$154792483514Gzglm:localhost	\N
16	!YvivtdTtsTAmNnsRUw:localhost	m.room.member	@user1:localhost	$154792484415abNlG:localhost	$15479247501iUNIP:localhost
17	!lxLGrxbEpguUZULoSC:localhost	m.room.create		$154792488216AbRES:localhost	\N
18	!lxLGrxbEpguUZULoSC:localhost	m.room.member	@user1:localhost	$154792488217OnxTZ:localhost	\N
19	!lxLGrxbEpguUZULoSC:localhost	m.room.power_levels		$154792488218BUaoQ:localhost	\N
20	!lxLGrxbEpguUZULoSC:localhost	m.room.join_rules		$154792488219bruaB:localhost	\N
21	!lxLGrxbEpguUZULoSC:localhost	m.room.history_visibility		$154792488220dvrBE:localhost	\N
22	!lxLGrxbEpguUZULoSC:localhost	m.room.guest_access		$154792488221gUPQT:localhost	\N
23	!lxLGrxbEpguUZULoSC:localhost	m.room.name		$154792488222ZBqEn:localhost	\N
24	!lxLGrxbEpguUZULoSC:localhost	m.room.related_groups		$154792490923tISso:localhost	\N
25	!tHjklMrpyrzHaqkxRt:localhost	m.room.create		$154792492924bdmxc:localhost	\N
26	!tHjklMrpyrzHaqkxRt:localhost	m.room.member	@user2:localhost	$154792492925JZWbo:localhost	\N
27	!tHjklMrpyrzHaqkxRt:localhost	m.room.power_levels		$154792493026cBNiO:localhost	\N
28	!tHjklMrpyrzHaqkxRt:localhost	m.room.join_rules		$154792493027Gtrdl:localhost	\N
29	!tHjklMrpyrzHaqkxRt:localhost	m.room.history_visibility		$154792493028JotEC:localhost	\N
30	!tHjklMrpyrzHaqkxRt:localhost	m.room.guest_access		$154792493029TiWmR:localhost	\N
33	!DwnsPKUkFrUbPENRUr:localhost	m.room.member	@user2:localhost	$154792507633FUQML:localhost	\N
34	!DwnsPKUkFrUbPENRUr:localhost	m.room.member	@user2:localhost	$154792514935gxWdL:localhost	$154792507633FUQML:localhost
\.


--
-- Data for Name: current_state_events; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.current_state_events (event_id, room_id, type, state_key) FROM stdin;
$15479247500OKKlI:localhost	!YvivtdTtsTAmNnsRUw:localhost	m.room.create	
$15479247502PzwLU:localhost	!YvivtdTtsTAmNnsRUw:localhost	m.room.power_levels	
$15479247503HdRXi:localhost	!YvivtdTtsTAmNnsRUw:localhost	m.room.join_rules	
$15479247504DWCIT:localhost	!YvivtdTtsTAmNnsRUw:localhost	m.room.history_visibility	
$15479247505lMKFc:localhost	!YvivtdTtsTAmNnsRUw:localhost	m.room.guest_access	
$15479248177pgEuD:localhost	!DwnsPKUkFrUbPENRUr:localhost	m.room.create	
$15479248178PDnSR:localhost	!DwnsPKUkFrUbPENRUr:localhost	m.room.member	@user1:localhost
$15479248189maFVd:localhost	!DwnsPKUkFrUbPENRUr:localhost	m.room.power_levels	
$154792481810eHTrj:localhost	!DwnsPKUkFrUbPENRUr:localhost	m.room.join_rules	
$154792481811UJmBV:localhost	!DwnsPKUkFrUbPENRUr:localhost	m.room.history_visibility	
$154792481812FTgOr:localhost	!DwnsPKUkFrUbPENRUr:localhost	m.room.guest_access	
$154792481813sscwS:localhost	!DwnsPKUkFrUbPENRUr:localhost	m.room.name	
$154792483514Gzglm:localhost	!DwnsPKUkFrUbPENRUr:localhost	m.room.related_groups	
$154792484415abNlG:localhost	!YvivtdTtsTAmNnsRUw:localhost	m.room.member	@user1:localhost
$154792488216AbRES:localhost	!lxLGrxbEpguUZULoSC:localhost	m.room.create	
$154792488217OnxTZ:localhost	!lxLGrxbEpguUZULoSC:localhost	m.room.member	@user1:localhost
$154792488218BUaoQ:localhost	!lxLGrxbEpguUZULoSC:localhost	m.room.power_levels	
$154792488219bruaB:localhost	!lxLGrxbEpguUZULoSC:localhost	m.room.join_rules	
$154792488220dvrBE:localhost	!lxLGrxbEpguUZULoSC:localhost	m.room.history_visibility	
$154792488221gUPQT:localhost	!lxLGrxbEpguUZULoSC:localhost	m.room.guest_access	
$154792488222ZBqEn:localhost	!lxLGrxbEpguUZULoSC:localhost	m.room.name	
$154792490923tISso:localhost	!lxLGrxbEpguUZULoSC:localhost	m.room.related_groups	
$154792492924bdmxc:localhost	!tHjklMrpyrzHaqkxRt:localhost	m.room.create	
$154792492925JZWbo:localhost	!tHjklMrpyrzHaqkxRt:localhost	m.room.member	@user2:localhost
$154792493026cBNiO:localhost	!tHjklMrpyrzHaqkxRt:localhost	m.room.power_levels	
$154792493027Gtrdl:localhost	!tHjklMrpyrzHaqkxRt:localhost	m.room.join_rules	
$154792493028JotEC:localhost	!tHjklMrpyrzHaqkxRt:localhost	m.room.history_visibility	
$154792493029TiWmR:localhost	!tHjklMrpyrzHaqkxRt:localhost	m.room.guest_access	
$154792514935gxWdL:localhost	!DwnsPKUkFrUbPENRUr:localhost	m.room.member	@user2:localhost
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
matrix.org	1547924933613	600000
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
4	@user1:localhost	HBSKQKGJTX
7	@user1:localhost	DZEFOEKZYR
8	@user2:localhost	IJWYZRUMUD
9	@user2:localhost	WZGSJQWHEI
12	@user1:localhost	IQFCTAEHOC
14	@user2:localhost	SZDGWSGKHC
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
@user1:localhost	DZEFOEKZYR	\N
@user2:localhost	IJWYZRUMUD	\N
@user2:localhost	SZDGWSGKHC	https://riot.im/app/ via Chrome on Linux
\.


--
-- Data for Name: e2e_device_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_device_keys_json (user_id, device_id, ts_added_ms, key_json) FROM stdin;
@user2:localhost	SZDGWSGKHC	1547925142612	{"algorithms":["m.olm.v1.curve25519-aes-sha2","m.megolm.v1.aes-sha2"],"device_id":"SZDGWSGKHC","keys":{"curve25519:SZDGWSGKHC":"fOQCs3Qx7xY1KIqmiVWe0DjQxGgVj4anKU7HbQ0DfXo","ed25519:SZDGWSGKHC":"ZMtGaaHqhrPObiTa6qnegbfYpU3XJj90sDArY/BQsTE"},"signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"lVNUJDmp4BCiD+wROveERp/lDcxrXvGaCvyqMfYMR3cGBkF+jsboxGE5DDrnGxFEV1hTKHOPAmuokvbPu251Dw"}},"user_id":"@user2:localhost"}
\.


--
-- Data for Name: e2e_one_time_keys_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.e2e_one_time_keys_json (user_id, device_id, algorithm, key_id, ts_added_ms, key_json) FROM stdin;
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAABQ	1547925143932	{"key":"bNVc9mDuxKlhp98kq63XNVIdKTX0XRcmTy6LnQ50DHA","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"/VeQ8LoE4GA9dM2syhUrs11uu95dxzhhGqXkF16JgdknP4YKZtF1d65JaVjx0wD4ya6WPSTksFXZqCpguSlGAQ"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAABA	1547925143932	{"key":"CkghBTddqprBzsiF/ADiligDI2tAzjzFp+9oMgDd5WQ","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"m2Oqa3AM39Nt/YddQe4k2iyODg0kyYmp2O8ZfxyNLxpvuh31G4wTVapY0EQJaaHg778rzneYgZxFy8kPDw99BQ"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAAw	1547925143932	{"key":"dJC33lftOeH+o+IyH2/MBzOsFwN+aROFm1B/eMmgGxY","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"jzbGUL7WRKh2tnXBMxm5nF1yRBy5A+cMygz6xEF3wd+umKJL5Bs5z8YzhMgIBGTMNBvp/PTXIeZvC2Zc+UJzAA"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAAg	1547925143932	{"key":"hzdXP4EEuHEPS/o/+MPR6Q/CzmZTS1dLuBdeIAcQNDA","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"eadhyaCVIdMJdFHTC0YfEgW0DMEX32HHnVScHXxJduSSt5RnsnWwXNAfwSNe1RdX7WhZelgWaQuwciohRFBlCg"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAAQ	1547925143932	{"key":"UWhgT3tioy5+kIYvHtPardxaTvBHREhWRI5zT2n3CWY","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"h3irLkk3hoYR5Yg+HKuU+8mgcdCqHx5hDZdrsheqKbnLu971qazT10LinBVudXpKhHts99toXrb9prkQ0iAjAQ"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAACg	1547925143997	{"key":"OMW4KcVKHSBeXkthdCIxf2in4+K2Vdkl/l0djBZMylw","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"PIrVCiSVbbdT/SWI8swv1tw81bk43+xLEx1Q2HirgNVR+HeLR/52EZ7uFINd1NnZnwXeVcW9g7rEq7RGBXKzCA"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAACQ	1547925143997	{"key":"vIrCbZ9KRVc61TrdkpHpavG7TbJ8WJwyrpGS0Rvr3Tk","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"AFfcdPnDeGra2QOkQ2cw3RYRkRCfI21m65YZ5wSKuCXz/juWeRhULA+gtKxCM2jIQmT6ooF/S8EbLjq4ETBuCg"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAACA	1547925143997	{"key":"aFiDVZBV4E9zKO+CAe5RTaP2+R3OEIvVgWhRzZfVMBQ","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"u3oeMzF9pIPFOH/P8GY47QE5NfICMMCxk/+I5FcgMTi4JAc10Bz0DBqZYIsEKTViO/FNGsj4p4gR6LatLhPlCw"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAABw	1547925143997	{"key":"RqbFvwBZWtbX19mM0KVdyuqVifhP+nRN1v6HEICZPgw","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"chhOvYrDnno10lVfzsB2jUSPvYadt/1TlEPiP1Y+xIGhTR+8MhDJBz0iAGQu8n/wDOU/mqVSVCa/+4up5PXlBw"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAABg	1547925143997	{"key":"pfPaoM/XUrkUlygXArV+Z+QbLI2Eow9juyBFwDKTXwU","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"pXkPz3UcOdewQRrWLof6EIrt510y4VBDcoNIXZL0VZxvGaNn+dEDq/GTbOVncxrnXJLnXnDDPBR34jahU2h1AQ"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAADw	1547925144062	{"key":"MUrv5MO6/ancq77/luZ9pfMZmPPUYcxvT5vnjfuCMHY","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"HKR8SqInB5osM8HngygYQ0+29HQKj6zfSfWw8XuTceewC5r0bocire+hbHxncakd0OqtdfgcREWu3x+bVqsvCg"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAADg	1547925144062	{"key":"pX9JtZVn/QLh2xSQEy3wf16dQTFwW+Yfa2ysy3ghPW8","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"tSNK/Br1/E74uX4xDJij43OfE1EXOpinyLzse9uO5IuiWVCRYPWG+WYsaGZVGE3MSBkSXZJZxD0hCwWt4HtrBg"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAADQ	1547925144062	{"key":"F1gbB16ySg0G2Nkfmghkdgm4UDVi6+Frtu71hlaxsnM","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"Hv9ASlry8mc6A3Pwmpojg3k/Crb/jrF9bMcmx7Rt5tP2fQZHS5QxG2fIj1jnj5xkXkd4JiwF8/V2cSk1acJQCg"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAADA	1547925144062	{"key":"WOavgDHi1cQagsoOxlkaHKmmQEv4Zal6hWHk1354d1s","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"wJ9jzi+BsYSl85/9KaAlOgEnrcx798oSW2gMRLF2TMHaTmqd89d2oAjV3oAqX7pMMY5d7/0AY4XMyJ/ox2iDAw"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAACw	1547925144062	{"key":"QgdF/Vb7p9HfgHoPqyhjdSh9n5zW/yEJVa7VMnqfa1Q","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"+OtFRGzbiAOMCqhuuh6fs8fY2NSIhSvDpqVj5Eqj1C7jJhbJNIKN/7uk5nz9sytT/h7dxMhbwxR8+GT6eY0bCw"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAFA	1547925144116	{"key":"j18cBwQowxp5ddmAk1ixp+uALartlRNiXU7z8t2Chh0","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"uinD7ZBiArKf1yGXdqz4gPzJzaG8mVAvSOk7fA9BQ1nozQFUrHDW9zktoSmtuGCSuM7+cj8nJFALtiEOLeCMBw"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAEw	1547925144116	{"key":"93FWo1aodfpQVm+rOz4SIYYhHP9YsomD+rlsuOXZrEc","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"dWZWM5gvzBqsfPam58YAazlrizT9UEjtTz7yyV0tSj3DA1j063gy7JnAaNdNTXktfIEsouH95syzo9Ixt74TBQ"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAEg	1547925144116	{"key":"/8Zku8c3bKM0qcnxsxrs8YM87Wv1cEU5swsGHBok7Gk","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"wOeE8/zDqy6HJaPhU34omvZmweceKoLsC/xMRoca4KT48YbkTBzZmmDDZ3EJ4X4ilefp6ZNTqVxitjqdb73GDA"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAEQ	1547925144116	{"key":"T1bEXUc0ymusj/BWGWbYQyLroNUJBdSvDBPOmTnCdEg","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"moyMdBLa/7phkw6MVW4TZ05TMCLe1tT2+hoORpRl2ZtActRnpYaVncLhaTXq6kiA+y4qibbf19btew72i5QqAA"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAEA	1547925144116	{"key":"I7jT/6NFTWwG2Eq6C5wXA9KM0eueuQ6PAujcgkGlRwg","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"tbVU/GstZPU+CBfPtJQOaVsdMeRtJIT9FF5OGYmNqyqhjHHcojmoPBnt73UN8a3+FSMOSTzdUVHrnhb16/bMDA"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAGQ	1547925144167	{"key":"JQXqT0CkaRoyVVF9xFQ607Pqj9uD8aisQzkbUeFCoHE","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"XwdbXnZoopBHSfIwtkdHOdJkM1HxlU0n1Sz4tC7lmkNZde3Tbv4JwZaXCgocii4qaRPsfCQzMEiUi0MoZrzxDw"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAGA	1547925144167	{"key":"AuWWn+MarsbigWMU0UcVU46/oOIhx+Uf9y9nToTQY28","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"flXh2l067AL/bGxTZfFA4s+cthr0zDx297AdK8gBP8wL0tcRwjZrKhcBlFrj1eBnSDNNtkLQqO/EzXbZMeG8BA"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAFw	1547925144167	{"key":"Y08+QmDeOb/ENORXNAVIDNd+bWnwKs4RgBvBBCo1Xn8","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"wuDcro9yqED0+IbCm6cfjqVjR6t3sf5qyVBBRnmme29/biQO/lj9sfdT1QAdtsavr/duvDvKA4GFOYGyHti2Dw"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAFg	1547925144167	{"key":"rYQ8Y5yO9322qT/Cc/okjyDA+dZHTPFhXIeK6gwRGCQ","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"TVFuqZi91DLFL9yrfWNgtbj3pvwujHqUblVsVMYrdw2zpe4ofpKNWAPm0N1lKCRWKUnOvH7q9p7DU0n9tOv5Ag"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAFQ	1547925144167	{"key":"7EWpKc3CK8aj2FK0/lpuWocJBTSOR26A7fFRCnVf6BI","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"Kb8AGGjkkENawhLWUJKw35IoD/JdF5eeX4vEIu966Hfjdcd7cIjoGJRze33PJIOlzmUSuIb10cD36IMWDR0KBg"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAHg	1547925144217	{"key":"47hlNzKBHs3ZEjThUR6lAUk8VcwQjNSnzTBlysajvi4","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"tBT0I4wX0ygxwH+Pk04LmjLKaeJ+bF2mGFWNdK4JiPCVSU5VZOJAzaUzzu1SlTFs+zLpLNVGdXzMzF9eQolSCw"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAHQ	1547925144217	{"key":"5jQa5Hhm130pmmQaePvKEJBbcwW/Asy8HyVcHNiAM3w","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"A1pVIdMGbD8jNEyqhfcQYvcHRhEwEsF6uvKsjYRH3SZTLDXhtedm5MFpc8AtdwtS1ODTKzAk9ek9bQr8WJoVDw"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAHA	1547925144217	{"key":"OcPSXZmXBklBlXQ1wY7zINsdzviUkD1aXzcnpJ/ga2k","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"fI5EtMlxXi6AvxWEgnBvBV7ZP8xT3WDu475/EqCqvDU82uLSFtvPcbZ4rOa9OKK/utoFjiiTBJxF3zrH2QdLDA"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAGw	1547925144217	{"key":"UuSIBhMtbizdc+GRsJjGEKBDqtwU157CSBupjEQWwTo","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"56j0K1oju6KwqnoATrtW4tspdOxLQFSUD3zotL3irnImKn6vPFcNuTe4N26dcO6fiV0IFMqnmqFAMlJDT7EDCw"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAGg	1547925144217	{"key":"hNv6l7mvEAriGVz7ap6oGF31rpDoYwH8hDpkkUhThnA","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"fe0DvPtXYPQpLn4p5WoP+q4ofnrF0qvcP+XDkysnMW7VY040/JQGWxo+ZRdDufB+rf6QJKu6UoCG1EVYeMn2Cg"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAALQ	1547925144371	{"key":"Nq/gBtXRVQeQ8mkc76yLcQly5o3DjsefMMVVVnwDpSE","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"Gu66rtarTWUMRB2gcO4mQzhAI3ZO77AUgXSeUDlXjnMc46vSnviIeQOEz5TMCj/lEJNkszUKZ5V28ZDF0T7cCw"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAALA	1547925144371	{"key":"dNiKdBuBBx4GIFySBEmJTBEy+/li6dSN24364Kn7AWA","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"5U/UeFlsAjXOXtqjqk/8DDa34ODLvpql0GO8YUswRReK873uFHX4WKk+uHsaB3juW4AwoqvT9Qy00x4B/375Bg"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAKw	1547925144371	{"key":"P9ID4NNUbnTqyCQzB7YpFeMh3oF5fgb9xjfmCQKYwQk","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"zq/hj91VRjQM/+BWIN5y2sDQrxIZB382IZMDth0iv0tCppnV9mycc47qElTysUNdRTALmvCdEXlhwyTtPIQXDQ"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAKg	1547925144371	{"key":"9Rs9EYHsyPYGAYiLYWK4Knuzk7BvV8ymEWdPjKtx2GI","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"X3+7MVYuqMxFO2HSNjxxdoq8cc08G/O5AA91EIOpgzjprkVCV9/soBVD859ogUmPwC5UUEBnTh0o5hizMIw1Bw"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAKQ	1547925144371	{"key":"g7ffbsf6FVAPsutm+ceeUEp+zXBAwZNLRtLgSXpLuWo","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"R6Vm8zWI4OEESlRpPjRIvoE1RKaIc3jxoxaWGDaQ5DmAW/Npxiso2SdCRY3+lclbF+DOG4sv7sFSg81Ve6tfCg"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAIw	1547925144275	{"key":"/nO3RFEGt64e8TW945ppayNtQSPHD9bQ1eGg/AV3Y2k","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"muYFYED+Py3kDgGz9nr+xrwmYs4IsO7qr/XUOD+kW9d9Go/PxZW7tw22G/tNqGsGu7nqw5sbBooNSTajUfGcDw"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAIg	1547925144275	{"key":"qBjboPaoN0mxmOm70RhFheHPQ5zf5AfNeYyNtVq9nTs","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"Ic7gJbZl3k3w//aIhqpWiyRjnQssiRnCqUCsl76EPRWqvhCeoljPSSJak/WepS1VS5Zu/Ivu9R6iybThE1J9BA"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAIQ	1547925144275	{"key":"bz9M8EUW5M/zxGZ3IlJ/Js4JotQbv+wl9/BF/NbRmSQ","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"meRFdgK3R0WrWx3B4AnF0WvZZgcPoJ4hLdVZnQQiYjI0Fxh7ef1bRgyOzXEM12mmupiAtSC5WiW4yarEf4jaBw"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAIA	1547925144275	{"key":"EJb6zewkmyoZCoZJpGEO5TEcafynzxilkIN7oKi2zyQ","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"GCrtxujwgp95hQOq3nqEN/KixF4I4123jsfStFXD/0ri/wgtKTCpA9tb34EIdJPtyYzyICYu5lNEOr2n2TqWDg"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAHw	1547925144275	{"key":"yVvdWauNBrKNmdlvri24rgkUoB5E5i6xU49FlaVasyA","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"s7ppYb/ZpbOHLa0c7eo+nRbgRPNm0oGQFuxxbP/tieHtyYDnjEy0uWLSAOp43WfKJZZuBvVPRkkpbukvKOJqAw"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAMg	1547925144407	{"key":"4x7X6CZAwdjuBLhO5/suia0D7coJA4t1Uv8ef3Qt4mo","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"DA/1QfsLYmfkf8hW78pAvN3j4yzXLL5AwnntxTp9J60tFmeizXjzSpglFNqJH9TGPjOWyo9GmVpySfZSyRaxAw"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAMQ	1547925144407	{"key":"0yuCxp1AyPvSm7eQsYwFVhxr82RGXKxCc9ZhSJY/riU","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"ynWbZcaY2JL87MDsZWfwKZDeGLaUufDtQLXLkvN6gwV087hH1Km6YOJ+yEu9GPmu7H3FaoV0jclcJBquu/KRAA"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAMA	1547925144407	{"key":"9PRfFNRcCVrc0wyOnacNW69tb4VJIW8VuapekXh+5FI","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"XMRunSDngc9eAkrAQLMwtkcKeyoXlZHi7ZbvEL0fbIpfGgptZj0I7dGoym1G36x6FboqF2FLwLYGdEtSe6ZLBA"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAALw	1547925144407	{"key":"WeUOqDpWM0mzLsbD1p1aSaqcF/JRKmXlKX/0N2bg9y8","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"+QCfVzDEKYkhZKO62blTzosB/3WtSGQL5U+dOIT8m/f3z4cD6bkb+isvepgz6q2PNA9NMMjDezJ1EXLtcqGGBA"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAALg	1547925144407	{"key":"F1E5SkP2E/Jo1Yppd71h9a4t4rUFid6rdgu/sDxX7EM","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"SteAAPSQ2S3V6fOUnvp2EXzBBNkQG6FJbBl8kyeeftufE9Ow9ITr9ikbU0Qi6Hta69Mrx+tANPNPCPf4r8tGAw"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAKA	1547925144335	{"key":"3L13K6Pd5BBjktYKDS9SzSK7gWj5sJiiXoH/SeeSlVU","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"TrZlfc2NtdvZX/aRsPBYNJnQSIRPGRL3Vvql0+55Eaon8Ige38U3KtwktGZPBkD8qK4RjKVZjHIExSVicLJzCQ"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAJw	1547925144335	{"key":"aJev4WXTlQxknD1I08cQeN4djhT8/iNZpuOnlPof4Xc","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"fefHxCu5n1Cl+lup0Px9oKB1KENHTFU263Lx8vgWsxWRpVtQ7X4Uzlw7akrmWDSrd7NQR75X9M9M8f4+k0VtDw"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAJg	1547925144335	{"key":"5MPDi9ix/w4qIGoHvyqhKyP3piY+fThOYpW3QX9fEn4","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"0j0KXkKognIbOjv3LhN/AjsKxJNLzciZRm9jHnrMt2seVCPb8dwykIr17/SQ3vOczcVFkoUCnaHEZDC9fj2MDg"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAJQ	1547925144335	{"key":"HMVBVOlAl0Rcxxc3qYxW/ahs/PUjEUw+gPV1ygE11jU","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"IL2/W36iPweq+zNtHwm41b1XMOaBj2yUZBdzj98tWREwgeYEg2FkLMYZs3d2xzguDNZHX3ht5rCwXtYz/kC5Dw"}}}
@user2:localhost	SZDGWSGKHC	signed_curve25519	AAAAJA	1547925144335	{"key":"eqZ4FDMvlFtefvLPrGHOhCaCfN5ex1OVHbpUqQKdNQM","signatures":{"@user2:localhost":{"ed25519:SZDGWSGKHC":"QcM5Fk5M2uTT9VSE0m3fjtdDF9S0Ha8CVgAkCuuq1rO8h4ggjt8woDEZ2TEjKTVJYj84019UlBS2GPd0P9x4Aw"}}}
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
$15479247501iUNIP:localhost	$15479247500OKKlI:localhost	!YvivtdTtsTAmNnsRUw:localhost
$15479247502PzwLU:localhost	$15479247500OKKlI:localhost	!YvivtdTtsTAmNnsRUw:localhost
$15479247502PzwLU:localhost	$15479247501iUNIP:localhost	!YvivtdTtsTAmNnsRUw:localhost
$15479247503HdRXi:localhost	$15479247500OKKlI:localhost	!YvivtdTtsTAmNnsRUw:localhost
$15479247503HdRXi:localhost	$15479247501iUNIP:localhost	!YvivtdTtsTAmNnsRUw:localhost
$15479247503HdRXi:localhost	$15479247502PzwLU:localhost	!YvivtdTtsTAmNnsRUw:localhost
$15479247504DWCIT:localhost	$15479247502PzwLU:localhost	!YvivtdTtsTAmNnsRUw:localhost
$15479247504DWCIT:localhost	$15479247500OKKlI:localhost	!YvivtdTtsTAmNnsRUw:localhost
$15479247504DWCIT:localhost	$15479247501iUNIP:localhost	!YvivtdTtsTAmNnsRUw:localhost
$15479247505lMKFc:localhost	$15479247502PzwLU:localhost	!YvivtdTtsTAmNnsRUw:localhost
$15479247505lMKFc:localhost	$15479247500OKKlI:localhost	!YvivtdTtsTAmNnsRUw:localhost
$15479247505lMKFc:localhost	$15479247501iUNIP:localhost	!YvivtdTtsTAmNnsRUw:localhost
$15479248178PDnSR:localhost	$15479248177pgEuD:localhost	!DwnsPKUkFrUbPENRUr:localhost
$15479248189maFVd:localhost	$15479248177pgEuD:localhost	!DwnsPKUkFrUbPENRUr:localhost
$15479248189maFVd:localhost	$15479248178PDnSR:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792481810eHTrj:localhost	$15479248177pgEuD:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792481810eHTrj:localhost	$15479248178PDnSR:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792481810eHTrj:localhost	$15479248189maFVd:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792481811UJmBV:localhost	$15479248189maFVd:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792481811UJmBV:localhost	$15479248177pgEuD:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792481811UJmBV:localhost	$15479248178PDnSR:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792481812FTgOr:localhost	$15479248189maFVd:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792481812FTgOr:localhost	$15479248177pgEuD:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792481812FTgOr:localhost	$15479248178PDnSR:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792481813sscwS:localhost	$15479248189maFVd:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792481813sscwS:localhost	$15479248177pgEuD:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792481813sscwS:localhost	$15479248178PDnSR:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792483514Gzglm:localhost	$15479248189maFVd:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792483514Gzglm:localhost	$15479248177pgEuD:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792483514Gzglm:localhost	$15479248178PDnSR:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792484415abNlG:localhost	$15479247502PzwLU:localhost	!YvivtdTtsTAmNnsRUw:localhost
$154792484415abNlG:localhost	$15479247500OKKlI:localhost	!YvivtdTtsTAmNnsRUw:localhost
$154792484415abNlG:localhost	$15479247501iUNIP:localhost	!YvivtdTtsTAmNnsRUw:localhost
$154792488217OnxTZ:localhost	$154792488216AbRES:localhost	!lxLGrxbEpguUZULoSC:localhost
$154792488218BUaoQ:localhost	$154792488216AbRES:localhost	!lxLGrxbEpguUZULoSC:localhost
$154792488218BUaoQ:localhost	$154792488217OnxTZ:localhost	!lxLGrxbEpguUZULoSC:localhost
$154792488219bruaB:localhost	$154792488216AbRES:localhost	!lxLGrxbEpguUZULoSC:localhost
$154792488219bruaB:localhost	$154792488217OnxTZ:localhost	!lxLGrxbEpguUZULoSC:localhost
$154792488219bruaB:localhost	$154792488218BUaoQ:localhost	!lxLGrxbEpguUZULoSC:localhost
$154792488220dvrBE:localhost	$154792488218BUaoQ:localhost	!lxLGrxbEpguUZULoSC:localhost
$154792488220dvrBE:localhost	$154792488216AbRES:localhost	!lxLGrxbEpguUZULoSC:localhost
$154792488220dvrBE:localhost	$154792488217OnxTZ:localhost	!lxLGrxbEpguUZULoSC:localhost
$154792488221gUPQT:localhost	$154792488218BUaoQ:localhost	!lxLGrxbEpguUZULoSC:localhost
$154792488221gUPQT:localhost	$154792488216AbRES:localhost	!lxLGrxbEpguUZULoSC:localhost
$154792488221gUPQT:localhost	$154792488217OnxTZ:localhost	!lxLGrxbEpguUZULoSC:localhost
$154792488222ZBqEn:localhost	$154792488218BUaoQ:localhost	!lxLGrxbEpguUZULoSC:localhost
$154792488222ZBqEn:localhost	$154792488216AbRES:localhost	!lxLGrxbEpguUZULoSC:localhost
$154792488222ZBqEn:localhost	$154792488217OnxTZ:localhost	!lxLGrxbEpguUZULoSC:localhost
$154792490923tISso:localhost	$154792488218BUaoQ:localhost	!lxLGrxbEpguUZULoSC:localhost
$154792490923tISso:localhost	$154792488216AbRES:localhost	!lxLGrxbEpguUZULoSC:localhost
$154792490923tISso:localhost	$154792488217OnxTZ:localhost	!lxLGrxbEpguUZULoSC:localhost
$154792492925JZWbo:localhost	$154792492924bdmxc:localhost	!tHjklMrpyrzHaqkxRt:localhost
$154792493026cBNiO:localhost	$154792492924bdmxc:localhost	!tHjklMrpyrzHaqkxRt:localhost
$154792493026cBNiO:localhost	$154792492925JZWbo:localhost	!tHjklMrpyrzHaqkxRt:localhost
$154792493027Gtrdl:localhost	$154792492924bdmxc:localhost	!tHjklMrpyrzHaqkxRt:localhost
$154792493027Gtrdl:localhost	$154792492925JZWbo:localhost	!tHjklMrpyrzHaqkxRt:localhost
$154792493027Gtrdl:localhost	$154792493026cBNiO:localhost	!tHjklMrpyrzHaqkxRt:localhost
$154792493028JotEC:localhost	$154792493026cBNiO:localhost	!tHjklMrpyrzHaqkxRt:localhost
$154792493028JotEC:localhost	$154792492924bdmxc:localhost	!tHjklMrpyrzHaqkxRt:localhost
$154792493028JotEC:localhost	$154792492925JZWbo:localhost	!tHjklMrpyrzHaqkxRt:localhost
$154792493029TiWmR:localhost	$154792493026cBNiO:localhost	!tHjklMrpyrzHaqkxRt:localhost
$154792493029TiWmR:localhost	$154792492924bdmxc:localhost	!tHjklMrpyrzHaqkxRt:localhost
$154792493029TiWmR:localhost	$154792492925JZWbo:localhost	!tHjklMrpyrzHaqkxRt:localhost
$154792507633FUQML:localhost	$15479248189maFVd:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792507633FUQML:localhost	$15479248177pgEuD:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792507633FUQML:localhost	$15479248178PDnSR:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792507633FUQML:localhost	$154792481810eHTrj:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792514935gxWdL:localhost	$15479248189maFVd:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792514935gxWdL:localhost	$15479248177pgEuD:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792514935gxWdL:localhost	$154792481810eHTrj:localhost	!DwnsPKUkFrUbPENRUr:localhost
$154792514935gxWdL:localhost	$154792507633FUQML:localhost	!DwnsPKUkFrUbPENRUr:localhost
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
$15479247501iUNIP:localhost	$15479247500OKKlI:localhost	!YvivtdTtsTAmNnsRUw:localhost	f
$15479247502PzwLU:localhost	$15479247501iUNIP:localhost	!YvivtdTtsTAmNnsRUw:localhost	f
$15479247503HdRXi:localhost	$15479247502PzwLU:localhost	!YvivtdTtsTAmNnsRUw:localhost	f
$15479247504DWCIT:localhost	$15479247503HdRXi:localhost	!YvivtdTtsTAmNnsRUw:localhost	f
$15479247505lMKFc:localhost	$15479247504DWCIT:localhost	!YvivtdTtsTAmNnsRUw:localhost	f
$15479248178PDnSR:localhost	$15479248177pgEuD:localhost	!DwnsPKUkFrUbPENRUr:localhost	f
$15479248189maFVd:localhost	$15479248178PDnSR:localhost	!DwnsPKUkFrUbPENRUr:localhost	f
$154792481810eHTrj:localhost	$15479248189maFVd:localhost	!DwnsPKUkFrUbPENRUr:localhost	f
$154792481811UJmBV:localhost	$154792481810eHTrj:localhost	!DwnsPKUkFrUbPENRUr:localhost	f
$154792481812FTgOr:localhost	$154792481811UJmBV:localhost	!DwnsPKUkFrUbPENRUr:localhost	f
$154792481813sscwS:localhost	$154792481812FTgOr:localhost	!DwnsPKUkFrUbPENRUr:localhost	f
$154792483514Gzglm:localhost	$154792481813sscwS:localhost	!DwnsPKUkFrUbPENRUr:localhost	f
$154792484415abNlG:localhost	$15479247505lMKFc:localhost	!YvivtdTtsTAmNnsRUw:localhost	f
$154792488217OnxTZ:localhost	$154792488216AbRES:localhost	!lxLGrxbEpguUZULoSC:localhost	f
$154792488218BUaoQ:localhost	$154792488217OnxTZ:localhost	!lxLGrxbEpguUZULoSC:localhost	f
$154792488219bruaB:localhost	$154792488218BUaoQ:localhost	!lxLGrxbEpguUZULoSC:localhost	f
$154792488220dvrBE:localhost	$154792488219bruaB:localhost	!lxLGrxbEpguUZULoSC:localhost	f
$154792488221gUPQT:localhost	$154792488220dvrBE:localhost	!lxLGrxbEpguUZULoSC:localhost	f
$154792488222ZBqEn:localhost	$154792488221gUPQT:localhost	!lxLGrxbEpguUZULoSC:localhost	f
$154792490923tISso:localhost	$154792488222ZBqEn:localhost	!lxLGrxbEpguUZULoSC:localhost	f
$154792492925JZWbo:localhost	$154792492924bdmxc:localhost	!tHjklMrpyrzHaqkxRt:localhost	f
$154792493026cBNiO:localhost	$154792492925JZWbo:localhost	!tHjklMrpyrzHaqkxRt:localhost	f
$154792493027Gtrdl:localhost	$154792493026cBNiO:localhost	!tHjklMrpyrzHaqkxRt:localhost	f
$154792493028JotEC:localhost	$154792493027Gtrdl:localhost	!tHjklMrpyrzHaqkxRt:localhost	f
$154792493029TiWmR:localhost	$154792493028JotEC:localhost	!tHjklMrpyrzHaqkxRt:localhost	f
$154792501831ATytk:localhost	$154792483514Gzglm:localhost	!DwnsPKUkFrUbPENRUr:localhost	f
$154792503032kwMJH:localhost	$154792501831ATytk:localhost	!DwnsPKUkFrUbPENRUr:localhost	f
$154792507633FUQML:localhost	$154792503032kwMJH:localhost	!DwnsPKUkFrUbPENRUr:localhost	f
$154792514935gxWdL:localhost	$154792507633FUQML:localhost	!DwnsPKUkFrUbPENRUr:localhost	f
$154792515636GRwRe:localhost	$154792514935gxWdL:localhost	!DwnsPKUkFrUbPENRUr:localhost	f
$154792516437BJyyo:localhost	$154792515636GRwRe:localhost	!DwnsPKUkFrUbPENRUr:localhost	f
$154792518138HlGib:localhost	$154792516437BJyyo:localhost	!DwnsPKUkFrUbPENRUr:localhost	f
\.


--
-- Data for Name: event_forward_extremities; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_forward_extremities (event_id, room_id) FROM stdin;
$154792484415abNlG:localhost	!YvivtdTtsTAmNnsRUw:localhost
$154792490923tISso:localhost	!lxLGrxbEpguUZULoSC:localhost
$154792493029TiWmR:localhost	!tHjklMrpyrzHaqkxRt:localhost
$154792518138HlGib:localhost	!DwnsPKUkFrUbPENRUr:localhost
\.


--
-- Data for Name: event_json; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_json (event_id, room_id, internal_metadata, json) FROM stdin;
$15479247500OKKlI:localhost	!YvivtdTtsTAmNnsRUw:localhost	{"token_id": 3, "stream_ordering": 2}	{"type": "m.room.create", "content": {"room_version": "1", "creator": "@user1:localhost"}, "room_id": "!YvivtdTtsTAmNnsRUw:localhost", "sender": "@user1:localhost", "state_key": "", "event_id": "$15479247500OKKlI:localhost", "origin": "localhost", "origin_server_ts": 1547924750066, "prev_events": [], "depth": 1, "prev_state": [], "auth_events": [], "hashes": {"sha256": "HVVG1vZ5SQKRT2zt5iHm8u1zJ8HFswsLkrGu0SOEWy4"}, "signatures": {"localhost": {"ed25519:a_cgoU": "YgQmXdrr1mxHxIHbDX+chg3eQ5gOEYY9gIOWU9Q9QdvJ9bWVeib0I+H8KejzmJqXrrjkMklMiLmUciw6psRLCg"}}, "unsigned": {"age_ts": 1547924750066}}
$15479247501iUNIP:localhost	!YvivtdTtsTAmNnsRUw:localhost	{"token_id": 3, "stream_ordering": 3}	{"type": "m.room.member", "content": {"membership": "join", "displayname": "user1", "avatar_url": null}, "room_id": "!YvivtdTtsTAmNnsRUw:localhost", "sender": "@user1:localhost", "state_key": "@user1:localhost", "membership": "join", "event_id": "$15479247501iUNIP:localhost", "origin": "localhost", "origin_server_ts": 1547924750113, "prev_events": [["$15479247500OKKlI:localhost", {"sha256": "4euu901/oZf9Sg/VtZMyQicx1FdWo0vBCR/Z7oydjcM"}]], "depth": 2, "prev_state": [], "auth_events": [["$15479247500OKKlI:localhost", {"sha256": "4euu901/oZf9Sg/VtZMyQicx1FdWo0vBCR/Z7oydjcM"}]], "hashes": {"sha256": "7XTttD/zylR7Gv5LMbxqQbFu+j9xLOF/iuaFnK8L66g"}, "signatures": {"localhost": {"ed25519:a_cgoU": "DL95h2Di9DE4ciXPz77FnINm9RWPHKfMclkLBl8fqmof9kFO6cLA/d8ZLChAQDQ3p3stWJAkYlKIuHDBf5CQCw"}}, "unsigned": {"age_ts": 1547924750113}}
$15479247502PzwLU:localhost	!YvivtdTtsTAmNnsRUw:localhost	{"token_id": 3, "stream_ordering": 4}	{"type": "m.room.power_levels", "content": {"users": {"@user1:localhost": 100, "@riot-bot:matrix.org": 100}, "users_default": 0, "events": {"m.room.name": 50, "m.room.power_levels": 100, "m.room.history_visibility": 100, "m.room.canonical_alias": 50, "m.room.avatar": 50}, "events_default": 0, "state_default": 50, "ban": 50, "kick": 50, "redact": 50, "invite": 0}, "room_id": "!YvivtdTtsTAmNnsRUw:localhost", "sender": "@user1:localhost", "state_key": "", "event_id": "$15479247502PzwLU:localhost", "origin": "localhost", "origin_server_ts": 1547924750199, "prev_events": [["$15479247501iUNIP:localhost", {"sha256": "e32HqudAUT+pwPhfgp/OaU7/p4bVxGJ3iO+eXi7ACEo"}]], "depth": 3, "prev_state": [], "auth_events": [["$15479247500OKKlI:localhost", {"sha256": "4euu901/oZf9Sg/VtZMyQicx1FdWo0vBCR/Z7oydjcM"}], ["$15479247501iUNIP:localhost", {"sha256": "e32HqudAUT+pwPhfgp/OaU7/p4bVxGJ3iO+eXi7ACEo"}]], "hashes": {"sha256": "r5Eo+nSFOb/w8+o34pzNr7S1rjD5zG94nEyMCYLSW6w"}, "signatures": {"localhost": {"ed25519:a_cgoU": "I8TYPrqEFVtHSaRinrkwBZwjo9HPlqI0wA+wcUKvf4Vbe+HEHeOjpTwi7UdojzdO/ef/o3IScwOb/Wt3azT4Bw"}}, "unsigned": {"age_ts": 1547924750199}}
$15479247503HdRXi:localhost	!YvivtdTtsTAmNnsRUw:localhost	{"token_id": 3, "stream_ordering": 5}	{"type": "m.room.join_rules", "content": {"join_rule": "invite"}, "room_id": "!YvivtdTtsTAmNnsRUw:localhost", "sender": "@user1:localhost", "state_key": "", "event_id": "$15479247503HdRXi:localhost", "origin": "localhost", "origin_server_ts": 1547924750258, "prev_events": [["$15479247502PzwLU:localhost", {"sha256": "DJlzrstrvn/ao0HAb6iDHfEjn7o2KcPiXhsrdMkG3Jw"}]], "depth": 4, "prev_state": [], "auth_events": [["$15479247500OKKlI:localhost", {"sha256": "4euu901/oZf9Sg/VtZMyQicx1FdWo0vBCR/Z7oydjcM"}], ["$15479247501iUNIP:localhost", {"sha256": "e32HqudAUT+pwPhfgp/OaU7/p4bVxGJ3iO+eXi7ACEo"}], ["$15479247502PzwLU:localhost", {"sha256": "DJlzrstrvn/ao0HAb6iDHfEjn7o2KcPiXhsrdMkG3Jw"}]], "hashes": {"sha256": "u5oc0CgVUWNVVREUKi/Qn4a/yPh3/e2FBokZc01Iw/M"}, "signatures": {"localhost": {"ed25519:a_cgoU": "SNsEo9nO4gY2udhVKF+cjVujNo7h0gC3rmoUmN+7352lNluXhwbxMF7cGip0pF1S52RzT1z7JIwuzGvcvHfkCw"}}, "unsigned": {"age_ts": 1547924750258}}
$15479247504DWCIT:localhost	!YvivtdTtsTAmNnsRUw:localhost	{"token_id": 3, "stream_ordering": 6}	{"type": "m.room.history_visibility", "content": {"history_visibility": "shared"}, "room_id": "!YvivtdTtsTAmNnsRUw:localhost", "sender": "@user1:localhost", "state_key": "", "event_id": "$15479247504DWCIT:localhost", "origin": "localhost", "origin_server_ts": 1547924750300, "prev_events": [["$15479247503HdRXi:localhost", {"sha256": "xAVT7fD/GTEstvuj2UzZmCNX78MayQ7h7y6O/xiGSjI"}]], "depth": 5, "prev_state": [], "auth_events": [["$15479247502PzwLU:localhost", {"sha256": "DJlzrstrvn/ao0HAb6iDHfEjn7o2KcPiXhsrdMkG3Jw"}], ["$15479247500OKKlI:localhost", {"sha256": "4euu901/oZf9Sg/VtZMyQicx1FdWo0vBCR/Z7oydjcM"}], ["$15479247501iUNIP:localhost", {"sha256": "e32HqudAUT+pwPhfgp/OaU7/p4bVxGJ3iO+eXi7ACEo"}]], "hashes": {"sha256": "8lHXETt4sjR0vbP8hYDx+Vm3LhNcIP94kk5rpDA1AfM"}, "signatures": {"localhost": {"ed25519:a_cgoU": "xUAlDfaLVQjThTgQT8IPfttM58jbVcQOQI6jxzcGGZ+4tl9uzA8/De3484Im74jIhrDKljYMBb+LwAUWu+TvCg"}}, "unsigned": {"age_ts": 1547924750300}}
$15479247505lMKFc:localhost	!YvivtdTtsTAmNnsRUw:localhost	{"token_id": 3, "stream_ordering": 7}	{"type": "m.room.guest_access", "content": {"guest_access": "can_join"}, "room_id": "!YvivtdTtsTAmNnsRUw:localhost", "sender": "@user1:localhost", "state_key": "", "event_id": "$15479247505lMKFc:localhost", "origin": "localhost", "origin_server_ts": 1547924750348, "prev_events": [["$15479247504DWCIT:localhost", {"sha256": "SIneIJ32g9hCxJVeEpjo70dddnl/o615s8FTzc3roO8"}]], "depth": 6, "prev_state": [], "auth_events": [["$15479247502PzwLU:localhost", {"sha256": "DJlzrstrvn/ao0HAb6iDHfEjn7o2KcPiXhsrdMkG3Jw"}], ["$15479247500OKKlI:localhost", {"sha256": "4euu901/oZf9Sg/VtZMyQicx1FdWo0vBCR/Z7oydjcM"}], ["$15479247501iUNIP:localhost", {"sha256": "e32HqudAUT+pwPhfgp/OaU7/p4bVxGJ3iO+eXi7ACEo"}]], "hashes": {"sha256": "PFlbSH1zOSkZQGNOQnuXYAFit0ycXR9T/iuiejSTG58"}, "signatures": {"localhost": {"ed25519:a_cgoU": "fWFBYzCbosLOpuKFQe/tTAth6CohLnDMAhxjxjeD4x+pjdzhjH3v9n7yKC/4pG2iGTFTJ38DShRbSyGGATfxBA"}}, "unsigned": {"age_ts": 1547924750348}}
$15479248177pgEuD:localhost	!DwnsPKUkFrUbPENRUr:localhost	{"token_id": 3, "stream_ordering": 8}	{"type": "m.room.create", "content": {"room_version": "1", "creator": "@user1:localhost"}, "room_id": "!DwnsPKUkFrUbPENRUr:localhost", "sender": "@user1:localhost", "state_key": "", "event_id": "$15479248177pgEuD:localhost", "origin": "localhost", "origin_server_ts": 1547924817927, "prev_events": [], "depth": 1, "prev_state": [], "auth_events": [], "hashes": {"sha256": "OKUYq8vI0oTzTnB+x+QrxlNVlBu/vfYm5sdmmBuL2og"}, "signatures": {"localhost": {"ed25519:a_cgoU": "sTFjLqxghSL/GyAA4s0JRr/QWeN03EjTznz3CKw9JEkBQ4QgF+nUI3+TgFDfzT+8f+yNI9t4DtLQkqe8HDPJAg"}}, "unsigned": {"age_ts": 1547924817927}}
$15479248178PDnSR:localhost	!DwnsPKUkFrUbPENRUr:localhost	{"token_id": 3, "stream_ordering": 9}	{"type": "m.room.member", "content": {"membership": "join", "displayname": "user1", "avatar_url": null}, "room_id": "!DwnsPKUkFrUbPENRUr:localhost", "sender": "@user1:localhost", "state_key": "@user1:localhost", "membership": "join", "event_id": "$15479248178PDnSR:localhost", "origin": "localhost", "origin_server_ts": 1547924817969, "prev_events": [["$15479248177pgEuD:localhost", {"sha256": "YFkVZ9hBxC1u5aLChxqK2yk8e+5AK9V4tJfZMvNRcGc"}]], "depth": 2, "prev_state": [], "auth_events": [["$15479248177pgEuD:localhost", {"sha256": "YFkVZ9hBxC1u5aLChxqK2yk8e+5AK9V4tJfZMvNRcGc"}]], "hashes": {"sha256": "7odw8kUwNnzOHrilsnTEME/3SQGYqBG1JNMspoqaNIY"}, "signatures": {"localhost": {"ed25519:a_cgoU": "AH+xcLGJeolfCMfiueIYLIv/5S5Q9vdlRk6r2Qd/ZXOG/BggXbPGCdivRigGTpHdbt4Aijt9aUhDry1WNsx+Ag"}}, "unsigned": {"age_ts": 1547924817969}}
$15479248189maFVd:localhost	!DwnsPKUkFrUbPENRUr:localhost	{"token_id": 3, "stream_ordering": 10}	{"type": "m.room.power_levels", "content": {"users": {"@user1:localhost": 100}, "users_default": 0, "events": {"m.room.name": 50, "m.room.power_levels": 100, "m.room.history_visibility": 100, "m.room.canonical_alias": 50, "m.room.avatar": 50}, "events_default": 0, "state_default": 50, "ban": 50, "kick": 50, "redact": 50, "invite": 0}, "room_id": "!DwnsPKUkFrUbPENRUr:localhost", "sender": "@user1:localhost", "state_key": "", "event_id": "$15479248189maFVd:localhost", "origin": "localhost", "origin_server_ts": 1547924818016, "prev_events": [["$15479248178PDnSR:localhost", {"sha256": "6edDzdaCVWyznP4vuu8fbj/QwxG8QVdP/cGJXooU0B4"}]], "depth": 3, "prev_state": [], "auth_events": [["$15479248177pgEuD:localhost", {"sha256": "YFkVZ9hBxC1u5aLChxqK2yk8e+5AK9V4tJfZMvNRcGc"}], ["$15479248178PDnSR:localhost", {"sha256": "6edDzdaCVWyznP4vuu8fbj/QwxG8QVdP/cGJXooU0B4"}]], "hashes": {"sha256": "PGsjWohzbBMsrGZVfzXXTrAKlGWE13fRRVO1mwokJmQ"}, "signatures": {"localhost": {"ed25519:a_cgoU": "0eV1fuYoorfyezyE0MCaJXTok2NtqO2eTgjvGwDM0I3pNXpZ0lVNLFp3UF2VFif2U6eyJvL8pfLUXiKtTKVZCA"}}, "unsigned": {"age_ts": 1547924818016}}
$154792488219bruaB:localhost	!lxLGrxbEpguUZULoSC:localhost	{"token_id": 3, "stream_ordering": 20}	{"type": "m.room.join_rules", "content": {"join_rule": "invite"}, "room_id": "!lxLGrxbEpguUZULoSC:localhost", "sender": "@user1:localhost", "state_key": "", "event_id": "$154792488219bruaB:localhost", "origin": "localhost", "origin_server_ts": 1547924882327, "prev_events": [["$154792488218BUaoQ:localhost", {"sha256": "YIlp2Qh9VG9OXL6naNJJrN5NutFrzhc41LtB+gDMZkQ"}]], "depth": 4, "prev_state": [], "auth_events": [["$154792488216AbRES:localhost", {"sha256": "KjjVUyLVqD5xKYG/qqPOY4tOMWXNy1V8mFoioC6xk2k"}], ["$154792488217OnxTZ:localhost", {"sha256": "EuxEpAoxlHlAx/cmu7zulA8oDra4/VGu1g7dIYSosOY"}], ["$154792488218BUaoQ:localhost", {"sha256": "YIlp2Qh9VG9OXL6naNJJrN5NutFrzhc41LtB+gDMZkQ"}]], "hashes": {"sha256": "QYWS4sKXciEcrAf4FHn2DlO3WmL2GWySwpkMAl0fWGw"}, "signatures": {"localhost": {"ed25519:a_cgoU": "BfipMEMroVmVYewYLsVLooGilb3+Hbcu5MGrB2uWEk3/aqJMBWuKSeSc/uIIbY9pzZRRdkA+mcuTPJMJieVCAQ"}}, "unsigned": {"age_ts": 1547924882327}}
$154792492924bdmxc:localhost	!tHjklMrpyrzHaqkxRt:localhost	{"token_id": 5, "stream_ordering": 25}	{"type": "m.room.create", "content": {"room_version": "1", "creator": "@user2:localhost"}, "room_id": "!tHjklMrpyrzHaqkxRt:localhost", "sender": "@user2:localhost", "state_key": "", "event_id": "$154792492924bdmxc:localhost", "origin": "localhost", "origin_server_ts": 1547924929933, "prev_events": [], "depth": 1, "prev_state": [], "auth_events": [], "hashes": {"sha256": "a39W0b4PWzBAto+XNG4Rcg108gA4JtfthiCg9FYHgI8"}, "signatures": {"localhost": {"ed25519:a_cgoU": "l/Vs7ctq1oI5Kve897++Z6MHBsl0q0u/BpdHqZS7a8Glck4Eps4bfVtACHAUsr+9Af6uhS9pVpJgbWXXsabABQ"}}, "unsigned": {"age_ts": 1547924929933}}
$154792493026cBNiO:localhost	!tHjklMrpyrzHaqkxRt:localhost	{"token_id": 5, "stream_ordering": 27}	{"type": "m.room.power_levels", "content": {"users": {"@user2:localhost": 100, "@riot-bot:matrix.org": 100}, "users_default": 0, "events": {"m.room.name": 50, "m.room.power_levels": 100, "m.room.history_visibility": 100, "m.room.canonical_alias": 50, "m.room.avatar": 50}, "events_default": 0, "state_default": 50, "ban": 50, "kick": 50, "redact": 50, "invite": 0}, "room_id": "!tHjklMrpyrzHaqkxRt:localhost", "sender": "@user2:localhost", "state_key": "", "event_id": "$154792493026cBNiO:localhost", "origin": "localhost", "origin_server_ts": 1547924930043, "prev_events": [["$154792492925JZWbo:localhost", {"sha256": "Q6u5jEzKLYkcJV5SP/FMXFjWgVB6/1jg72Ln+Wqw8kU"}]], "depth": 3, "prev_state": [], "auth_events": [["$154792492924bdmxc:localhost", {"sha256": "S652enxTPCdC5vSgWcuTHMLbhZ5BzOM4xHIDefpqoF0"}], ["$154792492925JZWbo:localhost", {"sha256": "Q6u5jEzKLYkcJV5SP/FMXFjWgVB6/1jg72Ln+Wqw8kU"}]], "hashes": {"sha256": "Hy2wY2akpcuHJY/nD8g0DWG21Q5V5H6DljGS6a9OABg"}, "signatures": {"localhost": {"ed25519:a_cgoU": "AiLToxvbq/kjSP4hlqx39ociFhbwZtqTDGajsTplwiDiGRxW2eBCZEbXS0Usc7Ol550XL3x1lf8zoI9lhtIsBQ"}}, "unsigned": {"age_ts": 1547924930043}}
$154792493027Gtrdl:localhost	!tHjklMrpyrzHaqkxRt:localhost	{"token_id": 5, "stream_ordering": 28}	{"type": "m.room.join_rules", "content": {"join_rule": "invite"}, "room_id": "!tHjklMrpyrzHaqkxRt:localhost", "sender": "@user2:localhost", "state_key": "", "event_id": "$154792493027Gtrdl:localhost", "origin": "localhost", "origin_server_ts": 1547924930096, "prev_events": [["$154792493026cBNiO:localhost", {"sha256": "JHbPERXP/6s0eAmnnvRhP64z7oNbo2DZ0ZtMdvl51PI"}]], "depth": 4, "prev_state": [], "auth_events": [["$154792492924bdmxc:localhost", {"sha256": "S652enxTPCdC5vSgWcuTHMLbhZ5BzOM4xHIDefpqoF0"}], ["$154792492925JZWbo:localhost", {"sha256": "Q6u5jEzKLYkcJV5SP/FMXFjWgVB6/1jg72Ln+Wqw8kU"}], ["$154792493026cBNiO:localhost", {"sha256": "JHbPERXP/6s0eAmnnvRhP64z7oNbo2DZ0ZtMdvl51PI"}]], "hashes": {"sha256": "fscLGfbPdsI1sgPJr4erMJnSxEkgNv4KR498uu9wcHw"}, "signatures": {"localhost": {"ed25519:a_cgoU": "Vg9uVd2XtykGn+E2RCtNNvGH24By8pDB+QpHD6CrDTw2ZN1GHRCgVHGzYt+/Dql+w0CVbX16T2dfal28ccUtDg"}}, "unsigned": {"age_ts": 1547924930096}}
$154792493028JotEC:localhost	!tHjklMrpyrzHaqkxRt:localhost	{"token_id": 5, "stream_ordering": 29}	{"type": "m.room.history_visibility", "content": {"history_visibility": "shared"}, "room_id": "!tHjklMrpyrzHaqkxRt:localhost", "sender": "@user2:localhost", "state_key": "", "event_id": "$154792493028JotEC:localhost", "origin": "localhost", "origin_server_ts": 1547924930144, "prev_events": [["$154792493027Gtrdl:localhost", {"sha256": "uR+EojTKl9yDPgOvzJyqv7FNq+xHJrNelOCDo4SOQ9E"}]], "depth": 5, "prev_state": [], "auth_events": [["$154792493026cBNiO:localhost", {"sha256": "JHbPERXP/6s0eAmnnvRhP64z7oNbo2DZ0ZtMdvl51PI"}], ["$154792492924bdmxc:localhost", {"sha256": "S652enxTPCdC5vSgWcuTHMLbhZ5BzOM4xHIDefpqoF0"}], ["$154792492925JZWbo:localhost", {"sha256": "Q6u5jEzKLYkcJV5SP/FMXFjWgVB6/1jg72Ln+Wqw8kU"}]], "hashes": {"sha256": "/PJHG5PrB3TD1f8bpQI1Fqd6/x7rIcUrRXeVl0oUu9M"}, "signatures": {"localhost": {"ed25519:a_cgoU": "qDaH2o67ZUBY0umMUgoUC2aRNxD4yDjMAXCakasUrrbl55Ibhbl+DEtSkKddXYEam3MxsfKVNkhA7QtB4ZRaDg"}}, "unsigned": {"age_ts": 1547924930144}}
$154792481810eHTrj:localhost	!DwnsPKUkFrUbPENRUr:localhost	{"token_id": 3, "stream_ordering": 11}	{"type": "m.room.join_rules", "content": {"join_rule": "invite"}, "room_id": "!DwnsPKUkFrUbPENRUr:localhost", "sender": "@user1:localhost", "state_key": "", "event_id": "$154792481810eHTrj:localhost", "origin": "localhost", "origin_server_ts": 1547924818066, "prev_events": [["$15479248189maFVd:localhost", {"sha256": "Ko3cvqdUrmcYnXpIVRjvGi25xPZHefXWdxIBZgy7ep4"}]], "depth": 4, "prev_state": [], "auth_events": [["$15479248177pgEuD:localhost", {"sha256": "YFkVZ9hBxC1u5aLChxqK2yk8e+5AK9V4tJfZMvNRcGc"}], ["$15479248178PDnSR:localhost", {"sha256": "6edDzdaCVWyznP4vuu8fbj/QwxG8QVdP/cGJXooU0B4"}], ["$15479248189maFVd:localhost", {"sha256": "Ko3cvqdUrmcYnXpIVRjvGi25xPZHefXWdxIBZgy7ep4"}]], "hashes": {"sha256": "N7W3/371mGLC85067vW9rFxhpdnkOxJ+IR+LZ93uIt0"}, "signatures": {"localhost": {"ed25519:a_cgoU": "CliIJvm15jF1TMBAE4llNqSUqqS6M5axAFCXWYYDmzjnhl4ryyz8QKLhOa3Y1D8nS0UfY3iwBF/9bWAxN0/IAg"}}, "unsigned": {"age_ts": 1547924818066}}
$154792481813sscwS:localhost	!DwnsPKUkFrUbPENRUr:localhost	{"token_id": 3, "stream_ordering": 14}	{"type": "m.room.name", "room_id": "!DwnsPKUkFrUbPENRUr:localhost", "sender": "@user1:localhost", "state_key": "", "content": {"name": "public"}, "event_id": "$154792481813sscwS:localhost", "origin": "localhost", "origin_server_ts": 1547924818223, "prev_events": [["$154792481812FTgOr:localhost", {"sha256": "L/6St6dLoezoev2SOKgkqxiuv/zZZsWZBLl3koMhBjU"}]], "depth": 7, "prev_state": [], "auth_events": [["$15479248189maFVd:localhost", {"sha256": "Ko3cvqdUrmcYnXpIVRjvGi25xPZHefXWdxIBZgy7ep4"}], ["$15479248177pgEuD:localhost", {"sha256": "YFkVZ9hBxC1u5aLChxqK2yk8e+5AK9V4tJfZMvNRcGc"}], ["$15479248178PDnSR:localhost", {"sha256": "6edDzdaCVWyznP4vuu8fbj/QwxG8QVdP/cGJXooU0B4"}]], "hashes": {"sha256": "0S51XL7exHNKZuzQ1DKUDLlva4RfgCbUEGYRKYuRTEY"}, "signatures": {"localhost": {"ed25519:a_cgoU": "wW7dvenl12GHg5HTjw4cNXERwnaEVE4EcTNHCmefY9hCxSlkIGCukauCDUZbWZbXqzQ4RqxsvgAzhepFLj25CA"}}, "unsigned": {"age_ts": 1547924818223}}
$154792481811UJmBV:localhost	!DwnsPKUkFrUbPENRUr:localhost	{"token_id": 3, "stream_ordering": 12}	{"type": "m.room.history_visibility", "content": {"history_visibility": "shared"}, "room_id": "!DwnsPKUkFrUbPENRUr:localhost", "sender": "@user1:localhost", "state_key": "", "event_id": "$154792481811UJmBV:localhost", "origin": "localhost", "origin_server_ts": 1547924818127, "prev_events": [["$154792481810eHTrj:localhost", {"sha256": "1rVLKHQvn3aCtwZwPXupMfeaG6wu+gDLQc77mqnENnE"}]], "depth": 5, "prev_state": [], "auth_events": [["$15479248189maFVd:localhost", {"sha256": "Ko3cvqdUrmcYnXpIVRjvGi25xPZHefXWdxIBZgy7ep4"}], ["$15479248177pgEuD:localhost", {"sha256": "YFkVZ9hBxC1u5aLChxqK2yk8e+5AK9V4tJfZMvNRcGc"}], ["$15479248178PDnSR:localhost", {"sha256": "6edDzdaCVWyznP4vuu8fbj/QwxG8QVdP/cGJXooU0B4"}]], "hashes": {"sha256": "k007EpYqrNGt9pqq+Xytf8jwCQmJ+4Z9KMwXD6uSvW4"}, "signatures": {"localhost": {"ed25519:a_cgoU": "GDwvLZPS7FALR0OpDBDpsA9Rm2F5iHyaK4iofO+2FAO0LKtpx7sdZmfMhWLgHgxpEMzgjVrJ4OjNjb8ps6+KBQ"}}, "unsigned": {"age_ts": 1547924818127}}
$154792488217OnxTZ:localhost	!lxLGrxbEpguUZULoSC:localhost	{"token_id": 3, "stream_ordering": 18}	{"type": "m.room.member", "content": {"membership": "join", "displayname": "user1", "avatar_url": null}, "room_id": "!lxLGrxbEpguUZULoSC:localhost", "sender": "@user1:localhost", "state_key": "@user1:localhost", "membership": "join", "event_id": "$154792488217OnxTZ:localhost", "origin": "localhost", "origin_server_ts": 1547924882214, "prev_events": [["$154792488216AbRES:localhost", {"sha256": "KjjVUyLVqD5xKYG/qqPOY4tOMWXNy1V8mFoioC6xk2k"}]], "depth": 2, "prev_state": [], "auth_events": [["$154792488216AbRES:localhost", {"sha256": "KjjVUyLVqD5xKYG/qqPOY4tOMWXNy1V8mFoioC6xk2k"}]], "hashes": {"sha256": "DiKXpFpCRl0DscLfV7Wy/zAePHRoa5mpD/Dg85gWfNg"}, "signatures": {"localhost": {"ed25519:a_cgoU": "fAjCwJa/zSiv9VenSbEV/p6QeYNKCshhPDe3QDOpsTB249yNd/M+osW85Ge0k8l6qqzmgP9kKLydq47lUkoZDg"}}, "unsigned": {"age_ts": 1547924882214}}
$154792503032kwMJH:localhost	!DwnsPKUkFrUbPENRUr:localhost	{"token_id": 6, "txn_id": "m1547925030212.1", "stream_ordering": 32}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "\\u0434\\u0435\\u043b\\u043e \\u0434\\u0436\\u0435\\u0439\\u043c\\u0430 xD"}, "room_id": "!DwnsPKUkFrUbPENRUr:localhost", "sender": "@user1:localhost", "event_id": "$154792503032kwMJH:localhost", "origin": "localhost", "origin_server_ts": 1547925030251, "prev_events": [["$154792501831ATytk:localhost", {"sha256": "pPRUiExAh/2y6mz+IGSZjYewch9QT6QXHD3rKkTMnNM"}]], "depth": 10, "auth_events": [["$15479248189maFVd:localhost", {"sha256": "Ko3cvqdUrmcYnXpIVRjvGi25xPZHefXWdxIBZgy7ep4"}], ["$15479248177pgEuD:localhost", {"sha256": "YFkVZ9hBxC1u5aLChxqK2yk8e+5AK9V4tJfZMvNRcGc"}], ["$15479248178PDnSR:localhost", {"sha256": "6edDzdaCVWyznP4vuu8fbj/QwxG8QVdP/cGJXooU0B4"}]], "hashes": {"sha256": "ATemqXl2L/ao6+GOqValPUcgOg/Ui0HTQw50bzhst5Y"}, "signatures": {"localhost": {"ed25519:a_cgoU": "EALYRWPYpCXmsi5ynvtd5BBdJjYVN6FBgXPJcl/RqBwRAhgGmRhMpaVTMGjmHw0J22P9NrdMTKcQHFtxuhZjAw"}}, "unsigned": {"age_ts": 1547925030251}}
$154792481812FTgOr:localhost	!DwnsPKUkFrUbPENRUr:localhost	{"token_id": 3, "stream_ordering": 13}	{"type": "m.room.guest_access", "content": {"guest_access": "can_join"}, "room_id": "!DwnsPKUkFrUbPENRUr:localhost", "sender": "@user1:localhost", "state_key": "", "event_id": "$154792481812FTgOr:localhost", "origin": "localhost", "origin_server_ts": 1547924818172, "prev_events": [["$154792481811UJmBV:localhost", {"sha256": "W/opMMC8fdXUpoJCzJZqotmYcgIpEPeyDhsAIXqBn4s"}]], "depth": 6, "prev_state": [], "auth_events": [["$15479248189maFVd:localhost", {"sha256": "Ko3cvqdUrmcYnXpIVRjvGi25xPZHefXWdxIBZgy7ep4"}], ["$15479248177pgEuD:localhost", {"sha256": "YFkVZ9hBxC1u5aLChxqK2yk8e+5AK9V4tJfZMvNRcGc"}], ["$15479248178PDnSR:localhost", {"sha256": "6edDzdaCVWyznP4vuu8fbj/QwxG8QVdP/cGJXooU0B4"}]], "hashes": {"sha256": "AokpRv7rRE7mRm8jebmBeGDURbFHqNm22rhfvNvWAjc"}, "signatures": {"localhost": {"ed25519:a_cgoU": "da8NHHpZOct4azT4C/ePuVzymozB7+hNtisPR4Z4j8mEgKTPWXkD4rimfB6RUMXhcy3kTyhc9FgHf/56HIiiCA"}}, "unsigned": {"age_ts": 1547924818172}}
$154792483514Gzglm:localhost	!DwnsPKUkFrUbPENRUr:localhost	{"token_id": 3, "stream_ordering": 15}	{"type": "m.room.related_groups", "content": {"groups": ["+counterstrike:localhost"]}, "room_id": "!DwnsPKUkFrUbPENRUr:localhost", "sender": "@user1:localhost", "state_key": "", "event_id": "$154792483514Gzglm:localhost", "origin": "localhost", "origin_server_ts": 1547924835639, "prev_events": [["$154792481813sscwS:localhost", {"sha256": "WXMhmF9wK1czMQhxzxkzQTytu/J4BzqBzcvmw8dgG0A"}]], "depth": 8, "prev_state": [], "auth_events": [["$15479248189maFVd:localhost", {"sha256": "Ko3cvqdUrmcYnXpIVRjvGi25xPZHefXWdxIBZgy7ep4"}], ["$15479248177pgEuD:localhost", {"sha256": "YFkVZ9hBxC1u5aLChxqK2yk8e+5AK9V4tJfZMvNRcGc"}], ["$15479248178PDnSR:localhost", {"sha256": "6edDzdaCVWyznP4vuu8fbj/QwxG8QVdP/cGJXooU0B4"}]], "hashes": {"sha256": "Rj1BdqwhnHiRe8XQpx3MYBD+aDZ538r6Q7pVrmtOt4s"}, "signatures": {"localhost": {"ed25519:a_cgoU": "MdfQifKI00f5nxSdt7nqoETdRHml+GIAMLsROXMA8FtF5DrrfCEjzes13igG58NgoPPyPZiLv8YxIZ82w1ZmDQ"}}, "unsigned": {"age_ts": 1547924835639}}
$154792484415abNlG:localhost	!YvivtdTtsTAmNnsRUw:localhost	{"token_id": 3, "stream_ordering": 16}	{"type": "m.room.member", "content": {"membership": "leave"}, "room_id": "!YvivtdTtsTAmNnsRUw:localhost", "sender": "@user1:localhost", "state_key": "@user1:localhost", "membership": "leave", "event_id": "$154792484415abNlG:localhost", "origin": "localhost", "origin_server_ts": 1547924844130, "prev_events": [["$15479247505lMKFc:localhost", {"sha256": "Mec8Kg5Kt5pghcYB6Pvj9bGhb4Lw7Ix6iYwWXR4KvJI"}]], "depth": 7, "prev_state": [], "auth_events": [["$15479247502PzwLU:localhost", {"sha256": "DJlzrstrvn/ao0HAb6iDHfEjn7o2KcPiXhsrdMkG3Jw"}], ["$15479247500OKKlI:localhost", {"sha256": "4euu901/oZf9Sg/VtZMyQicx1FdWo0vBCR/Z7oydjcM"}], ["$15479247501iUNIP:localhost", {"sha256": "e32HqudAUT+pwPhfgp/OaU7/p4bVxGJ3iO+eXi7ACEo"}]], "hashes": {"sha256": "80QL8tPAC3OjcYz0A7ljeT5TgiG/LrS/EEA6QUa8bCo"}, "signatures": {"localhost": {"ed25519:a_cgoU": "i0SpMCLMuujQG+GIri+lxAXcYaf4AtJJvROI/S8kFl3BpfqiM+2JFSOQ/x2t2SNoFDser1mDJoGhOWPBrtUDCQ"}}, "unsigned": {"age_ts": 1547924844130, "replaces_state": "$15479247501iUNIP:localhost"}}
$154792488216AbRES:localhost	!lxLGrxbEpguUZULoSC:localhost	{"token_id": 3, "stream_ordering": 17}	{"type": "m.room.create", "content": {"room_version": "1", "creator": "@user1:localhost"}, "room_id": "!lxLGrxbEpguUZULoSC:localhost", "sender": "@user1:localhost", "state_key": "", "event_id": "$154792488216AbRES:localhost", "origin": "localhost", "origin_server_ts": 1547924882173, "prev_events": [], "depth": 1, "prev_state": [], "auth_events": [], "hashes": {"sha256": "ClNG++ENTL46ibGcM6a7FbEYxxwhllaOiS/qR1Q+gj4"}, "signatures": {"localhost": {"ed25519:a_cgoU": "+EdfxoElglOPr7T++KsD+9npPgCbPl0vUYtP4iPzs8mlU2LQbDZdZcf7RLAkVwit8LTogtEK59Gg23JAQtZ2Dw"}}, "unsigned": {"age_ts": 1547924882173}}
$154792488218BUaoQ:localhost	!lxLGrxbEpguUZULoSC:localhost	{"token_id": 3, "stream_ordering": 19}	{"type": "m.room.power_levels", "content": {"users": {"@user1:localhost": 100}, "users_default": 0, "events": {"m.room.name": 50, "m.room.power_levels": 100, "m.room.history_visibility": 100, "m.room.canonical_alias": 50, "m.room.avatar": 50}, "events_default": 0, "state_default": 50, "ban": 50, "kick": 50, "redact": 50, "invite": 0}, "room_id": "!lxLGrxbEpguUZULoSC:localhost", "sender": "@user1:localhost", "state_key": "", "event_id": "$154792488218BUaoQ:localhost", "origin": "localhost", "origin_server_ts": 1547924882263, "prev_events": [["$154792488217OnxTZ:localhost", {"sha256": "EuxEpAoxlHlAx/cmu7zulA8oDra4/VGu1g7dIYSosOY"}]], "depth": 3, "prev_state": [], "auth_events": [["$154792488216AbRES:localhost", {"sha256": "KjjVUyLVqD5xKYG/qqPOY4tOMWXNy1V8mFoioC6xk2k"}], ["$154792488217OnxTZ:localhost", {"sha256": "EuxEpAoxlHlAx/cmu7zulA8oDra4/VGu1g7dIYSosOY"}]], "hashes": {"sha256": "S18zvpho26ZfzhDgyezQs+dgvKt1n/BhWXPU9L5X6rA"}, "signatures": {"localhost": {"ed25519:a_cgoU": "yBXmQ9BL+XRX1N+ifT+/Z5ylKjH+tb7gVbDiVo2nQZQQfHCCFXgG2ZI+bXZkCKvMD5dJ2ni1lYYyNh8pGjXLBg"}}, "unsigned": {"age_ts": 1547924882263}}
$154792488220dvrBE:localhost	!lxLGrxbEpguUZULoSC:localhost	{"token_id": 3, "stream_ordering": 21}	{"type": "m.room.history_visibility", "content": {"history_visibility": "shared"}, "room_id": "!lxLGrxbEpguUZULoSC:localhost", "sender": "@user1:localhost", "state_key": "", "event_id": "$154792488220dvrBE:localhost", "origin": "localhost", "origin_server_ts": 1547924882390, "prev_events": [["$154792488219bruaB:localhost", {"sha256": "xrt83/TN6RvMs0H85MIaGt84NuwmcSofrA3ubYqtRSc"}]], "depth": 5, "prev_state": [], "auth_events": [["$154792488218BUaoQ:localhost", {"sha256": "YIlp2Qh9VG9OXL6naNJJrN5NutFrzhc41LtB+gDMZkQ"}], ["$154792488216AbRES:localhost", {"sha256": "KjjVUyLVqD5xKYG/qqPOY4tOMWXNy1V8mFoioC6xk2k"}], ["$154792488217OnxTZ:localhost", {"sha256": "EuxEpAoxlHlAx/cmu7zulA8oDra4/VGu1g7dIYSosOY"}]], "hashes": {"sha256": "uEw3DfL8VXrSjNUOOY6eSYeHkmF6vuUrsXHXkW0UMhI"}, "signatures": {"localhost": {"ed25519:a_cgoU": "xDeW2gJtwVTIv3q4pu/4Jh3d7bQirGRfCyjuewhI+Ql2cuAC+7PimnhvW6jWBdSIo1WjWcC7XN1rtpjjVGiLCg"}}, "unsigned": {"age_ts": 1547924882390}}
$154792492925JZWbo:localhost	!tHjklMrpyrzHaqkxRt:localhost	{"token_id": 5, "stream_ordering": 26}	{"type": "m.room.member", "content": {"membership": "join", "displayname": "user2", "avatar_url": null}, "room_id": "!tHjklMrpyrzHaqkxRt:localhost", "sender": "@user2:localhost", "state_key": "@user2:localhost", "membership": "join", "event_id": "$154792492925JZWbo:localhost", "origin": "localhost", "origin_server_ts": 1547924929965, "prev_events": [["$154792492924bdmxc:localhost", {"sha256": "S652enxTPCdC5vSgWcuTHMLbhZ5BzOM4xHIDefpqoF0"}]], "depth": 2, "prev_state": [], "auth_events": [["$154792492924bdmxc:localhost", {"sha256": "S652enxTPCdC5vSgWcuTHMLbhZ5BzOM4xHIDefpqoF0"}]], "hashes": {"sha256": "XvThNTR0GtNpOJn0cIJHbOkZeGfaQ5vY+9oVi6fWlpk"}, "signatures": {"localhost": {"ed25519:a_cgoU": "2xrhSn2B+aV2H3LXlQiztRS0wcCRiwc3rkdIt+0ZNjBhWnHO8rjDBdcHd8eOFWxwcrDD7Xrzd73gne0wtFcBBw"}}, "unsigned": {"age_ts": 1547924929965}}
$154792488221gUPQT:localhost	!lxLGrxbEpguUZULoSC:localhost	{"token_id": 3, "stream_ordering": 22}	{"type": "m.room.guest_access", "content": {"guest_access": "can_join"}, "room_id": "!lxLGrxbEpguUZULoSC:localhost", "sender": "@user1:localhost", "state_key": "", "event_id": "$154792488221gUPQT:localhost", "origin": "localhost", "origin_server_ts": 1547924882464, "prev_events": [["$154792488220dvrBE:localhost", {"sha256": "uQqUOL5kuENYR6PehwfMsd04PlfaxU3O7cgSpfUQegY"}]], "depth": 6, "prev_state": [], "auth_events": [["$154792488218BUaoQ:localhost", {"sha256": "YIlp2Qh9VG9OXL6naNJJrN5NutFrzhc41LtB+gDMZkQ"}], ["$154792488216AbRES:localhost", {"sha256": "KjjVUyLVqD5xKYG/qqPOY4tOMWXNy1V8mFoioC6xk2k"}], ["$154792488217OnxTZ:localhost", {"sha256": "EuxEpAoxlHlAx/cmu7zulA8oDra4/VGu1g7dIYSosOY"}]], "hashes": {"sha256": "jqnTotcXGgFdpjsT98/KhjiOJn3zEcKRbcRbsk/auWI"}, "signatures": {"localhost": {"ed25519:a_cgoU": "C89pT8cQNNQThaVjcpR2Fh/5nBbFE6BBFSX9L9eIpc+IwlHLDJ0qcnu8hzPmaV3+PTCQfPGQscH5siaxVdbYCw"}}, "unsigned": {"age_ts": 1547924882464}}
$154792490923tISso:localhost	!lxLGrxbEpguUZULoSC:localhost	{"token_id": 3, "stream_ordering": 24}	{"type": "m.room.related_groups", "content": {"groups": ["+winter:localhost"]}, "room_id": "!lxLGrxbEpguUZULoSC:localhost", "sender": "@user1:localhost", "state_key": "", "event_id": "$154792490923tISso:localhost", "origin": "localhost", "origin_server_ts": 1547924909360, "prev_events": [["$154792488222ZBqEn:localhost", {"sha256": "TCXZJVMEahcLM45jMOo6osGNebNEplUeq2smMVS/jIw"}]], "depth": 8, "prev_state": [], "auth_events": [["$154792488218BUaoQ:localhost", {"sha256": "YIlp2Qh9VG9OXL6naNJJrN5NutFrzhc41LtB+gDMZkQ"}], ["$154792488216AbRES:localhost", {"sha256": "KjjVUyLVqD5xKYG/qqPOY4tOMWXNy1V8mFoioC6xk2k"}], ["$154792488217OnxTZ:localhost", {"sha256": "EuxEpAoxlHlAx/cmu7zulA8oDra4/VGu1g7dIYSosOY"}]], "hashes": {"sha256": "1Ghp+oCG/iI74CZeI8LwYiGjwiTCY563LOmArmOBx4w"}, "signatures": {"localhost": {"ed25519:a_cgoU": "8UhK2hSM0Et9K5veEWE8wR0dLgHWTkw2gbeew9TGZp2i/4J4Z6q/ENbz8hzPOWAtWGFQYtux+5YDsjdVkK9TDw"}}, "unsigned": {"age_ts": 1547924909360}}
$154792515636GRwRe:localhost	!DwnsPKUkFrUbPENRUr:localhost	{"token_id": 7, "txn_id": "m1547925156097.1", "stream_ordering": 35}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "This can be string for a single unique column or an array for a composite."}, "room_id": "!DwnsPKUkFrUbPENRUr:localhost", "sender": "@user2:localhost", "event_id": "$154792515636GRwRe:localhost", "origin": "localhost", "origin_server_ts": 1547925156128, "prev_events": [["$154792514935gxWdL:localhost", {"sha256": "bxVCqXgrDrJskC9M4WzxGqe1dS71AU2BNga7/uPP4zw"}]], "depth": 13, "auth_events": [["$15479248189maFVd:localhost", {"sha256": "Ko3cvqdUrmcYnXpIVRjvGi25xPZHefXWdxIBZgy7ep4"}], ["$15479248177pgEuD:localhost", {"sha256": "YFkVZ9hBxC1u5aLChxqK2yk8e+5AK9V4tJfZMvNRcGc"}], ["$154792514935gxWdL:localhost", {"sha256": "bxVCqXgrDrJskC9M4WzxGqe1dS71AU2BNga7/uPP4zw"}]], "hashes": {"sha256": "twvNyldy6OkU4+VC64qrEHSVa5bJFebZo1uh0yEecDs"}, "signatures": {"localhost": {"ed25519:a_cgoU": "gtoZkBMpgQ5ecVzO7gFZ2BsJhbMVLVxfZWnK1PTrv7X+5fC7ENvfK2ORfoxjew9/HqOd7/heBztvo8iHJPqUDg"}}, "unsigned": {"age_ts": 1547925156128}}
$154792488222ZBqEn:localhost	!lxLGrxbEpguUZULoSC:localhost	{"token_id": 3, "stream_ordering": 23}	{"type": "m.room.name", "room_id": "!lxLGrxbEpguUZULoSC:localhost", "sender": "@user1:localhost", "state_key": "", "content": {"name": "public"}, "event_id": "$154792488222ZBqEn:localhost", "origin": "localhost", "origin_server_ts": 1547924882506, "prev_events": [["$154792488221gUPQT:localhost", {"sha256": "H2nfzTAW0hLo53VdciFWEP/B4/Cd9vKN/jUl2nHAa7I"}]], "depth": 7, "prev_state": [], "auth_events": [["$154792488218BUaoQ:localhost", {"sha256": "YIlp2Qh9VG9OXL6naNJJrN5NutFrzhc41LtB+gDMZkQ"}], ["$154792488216AbRES:localhost", {"sha256": "KjjVUyLVqD5xKYG/qqPOY4tOMWXNy1V8mFoioC6xk2k"}], ["$154792488217OnxTZ:localhost", {"sha256": "EuxEpAoxlHlAx/cmu7zulA8oDra4/VGu1g7dIYSosOY"}]], "hashes": {"sha256": "nqnXZL/w5iYoBynRAgRsdanWMsK21zgXY6VShCahP1M"}, "signatures": {"localhost": {"ed25519:a_cgoU": "oY14MWKlU9SutIde26whQL9C9ep+9Nzks0InESNVePyQtK7rSKaxWbEr0osfjeRFNIRp6XGZrAgL2nxIeKy6Cw"}}, "unsigned": {"age_ts": 1547924882506}}
$154792516437BJyyo:localhost	!DwnsPKUkFrUbPENRUr:localhost	{"token_id": 7, "txn_id": "m1547925164511.2", "stream_ordering": 36}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "\\u0442\\u0430\\u043a \\u0442\\u043e\\u0442\\u0443 \\u043c\\u0435\\u043d\\u044f \\u0442\\u043e\\u0434\\u0435 \\u0432 \\u044f\\u043d\\u0432\\u0430\\u0440\\u0435 \\u0441\\u0435\\u0441\\u0441\\u0438\\u044f, \\u043c\\u0430\\u043b\\u043e \\u0443 \\u043a\\u043e\\u0433\\u043e \\u043e\\u0442\\u043b\\u0438\\u0447\\u0430\\u0435\\u0442\\u0441\\u044f"}, "room_id": "!DwnsPKUkFrUbPENRUr:localhost", "sender": "@user2:localhost", "event_id": "$154792516437BJyyo:localhost", "origin": "localhost", "origin_server_ts": 1547925164548, "prev_events": [["$154792515636GRwRe:localhost", {"sha256": "XCLgsvOAPkcMoQMOI0Ll+v8nOyRLTAmkC8H43xIdiog"}]], "depth": 14, "auth_events": [["$15479248189maFVd:localhost", {"sha256": "Ko3cvqdUrmcYnXpIVRjvGi25xPZHefXWdxIBZgy7ep4"}], ["$15479248177pgEuD:localhost", {"sha256": "YFkVZ9hBxC1u5aLChxqK2yk8e+5AK9V4tJfZMvNRcGc"}], ["$154792514935gxWdL:localhost", {"sha256": "bxVCqXgrDrJskC9M4WzxGqe1dS71AU2BNga7/uPP4zw"}]], "hashes": {"sha256": "DGHNddDySk+MGtlZGP7kENcKwT+/29S57HLwonXY5XQ"}, "signatures": {"localhost": {"ed25519:a_cgoU": "pguJiyNvewq6//38xXlHtEOkgR26lsrdh7nZybNuOGEhWNTN4YSjx0QJaCJVjrvijcLmDBBVFxkyEzL8jOVpDg"}}, "unsigned": {"age_ts": 1547925164548}}
$154792493029TiWmR:localhost	!tHjklMrpyrzHaqkxRt:localhost	{"token_id": 5, "stream_ordering": 30}	{"type": "m.room.guest_access", "content": {"guest_access": "can_join"}, "room_id": "!tHjklMrpyrzHaqkxRt:localhost", "sender": "@user2:localhost", "state_key": "", "event_id": "$154792493029TiWmR:localhost", "origin": "localhost", "origin_server_ts": 1547924930189, "prev_events": [["$154792493028JotEC:localhost", {"sha256": "0Y73stUldEewXqEo6VpsluwuIFl63vxTQ48CeS0sThQ"}]], "depth": 6, "prev_state": [], "auth_events": [["$154792493026cBNiO:localhost", {"sha256": "JHbPERXP/6s0eAmnnvRhP64z7oNbo2DZ0ZtMdvl51PI"}], ["$154792492924bdmxc:localhost", {"sha256": "S652enxTPCdC5vSgWcuTHMLbhZ5BzOM4xHIDefpqoF0"}], ["$154792492925JZWbo:localhost", {"sha256": "Q6u5jEzKLYkcJV5SP/FMXFjWgVB6/1jg72Ln+Wqw8kU"}]], "hashes": {"sha256": "54GK7hzQ5KGNhd+Hjf4Vr9pw5yXYYm63ENjeQAEEOy8"}, "signatures": {"localhost": {"ed25519:a_cgoU": "4gq28sfrZIa/oKEmC7EJ+lo1ieCSAM42Ub7NrkcuXpJJEa+VIHa51zPcAJBcKFF35xahqUYKexUv3WQZjjUjCw"}}, "unsigned": {"age_ts": 1547924930189}}
$154792507633FUQML:localhost	!DwnsPKUkFrUbPENRUr:localhost	{"token_id": 8, "stream_ordering": 33}	{"type": "m.room.member", "content": {"membership": "invite", "displayname": "user2", "avatar_url": null}, "room_id": "!DwnsPKUkFrUbPENRUr:localhost", "sender": "@user1:localhost", "state_key": "@user2:localhost", "membership": "invite", "event_id": "$154792507633FUQML:localhost", "origin": "localhost", "origin_server_ts": 1547925076662, "prev_events": [["$154792503032kwMJH:localhost", {"sha256": "9BDp4EgwU+j0Cj6jIM8PhEHvoOJ4sqyUeB/iIEV1nRI"}]], "depth": 11, "prev_state": [], "auth_events": [["$15479248189maFVd:localhost", {"sha256": "Ko3cvqdUrmcYnXpIVRjvGi25xPZHefXWdxIBZgy7ep4"}], ["$15479248177pgEuD:localhost", {"sha256": "YFkVZ9hBxC1u5aLChxqK2yk8e+5AK9V4tJfZMvNRcGc"}], ["$15479248178PDnSR:localhost", {"sha256": "6edDzdaCVWyznP4vuu8fbj/QwxG8QVdP/cGJXooU0B4"}], ["$154792481810eHTrj:localhost", {"sha256": "1rVLKHQvn3aCtwZwPXupMfeaG6wu+gDLQc77mqnENnE"}]], "hashes": {"sha256": "56j9pxtCLREVWi9tB4CnPgYU0qeauFiegjQiMoXZRmw"}, "signatures": {"localhost": {"ed25519:a_cgoU": "FxzdG06JhvpwoI0LKF6r5lh9Ld8CvOjHyUNlV/CSjWI6i3acIpDDiIs33L+tW+1yWO8cduMtphfyGUUTSRZnBw"}}, "unsigned": {"age_ts": 1547925076662, "invite_room_state": [{"type": "m.room.join_rules", "state_key": "", "content": {"join_rule": "invite"}, "sender": "@user1:localhost"}, {"type": "m.room.name", "state_key": "", "content": {"name": "public"}, "sender": "@user1:localhost"}, {"type": "m.room.member", "state_key": "@user1:localhost", "content": {"membership": "join", "displayname": "user1", "avatar_url": null}, "sender": "@user1:localhost"}]}}
$154792501831ATytk:localhost	!DwnsPKUkFrUbPENRUr:localhost	{"token_id": 6, "txn_id": "m1547925018801.0", "stream_ordering": 31}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "Batching can also be done through a many-to-many relationship. After the first SQL query, Join Monster will select from the junction table, and then join it on the related table. "}, "room_id": "!DwnsPKUkFrUbPENRUr:localhost", "sender": "@user1:localhost", "event_id": "$154792501831ATytk:localhost", "origin": "localhost", "origin_server_ts": 1547925018838, "prev_events": [["$154792483514Gzglm:localhost", {"sha256": "7QKcW41vAvrxkH5u89p5dyoy5dJkg/Ucx/5ODx2dueM"}]], "depth": 9, "auth_events": [["$15479248189maFVd:localhost", {"sha256": "Ko3cvqdUrmcYnXpIVRjvGi25xPZHefXWdxIBZgy7ep4"}], ["$15479248177pgEuD:localhost", {"sha256": "YFkVZ9hBxC1u5aLChxqK2yk8e+5AK9V4tJfZMvNRcGc"}], ["$15479248178PDnSR:localhost", {"sha256": "6edDzdaCVWyznP4vuu8fbj/QwxG8QVdP/cGJXooU0B4"}]], "hashes": {"sha256": "8XMb1jF7uK44SrsV4nvvrqoTO3ShPkmio/xPwDuFHEs"}, "signatures": {"localhost": {"ed25519:a_cgoU": "SfUzjiDtyp+K4p2BMn9olLRX4wcHBsZK+xyDW6/SE0Y7z2rovC3/2ydzbZ+5g8r2KPMCAHS9ACshtq6nH0gDCQ"}}, "unsigned": {"age_ts": 1547925018838}}
$154792514935gxWdL:localhost	!DwnsPKUkFrUbPENRUr:localhost	{"token_id": 9, "stream_ordering": 34}	{"type": "m.room.member", "content": {"membership": "join", "displayname": "user2", "avatar_url": null}, "room_id": "!DwnsPKUkFrUbPENRUr:localhost", "sender": "@user2:localhost", "state_key": "@user2:localhost", "membership": "join", "event_id": "$154792514935gxWdL:localhost", "origin": "localhost", "origin_server_ts": 1547925149640, "prev_events": [["$154792507633FUQML:localhost", {"sha256": "TDn2zMOibSwrWRRLRJMyJlchJZQNfkaOLuHz4lVjZhU"}]], "depth": 12, "prev_state": [], "auth_events": [["$15479248189maFVd:localhost", {"sha256": "Ko3cvqdUrmcYnXpIVRjvGi25xPZHefXWdxIBZgy7ep4"}], ["$15479248177pgEuD:localhost", {"sha256": "YFkVZ9hBxC1u5aLChxqK2yk8e+5AK9V4tJfZMvNRcGc"}], ["$154792481810eHTrj:localhost", {"sha256": "1rVLKHQvn3aCtwZwPXupMfeaG6wu+gDLQc77mqnENnE"}], ["$154792507633FUQML:localhost", {"sha256": "TDn2zMOibSwrWRRLRJMyJlchJZQNfkaOLuHz4lVjZhU"}]], "hashes": {"sha256": "9wmvp2AANUJJKiRcnwzncPiF+eJosIuhDRMtKFg0lWA"}, "signatures": {"localhost": {"ed25519:a_cgoU": "vJMp0joQZjgFwjlzeb5DdJDCiIfttrM8eI2gVmhWNqO3AlTaxsO1HmSWLymesgeJp/7DTAPnrLU2tN/gWINyCQ"}}, "unsigned": {"age_ts": 1547925149640, "replaces_state": "$154792507633FUQML:localhost"}}
$154792518138HlGib:localhost	!DwnsPKUkFrUbPENRUr:localhost	{"token_id": 7, "txn_id": "m1547925181258.3", "stream_ordering": 37}	{"type": "m.room.message", "content": {"msgtype": "m.text", "body": "\\u043f\\u0443\\u0448\\u0438\\u0442 \\u0441 \\u0430\\u0432\\u043f \\u0432 \\u043d\\u0430\\u0434\\u0435\\u0436\\u0434\\u0435 \\u043d\\u0430 \\u0447\\u0442\\u043e"}, "room_id": "!DwnsPKUkFrUbPENRUr:localhost", "sender": "@user2:localhost", "event_id": "$154792518138HlGib:localhost", "origin": "localhost", "origin_server_ts": 1547925181306, "prev_events": [["$154792516437BJyyo:localhost", {"sha256": "uFYLYOTK2ma6DeXpBQjlGgX9AAsf+IPw25MachdlIgw"}]], "depth": 15, "auth_events": [["$15479248189maFVd:localhost", {"sha256": "Ko3cvqdUrmcYnXpIVRjvGi25xPZHefXWdxIBZgy7ep4"}], ["$15479248177pgEuD:localhost", {"sha256": "YFkVZ9hBxC1u5aLChxqK2yk8e+5AK9V4tJfZMvNRcGc"}], ["$154792514935gxWdL:localhost", {"sha256": "bxVCqXgrDrJskC9M4WzxGqe1dS71AU2BNga7/uPP4zw"}]], "hashes": {"sha256": "uVhdmpMj1AfWGD3BTxq4xAZrKiSB3ot6928rDSziCy0"}, "signatures": {"localhost": {"ed25519:a_cgoU": "mlY1cZleBUcXvsGd0WmCzNun0dfPOX+5G0TPmLPQBS+mhhu61ji0Zd4IUD7YbUMJrUsjd00X5ZLPJqSG148mCw"}}, "unsigned": {"age_ts": 1547925181306}}
\.


--
-- Data for Name: event_push_actions; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_push_actions (room_id, event_id, user_id, profile_tag, actions, topological_ordering, stream_ordering, notif, highlight) FROM stdin;
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
\.


--
-- Data for Name: event_push_summary_stream_ordering; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_push_summary_stream_ordering (lock, stream_ordering) FROM stdin;
X	0
\.


--
-- Data for Name: event_reference_hashes; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.event_reference_hashes (event_id, algorithm, hash) FROM stdin;
$15479247500OKKlI:localhost	sha256	\\xe1ebaef74d7fa197fd4a0fd5b59332422731d45756a34bc1091fd9ee8c9d8dc3
$15479247501iUNIP:localhost	sha256	\\x7b7d87aae740513fa9c0f85f829fce694effa786d5c4627788ef9e5e2ec0084a
$15479247502PzwLU:localhost	sha256	\\x0c9973aecb6bbe7fdaa341c06fa8831df1239fba3629c3e25e1b2b74c906dc9c
$15479247503HdRXi:localhost	sha256	\\xc40553edf0ff19312cb6fba3d94cd9982357efc31ac90ee1ef2e8eff18864a32
$15479247504DWCIT:localhost	sha256	\\x4889de209df683d842c4955e1298e8ef475d76797fa3ad79b3c153cdcdeba0ef
$15479247505lMKFc:localhost	sha256	\\x31e73c2a0e4ab79a6085c601e8fbe3f5b1a16f82f0ec8c7a898c165d1e0abc92
$15479248177pgEuD:localhost	sha256	\\x60591567d841c42d6ee5a2c2871a8adb293c7bee402bd578b497d932f3517067
$15479248178PDnSR:localhost	sha256	\\xe9e743cdd682556cb39cfe2fbaef1f6e3fd0c311bc41574ffdc1895e8a14d01e
$15479248189maFVd:localhost	sha256	\\x2a8ddcbea754ae67189d7a485518ef1a2db9c4f64779f5d6771201660cbb7a9e
$154792481810eHTrj:localhost	sha256	\\xd6b54b28742f9f7682b706703d7ba931f79a1bac2efa00cb41cefb9aa9c43671
$154792481811UJmBV:localhost	sha256	\\x5bfa2930c0bc7dd5d4a68242cc966aa2d99872022910f7b20e1b00217a819f8b
$154792481812FTgOr:localhost	sha256	\\x2ffe92b7a74ba1ece87afd9238a824ab18aebffcd966c59904b9779283210635
$154792481813sscwS:localhost	sha256	\\x597321985f702b5733310871cf1933413cadbbf278073a81cdcbe6c3c7601b40
$154792483514Gzglm:localhost	sha256	\\xed029c5b8d6f02faf1907e6ef3da79772a32e5d26483f51cc7fe4e0f1d9db9e3
$154792484415abNlG:localhost	sha256	\\x55ef2d28a12e79eb0557a57e9677794a8449941ff71090faea0864294f81ce65
$154792488216AbRES:localhost	sha256	\\x2a38d55322d5a83e712981bfaaa3ce638b4e3165cdcb557c985a22a02eb19369
$154792488217OnxTZ:localhost	sha256	\\x12ec44a40a31947940c7f726bbbcee940f280eb6b8fd51aed60edd2184a8b0e6
$154792488218BUaoQ:localhost	sha256	\\x608969d9087d546f4e5cbea768d249acde4dbad16bce1738d4bb41fa00cc6644
$154792488219bruaB:localhost	sha256	\\xc6bb7cdff4cde91bccb341fce4c21a1adf3836ec26712a1fac0dee6d8aad4527
$154792488220dvrBE:localhost	sha256	\\xb90a9438be64b8435847a3de8707ccb1dd383e57dac54dceedc812a5f5107a06
$154792488221gUPQT:localhost	sha256	\\x1f69dfcd3016d212e8e7755d72215610ffc1e3f09df6f28dfe3525da71c06bb2
$154792488222ZBqEn:localhost	sha256	\\x4c25d92553046a170b338e6330ea3aa2c18d79b344a6551eab6b263154bf8c8c
$154792490923tISso:localhost	sha256	\\x470b99caa8192fab2ef731540173fcb11c8ab24403e22c9f0d45bb27fdc629aa
$154792492924bdmxc:localhost	sha256	\\x4bae767a7c533c2742e6f4a059cb931cc2db859e41cce338c4720379fa6aa05d
$154792492925JZWbo:localhost	sha256	\\x43abb98c4cca2d891c255e523ff14c5c58d681507aff58e0ef62e7f96ab0f245
$154792493026cBNiO:localhost	sha256	\\x2476cf1115cfffab347809a79ef4613fae33ee835ba360d9d19b4c76f979d4f2
$154792493027Gtrdl:localhost	sha256	\\xb91f84a234ca97dc833e03afcc9caabfb14dabec4726b35e94e083a3848e43d1
$154792493028JotEC:localhost	sha256	\\xd18ef7b2d5257447b05ea128e95a6c96ec2e20597adefc53438f02792d2c4e14
$154792493029TiWmR:localhost	sha256	\\x956fd8fbdbf2c7c2bec07c50aa2f09bb30128ea37f62ac087bc6ba4bca1dc59b
$154792501831ATytk:localhost	sha256	\\xa4f454884c4087fdb2ea6cfe2064998d87b0721f504fa4171c3deb2a44cc9cd3
$154792503032kwMJH:localhost	sha256	\\xf410e9e0483053e8f40a3ea320cf0f8441efa0e278b2ac94781fe22045759d12
$154792507633FUQML:localhost	sha256	\\x4c39f6ccc3a26d2c2b59144b44933226572125940d7e468e2ee1f3e255636615
$154792514935gxWdL:localhost	sha256	\\x6f1542a9782b0eb26c902f4ce16cf11aa7b5752ef5014d813606bbfee3cfe33c
$154792515636GRwRe:localhost	sha256	\\x5c22e0b2f3803e470ca1030e2342e5faff273b244b4c09a40bc1f8df121d8a88
$154792516437BJyyo:localhost	sha256	\\xb8560b60e4cada66ba0de5e90508e51a05fd000b1ff883f0db931a721765220c
$154792518138HlGib:localhost	sha256	\\x7113f6d9e4b386dfe7baf5efc7edc033fd8264e07a7173664b65ae67415f79ea
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
$154792481813sscwS:localhost	!DwnsPKUkFrUbPENRUr:localhost	\N	content.name	'public':1	1547924818223	14
$154792488222ZBqEn:localhost	!lxLGrxbEpguUZULoSC:localhost	\N	content.name	'public':1	1547924882506	23
$154792501831ATytk:localhost	!DwnsPKUkFrUbPENRUr:localhost	\N	content.body	'also':3 'batch':1 'done':5 'first':15 'join':18,28 'junction':24 'mani':9,11 'many-to-mani':8 'monster':19 'queri':17 'relat':32 'relationship':12 'select':21 'sql':16 'tabl':25,33	1547925018838	31
$154792503032kwMJH:localhost	!DwnsPKUkFrUbPENRUr:localhost	\N	content.body	'xd':3 'дело':1 'джейма':2	1547925030251	32
$154792515636GRwRe:localhost	!DwnsPKUkFrUbPENRUr:localhost	\N	content.body	'array':12 'column':9 'composit':15 'singl':7 'string':4 'uniqu':8	1547925156128	35
$154792516437BJyyo:localhost	!DwnsPKUkFrUbPENRUr:localhost	\N	content.body	'в':5 'кого':10 'мало':8 'меня':3 'отличается':11 'сессия':7 'так':1 'тоде':4 'тоту':2 'у':9 'январе':6	1547925164548	36
$154792518138HlGib:localhost	!DwnsPKUkFrUbPENRUr:localhost	\N	content.body	'авп':3 'в':4 'на':6 'надежде':5 'пушит':1 'с':2 'что':7	1547925181306	37
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
$15479247500OKKlI:localhost	1
$15479247501iUNIP:localhost	2
$15479247502PzwLU:localhost	3
$15479247503HdRXi:localhost	4
$15479247504DWCIT:localhost	5
$15479247505lMKFc:localhost	6
$15479248177pgEuD:localhost	8
$15479248178PDnSR:localhost	9
$15479248189maFVd:localhost	10
$154792481810eHTrj:localhost	11
$154792481811UJmBV:localhost	12
$154792481812FTgOr:localhost	13
$154792481813sscwS:localhost	14
$154792483514Gzglm:localhost	15
$154792484415abNlG:localhost	16
$154792488216AbRES:localhost	17
$154792488217OnxTZ:localhost	18
$154792488218BUaoQ:localhost	19
$154792488219bruaB:localhost	20
$154792488220dvrBE:localhost	21
$154792488221gUPQT:localhost	22
$154792488222ZBqEn:localhost	23
$154792490923tISso:localhost	24
$154792492924bdmxc:localhost	25
$154792492925JZWbo:localhost	26
$154792493026cBNiO:localhost	27
$154792493027Gtrdl:localhost	28
$154792493028JotEC:localhost	29
$154792493029TiWmR:localhost	30
$154792501831ATytk:localhost	15
$154792503032kwMJH:localhost	15
$154792507633FUQML:localhost	32
$154792514935gxWdL:localhost	33
$154792515636GRwRe:localhost	33
$154792516437BJyyo:localhost	33
$154792518138HlGib:localhost	33
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.events (stream_ordering, topological_ordering, event_id, type, room_id, content, unrecognized_keys, processed, outlier, depth, origin_server_ts, received_ts, sender, contains_url) FROM stdin;
2	1	$15479247500OKKlI:localhost	m.room.create	!YvivtdTtsTAmNnsRUw:localhost	\N	\N	t	f	1	1547924750066	1547924750093	@user1:localhost	f
3	2	$15479247501iUNIP:localhost	m.room.member	!YvivtdTtsTAmNnsRUw:localhost	\N	\N	t	f	2	1547924750113	1547924750185	@user1:localhost	f
4	3	$15479247502PzwLU:localhost	m.room.power_levels	!YvivtdTtsTAmNnsRUw:localhost	\N	\N	t	f	3	1547924750199	1547924750243	@user1:localhost	f
5	4	$15479247503HdRXi:localhost	m.room.join_rules	!YvivtdTtsTAmNnsRUw:localhost	\N	\N	t	f	4	1547924750258	1547924750291	@user1:localhost	f
6	5	$15479247504DWCIT:localhost	m.room.history_visibility	!YvivtdTtsTAmNnsRUw:localhost	\N	\N	t	f	5	1547924750300	1547924750328	@user1:localhost	f
7	6	$15479247505lMKFc:localhost	m.room.guest_access	!YvivtdTtsTAmNnsRUw:localhost	\N	\N	t	f	6	1547924750348	1547924750384	@user1:localhost	f
8	1	$15479248177pgEuD:localhost	m.room.create	!DwnsPKUkFrUbPENRUr:localhost	\N	\N	t	f	1	1547924817927	1547924817951	@user1:localhost	f
9	2	$15479248178PDnSR:localhost	m.room.member	!DwnsPKUkFrUbPENRUr:localhost	\N	\N	t	f	2	1547924817969	1547924817997	@user1:localhost	f
10	3	$15479248189maFVd:localhost	m.room.power_levels	!DwnsPKUkFrUbPENRUr:localhost	\N	\N	t	f	3	1547924818016	1547924818051	@user1:localhost	f
11	4	$154792481810eHTrj:localhost	m.room.join_rules	!DwnsPKUkFrUbPENRUr:localhost	\N	\N	t	f	4	1547924818066	1547924818114	@user1:localhost	f
12	5	$154792481811UJmBV:localhost	m.room.history_visibility	!DwnsPKUkFrUbPENRUr:localhost	\N	\N	t	f	5	1547924818127	1547924818161	@user1:localhost	f
13	6	$154792481812FTgOr:localhost	m.room.guest_access	!DwnsPKUkFrUbPENRUr:localhost	\N	\N	t	f	6	1547924818172	1547924818206	@user1:localhost	f
14	7	$154792481813sscwS:localhost	m.room.name	!DwnsPKUkFrUbPENRUr:localhost	\N	\N	t	f	7	1547924818223	1547924818254	@user1:localhost	f
15	8	$154792483514Gzglm:localhost	m.room.related_groups	!DwnsPKUkFrUbPENRUr:localhost	\N	\N	t	f	8	1547924835639	1547924835658	@user1:localhost	f
16	7	$154792484415abNlG:localhost	m.room.member	!YvivtdTtsTAmNnsRUw:localhost	\N	\N	t	f	7	1547924844130	1547924844157	@user1:localhost	f
17	1	$154792488216AbRES:localhost	m.room.create	!lxLGrxbEpguUZULoSC:localhost	\N	\N	t	f	1	1547924882173	1547924882196	@user1:localhost	f
18	2	$154792488217OnxTZ:localhost	m.room.member	!lxLGrxbEpguUZULoSC:localhost	\N	\N	t	f	2	1547924882214	1547924882244	@user1:localhost	f
19	3	$154792488218BUaoQ:localhost	m.room.power_levels	!lxLGrxbEpguUZULoSC:localhost	\N	\N	t	f	3	1547924882263	1547924882310	@user1:localhost	f
20	4	$154792488219bruaB:localhost	m.room.join_rules	!lxLGrxbEpguUZULoSC:localhost	\N	\N	t	f	4	1547924882327	1547924882368	@user1:localhost	f
21	5	$154792488220dvrBE:localhost	m.room.history_visibility	!lxLGrxbEpguUZULoSC:localhost	\N	\N	t	f	5	1547924882390	1547924882454	@user1:localhost	f
22	6	$154792488221gUPQT:localhost	m.room.guest_access	!lxLGrxbEpguUZULoSC:localhost	\N	\N	t	f	6	1547924882464	1547924882495	@user1:localhost	f
23	7	$154792488222ZBqEn:localhost	m.room.name	!lxLGrxbEpguUZULoSC:localhost	\N	\N	t	f	7	1547924882506	1547924882536	@user1:localhost	f
24	8	$154792490923tISso:localhost	m.room.related_groups	!lxLGrxbEpguUZULoSC:localhost	\N	\N	t	f	8	1547924909360	1547924909377	@user1:localhost	f
25	1	$154792492924bdmxc:localhost	m.room.create	!tHjklMrpyrzHaqkxRt:localhost	\N	\N	t	f	1	1547924929933	1547924929951	@user2:localhost	f
26	2	$154792492925JZWbo:localhost	m.room.member	!tHjklMrpyrzHaqkxRt:localhost	\N	\N	t	f	2	1547924929965	1547924930028	@user2:localhost	f
27	3	$154792493026cBNiO:localhost	m.room.power_levels	!tHjklMrpyrzHaqkxRt:localhost	\N	\N	t	f	3	1547924930043	1547924930085	@user2:localhost	f
28	4	$154792493027Gtrdl:localhost	m.room.join_rules	!tHjklMrpyrzHaqkxRt:localhost	\N	\N	t	f	4	1547924930096	1547924930127	@user2:localhost	f
29	5	$154792493028JotEC:localhost	m.room.history_visibility	!tHjklMrpyrzHaqkxRt:localhost	\N	\N	t	f	5	1547924930144	1547924930179	@user2:localhost	f
30	6	$154792493029TiWmR:localhost	m.room.guest_access	!tHjklMrpyrzHaqkxRt:localhost	\N	\N	t	f	6	1547924930189	1547924930213	@user2:localhost	f
31	9	$154792501831ATytk:localhost	m.room.message	!DwnsPKUkFrUbPENRUr:localhost	\N	\N	t	f	9	1547925018838	1547925018849	@user1:localhost	f
32	10	$154792503032kwMJH:localhost	m.room.message	!DwnsPKUkFrUbPENRUr:localhost	\N	\N	t	f	10	1547925030251	1547925030263	@user1:localhost	f
33	11	$154792507633FUQML:localhost	m.room.member	!DwnsPKUkFrUbPENRUr:localhost	\N	\N	t	f	11	1547925076662	1547925076687	@user1:localhost	f
34	12	$154792514935gxWdL:localhost	m.room.member	!DwnsPKUkFrUbPENRUr:localhost	\N	\N	t	f	12	1547925149640	1547925149702	@user2:localhost	f
35	13	$154792515636GRwRe:localhost	m.room.message	!DwnsPKUkFrUbPENRUr:localhost	\N	\N	t	f	13	1547925156128	1547925156160	@user2:localhost	f
36	14	$154792516437BJyyo:localhost	m.room.message	!DwnsPKUkFrUbPENRUr:localhost	\N	\N	t	f	14	1547925164548	1547925164558	@user2:localhost	f
37	15	$154792518138HlGib:localhost	m.room.message	!DwnsPKUkFrUbPENRUr:localhost	\N	\N	t	f	15	1547925181306	1547925181320	@user2:localhost	f
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
events	37
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
+counterstrike:localhost	!DwnsPKUkFrUbPENRUr:localhost	f
+winter:localhost	!lxLGrxbEpguUZULoSC:localhost	f
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
+counterstrike:localhost	@user1:localhost	t	t
+winter:localhost	@user1:localhost	t	t
+counterstrike:localhost	@user2:localhost	f	t
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.groups (group_id, name, avatar_url, short_description, long_description, is_public, join_policy) FROM stdin;
+counterstrike:localhost	Counter-Strike: Global Offensive	\N	\N	\N	t	invite
+winter:localhost	HCT Americas Winter Playoffs	\N	\N	\N	t	invite
\.


--
-- Data for Name: guest_access; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.guest_access (event_id, room_id, guest_access) FROM stdin;
$15479247505lMKFc:localhost	!YvivtdTtsTAmNnsRUw:localhost	can_join
$154792481812FTgOr:localhost	!DwnsPKUkFrUbPENRUr:localhost	can_join
$154792488221gUPQT:localhost	!lxLGrxbEpguUZULoSC:localhost	can_join
$154792493029TiWmR:localhost	!tHjklMrpyrzHaqkxRt:localhost	can_join
\.


--
-- Data for Name: history_visibility; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.history_visibility (event_id, room_id, history_visibility) FROM stdin;
$15479247504DWCIT:localhost	!YvivtdTtsTAmNnsRUw:localhost	shared
$154792481811UJmBV:localhost	!DwnsPKUkFrUbPENRUr:localhost	shared
$154792488220dvrBE:localhost	!lxLGrxbEpguUZULoSC:localhost	shared
$154792493028JotEC:localhost	!tHjklMrpyrzHaqkxRt:localhost	shared
\.


--
-- Data for Name: local_group_membership; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.local_group_membership (group_id, user_id, is_admin, membership, is_publicised, content) FROM stdin;
+counterstrike:localhost	@user1:localhost	t	join	f	{}
+winter:localhost	@user1:localhost	t	join	f	{}
+counterstrike:localhost	@user2:localhost	f	join	f	{}
\.


--
-- Data for Name: local_group_updates; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.local_group_updates (stream_id, group_id, user_id, type, content) FROM stdin;
2	+counterstrike:localhost	@user1:localhost	membership	{"membership": "join", "content": {}}
3	+winter:localhost	@user1:localhost	membership	{"membership": "join", "content": {}}
4	+counterstrike:localhost	@user2:localhost	membership	{"membership": "invite", "content": {"profile": {"name": "Counter-Strike: Global Offensive", "avatar_url": null}, "inviter": "@user1:localhost"}}
5	+counterstrike:localhost	@user2:localhost	membership	{"membership": "join", "content": {}}
\.


--
-- Data for Name: local_invites; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.local_invites (stream_id, inviter, invitee, event_id, room_id, locally_rejected, replaced_by) FROM stdin;
34	@user1:localhost	@user2:localhost	$154792507633FUQML:localhost	!DwnsPKUkFrUbPENRUr:localhost	\N	$154792514935gxWdL:localhost
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
OiaZmaebnahwQDlxCpRNCjRR	1547928418533	@user1:localhost
AZYwoxAGKVVAaRHPWwWNCMfh	1547928418544	@user1:localhost
TRldCTSrrnqsLijliRzrklRq	1547928418558	@user1:localhost
nwXNPXyGxMzZrNMGJqnnGdhC	1547928440931	@user1:localhost
xbJCfswNdwbpaNZgLqFLQmiw	1547928440947	@user1:localhost
XwHEZKibSWIusijexbdwGHPC	1547928440956	@user1:localhost
woNZGoxLgTtbgozISOrEFbLE	1547928444214	@user1:localhost
sFhbHyUbongsPlfAqITkSXkE	1547928444302	@user1:localhost
jIlcwKPDhDUKHzMbjBrwIdVQ	1547928444324	@user1:localhost
XmZvVasxHQysZuleXWCcYRAL	1547928482711	@user1:localhost
hErxowjITFGJnwYOfhNfnRTi	1547928482720	@user1:localhost
AuFiFVTFXHgmUSjDjoKKmFlh	1547928482736	@user1:localhost
KDHrfQeLUnipfwVBjDAoDeqd	1547928663495	@user1:localhost
MDxqwLeJEMuRkvZwztVXYjdm	1547928663505	@user1:localhost
LOYLtkrXgDyrKMwTDnNeFtqy	1547928663519	@user1:localhost
YmZDHuABnhzKVbludBXfFLyg	1547928684981	@user1:localhost
NwtVhOeAdGGKLZamvqIHrXJd	1547928684992	@user1:localhost
XeHBuCflWHaPcRrSKHFEzOFF	1547928684998	@user1:localhost
vvYKRdXSpgHkRJicWJBDKIQB	1547928728476	@user1:localhost
YcmDbhXlpoAKkicEQxQeFTNr	1547928728491	@user1:localhost
srvROmBskqsghLSBrbGCNCfA	1547928728493	@user1:localhost
VTuumZtsVvSUWQgoJsrcyFgS	1547928749914	@user2:localhost
GLGPgvSdigpgKKtIIHhemWTv	1547928749916	@user2:localhost
LZlqAeUzdazaOIQsJtGrXRIX	1547928749936	@user2:localhost
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
14	@user1:localhost	offline	1547925137408	1547925172410	1547925139915	\N	t
15	@user2:localhost	online	1547925187340	1547924929918	1547925187341	\N	t
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.profiles (user_id, displayname, avatar_url) FROM stdin;
user1	user1	\N
user2	user2	\N
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
!DwnsPKUkFrUbPENRUr:localhost	m.read	@user2:localhost	["$154792507633FUQML:localhost"]	{"ts": 1547925151191}
\.


--
-- Data for Name: receipts_linearized; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.receipts_linearized (stream_id, room_id, receipt_type, user_id, event_id, data) FROM stdin;
2	!DwnsPKUkFrUbPENRUr:localhost	m.read	@user2:localhost	$154792507633FUQML:localhost	{"ts": 1547925151191}
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
@user1:localhost	!YvivtdTtsTAmNnsRUw:localhost	m.fully_read	4	{"event_id": "$15479247505lMKFc:localhost"}
@user1:localhost	!lxLGrxbEpguUZULoSC:localhost	m.fully_read	7	{"event_id": "$154792488222ZBqEn:localhost"}
@user1:localhost	!DwnsPKUkFrUbPENRUr:localhost	m.fully_read	9	{"event_id": "$154792507633FUQML:localhost"}
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
!YvivtdTtsTAmNnsRUw:localhost	1
!DwnsPKUkFrUbPENRUr:localhost	1
!lxLGrxbEpguUZULoSC:localhost	1
!tHjklMrpyrzHaqkxRt:localhost	1
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
$15479247501iUNIP:localhost	@user1:localhost	@user1:localhost	!YvivtdTtsTAmNnsRUw:localhost	join	0	user1	\N
$15479248178PDnSR:localhost	@user1:localhost	@user1:localhost	!DwnsPKUkFrUbPENRUr:localhost	join	0	user1	\N
$154792484415abNlG:localhost	@user1:localhost	@user1:localhost	!YvivtdTtsTAmNnsRUw:localhost	leave	0	\N	\N
$154792488217OnxTZ:localhost	@user1:localhost	@user1:localhost	!lxLGrxbEpguUZULoSC:localhost	join	0	user1	\N
$154792492925JZWbo:localhost	@user2:localhost	@user2:localhost	!tHjklMrpyrzHaqkxRt:localhost	join	0	user2	\N
$154792507633FUQML:localhost	@user2:localhost	@user1:localhost	!DwnsPKUkFrUbPENRUr:localhost	invite	0	user2	\N
$154792514935gxWdL:localhost	@user2:localhost	@user2:localhost	!DwnsPKUkFrUbPENRUr:localhost	join	0	user2	\N
\.


--
-- Data for Name: room_names; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.room_names (event_id, room_id, name) FROM stdin;
$154792481813sscwS:localhost	!DwnsPKUkFrUbPENRUr:localhost	public
$154792488222ZBqEn:localhost	!lxLGrxbEpguUZULoSC:localhost	public
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
!YvivtdTtsTAmNnsRUw:localhost	f	@user1:localhost
!DwnsPKUkFrUbPENRUr:localhost	f	@user1:localhost
!lxLGrxbEpguUZULoSC:localhost	f	@user1:localhost
!tHjklMrpyrzHaqkxRt:localhost	f	@user2:localhost
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
$15479247500OKKlI:localhost	!YvivtdTtsTAmNnsRUw:localhost	m.room.create		\N
$15479247501iUNIP:localhost	!YvivtdTtsTAmNnsRUw:localhost	m.room.member	@user1:localhost	\N
$15479247502PzwLU:localhost	!YvivtdTtsTAmNnsRUw:localhost	m.room.power_levels		\N
$15479247503HdRXi:localhost	!YvivtdTtsTAmNnsRUw:localhost	m.room.join_rules		\N
$15479247504DWCIT:localhost	!YvivtdTtsTAmNnsRUw:localhost	m.room.history_visibility		\N
$15479247505lMKFc:localhost	!YvivtdTtsTAmNnsRUw:localhost	m.room.guest_access		\N
$15479248177pgEuD:localhost	!DwnsPKUkFrUbPENRUr:localhost	m.room.create		\N
$15479248178PDnSR:localhost	!DwnsPKUkFrUbPENRUr:localhost	m.room.member	@user1:localhost	\N
$15479248189maFVd:localhost	!DwnsPKUkFrUbPENRUr:localhost	m.room.power_levels		\N
$154792481810eHTrj:localhost	!DwnsPKUkFrUbPENRUr:localhost	m.room.join_rules		\N
$154792481811UJmBV:localhost	!DwnsPKUkFrUbPENRUr:localhost	m.room.history_visibility		\N
$154792481812FTgOr:localhost	!DwnsPKUkFrUbPENRUr:localhost	m.room.guest_access		\N
$154792481813sscwS:localhost	!DwnsPKUkFrUbPENRUr:localhost	m.room.name		\N
$154792483514Gzglm:localhost	!DwnsPKUkFrUbPENRUr:localhost	m.room.related_groups		\N
$154792484415abNlG:localhost	!YvivtdTtsTAmNnsRUw:localhost	m.room.member	@user1:localhost	\N
$154792488216AbRES:localhost	!lxLGrxbEpguUZULoSC:localhost	m.room.create		\N
$154792488217OnxTZ:localhost	!lxLGrxbEpguUZULoSC:localhost	m.room.member	@user1:localhost	\N
$154792488218BUaoQ:localhost	!lxLGrxbEpguUZULoSC:localhost	m.room.power_levels		\N
$154792488219bruaB:localhost	!lxLGrxbEpguUZULoSC:localhost	m.room.join_rules		\N
$154792488220dvrBE:localhost	!lxLGrxbEpguUZULoSC:localhost	m.room.history_visibility		\N
$154792488221gUPQT:localhost	!lxLGrxbEpguUZULoSC:localhost	m.room.guest_access		\N
$154792488222ZBqEn:localhost	!lxLGrxbEpguUZULoSC:localhost	m.room.name		\N
$154792490923tISso:localhost	!lxLGrxbEpguUZULoSC:localhost	m.room.related_groups		\N
$154792492924bdmxc:localhost	!tHjklMrpyrzHaqkxRt:localhost	m.room.create		\N
$154792492925JZWbo:localhost	!tHjklMrpyrzHaqkxRt:localhost	m.room.member	@user2:localhost	\N
$154792493026cBNiO:localhost	!tHjklMrpyrzHaqkxRt:localhost	m.room.power_levels		\N
$154792493027Gtrdl:localhost	!tHjklMrpyrzHaqkxRt:localhost	m.room.join_rules		\N
$154792493028JotEC:localhost	!tHjklMrpyrzHaqkxRt:localhost	m.room.history_visibility		\N
$154792493029TiWmR:localhost	!tHjklMrpyrzHaqkxRt:localhost	m.room.guest_access		\N
$154792507633FUQML:localhost	!DwnsPKUkFrUbPENRUr:localhost	m.room.member	@user2:localhost	\N
$154792514935gxWdL:localhost	!DwnsPKUkFrUbPENRUr:localhost	m.room.member	@user2:localhost	\N
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
16	6
18	17
19	18
20	19
21	20
22	21
23	22
24	23
26	25
27	26
28	27
29	28
30	29
31	30
32	15
33	32
\.


--
-- Data for Name: state_groups; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.state_groups (id, room_id, event_id) FROM stdin;
1	!YvivtdTtsTAmNnsRUw:localhost	$15479247500OKKlI:localhost
2	!YvivtdTtsTAmNnsRUw:localhost	$15479247501iUNIP:localhost
3	!YvivtdTtsTAmNnsRUw:localhost	$15479247502PzwLU:localhost
4	!YvivtdTtsTAmNnsRUw:localhost	$15479247503HdRXi:localhost
5	!YvivtdTtsTAmNnsRUw:localhost	$15479247504DWCIT:localhost
6	!YvivtdTtsTAmNnsRUw:localhost	$15479247505lMKFc:localhost
7	!YvivtdTtsTAmNnsRUw:localhost	$15479247506alxoD:localhost
8	!DwnsPKUkFrUbPENRUr:localhost	$15479248177pgEuD:localhost
9	!DwnsPKUkFrUbPENRUr:localhost	$15479248178PDnSR:localhost
10	!DwnsPKUkFrUbPENRUr:localhost	$15479248189maFVd:localhost
11	!DwnsPKUkFrUbPENRUr:localhost	$154792481810eHTrj:localhost
12	!DwnsPKUkFrUbPENRUr:localhost	$154792481811UJmBV:localhost
13	!DwnsPKUkFrUbPENRUr:localhost	$154792481812FTgOr:localhost
14	!DwnsPKUkFrUbPENRUr:localhost	$154792481813sscwS:localhost
15	!DwnsPKUkFrUbPENRUr:localhost	$154792483514Gzglm:localhost
16	!YvivtdTtsTAmNnsRUw:localhost	$154792484415abNlG:localhost
17	!lxLGrxbEpguUZULoSC:localhost	$154792488216AbRES:localhost
18	!lxLGrxbEpguUZULoSC:localhost	$154792488217OnxTZ:localhost
19	!lxLGrxbEpguUZULoSC:localhost	$154792488218BUaoQ:localhost
20	!lxLGrxbEpguUZULoSC:localhost	$154792488219bruaB:localhost
21	!lxLGrxbEpguUZULoSC:localhost	$154792488220dvrBE:localhost
22	!lxLGrxbEpguUZULoSC:localhost	$154792488221gUPQT:localhost
23	!lxLGrxbEpguUZULoSC:localhost	$154792488222ZBqEn:localhost
24	!lxLGrxbEpguUZULoSC:localhost	$154792490923tISso:localhost
25	!tHjklMrpyrzHaqkxRt:localhost	$154792492924bdmxc:localhost
26	!tHjklMrpyrzHaqkxRt:localhost	$154792492925JZWbo:localhost
27	!tHjklMrpyrzHaqkxRt:localhost	$154792493026cBNiO:localhost
28	!tHjklMrpyrzHaqkxRt:localhost	$154792493027Gtrdl:localhost
29	!tHjklMrpyrzHaqkxRt:localhost	$154792493028JotEC:localhost
30	!tHjklMrpyrzHaqkxRt:localhost	$154792493029TiWmR:localhost
31	!tHjklMrpyrzHaqkxRt:localhost	$154792493030llprg:localhost
32	!DwnsPKUkFrUbPENRUr:localhost	$154792507633FUQML:localhost
33	!DwnsPKUkFrUbPENRUr:localhost	$154792514935gxWdL:localhost
\.


--
-- Data for Name: state_groups_state; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.state_groups_state (state_group, room_id, type, state_key, event_id) FROM stdin;
1	!YvivtdTtsTAmNnsRUw:localhost	m.room.create		$15479247500OKKlI:localhost
2	!YvivtdTtsTAmNnsRUw:localhost	m.room.member	@user1:localhost	$15479247501iUNIP:localhost
3	!YvivtdTtsTAmNnsRUw:localhost	m.room.power_levels		$15479247502PzwLU:localhost
4	!YvivtdTtsTAmNnsRUw:localhost	m.room.join_rules		$15479247503HdRXi:localhost
5	!YvivtdTtsTAmNnsRUw:localhost	m.room.history_visibility		$15479247504DWCIT:localhost
6	!YvivtdTtsTAmNnsRUw:localhost	m.room.guest_access		$15479247505lMKFc:localhost
7	!YvivtdTtsTAmNnsRUw:localhost	m.room.member	@riot-bot:matrix.org	$15479247506alxoD:localhost
8	!DwnsPKUkFrUbPENRUr:localhost	m.room.create		$15479248177pgEuD:localhost
9	!DwnsPKUkFrUbPENRUr:localhost	m.room.member	@user1:localhost	$15479248178PDnSR:localhost
10	!DwnsPKUkFrUbPENRUr:localhost	m.room.power_levels		$15479248189maFVd:localhost
11	!DwnsPKUkFrUbPENRUr:localhost	m.room.join_rules		$154792481810eHTrj:localhost
12	!DwnsPKUkFrUbPENRUr:localhost	m.room.history_visibility		$154792481811UJmBV:localhost
13	!DwnsPKUkFrUbPENRUr:localhost	m.room.guest_access		$154792481812FTgOr:localhost
14	!DwnsPKUkFrUbPENRUr:localhost	m.room.name		$154792481813sscwS:localhost
15	!DwnsPKUkFrUbPENRUr:localhost	m.room.related_groups		$154792483514Gzglm:localhost
16	!YvivtdTtsTAmNnsRUw:localhost	m.room.member	@user1:localhost	$154792484415abNlG:localhost
17	!lxLGrxbEpguUZULoSC:localhost	m.room.create		$154792488216AbRES:localhost
18	!lxLGrxbEpguUZULoSC:localhost	m.room.member	@user1:localhost	$154792488217OnxTZ:localhost
19	!lxLGrxbEpguUZULoSC:localhost	m.room.power_levels		$154792488218BUaoQ:localhost
20	!lxLGrxbEpguUZULoSC:localhost	m.room.join_rules		$154792488219bruaB:localhost
21	!lxLGrxbEpguUZULoSC:localhost	m.room.history_visibility		$154792488220dvrBE:localhost
22	!lxLGrxbEpguUZULoSC:localhost	m.room.guest_access		$154792488221gUPQT:localhost
23	!lxLGrxbEpguUZULoSC:localhost	m.room.name		$154792488222ZBqEn:localhost
24	!lxLGrxbEpguUZULoSC:localhost	m.room.related_groups		$154792490923tISso:localhost
25	!tHjklMrpyrzHaqkxRt:localhost	m.room.create		$154792492924bdmxc:localhost
26	!tHjklMrpyrzHaqkxRt:localhost	m.room.member	@user2:localhost	$154792492925JZWbo:localhost
27	!tHjklMrpyrzHaqkxRt:localhost	m.room.power_levels		$154792493026cBNiO:localhost
28	!tHjklMrpyrzHaqkxRt:localhost	m.room.join_rules		$154792493027Gtrdl:localhost
29	!tHjklMrpyrzHaqkxRt:localhost	m.room.history_visibility		$154792493028JotEC:localhost
30	!tHjklMrpyrzHaqkxRt:localhost	m.room.guest_access		$154792493029TiWmR:localhost
31	!tHjklMrpyrzHaqkxRt:localhost	m.room.member	@riot-bot:matrix.org	$154792493030llprg:localhost
32	!DwnsPKUkFrUbPENRUr:localhost	m.room.member	@user2:localhost	$154792507633FUQML:localhost
33	!DwnsPKUkFrUbPENRUr:localhost	m.room.member	@user2:localhost	$154792514935gxWdL:localhost
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
2	!YvivtdTtsTAmNnsRUw:localhost	$15479247500OKKlI:localhost
3	!YvivtdTtsTAmNnsRUw:localhost	$15479247501iUNIP:localhost
4	!YvivtdTtsTAmNnsRUw:localhost	$15479247502PzwLU:localhost
5	!YvivtdTtsTAmNnsRUw:localhost	$15479247503HdRXi:localhost
6	!YvivtdTtsTAmNnsRUw:localhost	$15479247504DWCIT:localhost
7	!YvivtdTtsTAmNnsRUw:localhost	$15479247505lMKFc:localhost
8	!DwnsPKUkFrUbPENRUr:localhost	$15479248177pgEuD:localhost
9	!DwnsPKUkFrUbPENRUr:localhost	$15479248178PDnSR:localhost
10	!DwnsPKUkFrUbPENRUr:localhost	$15479248189maFVd:localhost
11	!DwnsPKUkFrUbPENRUr:localhost	$154792481810eHTrj:localhost
12	!DwnsPKUkFrUbPENRUr:localhost	$154792481811UJmBV:localhost
13	!DwnsPKUkFrUbPENRUr:localhost	$154792481812FTgOr:localhost
14	!DwnsPKUkFrUbPENRUr:localhost	$154792481813sscwS:localhost
15	!DwnsPKUkFrUbPENRUr:localhost	$154792483514Gzglm:localhost
16	!YvivtdTtsTAmNnsRUw:localhost	$154792484415abNlG:localhost
17	!lxLGrxbEpguUZULoSC:localhost	$154792488216AbRES:localhost
18	!lxLGrxbEpguUZULoSC:localhost	$154792488217OnxTZ:localhost
19	!lxLGrxbEpguUZULoSC:localhost	$154792488218BUaoQ:localhost
20	!lxLGrxbEpguUZULoSC:localhost	$154792488219bruaB:localhost
21	!lxLGrxbEpguUZULoSC:localhost	$154792488220dvrBE:localhost
22	!lxLGrxbEpguUZULoSC:localhost	$154792488221gUPQT:localhost
23	!lxLGrxbEpguUZULoSC:localhost	$154792488222ZBqEn:localhost
24	!lxLGrxbEpguUZULoSC:localhost	$154792490923tISso:localhost
25	!tHjklMrpyrzHaqkxRt:localhost	$154792492924bdmxc:localhost
26	!tHjklMrpyrzHaqkxRt:localhost	$154792492925JZWbo:localhost
27	!tHjklMrpyrzHaqkxRt:localhost	$154792493026cBNiO:localhost
28	!tHjklMrpyrzHaqkxRt:localhost	$154792493027Gtrdl:localhost
29	!tHjklMrpyrzHaqkxRt:localhost	$154792493028JotEC:localhost
30	!tHjklMrpyrzHaqkxRt:localhost	$154792493029TiWmR:localhost
31	!DwnsPKUkFrUbPENRUr:localhost	$154792501831ATytk:localhost
32	!DwnsPKUkFrUbPENRUr:localhost	$154792503032kwMJH:localhost
33	!DwnsPKUkFrUbPENRUr:localhost	$154792507633FUQML:localhost
34	!DwnsPKUkFrUbPENRUr:localhost	$154792514935gxWdL:localhost
35	!DwnsPKUkFrUbPENRUr:localhost	$154792515636GRwRe:localhost
36	!DwnsPKUkFrUbPENRUr:localhost	$154792516437BJyyo:localhost
37	!DwnsPKUkFrUbPENRUr:localhost	$154792518138HlGib:localhost
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
@user1:localhost	DZEFOEKZYR	1547856000000
@user1:localhost	HBSKQKGJTX	1547856000000
@user2:localhost	WZGSJQWHEI	1547856000000
\.


--
-- Data for Name: user_directory; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory (user_id, room_id, display_name, avatar_url) FROM stdin;
@user1:localhost	!DwnsPKUkFrUbPENRUr:localhost	user1	\N
@user2:localhost	!tHjklMrpyrzHaqkxRt:localhost	user2	\N
\.


--
-- Data for Name: user_directory_search; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory_search (user_id, vector) FROM stdin;
@user1:localhost	'localhost':2 'user1':1A,3B
@user2:localhost	'localhost':2 'user2':1A,3B
\.


--
-- Data for Name: user_directory_stream_pos; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_directory_stream_pos (lock, stream_id) FROM stdin;
X	34
\.


--
-- Data for Name: user_filters; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_filters (user_id, filter_id, filter_json) FROM stdin;
user1	0	\\x7b22726f6f6d223a7b227374617465223a7b226c617a795f6c6f61645f6d656d62657273223a747275657d7d7d
user2	0	\\x7b22726f6f6d223a7b227374617465223a7b226c617a795f6c6f61645f6d656d62657273223a747275657d7d7d
user1	1	\\x7b22726f6f6d223a7b2274696d656c696e65223a7b226c696d6974223a31307d7d7d
user2	1	\\x7b22726f6f6d223a7b2274696d656c696e65223a7b226c696d6974223a31307d7d7d
\.


--
-- Data for Name: user_ips; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.user_ips (user_id, access_token, device_id, ip, user_agent, last_seen) FROM stdin;
@user1:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEB1c2VyMTpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBXa3pzVzhuTlZVbnhONkI3CjAwMmZzaWduYXR1cmUg8ZPiEzFO-7954suYD8UQRvI52-AQ9az7TYfJ3FFNHyIK	HBSKQKGJTX	::ffff:172.30.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.92 Safari/537.36	1547924875268
@user1:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEB1c2VyMTpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSAuYXFXLl5mUWFzajZWWm9fCjAwMmZzaWduYXR1cmUgp-mt0uZgGfYKIdmKNJy_9UT-r78ArZmUU9ei-ynIWGcK	DZEFOEKZYR	::ffff:172.30.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.92 Safari/537.36	1547924951830
@user1:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEB1c2VyMTpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSAuYXFXLl5mUWFzajZWWm9fCjAwMmZzaWduYXR1cmUgp-mt0uZgGfYKIdmKNJy_9UT-r78ArZmUU9ei-ynIWGcK	DZEFOEKZYR	::ffff:172.30.0.4		1547924992328
@user2:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEB1c2VyMjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSAtUmR4XzJDQUFXaXdDNCpzCjAwMmZzaWduYXR1cmUgAfHRNSJ9c0dYCzEjg1MuMDkNjUbFM9bIHbEW9R1xMgsK	WZGSJQWHEI	::ffff:172.30.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.92 Safari/537.36	1547925056608
@user1:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEB1c2VyMTpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBORzBINlZ5QiNVODdsOm9fCjAwMmZzaWduYXR1cmUgGBYB0ctrWDLNFKZaRBLpaH4eYOgjrctaMTgT8TEaRPUK	IQFCTAEHOC	::ffff:172.30.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.92 Safari/537.36	1547925060780
@user2:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEB1c2VyMjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBaMkY5QiM9Y0JGSTpCcCM7CjAwMmZzaWduYXR1cmUgjuACnNh8k3chc2EchVVDjmkI9X1tXKrk03VmuXW1yUwK	SZDGWSGKHC	::ffff:172.30.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.92 Safari/537.36	1547925142544
@user2:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEB1c2VyMjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBkczZraE0qTjVMOipsKmduCjAwMmZzaWduYXR1cmUgge-PObH-j2PX7A-mKSn6YN8FsoXu2PGUaoI4CK3N_t0K	IJWYZRUMUD	::ffff:172.30.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.92 Safari/537.36	1547925164547
@user2:localhost	MDAxN2xvY2F0aW9uIGxvY2FsaG9zdAowMDEzaWRlbnRpZmllciBrZXkKMDAxMGNpZCBnZW4gPSAxCjAwMjNjaWQgdXNlcl9pZCA9IEB1c2VyMjpsb2NhbGhvc3QKMDAxNmNpZCB0eXBlID0gYWNjZXNzCjAwMjFjaWQgbm9uY2UgPSBkczZraE0qTjVMOipsKmduCjAwMmZzaWduYXR1cmUgge-PObH-j2PX7A-mKSn6YN8FsoXu2PGUaoI4CK3N_t0K	IJWYZRUMUD	::ffff:172.30.0.4		1547925164592
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
@user1:localhost	$2b$12$I0D3ngPmQa4YaS.ia3tN5uMKwj9px6jkYKb/w3x3g7l5f3zBILDui	1547924749	0	\N	0	\N	\N	\N
@user2:localhost	$2b$12$mCZ8BbTs4L/hsfl5/lBH0.rgeq4h8sY7xL8t/loFj1xpREQOVLR4u	1547924929	0	\N	0	\N	\N	\N
\.


--
-- Data for Name: users_in_public_rooms; Type: TABLE DATA; Schema: public; Owner: synapse
--

COPY public.users_in_public_rooms (user_id, room_id) FROM stdin;
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
@user2:localhost	@user1:localhost	!DwnsPKUkFrUbPENRUr:localhost	t
@user1:localhost	@user2:localhost	!DwnsPKUkFrUbPENRUr:localhost	t
\.


--
-- Name: state_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: synapse
--

SELECT pg_catalog.setval('public.state_group_id_seq', 33, true);


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

