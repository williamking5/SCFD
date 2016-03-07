const
	ee=10E-6;
var
	i,j,k,m,n:longint;
	x,y:array[1..4] of real;
	c1,c2:real;ans,b1,b2:boolean;
begin
	for i:=1 to 4 do
		readln(x[i],y[i]);
	
	b1:=false;b2:=false;
	c1:=(x[2]-x[1])*(y[3]-y[1])-(x[3]-x[1])*(y[2]-y[1]);
	c2:=(x[2]-x[1])*(y[4]-y[1])-(y[2]-y[1])*(x[4]-x[1]);
	
	if c1*c2<0 then b1:=true;
	if (abs(c1)<ee) and (abs(c2)>ee) then
		if (x[3]-x[1])*(x[3]-x[2])<=0 then
		begin
			ans:=true;
			writeln(ans);
			halt;
		end;
	if (abs(c1)>ee) and (abs(c2)<ee) then
		if (x[4]-x[1])*(x[4]-x[2])<=0 then
		begin
			ans:=true;
			writeln(ans);
			halt;
		end;

	c1:=(x[4]-x[3])*(y[1]-y[3])-(y[4]-y[3])*(x[1]-x[3]);
	c2:=(x[4]-x[3])*(y[2]-y[3])-(y[4]-y[3])*(x[2]-x[3]);

	if c1*c2<0 then b2:=true;
	if (abs(c1)<ee) and (abs(c2)>ee) then
		if (x[1]-x[3])*(x[1]-x[4])<=0 then
		begin
			ans:=true;
			writeln(ans);
			halt;
		end;
	if (abs(c1)>ee) and (abs(c2)<ee) then
		if (x[2]-x[3])*(x[2]-x[4])<=0 then
		begin
			ans:=true;;
			writeln(ans);
			halt;
		end;
	
	ans:=b1 and b2;
	writeln(ans);
end.
