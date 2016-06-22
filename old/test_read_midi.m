addpath('src')

midi=readmidi('deb_clai.mid');

Notes = midiInfo(midi,0);
[PR,t,nn] = piano_roll(Notes(1:100,:),1);

imagesc(t,nn,PR)
%%




data=Notes(1:50,3:6);
data1=data(:,1);
mat=zeros(max(data1))
for i=1:(length(data1)-1)
    mat(data1(i),data1(i+1))=mat(data1(i),data1(i+1))+1;
    
    
end

%imagesc(mat)

%%
clc
display('[')
matsums=sum(mat,1);
indices=find(matsums>0);
for i=1:size(mat,1)
    str1=[];
    str2=[];
    ind=0;
    if matsums(i)>0
        str1=[ '[' num2str(i) ', 0.5 , 0.8 ,['];
        for j=1:size(mat,1)
            if mat(i,j)~=0
                ind=ind+1;
                str1=[str1 '[' num2str(j) ',' num2str(mat(i,j)) ']'];
                if sum(mat(i,((j+1):end)))~=0
                    str1=[str1 ','];
                end
            end
            
            
        end
        str1=[str1 ']'];
    end
    str1=[str1 '],'];
    if matsums((i+1):end)>0
        str1=[str1 ','];
    end
    if ind>0
        display([str1 '']);
    end
    
end

display(']')