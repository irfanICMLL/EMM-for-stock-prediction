function [ ds ] = cell2double( ts )
[m,n]=size(ts);
for i=1:m
    for j=1:n
        ds(i,j)=ts{i,j};
    end
end

end

