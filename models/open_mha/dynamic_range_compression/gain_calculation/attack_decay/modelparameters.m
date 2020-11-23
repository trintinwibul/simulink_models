% modelparameters.m  
%
% Copyright 2020 AudioLogic, Inc
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
% INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
% PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
% FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
% ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%
% Connor Dack
% AudioLogic, Inc
% 985 Technology Blvd
% Bozeman, MT 59718
% openspeech@flatearthinc.com

%% Initialize
addpath(genpath('..\attack_decay_filter'));        % Location of the o1_lp_coeffs function
addpath(genpath('..\..\..\referenced_functions')); % Location of the Dual Port RAM

%% Autogen parameters
mp.testFile = [mp.test_signals_path filesep 'auditory_nerve\mef_result_subset.wav'];

% Open MHA Parameters 
fs = 48e3;
coeff_size = 8;
num_bands  = 8;
num_coeff  = 2;

% Data Input Array
band_num_input = [1:1:num_bands num_bands:-1:1];
band_num_input = [band_num_input band_num_input band_num_input band_num_input band_num_input];

mp.sim_prompts = 1;
mp.sim_verify = 1;
mp.simDuration = 15;
mp.nSamples = length(band_num_input);
mp.useAvalonInterface = false;

mp.W_bits = 24;
mp.F_bits = 23;

%% Attack and Decay DPRAM Parameters
% Create tau values to generate C1 Coefficients between 0 and 1
tau_as = -1 ./ (log([0:1:num_bands-1] ./ num_bands) * fs);
tau_ds = -1 ./ (log([num_bands-1:-1:0] ./ num_bands) * fs);
% Initialization
ad_coeffs = fi(zeros(2^coeff_size,1),0,16,16);

% Create the Coefficient Array
z = 1;
for i = 1:2:2*num_bands-1
    [attack_c1, ~]   = o1_lp_coeffs(tau_as(z), fs);
    ad_coeffs(i,1)   = fi(attack_c1,0,16,16);
    [decay_c1, ~]    = o1_lp_coeffs(tau_ds(z), fs);
    ad_coeffs(i+1,1) = fi(decay_c1,0,16,16);
    z = z+1;
end
time = (0:1:length(band_num_input)-1) *1/fs;
band_num_timeseries = timeseries(uint8(band_num_input),time);
