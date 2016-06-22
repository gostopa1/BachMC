function newmel=mc_sample(trmat,bb,nosamples)
%% Makes a new melody from a Markov Chain transition matrix
%% Inputs are: the transition matrix, the sequence of the unique events (to
%% get the first events) and the number of the samples to generate
order=length(size(trmat))-1;
for i=1:order
    newmel(i)=bb(i);
end



for i=order:(nosamples-1)
    %ind=newmel((i-order+1):(i-1+1));
    ind=newmel((i-order+1):(i-1+1));
    
    str=['trmat('];
    for j=1:length(ind)
       str=[str num2str(ind(j)) ','];
    end
    str=[str ':); '];
    a=row_to_probs(squeeze(eval(str)));

    newmel(i+1)=a(randi(length(a)));
end



end