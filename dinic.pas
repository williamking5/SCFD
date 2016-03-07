var
	i,j,k,m,n:longint;
	ans,s,t,x,y,z:longint;
	hehe:boolean;
	f,c,c2,c3:array[1..100,1..100] of longint;
function getv3(s,t:longint):boolean;
var
	i,j,p,k,kk:longint;
	q,v:array[1..100] of longint;
begin
	getv3:=true;
	fillchar(v,sizeof(v),0);
	p:=1;k:=1;v[s]:=1;
	q[1]:=s;
	repeat
		kk:=k;
		for i:=p to k do
		begin
			for j:=1 to n do
				if (c2[q[i]][j]<>0) and (v[j]=0) then begin
					inc(kk);
					q[kk]:=j;
					v[j]:=v[q[i]]+1;
				end;
		end;
		p:=k+1;
		k:=kk;
	until p>k;
	if v[t]=0 then exit(false);
	for i:=1 to n do
		for j:=1 to n do
			if (c2[i,j]<>0) and (v[i]+1=v[j]) then c3[i,j]:=c2[i,j];
end;
procedure getv2;
var
	i,j:longint;
begin
	fillchar(c2,sizeof(c2),0);
	for i:=1 to n do
		for j:=1 to n do
			c2[i,j]:=c[i,j];
	for i:=1 to n do
		for j:=1 to n do
		begin
			c2[i,j]:=c2[i,j]-f[i,j];
			c2[j,i]:=c2[j,i]+f[i,j];
		end;
end;
function dfs(s,t:longint):longint;
var
	i,j,p,k,min,ans:longint;
	bb:boolean;
	z:array[1..100] of longint;
begin
	k:=1;z[1]:=s;ans:=0;
	while true do
	begin
		bb:=false;
		for i:=1 to n do
			if c3[s,i]<>0 then begin
				bb:=true;break;
			end;
		if bb=false then break;
		if z[k]=t then begin
			min:=maxint;
			for i:=1 to k-1 do
				if min>c3[z[i],z[i+1]] then min:=c3[z[i],z[i+1]];
			for i:=1 to k-1 do
			begin
				inc(f[z[i],z[i+1]],min);
				dec(c3[z[i],z[i+1]],min);
			end;
			for i:=1 to k do
				if c3[z[i],z[i+1]]=0 then break;
			k:=i;inc(ans,min);
			continue;
		end;
		
		bb:=false;
		for i:=1 to n do
			if c3[z[k],i]<>0 then begin
				bb:=true;
				break;
			end;
		if bb=false then begin
			for i:=1 to n do	c3[z[k],i]:=0;
			for i:=1 to n do	c3[i,z[k]]:=0;
			dec(k);
			continue;
		end;
		inc(k);
		z[k]:=i;
	end;
	exit(ans);
end;
begin
	readln(n,m,s,t);
	for i:=1 to m do
	begin
		readln(x,y,z);
		c[x,y]:=z;
	end;
	fillchar(f,sizeof(f),0);
	ans:=0;
	while true do
	begin
		getv2;
		hehe:=getv3(s,t);
		if hehe=false then break;
		ans:=ans+dfs(s,t);
	end;
	writeln(ans);
end.
