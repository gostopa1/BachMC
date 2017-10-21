# -*- coding: utf-8 -*-
"""
Created on Fri Oct 20 22:38:28 2017

@author: Tanilas
"""



import time
import rtmidi
import random
import numpy as np
midiout = rtmidi.MidiOut()
midiout.get_ports()
available_ports = midiout.get_ports()

patlist=[[77],[76],[72],[75],[73],[46,70],[53],[58],[61],[65],[70],[41,72],[57],[69],[46,73],[49,77],[56],[68],[78],[44,75],[60],[66],[89],[59,61,65,73],[58,61,66,73],[56,59,61,65,68,73],[54,73],[61,78],[54,77],[59],[63,75],[63,83],[82],[54,82],[65,80],[54,56,59,78],[65,77],[54,56,59,75],[65,73],[54,71],[61,70],[58,70],[71],[61,75],[58,76],[53,77],[58,77],[51,63,78],[54,70],[56,73],[56,75],[61,65,73],[80],[66,68,72],[65,68,73],[63,66,68,75],[61,65,68,77],[85],[84],[54,58,82],[56,60,73],[61,73],[56,60,75],[57,60,77],[46],[46,65,68,71,74],[46,66,70,75],[46,74,77],[46,75,78],[46,69,75,78],[46,70,73,77],[39,46,66,75],[39,46],[39,46,65,73],[39,46,63,72],[40,46,61,67,70],[40,46],[40,46,61,70],[41,46,61,70],[41,46],[41,46,65,73],[41,45,63,72],[41,45],[34,46,61,70],[47,75,78],[47],[47,68,76],[47,66,75],[47,64,73],[47,63,66,71],[47,63,66,70],[48,63,66,69],[48],[49,61,65,70],[53,57,65,66,72],[58,61,65,75],[58,61,65,70],[58,61,65,87],[58,61,65,82],[94],[97],[101],[58,61,65,99],[96],[58,61,65,95],[93],[92],[91],[90],[88],[87],[86],[83],[81],[79]]
translist=[[2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[7],[13],[10],[5,5,5,5,5,5,5,5,5,14,14,14,14,14,14,14,14,14],[3],[15],[7],[8],[10],[1],[2],[1],[2],[1],[3],[6],[7,7,7,7,7,7,7,65],[8],[1,1,3,3,3,3,24],[2],[1],[2],[1],[5],[4],[16],[17],[9],[18],[19],[1],[20],[17],[21],[22],[1],[4],[15],[7],[8],[10],[4],[5],[12],[7],[10],[10],[1],[10],[1],[1],[23],[2],[1],[2],[1],[2],[1],[25],[26],[27],[8],[9],[8],[28],[8],[1],[29],[30],[31],[30],[32],[30],[33],[34],[35],[36],[37],[38],[39],[40],[8],[41],[8],[41],[18],[42],[43],[27],[8],[9],[8],[44],[45],[46],[8],[9],[47],[48],[49],[50],[10],[17],[10],[51],[22],[3],[52],[53],[18],[53],[11],[53],[54],[53],[55],[53],[56],[53],[57],[53],[58],[59],[60],[53],[19],[1,4],[61],[53],[19],[4],[62],[53],[18],[53],[11],[53],[63],[53],[19],[4],[64],[19],[1],[2],[1],[3],[1,4],[2],[1],[2,3,3,3],[1],[1],[65],[65],[65],[65],[66,66,67,67,72],[65],[65],[65],[65],[65],[65],[65],[65],[68],[69],[69,70],[65],[65],[65],[70],[65],[71],[65],[65],[65],[65],[65],[73],[73],[73],[74],[75],[76],[77],[77],[77],[78],[77],[79],[80],[81],[80],[82],[83],[84],[65],[65],[65],[65],[65],[65],[65],[65],[69],[65],[85],[86],[86],[86],[86],[86],[87],[86],[86],[86],[88],[89],[90],[86],[86],[86],[91],[86],[92],[93],[93],[93],[92],[93],[94],[95],[9],[9],[10],[11],[5],[1],[96],[5],[3],[97],[5],[1],[33],[58],[23],[98],[58],[59],[99],[58],[23],[100],[101],[102],[103],[101],[104],[105],[100],[106],[107],[108],[109],[23],[110],[111],[112],[58],[59],[113],[33],[114],[53],[115],[19],[1],[2],[1],[3]]
trans=[[1,2,1,2,1],[2,1,2,1,3],[1,2,1,3,4],[2,1,3,4,5],[1,3,4,5,6],[3,4,5,6,7],[4,5,6,7,8],[5,6,7,8,9],[6,7,8,9,10],[7,8,9,10,11],[8,9,10,11,12],[9,10,11,12,7],[10,11,12,7,13],[11,12,7,13,10],[12,7,13,10,14],[7,13,10,14,3],[13,10,14,3,15],[10,14,3,15,7],[14,3,15,7,8],[3,15,7,8,10],[15,7,8,10,1],[7,8,10,1,2],[8,10,1,2,1],[10,1,2,1,2],[12,7,13,10,5],[7,13,10,5,3],[13,10,5,3,6],[10,5,3,6,7],[5,3,6,7,8],[3,6,7,8,1],[6,7,8,1,2],[7,8,1,2,1],[8,1,2,1,2],[3,6,7,8,3],[6,7,8,3,5],[7,8,3,5,4],[8,3,5,4,16],[3,5,4,16,17],[5,4,16,17,9],[4,16,17,9,18],[16,17,9,18,19],[17,9,18,19,1],[9,18,19,1,20],[18,19,1,20,17],[19,1,20,17,21],[1,20,17,21,22],[20,17,21,22,1],[17,21,22,1,4],[21,22,1,4,15],[22,1,4,15,7],[1,4,15,7,8],[4,15,7,8,10],[15,7,8,10,4],[7,8,10,4,5],[8,10,4,5,12],[10,4,5,12,7],[4,5,12,7,10],[5,12,7,10,10],[12,7,10,10,1],[7,10,10,1,10],[10,10,1,10,1],[10,1,10,1,1],[1,10,1,1,23],[10,1,1,23,2],[1,1,23,2,1],[1,23,2,1,2],[23,2,1,2,1],[2,1,2,1,2],[3,6,7,8,24],[6,7,8,24,25],[7,8,24,25,26],[8,24,25,26,27],[24,25,26,27,8],[25,26,27,8,9],[26,27,8,9,8],[27,8,9,8,28],[8,9,8,28,8],[9,8,28,8,1],[8,28,8,1,29],[28,8,1,29,30],[8,1,29,30,31],[1,29,30,31,30],[29,30,31,30,32],[30,31,30,32,30],[31,30,32,30,33],[30,32,30,33,34],[32,30,33,34,35],[30,33,34,35,36],[33,34,35,36,37],[34,35,36,37,38],[35,36,37,38,39],[36,37,38,39,40],[37,38,39,40,8],[38,39,40,8,41],[39,40,8,41,8],[40,8,41,8,41],[8,41,8,41,18],[41,8,41,18,42],[8,41,18,42,43],[41,18,42,43,27],[18,42,43,27,8],[42,43,27,8,9],[43,27,8,9,8],[27,8,9,8,44],[8,9,8,44,45],[9,8,44,45,46],[8,44,45,46,8],[44,45,46,8,9],[45,46,8,9,47],[46,8,9,47,48],[8,9,47,48,49],[9,47,48,49,50],[47,48,49,50,10],[48,49,50,10,17],[49,50,10,17,10],[50,10,17,10,51],[10,17,10,51,22],[17,10,51,22,3],[10,51,22,3,52],[51,22,3,52,53],[22,3,52,53,18],[3,52,53,18,53],[52,53,18,53,11],[53,18,53,11,53],[18,53,11,53,54],[53,11,53,54,53],[11,53,54,53,55],[53,54,53,55,53],[54,53,55,53,56],[53,55,53,56,53],[55,53,56,53,57],[53,56,53,57,53],[56,53,57,53,58],[53,57,53,58,59],[57,53,58,59,60],[53,58,59,60,53],[58,59,60,53,19],[59,60,53,19,4],[60,53,19,4,61],[53,19,4,61,53],[19,4,61,53,19],[4,61,53,19,4],[61,53,19,4,62],[53,19,4,62,53],[19,4,62,53,18],[4,62,53,18,53],[62,53,18,53,11],[59,60,53,19,1],[60,53,19,1,63],[53,19,1,63,53],[19,1,63,53,19],[1,63,53,19,4],[63,53,19,4,64],[53,19,4,64,19],[19,4,64,19,1],[4,64,19,1,2],[64,19,1,2,1],[19,1,2,1,3],[1,2,1,3,1],[2,1,3,1,2],[1,3,1,2,1],[3,1,2,1,3],[3,1,2,1,2],[10,5,3,6,65],[5,3,6,65,65],[3,6,65,65,65],[6,65,65,65,65],[65,65,65,65,65],[65,65,65,65,66],[65,65,65,66,65],[65,65,66,65,65],[65,66,65,65,65],[66,65,65,65,65],[65,65,65,65,67],[65,65,65,67,65],[65,65,67,65,65],[65,67,65,65,65],[67,65,65,65,68],[65,65,65,68,69],[65,65,68,69,70],[65,68,69,70,65],[68,69,70,65,65],[69,70,65,65,65],[70,65,65,65,70],[65,65,65,70,65],[65,65,70,65,71],[65,70,65,71,65],[70,65,71,65,65],[65,71,65,65,65],[71,65,65,65,65],[65,65,65,65,72],[65,65,65,72,73],[65,65,72,73,73],[65,72,73,73,73],[72,73,73,73,74],[73,73,73,74,75],[73,73,74,75,76],[73,74,75,76,77],[74,75,76,77,77],[75,76,77,77,77],[76,77,77,77,78],[77,77,77,78,77],[77,77,78,77,79],[77,78,77,79,80],[78,77,79,80,81],[77,79,80,81,80],[79,80,81,80,82],[80,81,80,82,83],[81,80,82,83,84],[80,82,83,84,65],[82,83,84,65,65],[83,84,65,65,65],[84,65,65,65,65],[65,65,68,69,69],[65,68,69,69,65],[68,69,69,65,65],[69,69,65,65,65],[69,65,65,65,69],[65,65,65,69,65],[65,65,69,65,85],[65,69,65,85,86],[69,65,85,86,86],[65,85,86,86,86],[85,86,86,86,86],[86,86,86,86,86],[86,86,86,86,87],[86,86,86,87,86],[86,86,87,86,86],[86,87,86,86,86],[87,86,86,86,88],[86,86,86,88,89],[86,86,88,89,90],[86,88,89,90,86],[88,89,90,86,86],[89,90,86,86,86],[90,86,86,86,91],[86,86,86,91,86],[86,86,91,86,92],[86,91,86,92,93],[91,86,92,93,93],[86,92,93,93,93],[92,93,93,93,92],[93,93,93,92,93],[93,93,92,93,94],[93,92,93,94,95],[92,93,94,95,9],[93,94,95,9,9],[94,95,9,9,10],[95,9,9,10,11],[9,9,10,11,5],[9,10,11,5,1],[10,11,5,1,96],[11,5,1,96,5],[5,1,96,5,3],[1,96,5,3,97],[96,5,3,97,5],[5,3,97,5,1],[3,97,5,1,33],[97,5,1,33,58],[5,1,33,58,23],[1,33,58,23,98],[33,58,23,98,58],[58,23,98,58,59],[23,98,58,59,99],[98,58,59,99,58],[58,59,99,58,23],[59,99,58,23,100],[99,58,23,100,101],[58,23,100,101,102],[23,100,101,102,103],[100,101,102,103,101],[101,102,103,101,104],[102,103,101,104,105],[103,101,104,105,100],[101,104,105,100,106],[104,105,100,106,107],[105,100,106,107,108],[100,106,107,108,109],[106,107,108,109,23],[107,108,109,23,110],[108,109,23,110,111],[109,23,110,111,112],[23,110,111,112,58],[110,111,112,58,59],[111,112,58,59,113],[112,58,59,113,33],[58,59,113,33,114],[59,113,33,114,53],[113,33,114,53,115],[33,114,53,115,19],[114,53,115,19,1],[53,115,19,1,2],[115,19,1,2,1]]
durlist=[[0.21429,0.21429,0.21429,0.21429,0.21429,0.21429,0.21429,0.21429,0.21429,0.21429,0.21429,0.21429,0.21429,0.21429,0.21429,0.21429,0.21429,0.21429,0.21429,0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.64286],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429,0.21429,0.21429,0.21429,0.21429,0.21429,0.21429,0.21429,0.21429,0.64286,0.64286,0.64286,0.64286,0.64286,0.64286,0.64286,0.64286,0.64286],[0.21429],[0.21429],[0.21429],[0.64286],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429,0.21429,0.21429,0.21429,0.21429,0.21429,0.21429,0.21429],[0.64286],[0.21429,0.21429,0.21429,0.21429,0.21429,0.21429,0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.64286],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.64286],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.64286],[0.21429],[0.64286],[0.21429],[0.64286],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.64286],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.64286],[0.21429],[0.21429],[0.64286],[0.21429],[0.64286],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.64286],[0.21429],[0.64286],[0.64286],[0.21429],[0.21429],[0.64286],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.64286],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429,0.21429],[0.64286],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429,0.21429],[0.21429],[0.21429],[0.21429,0.21429,0.21429,0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429,0.21429,0.42857,0.42857,0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429,0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.42857],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.42857],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.42857],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.64286],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.64286],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.64286],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429],[0.42857],[0.21429],[0.21429],[0.21429],[0.21429],[0.21429]]
amplist=[[57,57,57,70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,70],[76],[76],[76],[83],[89],[64],[70],[76],[76],[83],[76],[70],[76,76,76,76,76,76,76,76,76,83,83,83,83,83,83,83,83,83],[70],[64],[83],[89],[70],[38],[57],[38],[57],[38],[70],[76],[83,83,83,83,83,83,83,76],[89],[38,38,70,70,70,70,76],[57],[38],[57],[38],[76],[76],[70],[76],[64],[76],[76],[38],[83],[76],[70],[76],[38],[76],[64],[83],[89],[70],[76],[76],[76],[83],[70],[70],[38],[70],[38],[38],[76],[57],[38],[57],[38],[57],[38],[64],[76],[70],[89],[64],[89],[76],[89],[38],[76],[76],[76],[76],[83],[76],[64],[70],[76],[76],[76],[83],[70],[76],[89],[76],[89],[76],[76],[76],[76],[70],[89],[64],[89],[83],[70],[70],[89],[64],[64],[70],[70],[64],[70],[76],[70],[76],[76],[70],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[38,76],[83],[76],[76],[76],[70],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[38],[57],[38],[70],[38,76],[57],[38],[57,70,70,70],[38],[38],[76],[76],[76],[76],[76,76,76,76,70],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76,76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[70],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[83],[76],[76],[76],[76],[76],[76],[76],[76],[76],[64],[64],[70],[76],[76],[38],[76],[76],[70],[76],[76],[38],[64],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[76],[64],[76],[76],[76],[76],[38],[57],[38],[70]]
startstr=[1,2,1,2,1]

