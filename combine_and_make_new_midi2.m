%% This script reads the MIDI, analyzes it and generates a new composition

clear
addpath('./src') % Importing the MATLAB MIDI toolbox by Ken Schutte (http://kenschutte.com/midi)
%addpath('./mc_files')
addpath('./functions') %
prefix='./original_midis/'; % Where the original midis are stored (that are used for the analysis)
ind=1;
%% Reading files
filename='take5.mid';
%filename='entrtanr.mid'
filename='breezefa.mid'
Notesall=[]
for midifiles={'asturias.mid','bumble_bee.mid','bach.mid','furelise.mid','entrtanr.mid'}
%for midifiles={'asturias.mid'}
    filename=midifiles{1};
    midi=readmidi([prefix filename]);
    
    Notesall = [Notesall ; midiInfo(midi,0)];% Take all information from the MIDI file.
end
[trackevents,trackind]=hist(Notesall(:,1),unique(Notesall(:,1)))
[~,tracki]=sort(trackevents,'descend');
trackevents=trackevents(tracki);
trackind=trackind(tracki);
trackmat=trackind(trackevents>5);

[channelevents,channelind]=hist(Notesall(:,2),unique(Notesall(:,2)))
%[~,channeli]=sort(trackevents,'descend');
%channelevents=channelevents(channeli);
%channelind=channelind(channeli);
%channelmat=channelind(channelevents>5);
    Notes=Notesall;
for channeli=1
    channel=0
    
    Notesall=Notesall(ismember(Notesall(:,2),[channeli]),:);
    for tracki=1
        track=trackmat(tracki)
        Notesall=Notesall(ismember(Notesall(:,1),track),:);
        clear newmelody ub bnew
        
        num_of_notes=size(Notes,1); % Find the number of notes in the midi file
        
        hist(Notes(:,1),unique(Notes(:,1)))
        title('see the good tracks')
        musiclen=15500;
        order=4; % Change the order of the markov chains for the note patterns
        
        
        [PR,t,nn] = piano_roll(Notes(1:num_of_notes,:),1);
        figure(1)
        imagesc(t,nn,PR)
        
        
        %% Get the information from the MIDIS
        data2=Notes(1:num_of_notes,3:6);
        data=[data2];
        durs=data(:,4)-data(:,3);
        durnextnote=diff(data(:,4)); durnextnote(end+1)=durnextnote(end);
        
        %durnextnote(durnextnote<=0)=100000; durs=min([durs durnextnote],[],2)*2;
        %durs=max([durs durnextnote],[],2)*1;
        %durs=durnextnote*2;
        
        
        
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
        max_distance=0.01;
        for i=2:s(1)
            %if stp(i-1)~=stp(i)
            if stp(i-1)<=stp(i)-max_distance
                pats=[pats curpat];
                
                curpat=zeros(max(nnotes),1);
            end
            curpat(nnotes(i))=1;
        end
        %%
        figure(2)
        imagesc(pats)
        colormap gray
        
        %% Select the number of patterns to generate in the new composition
        
        
        [ub,u,bb]=unique(pats','rows');
        imagesc(ub)
        display(['Number of different patterns: ' num2str(max(bb))])
        %%
        
        
        
        bnew=ndimensional_mc_sample(bb,order,musiclen);
        %%

        
        %% Make durs
        %for i=1:length(bb)
        %    durall(bb(i))=durs(i);
        %end
        
        % dur gives the unique cases, durbb says to which of the unique each one
        % corresponds
        [dur,duru,durbb]=unique(round(durs*100)/100);
        display(['Number of different durs: ' num2str(max(durbb))])
        

        
        
        %% Model the durations and the velocitites as well. Change the numbers to
        %% change the number in the arguments to change the order of the MC.
        %newdurs=sample_new_ts(durs,2,musiclen);
        newdurs=ndimensional_mc_sample(durs,order,musiclen);
        %newamps=sample_new_ts(data(:,2),2,musiclen);
        newamps=ndimensional_mc_sample(data(:,2),order,musiclen);

        %% New music
        
        newmelody=ub(bnew,:);
        
        for i=1:musiclen
            
            %(i,:) =ub(bnew(i),:);
            %newdurs(i)=durall(bnew(i));
            %newamps(i)=ampall(bnew(i));
        end
        
        imagesc(newmelody')
        
        %% Generate the MIDI matrix and then create the MIDI file based on the M
        %% matrix
        stp=Notes(1,4);
        
        
        for i=1:size(newmelody,1)
            a=find(newmelody(i,:))+min(notes);
            
            for j=1:length(a)
                M(ind,1) = track(1);         % all in track 1
                M(ind,2) = channel(1);         % all in channel 1
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
    end
end
midi_new = matrix2midi(M);
midi_new.ticks_per_quarter_note=midi.ticks_per_quarter_note;
%midi_new = matrix2midi(Notes);
writemidi(midi_new, ['./resultmidis/' filename(1:end-4)  '_' num2str(order) '.mid']);
system(['timidity ./resultmidis/' filename(1:end-4)  '_' num2str(order) '.mid'])