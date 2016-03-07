type
	pointtype=record
		x:real;
		y:real;
		a:real;
		loc:longint;
	end;
const
	eps=10E-6;
var
	i,j,k,m,n,mini:longint;
	min:real;
	kk:pointtype;
	a,p:array[0..100000] of pointtype;
	v:array[0..100000] of 0..1;
	s:array[0..100000] of longint;
function compare(i,j:pointtype):shortint;
var
	k:real;
begin
	compare:=0;
	if i.a>j.a then exit(1);
	k:=i.x*j.y-j.x*i.y;
	if k<0 then exit(1);
	if k>0 then exit(2);
end;
function discom(i,j:pointtype):shortint;
begin
	if sqr(i.x)+sqr(i.y)>sqr(j.x)+sqr(j.y) then exit(2);
	if sqr(i.x)+sqr(i.y)<sqr(j.x)+sqr(j.y) then exit(1);
end;
procedure sort(h,t:longint);
var
	i,ii,j:longint;
	x,k:pointtype;
begin
	x:=p[(h+t) div 2];
	i:=h;
	j:=t;
	repeat
		while (compare(p[i],x)=2)or((compare(p[i],x)=0)and(discom(p[i],x)=2)) do inc(i);
		while (compare(p[j],x)=1)or((compare(p[j],x)=0)and(discom(p[j],x)=1)) do dec(j);
		if i<=j then begin
			k:=p[i];
			p[i]:=p[j];
			p[j]:=k;
			inc(i);
			dec(j);
		end;
	until i>j;
	
	if j>h then sort(h,j);
	if i<t then sort(i,t);
end;
begin
	readln(n);
	for i:=0 to n-1 do
	begin
		readln(a[i].x,a[i].y);
		a[i].loc:=i;
	end;
	
	mini:=0;
	for i:=0 to n-1 do
		if a[i].y<a[mini].y then mini:=i;
	
	for i:=0 to n-1 do
	begin
		p[i].x:=a[i].x-a[mini].x;
		p[i].y:=a[i].y-a[mini].y;
		p[i].loc:=a[i].loc;
	end;
	
	for i:=0 to n-1 do
	begin
		if (p[i].x>0) and (p[i].y=0) then p[i].a:=0;
		if (p[i].x>0) and (p[i].y>0) then p[i].a:=1;
		if (p[i].x=0) and (p[i].y>0) then p[i].a:=1.5;
		if (p[i].x<0) and (p[i].y>0) then p[i].a:=2;
		if (p[i].x<0) and (p[i].y=0) then p[i].a:=2.5;
		if (p[i].x<0) and (p[i].y<0) then p[i].a:=3;
		if (p[i].x=0) and (p[i].y<0) then p[i].a:=3.5;
		if (p[i].x>0) and (p[i].y<0) then p[i].a:=4;
	end;
	kk:=p[mini];
	p[mini]:=p[0];
	p[0]:=kk;
	sort(1,n-1);
	fillchar(v,sizeof(v),0);
	for i:=2 to n-1 do
		if compare(p[i],p[i-1])=0 then v[i]:=1;		
	s[0]:=0;s[1]:=1;s[2]:=2;
	k:=2;
	for i:=3 to n-1 do
	begin
		if v[i]=1 then continue;
		if ((p[s[k-1]].x-p[s[k-2]].x)*(p[s[k]].y-p[s[k-2]].y)-(p[s[k-1]].y-p[s[k-2]].y)*(p[s[k]].x-p[s[k-2]].x))*((p[s[k]].x-p[s[k-1]].x)*(p[i].y-p[s[k-1]].y)-(p[s[k]].y-p[s[k-1]].y)*(p[i].x-p[s[k-1]].x))<0 then begin
			s[k]:=i;
		end
		else begin
			inc(k);
			s[k]:=i;
		end;	
	end;
	
	if ((p[s[k-1]].x-p[s[k-2]].x)*(p[s[k]].y-p[s[k-2]].y)-(p[s[k-1]].y-p[s[k-2]].y)*(p[s[k]].x-p[s[k-2]].x))*((p[s[k]].x-p[s[k-1]].x)*(p[0].y-p[s[k-1]].y)-(p[s[k]].y-p[s[k-1]].y)*(p[0].x-p[s[k-1]].x))<0 then dec(k);
	for i:=0 to k do
		writeln(p[s[i]].x+a[mini].x:0:2,' ',p[s[i]].y+a[mini].y:0:2)
end.
