function varargout = UpdateEmployee(varargin)
% UPDATEEMPLOYEE MATLAB code for UpdateEmployee.fig
%      UPDATEEMPLOYEE, by itself, creates a new UPDATEEMPLOYEE or raises the existing
%      singleton*.
%
%      H = UPDATEEMPLOYEE returns the handle to a new UPDATEEMPLOYEE or the handle to
%      the existing singleton*.
%
%      UPDATEEMPLOYEE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UPDATEEMPLOYEE.M with the given input arguments.
%
%      UPDATEEMPLOYEE('Property','Value',...) creates a new UPDATEEMPLOYEE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UpdateEmployee_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UpdateEmployee_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UpdateEmployee

% Last Modified by GUIDE v2.5 21-Jul-2019 00:10:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UpdateEmployee_OpeningFcn, ...
                   'gui_OutputFcn',  @UpdateEmployee_OutputFcn, ...
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


% --- Executes just before UpdateEmployee is made visible.
function UpdateEmployee_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UpdateEmployee (see VARARGIN)

% Choose default command line output for UpdateEmployee
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes UpdateEmployee wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = UpdateEmployee_OutputFcn(hObject, eventdata, handles) 
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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
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
name =get(handles.edit2,'string');
username=get(handles.edit3,'string');
userpass=get(handles.edit4,'string');

columname = {'EMPLOYEENAME','EMPLOYEEUSERNAME','EMPLOYEEPASSWORD'};


Whatyouwanttosearch='Select EMPLOYEECNIC from Employee where EMPLOYEECNIC=''employeecnic''';
    SearchString = strrep(Whatyouwanttosearch,'employeecnic',cnic);
    curs = exec(conn,SearchString); 
    curs = fetch(curs);
    data = curs.Data;
    disp(data);
      
    ifmatched=strcmp(data,'No Data');
    
    if ifmatched == 0
        dataTobeUpdated = {name username userpass};
         whereClause = 'where EMPLOYEECNIC=''cnic''';
         newupdate = strrep(whereClause,'cnic',cnic);
        update(conn,'Employee',columname,dataTobeUpdated,newupdate);
        msgbox('Employee Updated Successfully');
       set(handles.edit1,'string',''); 
       set(handles.edit2,'string','');
       set(handles.edit3,'string','');
       set(handles.edit4,'string','');
    else
        msgbox('CNIC Doesnt Exist Cant Update....');
        set(handles.edit1,'string',''); 
       set(handles.edit2,'string','');
       set(handles.edit3,'string','');
       set(handles.edit4,'string','');
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
