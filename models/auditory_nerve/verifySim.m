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

data_input            = testSignal.audio(:,1);
c1_chirp_filter       = zeros(1,totalstim);
c2_wideband_filter    = zeros(1,totalstim);
inner_hair_cell_out   = zeros(1,totalstim);

totalstim  = length(data_input);
wbout      = zeros(1,totalstim);
ohc_sim    = zeros(1,totalstim);
c_grdelay   = zeros(1,totalstim);
c_rsigma   = zeros(1,totalstim);
c_tauc1   = zeros(1,totalstim);
c_tauwb   = zeros(1,totalstim);
c_wbgain   = zeros(1,totalstim);

%% Complete Auditory Nerve
mex C1ChirpFilt.c complex.c
mex C2ChirpFilt.c complex.c
mex inner_hair_cell_source.c complex.c
mex WbGammaTone.c complex.c
mex outer_hair_cell_source.c
mex calc_tau_source.c

middle_ear_filter_out = mef_verification(data_input,tdres);
for i = 1:totalstim
    if(i == 1)
        wbout(1,i) = WbGammaTone(middle_ear_filter_out(i),tdres,centerfreq,i-1,tauwb_i,wbgain_i,wborder, TauWBMax, cf);
    else
        wbout(1,i) = WbGammaTone(middle_ear_filter_out(i),tdres,centerfreq,i-1,c_tauwb(1,i-1),c_wbgain(1,i-1),wborder, TauWBMax, cf);
    end
    ohc_sim(1,i) = outer_hair_cell_source(wbout(1,i), ohcasym, s0, s1, x1, tdres, Fcohc, i-1, gainohc, orderohc, taumin, taumax);
    [c_grdelay(1,i), c_rsigma(1,i), c_tauc1(1,i), c_tauwb(1,i), c_wbgain(1,i)] = calc_tau_source(tdres, cf, centerfreq, ohc_sim(1,i));
    c1_chirp_filter(1,i) = C1ChirpFilt(middle_ear_filter_out(i), tdres, cf, i-1, taumax, c_rsigma(1,i));
    c2_wideband_filter(1,i) = C2ChirpFilt(middle_ear_filter_out(i), tdres, cf, i-1, taumaxc2, fcohcc2);
    inner_hair_cell_out(1,i) = inner_hair_cell_source(c1_chirp_filter(i), slope_c1, ihcasym_c1, c2_wideband_filter(i), slope_c2, ihcasym_c2, tdres, Fcihc, i-1, gainihc, orderihc);
end
pla_nl_out = NLBeforePLA(inner_hair_cell_out, totalstim, spont, cf);
syn_out    = PowerLaw(pla_nl_out, totalstim, randNums, Fs);

%% Plot the Results
figure
subplot(2,1,1)
plot(middle_ear_filter_out)
legend('Input Wave')
title('Audio Input')

sim_out = mp.dataOut;
subplot(2,1,2)
plot(syn_out)
hold on
plot(sim_out,'--')
legend('C Source Code','Simulink')
title('Auditory Nerve Simulink Simulation')
