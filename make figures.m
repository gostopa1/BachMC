addpath mc_files\

trmat=mc_model(data(:,1),1);
imagesc(trmat)

xlabel('Notes')
ylabel('Notes')
title('Note transition matrix')
colorbar

%%

addpath mc_files\
[u,ub]=make_pats(data);
trmat=mc_model(data(:,1),1);
imagesc(trmat)

xlabel('Notes patterns')
ylabel('Notes patterns')
title('Note pattern transition matrix')
colorbar
figure(3)
imagesc(ub')
xlabel('Note pattern index')
ylabel('Notes')
title('Note patterns in ascending order')
%%
filename='entrtanr.mid';
%filename='gnossi.mid';
%filename='breezefa.mid';
%filename='bartok_romanian.mid';
midi=readmidi(filename);

Notes = midiInfo(midi,0);
%num_of_notes=2700;
num_of_notes=size(Notes,1);
[PR,t,nn] = piano_roll(Notes(1:num_of_notes,:),1);
figure(1)
subplot(2,1,1)
imagesc(t,nn,PR)
xlabel('Time')
ylabel('Notes')
title('Original Composition')

filename='resultmidis\entrtanr_2.mid'
%filename='resultmidis\gnossi_2.mid'

midi=readmidi(filename);
Notes = midiInfo(midi,0);
num_of_notes=size(Notes,1);

[PR,t,nn] = piano_roll(Notes(1:num_of_notes,:),1);
subplot(2,1,2)
imagesc(t,nn,PR)
xlabel('Time')
ylabel('Notes')

title('Generated Composition - Order 2')