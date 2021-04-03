
clear all
close all

c0=round(rand(1,12));

Fc= 1250.0e6;    % carrier frequency
Fs=16*Fc;      % sampling frequency
Fd=Fs/8000;     % Baud rate

M=4;
opt=0;

SNR1 = -10; %SNR for transmitter(dB)
PdBm = 0; % Signal Power
BW = 500e3; % Bandwidth in Hz

% Generate 3 signals 
[t0, u1] = sigpsk(c0, Fc, Fd, Fs, M, opt);

%add white noise
u2= awn(u1,SNR1,PdBm);

% % Amplifer
Gain=10;    % Gain in dB
NF = 3;     % Noise Figure in dB
u3=amp1(u2,Gain,NF,BW);

fl=1200e6; 
fh=1300e6; 
u4=filterbp(u3,1,fl,fh,Fs,0.9);

ut1=[u1;u2;u3;u4];
marker1=['PureSig'; 'Sig+Noi'; 'Aft Amp';'Aft BPF'];
figure(1); scopet(t0,ut1,marker1,1)
figure(2); scopef(Fs,ut1,marker1,1)


% demodulation
u8code = demodpsk(u4,Fc,Fs,Fd,M);
figure(3); 
plotcodes(c0,u8code)

%eof