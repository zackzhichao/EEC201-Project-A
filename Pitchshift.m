% V0.1 The idea is first use upsampling and downsampling to change the
% speed and pitch, then change the speed of speech.
% If rate > 1, then move the pitch higher, otherwise lower
% Assume shift by an integer number
function So = Pitchshift(Speech,rate,Fs)
tem = rats(rate);
k = strfing(tem,'/');
if isempty(k)
  p = rate;
  q = 1;
else
  p = str2num(tem(1:k-1));
  q = str2num(tem(k+1:end));
end
So = SOLA(Speech,rate,Fs);
%% Change the speed and pitchshift by resampling
So = resample(So,p,q);
end
