const
	tot=200000;
var
	i,j,k,m,n:longint;
	st:array[1..tot] of longint;
	w:array[1..tot] of longint;
	ptb:array[1..tot] of longint;
	link:array[1..tot] of longint;
	d,q,v:array[1..tot] of longint;
	kk,pp,p,a,b:longint;
begin
	readln(n,m);
	fillchar(st,sizeof(st),0);
	fillchar(w,sizeof(w),0);
	fillchar(ptb,sizeof(ptb),0);
	fillchar(link,sizeof(link),0);
	
	for i:=1 to m do
	begin
		readln(a,b,w[i]);
		link[i]:=st[a];
		st[a]:=i;ptb[i]:=b;
	end;
	
	fillchar(q,sizeof(q),0);
	fillchar(v,sizeof(v),0);
	for i:=2 to n do
		d[i]:=maxlongint;
	q[1]:=1;v[1]:=1;p:=1;k:=1;d[1]:=0;

	while true do
	begin
		kk:=k;
		
		repeat
			j:=st[q[p]];
			while j<>0 do
			begin
				if d[ptb[j]]>d[q[p]]+w[j] then
				begin
					d[ptb[j]]:=d[q[p]]+w[j];
					if v[ptb[j]]=0 then
					begin
						inc(kk);
						if kk>tot then kk:=1;
							q[kk]:=ptb[j];
						v[ptb[j]]:=1;
					end;
				end;
				j:=link[j];
			end;
			
			v[q[p]]:=0;
			inc(p);
			if p>tot then p:=1;
		until p=k;

		if kk=k then break;
		k:=kk;
		inc(p);if p>tot then p:=1;
	end;

	for i:=1 to n do
		write(d[i],' ');writeln;
end.
