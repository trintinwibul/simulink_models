% Copyright 2020 Flat Earth Inc
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
% INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
% PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
% FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
% ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%
% Matthew Blunt & Hezekiah Austin
% Flat Earth Inc
% 985 Technology Blvd
% Bozeman, MT 59718
% support@flatearthinc.com

% Auditory Nerve Simulink Model Code
% IHC_Lowpass_Test_Parameters
% 06/26/2019

% clear all;
% close all;

%% NOTES

% The following script is designed as an init script for the IHC Lowpass
% Filter Simulink model. It sets the parameters for both the 
% Simulink model and the comparison MATLAB function. In addition, it 
% provides the test signal, set to a frequency sweep from 125 Hz to 20000 
% Hz in 4 seconds, sampled at 48 kHz.


%% AN MODEL INPUTS

% Overall AN model inputs

% Characteristic frequency of specific neuron, chosen arbitrarily for
% testing (but must be greater than 125 - see model_IHC_BEZ2018)
cf = 1000;

% Sampling frequency
Fs = 48e3;

% Binsize in seconds
tdres = 1/Fs;

% Number of repititions for peri-stimulus time histogram
nrep = 100; 

% Impairment constants
cohc = 1; 
cihc = 1; 

% Species (1 for cat, 2 or 3 for human)
species = 2;

%% IHC LOWPASS FILTER PARAMETERS

% Declaring 2 pi constant
TWOPI= 6.28318530717959; 

% Function Inputs:
Fcihc = 3000;
gainihc = 1.0;
orderihc = 7;

% Calculated Constants
C = 2.0/tdres;
c1LPihc = ( C - TWOPI*Fcihc ) / ( C + TWOPI*Fcihc );
c2LPihc = TWOPI*Fcihc / (TWOPI*Fcihc + C);

% Filter Coefficients Matrix
% Coefficients are order as follows
%       [b01 b11 b21 a01 a11 a21]
%       [b02 b12 b22 a02 a12 a22]
%               * * *
%       [b0m b1m b2m a0m a1m a2m]
% Added for the Direct Form implementation by Hezekiah Austin 03/10/2020
INCLPcoeffs = [  gainihc*c2LPihc gainihc*c2LPihc 0 1 -c1LPihc 0;
                c2LPihc c2LPihc 0 1 -c1LPihc 0;
                c2LPihc c2LPihc 0 1 -c1LPihc 0;
                c2LPihc c2LPihc 0 1 -c1LPihc 0;
                c2LPihc c2LPihc 0 1 -c1LPihc 0;
                c2LPihc c2LPihc 0 1 -c1LPihc 0;
                c2LPihc c2LPihc 0 1 -c1LPihc 0];

%% TEST SIGNAL

% Test signal set to chirp signal moving linearly over time from 125 Hz to
% 20000 Hz, sampled at 48 kHz.

% read in chirp signal
[tone,fs] = audioread('AN_test_tone.wav');

% Assign to variable used in model
% *** Changed to single precision by Hezekiah Austin 03/03/2020
RxSignal = single(tone);

% Added a doubles signal of test/verification of singles
% *** Added by Hezekiah Austin 03/03/2020
RxSignal_doubles = tone;

% Find test time, which is set in model
testtime = length(RxSignal)/Fs

% end of script

