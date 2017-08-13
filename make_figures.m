figure(1)
clf

trmat=mc_model(data(:,1),1);
imagesc(trmat)

xlabel('Notes')
ylabel('Notes')
title('Note transition matrix')
colorbar

%% Make figures regarding the MC transition matrix

figure(2)
clf
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
figure(3)
clf
filename='./original_midis/breezefa.mid';
midi=readmidi(filename);

Notes = midiInfo(midi,0);
num_of_notes=size(Notes,1);
[PR,t,nn] = piano_roll(Notes(1:num_of_notes,:),1);

subplot(2,1,1)
imagesc(t,nn,PR)
xlabel('Time')
ylabel('Notes')
title('Original Composition')

filename='resultmidis\breezefa_2.mid'
midi=readmidi(filename);
Notes = midiInfo(midi,0);
num_of_notes=size(Notes,1);

[PR,t,nn] = piano_roll(Notes(1:num_of_notes,:),1);
subplot(2,1,2)
imagesc(t,nn,PR)
xlabel('Time')
ylabel('Notes')

title('Generated Composition - Order 2')