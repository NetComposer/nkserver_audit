%% -------------------------------------------------------------------
%%
%% Copyright (c) 2019 Carlos Gonzalez Florido.  All Rights Reserved.
%%
%% This file is provided to you under the Apache License,
%% Version 2.0 (the "License"); you may not use this file
%% except in compliance with the License.  You may obtain
%% a copy of the License at
%%
%%   http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing,
%% software distributed under the License is distributed on an
%% "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
%% KIND, either express or implied.  See the License for the
%% specific language governing permissions and limitations
%% under the License.
%%
%% -------------------------------------------------------------------

%% @doc Default plugin callbacks
-module(nkserver_audit_callbacks).
-author('Carlos Gonzalez <carlosj.gf@gmail.com>').
-export([status/1, audit_store/3, audit_search/3, audit_aggregate/3]).


-include_lib("nkserver/include/nkserver.hrl").
-include("nkserver_audit.hrl").
%-type continue() :: continue | {continue, list()}.


%% ===================================================================
%% Status Callbacks
%% ===================================================================


status(_) -> continue.


%% @doc
-spec audit_store(nkserver:id(), [nkserver_audit:audit()], nkserver_audit:store_opts()) ->
    ok | {error, term()}.

audit_store(_SrvId, _Audits, _Opts) ->
    {error, no_audit_store_backend}.


%% @doc
-spec audit_search(nkserver:id(), nkserver_audit_search:spec(), nkserver_audit_search:opts()) ->
    {ok, [nkserver_audit:audit()], map()} | {error, term()}.

audit_search(_SrvId, _Spec, _Opts) ->
    {error, no_audit_store_backend}.


%% @doc
-spec audit_aggregate(nkserver:id(), nkserver_audit:agg_type(), nkserver_audit:agg_opts()) ->
    {ok, [nkserver_audit:audit()], map()} | {error, term()}.

audit_aggregate(_SrvId, _Spec, _Opts) ->
    {error, no_audit_store_backend}.
