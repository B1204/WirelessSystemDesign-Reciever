function [xcode] = pskdemod(y,Fc,Fs,Fd,M)
%function [xsin,xcos,xcode] = pskdemod(y,Fc,Fs,Fd)

[r,c]=size(y);
if r*c == 0,
    x = []; return
end

if (r==1),   % convert row vector to column
    y = y(:);  len = c;
else
    len = r;
end

% qam
t = (0:1/Fs:((len-1)/Fs))';
t = t(:,ones(1,size(y,2)));
x1 = 2*y.*cos(2*pi*Fc*t);
x2 = 2*y.*sin(2*pi*Fc*t);
[b,a]=butter(1,Fc*2/Fs);

for i = 1:size(y,2),
    x1(:,i) = filtfilt(b,a,x1(:,i));
    x2(:,i) = filtfilt(b,a,x2(:,i));
end

if (r==1),   % convert x2 from a column to a row if necessary
    x2 = x2.';
end

if (r==1),   % convert x from a column to a row
    x1 = x1.';
end

FsDFd = Fs/Fd;
num_bit=len/FsDFd;

%zzz=abs(x2);
%xcode=[];
for k=1:num_bit
    i1=1+(k-1)*FsDFd;
    i2=k*FsDFd;
%    tmp=round(mean(zzz(i1:i2)));
    tmp1(k)=(mean(x1(i1:i2)));
    tmp2(k)=(mean(x2(i1:i2)));
%    xcode=[xcode tmp];
end

tmp2=tmp2+abs(min(tmp2));
trange=max(tmp2)-min(tmp2);

for ii=1:num_bit
    if (tmp2(ii)>=(max(tmp2)-trange/2))
        xcode(ii)=1;
    else
        xcode(ii)=0;
    end
end

%xcode
%xsin=x1;
%xcos=x2;

%eof