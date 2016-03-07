const
	eps=10E-7;
var
	i,j,k,m,n:longint;
	a,x,y:array[0..100000] of real;
function compare(xx,yy:longint):shortint;
var
	k:real;
begin
	if a[xx]=a[yy] then
	begin
		if (a[xx]=0) or (a[xx]=1.5) or (a[xx]=2.5) or (a[xx]=3.5) then
			exit(0);
		k:=x[xx]*y[yy]-x[yy]*y[xx];
		if k<0-eps then exit(1);
		if abs(k)<eps then exit(0);
		if k>eps then exit(2);
	end
	else
	begin
		if a[xx]>a[yy] then exit(1)
		else exit(2);
	end;
end;
procedure swap(xx,yy:longint);
var
	k:real;
begin
	k:=x[xx];x[xx]:=x[yy];x[yy]:=k;
	k:=y[xx];y[xx]:=y[yy];y[yy]:=k;
	k:=a[xx];a[xx]:=a[yy];a[yy]:=k;
end;
procedure sort(h,t:longint);
var
	i,j,xx:longint;
begin
	xx:=(h+t) div 2;
	a[0]:=a[xx];x[0]:=x[xx];y[0]:=y[xx];
	i:=h;j:=t;
	repeat
		while compare(i,0)=2 do
			inc(i);
		while compare(j,0)=1 do
			dec(j);
		if i<=j then
		begin
			swap(i,j);
			inc(i);dec(j);
		end;
	until i>j;
	if i<t then sort(i,t);
	if j>h then sort(h,j);
end;
begin
	readln(n);
	for i:=1 to n do
	begin
		readln(x[i],y[i]);
		if (x[i]>0) and (y[i]>0) then a[i]:=1;
		if (x[i]>0) and (y[i]<0) then a[i]:=4;
		if (x[i]<0) and (y[i]>0) then a[i]:=2;
		if (x[i]<0) and (y[i]<0) then a[i]:=3;
		if (x[i]>0) and (y[i]=0) then a[i]:=0;
		if (x[i]=0) and (y[i]>0) then a[i]:=1.5;
		if (x[i]<0) and (y[i]=0) then a[i]:=2.5;
		if (x[i]=0) and (y[i]<0) then a[i]:=3.5;
	end;

	sort(1,n);
	for i:=1 to n do
		writeln(x[i]:0:2,' ',y[i]:0:2);
end.
