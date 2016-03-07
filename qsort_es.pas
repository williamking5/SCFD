var
	i,j,k,m,n:longint;
	a,b:array[1..100000] of longint;
function compare(xx,yy:longint):shortint;
begin
	if a[xx]=a[yy] then
	begin
		if b[xx]=b[yy] then exit(0);
		if b[xx]>b[yy] then exit(1);
		if b[xx]<b[yy] then exit(2);
	end
	else
	begin
		if a[xx]>a[yy] then exit(1);
		if a[xx]<a[yy] then exit(2);
	end;
end;
procedure swap(x,y:longint);
var
	k:longint;
begin
	k:=a[x];a[x]:=a[y];a[y]:=k;
	k:=b[x];b[x]:=b[y];b[y]:=k;
end;
procedure sort(h,t:longint);
var
	i,j,xx,y:longint;
	mid1,mid2:longint;
begin
	i:=h;
	j:=t;
	xx:=(h+t) div 2;
	repeat
		while (a[i]<a[xx]) or ((a[i]=a[xx]) and (b[i]<b[xx])) do inc(i);
		while (a[j]>a[xx]) or ((a[j]=a[xx]) and (b[j]>b[xx])) do dec(j);
		if i<=j then
		begin
			y:=a[i];a[i]:=a[j];a[j]:=y;
			y:=b[i];b[i]:=b[j];b[j]:=y;
			inc(i);dec(j);
		end;
	until i>j;

	if h<j then sort(h,j);
	if i<t then sort(i,t);
end;
begin
	readln(n);
	for i:=1 to n do
		readln(a[i],b[i]);
	sort(1,n);
	for i:=1 to n do
		writeln(a[i],' ',b[i]);
end.
