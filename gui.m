function varargout = gui(varargin)
    % GUI MATLAB code for gui.fig
    %      GUI, by itself, creates a new GUI or raises the existing
    %      singleton*.
    %
    %      H = GUI returns the handle to a new GUI or the handle to
    %      the existing singleton*.
    %
    %      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in GUI.M with the given input arguments.
    %
    %      GUI('Property','Value',...) creates a new GUI or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before gui_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to gui_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Edit the above text to modify the response to help gui

    % Last Modified by GUIDE v2.5 26-Jun-2021 15:42:00

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @gui_OpeningFcn, ...
                       'gui_OutputFcn',  @gui_OutputFcn, ...
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
end

% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to gui (see VARARGIN)
    
    handles.IMG_SCALE = 1/108; % 28x28
    handles.hasNet = 0;

    % Choose default command line output for gui
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes gui wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;
end

% --------------------------------------------------------------------
function LOAD_NN_MENU_Callback(hObject, eventdata, handles)
    % hObject    handle to LOAD_NN_MENU (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    [fName, fPath] = uigetfile;
    
    netFileStr = strcat(fPath, fName);
    handles.net = load(netFileStr, 'net').net;
    
    handles.hasNet = 1;
end


% --- Executes on selection change in PUP_TRAINFCN.
function PUP_TRAINFCN_Callback(hObject, eventdata, handles)
    % hObject    handle to PUP_TRAINFCN (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: contents = cellstr(get(hObject,'String')) returns PUP_TRAINFCN contents as cell array
    %        contents{get(hObject,'Value')} returns selected item from PUP_TRAINFCN
end

% --- Executes during object creation, after setting all properties.
function PUP_TRAINFCN_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to PUP_TRAINFCN (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: popupmenu controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end


function EDIT_NNCFG_Callback(hObject, eventdata, handles)
    % hObject    handle to EDIT_NNCFG (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of EDIT_NNCFG as text
    %        str2double(get(hObject,'String')) returns contents of EDIT_NNCFG as a double
end

% --- Executes during object creation, after setting all properties.
function EDIT_NNCFG_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to EDIT_NNCFG (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end


function EDIT_ACTIVATIONFCN_Callback(hObject, eventdata, handles)
    % hObject    handle to EDIT_ACTIVATIONFCN (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of EDIT_ACTIVATIONFCN as text
    %        str2double(get(hObject,'String')) returns contents of EDIT_ACTIVATIONFCN as a double
end

% --- Executes during object creation, after setting all properties.
function EDIT_ACTIVATIONFCN_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to EDIT_ACTIVATIONFCN (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

% --------------------------------------------------------------------
function SAVE_NN_MENU_Callback(hObject, eventdata, handles)
    % hObject    handle to SAVE_NN_MENU (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    if (handles.hasNet ~= 1)
        return;
    end

end


% --- Executes on button press in BTN_NETCREATETRAIN.
function BTN_NETCREATETRAIN_Callback(hObject, eventdata, handles)
    % hObject    handle to BTN_NETCREATETRAIN (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    if (isempty(get(handles.EDIT_NNCFG, 'String')))
        return;
    end
    
    if (isempty(get(handles.EDIT_ACTIVATIONFCN, 'String')))
        return;
    end
    
    nnCfgCellArray = split(get(handles.EDIT_NNCFG, 'String'));
    
    for i = 1: length(nnCfgCellArray)
        if (~isscalar(nnCfgCellArray(i)))
            return;
        end
    end
    
    nnCfgStr = cell2mat(nnCfgCellArray);
    
    for i = 1: length(nnCfgStr)
        nnCfgValue(i) = str2num(nnCfgStr(i, :));
    end
    
    handles.net = feedforwardnet(nnCfgValue);
    
    trainFcnCell = get(handles.PUP_TRAINFCN, 'String');
    trainFcnCell = trainFcnCell(get(handles.PUP_TRAINFCN, 'Value'));
    trainFcnStr = cell2mat(trainFcnCell);
    
    handles.net.trainFcn = trainFcnStr;
    
    activationFcnCellArray = split(get(handles.EDIT_ACTIVATIONFCN, 'String'));
    activationFcnStrArray = string(activationFcnCellArray);
    
    if (length(activationFcnStrArray) ~= length(nnCfgValue) + 1)
        return;
    end
    
    for i = 1: length(activationFcnStrArray)
        handles.net.layers{i}.transferFcn = activationFcnStrArray(i);
    end
    
    folderImg = dir(sprintf("%s\\*.jpg", get(handles.EDIT_TRAINFOLDER, 'String')));
    imgFiles = natsort({folderImg.name})

    letrasBW = zeros(3024 * 3024 * handles.IMG_SCALE * handles.IMG_SCALE, length(imgFiles));
    letrasTarget = [];
    letrasBWCol = 1;
    
    jump = length(imgFiles) / 10;

    for i = 1: jump
        for j = 1: 10
            img = imread(sprintf('%s\\%s', get(handles.EDIT_TRAINFOLDER, 'String'), char(imgFiles(((j - 1) * jump) + i))));
%             imshow(img);
%             pause(0.05);
            img = imresize(img, handles.IMG_SCALE);
            binarizedImg = imbinarize(img);
            letrasBW(:, letrasBWCol) = reshape(binarizedImg, 1, []);
            letrasBWCol = letrasBWCol + 1;
        end

        letrasTarget = [letrasTarget eye(10)];
    end
end


% --- Executes on button press in BTN_CHOOSEDIR.
function BTN_CHOOSEDIR_Callback(hObject, eventdata, handles)
    % hObject    handle to BTN_CHOOSEDIR (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    set(handles.EDIT_TRAINFOLDER, 'String', uigetdir('.', "Escolher pasta para treino"));
    
    if (get(handles.EDIT_TRAINFOLDER, 'String') == '0')
        set(handles.EDIT_TRAINFOLDER, 'String', 'C:\');
    end
end


function EDIT_TRAINFOLDER_Callback(hObject, eventdata, handles)
    % hObject    handle to EDIT_TRAINFOLDER (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of EDIT_TRAINFOLDER as text
    %        str2double(get(hObject,'String')) returns contents of EDIT_TRAINFOLDER as a double
end

% --- Executes during object creation, after setting all properties.
function EDIT_TRAINFOLDER_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to EDIT_TRAINFOLDER (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end


% --- Executes on selection change in ordemMenu.
function ordemMenu_Callback(hObject, eventdata, handles)
% hObject    handle to ordemMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ordemMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ordemMenu


% --- Executes during object creation, after setting all properties.
function ordemMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ordemMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
