function scopef(fs,u,marker,ys)
%function scopef(fs,u,marker,ys)
%   display up to 12 channels of waves in freq-domain
%INPUT:
%   fs=sampling frequency(kHz)
%   u= matrix containing multiple waveforms to be plotted
%   marker=matrix containing names corresponding to respect waveform
%   ys: the numbering of the first signal

if mod(length(u(1,:)),2)==1
    f=(0:(length(u(1,:))-1)/2)*fs/length(u(1,:));
else 
    f=(0:length(u(1,:))/2)*fs/length(u(1,:));
end

n=size(u,1); % n is the number of row in matrx x;

ystart=ys-0.4;

for j=1:n
    x(j,:)=abs(fft(u(j,:)));
end
x=real(x);

%normalization of each row

for k=1:n;
   ma=max(x(k,:));
   mi=min(x(k,:));

   if (ma*mi>=0)
      nom=max(abs(ma),abs(mi));
   else  
      nom=ma+abs(mi);
   end 
  
   x(k,:)=0.9*x(k,:)/nom ;
   x(k,:)=x(k,:)+(k-1)-min(x(k,:))+ystart;
end 

f=f/1e6;
fmax=max(f);

switch n
case 1
   plot(f,x(1,(1:length(f))));
case 2
   plot(f,x(1,(1:length(f))),f,x(2,(1:length(f))));
case 3
   plot(f,x(1,(1:length(f))),f,x(2,(1:length(f))),f,x(3,(1:length(f))));
case 4
   plot(f,x(1,(1:length(f))),f,x(2,(1:length(f))),f,x(3,(1:length(f))),f,x(4,(1:length(f))));
case 5
   plot(f,x(1,(1:length(f))),f,x(2,(1:length(f))),f,x(3,(1:length(f))),f,x(4,(1:length(f))),f,x(5,(1:length(f))));
case 6
   plot(f,x(1,(1:length(f))),f,x(2,(1:length(f))),f,x(3,(1:length(f))),f,x(4,(1:length(f))),f,x(5,(1:length(f))),f,x(6,(1:length(f))));
case 7
   plot(f,x(1,(1:length(f))),f,x(2,(1:length(f))),f,x(3,(1:length(f))),f,x(4,(1:length(f))),f,x(5,(1:length(f))),f,x(6,(1:length(f))),f,x(7,(1:length(f))));
case 8
   plot(f,x(1,(1:length(f))),f,x(2,(1:length(f))),f,x(3,(1:length(f))),f,x(4,(1:length(f))),f,x(5,(1:length(f))),f,x(6,(1:length(f))),f,x(7,(1:length(f))),f,x(8,(1:length(f))));
case 9
   plot(f,x(1,(1:length(f))),f,x(2,(1:length(f))),f,x(3,(1:length(f))),f,x(4,(1:length(f))),f,x(5,(1:length(f))),f,x(6,(1:length(f))),f,x(7,(1:length(f))),f,x(8,(1:length(f))),f,x(9,(1:length(f))));
case 10
   plot(f,x(1,(1:length(f))),f,x(2,(1:length(f))),f,x(3,(1:length(f))),f,x(4,(1:length(f))),f,x(5,(1:length(f))),f,x(6,(1:length(f))),f,x(7,(1:length(f))),f,x(8,(1:length(f))),f,x(9,(1:length(f))),f,x(10,(1:length(f))));   
case 11
   plot(f,x(1,(1:length(f))),f,x(2,(1:length(f))),f,x(3,(1:length(f))),f,x(4,(1:length(f))),f,x(5,(1:length(f))),f,x(6,(1:length(f))),f,x(7,(1:length(f))),f,x(8,(1:length(f))),f,x(9,(1:length(f))),f,x(10,(1:length(f))),f,x(11,(1:length(f))));   
case 12
   plot(f,x(1,(1:length(f))),f,x(2,(1:length(f))),f,x(3,(1:length(f))),f,x(4,(1:length(f))),f,x(5,(1:length(f))),f,x(6,(1:length(f))),f,x(7,(1:length(f))),f,x(8,(1:length(f))),f,x(9,(1:length(f))),f,x(10,(1:length(f))),f,x(11,(1:length(f))),f,x(12,(1:length(f))));   
 
otherwise
   disp('Too many figures!!')
end

for k=1:n;
   text(1.03*fmax,k+ys-1,marker(k,:));  
end 

title('MultiChannel Frequency Scope')
xlabel('Frequency (MHz)')
ylabel('Normalized Magnitudes (Ratio scale)')
axis([-0.02*fmax 1.02*fmax ys-1 ys+n])
set(gca,'Ytick',[ys:ys+n-1])

