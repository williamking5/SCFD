var
	i,j,k,m,n:longint;
	kk,kk1,ans:real;
	x,y:array[0..1000000] of real;
function cross(x1,y1,x2,y2:real):real;
begin
	exit(x1*y2-x2*y1);
end;
function dis(x1,y1,x2,y2:real):real;
begin
	exit(sqrt(sqr(x1-x2)+sqr(y1-y2)));
end;
function max(x,y:real):real;
begin
	if x>=y then exit(x)
	else exit(y);
end;
begin
	readln(n);
	for i:=0 to n-1 do
		readln(x[i],y[i]);
	j:=1;
	ans:=0;
	for i:=0 to n-1 do
	begin
		while true do
		begin
			kk:=abs(cross(x[i mod n]-x[j mod n],y[i mod n]-y[j mod n],x[(i+1) mod n]-x[j mod n],y[(i+1) mod n]-y[j mod n]));
			kk1:=abs(cross(x[i mod n]-x[(j+1) mod n],y[i mod n]-y[(j+1) mod n],x[(i+1) mod n]-x[(j+1) mod n],y[(i+1) mod n]-y[(j+1) mod n]));
			if kk1>=kk then j:=(j+1) mod n
			else break;
		end;
		kk:=max(dis(x[i mod n],y[i mod n],x[j mod n],y[j mod n]),dis(x[(i+1) mod n],y[(i+1) mod n],x[j mod n],y[j mod n]));
		if ans<kk then ans:=kk
	end;
	writeln(ans);
end.
