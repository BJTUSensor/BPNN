
%           Data: 2018/4/17 9:47
%           Option：边缘检测函数
%           Creator:XIDI
%           Last Modified： 2018/4/17 11:09

function [A_Start,A_End] = EdgeDetection(Original_Spectrum);
C =  Original_Spectrum;
%%  边缘检测
          y_mask = [ 1  1  1;
                     1  1  1;
                     1  1  1];  
          % 建立y方向上的模板
          Z_mask = [-1 -2 -1;
                     0  0  0;
                     1  2  1];  
          % 建立x方向上的模板
          x_mask = Z_mask';    
          I = C;
          dx = imfilter(I,x_mask);%计算X方向的梯度分量
          dy = imfilter(I,y_mask);%计算Y方向的梯度分量
          grad = sqrt(dx.*dx+dy.*dy);%计算梯度
          grad = mat2gray(grad);%将梯度矩阵转换为灰度图像
          level = graythresh(grad);%计算灰度阈值
          BW = im2bw(grad,level);%用阈值分割梯度图像
%%  去除二值图像的杂散点
%         figure(15);
%         imshow(BW);
%         f=bwareaopen(BW,210);%去掉图像中面积小于300的区域
%         figure(6);
%         imshow(f);title('bwareopen删除操作')
        
%         se=strel('disk',2);%创建一个半径为2的圆形结构元素
%         g=imdilate(f,se);%用结构元素se对图像作膨胀运算
%         figure(7);
%         imshow(g);title('imdilate膨胀操作')
%% 开运算
        se = strel('square',4);
        fa = imopen(BW,se);
        
%         figure(12);
%         imshow(fa);title('开运算')
%%  计算检测的边界
        [x,y]=find(fa ~= 0);
        a = min(min(y));
        b = max(max(y));
        
        
        A_Start = a;
        A_End = b;
%         disp(min(min(y)));
%         disp(max(max(y)));
%         figure(8);
%         imshow(g);title('sobel');
%% 边缘检测效果
%         x = 0:10000;
%         figure();
%         y = (2).*(x>=0 & x< a ) + (4).*(x>= a & x<= b ) + (2).*(x> b & x<=10000);
%         plot(x,y,'g','LineWidth',2);
%         axis([0 10010 0 6]);%设置二维图的x-y坐标范围 
%         hold on;
%   
%         xlabel('长度'); ylabel('取值');
%         title('边缘检测效果图');
% 
%         plot( a , 4, '*', 'MarkerEdgeColor','r','MarkerSize',20);
%         plot( b , 4, '*', 'MarkerEdgeColor','r','MarkerSize',20);
% 
%         text(a,4,['Start(' num2str(a) ')']);
%         text(b,4,['Eed(' num2str(b) ')']);
%         hold off;  
        