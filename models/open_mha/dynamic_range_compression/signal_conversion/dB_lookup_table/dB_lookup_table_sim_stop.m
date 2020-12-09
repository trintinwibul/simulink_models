% dB_lookup_table_sim_stop.m
%
% The following script is designed to isolate and test the dB Lookup Table
% simulation results against expected results calculated via openMHA source
% code methods.
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
% dB Lookup Table Test/Verification Simulation Stop Script
% 11/18/2020

%% Calculate openMHA Results

level_in_db_matlab = 10.*log10(2500000000.*double(level_in));
% *** openMHA Source File, Function Call: dc.cpp 
% *** openMHA Source File, Function Call Lines: 406 (pa22dbspl)
% *** openMHA Source File, Computation: mha_signal.hh 
% *** openMHA Source File, Computation Lines: 90-98 

%% Compare Results

% Error calculations
% level_in = level_in';
% level_in_db_matlab = level_in_db_matlab';
% diff = abs(out.level_in_db(4:end-4) - level_in_db_matlab(4:end-4));
% percdiff = 100.*(diff./level_in_db_matlab(4:end-4));
% [maxpercdiff, mpdidx] = max(percdiff);
% [maxdiff, mdidx] = max(diff);
% avgpercdiff = sum(percdiff)/length(percdiff);
% 
% % Display results
% % disp('Maximum Percent Difference = ');
% % disp(maxpercdiff);
% % disp('Maximum Difference = ');
% % disp(maxdiff);
% % disp('Average Percent Difference');
% % disp(avgpercdiff);
% 
% avgdiff        = sum(diff)/length(diff);
% bitprecision   = -log2(avgdiff);
% guaranteedbits = -log2(maxdiff);

%% Plotting Resulting I/O Characteristics
figure()
% subplot(2,1,1)
% semilogx(level_in)
% % hold on
% % plot(level_in_2)
% title('Input Signal')
% legend('dB to PA2', 'Equally Spaced PA2')

% subplot(2,1,2)
semilogx(level_in,level_in_db_matlab);
hold on;
plot(level_in,level_in_db,'--');
hold on;
plot(level_in,lookup_table)
legend('MATLAB','Programmable Look Up Table', '1D Look Up Table');
xlabel('Input Level [Pa^2]');
ylabel('Input Level [dB]');
title('Dual-Port dB Lookup Table: Actual vs. Expected Results');



