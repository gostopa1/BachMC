numberofnotes=size(ub,2)
numberofpats=size(ub,1)
allstr='['
for pati=1:numberofpats
    pati
   noteinds=find(ub(pati,:));
   lnoteinds=length(noteinds);
   str=['['];
   for notei=1:length(noteinds)
       
       str=[str num2str(noteinds(notei)+minnote)];
       if notei<lnoteinds
           str=[str ','];
       end
   end
   str=[str ']'];
   allstr=[allstr str];
   if pati<numberofpats
       allstr=[allstr ','];
   end
   
   
       
end
allstr=[allstr ']'];
display(['patlist=' allstr])


%%

allallstr2='[';
for i=1:length(model.pat)
    allstr2='[';
    allnums=[];
    for j=1:size(model.pat(i).transitions,1)
        allnums=[allnums ; repmat(model.pat(i).transitions(j,1),model.pat(i).transitions(j,2),1)];
        
    end
    
    for j=1:length(allnums)
        if j==length(allnums)
            allstr2=[allstr2 num2str(allnums(j)) ];
        else
        allstr2=[allstr2 num2str(allnums(j)) ','];
        end
    end
    if i==length(model.pat)
        
    allstr2=[allstr2 ']'];
    else
        allstr2=[allstr2 '],'];
    end
    
    allallstr2=[allallstr2 allstr2];
    
end
allallstr2=[allallstr2 ']'];

display(['translist=' allallstr2])

%%
str=['['];
for i=1:order
    if i==order
    str=[str num2str(bb(i))];
    else
        str=[str num2str(bb(i)) ','];
    end
    
    
end

str=[str ']'];

display(['startstr=' str])

%% Make the transitions
model.transition;
order=size(model.transition,2);
numberofpats=size(model.transition,1);
allstr='[';
for pati=1:numberofpats
    
   noteinds=model.transition(pati,:);
   lnoteinds=length(noteinds);
   str=['['];
   for notei=1:length(noteinds)
       
       str=[str num2str(noteinds(notei))];
       if notei<lnoteinds
           str=[str ','];
       end
   end
   str=[str ']'];
   allstr=[allstr str];
   if pati<numberofpats
       allstr=[allstr ','];
   end
   
  
   
   
       
end
allstr=[allstr ']'];
display(['trans=' allstr])


%%



allallstr2='[';
for i=1:length(model.pat)
    allstr2='[';
    allnums=[];
    for j=1:size(model.pat(i).transitions,1)
        allnums=[allnums ; repmat(model.pat(i).transitions(j,1),model.pat(i).transitions(j,2),1)];   
    end
    for j=1:length(allnums)
        if j==length(allnums)
            %allstr2=[allstr2 num2str(allnums(j)) ];
            allstr2=[allstr2 num2str(durs(allnums(j))) ];         
        else
        allstr2=[allstr2 num2str(durs(allnums(j))) ','];
        end
    end
    if i==length(model.pat)      
    allstr2=[allstr2 ']'];
    else
        allstr2=[allstr2 '],'];
    end 
    allallstr2=[allallstr2 allstr2]; 
end
allallstr2=[allallstr2 ']'];

display(['durlist=' allallstr2])
%%




allallstr2='[';
for i=1:length(model.pat)
    allstr2='[';
    allnums=[];
    for j=1:size(model.pat(i).transitions,1)
        allnums=[allnums ; repmat(model.pat(i).transitions(j,1),model.pat(i).transitions(j,2),1)];   
    end
    for j=1:length(allnums)
        if j==length(allnums)
            %allstr2=[allstr2 num2str(allnums(j)) ];
            allstr2=[allstr2 num2str(amps(allnums(j))) ];         
        else
        allstr2=[allstr2 num2str(amps(allnums(j))) ','];
        end
    end
    if i==length(model.pat)      
    allstr2=[allstr2 ']'];
    else
        allstr2=[allstr2 '],'];
    end 
    allallstr2=[allallstr2 allstr2]; 
end
allallstr2=[allallstr2 ']'];

display(['amplist=' allallstr2])
