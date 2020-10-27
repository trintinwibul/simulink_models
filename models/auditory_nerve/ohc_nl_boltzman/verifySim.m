% mp = sm_stop_verify(mp)
%
% Matlab function that verifies the model output 

% Inputs:
%   mp, which is the model data structure that holds the model parameters
%
% Outputs:
%   mp, the model data structure that now contains the left/right channel
%   data, which is in the following format:
%          mp.left_data_out         - The processed left channel data
%          mp.left_time_out         - time of left channel data
%          mp.right_data_out        - The processed right channel data
%          mp.right_time_out        - time of right channel data
%
% Copyright 2019 Audio Logic
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
% INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
% PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
% FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
% ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%
% Connor Dack
% Audio Logic
% 985 Technology Blvd
% Bozeman, MT 59718
% openspeech@flatearthinc.com

%% 
close all;
mex Boltzman.c

data_input  = testSignal.audio(:,1) .* 500;
% data_input  = testSignal.audio(:,1);
nl_boltzman = zeros(1,length(data_input));

for i = 1:length(data_input)
    nl_boltzman(1,i) = Boltzman(data_input(i), ohcasym, s0, s1, x1);
end

figure
subplot(2,1,1)
plot(data_input)
legend('CP WBGTF Input Wave')
title('Audio Input')

sim_out = mp.dataOut;
subplot(2,1,2)
plot(nl_boltzman)
hold on
plot(sim_out)
legend('C Source Code','Simulink')
title('C Source Code vs Simulink Output')