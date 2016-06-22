%% This script reads the MIDI, analyzes it and generates a new composition


clear
addpath('./src')
addpath('./mc_files')
addpath('./functions')
prefix='./original_midis/';
%filename='deb_clai.mid';
%filename='deb_clai.mid';
%filename='bartok_romanian.mid';


%% Reading files
%filename=[prefix 'entrtanr.mid'];
%filename='gnossi.mid';
filename='breezefa.mid';
filename='entrtanr.mid'
filename='bumble_bee.mid'
filename='furelise.mid'


%filename='joey.mid';
%filename='bartok_romanian.mid';
%filename='take5.mid';
%filename='deb_clai.mid';
midi=readmidi([prefix filename]);


Notes = midiInfo(midi,0);
%num_of_notes=2700;
num_of_notes=size(Notes,1);
%num_of_notes=700;
[PR,t,nn] = piano_roll(Notes(1:num_of_notes,:),1);
 figure(2)
 imagesc(t,nn,PR)


%% Get the information from the MIDIS
data2=Notes(1:num_of_notes,3:6);
data=[data2];
durs=data(:,4)-data(:,3);
%% Find notes that start at the same time to generate patterns
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
%%
imagesc(pats)
colormap gray

%% Select the number of patterns to generate in the new composition

musiclen=1000;

[ub,u,bb]=unique(pats','rows');
imagesc(ub)
display(['Íumber of different patterns: ' num2str(max(bb))])
%%


%%[~,bb]=ismember(b,ub);
order=2; % Change the order of the markov chains for the note patterns
transmat=mc_model(bb,order);
bnew=mc_sample(transmat,bb,musiclen);

%%
 %imagesc(transmat)
 %xlabel('Note Patterns')
 %ylabel('Note Patterns')
 %title(['Note Patterns transition matrix - ' filename])
 %colorbar

%% Make durs
%for i=1:length(bb)
%    durall(bb(i))=durs(i);
%end

% dur gives the unique cases, durbb says to which of the unique each one
% corresponds
[dur,duru,durbb]=unique(round(durs*100)/100);  
display(['Íumber of different durs: ' num2str(max(durbb))])

%durbnew=mc_sample(mc_model(durbb,order),durbb,musiclen);
%newdurs=dur(durbnew);


%% Model the durations and the velocitites as well. Change the numbers to
%% change the number in the arguments to change the order of the MC.
newdurs=sample_new_ts(durs,2,musiclen);
newamps=sample_new_ts(data(:,2),2,musiclen);
%% Make durs and amps without mc
% 
% amps=data(:,2);
% for i=1:length(bb)
%     ampall(bb(i))=amps(i);
% end
%     
% 
% for i=1:length(bb)
%     durall(bb(i))=durs(i);
% end
%% New music


for i=1:musiclen
    
newmelody(i,:) =ub(bnew(i),:);
%newdurs(i)=durall(bnew(i));
%newamps(i)=ampall(bnew(i));
end

imagesc(newmelody')

%% Generate the MIDI matrix and then create the MIDI file based on the M
%% matrix
stp=0;
dur=0.3;
ind=1;
for i=1:size(newmelody,1)
    a=find(newmelody(i,:))+min(notes);
    
    for j=1:length(a)
        M(ind,1) = 1;         % all in track 1
        M(ind,2) = 1;         % all in channel 1
        M(ind,3) = a(j);      % note numbers: one ocatave starting at middle C (60)
        %M(ind,4) = 80;  % lets have volume ramp up 80->120
        M(ind,4) = newamps(i);  % lets have volume ramp up 80->120
        M(ind,5) = stp;  % note on:  notes start every .5 seconds
        %M(ind,6) = stp+dur;   % note off: each note has duration .5 seconds
        M(ind,6) = stp+newdurs(i);   % note off: each note has duration .5 seconds
        ind=ind+1;
    end
    stp=stp+newdurs(i);
    %stp=stp+dur;
end
%filename='enter_breezefa.mid';

midi_new = matrix2midi(M);
writemidi(midi_new, ['./resultmidis/' filename(1:end-4)  '_' num2str(order) '.mid']);