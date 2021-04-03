function plotcodes(c0,c1)
%  c0       : original code
%  c1       : received code

CL=length(c0);

subplot(2,1,1)
stem(c0,'b')
ylabel('Original')
axis([0.5 CL+0.5 0 1])
set(gca,'Ytick',[0 1])

subplot(2,1,2)
stem(c1,'r')
ylabel('Detected')
axis([0.5 CL+0.5 0 1])
set(gca,'Ytick',[0 1])