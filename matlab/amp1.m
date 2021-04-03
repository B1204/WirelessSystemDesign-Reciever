function y=amp_lin(x,Gain,NF,BW)
%function y=amp_lin(x,Gain,NF,BW)
% Linear model: y=C1*(x+Ec)
% INPUT 
%  x    : input signal in V (50 Ohm system)
%  Gain : Gain in dB
%  NF   : Noice figure in dB
%  BW   : Channel bandwidth in Hz

G=10^(Gain/20); 		% Voltage gain in ratio
F=10^(NF/10); 			% Noice Factor

k=1.38e-23;                 	% Boltzman constant
T=290;                      	% Temperature
Nc=(F-1)*k*T*BW;            	% Noise power
Em=sqrt(4*50*Nc);           	% RMS magnitude of noise emf
en=Em*randn(1,length(x));   	% Noise emf

y=G*(x+en);

%eof