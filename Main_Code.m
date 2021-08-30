clear all, close all,clc
A = imread('Parrot.jpg');
% A = imread('Rabbit.jpg');
% A = imread('city.jpg');
figure(3)
imshow(A)
Abw2=rgb2gray(A);  
[nx,ny] = size(Abw2);
figure(1),subplot(2,2,1), imshow(Abw2)
title('Original Image','FontSize',16)
transformed = fft2(Abw2);
F= log(abs(fftshift(transformed))+1);
F = mat2gray(F);
figure(4)
imshow(F);
count_pic = 2;  
for thresh = 0.1*[0.001 0.005 0.01] * max(abs(transformed(:)))
    ind=abs(transformed)>thresh;
    count =sum(ind(:));
    AhatFilt = transformed.*ind;
    percent=count/(nx*ny)*100;
    Afilt = uint8(ifft2(AhatFilt));
    figure(1), subplot(2,2,count_pic)
    imshow(Afilt);
    count_pic = count_pic + 1;
    drawnow
    title([num2str(percent) '% of FFT basis'],'FontSize',14)
end
figure(5),subplot(2,2,1)
Anew = imresize(Abw2,.1);
surf(double(Anew));
title('original image');

figure(5),subplot(2,2,2)
Anew = imresize(F,.1);
surf(double((Anew)));
title('Fourier Transformed');

figure(5),subplot(2,2,3)
Anew = imresize((abs(AhatFilt)),.1);
surf(double((Anew)));
title('After Truncated');

figure(5),subplot(2,2,4)
Anew = imresize(Afilt,.1);
surf(double((Anew)));
title('Filtred image'); 
imwrite(Abw2,'beforefiltring.jpg');
imwrite(AhatFilt,'filtred.jpg');

