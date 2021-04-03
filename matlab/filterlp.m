function y=filterlp(x, Ns, fL, Fs, IL)
%function y=filterlp(x, Ns, fL, Fs, IL)
% x: input signal (time domain)
% Ns: number of sections
% fL: lower cutoff frequncy in Hz
% Fs: sampling frequency of signal x in Hz
% IL: Insertion loss in dB
% y: output signal (time domain)

c=10^(-IL/20);

Fn=2*fL/Fs;
[B,A]=butter(Ns,Fn);
y=filtfilt(B,A,x);
y=c*y;

%eof