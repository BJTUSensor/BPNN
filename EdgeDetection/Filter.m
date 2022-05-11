
% var = 1   先对A1进行单维的中值滤波，再对B1进行单维的中值滤波,然后相减，得到C，中值滤波的参数为：7
% var = 2   先对A1进行中值滤波，再对B1进行中值滤波,然后相减，得到C，中值滤波的参数为：7
% var = 3   测量谱和原始谱进行相减，得到C，然后对C进行单维中值滤波；
% var = 4   测量谱和原始谱进行相减，得到C，然后对C进行中值滤波；
%           Data: 2018/4/10 16:38
%           Option：先对原始谱和测量谱进行滤波，滤波之后再相减，得到相减谱；

function C = Filter_Exp(var)
   load  Data_Brillouin
% A1 = textread('2018年4月19日_10.77_10.88_0.0025000米不加热.txt');
% B1 = textread('2018年4月19日_10.77_10.88_0.0025000米后1000米加热35度.txt');
% C1 = textread('2018年4月19日_10.77_10.88_0.0025000米后中间两段500米加热50度.txt');
switch var
%% case=1
  case  1    
   [m,n]=size(A1);
    for  i =1:n
        y =A1(:,i);
        A = medfilt1(y,41);
        A1(:,i)=A;
    end
%      figure(1);
%      mesh(A1);title('A');
          
    [m,n]=size(B1);
    for  i =1:n
        x =B1(:,i);
        B = medfilt1(x,41);
        B1(:,i)=B;
    end
    
% 
%     figure(2);
%     mesh(B1);title('B');
   
    C = B1 - A1;

%     figure(10);
%     mesh(C);title('c');
%% case=2
   case  2
        x = A1;
        A1 = medfilt2(x,[64,64]); 
%         figure(2);
%         mesh(A1);title('A-7');
        
        y = B1;
        B = medfilt2(y,[64,64]);       
%         figure(2);
%         mesh(B);title('B');
       
        C = B - A1;
        %figure(3)
        %mesh(C);title('C');
        %imshow(C);title('原图');%显示二值图像  
%% case=3
   case  3
       
        A = A1;
        B = B1;
        T = B - A;
        
        [m,n]=size(T);
        for  i =1:n
             y =T(:,i);
             C1 = medfilt1(y,1);
            T(:,i)=C1;
        end
        C = T;
        figure(3)
        mesh(C);title('C');

%% case=4
   case  4
        A = A1;
        B = B1;
        T = B - A;
        C = medfilt2(T,[81,81]);
        
        %figure(3)
        %mesh(C);title('C');
        %imshow(C);title('原图');%显示二值图像 
%         
%         C=B1;
%         mesh(C);
        
%% case=5
  case  5  
        x = A1;
        
        A = A1;
        
        A3 = medfilt2(x,[7,7]);
        figure(2);
        mesh(A3);title('A-7');
        
        [m,n]=size(A);
    for  i =1:n
        y =A(:,i);
        A4 = medfilt1(y,7);
        A(:,i)=A4;
    end
          C = A3 - A;
          figure(9);
          mesh(C);title('C');        
%% case=otherwise
    otherwise
          C = [0 0 0]
     end
  end
   
