function ppt_photo(address,adjust,p,out_press,show)
%% 将照片里的ppt摆正的函数

tic

if nargin<5
    show=0;
end

if nargin<4
    out_press=1;
end

if nargin<3
    p=1;
end

if nargin<2
    adjust=0;
end






I0=imread(address);
I=rgb2gray(I0);
I=im2double(I);




thresh=graythresh(I)+adjust;




% if nargin==1
%     p=1;
%     thresh=graythresh(I);
%
% elseif nargin==2
%     p=1;
%     thresh=graythresh(I)+adjust;
% elseif nargin==3
%     thresh=graythresh(I)+adjust;
%
% elseif
%     thresh=graythresh(I)+adjust;
%     show=1;
%



if p~=1
    rotI=imresize(I,1./p);
else
    rotI=I;
end


if show
    figure
    imshow(I);
end


% thresh=0.5647

%
% thresh=thresh+0.1
% thresh=mythresh(rotI); %%%% 这里可以设置迭代算法，从0往上加
if show
    thresh
end

rotI=im2bw(rotI,thresh);
if show
    figure;
    imshow(rotI)
end


rotI=maxLianTongYu(rotI);

if show
    figure
    imshow(rotI)
end




% rotI = edge(rotI,'canny');

% imshow(rotI)




%% 此时 rotI 是边缘检测过的图像
[xx,yy]=find(rotI);

% xmax=p.*max(xx);
% xmin=p.*min(xx);
% ymax=p.*max(yy);
% ymin=p.*min(yy);

xmax=max(xx);
xmin=min(xx);
ymax=max(yy);
ymin=min(yy);


I_resized_part=rotI(xmin:xmax,ymin:ymax);

[xx,yy]=find(I_resized_part);



xyall=[yy xx];

% xyall(find(max(zz)),:)

xychoose=choose_point(xyall); %在压缩小图中的四点坐标
%top left->top right->bottom left->bottom right



% M=1600.*3/2;
% N=1200.*3./2;

%% 获取彩色小图
xmax=p.*xmax;
xmin=p.*xmin;
ymax=p.*ymax;
ymin=p.*ymin;

S=(xmax-xmin).*(ymax-ymin);


M=4.*(S./12).^0.5./out_press;
N=3.*(S./12).^0.5./out_press;




I0_part=I0(xmin:xmax,ymin:ymax,:);


xychoose=p.*xychoose; % 在彩色小图中的四点坐标

base_point=[0 0;M 0;0 N;M N];

tform=cp2tform(xychoose,base_point,'Projective');

[Iout x y]=imtransform(I0_part,tform);

if show
    figure;
    imshow(Iout)
end
% Iout=Iout(ceil(abs(x(1))):ceil(abs(x(1)))+800,ceil(abs(y(1))):ceil(abs(y(1)))+600);
% Iout=Iout(ceil(abs(y(1))):ceil(abs(y(1)))+600,ceil(abs(x(1))):ceil(abs(x(1)))+800);

% figure;
% imshow(Iout)

Iout=Iout(ceil(abs(y(1))):ceil(abs(y(1)))+N,ceil(abs(x(1))):ceil(abs(x(1)))+M,:);
figure;
imshow(Iout)

for k=length(address):-1:1
    if address(k)=='.'
        break;
    end
end
toc
choice = menu('Save the adjusted picture','Yes','No');

if choice==1
    imwrite(Iout,[address(1:k-1) '_adjusted' address(k:end)]);
end


% imtransform([0 0],tform)

%
%




