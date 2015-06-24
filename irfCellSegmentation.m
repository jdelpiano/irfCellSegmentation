function varargout = irfCellSegmentation(varargin)
% IRFCELLSEGMENTATION MATLAB code for irfCellSegmentation.fig
%      IRFCELLSEGMENTATION, by itself, creates a new IRFCELLSEGMENTATION or raises the existing
%      singleton*.
%
%      H = IRFCELLSEGMENTATION returns the handle to a new IRFCELLSEGMENTATION or the handle to
%      the existing singleton*.
%
%      IRFCELLSEGMENTATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IRFCELLSEGMENTATION.M with the given input arguments.
%
%      IRFCELLSEGMENTATION('Property','Value',...) creates a new IRFCELLSEGMENTATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before irfCellSegmentation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to irfCellSegmentation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% jd, Jun-2015

% Edit the above text to modify the response to help irfCellSegmentation

% Last Modified by GUIDE v2.5 23-Jun-2015 13:49:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @irfCellSegmentation_OpeningFcn, ...
                   'gui_OutputFcn',  @irfCellSegmentation_OutputFcn, ...
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


% --- Executes just before irfCellSegmentation is made visible.
function irfCellSegmentation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to irfCellSegmentation (see VARARGIN)


% ------------------------------
% Init

handles.openingSampleStack = true;

% Zero value means "no previous opening/saving folder"
handles.lastSavingFolder = 0;
handles.lastOpeningFolder = 0;

% Global Parameters: Initial bounds for cell size in pixels
handles.minCellDiameter = 30;
handles.maxCellDiameter = 90;

handles.laplacianOfGaussianSwitch = true;
handles.laplacianOfGaussianSizeParam = 8;
handles.laplacianOfGaussianSave = true;
set(handles.laplacianOfGaussianSaveCheck, 'Value', handles.laplacianOfGaussianSave)

handles.watershedSwitch = true;
handles.watershedThreshold = 0.92;
handles.watershedSave = true;
set(handles.watershedSaveCheck, 'Value', handles.watershedSave)

% Add function folders to path
[handles.irfSegFolder, unusedName, unusedExt] = fileparts(mfilename('fullpath'));
addpath(handles.irfSegFolder)
addpath([handles.irfSegFolder filesep 'functions'])
addpath([handles.irfSegFolder filesep 'extern'])
addpath([handles.irfSegFolder filesep 'extern' filesep 'bfmatlab'])
addpath([handles.irfSegFolder filesep 'extern' filesep 'LPizarro'])
cd(handles.irfSegFolder)





% Choose default command line output for irfCellSegmentation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes irfCellSegmentation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = irfCellSegmentation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function minCellDiameterParamEdit_Callback(hObject, eventdata, handles)
% hObject    handle to minCellDiameterParamEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minCellDiameterParamEdit as text
%        str2double(get(hObject,'String')) returns contents of minCellDiameterParamEdit as a double


% --- Executes during object creation, after setting all properties.
function minCellDiameterParamEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minCellDiameterParamEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxCellDiameterParamEdit_Callback(hObject, eventdata, handles)
% hObject    handle to maxCellDiameterParamEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxCellDiameterParamEdit as text
%        str2double(get(hObject,'String')) returns contents of maxCellDiameterParamEdit as a double


% --- Executes during object creation, after setting all properties.
function maxCellDiameterParamEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxCellDiameterParamEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in laplacianOfGaussianCheck.
function laplacianOfGaussianCheck_Callback(hObject, eventdata, handles)
% hObject    handle to laplacianOfGaussianCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of laplacianOfGaussianCheck



function laplacianOfGaussianParamEdit_Callback(hObject, eventdata, handles)
% hObject    handle to laplacianOfGaussianParamEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of laplacianOfGaussianParamEdit as text
%        str2double(get(hObject,'String')) returns contents of laplacianOfGaussianParamEdit as a double


