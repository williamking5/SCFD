var
	i,j,p,k,m,n:longint;
	q,a:array[0..1000000] of longint;
begin
	readln(n,m);
	for i:=1 to n do
		read(a[i]);
	p:=1;k:=1;
	q[1]:=1;
	write(a[1],' ');
	for i:=2 to n do
	begin
		while (a[q[k]]>a[i]) and (p<=k) do dec(k);
		q[k+1]:=i;
		inc(k);
		if i-q[p]+1>m then inc(p);
		write(a[q[p]],' ');
	end;
	writeln;
end.
