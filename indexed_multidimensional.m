%% This script reads the MIDI, analyzes it and generates a new composition
clear
addpath('./src') % Importing the MATLAB MIDI toolbox by Ken Schutte (http://kenschutte.com/midi)
%addpath('./mc_files')
addpath('./functions') %
prefix='./original_midis/'; % Where the original midis are stored (that are used for the analysis)

%% Reading files
filename='furelise.mid'
midi=readmidi([prefix filename]);

Notes = midiInfo(midi,0);% Take all information from the MIDI file.

num_of_notes=size(Notes,1); % Find the number of notes (note ons) in the midi file
num_of_notes=50

%% Get the information from the MIDIS
channel=0
track=2;
Notes=Notes(Notes(:,1)==track,:);
Notes=Notes(Notes(:,2)==channel,:);
data=Notes(1:num_of_notes,3:6);

durs=data(:,4)-data(:,3);
%% Find notes that start at the same time to generate patterns
s=size(data);
stp=data(:,3);
notes=data(:,1);
unotes=unique(notes);
nnotes=notes-min(notes)+1; % To find the range of notes (e.g. from note 32 to note 56)
curpat=zeros(max(nnotes),1); %% Make an empty vector to add the patterns
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


musiclen=1000;

[ub,u,bb]=unique(pats','rows');
imagesc(ub'); ylabel('Notes'); xlabel('Pattern index')
display(['Number of different patterns: ' num2str(max(bb))])


order=2

for pati=(order+1):length(bb)
   
    for previousi=1:order
       transition(pati-order,previousi)=bb(pati-previousi);
    end
    transition_next(pati-order)=bb(pati)
end

[ub2,u2,bb2]=unique(transition,'rows');
%% Think about it taneli
frequencymap=zeros(length(unique(transition_next)),2)
for i=1:length(bb2)
    
    bb2(i)=transition_next(i)
    frequencymap(bb2(i),1)=transition_next(i);
    frequencymap(bb2(i),2)=frequencymap(bb2(i),2)+1;
end



