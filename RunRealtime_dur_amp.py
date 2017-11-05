# -*- coding: utf-8 -*-
"""
Created on Fri Oct 20 22:38:28 2017

@author: Athanasios Gotsopoulos
"""

import time
import sys
import rtmidi
import random
import numpy as np
midiout = rtmidi.MidiOut()
midiout.get_ports()
available_ports = midiout.get_ports()


sys.path.append('./python_aux/')
#from aux import *
from note_aux import *
from dur_aux import *
from amp_aux import *



if available_ports:
    #midiout.open_port(1)
    midiout.open_port(1)
else:
    midiout.open_virtual_port("My virtual output")

def findainb(a,b):
    ind=[]
    for i in range(len(a)):
        if a[i]==b:
            ind.append(i)
    return ind

durfac=0.5
time.sleep(3)
midiout.send_message([176,123,2])
#To play first the introduction)
for i in range(len(note_startstr)):
    
    note_patind=note_startstr[i];
    notedur=dur_patlist[dur_startstr[i]][0]*durfac;
    notevel=amp_patlist[amp_startstr[i]][0];
 

    for j in range(len(note_patlist[note_startstr[i]])):
        notenum=note_patlist[note_patind][j]
        
        control = [0x90, notenum, notevel]
        midiout.send_message(control)
        time.sleep(notedur)
    for j in range(len(note_patlist[note_patind])):
        notenum=note_patlist[note_patind][j]
        
        control = [0x80, notenum, 0]
        midiout.send_message(control)
        

while(1):
    
    try :
        note_patind=findainb(note_trans,note_startstr)[0]
    except:
        print('No such note pattern!')
        note_patind=random.randint(0,len(note_patlist)-1) # In case of randomness   
    
    try :
        dur_patind=findainb(dur_trans,dur_startstr)[0]
    except:
        print('No such dur pattern!')
        dur_patind=random.randint(0,len(dur_patlist)-1) # In case of randomness   
    
    try :
        amp_patind=findainb(amp_trans,amp_startstr)[0]
    except:
        #time.sleep(10)
        print('No such amp pattern!')
        amp_patind=random.randint(0,len(amp_patlist)-1) # In case of randomness   
        
    note_patind=np.random.permutation(note_translist[note_patind])[0];
    amp_patind=np.random.permutation(amp_translist[amp_patind])[0];
    dur_patind=np.random.permutation(dur_translist[dur_patind])[0];
    notedur=dur_patlist[dur_patind][0]*durfac
    notevel=amp_patlist[amp_patind][0]
    if notevel>100:
        print('Too High note')
        #notevel=100    
    
    for j in range(len(note_patlist[note_patind])):
        notenum=note_patlist[note_patind][j]
        print(notenum)
        control = [0x90, notenum, notevel]
        midiout.send_message(control)
    time.sleep(notedur/1)
    
    print('')
    for j in range(len(note_patlist[note_patind])):
        notenum=note_patlist[note_patind][j]
        
        control = [0x80, notenum, 0]
        midiout.send_message(control)

    note_startstr.insert(len(note_startstr),note_patind)
    note_startstr=note_startstr[1::]
    
    dur_startstr.insert(len(dur_startstr),dur_patind)
    dur_startstr=dur_startstr[1::]
    
    amp_startstr.insert(len(amp_startstr),amp_patind)
    amp_startstr=amp_startstr[1::]
    
    #print(note_startstr+note_patind)
        
midiout.close_port()
