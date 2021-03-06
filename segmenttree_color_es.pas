var
	i,j,k,m,n:longint;
	cover,lazy,left,right,fa,l,r:array[1..100000] of longint;
	x,y,z,len:longint;
procedure build(root,ll,rr:longint);
begin
	l[root]:=ll;
	r[root]:=rr;
	if ll<>rr then begin
		inc(len);fa[len]:=root;
		left[root]:=len;
		build(left[root],ll,(ll+rr)div 2);
		
		inc(len);fa[len]:=root;
		right[root]:=len;
		build(right[root],(ll+rr) div 2+1,rr);
	end;
end;
procedure downdate(root:longint);
begin
	if lazy[root]=-1 then begin
		lazy[root]:=0;
		cover[root]:=0;
		if l[root]=r[root] then exit;
		lazy[left[root]]:=-1;
		lazy[right[root]]:=-1;
	end;
end;
function insert(root,ll,rr:longint):boolean;
begin
	if lazy[root]=-1 then downdate(root);
	if cover[root]>0 then exit;
	if (l[root]=ll) and (r[root]=rr) then begin
		inc(cover[root]);exit;end;
	if ll>(l[root]+r[root]) div 2+1 then exit(insert(right[root],ll,rr));
	if rr<=(l[root]+r[root]) div 2 then exit(insert(left[root],ll,rr));
	if l[root]=r[root] then exit;
	insert(left[root],ll,(l[root]+r[root])div 2);
	insert(right[root],(l[root]+r[root])div 2+1,rr);
end;
function delete(root,ll,rr:longint):boolean;
begin
	if lazy[root]=-1 then exit;
	if cover[root]>0 then begin
		cover[root]:=0;lazy[root]:=-1;
		if l[root]<=ll-1 then insert(root,l[root],ll-1);
		if rr+1<=r[root] then insert(root,rr+1,r[root]);exit;
	end;
	
	if l[root]=r[root] then begin
		lazy[root]:=-1;exit;end;
	if ll>(l[root]+r[root]) div 2 then exit(delete(right[root],ll,rr));
	if rr<=(l[root]+r[root])div 2 then exit(delete(left[root],ll,rr));
	delete(left[root],ll,(l[root]+r[root])div 2);
	delete(right[root],(l[root]+r[root]) div 2+1,rr);
end;
function count_h(root:longint):longint;
begin
	if lazy[root]=-1 then exit(0);
	if cover[root]>0 then exit(r[root]-l[root]+1);
	if l[root]<>r[root] then exit(count_h(left[root])+count_h(right[root]))
	else exit(0);
end;
function count(root,ll,rr:longint):longint;
begin
	if lazy[root]=-1 then exit(0);
	if cover[root]>0 then exit(rr-ll+1);
	if (l[root]=ll) and (r[root]=rr) then exit(count_h(root));
	if ll>(l[root]+r[root])div 2 then exit(count(right[root],ll,rr));
	if rr<=(l[root]+r[root]) div 2 then exit(count(left[root],ll,rr));
	exit(count(left[root],ll,(l[root]+r[root]) div 2)+count(right[root],(l[root]+r[root])div 2+1,rr));
end;
begin
	readln(n);
	fillchar(cover,sizeof(cover),0);
	fillchar(lazy,sizeof(lazy),0);
	fillchar(left,sizeof(left),0);
	fillchar(right,sizeof(right),0);
	fillchar(fa,sizeof(fa),0);
	fillchar(l,sizeof(l),0);
	fillchar(r,sizeof(r),0);
	len:=1;
	build(1,1,n);
	
	writeln(count(1,1,n));
end.
