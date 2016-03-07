var
	i,j,k,m,n:longint;
	fa,sate:array[0..1000000] of longint;
	son:array[0..1000000,0..1] of longint;
function leftcheck(p:longint):shortint;
begin
	if son[fa[p],0]=p then exit(0)
	else exit(1);
end;
procedure ronate(x,k:longint);
var
	y,i,j:longint;
begin
	i:=son[x,k];
	y:=fa[x];
	j:=fa[y];
	if j<>0 then son[j,leftcheck(y)]:=x;
		fa[x]:=j;
	son[x,k]:=y;
	fa[y]:=x;
	if i<>0 then fa[i]:=y;
	son[y,k xor 1]:=i;
end;
procedure splay(x:longint);
var
	i,j:longint;
begin
	while true do
	begin
		if fa[x]=0 then exit;
		if fa[fa[x]]=0 then begin
			ronate(x,leftcheck(x) xor 1);exit;
		end;
		i:=leftcheck(x) xor 1;
		j:=leftcheck(fa[x]) xor 1;
		ronate(x,i);
		ronate(x,j);
	end;
end;
procedure insert(root,p,len:longint);
var
	i,j:longint;
begin
	i:=root;
	while true do
	begin
		if p<=sate[i] then begin
			if son[i,0]=0 then begin
				inc(len);
				fa[len]:=i;
				sate[len]:=p;
				son[i,0]:=len;
				exit;
			end
			else i:=son[i,0];
		end
		else begin
			if son[i,1]=0 then begin
				inc(len);
				fa[len]:=i;
				sate[len]:=p;
				son[i,1]:=len;
				exit;
			end
			else i:=son[i,1];
		end;
	end;
end;
function find(root,p:longint):longint;
var
	i,j:longint;
begin
	i:=root;
	while true do
	begin
		if sate[i]=p then exit(i);
		if p<sate[i] then begin
			if son[i,0]<>0 then i:=son[i,0]
			else exit(0);
		end 
		else begin
			if son[i,1]<>0 then i:=son[i,1]
			else exit(0);
		end;
	end;
end;
begin
	fillchar(fa,sizeof(fa),0);
	fillchar(sate,sizeof(sate),0);
	fillchar(son,sizeof(son),0);
	readln(n);
	readln(m);sate[1]:=m;
	for i:=2 to n do
	begin
		readln(m);
		insert(1,m,i-1);
	end;
end.
