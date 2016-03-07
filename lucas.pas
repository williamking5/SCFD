type
	ans=record
		x:longint;
		y:longint;
	end;
var
	i,j,k,m,n:longint;
	p,dx,dy:longint;
	shiyan:ans;lucas:longint;
	a,b:array[0..100] of longint;
procedure p_digit(xx,yy:longint);
var
	x,y,i:longint;
begin
	fillchar(a,sizeof(a),0);fillchar(b,sizeof(b),0);
	x:=xx;y:=yy;
	i:=0;
	while x>0 do
	begin
		a[i]:=x mod p;
		inc(i);x:=x div p;
	end;
	dx:=i-1;
	i:=0;
	while y>0 do
	begin
		b[i]:=y mod p;
		inc(i);y:=y div p;
	end;
	dy:=i-1;
end;
function ee(a,b:longint):ans;
var
	k:ans;
begin
	if b=0 then
	begin
		ee.x:=1 div a;
		ee.y:=0;
	end
	else
	begin
		k:=ee(b,a mod b);
		ee.x:=k.y;
		ee.y:=k.x-(a div b)*k.y;
	end;
end;
function niyuan(kk:longint):longint;
var
	shiyan:ans;
begin
	shiyan:=ee(kk,-p);
	shiyan.x:=shiyan.x mod p;
	if shiyan.x<0 then shiyan.x:=shiyan.x+p;
	exit(shiyan.x);
end;
function c(x,y:longint):longint;
var
	i,n,m:longint;
begin
	n:=1;
	for i:=1 to x do
		n:=n*i mod p;
	m:=1;
	for i:=1 to y do
		m:=m*i mod p;
	for i:=1 to (x-y) do
		m:=m*i mod p;
	m:=niyuan(m);
	c:=m*n mod p;
end;
begin
	readln(n,m,p);
	p_digit(n,m);
	if dx>dy then k:=dx else k:=dy;
	lucas:=1;
	for i:=0 to k do
	begin
		if b[i]>a[i] then
		begin
			lucas:=0;
			break;
		end;
		lucas:=lucas*c(a[i],b[i]);
	end;
	writeln(lucas);
end.
