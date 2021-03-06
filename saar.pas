var
	i,j,k,m,n:longint;
	s:ansistring;
	tmp:array[1..131072,0..2] of longint;
	rank:array[1..131072] of longint;
procedure swap(var a,b:longint);
var
	k:longint;
begin
	k:=a;a:=b;b:=k;
end;
procedure sort(h,t:longint);
var
	i,j,x,y:longint;
begin
	i:=h;j:=t;
	x:=tmp[(h+t)div 2][0];
	y:=tmp[(h+t)div 2][1];
	repeat
		while (tmp[i][0]<x)or((tmp[i][0]=x)and(tmp[i][1]<y)) do inc(i);
		while (tmp[j][0]>x)or((tmp[j][0]=x)and(tmp[j][1]>y)) do dec(j);
		if i<=j then begin
			swap(tmp[i][0],tmp[j][0]);
			swap(tmp[i][1],tmp[j][1]);
			swap(tmp[i][2],tmp[j][2]);
			inc(i);dec(j);
		end;
	until i>j;
	if j>h then sort(h,j);
	if i<t then sort(i,t);
end;
procedure getrank;
var
	i,j:longint;
begin
	fillchar(tmp,sizeof(tmp),0);
	for i:=1 to n do
	begin
		tmp[i][0]:=ord(s[i]);
		tmp[i][2]:=i;
	end;
	sort(1,n);
	rank[tmp[1][2]]:=1;
	for i:=2 to n do
		if (tmp[i][0]=tmp[i-1][0])and(tmp[i][1]=tmp[i-1][1]) then rank[tmp[i][2]]:=rank[tmp[i-1][2]]
		else rank[tmp[i][2]]:=i;
	
	k:=1;
	while true do begin
		for i:=1 to n do begin
			tmp[i][0]:=rank[i];
			tmp[i][1]:=rank[i+k];
			tmp[i][2]:=i;
		end;
		sort(1,n);
		rank[tmp[1][2]]:=1;
		for i:=2 to n do
			if (tmp[i][0]=tmp[i-1][0])and(tmp[i][1]=tmp[i-1][1]) then rank[tmp[i][2]]:=rank[tmp[i-1][2]]
			else rank[tmp[i][2]]:=i;
		if k>n then break;
		k:=k*2;
	end;
end;
begin
	readln(s);
	n:=length(s);
	getrank;
	for i:=1 to n do writeln(rank[i]);
end.
