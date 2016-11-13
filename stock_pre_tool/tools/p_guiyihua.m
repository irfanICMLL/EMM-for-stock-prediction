function [guiyihua] = p_guiyihua(shuju)
M=0.1;
m=-0.1;
[n,k]=size(shuju);
A=zeros(n,k);
B=zeros(n,k);
for i=1:n
  A(i,:)=m;%bi为已知的列向量
  B(i,:)=M-m;
end

guiyihua=(shuju-A)./B;
guiyihua(find(guiyihua>1))=1;
guiyihua(find(guiyihua<0))=0;
end

