

function [] = func_ori_plot(ori)
   nGrains = max(size(ori));
   for i=1:nGrains
       x1(i) = ori(i,1);
       y1(i) = ori(i,2);
       z1(i) = ori(i,3);
   end
    
        figure
        [X,Y,Z] = sphere(100);
        scatter3(x1,y1,z1,'filled')
        view([0,0,1])
        daspect([1 1 1])      
        xlabel('X')
        ylabel('Y')
        zlabel('Z')
end
   