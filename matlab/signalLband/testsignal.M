clear all ;
close all;
%function sigpsk(c0, fc, fd, fs, M, pic)
c0=[1 0 0 1 1 0 1 0]; 
Fc=1250e6; 
Fs=8*Fc; 
Fd=Fs/10000; 
M=2; % BPSK 
pic=0; 
[t0, u1] = sigpsk(c0, Fc, Fd, Fs, M, pic); 

SNR1 = 0; %SNR for transmitter(dB)
PdBm = -10; % Signal Power
y1= awn(u1,SNR1,PdBm);

Fc1=1246e6;
c1=round(rand(1,8)); 
[t0, u11] = sigpsk(c1, Fc1, Fd, Fs, M, pic); 
SNR1 = -10; %SNR for transmitter(dB)
PdBm = 15; % Signal Power
o1= awn(u11,SNR1,PdBm);

Fc2=1254e6;
c2=round(rand(1,8)); 
[t0, u12] = sigpsk(c2, Fc2, Fd, Fs, M, pic); 
SNR1 = 0; %SNR for transmitter(dB)
PdBm = 13; % Signal Power
o2= awn(u12,SNR1,PdBm);

Fc3=1110e6;
c3=round(rand(1,8)); 
[t0, u13] = sigpsk(c3, Fc3, Fd, Fs, M, pic); 
SNR1 = 50; %SNR for transmitter(dB)
PdBm = 10; % Signal Power
o3= awn(u13,SNR1,PdBm);

Fc4=1390e6;
c4=round(rand(1,8)); 
[t0, u14] = sigpsk(c4, Fc4, Fd, Fs, M, pic); 
SNR1 = 60; %SNR for transmitter(dB)
PdBm = 15; % Signal Power
o4= awn(u14,SNR1,PdBm);

testsig=y1+o1+o2+o3+o4;

%[xosin] = demodpsk(y1,Fc,Fs,Fd,M); 
%plotcodes(c0,xosin);


%Gain=20; % dB 
%P1dB=3; % dBm 
%OIP3=35; % dBm 
%Pmax = 25; % dBm 
%NF=2.9; % dB 
%BW = 500e3; % Hz 
%ampbcd=abcd(Gain,P1dB,OIP3,Pmax); 
%y2=amp3(y1,ampbcd,NF,BW); 
% 
% 
% Gain =  10;
% NF = 3;
% BW = 1000;
% 
% y21=amp1(y1,Gain,NF,BW);
% 
% Ns = 4; % Number of sections in cascade. 
% fL = 1e6; % Lower passband frequency; 
% fH = 5e6; % Higher passband frequency; 
% IL = 0; % Insertion loss (in dB). 
% 
% y2=filterbp(y21, Ns, fL,fH, Fs, IL); 
% 
% 
%    PP = 10;
%    fo = 1.8e6;
%    tol = 0;
% ylo=siglo(to,PP,fo,tol);
% 
% Gain = 1;
% NF = 3;
% BW = 100;
% 
% y3 = mixer1(y2,ylo,Gain,NF,BW);
% 
% Ns = 4; % Number of sections in cascade. 
% fL = 1e6; % Lower passband frequency; 
% fH = 1.4e6; % Higher passband frequency; 
% IL = 0; % Insertion loss (in dB). 
% 
% y4=filterbp(y3, Ns, fL,fH, Fs, IL); 
% 
% 
% PP = 20;
%    fo = 1e6;
%    tol = 0;
% 
% ylo=siglo(to,PP,fo,tol);
% 
% Gain = 1;
% NF = 3;
% BW = 100;
% 
% 
% y6 = mixer1(y4,ylo,Gain,NF,BW);
% 
% Ns = 4; % Number of sections in cascade. 
% %fL = 1e6; % Lower passband frequency; 
% fH = 0.5e6; % Higher passband frequency; 
% IL = 0; % Insertion loss (in dB). 
% 
% y7=filterlp(y6, Ns,fH, Fs, IL); 

figure;
scopet(t0,[testsig],['SIG'],1); 

figure;
scopef(Fs,[testsig],['SIG'],1); 
%Fc=0.2e6;
[xfinal] = demodpsk(testsig,Fc,Fs,Fd,M); 
%scopet(t,[xsin;xcos],['xsin';'xcos'],3); 
figure;

plotcodes(c0,xfinal) ;

