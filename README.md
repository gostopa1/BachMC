This is a Markov Chain MIDI file analyzer that also generates new sequences.

An example composition made based on "Breeze from Alabama" can be found here:
https://soundcloud.com/tanilasmusic/rag-me

It analyzes a MIDI file and finds

Main files are the following

MIDI2markov: function that performs first-order Markov Chain analysis and generates a Supercollider script for realtime MIDI message generation using Supercollider.

analyze_and_make_new_midi.m: The main script that analyzes the midifile and generates a new MIDI file. Check out the code for more options like, chain-order, length of new MIDI sequence, MIDI file to use as analysis etc.

make_figures: This one I made for report purposes only. You can give it a try after you run analyze_and_make_new_midi (some variables are used from that script).

Check out the MIDI destination to make sure you send to the right destination. TI have put the first MIDIOut as default (m = MIDIOut(0);). In Windows this is typically the the built-in MIDIMapper that produces some sound.

Folder description:
./functions/: a set of MATLAB functions required for the analysis
./original_midis: Where I store the MIDI files that are about to be analyzed. the MIDI2markov function by default uses that as a location so you don't need to put the full path (i.e. MIDI2markov('breezefa.mid') should work right away). It contains "breezefa.mid" that is "Breeze from Alabama" by Scott Joplin.
./result_midis/:The MIDI files that are generated by the the analyze_and_make_new_midi script are located here
./sc_files/: Here are the resulting Supercollider scripts that are generated by the MIDI2markov function
./sc_text/: This is the text that is used to generate the Supercollider script in MIDI2markov. The transition matrix is generated in MATLAB, the rest of the Supercollider script is the same.
./src/: the MATLAB MIDI toolbox made by Ken Schutte (http://kenschutte.com/midi)


This project has been implemented as music school project. 

Things to implement later:

-Instead of dense transition matrices, it would be smarter to use sparse matrices to avoid memory allocation problems in higher order analysis.


I plan to implement similar analysis in Python that will analyze and generate MIDI messages in the same environment

----- 

UPDATE:

Realtime generation has been implemented in Python (RunRealtime_dur_amp.py). The data for the generation (transition matrices etc. are still made in MATLAB because the MIDI tooblox for MATLAB is way more convenient for me). It uses python-rtmidi and numpy.

To make MIDI files purely in MATLAB run combine_and_make_new_midi.m
To make the transition matrices to run in Python run read_MIDI_make_python_data.m

Examples of realtime generation can be found in the following YouTube playlist:
https://www.youtube.com/playlist?list=PLLhYA6_Y_OaK8ugjgew2DcVVlqbzWY7fo

The supercollider part is no longer supported.




