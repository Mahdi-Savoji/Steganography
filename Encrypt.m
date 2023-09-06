% The Main File - Encrypt 
clear;clc;close;
fprintf('* * Photo Encryption * * \n')
im = imread('image.bmp');
im2=im;
n = floor((size(im2,1))/8);
m = floor((size(im2,2))/8);
T = m*n;
sc = input('Please Inter Your Message: \n','s');
while size(sc,2)*8>=T
    fprintf('Your Message Is Bigger Than To Be Encrypted In This Picture. \n');
    sc = input('Inter The Message Again! \n','s');
end
while strcmp(sc((end-1):end),'\n')==0
    clear sc
      sc = input('2 Last Particle Of Your Message Should Be \\n , Inter It Again: \n','s');
        while size(sc,2)*8>=T
            fprintf('Your Message Is Bigger Than To Be Encrypted In This Picture. \n');
            sc = input('Inter The Message Again! \n','s');
        end      
end

key = input('Please Inter The Key: \n[It Should Be A Positive Number less Than 2^32] \n','s') ;
while isnumeric(str2double(key))~=1 || isnan(str2double(key))==1 || str2double(key)<0
    clear key
      key = input('Please Inter The Key: \n[ It Should Be A Positive Number less Than 2^32 ] \n','s') ;
end
key = str2double(key);

sorted = slice(im2);

bin = sc2bin(sc);

[rn,im2] = hidethescript(bin,im2,sorted,key);

pause(1);
fprintf('Your Message Saved Successfully!!! \n')
% before & after
% check(im,im2);