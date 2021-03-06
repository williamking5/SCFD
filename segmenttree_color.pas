var
	i,j,k,m,n:longint;
	x,y,z,len:longint;
	cover,lazy,fa,left,right,l,r:array[0..1000000] of longint;
procedure build(root,ll,rr:longint);
begin
	l[root]:=ll;
	r[root]:=rr;
	if ll<>rr then
	begin
		inc(len);fa[len]:=root;
		left[root]:=len;
		build(left[root],ll,(ll+rr) div 2);
		
		inc(len);fa[len]:=root;
		right[root]:=len;
		build(right[root],(ll+rr) div 2+1,rr);
	end;
end;
procedure downdate(root:longint);
begin
	if lazy[root]=-1 then
	begin
		lazy[left[root]]:=-1;
		lazy[right[root]]:=-1;
		lazy[root]:=0;
		cover[root]:=0;
	end;
end;
procedure insert(root,ll,rr:longint);
begin
	if lazy[root]=-1 then downdate(root);
	if cover[root]<>0 then exit;
	
	if (l[root]=ll) and (r[root]=rr) then
	begin
		lazy[root]:=0;
		cover[root]:=1;
	end
	else
	begin
		if ll>(l[root]+r[root]) div 2 then begin
			insert(right[root],ll,rr);exit;end;
		if rr<=(l[root]+r[root]) div 2 then begin
			insert(left[root],ll,rr);exit;end;
		
		insert(left[root],ll,(l[root]+r[root]) div 2);
		insert(right[root],(l[root]+r[root]) div 2+1,rr);
	end;
end;
procedure delete(root,ll,rr:longint);
begin
	if lazy[root]=-1 then exit;
	if (l[root]=ll) and (r[root]=rr) then begin
		cover[root]:=0;
		if ll=rr then exit;
		lazy[left[root]]:=-1;
		lazy[right[root]]:=-1;exit;
	end;
	if cover[root]=1 then
	begin
		cover[root]:=0;
		lazy[left[root]]:=-1;
		lazy[right[root]]:=-1;
		if ll-1>=l[root] then insert(root,l[root],ll-1);
		if r[root]>=rr+1 then insert(root,rr+1,r[root]);exit;
	end;
	if ll>(l[root]+r[root]) div 2 then begin
		delete(right[root],ll,rr);exit;end;
	if rr<=(l[root]+r[root]) div 2 then begin
		delete(left[root],ll,rr);exit;end;
	delete(left[root],ll,(l[root]+r[root]) div 2);
	delete(right[root],(l[root]+r[root]) div 2+1,rr);
end;
function count_h(root:longint):longint;
begin
	if lazy[root]=-1 then exit(0);
	if cover[root]=1 then exit(r[root]-l[root]+1)
	else
	begin
		if r[root]=l[root] then exit(0);
		exit(count_h(left[root])+count_h(right[root]));
	end;
end;
function count(root,ll,rr:longint):longint;
begin
	if lazy[root]=-1 then exit(0);
	if cover[root]=1 then exit(rr-ll+1);
	
	if (ll=l[root]) and (rr=r[root]) then
		exit(count_h(root));
	if ll>(l[root]+r[root]) div 2 then exit(count(right[root],ll,rr));
	if rr<=(l[root]+r[root]) div 2 then exit(count(left[root],ll,rr));
	exit(count(left[root],ll,(l[root]+r[root])div 2)+count(right[root],(l[root]+r[root])div 2+1,rr));
end;
begin
	readln(n);
	fillchar(lazy,sizeof(lazy),0);
	fillchar(l,sizeof(l),0);
	fillchar(r,sizeof(r),0);
	fillchar(left,sizeof(left),0);
	fillchar(right,sizeof(right),0);
	fillchar(fa,sizeof(fa),0);
	len:=1;
	build(1,1,n);
	for i:=1 to n do
	begin
		readln(x,y,z);
		if z=1 then insert(1,x,y);
		if z=-1 then delete(1,x,y);
		if z=2 then writeln(count(1,x,y));
	end;
end.
