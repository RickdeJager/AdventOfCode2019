-module(aoc2).

-import(string, [len/1, concat/2, chr/2, substr/3, str/2,
	to_lower/1, to_upper/1]).

-export([main/0]).

main() -> io:fwrite("Hi\n"),
	  step(0, [1,1,1,4,99,5,6,0,99]).
	 % step(0, [99]).

step(Index, Codes) ->
	Opcode = lists:nth(Index+1, Codes),
%	Arg1 = lists:nth(Index+2, Codes),
%	Arg2 = lists:nth(Index+3, Codes),
%	Arg3 = lists:nth(Index+4, Codes),
%	io:fwrite("opcode: ~p, arguments: ~p, ~p, ~p\n", [Opcode, Arg1, Arg2, Arg3]),
%	if Opcode == 1 -> step(Index + 4, add(Index, Codes))
	if Opcode == 1 -> step(Index + 4, add(Index, Codes))
	; Opcode == 2 -> step(Index + 4, mul(Index, Codes))
	; Opcode == 99 -> done(Codes)
	end.
%	add(0, Codes).
%	io:fwrite("result: ~p\n", add(0, Codes)).

add(Index, Codes) ->
	Index1 = lists:nth(Index+2, Codes),
	Index2 = lists:nth(Index+3, Codes),
	Index3 = lists:nth(Index+4, Codes) + 1,
	Arg1 = lists:nth(Index1+1, Codes),
	Arg2 = lists:nth(Index2+1, Codes),
	After = lists:nthtail(Index3, Codes),
	Before = lists:sublist(Codes, 1, Index3-1),
	Result = Arg1 + Arg2,
	%io:fwrite("result: ~p\n", [Result]),
	Before ++ [Result] ++ After.

mul(Index, Codes) ->
	Index1 = lists:nth(Index+2, Codes),
	Index2 = lists:nth(Index+3, Codes),
	Index3 = lists:nth(Index+4, Codes) + 1,
	Arg1 = lists:nth(Index1+1, Codes),
	Arg2 = lists:nth(Index2+1, Codes),
	After = lists:nthtail(Index3, Codes),
	Before = lists:sublist(Codes, 1, Index3-1),
	Result = Arg1 * Arg2,
	%io:fwrite("result: ~p\n", [Result]),
	Before ++ [Result] ++ After.
done(Codes) ->
	io:fwrite("99: result value ~p\n", [lists:nth(1, Codes)]).
