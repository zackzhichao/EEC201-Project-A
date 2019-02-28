[Speech,Fs] = audioread('Test_voice.m4a');
% SpeechN = Pitchshift(Speech,2,Fs);
Speech = Speech(:,1);
tic;
SpeechN1 = SOLA(Speech,1.5,Fs);
% SpeechN = Pitchshift(Speech,2,3,Fs);
toc;
audiowrite('SpeedupedVoice.m4a',SpeechN1,Fs);
% sound(SpeechN,Fs);