all:
	test -d deps || rebar get-deps
	rebar compile
	@erl -noshell -pa './deps/eredis/ebin' -pa './ebin' -s nihao start