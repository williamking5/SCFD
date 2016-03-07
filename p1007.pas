var
	i,n:longint;
	x,y:array[1..100] of real;
	r,s:real;
begin
	readln(n,r);
	for i:=1 to n do
		readln(x[i],y[i]);
	for i:=1 to n-1 do
		s:=s+sqrt(sqr(x[i]-x[i+1])+sqr(y[i]-y[i+1]));
	s:=s+sqrt(sqr(x[n]-x[1])+sqr(y[n]-y[1]));
	s:=s+2*pi*r;
	writeln(s:0:2);
end.
