# EEC201-Project-A

Target

Design a vocoder in Matlab GUI. It should show the waveform of the uploaded voice file, 
performing streching, compressing, frequency or pitch shift. 

Group member\
Qinwe Deng   -mrdeng@ucdavis.edu\
Zhichao Qiu  -zcqiu@ucdavis.edu\
Shudi Chen   -sdichen@ucdavis.edu

Project tasks\
We decompose the design into four parts:\
  1.design a GUI interface\
  2.design a function that can cut down a specific pieces of sound from the file\
  3.design a function that can perform time streching or time compressing on the sound\
  4.design a function that can perform phase or pitch shifting on the sound
 
 We have read some papers and online videos and found that we can design a phase vocoder using STFT and\
 many overlap-add(OLA) ways such as OLA, SOLA, PSOLA. Therefore, we mainly focus on how to synchronize \
 STFT signals using OLA and other methods.
 
 Descriptions of methodology about each part\
  1.Use MATLAB to design a GUI interface of phase vocoder\
  2.We will first compute where should we cut down the signal and then cut it down.\
  3. For time stretching or time compressing, we SOLA and PSOLA to change the speed of the speech while\
  retain the original pitch. If we have enough time, we will find some frequency domain processing methods\ 
  and compare the result of these methods.\
  4.For pitch shifting, we use a time domain processing method. First, we use SOLA algorithm to change the\
  speed of the speech. Then we use resampling to change the speed and pitch of the speech at the same time.\
  The speed up ratio is the same with the resampling ratio, so that the pitch will move while retain the\
  original speed.
   
 Division of project tasks\
  Part 1 and 2 will be completed by Shudi Chen\
  Part 3 is decomposed into two parts. Using OLA to recover signal will be completed by Qinwen Deng and\
  Zhichao Qiu. Using PSOLA to recover signal will be completed by Zhichao Qiu.\
  Part 4 will be completed by Qinwen Deng.
  
  Milestone\
  Complete the design and make a good presentation on the class.
 
 Reference
 1. Eric Moulines, Francis Charpentier\
    Pitch-synchronous waveform processing techniques for text-to-speech synthesis using diphones\
    Speech Communication, Volume 9,Issues 5-6, Dec 1990, Page 453-467
 2. TAMU lecturing slides-http://research.cs.tamu.edu/prism/lectures/sp/l19.pdf
 3. GUI learning video (Chinese)- www.bilibili.com/video/av14841464
 4. Olli Parviainen\
    Time and pitch scaling in audio processing\
    Software Developer's Journal 4/2006

