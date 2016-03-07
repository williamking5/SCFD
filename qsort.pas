var
	i,j,k,m,n:longint;
	a:array[1..100000] of longint;
procedure swap(var x,y:longint);
var
	k:longint;
begin
	k:=x;
	x:=y;
	y:=k;
end;
procedure qsort(h,t:longint);
var
	i,j,x:longint;
begin
	x:=a[(h+t) div 2];
	i:=h;j:=t;
	repeat
		while (a[i]<x) do inc(i);
		while (a[j]>x) do dec(j);
		
		if i<=j then
		begin
			swap(a[i],a[j]);
			inc(i);dec(j);
		end;
	until i>j;
	if i<t then qsort(i,t);
	if j>h then qsort(j,h);
end;
begin
	readln(n);
	for i:=1 to n do
		readln(a[i]);
	qsort(1,n);
end.
