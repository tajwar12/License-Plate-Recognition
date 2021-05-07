function varargout = EmployeeControl(varargin)
% EMPLOYEECONTROL MATLAB code for EmployeeControl.fig
%      EMPLOYEECONTROL, by itself, creates a new EMPLOYEECONTROL or raises the existing
%      singleton*.
%
%      H = EMPLOYEECONTROL returns the handle to a new EMPLOYEECONTROL or the handle to
%      the existing singleton*.
%
%      EMPLOYEECONTROL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EMPLOYEECONTROL.M with the given input arguments.
%
%      EMPLOYEECONTROL('Property','Value',...) creates a new EMPLOYEECONTROL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EmployeeControl_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EmployeeControl_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EmployeeControl

% Last Modified by GUIDE v2.5 21-Jul-2019 18:00:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EmployeeControl_OpeningFcn, ...
                   'gui_OutputFcn',  @EmployeeControl_OutputFcn, ...
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


% --- Executes just before EmployeeControl is made visible.
function EmployeeControl_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EmployeeControl (see VARARGIN)

% Choose default command line output for EmployeeControl
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EmployeeControl wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EmployeeControl_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

run SearchNumberPlateMannully.m
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

x=videoinput('winvideo',1);
imaqhwinfo(x);
preview(x);
    img=getsnapshot(x);
    fname=['Image' num2str(1)];
    imwrite(img,fname,'jpg');
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
run Login.m
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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run BrowseAnImageEmployee.m
delete(handles.figure1);