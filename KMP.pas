var
	i,j,k,m,n:longint;
	a,b:ansistring;
	p:array[0..1000000] of longint;
procedure prex;
var
	i,k,n:longint;
begin
	fillchar(p,sizeof(p),0);
	
	k:=0;p[1]:=0;
	n:=length(b);
	for i:=2 to n do
	begin
		while (k<>0) and (b[k+1]<>b[i]) do
			k:=p[k];
		if b[k+1]=b[i] then inc(k);
		p[i]:=k;
	end;
end;
procedure kmp;
var
	i,j,k,m,n:longint;
begin
	j:=0;
	m:=length(b);
	for i:=1 to length(a) do
	begin
		while (j<>0) and (a[i]<>b[j+1]) do j:=p[j];
		if b[j+1]=a[i] then inc(j);
		if j=m then writeln(i-j+1);
	end;
end;
begin
	readln(a);
	readln(b);
	prex;
	kmp;
end.
