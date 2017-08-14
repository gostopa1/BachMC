function out=sample_new_ts(data,order,samples)
%% Given a time series of whatever values this function uses the functions
%% mc_model and mc_sample to generate a new time series based on the
%% transition matrix generated by the original data. The inputs are: the
%% data (can me also matrix where one dimension is the observations) the
%% order of the chain and the number of the samples.

[a,b,c]=unique(data,'rows');

transmat=mc_model(c,order);
bnew=mc_sample(transmat,c,samples);
out=a(bnew);

end