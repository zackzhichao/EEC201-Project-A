function varargout = Project(varargin)
% PROJECT MATLAB code for Project.fig
%      PROJECT, by itself, creates a new PROJECT or raises the existing
%      singleton*.
%
%      H = PROJECT returns the handle to a new PROJECT or the handle to
%      the existing singleton*.
%
%      PROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECT.M with the given input arguments.
%
%      PROJECT('Property','Value',...) creates a new PROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Project_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Project_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Project

% Last Modified by GUIDE v2.5 13-Mar-2019 17:21:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Project_OpeningFcn, ...
                   'gui_OutputFcn',  @Project_OutputFcn, ...
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


% --- Executes just before Project is made visible.
function Project_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Project (see VARARGIN)

% Choose default command line output for Project
handles.output = hObject;

guidata(hObject, handles);

% UIWAIT makes Project wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Project_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadfile.
function loadfile_Callback(hObject, eventdata, handles)
% hObject    handle to loadfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGui=guidata(handles.figure1);

[file,path] = uigetfile('*.wav','*.m4a');
pathpall = [path file];
[x,fx] = audioread(pathpall);
myGui.freqSam=fx;
myGui.datasound=x;
totalt = ceil(length(x)/fx);
t = linspace(0,totalt,length(x));
plot(handles.axes1,t,myGui.datasound);
xlabel(handles.axes1,'t/s');

guidata(handles.figure1,myGui);


function starttime_Callback(hObject, eventdata, handles)
% hObject    handle to starttime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of starttime as text
%        str2double(get(hObject,'String')) returns contents of starttime as a double


% --- Executes during object creation, after setting all properties.
function starttime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to starttime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function endtime_Callback(hObject, eventdata, handles)
% hObject    handle to endtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of endtime as text
%        str2double(get(hObject,'String')) returns contents of endtime as a double


