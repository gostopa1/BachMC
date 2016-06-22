addpath('src')
clear
midi=readmidi('breezefa.mid');
midi=readmidi('bach.mid');
%midi=readmidi('deb_clai.mid');

Notes = midiInfo(midi,0);
num_of_notes=6000;

[PR,t,nn] = piano_roll(Notes(1:num_of_notes,:),1);
figure(2)
imagesc(t,nn,PR)
%%



data=Notes(1:num_of_notes,3:6);
data1=data(:,1);
mat=zeros(max(data1));
for i=1:(length(data1)-1)
    mat(data1(i),data1(i+1))=mat(data1(i),data1(i+1))+1;
    
    
end

%imagesc(mat)

durs=((data(:,4)-data(:,3)));



vols=data(:,2);


data=[data(:,1:2) durs]

%% Make note transition mat

chain_order=3;

data_index=1;
unotes=unique(data(:,data_index));
notes=data(:,data_index);
%note_inds=1:length(unique(data(:,1)));
[~,note_inds]=ismember(notes,unotes)
note_tr_mat=zeros(length(unotes),length(unotes),length(unotes));
for i=1:(length(data(:,1))-3)
    i1=note_inds(i);
    i2=note_inds(i+1);
    i3=note_inds(i+3);
    note_tr_mat(i1,i2,i3)=note_tr_mat(i1,i2,i3)+1;
end

%% Make duration matrix

data_index=3;
udurs=unique(data(:,data_index));
durs=data(:,data_index);
%note_inds=1:length(unique(data(:,1)));
[~,dur_inds]=ismember(durs,udurs)
dur_tr_mat=zeros(length(udurs),length(udurs),length(udurs));
for i=1:(length(data(:,1))-3)
    i1=dur_inds(i);
    i2=dur_inds(i+1);
    i3=dur_inds(i+3);
    dur_tr_mat(i1,i2,i3)=dur_tr_mat(i1,i2,i3)+1;
end
%%
num_of_notes=100;

for i=1:(chain_order-1)
    newnotes(i)=note_inds(i);
    newdurs(i)=dur_inds(i);
    
    
end

%next_note 
for i=(chain_order):num_of_notes
    a=row_to_probs(note_tr_mat(newnotes(i-2),newnotes(i-1),:));
    %length(a)
    %pause
    b=row_to_probs(dur_tr_mat(newdurs(i-2),newdurs(i-1),:));
    nnote=a(randi(length(a)));
    ndur=b(randi(length(b)));
    
    newnotes(i)=nnote;
    newdurs(i)=ndur;
end





%%



%% Make new MIDI file



%%
M = zeros(num_of_notes,6);

M(:,1) = 1;         % all in track 1
M(:,2) = 1;         % all in channel 1
M(:,3) = unotes(newnotes);      % note numbers: one ocatave starting at middle C (60)
M(:,4) = 80;  % lets have volume ramp up 80->120
M(:,5) = cumsum(udurs(newdurs))-udurs(newdurs);  % note on:  notes start every .5 seconds
M(:,6) = cumsum(udurs(newdurs));   % note off: each note has duration .5 seconds

midi_new = matrix2midi(M);
writemidi(midi_new, 'testout.mid');
