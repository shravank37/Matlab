clear all
clc
% ORI=xlsread('C:\Users\shravan\Desktop\RESULTS_FINAL\Elastic Results\TEXTURES ALL\Elastic_Textures_All\pref_ori_all.xlsx');
ORI=xlsread('C:\Users\shravan\Desktop\Probability Distributions\Elastic\Textures_138_200\pref_ori_all.xlsx');
path1 = 'C:\Users\shravan\Desktop\Probability Distributions\Elastic\Textures_138_200\Euler_0';
path2 = 'C:\Users\shravan\Desktop\Probability Distributions\Elastic\Textures_138_200\Euler_';
zs = [0;0;1];
bin_size = 0.001;
nMoments = 4;
for j=1:63
    if (j<0)
        P1 = sprintf('%s%d.xlsx',path1,j);
    else
        P1 = sprintf('%s%d.xlsx',path2,j);
    end   
    EulerFinal = xlsread(P1);

    xa = ORI(j,1:3); % The vector along which projection is required (need not be a unit vector)
    nGrains=max(size(EulerFinal));
    XA = (1/norm(xa))*xa';   %% Direction along which the projection is required
    d = XA(1); e=XA(2);
    a = (-e/sqrt(d*d+e*e));
    b = (d/sqrt(d*d+e*e));
    YA = [a;b;0]; % This vector is perpendicular to 'XA' (both XA and YA are contained in the same plane as the 2 preferred orientations)
    for i=1:nGrains
        x = EulerFinal(i,1);        y = EulerFinal(i,2);        z = EulerFinal(i,3);
        c1 = cos(x);        c2 = cos(y);        c3 = cos(z);        
        s1 = sin(x);        s2 = sin(y);        s3 = sin(z);

        R=[c1*c3-c2*s1*s3  -c1*s3-c2*c3*s1  s1*s2;
           c3*s1+c1*c2*s3   c1*c2*c3-s1*s3 -c1*s2;
                    s2*s3            c3*s2    c2];        
        qp = R*zs;        q = qp/norm(qp);
        proj1(i) = q'*XA;        proj2(i) = q'*YA;  
    end      
    %% Finding the moments of the distribution of projection         
       [bin_mean,num_frac] = func_prob_distribution(bin_size,abs(proj1),max(size(proj1)));      
        mean = (bin_mean*num_frac');
        for k=2:nMoments
            M(k,1) = ((bin_mean-mean).^k)*num_frac';
        end            
        R1(j,1:nMoments)=[mean (M(2:nMoments,1))'];
      
        C1 = (1/nGrains)*(sum(abs(proj1))) % Normalized sum of projectrions along 'XA'
      %C2 = (1/nGrains)*(sum(abs(proj2))) % Normalized sum of projectrions along 'YA'

    xlsappend('C:\Users\shravan\Desktop\proj_Moments_2.xlsx',R1)
end