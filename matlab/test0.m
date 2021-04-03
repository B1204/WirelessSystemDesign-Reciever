
clear all
close all

% Generate 3 signals using Phase Shift Keying 
c0=round(rand(1,12)); % message signal symbol
Fc= 1250.0e6;    % Carrier Frequency = 1250 Mhz
Fs=16*Fc;      % sampling frequency, +ve
Fd=Fs/10000;     % Baud rate
M=4; % mary number
opt=0; % phase-in-circle value

[t0, u01] = sigpsk(c0, Fc, Fd, Fs, M, opt);

% Add White Noise
SNR1 = 10; %SNR for transmitter(dB)
PdBm = 0; % Signal Power

u02= awn(u01,SNR1,PdBm);

% % 1. RF2411 LNA
Gain1=14;    % Gain in dB 
NF1 = 1.6;     % Noise Figure in dB
BW = 2e6; % Bandwidth in Hz = 2 Mhz

u1=amp1(u02,Gain1,NF1,BW);

%% 2. K&L BPF
Ns2=1; % number of sections
fL2=1200e6; % lower cutoff frequency in Hz
fH2=1300e6; % higher cutoff frequency in Hz
il2=0.9; % Insertion Loss in dB
u2=filterbp(u1,Ns2,fL2,fH2,Fs,il2);

%% 3. RF2411 Mixer

% LO 
PLOout3 = 0; % output power in dBm 
FLO3 = 1180e6; % Frequency in Hz 
TOL3 = 0; % Frequency stability in percentage 
sigLO3=siglo(t0,PLOout3,FLO3,TOL3); % Mixer 

Gain3=11; % Gain in dB 
NF3 = 11; % Noise Figure in dB
u3=mixer1(u2,sigLO3,Gain3,NF3,BW);

%% 4. VECTRON SAW for channel selection(Min BW in Hz= 2e6) and image rejection(Max 1 dB BW in Hz=7.50)
% Choosing min insertion loss
il4=22; % Insertion Loss in dB
Ns4=1; % number of sections
fL4=61e6; % lower cutoff frequency in Hz
fH4=79e6; % higher cutoff frequency in Hz
u4=filterbp(u3,Ns4,fL4,fH4,Fs,il4);

%% 5. PC2798GR AGC Mixer

% LO 
PLOout5 = 0; % output power in dBm 
FLO5 = 68e6; % Frequency in Hz 
TOL5 = 0; % Frequency stability in percentage 
sigLO5=siglo(t0,PLOout5,FLO5,TOL5); % Mixer 

Gain5=25; % Gain in dB 
NF5 = 9; % Noise Figure in dB
u5=mixer1(u4,sigLO5,Gain5,NF5,BW);

% Low Pass Filter
Ns = 4; 
Fc = 2.0e6; 
IL = 1.0; 
u05=filterlp(u5,Ns,Fc,Fs,IL);

%% 6. PC2798GR Amplifer

Gain2=22.5;    % Gain in dB 
NF2 = 1;     % Noise Figure in dB

u6=amp1(u05,Gain2,NF2,BW);

%% 7. PC3206GR AGC

Gain3=38;    % Gain in dB 
NF3 = 5.5;   % Noise Figure in dB

u7=amp1(u6,Gain3,NF3,BW);

% Low Pass Filter
Ns = 4; 
Fc = 2.0e6; 
IL = 1.0; 
u07=filterlp(u7,Ns,Fc,Fs,IL);

%% 8. PC3206GR AGC2

Gain3=11;    % Gain in dB 
NF3 = 1;   % Noise Figure in dB

u8=amp1(u07,Gain3,NF3,BW);

%% Visualize outputs

% freqency and time plots
ut1=[u01;u02;u1;u2;u3;u4;u5;u05;u6;u7;u07;u8];
marker1=['PureSig'; 'Sig+Noi'; 'Aft Amp'; 'Aft BPF'; 'Aft Mix'; 'Aft Saw'; 'Aft Mix'; 'Aft LPF'; 'Aft Amp'; 'Aft AGC'; 'Aft LPF'; 'Aft Amp'];
figure(1); scopet(t0,ut1,marker1,1) 
figure(2); scopef(Fs,ut1,marker1,1) 

% demodulation
u8code = demodpsk(u07,2e6,Fs,Fd,M);
figure(3); 
plotcodes(c0,u8code) % Plot Codes

%eof