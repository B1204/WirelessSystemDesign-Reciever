
function y= awn(x,SNRdB,PdBm)
%function y= awn(x,SNRdB,PdBm)
% Add White Guassian Noise to a signal
% INPUT
%    x    : pure signal vector
%    SNR  : in dB
%    PdBm : Signal power in dBm (assuming 50 Ohm system)
% OUTPUT
%    y    : signal vector (in V) with specified PdBm and SNR

Zc=50; 				% 50 Ohm system
P_W=10^(PdBm/10)/1000;		% power in Watt

Vmax=sqrt(2*Zc*P_W);		% Voltage amplitude

Xmean=mean(x); x=x-Xmean;  	% remove DC component if any
Xmax=max(x); x=Vmax*x/Xmax; 	% normalize x
y=awgn(x,SNRdB,PdBm-30); 

%eof 
