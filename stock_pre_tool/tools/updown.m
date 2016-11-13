function [up_down] =updown(time_series)

count=length(time_series);
up_down=zeros(1,count-1);
% up_down(1,1)=nan;
for i=2:count
    if time_series(i)>time_series(i-1)
        up_down(i-1)=0;
    elseif time_series(i)<time_series(i-1)
       up_down(i-1)=1;
    else
        up_down(i-1)=0;
    end
end


end

