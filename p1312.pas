var
	i,j,k,m,n:longint;
	max:longint;
	a,h,t:array[1..200] of longint;
	f:array[1..200,1..200] of longint;
begin
	readln(n);
	for i:=1 to n do
		read(a[i]);
	for i:=1 to n-1 do
	begin
		h[i]:=a[i];
		t[i]:=a[i+1];
	end;
	h[n]:=a[n];
	t[n]:=a[1];
	for i:=n+1 to 2*n-1 do
	begin
		h[i]:=h[i-n];
		t[i]:=t[i-n];
	end;
	
	fillchar(f,sizeof(f),0);
	for j:=2 to n do
	begin
		for i:=1 to 2*n-j do
		begin
			if j=2 then
			begin
				f[i,i+j-1]:=h[i]*h[i+1]*t[i+1];
				continue;
			end;
			max:=0;
			for k:=i to i+j-2 do
				if max<f[i,k]+f[k+1,i+j-1]+h[i]*t[i+j-1]*t[k] then
					max:=f[i,k]+f[k+1,i+j-1]+h[i]*t[i+j-1]*t[k];
			f[i,i+j-1]:=max;
		end;
	end;
	max:=0;
	for i:=1 to n do
		if max<f[i,i+n-1] then max:=f[i,i+n-1];
	writeln(max);
end.
