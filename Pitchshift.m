function So = Pitchshift(Speech,rate,Fs)

tem = rats(rate);
k = strfind(tem,'/');
if isempty(k)
  p = rate;
  q = 1;
else
  p = str2num(tem(1:k-1));
  q = str2num(tem(k+1:end));
end
So = SOLA(Speech,rate,Fs);
So = resample(So,p,q);
end