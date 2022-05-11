
%           Data: 2018/4/17 9:47
%           Option����Ե��⺯��
%           Creator:XIDI
%           Last Modified�� 2018/4/17 11:09

function [A_Start,A_End] = EdgeDetection(Original_Spectrum);
C =  Original_Spectrum;
%%  ��Ե���
          y_mask = [ 1  1  1;
                     1  1  1;
                     1  1  1];  
          % ����y�����ϵ�ģ��
          Z_mask = [-1 -2 -1;
                     0  0  0;
                     1  2  1];  
          % ����x�����ϵ�ģ��
          x_mask = Z_mask';    
          I = C;
          dx = imfilter(I,x_mask);%����X������ݶȷ���
          dy = imfilter(I,y_mask);%����Y������ݶȷ���
          grad = sqrt(dx.*dx+dy.*dy);%�����ݶ�
          grad = mat2gray(grad);%���ݶȾ���ת��Ϊ�Ҷ�ͼ��
          level = graythresh(grad);%����Ҷ���ֵ
          BW = im2bw(grad,level);%����ֵ�ָ��ݶ�ͼ��
%%  ȥ����ֵͼ�����ɢ��
%         figure(15);
%         imshow(BW);
%         f=bwareaopen(BW,210);%ȥ��ͼ�������С��300������
%         figure(6);
%         imshow(f);title('bwareopenɾ������')
        
%         se=strel('disk',2);%����һ���뾶Ϊ2��Բ�νṹԪ��
%         g=imdilate(f,se);%�ýṹԪ��se��ͼ������������
%         figure(7);
%         imshow(g);title('imdilate���Ͳ���')
%% ������
        se = strel('square',4);
        fa = imopen(BW,se);
        
%         figure(12);
%         imshow(fa);title('������')
%%  ������ı߽�
        [x,y]=find(fa ~= 0);
        a = min(min(y));
        b = max(max(y));
        
        
        A_Start = a;
        A_End = b;
%         disp(min(min(y)));
%         disp(max(max(y)));
%         figure(8);
%         imshow(g);title('sobel');
%% ��Ե���Ч��
%         x = 0:10000;
%         figure();
%         y = (2).*(x>=0 & x< a ) + (4).*(x>= a & x<= b ) + (2).*(x> b & x<=10000);
%         plot(x,y,'g','LineWidth',2);
%         axis([0 10010 0 6]);%���ö�άͼ��x-y���귶Χ 
%         hold on;
%   
%         xlabel('����'); ylabel('ȡֵ');
%         title('��Ե���Ч��ͼ');
% 
%         plot( a , 4, '*', 'MarkerEdgeColor','r','MarkerSize',20);
%         plot( b , 4, '*', 'MarkerEdgeColor','r','MarkerSize',20);
% 
%         text(a,4,['Start(' num2str(a) ')']);
%         text(b,4,['Eed(' num2str(b) ')']);
%         hold off;  
        