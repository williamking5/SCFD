var
	ans,i,j,k,m,n,x,len,s,t:longint;
	pk,pk1:array[1..100] of longint;
	d,prex,pre:array[1..100] of longint;
	w,ps,ps1,pi,pi1,c,f,b,d1:array[1..10000] of longint;
procedure getv1;
var
	i,j:longint;
begin
	len:=0;
	fillchar(pk1,sizeof(pk1),0);
	for i:=1 to m do
	begin
		j:=pk[i];
		while j<>0 do
		begin
			if f[j]<c[j] then begin
				inc(len);
				ps1[len]:=pk1[i];
				pk1[i]:=len;
				pi1[len]:=pi[j];
				w[len]:=b[j];
				d1[len]:=j;
			end;
			if f[j]>0 then begin
				inc(len);
				ps1[len]:=pk1[pi[j]];
				pk1[pi[j]]:=len;
				pi1[len]:=i;
				w[len]:=-b[j];
				d1[len]:=j;
			end;
			j:=ps[j];
		end;
	end;
end;
procedure spfa(s:longint);
var
	i,j,p,k,kk:longint;
	q:array[1..1000] of longint;
	v:array[1..100] of 0..1;
begin
	for i:=1 to n do
		d[i]:=maxint;
	fillchar(v,sizeof(v),0);
	fillchar(prex,sizeof(prex),0);
	fillchar(pre,sizeof(pre),0);
	d[s]:=0;
	q[1]:=s;p:=1;k:=1;v[s]:=1;
	while true do begin
		kk:=k;
		while p<=k do begin
			j:=pk1[q[p]];
			while j<>0 do
			begin
				if d[pi1[j]]>d[q[p]]+w[j] then begin
					d[pi1[j]]:=d[q[p]]+w[j];
					prex[pi1[j]]:=d1[j];
					pre[pi1[j]]:=q[p];
					if v[pi1[j]]=0 then begin
						inc(kk);
						if kk>1000 then kk:=1;
						q[kk]:=pi1[j];
						v[pi1[j]]:=1;
					end;
				end;
				j:=ps1[j];
			end;
			v[q[p]]:=0;
			inc(p);if p>1000 then p:=1;
		end;
		if k=kk then break;
		k:=kk;
	end;
end;
function cal(s,t:longint):longint;
var
	i,j,min,ans:longint;
begin
	getv1;
	spfa(s);
	if d[t]=maxint then exit(0);
	i:=t;
	min:=maxint;
	while prex[i]<>0 do begin
		if (c[prex[i]]>f[prex[i]]) and (min>c[prex[i]]-f[prex[i]]) then min:=c[prex[i]]-f[prex[i]]
		else if min>c[prex[i]] then min:=c[prex[i]];
		i:=pre[i];
	end;
	i:=t;
	while i<>s do begin
		if (c[prex[i]]>f[prex[i]]) then inc(f[prex[i]],min)
		else dec(f[prex[i]],min);
		i:=pre[i];
	end;
	exit(d[t]*min);
end;
begin
	readln(n,tt,k);
	m:=0;
	fillchar(pk,sizeo(pk),0);
	fillchar(f,sizeof(f),0);
	for i:=1 to n-1 do begin
		inc(m);
		ps[m]:=pk[i];
		pi[m]:=i+1;
		pk[i]:=m;
		c[m]:=k;
		b[m]:=0;
	end;
	for i:=1 to n do begin
		readln(x,y,z);
		inc(m);
		ps[m]:=pk[x];
		pi[m]:=y;
		pk[x]:=m;
		c[m]:=1;
		b[m]:=-z;
	end;
end.
