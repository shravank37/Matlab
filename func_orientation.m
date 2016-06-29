% N-Grain Number 
function g = func_orientation(x,y,z)
    c1 = cos(x);
    c2 = cos(y);
    c3 = cos(z);
    s1 = sin(x);
    s2 = sin(y);
    s3 = sin(z);
    g=[c1*c3-c2*s1*s3  -c1*s3-c2*c3*s1  s1*s2;
       c3*s1+c1*c2*s3   c1*c2*c3-s1*s3 -c1*s2;
                s2*s3            c3*s2    c2];
end          