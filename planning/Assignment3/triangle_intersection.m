function flag = triangle_intersection(P1, P2)
% triangle_test : returns true if the triangles overlap and false otherwise

%%% All of your code should be between the two lines of stars.
% *******************************************************************
flag = true;

% line intersection
for i = 1:3
    v1 = P1(i, :);
    if (i==3)
        v2 = P1(1, :);
    else
        v2 = P1(i+1, :);
    end
    
    for j=1:3
        v3 = P2(j, :);
        if (j == 3)
            v4 = P2(1, :);
        else
            v4 = P2(j+1, :);
        end
        d = (v4(2)-v3(2))*(v2(1)-v1(1))-(v4(1)-v3(1))*(v2(2)-v1(2));
        u = (v4(1)-v3(1))*(v1(2)-v3(2))-(v4(2)-v3(2))*(v1(1)-v3(1));
        v = (v2(1)-v1(1))*(v1(2)-v3(2))-(v2(2)-v1(2))*(v1(1)-v3(1));
        % parallel
        if(d==0)
            a=(v3(1)-v1(1))/(v2(1)-v1(1));
            b=(v4(1)-v1(1))/(v2(1)-v1(1));
            if(a>=0 && a<=1)
                return
            end
            if(b>=0 && b<=1)
                return
            end
        end
        % not parallel
        if(d<0)
            u = -u;
            v = -v;
            d = -d;
        end
        if(0<=u && u<=d && 0<=v && v<=d)
            return
        end
    end
end

% point in triangle
A = P1(1, :);
B = P1(2, :);
C = P1(3, :);
P = P2(1, :);

v0 = [C(1)-A(1) C(2)-A(2)];
v1 = [B(1)-A(1) B(2)-A(2)];
v2 = [P(1)-A(1) P(2)-A(2)];
%cross = lambda u,v: u[0]*v[1]-u[1]*v[0]
u = v2(1)*v0(2) - v2(2)*v0(1);
v = v1(1)*v2(2) - v1(2)*v2(1);
d = v1(1)*v0(2) - v1(2)*v0(1);
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

v0 = [C(1)-A(1) C(2)-A(2)];
v1 = [B(1)-A(1) B(2)-A(2)];
v2 = [P(1)-A(1) P(2)-A(2)];
%cross = lambda u,v: u[0]*v[1]-u[1]*v[0]
u = v2(1)*v0(2) - v2(2)*v0(1);
v = v1(1)*v2(2) - v1(2)*v2(1);
d = v1(1)*v0(2) - v1(2)*v0(1);
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
