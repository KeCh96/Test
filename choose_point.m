function xy_c=choose_point(xyall)


xyall=[xyall -xyall(:,1)-xyall(:,2)];
xyall=[xyall xyall(:,1)-xyall(:,2)];
xyall=[xyall -xyall(:,1)+xyall(:,2)];
xyall=[xyall xyall(:,1)+xyall(:,2)];


[~,y1]=max(xyall(:,3));
[~,y2]=max(xyall(:,4));
[~,y3]=max(xyall(:,5));
[~,y4]=max(xyall(:,6));
% 
% 
% xyall1=sortrows(xyall,-3);
% xyall2=sortrows(xyall,-4);
% xyall3=sortrows(xyall,-5);
% xyall4=sortrows(xyall,-6);
% 
% 
% 
xy_c=[xyall(y1,1:2);xyall(y2,1:2);xyall(y3,1:2);xyall(y4,1:2)];


