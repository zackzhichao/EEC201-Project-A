%Using ACF to calculate pitch
function PitchContour = PitchEstimate(x, fs)
%parameters
FrameSize = round(fs * 0.030);  %30 ms analyze frame
FrameRate = round(fs * 0.010);  %analyze frame shifting length
SignalLength = length(x);
FrameNum = floor((SignalLength - FrameSize) / FrameRate) + 2;
FramePitch = zeros(FrameNum + 2, 1);

% Calculate pitch for each frame
Range = 1 : FrameSize;
for Count = 2 : FrameNum
    FramePitch(Count) = PitchDetect(x(Range), fs);
    Range = Range + FrameRate;
end

% Using median filter for Pos-processing
FramePitch = medfilt1(FramePitch, 5);

% calculate pitch contour
PitchContour = zeros(SignalLength, 1);
for i = 1 : SignalLength
    PitchContour(i) = FramePitch(floor(i / FrameRate) + 1);
end