% --- Executes during object creation, after setting all properties.
function laplacianOfGaussianParamEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to laplacianOfGaussianParamEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in laplacianOfGaussianSaveCheck.
function laplacianOfGaussianSaveCheck_Callback(hObject, eventdata, handles)
% hObject    handle to laplacianOfGaussianSaveCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of laplacianOfGaussianSaveCheck


% --- Executes on button press in watershedCheck.
function watershedCheck_Callback(hObject, eventdata, handles)
% hObject    handle to watershedCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of watershedCheck



function watershedParamEdit_Callback(hObject, eventdata, handles)
% hObject    handle to watershedParamEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of watershedParamEdit as text
%        str2double(get(hObject,'String')) returns contents of watershedParamEdit as a double


% --- Executes during object creation, after setting all properties.
function watershedParamEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to watershedParamEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in watershedSaveCheck.
function watershedSaveCheck_Callback(hObject, eventdata, handles)
% hObject    handle to watershedSaveCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of watershedSaveCheck


% --- Executes on button press in mergeCheck.
function mergeCheck_Callback(hObject, eventdata, handles)
% hObject    handle to mergeCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mergeCheck



function mergingParamEdit_Callback(hObject, eventdata, handles)
% hObject    handle to mergingParamEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mergingParamEdit as text
%        str2double(get(hObject,'String')) returns contents of mergingParamEdit as a double


% --- Executes during object creation, after setting all properties.
function mergingParamEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mergingParamEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in runButton.
function runButton_Callback(hObject, eventdata, handles)
% hObject    handle to runButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.laplacianOfGaussianSave = ...
    get(handles.laplacianOfGaussianSaveCheck, 'Value');

% Read stack info

if handles.openingSampleStack
    
    listing = dir(get(handles.inputFolderEdit, 'String'));
    firstFileName = listing(3).name;
    
    fileNameParts = strsplit(firstFileName, '.');
    preferredExtension = fileNameParts{end};

else
    
    fileNameParts = strsplit(handles.templateFileName, '.');
    preferredExtension = fileNameParts{end};

end

inFolder = get(handles.inputFolderEdit, 'String');
outFolder = get(handles.outputFolderEdit, 'String');

listing = dir([inFolder filesep '*.' preferredExtension]);

numImages = length(listing);

inFileName = listing(1).name;
if strcmp(inFileName(end-8:end), '.ome.tiff') || strcmp(inFileName(end-7:end), '.ome.tif')

    handles.currentImage = openOMETiffImage([inFolder filesep inFileName]);
    
else
    
    handles = irfSegStdout(handles, 'Error: Extension is not .ome.tif(f)');
    
end


[imHeight, imWidth, unusedVar] = size(handles.currentImage);

% Setup options structure
global_options.minCellDiameter = ...
    str2double(get(handles.minCellDiameterParamEdit, 'String'));
global_options.maxCellDiameter = ...
    str2double(get(handles.maxCellDiameterParamEdit, 'String'));

handles = irfSegStdout(handles, ['']);


