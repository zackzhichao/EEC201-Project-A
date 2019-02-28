% V0.1 The idea is first use upsampling and downsampling to change the
% speed and pitch, then change the speed of speech.
% If rate > 1, then move the pitch higher, otherwise lower
% Assume shift by an integer number
function So = Pitchshift(Speech,p,q,Fs)
So = SOLA(Speech,p/q,Fs);
%% Change the speed and pitchshift by resampling
So = resample(So,p,q);
end