if available_ports:
    #midiout.open_port(1)
    midiout.open_port(2)
else:
    midiout.open_virtual_port("My virtual output")





notevel=80
notedur=0.1

#To play first the introduction)
for i in range(len(startstr)):
    patind=startstr[i]-1;
    
    for j in range(len(patlist[startstr[i]])):
        notenum=patlist[patind][j]
        
        control = [0x90, notenum, notevel]
        midiout.send_message(control)
        time.sleep(dur)
    for j in range(len(patlist[patind])):
        notenum=patlist[patind][j]
        
        control = [0x80, notenum, 0]
        midiout.send_message(control)
        
patind=findainb(trans,startstr)[0]
#patind=random.randint(0,len(patlist)) # In case of randomness
patind=np.random.permutation(translist[patind])[0]-1;

for i in range(50):
    
    for j in range(len(patlist[patind])):
        notenum=patlist[patind][j]
        
        control = [0x90, notenum, notevel]
        midiout.send_message(control)
    time.sleep(notedur/1)
    
    for j in range(len(patlist[patind])):
        notenum=patlist[patind][j]
        
        control = [0x80, notenum, 0]
        midiout.send_message(control)
    
    
    try :
        patind=findainb(trans,startstr)[0]
    except:
        print
        patind=random.randint(0,len(patlist)) # In case of randomness   
    
    
    patind=np.random.permutation(translist[patind])[0];
    notedur=np.random.permutation(durlist[patind])[0];
    notevel= np.random.permutation(amplist[patind])[0];
    startstr.insert(len(startstr),patind)
    
    print(startstr+patind)
    
    startstr=startstr[1::]
    


def findainb(a,b):
    ind=[]
    for i in range(len(a)):
        if a[i]==b:
            ind.append(i)
    return ind
