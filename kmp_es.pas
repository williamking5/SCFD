var
	i,j,k,m,n:longint;
	pi:array[1..100000] of longint;
	p,t:ansistring;
begin
	readln(p);readln(t);
	
	k:=0;pi[1]:=0;
	for i:=2 to length(t) do begin
		while (t[i]<>t[k+1])and(k>0)do k:=pi[k];
		if t[i]=t[k+1] then inc(k);
		pi[i]:=k;
	end;
	
	k:=0;
	for i:=1 to length(p) do begin
		while (p[i]<>t[k+1])and(k>0)do k:=pi[k];
		if p[i]=t[k+1] then inc(k);
		if k=length(t) then begin
			writeln('find:',i-length(t)+1);
			k:=pi[k];
		end;
	end;
end.
