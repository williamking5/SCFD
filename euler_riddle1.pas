var
	i,j,k,m,n:longint;
	a:array[1..10000000] of 0..1;
	miu:array[1..10000000] of shortint;
	prime:array[1..10000000] of longint;
begin
	readln(n);
	fillchar(a,sizeof(a),0);
	m:=0;
	for i:=2 to n do
	begin
		if a[i]=0 then
		begin
			inc(m);
			prime[m]:=i;
			miu[i]:=-1;
		end;

		for j:=1 to m do
		begin
			if prime[j]*i>n then break;
			a[prime[j]*i]:=1;
			if i mod prime[j]=0 then
			begin
				miu[i*prime[j]]:=0;
				break;
			end
			else miu[i*prime[j]]:=miu[i]*(-1);
		end;
	end;
	k:=0;
	for i:=2 to n do
		k:=k+abs(miu[i]);writeln(k);
end.
