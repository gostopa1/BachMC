clear
clc
addpath('./src')
addpath('./mc_files')

filename='breezefa.mid';
%filename='bartok_romanian.mid'
%filename='carnival.mid'
%filename='bach.mid';
midi=readmidi(filename);

Notes = midiInfo(midi,0);
num_of_notes=size(Notes,1)
%num_of_notes=1000;
[PR,t,nn] = piano_roll(Notes(1:num_of_notes,:),1);
sampleno=500;
decimalrnd=100;

data=Notes(1:num_of_notes,3:6);
notes=data(:,1);
vols=data(:,2);
%data2(:,2)=data(:,3)-circshift(data(:,3),1);
pausetillnextnote=round(decimalrnd*(data(:,3)-circshift(data(:,3),1)))/decimalrnd;
pausetillnextnote(1)=0;
%data2(:,3)=data(:,4)-data(:,3);
durs=round((data(:,4)-data(:,3))*decimalrnd)/decimalrnd;

[x,y,z]=unique([notes vols durs],'rows');
max(z)
order=1;

newmelody=x(mc_sample(mc_model(z,order),z,sampleno),:)
stps=cumsum(sample_new_ts(pausetillnextnote,2,sampleno));

%stps=cumsum(newmelody(:,2));
for i=1:size(newmelody,1)
   
        M(i,1) = 1;         % all in track 1
        M(i,2) = 1;         % all in channel 1
        M(i,3) = newmelody(i,1);      % note numbers: one ocatave starting at middle C (60)
        M(:,4) = newmelody(i,2);  % lets have volume ramp up 80->120
        %M(i,4) = newmelody(i,2);  % lets have volume ramp up 80->120
        M(i,5) = stps(i);  % note on:  notes start every .5 seconds
        %M(ind,6) = stp+dur;   % note off: each note has duration .5 seconds
        M(i,6) = stps(i)+newmelody(i,3);   % note off: each note has duration .5 seconds
        
    %stp=stp+dur;
end

midi_new = matrix2midi(M);
writemidi(midi_new, ['./resultmidis/' filename(1:end-4)  '_' num2str(order) '.mid']);
