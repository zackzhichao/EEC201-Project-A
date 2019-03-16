function pitch = PitchDetect(x, fs)
% Detect pitch in a speech segment
% pitch = 0 for unvoiced segment

MinLag = round( fs / 500);
MaxLag = round( fs / 70);

cc = CenterClipping(x, 0.3);    % Center Cliping for pre-processing
AutoCorr = xcorr(cc, MaxLag, 'coeff');      % normalize ACF
AutoCorr = AutoCorr(MaxLag + 1 : 2*MaxLag);     %take second half of the ACF


[MaxACF, MaxIndex] = max(AutoCorr(MinLag : MaxLag)); %search max value of ACF in search region
MaxIndex = MaxIndex + MinLag - 1;


[MinValue, ~] = min(AutoCorr(1 : MaxIndex));


if MaxACF > 0.35 && MinValue < 0 && IsPeak(MaxIndex, MinLag, MaxLag, AutoCorr)
    pitch = fs / (MaxIndex);
    else pitch = 0;
end


function v = IsPeak(i, min, max, x)
v = false;
if i == min || i == max
   return
end
if x(i) < x(i-1) || x(i) < x(i+1)
   return
end
v = true;
end

function [cc, ClipLevel] = CenterClipping(x, Percentage)

MaxAmp = max( abs(x) );
ClipLevel = MaxAmp * Percentage;
PositiveSet = find( x > ClipLevel);
NegativeSet = find (x < -ClipLevel);
cc = zeros( size(x) );
cc(PositiveSet) = x(PositiveSet) - ClipLevel;
cc(NegativeSet) = x(NegativeSet) + ClipLevel;

end

end
