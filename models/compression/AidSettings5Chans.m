%% script [AidSettingsXChans.m] where X is [1, 3, 5, 8, 12, 16, or 22]
%% Presumes that [NChans] has been set externally
%aligndelaymsec = 2.5; %% time delay for audio alignment with gain signal (post Fullgrabe et al, 2010 or 2011)
%%% remaining data should be 1-D arrays with NChans of parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% compression channel data, cf = 0 if not active, all arrays should be same length
%% compression thresholds specified relative to channel SPL for 65 dB input: FIXED in [update_channel_params]
chan_cfs = [500 1000 2000 4000 8000];%% assumed geometric spacing : edges/crossovers will be ratio spaced
t_atts = [200 100 100 100 100]; %% attack times msec
t_rels = [2000 1500 1200 1000 1000]; %% msec
%chan_crs = [2 2 2 2 2];
chan_crs = [5 5 5 5 5];
chan_thrs = [-15 -15 -10 -5 0]; %% dB rel channel RMS when carrying 65 dB SWN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Channel limiter settings: compression ratios FIXED in dualchannel_AGC (100)
deltaFSdB = [13  13  12  11  10]; %% Limiter threshold distance above slower compression mean (ie tracking ONLY)
pcact = zeros(size(deltaFSdB)); %% leave at 0, but NChans worthpercentage of time that limiter was active, updates every [recalculate]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% auto-populate limiter attack and release times from (a) minimum value for each and (b) ratio of change from high freq down to low
ta_min  = 2; ta_range = 3; %% minimum attack time for limiter, and multiplier to increase it towards lower freq chans
ta_lims = ta_min * (1 +  ((NChans:-1:1)./NChans)*(ta_range-1));
ta_lim    = round(min(t_atts/2, ta_lims)); %% Limiter attack times
tr_min  = 40; tr_range = 2; %% minimum release time for limiter, and multiplier to increase it towards lower freq chans
tr_lims = tr_min * (1 +  ((NChans:-1:1)./NChans)*(tr_range-1));
tr_lim   = round(min(t_rels/2, tr_lims)); %% Limiter release times
