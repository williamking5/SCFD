var
	i,j,k,m,n:longint;
	cover,left,right,l,r,fa:array[1..1000000] of longint;
	len,x,y,z:longint;
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
		build(right[root],(ll+rr)div 2+1,rr);
	end;
end;
procedure labe(root,ll,rr,x:longint);
begin
	if (l[root]=ll) and (r[root]=rr) then begin
		inc(cover[root],x);exit;end;
	if ll>(l[root]+r[root]) div 2 then begin
		labe(right[root],ll,rr,x);exit;end;
	if rr<=(l[root]+r[root])div 2 then begin
		labe(left[root],ll,rr,x);exit;end;
	labe(left[root],ll,(l[root]+r[root]) div 2,x);
	labe(right[root],(l[root]+r[root]) div 2+1,rr,x);
end;
function count_h(root:longint):longint;
begin
	if cover[root]>0 then exit(r[root]-l[root]+1);
	if l[root]<>r[root] then exit(count_h(left[root])+count_h(right[root]))
	else exit(0);
end;
function count(root,ll,rr:longint):longint;
begin
	if (l[root]=ll) and (r[root]=rr) then exit(count_h(root));
	if ll>(l[root]+r[root]) div 2 then exit(count(right[root],ll,rr));
	if rr<=(l[root]+r[root]) div 2 then exit(count(left[root],ll,rr));
end;
begin
	readln(n);
	fillchar(cover,sizeof(cover),0);
	fillchar(left,sizeof(left),0);
	fillchar(right,sizeof(right),0);
	fillchar(fa,sizeof(fa),0);
	fillchar(l,sizeof(l),0);
	fillchar(r,sizeof(r),0);
	len:=1;
	build(1,1,n);
	labe(1,1,4,1);
	labe(1,3,6,1);
	labe(1,5,8,1);
	labe(1,3,5,-1);
	labe(1,8,10,1);
	labe(1,1,4,-1);
	writeln(count(1,1,n));
end.
