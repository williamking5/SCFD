var
	i,j,k,m,n:longint;
	a,l,r:array[0..100] of longint;
begin
	readln(n);
	for i:=1 to n do
		read(a[i]);
	m:=0;
	for i:=1 to n do
		m:=m+a[i];
	m:=m div n;
	
	k:=0;
	for i:=1 to n-1 do
	begin
		if a[i]<>m then
		begin
			a[i+1]:=a[i]+a[i+1]-m;	
			a[i]:=m;
			inc(k);
		end;
	end;
	writeln(k);
end.
