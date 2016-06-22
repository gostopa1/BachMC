clear

addpath('./src')
addpath('./mc_files')
order=1;

%filename='gnossi.mid';
filename='breezefa.mid';
filename='entrtanr.mid'
midi=readmidi(filename);

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
notes=data(:,1);
unotes=unique(notes);
nnotes=notes-min(notes)+1;
curpat=zeros(max(nnotes),1);
[allpats,upats]=make_pats(data);

clear transmat
[ub,u,bb]=unique(allpats,'rows');
trmat=mc_model(bb,order);