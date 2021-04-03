function y=siglo(t,PdBm,Fo,Tol)
%function xosc=siglo(t,PdBm,fo,tol)
% Generate a real Local Oscillator Signal
% INPUT
%   t = time variable
%   P = Output power of local oscillator in dBm
%   Fo = Frequency of Local Oscillator in MHz
%   Tol = Acceptable level of frequency tolerance in Percentage
% OUTPUT
%   y : output signal waveform
%--------------------------------------------------------------

Zc=50; 				            % 50 Ohm system
P_W=10^(PdBm/10)/1000;		    % power in Watt

Vmax=sqrt(2*Zc*P_W);		    % Voltage amplitude
f=Fo*(1+rand(size(t))*Tol); 	% Frequency
y=Vmax*cos(2*pi*f.*t);

%eof