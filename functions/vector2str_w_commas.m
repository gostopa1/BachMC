function str=vector2str_w_commas(vec)
%% This function takes a vector of numbers and turns it to a string with
%% all the numbers with a comma in between. It is used to generate matrices
%% for SuperCollider

str=num2str(vec(1));
for i=2:length(vec)
    str=[str ',' num2str(vec(i))];
end
end