% --- Executes during object creation, after setting all properties.
function endtime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in intercept.
function intercept_Callback(hObject, eventdata, handles)
% hObject    handle to intercept (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGui = guidata(handles.figure1);

min1 = str2num(get(handles.startmin,'string'));
min2 = str2num(get(handles.endmin,'string'));
sec1 = str2num(get(handles.startsec,'string'));
sec2 = str2num(get(handles.endsec,'string'));
t1 = min1*60+sec1;
t2 = min2*60+sec2;
f = myGui.freqSam;
myGui.start = ceil(t1*f)+1;
myGui.end = ceil(t2*f)+1;
t = linspace(t1,t2,(myGui.end-myGui.start+1));
myGui.datasound1 = myGui.datasound(myGui.start:myGui.end);
plot(handles.axes2,t,myGui.datasound1);
xlabel(handles.axes2,'t/s');

guidata(handles.figure1,myGui);

% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGui = guidata(handles.figure1);

myGui.player1=audioplayer(myGui.datasound1,myGui.freqSam);
play(myGui.player1);
myGui.flag1 = 1;

guidata(handles.figure1,myGui);

% --------------------------------------------------------------------
function Pro_Callback(hObject, eventdata, handles)
% hObject    handle to Pro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h1 = [ handles.loadfile handles.play3 handles.axes1 handles.stop];
h2 = [ handles.play handles.intercept handles.axes2 handles.startmin handles.endmin handles.startsec handles.endsec handles.save1 handles.stop1];
h3 = [ handles.stretch handles.compress handles.edittime handles.axes3 handles.play1 handles.save2 handles.stop2];
h4 = [ handles.editphase handles.shift handles.play2 handles.axes4 handles.save3 handles.stop3];
set(h1,'Visible','on');
set(h2,'Visible','on');
set(h3,'Visible','on');
set(h4,'Visible','on');

% --------------------------------------------------------------------

% --------------------------------------------------------------------

% --------------------------------------------------------------------

% --------------------------------------------------------------------

% --- Executes on button press in play1.
function play1_Callback(hObject, eventdata, handles)
% hObject    handle to play1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGui=guidata(handles.figure1);

myGui.player2 = audioplayer(myGui.datasound2,myGui.freqSam);
play(myGui.player2);
myGui.flag2 = 1;

guidata(handles.figure1,myGui);


% --- Executes on button press in play2.
function play2_Callback(hObject, eventdata, handles)
% hObject    handle to play2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGui=guidata(handles.figure1);

myGui.player3=audioplayer(myGui.datasound3,myGui.freqSam);
play(myGui.player3);
myGui.flag3 = 1;

guidata(handles.figure1,myGui);


function edittime_Callback(hObject, eventdata, handles)
% hObject    handle to edittime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edittime as text
%        str2double(get(hObject,'String')) returns contents of edittime as a double


% --- Executes during object creation, after setting all properties.
function edittime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edittime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in shift.
function shift_Callback(hObject, eventdata, handles)
% hObject    handle to shift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGui = guidata(handles.figure1);

Speech = myGui.datasound1;
Fs = myGui.freqSam;
Rate = str2num(get(handles.editphase,'string'));
% Speech = Speech(:,1);
Speech = Speech(:);
SpeechN1 = Pitchshift(Speech,Rate,Fs);
myGui.datasound3 = SpeechN1;

min1 = str2num(get(handles.startmin,'string'));
min2 = str2num(get(handles.endmin,'string'));
sec1 = str2num(get(handles.startsec,'string'));
sec2 = str2num(get(handles.endsec,'string'));
t1 = min1*60+sec1;
t2 = min2*60+sec2;

t = linspace(t1,t2,length(myGui.datasound3));
plot(handles.axes4,t,myGui.datasound3);
xlabel(handles.axes4,'t/s');

guidata(handles.figure1,myGui);


function editphase_Callback(hObject, eventdata, handles)
% hObject    handle to editphase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editphase as text
%        str2double(get(hObject,'String')) returns contents of editphase as a double


% --- Executes during object creation, after setting all properties.
function editphase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editphase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in stretch.
function stretch_Callback(hObject, eventdata, handles)
% hObject    handle to stretch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGui = guidata(handles.figure1);

Speech = myGui.datasound1;
Fs = myGui.freqSam;
Rate = str2num(get(handles.edittime,'string'));
% Speech = Speech(:,1);
Speech = Speech(:);
SpeechN1 = SOLA(Speech,1/Rate,Fs);
myGui.datasound2 = SpeechN1;

min1 = str2num(get(handles.startmin,'string'));
min2 = str2num(get(handles.endmin,'string'));
sec1 = str2num(get(handles.startsec,'string'));
sec2 = str2num(get(handles.endsec,'string'));
t1 = min1*60+sec1;
t2 = min2*60+sec2;

t = linspace(0,Rate*t2-Rate*t1,length(myGui.datasound2));
plot(handles.axes3,t,myGui.datasound2);
xlabel(handles.axes3,'t/s');

guidata(handles.figure1,myGui);


% --- Executes on button press in compress.
function compress_Callback(hObject, eventdata, handles)
% hObject    handle to compress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGui = guidata(handles.figure1);

Speech = myGui.datasound1;
Fs = myGui.freqSam;
Rate = str2num(get(handles.edittime,'string'));
% Speech = Speech(:,1);
Speech = Speech(:);
SpeechN1 = SOLA(Speech,Rate,Fs);
myGui.datasound2 = SpeechN1;


min1 = str2num(get(handles.startmin,'string'));
min2 = str2num(get(handles.endmin,'string'));
sec1 = str2num(get(handles.startsec,'string'));
sec2 = str2num(get(handles.endsec,'string'));
t1 = min1*60+sec1;
t2 = min2*60+sec2;

t = linspace(0,t2/Rate-t1/Rate,length(myGui.datasound2));
plot(handles.axes3,t,myGui.datasound2);
xlabel(handles.axes3,'t/s');

guidata(handles.figure1,myGui);

% --- Executes on button press in play3.
function play3_Callback(hObject, eventdata, handles)
% hObject    handle to play3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGui=guidata(handles.figure1);

myGui.player = audioplayer(myGui.datasound,myGui.freqSam);
play(myGui.player);
myGui.flag = 1;

guidata(handles.figure1,myGui);


function startmin_Callback(hObject, eventdata, handles)
% hObject    handle to startmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startmin as text
%        str2double(get(hObject,'String')) returns contents of startmin as a double


% --- Executes during object creation, after setting all properties.
function startmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function startsec_Callback(hObject, eventdata, handles)
% hObject    handle to startsec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startsec as text
%        str2double(get(hObject,'String')) returns contents of startsec as a double


% --- Executes during object creation, after setting all properties.
function startsec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startsec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function endsec_Callback(hObject, eventdata, handles)
% hObject    handle to endsec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of endsec as text
%        str2double(get(hObject,'String')) returns contents of endsec as a double


% --- Executes during object creation, after setting all properties.
function endsec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endsec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function endmin_Callback(hObject, eventdata, handles)
% hObject    handle to endmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of endmin as text
%        str2double(get(hObject,'String')) returns contents of endmin as a double


% --- Executes during object creation, after setting all properties.
function endmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save1.
function save1_Callback(hObject, eventdata, handles)
% hObject    handle to save1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGui=guidata(handles.figure1);

audiowrite('interception.m4a',myGui.datasound1,myGui.freqSam);

guidata(handles.figure1,myGui);

% --- Executes on button press in save3.
function save3_Callback(hObject, eventdata, handles)
% hObject    handle to save3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGui=guidata(handles.figure1);

audiowrite('*.m4a',myGui.datasound3,myGui.freqSam);
% uiputfile('*.m4a',myGui.datasound3,myGui.freqSam)
guidata(handles.figure1,myGui);


% --- Executes on button press in save2.
function save2_Callback(hObject, eventdata, handles)
% hObject    handle to save2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGui=guidata(handles.figure1);

audiowrite('timecompress.m4a',myGui.datasound2,myGui.freqSam);

guidata(handles.figure1,myGui);

% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGui=guidata(handles.figure1);

if(myGui.flag == 1)
        disp('1');
        myGui.flag = 0;
        pause(myGui.player);
else
        disp('0');
        myGui.flag = 1;
        resume(myGui.player);
end

guidata(handles.figure1,myGui);


% --- Executes on button press in stop1.
function stop1_Callback(hObject, eventdata, handles)
% hObject    handle to stop1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGui=guidata(handles.figure1);

if(myGui.flag1 == 1)
        disp('1');
        myGui.flag1 = 0;
        pause(myGui.player1);
else
        disp('0');
        myGui.flag1 = 1;
        resume(myGui.player1);
end

guidata(handles.figure1,myGui);

% --- Executes on button press in stop3.
function stop3_Callback(hObject, eventdata, handles)
% hObject    handle to stop3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGui=guidata(handles.figure1);

if(myGui.flag3 == 1)
        disp('1');
        myGui.flag3 = 0;
        pause(myGui.player3);
else
        disp('0');
        myGui.flag3 = 1;
        resume(myGui.player3);
end

guidata(handles.figure1,myGui);

% --- Executes on button press in stop2.
function stop2_Callback(hObject, eventdata, handles)
% hObject    handle to stop2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGui=guidata(handles.figure1);

if(myGui.flag2 == 1)
        disp('1');
        myGui.flag2 = 0;
        pause(myGui.player2);
else
        disp('0');
        myGui.flag2 = 1;
        resume(myGui.player2);
end

guidata(handles.figure1,myGui);
