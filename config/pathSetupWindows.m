% pathSetupWindows Setup required paths for Simulink development
%
% This file is used to define and setup all paths required for Simulink development.
% Users need to add their FPGA Open Speech Tools root folder where all of the 
% git repositories are. They also need to add the path to their Quartus installation.

% Copyright 2020 Flat Earth Inc, Montana State University
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
% INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
% PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
% FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
% ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%
% Ross Snider, Trevor Vannoy
% Flat Earth Inc
% 985 Technology Blvd
% Bozeman, MT 59718
% support@flatearthinc.com

%% Git Repository Setup
% Add your git path to the cell array selection below so it will be found
% the next time you run Simulink.
% The first directory that Matlab finds that exists will be used.
localGitPath{1} = 'C:\Users\bugsbunny\research\NIH';
localGitPath{2} = 'V:\MSU\GitHub\';
validIndex = 0;
for index=1:length(localGitPath)
    if exist(localGitPath{index},'dir') 
        validIndex = index;
    end
end
if validIndex > 0
    gitPath = localGitPath{validIndex};
else
    error('Local Git repository not found.  Please add your Git path to pathSetupWindows.m');
end

%% Setup Matlab/Simulink paths
% These paths are required for developing simulink models and autogenerating code.
% It is intended that users put the FPGA Open Speech Tools repositories
% all in the same root folder (gitPath).

% TODO: change struct field names to match coding style; this struct
%       is used all over the place, so this will require some global refactoring
mp.model_path           = [gitPath '\simulink_models\models\' mp.model_name];
mp.test_signals_path    = [gitPath '\simulink_models\test_signals'];
mp.vhdl_codegen_path    = [gitPath '\simulink_codegen\vhdl'];
mp.driver_codegen_path  = [gitPath '\simulink_codegen\device_drivers'];
mp.ui_codegen_path      = [gitPath '\simulink_codegen\ui'];

%% Quartus Setup
% Add your Quartus path to the cell array selection below so it will be found
% the next time you run Simulink.
% The first directory that Matlab finds that exists will be used.
localQuartusPath{1} = 'C:\intelFPGA_lite\18.1\quartus\bin64';
localQuartusPath{2} = 'D:\intelFPGA_lite\18.1\quartus\bin64';
validIndex = 0;
for index=1:length(localQuartusPath)
    if exist(localQuartusPath{index},'dir') 
        validIndex = index;
    end
end
if validIndex > 0
    quartusPath = localQuartusPath{validIndex};
else
    error('Local Quartus install not found.  Please add your Quartus path to pathSetupWindows.m');
end
mp.quartus_path = quartusPath;

%% Setup Python paths
% Add your Python path to the cell array selection below so it will be found
% the next time you run Simulink.
% The first directory that Matlab finds that exists will be used.
localPythonPath{1} = 'F:\Python\Python37';
localPythonPath{2} = 'C:\Anaconda3';
validIndex = 0;
for index=1:length(localPythonPath)
    if exist(localPythonPath{index},'dir') 
        validIndex = index;
    end
end
if validIndex > 0
    pythonPath = localPythonPath{validIndex};
else
    error('Local python path not found. Please add your python path to pathSetupWindows.m');
end
mp.pythonPath = pythonPath;

% make sure Matlab is using the version of Python that you specified
[pythonVersion, pythonExe, pythonLoaded] = pyversion;
if  pythonLoaded
    disp(['Using Python version ' pythonVersion])
else
    % NOTE: if the version changes from what is already loaded in Matlab, you will need to restart 
    pyversion([mp.pythonPath, '\python.exe']);
    [pythonVersion, pythonExe, pythonLoaded] = pyversion;
    disp(['Setting Python to version ' pythonVersion])
end

% add the codegen_path to python's search path
if count(py.sys.path,mp.vhdl_codegen_path) == 0
    insert(py.sys.path,int32(0),mp.vhdl_codegen_path);
end
if count(py.sys.path,mp.driver_codegen_path) == 0
    insert(py.sys.path,int32(0),mp.driver_codegen_path);
end

%% Add the paths to the current Matlab session
addpath(mp.model_path)
addpath(mp.driver_codegen_path)
addpath(mp.vhdl_codegen_path)
addpath(mp.ui_codegen_path)
addpath(mp.test_signals_path)
hdlsetuptoolpath('ToolName', 'Altera Quartus II', 'ToolPath', mp.quartus_path);

%% Print out the paths
disp(['------------------------------------------------'])
disp(['Setting up the the following path parameters'])
disp(['Local GitHub repository path = ' localGitPath])
disp(['Simulink model path          = ' mp.model_path])
disp(['Test signals path            = ' mp.test_signals_path])
disp(['VHDL Codegen path            = ' mp.vhdl_codegen_path])
disp(['Driver Codegen path          = ' mp.driver_codegen_path])
disp(['UI Codegen path              = ' mp.ui_codegen_path])
disp(['Quartus path                 = ' mp.quartus_path])
disp(['------------------------------------------------'])