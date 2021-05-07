function varargout = SearchNumberPlateMannully(varargin)
% SEARCHNUMBERPLATEMANNULLY MATLAB code for SearchNumberPlateMannully.fig
%      SEARCHNUMBERPLATEMANNULLY, by itself, creates a new SEARCHNUMBERPLATEMANNULLY or raises the existing
%      singleton*.
%
%      H = SEARCHNUMBERPLATEMANNULLY returns the handle to a new SEARCHNUMBERPLATEMANNULLY or the handle to
%      the existing singleton*.
%
%      SEARCHNUMBERPLATEMANNULLY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEARCHNUMBERPLATEMANNULLY.M with the given input arguments.
%
%      SEARCHNUMBERPLATEMANNULLY('Property','Value',...) creates a new SEARCHNUMBERPLATEMANNULLY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SearchNumberPlateMannully_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SearchNumberPlateMannully_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SearchNumberPlateMannully

% Last Modified by GUIDE v2.5 21-Jul-2019 16:22:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SearchNumberPlateMannully_OpeningFcn, ...
                   'gui_OutputFcn',  @SearchNumberPlateMannully_OutputFcn, ...
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


% --- Executes just before SearchNumberPlateMannully is made visible.
function SearchNumberPlateMannully_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SearchNumberPlateMannully (see VARARGIN)

% Choose default command line output for SearchNumberPlateMannully
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SearchNumberPlateMannully wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SearchNumberPlateMannully_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

prefs = setdbprefs('DataReturnFormat');
setdbprefs('DataReturnFormat','table')

conn = database('LPR','','');


noPlate=get(handles.edit1,'string');

columname = {'REGNO','DATETIME'};

formatOut = 'yyyy-mm-dd HH:MM:ss';

time = datestr(now,formatOut);

dataTobeInserted = {noPlate time};
datainsert(conn,'VehicleInfo',columname,dataTobeInserted);
 
    %%
    %Stolen Vehicles
    
    Whatyouwanttosearch='Select REGNO from StolenVehicle where REGNO=''regno''';
    SearchString = strrep(Whatyouwanttosearch,'regno',noPlate);
    curs = exec(conn,SearchString); 
    curs = fetch(curs);
    data = curs.Data;
    %disp(data);
    nullQuery=strcmp(data,'No Data');
    
 
    if nullQuery==1
        CheckRegVehicle(noPlate) 
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
    
    
   function [] = CheckRegVehicle(noPlate) 

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
   

    


   
    
    
   


% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
run numberPlateExtraction.m
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
run EmployeeControl.m
delete(handles.figure1);
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axes(hObject)
imshow('b6.png');
% Hint: place code in OpeningFcn to populate axes1
