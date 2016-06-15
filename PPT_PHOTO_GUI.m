function varargout = PPT_PHOTO_GUI(varargin)
% PPT_PHOTO_GUI MATLAB code for PPT_PHOTO_GUI.fig
%      PPT_PHOTO_GUI, by itself, creates a new PPT_PHOTO_GUI or raises the existing
%      singleton*.
%
%      H = PPT_PHOTO_GUI returns the handle to a new PPT_PHOTO_GUI or the handle to
%      the existing singleton*.
%
%      PPT_PHOTO_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PPT_PHOTO_GUI.M with the given input arguments.
%
%      PPT_PHOTO_GUI('Property','Value',...) creates a new PPT_PHOTO_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PPT_PHOTO_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PPT_PHOTO_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PPT_PHOTO_GUI

% Last Modified by GUIDE v2.5 04-May-2016 23:26:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @PPT_PHOTO_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @PPT_PHOTO_GUI_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before PPT_PHOTO_GUI is made visible.
function PPT_PHOTO_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PPT_PHOTO_GUI (see VARARGIN)

% Choose default command line output for PPT_PHOTO_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PPT_PHOTO_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PPT_PHOTO_GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename;
[filename,panme]=uigetfile({'*.jpg'},'Select the image flie');
filename=fullfile(panme,filename)
set(handles.edit1,'string',filename);
axes(handles.axes1);
imshow(filename);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% if nargin<5
%     show=0;
% end
%
% if nargin<4
%     out_press=1;
% end
%
% if nargin<3
%     p=1;
% end
%
% if nargin<2
%     adjust=0;
% end
global filename;
global p;
global adjust;
address=filename;
out_press=1;
show=1;

if isempty(p)
    p=1;
end
if isempty(adjust)
    adjust=0;
end

I0=imread(address);
I=rgb2gray(I0);
I=im2double(I);

thresh=graythresh(I)+adjust;
% thresh=graythresh(I)



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
    drawnow;
end


% thresh=0.5647

%
% thresh=thresh+0.1
% thresh=mythresh(rotI); %%%% 这里可以设置迭代算法，从0往上加
if show
    thresh
end

rotI=im2bw(rotI,thresh);
% I_2=rotI;
if show
    %     figure;
    
    imshow(rotI)
    drawnow;
end
% pause(10)
while(1)
    
    I_max=maxLianTongYu(rotI);
    
    if show
        %     figure
        imshow(I_max)
        drawnow;
    end
%     pause(3)
    [mm,nn]=size(rotI);
    if sum(I_max(round(mm./2)-3:round(mm./2)+3,round(nn./2)-3:round(nn./2)+3))
        rotI=I_max;
        break;
    end
    rotI=rotI-I_max;

    
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

xychoose=p.*xychoose % 在彩色小图中的四点坐标

base_point=[0 0;M 0;0 N;M N];

tform=cp2tform(xychoose,base_point,'Projective');

[Iout x y]=imtransform(I0_part,tform);

% if show
% %     figure;
% %     imshow(Iout)
% %     drawnow;
% end
% Iout=Iout(ceil(abs(x(1))):ceil(abs(x(1)))+800,ceil(abs(y(1))):ceil(abs(y(1)))+600);
% Iout=Iout(ceil(abs(y(1))):ceil(abs(y(1)))+600,ceil(abs(x(1))):ceil(abs(x(1)))+800);

% figure;
% imshow(Iout)

Iout=Iout(ceil(abs(y(1))):ceil(abs(y(1)))+N,ceil(abs(x(1))):ceil(abs(x(1)))+M,:);
% figure;
imshow(Iout)
drawnow;
for k=length(address):-1:1
    if address(k)=='.'
        break;
    end
end

choice = menu('Save the adjusted picture','Yes','No');

if choice==1
    imwrite(Iout,[address(1:k-1) '_adjusted' address(k:end)]);
end

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)

global adjust;

input = get(hObject);
adjust=input.Value;
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global p;
p = get(hObject);
p=p.Value;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
