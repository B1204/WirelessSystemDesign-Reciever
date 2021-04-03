function [t, y] = sig_psk(x, fc, fd, fs, M, opt)
%function [y, y] = sig_psk(x, fc, fd, fs, M, opt)
% PSK Digital Modulation
% INPUT
%   x 	: Digital message signal
%   fc 	: Carrier frequency
%   fd 	: Baud rate
%   fs 	: Sampling frequency
%         (fs/fd must be a positive integer)
%   M 	: M-ary number
%   opt	: The phase-in-circle (PIC) value in PSK modulation scheme
% OUTPUT
%   y 	: Modulated signal using the scheme as specified by method

FsDFd = fs / fd;
if (ceil(FsDFd) ~= FsDFd) | (FsDFd <= 0)
	error('fs / fd must be a positive integer.')
end

if nargin < 5
   error('Not enough input parameters!');
   RETURN
else
    if nargin == 5
        PIC = 0;
    else
        PIC = opt;
    end
end

% psk
x2 = exp(i * (x * 2 * pi / M + PIC));
Nx2 = length(x2);
ss = [];
for a = 1:Nx2
	temp = x2(a)*ones(FsDFd,1);
	ss = [ss; temp];
end

yi = real(ss);
yq = imag(ss);
z = [yi(:) yq(:)];

% Apply quadrature amplitude modulation
t=(0:1/fs:((size(z,1)-1)/fs))';
wt=2*pi*fc*t;
y = z(:, 1).*cos(wt) + z(:, 2).*sin(wt);
y=y.';
t=t';
%eof