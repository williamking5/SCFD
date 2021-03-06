var
	i,j,k,m,n:longint;
	x,y,z,len:longint;
	a,s,min,lazy,fa,satel,sater,left,right:array[1..1000000] of longint;
procedure make(num,ll,rr:longint);
begin
	satel[num]:=ll;
	sater[num]:=rr;
	if ll<>rr then
	begin
		inc(len);
		fa[len]:=num;
		left[num]:=len;
		make(len,ll,(ll+rr) div 2);
		
		inc(len);
		fa[len]:=num;
		right[num]:=len;
		make(len,(ll+rr) div 2+1,rr);
	end;
end;
procedure update_min_sum(p,x:longint);
var
	i:longint;
begin
	i:=fa[p];
	while i<>0 do
	begin
		if min[left[i]]+lazy[left[i]]<min[right[i]]+lazy[right[i]] then
			min[i]:=min[left[i]]+lazy[left[i]]
		else min[i]:=min[right[i]]+lazy[right[i]];
		s[i]:=s[i]+x*(sater[p]-satel[p]+1);
		i:=fa[i];
	end;
end;
procedure downdate(p:longint);
begin
	if satel[p]<>sater[p] then
	begin
		lazy[left[p]]:=lazy[left[p]]+lazy[p];
		lazy[right[p]]:=lazy[right[p]]+lazy[p];
		s[p]:=s[p]+lazy[p]*(sater[p]-satel[p]+1);
		min[p]:=lazy[p]+min[p];
		lazy[p]:=0;
	end;
end;
procedure labe(num,ll,rr,x:longint);
var
	i:longint;
begin
	i:=(ll+rr) div 2;
	if (satel[num]=ll) and (sater[num]=rr) then
	begin
		lazy[num]:=lazy[num]+x;
		update_min_sum(num,x);
	end
	else
	begin
		downdate(num);
		i:=(satel[num]+sater[num]) div 2;
		if ll>i then begin
			labe(right[num],ll,rr,x);exit;end;
		if rr<=i then begin
			labe(left[num],ll,rr,x);exit;end;

		labe(left[num],ll,i,x);
		labe(right[num],i+1,rr,x);
	end;
end;
function sigma(root,ll,rr:longint):longint;
begin
	downdate(root);
	if (satel[root]=ll) and (sater[root]=rr) then
		exit(s[root]+lazy[root]*(sater[root]-satel[root]+1));
	if ll>(satel[root]+sater[root]) div 2 then exit(sigma(right[root],ll,rr));
	if rr<=(satel[root]+sater[root]) div 2 then exit(sigma(left[root],ll,rr));
	exit(sigma(left[root],ll,(satel[root]+sater[root]) div 2)+sigma(right[root],(satel[root]+sater[root]) div 2+1,rr));
end;
function minab(a,b:longint):longint;
begin
	if a<b then exit(a) else
	exit(b);
end;
function getmin(root,ll,rr:longint):longint;
begin
	downdate(root);
	if (satel[root]=ll) and (sater[root]=rr) then
		exit(min[root]+lazy[root]);
	if ll>(satel[root]+sater[root]) div 2 then exit(getmin(right[root],ll,rr));
	if rr<=(satel[root]+sater[root]) div 2 then exit(getmin(left[root],ll,rr));
	exit(minab(getmin(left[root],ll,(satel[root]+sater[root])div 2),getmin(right[root],(satel[root]+sater[root])div 2+1,rr)));
end;
begin
	fillchar(left,sizeof(left),0);
	fillchar(right,sizeof(right),0);
	fillchar(fa,sizeof(fa),0);
	fillchar(lazy,sizeof(lazy),0);
	fillchar(s,sizeof(s),0);
	len:=1;
	
	readln(n);
	make(1,1,n);
	for i:=1 to n do
		readln(a[i]);
	
	for i:=1 to len do
	begin
		if satel[i]=sater[i] then
		begin
			min[i]:=a[satel[i]];
			s[i]:=a[satel[i]];
			update_min_sum(i,s[i]);
		end;
	end;

	close(input);
	close(output);
end.
