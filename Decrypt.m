% The Main File - Decrypt %
clear;clc;close;
fprintf('* * Photo Decryption * * \n')
pause(1);
key = input('Please Inter The Key: \n[It Should Be A Positive Number Less Than 2^32] \n','s') ;
while isnumeric(str2double(key))~=1 || isnan(str2double(key))==1
    clear key
      key = input('Please Inter The Key: \n[It Should Be A Positive Number Less Than 2^32] \n','s') ;
end
key = str2double(key);
im3 = imread('after.bmp');
n = floor((size(im3,1))/8);
m = floor((size(im3,2))/8);
t=0;
T=m*n;
vaR = zeros(T,8);
for i=1:1:n
    for j=1:1:m
        t=t+1;
            for k = 1:1:3
               X = im3(8*i-7:8*i,8*j-7:8*j,k);
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
sorted1 = sortrows(vaR,5);
for i=1:1:floor(T/2)
        sorted1(T+1,:)=sorted1(i,:);
        sorted1(i,:)=sorted1(T-i+1,:);
        sorted1(T-i+1,:)=sorted1(T+1,:);
end
sorted1(T+1,:)=[];
%%
fprintf('Reading Done! \n')
pause(1);
clear message rn1
message='';
clear i j t M char MMD
t=1;
while true
        rng(key);
        rn1 = randi(8,[2,t]);
        num = im3(sorted1(t,7)*8+rn1(1,t)-8,sorted1(t,8)*8+rn1(2,t)-8,sorted1(t,4));
        binnum = dec2bin(num);
        message(t)=binnum(end); 
        if mod(size(message,2),8)==0
            for M=t-7:8:size(message,2)
            MMD = char(bin2dec(message(M:M+7)));
            pause(0.1);
            end
        end
        t=t+1; 
        if t >= T;
            fprintf('\nIt Is Maximum Amount Of Characters That Can Be Extracted. \n')
            return
        end
        if size(message,2)>=16
                if strcmp(char(bin2dec(message(end-15:end-8))),'\') && strcmp(char(bin2dec(message(end-7:end))),'n')
                    fprintf('\n')
                    GT = input('We Found The first \\n! Do You Want To Continue?! \n[Y]=Yes & [N]=No \n','s');
                
                    while strcmp(GT,'N')==0 && strcmp(GT,'Y')==0
                          GT = input('Please Inter The Expected Form! \n[Y]=Yes & [N]=No \n','s');
                        if strcmp(GT,'N') 
                        fprintf('Have A Good Day :) \n');
                        return
                        end
                    
                        if strcmp(GT,'Y')
                        break
                        end
                        
                    end
                 
                    if strcmp(GT,'N')
                    clear MMD i j m n t T vaR 
                    fprintf('Have A Good Day :) \n');
                    return
                    end
                end
        end
         
        if mod(size(message,2),8)==0 && strcmp(char(bin2dec(message(end-7:end))),'\') ~= 1
           if exist('MMD','var')==1
        fprintf(MMD);
           end 
        end
        
end
