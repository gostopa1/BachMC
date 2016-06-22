clear
clc
addpath('./src')
addpath('./mc_files')

filename='breezefa.mid';
%filename='bartok_romanian.mid'
%filename='bach.mid';
midi=readmidi(filename);

Notes = midiInfo(midi,0);
num_of_notes=size(Notes,1)
%num_of_notes=400;
[PR,t,nn] = piano_roll(Notes(1:num_of_notes,:),1);


data=Notes(1:num_of_notes,1:6);
%%

stp_difs=data(:,5)-circshift(data(:,5),1);
endp_difs=data(:,6)-circshift(data(:,6),1);
durs=data(:,6)-data(:,5);

order=1;
samples=1000;
for i=[3 4]
    display(['Column: ' num2str(i) ' - Unique elements: ' num2str(length(unique(data(:,i))))])
   M(:,i)=sample_new_ts(data(:,i),order,samples);
  
end
M(:,1)=1;
M(:,2)=1;
M(:,5)=cumsum(sample_new_ts(stp_difs,order,samples)); 
%M(:,6)=cumsum(sample_new_ts(endp_difs,order,samples)); 
M(:,6)=M(:,5)+sample_new_ts(durs,order,samples);

midi_new = matrix2midi(M);
writemidi(midi_new, ['./resultmidis/new' filename(1:end-4)  '_' num2str(order) '.mid']);

%%

data=Notes(1:num_of_notes,3:6);
data2(:,1)=data(:,1);
data2(:,2)=data(:,2);
data2(:,3)=data(:,3)-circshift(data(:,3),1);;
data2(:,4)=data(:,4)-data(:,3);

[x,y,z]=unique(data2,'rows');

max(z)
%%
newmelody=x(mc_sample(mc_model(z,order),z,1000),:)
stps=cumsum(data2(:,3));
for i=1:size(newmelody,1)
   
        M(i,1) = 1;         % all in track 1
        M(i,2) = 1;         % all in channel 1
        M(i,3) = newmelody(i,1);      % note numbers: one ocatave starting at middle C (60)
        %M(ind,4) = 80;  % lets have volume ramp up 80->120
        M(i,4) = newmelody(i,2);  % lets have volume ramp up 80->120
        M(i,5) = stps(i);  % note on:  notes start every .5 seconds
        %M(ind,6) = stp+dur;   % note off: each note has duration .5 seconds
        M(i,6) = stps(i)+newmelody(i,4);   % note off: each note has duration .5 seconds
        
    %stp=stp+dur;
end
filename='test5.mid';

midi_new = matrix2midi(M);
writemidi(midi_new, ['./resultmidis/' filename(1:end-4)  '_' num2str(order) '.mid']);
