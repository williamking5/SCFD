const
	tot=1000000;
var
	map,num:array[1..1000,1..1000] of longint;
	pi,ps,w,pb:array[1..3000000] of longint;
	p,st,kk,i,j,k,m,n:longint;
	d,q:array[1..1000000] of longint;
	v:array[1..1000000] of 0..1;
begin
	readln(n);
	k:=0;
	for i:=1 to n do
		for j:=1 to i do
		begin
			inc(k);
			read(map[i][j]);
			num[i][j]:=k;
		end;
	fillchar(pi,sizeof(pi),0);
	fillchar(ps,sizeof(ps),0);
	k:=0;
	for i:=n downto 2 do
	begin
		for j:=1 to i do
		begin
			inc(k);
			ps[k]:=pi[num[i][j]];
			pi[num[i][j]]:=k;
			if j=i then begin
			pb[k]:=num[i][1];w[k]:=map[i][1];end
			else begin pb[k]:=num[i][j+1];w[k]:=map[i][j+1];end;
			
			inc(k);
			ps[k]:=pi[num[i][j]];
			pi[num[i][j]]:=k;
			if j=1 then begin
			pb[k]:=num[i][i];w[k]:=map[i][i];end
			else begin pb[k]:=num[i][j-1];w[k]:=map[i][j-1];end;

			inc(k);
			ps[k]:=pi[num[i][j]];
			pi[num[i][j]]:=k;
			if j=i then begin
				pb[k]:=num[i-1][1];w[k]:=map[i-1][1];end
			else begin pb[k]:=num[i-1][j];w[k]:=map[i-1][j];end;

			inc(k);
			ps[k]:=pi[num[i][j]];
			pi[num[i][j]]:=k;
			if j=1 then begin
				pb[k]:=num[i-1][i-1];w[k]:=map[i-1][i-1];end
			else begin pb[k]:=num[i-1][j-1];w[k]:=map[i-1][j-1];end;
		end;
	end;
	
	m:=n*(n+1) div 2;
	fillchar(v,sizeof(v),0);
	fillchar(q,sizeof(q),0);
	for i:=1 to m do d[i]:=maxlongint;
	st:=num[n][1];d[st]:=0;
	q[1]:=st;v[st]:=1;p:=1;k:=1;

	while true do
	begin
		kk:=k;
		repeat
			j:=pi[q[p]];
			while j<>0 do
			begin
				if d[pb[j]]>d[q[p]]+w[j] then
				begin
					d[pb[j]]:=d[q[p]]+w[j];
					if v[pb[j]]=0 then
					begin
						inc(kk);
						if kk>tot then kk:=1;
						q[kk]:=pb[j];
						v[pb[j]]:=1;
					end;
				end;
				j:=ps[j];
			end;
			v[q[p]]:=0;
			inc(p);
			if p>tot then p:=1;
		until k=p;

		if kk=k then break;
		k:=kk;
		inc(p);
		if p>tot then p:=1;
	end;

	writeln(d[1]+map[n][1]);
end.
