function varargout = BrowseAnImage(varargin)
% BROWSEANIMAGE MATLAB code for BrowseAnImage.fig
%      BROWSEANIMAGE, by itself, creates a new BROWSEANIMAGE or raises the existing
%      singleton*.
%
%      H = BROWSEANIMAGE returns the handle to a new BROWSEANIMAGE or the handle to
%      the existing singleton*.
%
%      BROWSEANIMAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BROWSEANIMAGE.M with the given input arguments.
%
%      BROWSEANIMAGE('Property','Value',...) creates a new BROWSEANIMAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BrowseAnImage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BrowseAnImage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BrowseAnImage

% Last Modified by GUIDE v2.5 20-May-2019 01:14:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BrowseAnImage_OpeningFcn, ...
                   'gui_OutputFcn',  @BrowseAnImage_OutputFcn, ...
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


% --- Executes just before BrowseAnImage is made visible.
function BrowseAnImage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BrowseAnImage (see VARARGIN)

% Choose default command line output for BrowseAnImage
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BrowseAnImage wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BrowseAnImage_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)


load imgfildata;

% f=imread('example\carplate16.jpg');
% imshow(f);

[FileName,PathName] = uigetfile({'*.jpg'});
f=strcat(PathName,FileName);

picture=imread(f);

set(handles.axes2,'Units','pixels');
resizePos = get(handles.axes2,'Position');
axes(handles.axes2);
imshow(picture);
set(handles.axes2,'Units','normalized')

pictureforRecog=picture;

[rr,cc]=size(picture);%
picture=imresize(picture,[200 300]);
picture=rgb2gray(picture);

if size(picture,3)==3
  picture=rgb2gray(picture);
end
se=strel('rectangle',[5,5]);
a=imerode(picture,se);
%figure

axes(handles.axes2);
imshow(a);

b=imdilate(a,se);
threshold = graythresh(picture);
picture =~im2bw(picture,threshold);
picture = bwareaopen(picture,8);
imshow(picture)
if cc>1000
    picture1=bwareaopen(picture,3500);
else
picture1=bwareaopen(picture,2000);
end
%figure
axes(handles.axes2);

imshow(picture1),title('scaned image')%scaned immaagee taken from dataset
picture2=picture-picture1;

%figure
axes(handles.axes2);
imshow(picture2)
picture2=bwareaopen(picture2,200);
hold on;

%figure
axes(handles.axes2);

% imshow(picture2),title('2ndpi')

[L,Ne]=bwlabel(picture2);
propied=regionprops(L,'BoundingBox');
hold on
pause(1)
for n=1:size(propied,1)
  rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off

%figure
final_output=[];
t=[];
for n=1:Ne
  [r,c] = find(L==n);
  n1=picture(min(r):max(r),min(c):max(c));
  n1=imresize(n1,[42,24]);
  %imshow(n1)
  pause(0.5)
  x=[ ];

totalLetters=size(imgfile,2);



 for k=1:totalLetters
    
    y=corr2(imgfile{1,k},n1);
    x=[x y];
    
 end
 t=[t max(x)];
 if max(x)>.5
 z=find(x==max(x));
 
 
 out=cell2mat(imgfile(2,z));
 
 %disp(out);

%final_output=[final_output  out];
end
end


%picture=imread('example\carplate4.jpg');
%imshow(f);
pictureforRecog=imresize(pictureforRecog,[400 NaN]);
g=rgb2gray(pictureforRecog);

g=medfilt2(g,[3 3]);
se=strel('disk',1);
gi=imdilate(g,se);
ge=imerode(g,se);
gdiff=imsubtract(gi,ge);
gdiff=mat2gray(gdiff);
gdiff=conv2(gdiff,[1 1;1 1]);
gdiff=imadjust(gdiff,[0.5 0.7],[0 1],0.1);
B=logical(gdiff);
er=imerode(B,strel('line',50,0));
out1=imsubtract(B,er);
F=imfill(out1,'holes');

H=bwmorph(F,'thin',1);
H=imerode(H,strel('line',3,90));
final=bwareaopen(H,100);
Iprops=regionprops(final,'BoundingBox','Image');

NR=cat(1,Iprops.BoundingBox);

r=controlling(NR);

if ~isempty(r)
    I={Iprops.Image};
    noPlate=[];
    for v=1:length(r)
        N=I{1,r(v)};
        letter=readLetter(N);
        while letter=='O' || letter=='0'
            if v<=3
                letter='O';
            else
                letter='0';
            end
            break;
        end
        noPlate=[noPlate letter];
    end 
    
    %%
    %Inserting Number plates reg in VehicleInfo database
    
    set(handles.text3,'string',noPlate);
    prefs = setdbprefs('DataReturnFormat');
