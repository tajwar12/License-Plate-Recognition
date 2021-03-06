function varargout = DeleteEmployee(varargin)
% DELETEEMPLOYEE MATLAB code for DeleteEmployee.fig
%      DELETEEMPLOYEE, by itself, creates a new DELETEEMPLOYEE or raises the existing
%      singleton*.
%
%      H = DELETEEMPLOYEE returns the handle to a new DELETEEMPLOYEE or the handle to
%      the existing singleton*.
%
%      DELETEEMPLOYEE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DELETEEMPLOYEE.M with the given input arguments.
%
%      DELETEEMPLOYEE('Property','Value',...) creates a new DELETEEMPLOYEE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DeleteEmployee_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DeleteEmployee_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DeleteEmployee

% Last Modified by GUIDE v2.5 21-Jul-2019 00:07:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DeleteEmployee_OpeningFcn, ...
                   'gui_OutputFcn',  @DeleteEmployee_OutputFcn, ...
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


% --- Executes just before DeleteEmployee is made visible.
function DeleteEmployee_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DeleteEmployee (see VARARGIN)

% Choose default command line output for DeleteEmployee
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DeleteEmployee wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DeleteEmployee_OutputFcn(hObject, eventdata, handles) 
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

%% Make connection to database
conn = database('LPR','','');


cnic = get(handles.edit1,'string');

Whatyouwanttosearch='Select EMPLOYEECNIC from Employee where EMPLOYEECNIC=''employeecnic''';
    SearchString = strrep(Whatyouwanttosearch,'employeecnic',cnic);
    curs = exec(conn,SearchString); 
    curs = fetch(curs);
    data = curs.Data;
    disp(data);
      
    ifmatched=strcmp(data,'No Data');
    
    if ifmatched == 0
        deleteString='delete from Employee where EMPLOYEECNIC=''cnic''';
        newdelete = strrep(deleteString,'cnic',cnic);
        exec(conn,newdelete);
        msgbox('Employee Deleted Successfully');
        set(handles.edit1,'string','');
    else
        msgbox('CNIC Doesnt Exist Cant Update....');
        set(handles.edit1,'string','');
    end    

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
run AdminControl.m
delete(handles.figure1);
% hObject    handle to pushbutton2 (see GCBO)
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
