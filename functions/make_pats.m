function [allpats,upats]=make_pats(data)
%% This function generates the patterns of all the notes that start at the
%% same time from a matrix that has for columns (note, velocity, stp, endp)
%% and returns the matrix of the patterns during the song and the matrix of
%% the unique patterns.

[x,y,z]=unique(data(:,3));

for i=1:length(z)
    allpats(z(i),data(i,1))=1;
end

upats=unique(allpats,'rows');

end