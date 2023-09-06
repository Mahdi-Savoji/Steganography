function [rn,im2] = hidethescript(bin,im2,sorted,key)
bin = bin.';
bin = bin (:);
rng(key);
rn = randi(8,[2,size(bin,1)]);
x = zeros(2,size(bin,1));
for t =1:1:size(bin,1)
        x(t) = im2(sorted(t,7)*8+rn(1,t)-8,sorted(t,8)*8+rn(2,t)-8,sorted(t,4));
        N = dec2bin(x(t));
        n = bin2dec(N(end));
        if str2double(bin(t))==0 && n==1
            N(end) = '0';
            im2(sorted(t,7)*8+rn(1,t)-8,sorted(t,8)*8+rn(2,t)-8,sorted(t,4))=bin2dec(N);
        elseif str2double(bin(t))==1 && n==0
            N(end) = '1';
            im2(sorted(t,7)*8+rn(1,t)-8,sorted(t,8)*8+rn(2,t)-8,sorted(t,4))=bin2dec(N);
        end
end
 imwrite(im2,'after.bmp');
end

