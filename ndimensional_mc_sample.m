function newpat=ndimensional_mc_sample(bb,order,musiclen)

model.order=order;

for pati=(model.order+1):length(bb)
    
    transition(pati-model.order,:)=bb((1:model.order)+pati-model.order-1); %% All the transitions
    transition_next(pati-model.order)=bb(pati); % The next of each transition
end

[ub2,u2,bb2]=unique(transition,'rows','stable'); %unique transitions, locations of unique transitions, index of unique transition
%%
for i=1:length(u2)
   
    inds=find(bb2==i);
    next_states=[transition_next(inds)];

    uns=unique(next_states);
    if length(uns)>1
        [occfreq,occ]=hist(next_states,uns);
        
        occfreq=occfreq/sum(occfreq);
        model.pat(i).transitions=[ occ ; occfreq]'; % First column is next state, second column is its probability
    elseif length(unique(next_states))==1
        model.pat(i).transitions=[ uns ; 1]';
    end

end

%%
startind=1;
newpat(1:model.order)=bb((startind-1)+(1:model.order));
for notei=1:(musiclen-model.order)
%[~,i1]=intersect(transition,newpat((1:model.order)+(notei-1)),'rows','stable'); % FInd where such a transition occurs
[~,ind]=intersect(ub2,newpat((1:model.order)+(notei-1)),'rows','stable'); % FInd where such a transition occurs

%ind=bb2(i1) % Find the index of the current transition

try
[~,newpatind]=min(abs(rand-cumsum(model.pat(ind).transitions(:,2))));
newpat(model.order+notei)=model.pat(ind).transitions(newpatind,1);
catch
    newpat(model.order+notei)=bb(randi(length(bb)));
    
end




end

end