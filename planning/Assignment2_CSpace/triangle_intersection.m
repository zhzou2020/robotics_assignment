function flag = triangle_intersection(P1, P2)
% triangle_test : returns true if the triangles overlap and false otherwise

%%% All of your code should be between the two lines of stars.
% *******************************************************************
flag = true;

% line intersection
for i = 1:3
    v1 = P1(i, :);
    v2 = P1(mod(i+1, 3), :);
    for j=1:3
        v3 = P2(j, :);
        v4 = P2(mod(j+1, 3), :);
        d = (v4(1)-v3(1))*(v2(0)-v1(0))-(v4(0)-v3(0))*(v2(1)-v1(1));
        u = (v4(0)-v3(0))*(v1(1)-v3(1))-(v4(1)-v3(1))*(v1(0)-v3(0));
        v = (v2(0)-v1(0))*(v1(1)-v3(1))-(v2(1)-v1(1))*(v1(0)-v3(0));
        if(d<0)
            u = -u;
            v = -v;
            d = -d;
        end
        if(0<=u && u<=d && 0<=v && v<=d)
            return
        end
        % parallel
        if(d==0)
            a=(v3(0)-v1(0))/(v2(0)-v1(0));
            b=(v4(0)-v1(0))/(v2(0)-v1(0));
            if(a>=0 && a<=1)
                return
            end
            if(b>=0 && b<=1)
                return
            end
        end
    end
end

% point in triangle
A = P1(1, :);
B = P1(2, :);
C = P1(3, :);
P = P2(1, :);

v0 = [C(0)-A(0) C(1)-A(1)];
v1 = [B(0)-A(0) B(1)-A(1)];
v2 = [P(0)-A(0) P(1)-A(1)];
%cross = lambda u,v: u[0]*v[1]-u[1]*v[0]
u = v2(0)*v0(1) - v2(1)*v0(0);
v = v1(0)*v2(1) - v1(1)*v2(0);
d = v1(0)*v0(1) - v1(1)*v0(0);
if (d<0)
    u = -u;
    v = -v;
    d = -d;
end
if(u>=0 && v>=0 && (u+v) <= d)
    return
end

A = P2(1, :);
B = P2(2, :);
C = P2(3, :);
P = P1(1, :);

v0 = [C(0)-A(0) C(1)-A(1)];
v1 = [B(0)-A(0) B(1)-A(1)];
v2 = [P(0)-A(0) P(1)-A(1)];
%cross = lambda u,v: u[0]*v[1]-u[1]*v[0]
u = v2(0)*v0(1) - v2(1)*v0(0);
v = v1(0)*v2(1) - v1(1)*v2(0);
d = v1(0)*v0(1) - v1(1)*v0(0);
if (d<0)
    u = -u;
    v = -v;
    d = -d;
end
if(u>=0 && v>=0 && (u+v) <= d)
    return
end

flag = false;
% *******************************************************************
end