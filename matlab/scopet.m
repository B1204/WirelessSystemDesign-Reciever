function scopet(t,x,marker,ys)
%function scopet(t,x,marker,ys)
%  display up to 12 channels of waves in time-domain
%INPUT:
%   fs=sampling frequency(kHz)
%   u= matrix containing multiple waveforms to be plotted
%   marker=matrix containing names corresponding to respect waveform
%   ys: the numbering of the first signal

x=real(x);
n=size(x,1); % n is the number of row in matrx x;
ystart=ys-0.4;

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

t=t*1e6;
tmin=min(t);
tmax=max(t);

switch n
case 1
   plot(t,x(1,:));
case 2
   plot(t,x(1,:),t,x(2,:));
case 3
   plot(t,x(1,:),t,x(2,:),t,x(3,:));
case 4
   plot(t,x(1,:),t,x(2,:),t,x(3,:),t,x(4,:));
case 5
   plot(t,x(1,:),t,x(2,:),t,x(3,:),t,x(4,:),t,x(5,:));
case 6
   plot(t,x(1,:),t,x(2,:),t,x(3,:),t,x(4,:),t,x(5,:),t,x(6,:));
case 7
   plot(t,x(1,:),t,x(2,:),t,x(3,:),t,x(4,:),t,x(5,:),t,x(6,:),t,x(7,:));
case 8
   plot(t,x(1,:),t,x(2,:),t,x(3,:),t,x(4,:),t,x(5,:),t,x(6,:),t,x(7,:),t,x(8,:));
case 9
   plot(t,x(1,:),t,x(2,:),t,x(3,:),t,x(4,:),t,x(5,:),t,x(6,:),t,x(7,:),t,x(8,:),t,x(9,:));
case 10
   plot(t,x(1,:),t,x(2,:),t,x(3,:),t,x(4,:),t,x(5,:),t,x(6,:),t,x(7,:),t,x(8,:),t,x(9,:),t,x(10,:));   
case 11
   plot(t,x(1,:),t,x(2,:),t,x(3,:),t,x(4,:),t,x(5,:),t,x(6,:),t,x(7,:),t,x(8,:),t,x(9,:),t,x(10,:),t,x(11,:));   
case 12
   plot(t,x(1,:),t,x(2,:),t,x(3,:),t,x(4,:),t,x(5,:),t,x(6,:),t,x(7,:),t,x(8,:),t,x(9,:),t,x(10,:),t,x(11,:),t,x(12,:));   
otherwise
   disp('Too many figures!!')
end

for k=1:n;
   text(1.01*tmax,k+ys-1,marker(k,:));  
end 

title('MultiChannel Waveform Scope')
xlabel('Time (micro sec)')
ylabel('Normalized Singal Waveforms')
axis([tmin tmax ys-1 ys+n])
set(gca,'Ytick',[ys:ys+n-1])
%eof