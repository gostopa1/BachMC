function MIDI2markovsc(filename)
%This file makes a SuperCollider script for MarkovChain MIDI analysis based
%on the input filename. The transition matrix is build here. The rest of
%the super collider settings are included in the sc1.txt and sc2.txt files.

addpath('./src')
addpath('./mc_files')
addpath('./functions')

order=1;

%filename='gnossi.mid';
%filename='breezefa.mid';
%filename='entrtanr.mid'
midi=readmidi(['./original_midis/' filename]);

Notes = midiInfo(midi,0);

num_of_notes=size(Notes,1);
%num_of_notes=500;
[PR,t,nn] = piano_roll(Notes(1:num_of_notes,:),1);
% figure(2)
data=Notes(1:num_of_notes,3:6);
vols=data(:,2);
s=size(data);
stp=data(:,3);
durs=data(:,4)-data(:,3);
durs=round(durs*100)/100;
notes=data(:,1);
unotes=unique(notes);
nnotes=notes-min(notes)+1;
curpat=zeros(max(nnotes),1);
[allpats,upats]=make_pats(data);

[ub,u,bb]=unique(allpats,'rows');
trmat=mc_model(bb,order);
mkdir('./sc_files/');
fileID = fopen(['./sc_files/' filename(1:(length(filename)-4)) '_scex.scd'],'w');
file1 = fopen('./sc_text/sc1.txt','r');
file2 = fopen('./sc_text/sc2.txt','r');
dataA = fread(file1);
fwrite(fileID, dataA)

%fprintf(fileID,'%6s %12s\n','x','exp(x)');
%fprintf(fileID,'%6.2f %12.8f\n',A);


max(bb)



%%
    
    clc
display('[')
fprintf(fileID,'[\n')
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
        
        str1=[ '[' '[' vector2str_w_commas(find(ub(i,:))) ']' ', ' num2str(amp) ' ,['];
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
        fprintf(fileID,'%s\n',str1);
    end
    
end

display(']')
fprintf(fileID,']')
dataB = fread(file2);
fwrite(fileID, dataB)
fclose(fileID);
fclose(file1);
fclose(file2);

end