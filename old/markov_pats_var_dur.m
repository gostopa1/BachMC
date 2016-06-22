clear
addpath('./src')
 midi=readmidi('bach.mid');
% %midi=readmidi('deb_clai.mid');
% midi=readmidi('breezefa.mid');
% %midi=readmidi('bartok_mikrokosmos.mid');
%   midi=readmidi('bartok_romanian.mid');
% 
% 
% 
% 
% Notes = midiInfo(midi,0);
% num_of_notes=1500;
% [PR,t,nn] = piano_roll(Notes(1:num_of_notes,:),1);
% % figure(2)
% % imagesc(t,nn,PR)
% 
% data1=Notes(1:num_of_notes,3:6);

%midi=readmidi('entrtanr.mid');

Notes = midiInfo(midi,0);
%num_of_notes=2700;
num_of_notes=size(Notes,1);
[PR,t,nn] = piano_roll(Notes(1:num_of_notes,:),1);
% figure(2)
% imagesc(t,nn,PR)

data2=Notes(1:num_of_notes,3:6);
%data=[data1 ; data2];
data=[data2];
durs=data(:,4)-data(:,3);
%%
s=size(data);
stp=data(:,3);
notes=data(:,1);
unotes=unique(notes);
nnotes=notes-min(notes)+1;
curpat=zeros(max(nnotes),1);
pats=[];
patdurs=[];
curpat(nnotes(1))=1;

for i=2:s(1)
    if stp(i-1)~=stp(i)
       pats=[pats curpat];
       
       curpat=zeros(max(nnotes),1);
    end
    curpat(nnotes(i))=1;
end

imagesc(pats)


%%
clear transmat
[ub,u,bb]=unique(pats','rows'),
%%[~,bb]=ismember(b,ub);
transmat=zeros(max(bb),max(bb));
for i=1:(length(bb)-1)
   transmat(bb(i),bb(i+1))=transmat(bb(i),bb(i+1))+1;
end
size(bb)
    imagesc(transmat)
    
%% Make durs
for i=1:length(bb)
    durall(bb(i))=durs(i);
end
    
%% New music
musiclen=2000;

bnew(1)=bb(randi(length(bb)));
for i=1:musiclen
    
    a=row_to_probs(transmat(bnew(i),:));
    
    bnew(i+1)=a(randi(length(a)));
    
end
%%
for i=1:musiclen
    
newmelody(i,:) =ub(bnew(i),:);
newdurs(i)=durall(bnew(i));
end

imagesc(newmelody')

%%
stp=0;
dur=0.3;
ind=1;
for i=1:size(newmelody,1)
    a=find(newmelody(i,:))+min(notes);
    
    for j=1:length(a)
        M(ind,1) = 1;         % all in track 1
        M(ind,2) = 1;         % all in channel 1
        M(ind,3) = a(j);      % note numbers: one ocatave starting at middle C (60)
        M(ind,4) = 80;  % lets have volume ramp up 80->120
        M(ind,5) = stp;  % note on:  notes start every .5 seconds
        %M(ind,6) = stp+dur;   % note off: each note has duration .5 seconds
        M(ind,6) = stp+newdurs(i);   % note off: each note has duration .5 seconds
        ind=ind+1;
    end
    stp=stp+newdurs(i);
    %stp=stp+dur;
end


midi_new = matrix2midi(M);
writemidi(midi_new, './resultmidis/bartok3.mid');