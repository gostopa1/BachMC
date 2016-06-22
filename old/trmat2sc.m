%% This file is used to generate the SuperCollider format transition
%% matrix. The transition matrix as analyzed from the input MIDI file is
%% generated in the make_patterns_trmat_sc.m

max(bb)



%%
    
    clc
display('[')
mat=trmat;
matsums=sum(mat,1);
indices=find(matsums>0);
for i=1:size(mat,1)
    str1=[];
    str2=[];
    ind=0;
    if matsums(i)>0
        amp=mean(vols(find(bb==i)));
%%str1=[ '[' num2str(i) ', 0.5 , 0.8 ,['];
        
        str1=[ '[' '[' vector2str_w_commas(find(ub(i,:))) ']' ', 0.5 , ' num2str(amp) ' ,['];
        for j=1:size(mat,1)
            if mat(i,j)~=0
                ind=ind+1;
                %str1=[str1 '[' num2str(j) ',' num2str(mat(i,j)) ']'];
                str1=[str1 '[' num2str((find(indices==j)-1)) ',' num2str(mat(i,j)) ']'];
                if sum(mat(i,((j+1):end)))~=0
                    str1=[str1 ','];
                end
            end
        
            
        end
        
        str1=[str1 ']'];
        
    end
    durvec=durs(find(bb==i));
    str1=[str1 ',[' vector2str_w_commas(durvec) ']'];
%         for  duri=1:length(durvec)
%             if duri>1
%             str1=[str1 ','];
%             end
%             str1=[str1  num2str(durvec(duri))];
%         end
%         str1=[str1 ']'];
    str1=[str1 ']'];
    if sum(matsums((i+1):end))>0
        str1=[str1 ','];
    end
    if ind>0
        display([str1 '']);
    end
    
end

display(']')
