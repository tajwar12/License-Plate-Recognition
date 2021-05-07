function varargout = Login(varargin)
% LOGIN MATLAB code for Login.fig
%      LOGIN, by itself, creates a new LOGIN or raises the existing
%      singleton*.
%
%      H = LOGIN returns the handle to a new LOGIN or the handle to
%      the existing singleton*.
%
%      LOGIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOGIN.M with the given input arguments.
%
%      LOGIN('Property','Value',...) creates a new LOGIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Login_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Login_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Login

% Last Modified by GUIDE v2.5 20-Jul-2019 23:52:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Login_OpeningFcn, ...
                   'gui_OutputFcn',  @Login_OutputFcn, ...
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


% --- Executes just before Login is made visible.
function Login_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Login (see VARARGIN)

% Choose default command line output for Login
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);




% UIWAIT makes Login wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Login_OutputFcn(hObject, eventdata, handles) 
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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
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

%% Make connection to database
conn = database('LPR','','');


uname = get(handles.edit1,'string');
pass =get(handles.edit2,'string');


if (uname=="" || pass=="")
    msgbox('Please Enter Username and Password to Login');
else
    
    FetchingUsername='Select EMPLOYEEUSERNAME from Employee where EMPLOYEEUSERNAME=''Name''';
    SearchStringForUsername = strrep(FetchingUsername,'Name',uname);
    curs = exec(conn,SearchStringForUsername);
    curs = fetch(curs);
    data = curs.Data;
 
    UserData = table2cell(data);
    %celldisp(UserData);
    Username=strings(size(UserData));
    [Username{:}]=UserData{:};
    
    Whatyouwanttosearch='Select EMPLOYEEPASSWORD from Employee where EMPLOYEEUSERNAME=''Name''';
    SearchString = strrep(Whatyouwanttosearch,'Name',uname);
    curs = exec(conn,SearchString);
    curs = fetch(curs);
    data = curs.Data;
    %disp(data);
    C = table2cell(data);
    %celldisp(C);
    y=strings(size(C));
    [y{:}]=C{:};
 
 
    passcompare=strcmp(y,pass);
    adminname=strcmp('Admin',uname);
    
    CompareUsername=strcmp(Username,uname);

    if (adminname==1 && passcompare==1) 
    
    run AdminControl.m
    
    set(handles.edit1,'string','');
    set(handles.edit2,'string','');
    
    delete(handles.figure1);
  
    
    elseif (passcompare==1 && CompareUsername==1)
    run EmployeeControl.m
    delete(handles.figure1);
    elseif (passcompare~=1)
    msgbox('Username or Password Doesnt Match');
    set(handles.edit1,'string','');
    set(handles.edit2,'string','');
    end    
end


%% Close connection to database
close(conn)

%% Restore preferences
setdbprefs('DataReturnFormat',prefs)

%% Clear variables
clear prefs conn curs





% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)

axes(hObject)
imshow('shutterstock.jpg');
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axes(hObject)
imshow('b7.jpg');
% Hint: place code in OpeningFcn to populate axes2
