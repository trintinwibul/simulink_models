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
% Ross K. Snider
% Audio Logic
% 985 Technology Blvd
% Bozeman, MT 59718
% openspeech@flatearthinc.com

%% Verify that the test data got encoded, passed through the model, and
% decoded correctly.  The input (modified by gain) and output values should be identical.

close all;

dprData = squeeze(read_data.Data);

figure(1)
subplot(2,1,1)
plot(testSignal.audio(:,1)); hold on
plot(dataOut.Data(:,1))
title('Left channel')
legend('input', 'output')

subplot(2,1,2)
plot(testSignal.audio(:,2)); hold on
plot(dataOut.Data(:,2))
title('Right channel')
legend('input', 'output')

figure
hold on
plot(input_data)
plot(dprData(514:1025),'--')
hold off
title('Right channel')
legend('Write Data', 'Read Data')



% original_audio = [mp.test_signal.left(:) mp.test_signal.right(:)];
% processed_audio = [mp.left_data_out(:) mp.right_data_out(:)];
% soundsc(original_audio, mp.Fs);
% pause(mp.test_signal.duration*1.1);
% soundsc(processed_audio, mp.Fs);
