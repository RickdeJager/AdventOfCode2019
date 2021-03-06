-module(aoc5).

-import(string, [len/1, concat/2, chr/2, substr/3, str/2,
	to_lower/1, to_upper/1]).

-export([main/0]).

main() -> 
	 step(1, [3,225,1,225,6,6,1100,1,238,225,104,0,1102,67,92,225,1101,14,84,225,1002,217,69,224,101,-5175,224,224,4,224,102,8,223,223,101,2,224,224,1,224,223,223,1,214,95,224,101,-127,224,224,4,224,102,8,223,223,101,3,224,224,1,223,224,223,1101,8,41,225,2,17,91,224,1001,224,-518,224,4,224,1002,223,8,223,101,2,224,224,1,223,224,223,1101,37,27,225,1101,61,11,225,101,44,66,224,101,-85,224,224,4,224,1002,223,8,223,101,6,224,224,1,224,223,223,1102,7,32,224,101,-224,224,224,4,224,102,8,223,223,1001,224,6,224,1,224,223,223,1001,14,82,224,101,-174,224,224,4,224,102,8,223,223,101,7,224,224,1,223,224,223,102,65,210,224,101,-5525,224,224,4,224,102,8,223,223,101,3,224,224,1,224,223,223,1101,81,9,224,101,-90,224,224,4,224,102,8,223,223,1001,224,3,224,1,224,223,223,1101,71,85,225,1102,61,66,225,1102,75,53,225,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,8,226,226,224,102,2,223,223,1005,224,329,1001,223,1,223,1108,677,677,224,1002,223,2,223,1006,224,344,101,1,223,223,1007,226,677,224,102,2,223,223,1005,224,359,101,1,223,223,1007,677,677,224,1002,223,2,223,1006,224,374,101,1,223,223,1108,677,226,224,1002,223,2,223,1005,224,389,1001,223,1,223,108,226,677,224,102,2,223,223,1006,224,404,101,1,223,223,1108,226,677,224,102,2,223,223,1005,224,419,101,1,223,223,1008,677,677,224,102,2,223,223,1005,224,434,101,1,223,223,7,677,226,224,1002,223,2,223,1005,224,449,101,1,223,223,1008,226,226,224,102,2,223,223,1005,224,464,1001,223,1,223,107,226,677,224,1002,223,2,223,1006,224,479,1001,223,1,223,107,677,677,224,102,2,223,223,1005,224,494,1001,223,1,223,1008,226,677,224,102,2,223,223,1006,224,509,1001,223,1,223,1107,677,226,224,102,2,223,223,1005,224,524,101,1,223,223,1007,226,226,224,1002,223,2,223,1006,224,539,1001,223,1,223,107,226,226,224,102,2,223,223,1006,224,554,101,1,223,223,108,677,677,224,1002,223,2,223,1006,224,569,1001,223,1,223,7,226,677,224,102,2,223,223,1006,224,584,1001,223,1,223,8,677,226,224,102,2,223,223,1005,224,599,101,1,223,223,1107,677,677,224,1002,223,2,223,1005,224,614,101,1,223,223,8,226,677,224,102,2,223,223,1005,224,629,1001,223,1,223,7,226,226,224,1002,223,2,223,1006,224,644,1001,223,1,223,108,226,226,224,1002,223,2,223,1006,224,659,101,1,223,223,1107,226,677,224,1002,223,2,223,1006,224,674,101,1,223,223,4,223,99,226]).

step(Index, Codes) ->
	% Last 2 digits
	Opcode = lists:nth(Index, Codes) rem 100,
	if Opcode == 01 -> step(Index + 4, add(Index, Codes))
	; Opcode == 02 -> step(Index + 4, mul(Index, Codes))
	; Opcode == 03 -> step(Index + 2, inp(Index, Codes))
	; Opcode == 04 -> step(Index + 2, out(Index, Codes))
	; Opcode == 05 -> step(jt(Index, Codes), Codes)
	; Opcode == 06 -> step(jf(Index, Codes), Codes)
	; Opcode == 07 -> step(Index + 4, lt(Index, Codes))
	; Opcode == 08 -> step(Index + 4, eq(Index, Codes))
	; Opcode == 99 -> done(Codes)
	; true -> io:fwrite("Found unknown opcode ~p\n", [Opcode])
	end.

get_args(Index, Codes) ->
	Opcode = lists:nth(Index, Codes),
	if Opcode div 1000 == 0 -> 
		   Index2 = lists:nth(Index + 2, Codes) + 1,
		   Arg2 = lists:nth(Index2, Codes);
	true ->
		   Arg2 = lists:nth(Index + 2, Codes)
	end,

	if (Opcode div 100) rem 10 == 0 -> 
		   Index1 = lists:nth(Index + 1, Codes) + 1,
		   Arg1 = lists:nth(Index1, Codes);
	true ->
		   Arg1 = lists:nth(Index + 1, Codes)
	end,
	Index3 = lists:nth(Index + 3, Codes) + 1,
	{Arg1, Arg2, Index3}.

lt(Index, Codes) ->
	{Val1, Val2, Index3} = get_args(Index, Codes),
	After = lists:nthtail(Index3, Codes),
	Before = lists:sublist(Codes, 1, Index3-1),
	if  Val1 < Val2 ->
		   Result = 1
	; true ->
		   Result = 0
	end,
	Before ++ [Result] ++ After.
eq(Index, Codes) ->
	{Val1, Val2, Index3} = get_args(Index, Codes),
	After = lists:nthtail(Index3, Codes),
	Before = lists:sublist(Codes, 1, Index3-1),
	if  Val1 == Val2 ->
		   Result = 1
	; true ->
		   Result = 0
	end,
	Before ++ [Result] ++ After.

jt(Index, Codes) ->
	{Val1, Val2, _} = get_args(Index, Codes),
	if  Val1 == 0 ->
		   Ip = Index + 3
	; true ->
		   Ip = Val2 + 1
	end,
	Ip.

jf(Index, Codes) ->
	{Val1, Val2, _} = get_args(Index, Codes),
	if  Val1 == 0 ->
		   Ip = Val2 + 1
	; true ->
		   Ip = Index + 3
	end,
	Ip.

add(Index, Codes) ->
	{Arg1, Arg2, Index3} = get_args(Index, Codes),
	After = lists:nthtail(Index3, Codes),
	Before = lists:sublist(Codes, 1, Index3-1),
	Result = Arg1 + Arg2,
	Before ++ [Result] ++ After.

mul(Index, Codes) ->
	{Arg1, Arg2, Index3} = get_args(Index, Codes),
	After = lists:nthtail(Index3, Codes),
	Before = lists:sublist(Codes, 1, Index3-1),
	Result = Arg1 * Arg2,
	Before ++ [Result] ++ After.

inp(Index, Codes) ->
	Index1 = lists:nth(Index + 1, Codes) + 1,
	{ok, Term} = io:read("3: Input a value: "),
	After = lists:nthtail(Index1, Codes),
	Before = lists:sublist(Codes, 1, Index1-1),
	Before ++ [Term] ++ After.

out(Index, Codes) ->
	Index1 = lists:nth(Index + 1, Codes) + 1,
	Value = lists:nth(Index1, Codes),
	io:fwrite("4: Value at index ~p is ~p\n", [Index1, Value]),
	Codes.

done(Codes) ->
	io:fwrite("99: result value ~p\n", [lists:nth(1, Codes)]).
