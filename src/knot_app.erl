-module(knot_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	case knot_sup:start_link() of
		{ok, Pid} ->
			Dispatch = cowboy_router:compile([
				{'_', [
					{"/",           knot_page,        index},
					{"/ws/",        knot_msg_handler, #{}},
					%Static file handlers
					{"/js/[...]",   cowboy_static, {priv_dir, knot, "js/"}},
					{"/css/[...]",  cowboy_static, {priv_dir, knot, "css/"}},
					{"/font/[...]", cowboy_static, {priv_dir, knot, "font/"}},
					{"/img/[...]",  cowboy_static, {priv_dir, knot, "img/"}}
				]}
			]),
			{ok, _} = cowboy:start_http(http, 25, [{ip, {127,0,0,1}}, {port, 8080}],
							[{env, [{dispatch, Dispatch}]}]),
			{ok, Pid}
	end.

stop(_State) ->
	ok.
