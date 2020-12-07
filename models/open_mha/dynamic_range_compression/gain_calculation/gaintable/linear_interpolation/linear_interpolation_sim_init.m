% Copyright 2020 Audio Logic
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
% INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
% PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
% FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
% ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%
% Matthew Blunt
% Audio Logic
% 985 Technology Blvd
% Bozeman, MT 59718
% openspeech@flatearthinc.com

% openMHA Dynamic Compression Simulink Model Code
% Gain Table Test/Verification Simulation Init Script
% 11/18/2020

% clear all;
% close all;

%% NOTES

% The following script is designed as an init script for the Gain Table
% Simulink model. It sets the parameters for both the 
% Simulink model and the comparison MATLAB computation. In addition, it 
% provides the test signals for the Simulink Model.

%% Model Parameters
fs = 48e3;
sim_length = 1000;
time = (0:sim_length-1) ./ fs;
stop_time = time(end);

%% Simulation Type - Either 'double' or 'fxpt'
sim_type = 'fxpt';                  

% Gain - Fixed Point Paramters
gain_coeff_fp_size = 16; % Word Size
gain_coeff_fp_dec  = 8;  % Fractional Bits
gain_coeff_fp_sign = 1;  % Unsigned = 0, Signed = 1

% Prelook Up Table: Fractional - Fixed Point Paramters
frac_coeff_fp_size = 16; % Word Size
frac_coeff_fp_dec  = 8;  % Fractional Bits
frac_coeff_fp_sign = 1;  % Unsigned = 0, Signed = 1

% Define the Input Data Types
if(strcmp(sim_type,'double'))
    gain_coeff_type = 'double';
    frac_coeff_type = 'double';
elseif(strcmp(sim_type,'fxpt'))
    gain_coeff_type = fixdt(gain_coeff_fp_sign,gain_coeff_fp_size,gain_coeff_fp_dec);
    frac_coeff_type = fixdt(frac_coeff_fp_sign,frac_coeff_fp_size,frac_coeff_fp_dec);
end
%% Simulation Input Signals
in_low  = timeseries(1:sim_length,time);
in_high = timeseries((1:sim_length) * 10,time);
in_frac = timeseries(rand(sim_length,1),time);