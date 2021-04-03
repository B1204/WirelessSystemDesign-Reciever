function y = mixer1(sigRF,sigLO,Gain,NF,BW)
%function y = mixer1(sigRF,sigLO,Gain,NF,BW)
% INPUT
%   sigRF : RF signal obtained from the previous stage
%   sigLO : Local oscillator signal
%   Gain  : Gain in dB
%   NF    : Noise figure in dB
%   BW    : Bandwidth in Hz

k=1.38e-23;                 	% Boltzman constant
T=290;                      	% Room temperature

G=10^(Gain/10); 		% gain in ratio
F=10^(NF/10); 			% noice factor
Nc=(F-1)*k*T*BW;            	% Noise power
Em=sqrt(4*50*Nc);           	% RMS magnitude of noise emf
en=Em*randn(1,length(sigRF));	% Noise emf

x=sigRF.*sigLO; 
y=G*(x+en);

%eof