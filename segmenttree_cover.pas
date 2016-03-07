type
	treepoint=record
		l:longint;r:longint;left:longint;right:longint;fa:longint;cover:longint;
	end;
var
	i,j,k,m,n:longint;
	x,y,z,len:longint;
	tree:array[1..1000000] of treepoint;
procedure build(root,ll,rr:longint);
begin
	tree[root].l:=ll;
	tree[root].r:=rr;
	tree[root].cover:=0;
	if ll<>rr then
	begin
		inc(len);
		tree[len].fa:=root;
		tree[root].left:=len;
		build(len,ll,(ll+rr) div 2);
		inc(len);
		tree[len].fa:=root;
		tree[root].right:=len;
		build(len,(ll+rr)div 2+1,rr);
	end;
end;
procedure labe(root,ll,rr,x:longint);
begin
	if (tree[root].l=ll) and (tree[root].r=rr) then inc(tree[root].cover,x)
	else
	begin
		if ll>(tree[root].l+tree[root].r) div 2 then begin
			labe(tree[root].right,ll,rr,x);exit;end;
		if rr<=(tree[root].l+tree[root].r) div 2 then begin
			labe(tree[root].left,ll,rr,x);exit;end;
		labe(tree[root].left,ll,(tree[root].l+tree[root].r) div 2,x);
		labe(tree[root].right,(tree[root].l+tree[root].r) div 2+1,rr,x);
	end;
end;
function count_h(root:longint):longint;
begin
	if tree[root].cover>0 then exit(tree[root].r-tree[root].l+1)
	else
	begin
		if tree[root].l=tree[root].r then exit(0);
		exit(count_h(tree[root].left)+count_h(tree[root].right));
	end;
end;
function count(root,ll,rr:longint):longint;
begin
	if (tree[root].l=ll) and (tree[root].r=rr) then
		exit(count_h(root))
	else
	begin
		if ll>(tree[root].l+tree[root].r) div 2 then exit(count(tree[root].right,ll,rr));
		if rr<=(tree[root].l+tree[root].r) div 2 then exit(count(tree[root].left,ll,rr));
		
		exit(count(tree[root].left,ll,(tree[root].l+tree[root].r)div 2)+count(tree[root].right,(tree[root].l+tree[root].r) div 2+1,rr));
	end;
end;
begin
	readln(n,m);
	fillchar(tree,sizeof(tree),0);
	len:=1;
	build(1,0,n);
	
	for i:=1 to m do
	begin
		readln(x,y,z);
		labe(1,x,y,z);
	end;
	
	writeln(count(1,1,5));
end.
