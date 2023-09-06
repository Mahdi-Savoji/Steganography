function [sorted] = slice(im2)
% shred the picture to the 8*8 cubes 
n = floor((size(im2,1))/8);
m = floor((size(im2,2))/8);
t=0;
T=m*n;
vaR = zeros(T,8);
for i=1:1:n
    for j=1:1:m
        t=t+1;
            for k = 1:1:3
               X = im2(8*i-7:8*i,8*j-7:8*j,k);
                for q=1:1:size(X,1)
                    for w=1:1:size(X,2)
                        binx = dec2bin(X(q,w),8);
                        binx(end)='0'; 
                        X(q,w)=bin2dec(binx);
                    end
                end
                Mean = sum(sum(X))/64;
                X = X - Mean;
                vaR(t,k) = sum(sum(((X).^2)))/64;
                clear X
            end
            [vaR(t,5),vaR(t,4)]=max(vaR(t,1:3));
            vaR(t,6)=t;
            vaR(t,7)=i;
            vaR(t,8)=j;  
    end

end
sorted = sortrows(vaR,5);
    for i=1:1:floor(T/2)
        sorted(T+1,:)=sorted(i,:);
        sorted(i,:)=sorted(T-i+1,:);
        sorted(T-i+1,:)=sorted(T+1,:);
    end
sorted(T+1,:)=[];
end

