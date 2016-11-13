function [fudu] = bodong(ts)
n=length(ts);
fudu=zeros(n-1,1);
for i=1:n-1
    fudu(i)=(ts(i+1)-ts(i))/ts(i);
end

