var
	i,j,k,l,m,n:longint;
	b:boolean;
	a:array[1..9,1..9] of longint;
	v:array[1..9] of longint;
begin
	readln(n);
	for i:=1 to n do
	begin
		b:=true;
		for j:=1 to 9 do
			for k:=1 to 9 do
				read(a[j][k]);
		
		for j:=1 to 9 do
		begin
			if b=false then break;
			fillchar(v,sizeof(v),0);
			for k:=1 to 9 do
			begin
				if v[a[j][k]]=1 then
				begin
					writeln('Wrong');
					b:=false;
					break;
				end
				else inc(v[a[j][k]]);
			end;
		end;

		if b=true then
			for j:=1 to 9 do
			begin
				if b=false then break;
				fillchar(v,sizeof(v),0);
				for k:=1 to 9 do
					if v[a[k][j]]=1 then
					begin
						b:=false;
						writeln('Wrong');
						break;
					end
					else inc(v[a[k][j]])
			end;
		if b=true then
		begin
			for j:=1 to 3 do
				for k:=1 to 3 do
				begin
					fillchar(v,sizeof(v),0);
					for l:=(j*3-2) to j*3 do
					begin
						if b=false then break;
						for m:=(k*3-2) to k*3 do
							if v[a[l][m]]=1 then
							begin
								writeln('Wrong');
								b:=false;
								break;
							end
							else inc(v[a[l][m]]);
					end;
				end;
		end;
		if b=true then writeln('Right');
	end;
end.
