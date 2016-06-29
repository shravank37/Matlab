clc
clear all
% close all
% EulerFinal=xlsread('C:\Users\shravan\Desktop\Elastic_Textures_All\Euler_67.xlsx');
sheet=dlmread('C:\Users\shravan\Desktop\1 and 2 grains\1 grain\grainTexture.inp');

nGrains=sheet(1,1);
EulerFinal=sheet(2:nGrains+1,2:4);
%a = [90 0 0]; b = [45 45 45];    % These are the two preferred directions
%a = 2.5*a/norm(a); b = 2.5*b/norm(b);
xg = [2 0 0]; yg = [0 2 0];  zg = [0 0 2];
z = [0;0;1];                   % This vector when operated by the orientation matrix results in the direction of the c-axis of the hcp crystal
%% FInding the orientations of all the grains 
for i=1:nGrains
    alpha = EulerFinal(i,1);
    beta  = EulerFinal(i,2);
    gamma = EulerFinal(i,3);       
    R = func_orientation(alpha,beta,gamma);
    zp = R*z;               % This vector gives the orientation of any grain with x,y,z as its Euler angles           
    if (zp(3)<0)
        ori_vec(i,1:3) = (eye(3))*[zp(1);zp(2);zp(3)];    % Applying the inversion symmetry (all)
    else
        ori_vec(i,1:3) = [zp(1);zp(2);zp(3)];
    end
end
%% 
    for i = 1:nGrains
        X(i,1) = ori_vec(i,1);
        Y(i,1) = ori_vec(i,2);
        Z(i,1) = ori_vec(i,3);
    end
        A = [X,Y,Z];
%% Moment of inertia tensor
I = zeros(3,3);
for k = 1:nGrains
    I(1,1) = I(1,1) + A(k,1)*A(k,1);
    I(2,2) = I(2,2) + A(k,2)*A(k,2);
    I(3,3) = I(3,3) + A(k,3)*A(k,3);
    I(1,2) = I(1,2) + A(k,1)*A(k,2);
    I(1,3) = I(1,3) + A(k,1)*A(k,3);
    I(2,3) = I(2,3) + A(k,2)*A(k,3);
end
I(2,1) = I(1,2);
I(3,1) = I(1,3);
I(3,2) = I(2,3);
I = (1/nGrains)*I;
% for i=1:3
%     for j=1:3
%         if(i~=j)
%             I(i,j) = I(i,j);
%         end
%     end
% end

[V,D] = eig(I)   % Eigenvalues and vectors of moment of inertia tensor

pref_ori1 = V(:,1);
pref_ori2 = V(:,2);
% pref_ori3 = V(:,1);
pref_ori3 = cross(pref_ori1,pref_ori2);
quiver3(0,0,0,2,0,0,'r')
hold on
quiver3(0,0,0,0,2,0,'b')
hold on
quiver3(0,0,0,0,0,2,'g')
hold on
quiver3(0,0,0,pref_ori1(1),pref_ori1(2),pref_ori1(3),'k')
hold on
quiver3(0,0,0,pref_ori2(1),pref_ori2(2),pref_ori2(3),'m')
hold on
quiver3(0,0,0,pref_ori3(1),pref_ori3(2),pref_ori3(3),'c')
hold on

C=[pref_ori1' pref_ori2' pref_ori3'];
% ang1 = asind(pref_ori1'*pref_ori2)
% ang2 = asind(pref_ori1'*pref_ori3)
% ang3 = asind(pref_ori2'*pref_ori3)
% xlsappend('C:\Users\shravan\Desktop\princi_axes.csv',C); %%%%%%

