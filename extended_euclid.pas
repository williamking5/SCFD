type
	theans=record
		x:longint;
		y:longint;
	end;
var
	d,i,j,m,n:longint;
	k,ans:theans;
function ee(a,b:longint):theans;
begin
	if b=0 then
	begin
		ee.y:=0;
		ee.x:=d div a;
	end
	else
	begin
		k:=ee(b,a mod b);
		ee.x:=k.y;
		ee.y:=k.x-k.y*(a div b);
	end;
end;
begin
	readln(i,j,d);
	ans:=ee(i,j);
	writeln(ans.x,' ',ans.y)
end.
