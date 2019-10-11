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

%% @doc Default callbacks for plugin definitions
-module(nkserver_audit_plugin).
-author('Carlos Gonzalez <carlosj.gf@gmail.com>').
-export([plugin_deps/0, plugin_start/3, plugin_cache/3]).

-include("nkserver_audit.hrl").
-include_lib("nkserver/include/nkserver.hrl").


%% ===================================================================
%% Plugin Callbacks
%% ===================================================================


%% @doc 
plugin_deps() ->
	[].


%% @doc
plugin_start(SrvId, _Config, _Service) ->
	case nkserver_audit_app:get(activate) of
		true ->
			lager:info("NkSERVER AUDIT starting sender (~s)", [SrvId]),
			Spec = #{
				id => SrvId,
				start => {nkserver_audit_sender, start_link, [SrvId]},
				restart => permanent,
				shutdown => 5000,
				type => worker,
				modules => [nkserver_audit_sender]
			},
			case nkserver_workers_sup:update_child2(SrvId, Spec, #{}) of
				{ok, _, _Pid} ->
					ok;
				{error, Error} ->
					{error, Error}
			end;
		false ->
			lager:info("NkSERVER AUDIT not activated (~s)", [SrvId]),
			ok
	end.


%% @doc
plugin_cache(_Id, Config, _Service) ->
	Syntax = #{audit_srv => atom},
	case nklib_syntax:parse(Config, Syntax) of
		{ok, #{audit_srv:=AuditSrv}, _} ->
			case nkserver_audit_app:get(activate) of
				true ->
					{ok, #{audit_srv => AuditSrv}};
				false ->
					ok
			end;
		_ ->
			ok
	end.