for i = 1:numImages
    
    handles = irfSegStdout(handles, ['Processing slice ' num2str(i)...
        '/' num2str(numImages) '...']);
    
    inFileName = listing(i).name;
    if strcmp(inFileName(end-8:end), '.ome.tiff') || strcmp(inFileName(end-7:end), '.ome.tif')

        handles.currentImage = openOMETiffImage([inFolder filesep inFileName]);

    else

        handles = irfSegStdout(handles, 'Error: Extension is not .ome.tif(f)');

    end


    if get(handles.laplacianOfGaussianCheck, 'Value')

        % Get parameters for the Laplacian of Gaussian feature
        
        sigma = str2double(get(handles.laplacianOfGaussianParamEdit, 'String'));

        % Get Laplacian of Gaussian feature
        
        convResult = laplacianOfGaussian(handles.currentImage, sigma);

        if handles.laplacianOfGaussianSave

            % Save feature as image
            fileNameParts = strsplit(inFileName, '.');
            fileNameParts{1} = [fileNameParts{1} '-log'];
            outFileName = [fileNameParts{1} '.png'];
            imwrite(convResult, [outFolder filesep outFileName])

        end
    end
    
    if get(handles.watershedCheck, 'Value')
        
        % Watershed-based parameters
        
        segmentation_options.foregroundThresh = str2double(get(handles.watershedParamEdit, 'String'));
        segmentation_options.mergeRegions = get(handles.mergeCheck, 'Value');
        segmentation_options.mergeIntersectionRatio = ...
            str2double(get(handles.mergingParamEdit, 'String'));
        segmentation_options.filterSmallRegions = get(handles.filterCheck, 'Value');
        segmentation_options.saveResults = get(handles.watershedSaveCheck, 'Value');
        
        % Watershed-based segmentation
        
        showWatershedPrepSteps = false;

        fileNameParts = strsplit(inFileName, '.');
        fileNameParts{1} = [fileNameParts{1} '-segm'];
        handles.bBoxFileName = [outFolder filesep fileNameParts{1} '.mat'];

        minArea = pi * str2double(get(handles.minCellDiameterParamEdit, 'String'))^2 / 4;
        maxArea = pi * str2double(get(handles.maxCellDiameterParamEdit, 'String'))^2 / 4;

        % Call watershed over preparation steps
        [handles.hDetectionResults, handles.watershedLabels] = ...
            watershedBasedSegmentation(handles.currentImage, convResult,...
            handles.bBoxFileName, showWatershedPrepSteps,....
            [minArea, maxArea], segmentation_options);

        
    end
    
    handles = irfSegStdout(handles, ['Done.']);


end

handles = irfSegStdout(handles, ['Segmentation finished! - Results saved in folder '''...
    outFolder '''']);

guidata(hObject, handles);


% --- Executes on button press in filterCheck.
function filterCheck_Callback(hObject, eventdata, handles)
% hObject    handle to filterCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of filterCheck



function inputFolderEdit_Callback(hObject, eventdata, handles)
% hObject    handle to inputFolderEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputFolderEdit as text
%        str2double(get(hObject,'String')) returns contents of inputFolderEdit as a double


% --- Executes during object creation, after setting all properties.
function inputFolderEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputFolderEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in outputFolderButton.
function outputFolderButton_Callback(hObject, eventdata, handles)
% hObject    handle to outputFolderButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ischar(handles.lastSavingFolder)
    [fileName, pathName, unusedVar] = uigetfile('*.tif; *.tiff; *.png', 'Open', handles.lastSavingFolder);
else
    [fileName, pathName, unusedVar] = uigetfile('*.tif; *.tiff; *.png', 'Open', pwd());
end

if ischar(fileName) && ischar(pathName)
    
    handles.lastSavingFolder = pathName;
    
    set(handles.outputFolderEdit, 'String', pathName);
    

end

handles = irfSegStdout(handles, ['']);
 
guidata(hObject, handles);


function outputFolderEdit_Callback(hObject, eventdata, handles)
% hObject    handle to outputFolderEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of outputFolderEdit as text
%        str2double(get(hObject,'String')) returns contents of outputFolderEdit as a double


% --- Executes during object creation, after setting all properties.
function outputFolderEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outputFolderEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function openStackMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to openStackMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ischar(handles.lastOpeningFolder)
    [fileName, pathName, unusedVar] = uigetfile('*.tif; *.tiff; *.png', 'Open', handles.lastOpeningFolder);
else
    [fileName, pathName, unusedVar] = uigetfile('*.tif; *.tiff; *.png', 'Open', pwd());
end

if ischar(fileName) && ischar(pathName)
    
    handles.lastOpeningFolder = pathName;
    
    handles.templateFileName = fileName;
    handles.openingSampleStack = false;
    
    set(handles.inputFolderEdit, 'String', pathName);
    

end

handles = irfSegStdout(handles, ['']);

guidata(hObject, handles);


% --------------------------------------------------------------------
function handles = irfSegStdout(handles, msg)

set(handles.logText, 'String', msg);

disp(msg)

