MIDIClient.init;
MIDIIn.connectAll;

(

//MIDIOut.connect[];

// Create task
t = Task({


	// Set attributes of each node
	// [freq, dur, [[next_state, weighted_random],�]]
	var node_list =[
[[34,46], 0.5 , 116 ,[[32,1],[190,1]],[0.22,0.62]],
[[33,45], 0.5 , 105 ,[[70,1]],[0.11]],
[[31,43], 0.5 , 107.5 ,[[63,1],[85,1]],[0.11,0.11]],
[[31,43,67,71,74,79], 0.5 , 90 ,[[63,1]],[0.11]],
[[29,41], 0.5 , 105 ,[[12,1]],[0.45]]
];

	var node_index = 0;
	var bps = 60 / 60.0;  // Beats per second

	inf.do({

		var weight = 0;
		var random;
		var accumulator;
		var node = node_list[node_index];
		var temp=node[0];
		//var freq = node[0].midicps;
		//var dur = node[1] / bps;
		var dur = node[4][node[4].size.rand] / bps;
		var paths = node[3];
		var amp = node[2];

		// Get total statistical weight of connected nodes
		(0 .. paths.size - 1).do {|i| weight = weight + paths[i][1]};

		// Generate random value for choosing next node
		random = weight.rand;

		// Choose next node based on statistical weights
		accumulator = paths[0][1];

		node_index = block {|break|
			paths.size.do {|i|
				if ((random < accumulator), {
					break.value(paths[i][0])
					}, {
						accumulator = accumulator + paths[i + 1][1]
				})
			}
		};
m = MIDIOut(2);

		// Play
		//Synth(\my_synth, [\dur, dur, \amp, -3.dbamp, \freq, freq]);
		//Synth(\my_synth, [\dur, dur, \amp, amp/127.0, \freq, freq]);
		temp=node[0];
		//temp.postln;
		temp.size.do{|i| m.noteOn(16,temp[i] , amp-50);};
		temp.postln;
		node[0].postln;
		//m.noteOn(16, node[0], amp-50);
		//m.noteOn(16, 13, amp-50);
		//dur.wait+0.1.rand-0.05;
		dur.wait+0.1.rand-0.05;
		//m.noteOff(16, 13, amp-50);
		temp.size.do{|i|m.noteOff(16,temp[i] , amp-50);};
	})
});

t.start;
//k=t;
//u=t;
//q=t;
//w=t;
//x=t;

);

////c
//node_list[2].postln;


//m = MIDIOut(3)
//
//

//m.allNotesOff(16);



