-module(rsa).

-compile(export_all).

test(Message) ->
    {Private, Public} = make_sig(100),
    {B,N} = Private,
    {A,N} = Public,
    MessageInt = lin:str2int(Message),
    Encrypted = lin:pow(MessageInt, A, N),
    io:format("Encrypted: ~s~n", [lin:int2str(Encrypted)]),
    Decrypted = lin:pow(Encrypted, B, N),
    lin:int2str(Decrypted).

make_sig(Len) ->
    %% generate two <Len> digit prime numbers
    P = primes:make_prime(Len),
    io:format("P = ~p~n", [P]),
    Q = primes:make_prime(Len),
    io:format("Q = ~p~n", [Q]),
    N = P*Q,
    io:format("N = ~p~n", [N]),
    Phi = (P-1)*(Q-1),
    %% now make B such that B < Phi and gcd(B, Phi) = 1
    B = b(Phi),
    io:format("Public key (B) = ~p~n", [B]),
    A = lin:inv(B, Phi),
    io:format("Private key (A) = ~p~n", [A]),
    {{B,N},{A,N}}.

b(Phi) ->
    io:format("Generating a public key B "),
    K = length(integer_to_list(Phi)) - 1,
    B = b(1, K, Phi),
    io:format("~n", []),
    B.

b(Try, K, Phi) ->
    io:format("."),
    B = primes:make(K),
    if 
	B < Phi ->
	    case lin:gcd(B, Phi) of
		1 -> B;
		_ -> b(Try+1, K, Phi)
	    end;
	true ->
	    b(Try, K, Phi)
    end.
