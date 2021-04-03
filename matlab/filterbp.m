function y=filterbp(x, Ns, fL, fH, Fs, IL)
%function y=filterbp(x, Ns, fL, fH, Fs, IL)
% x: input signal (time domain)
% Ns: number of sections
% fL: lower cutoff frequncy in Hz
% fH: higher cutoff frequncy in Hz
% Fs: sampling frequency of signal x in Hz
% IL: Insertion loss in dB
% y: output signal (time domain)

c=10^(-IL/20);

fLow=2*fL/Fs;
fHigh=2*fH/Fs;
Fn=[fLow fHigh];
[B,A]=butter(Ns,Fn);
y=filtfilt(B,A,x);
y=c*y;

%eof