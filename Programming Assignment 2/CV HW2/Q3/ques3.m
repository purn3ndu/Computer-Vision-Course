f=imread('s4_1.pgm');
g=imread('s10_1.pgm');


subplot(2,3,1), subimage(f);
% transform first image to frequency domain and compute magnitude and phase
F=fft2(f);
FA=abs(F);
FP=atan2(imag(F),real(F));
FB=exp(j*FP);
% convert magnitude only back to image; convert phase only back to image
FM=real(ifft2(FA));
FN=real(ifft2(FB));
% determine maximum and minimum of magnitude image and print on screen
FMmax=max(max(FM))
FMmin=min(min(FM))
% convert magnitude only and phase only images to uint8 format for display
FMS=im2uint8(mat2gray(FM));
FNS=im2uint8(mat2gray(FN));

subplot(2,3,2), subimage(FMS, [0 25])
stitle='magnitude only';
title(stitle);
subplot(2,3,3), subimage(FNS, [0 175])

stitle='phase only';
title(stitle);


%image B
subplot(2,3,4), subimage(g)

G=fft2(g);
GA=abs(G);
GP=atan2(imag(G),real(G));
GB=exp(j*GP);
GM=real(ifft2(GA));
GN=real(ifft2(GB));
% determine maximum and minimum of magnitude-only second image and print
GMmax=max(max(GM));
GMmin=min(min(GM));
% convert magnitude-only and phase-only images to uint8 format
GMS=im2uint8(mat2gray(GM));
GNS=im2uint8(mat2gray(GN));


subplot(2,3,5), subimage(GMS, [0 25]);
stitle='magnitude only';
title(stitle);

subplot(2,3,6), subimage(GNS, [0 175]);
stitle='phase only';
title(stitle);