setdbprefs('DataReturnFormat','table')

conn = database('LPR','','');
columname = {'REGNO','DATETIME'};

formatOut = 'yyyy-mm-dd HH:MM:ss';

time = datestr(now,formatOut);

dataTobeInserted = {noPlate time};
datainsert(conn,'VehicleInfo',columname,dataTobeInserted);

    
    
    
    
    
    %%
    %Stolen Vehicles
    
    prefs = setdbprefs('DataReturnFormat');
    setdbprefs('DataReturnFormat','table')

    conn = database('LPR','','');
    
    Whatyouwanttosearch='Select REGNO from StolenVehicle where REGNO=''regno''';
    SearchString = strrep(Whatyouwanttosearch,'regno',noPlate);
    curs = exec(conn,SearchString); 
    curs = fetch(curs);
    data = curs.Data;
    %disp(data);
    nullQuery=strcmp(data,'No Data');
    
 
    if nullQuery==1
        CheckRegVehicle(noPlate);
    else
         C = table2cell(data);
        %celldisp(C);
         y=strings(size(C));
        [y{:}]=C{:};
        compareNoplate=strcmp(noPlate,y);
    
        if compareNoplate==1
         Whatyouwanttosearch='Select * from StolenVehicle where REGNO=''regno''';
          SearchString = strrep(Whatyouwanttosearch,'regno',noPlate);

         curs = exec(conn,SearchString); 
         curs = fetch(curs);
         data = curs.Data;
         %disp(data);
         
         C = table2cell(curs.Data);
    f = figure;
            axes
            title('All Stolen Cars')
            set(gca, 'visible', 'off')
            set(gca,'FontSize',20)
            set(findall(gca, 'type', 'text'), 'visible', 'on')
    uit = uitable(f);
    d = C;
    uit.Data = d;
    uit.ColumnName = {'OWNER','CNIC','REGNO','CHASSISNO','MAKER','MAKE'};
    uit.Position = [0 150 550 200];
         end   
    end
    
 %%   
    
   
else
    msgbox('Unable to extract the characters from the number plate.The characters on the number plate might not be clear or touching with each other or boundries');
   
end


% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

%axes(handles.axes2);
% vid=videoinput('winvideo',1); 
% hImage=image(zeros(1000,2000,3),'parent' ,handles.axes2);
% preview(vid,hImage);

axes(handles.axes2);

cam = ipcam('http://192.168.8.11:8080/video');
preview(cam)
img = snapshot(cam);
imshow(img)
imsave
% img=getsnapshot(camera);
fname=['Image' num2str(2)];
imwrite(img,fname,'jpg');

% x=videoinput('winvideo',1);
% imaqhwinfo(x);
% axes(handles.axes2);
% preview(x);
  


% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
run AdminControl.m
delete(handles.figure1);
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function void = CheckRegVehicle(noPlate) 

    prefs = setdbprefs('DataReturnFormat');
    setdbprefs('DataReturnFormat','table')

    conn = database('LPR','','');
    Whatyouwanttosearch='Select REGNO from RegisteredVehicle where REGNO=''regno''';
    SearchString = strrep(Whatyouwanttosearch,'regno',noPlate);
    curs = exec(conn,SearchString); 
    curs = fetch(curs);
    data = curs.Data;
    %disp(data);
    found=strcmp(data,'No Data');
    if found==1
     msgbox('Your Vehicle is not Registered');
   
    else
    C = table2cell(data);
    %celldisp(C);
    y=strings(size(C));
    [y{:}]=C{:};
    compareNoplateForRegistered=strcmp(noPlate,y);
        if compareNoplateForRegistered==1
            conn = database('LPR','','');
            Whatyouwanttosearch='Select * from RegisteredVehicle where REGNO=''regno''';
            SearchString = strrep(Whatyouwanttosearch,'regno',noPlate);
            curs = exec(conn,SearchString); 
            curs = fetch(curs);
            data = curs.Data;
            %disp(data);
    
            C = table2cell(curs.Data);
            f = figure;
            
          
           
            uit = uitable(f);
           
            axes
            title('All Registered Cars')
            set(gca, 'visible', 'off')
            set(gca,'FontSize',20)
            set(findall(gca, 'type', 'text'), 'visible', 'on')
            d = C;
            uit.Data = d;
           
            uit.ColumnName = {'OWNER','CNIC','ADDRESS','REGNO','MAKE','ENGINESIZE','COLOR','CHASSISNO','MAKER'};
            uit.Position = [0 150 550 200];
        end
    end
    
    
