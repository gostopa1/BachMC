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

from aux import *

if available_ports:
    #midiout.open_port(1)
    midiout.open_port(5)
else:
    midiout.open_virtual_port("My virtual output")

def findainb(a,b):
    ind=[]
    for i in range(len(a)):
        if a[i]==b:
            ind.append(i)
    return ind


notevel=80
notedur=0.1

#To play first the introduction)
for i in range(len(startstr)):
    patind=startstr[i];
    
    for j in range(len(patlist[startstr[i]])):
        notenum=patlist[patind][j]
        
        control = [0x90, notenum, notevel]
        midiout.send_message(control)
        time.sleep(notedur)
    for j in range(len(patlist[patind])):
        notenum=patlist[patind][j]
        
        control = [0x80, notenum, 0]
        midiout.send_message(control)
        
patind=findainb(trans,startstr)[0]
#patind=random.randint(0,len(patlist)) # In case of randomness
patind=np.random.permutation(translist[patind])[0];

for i in range(500):
    
    for j in range(len(patlist[patind])):
        notenum=patlist[patind][j]
        print(notenum)
        control = [0x90, notenum, notevel]
        midiout.send_message(control)
    time.sleep(notedur/1)
    
    print('')
    for j in range(len(patlist[patind])):
        notenum=patlist[patind][j]
        
        control = [0x80, notenum, 0]
        midiout.send_message(control)
    
    
    try :
        patind=findainb(trans,startstr)[0]
    except:
        print('no patterns!')
        patind=random.randint(0,len(patlist)) # In case of randomness   
    
    
    patind=np.random.permutation(translist[patind])[0];
    notedur=np.random.permutation(durlist[patind])[0];
    notevel= np.random.permutation(amplist[patind])[0];
    startstr.insert(len(startstr),patind)
    
    #print(startstr+patind)
    
    startstr=startstr[1::]
    
midiout.close_port()
