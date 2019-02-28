% Use SOLA(Synchronous-Overlap-Add) method to change the speed of speech
% while keeping the same pitch. Instead of just overlapping and add, this
% method use cross-correlation to indicate the start of the next cut,
% instead of a fixed one.
function So = SOLA(Speech,Rate,Fs)
%% parameters
FrameTime = 0.04; % 40ms
OffsetRate = 0.1;
FrameLength = ceil(FrameTime*Fs);
SpeechLength = length(Speech);
Win = hanning(FrameLength);
OffsetNum = ceil(OffsetRate*FrameLength);
L = 2*OffsetNum;
Ss = ceil(0.5*FrameLength);
Sa = ceil(Rate*0.5*FrameLength); % Hold the Ss as half the FrameLength
MaxFrameNum = ceil(SpeechLength/(Sa-OffsetNum)); % The Maximum FrameNum
%% Cut the frame
So = zeros(MaxFrameNum*FrameLength,1);
So(1:FrameLength) = Speech(1:FrameLength); % First Frame
So(Ss:FrameLength) = So(Ss:FrameLength).*Win(Ss:end); % Add Window
CoR = zeros(1,2*OffsetNum+1);
for i = 1:MaxFrameNum-1
	SCPoint = i*Sa;
    if SCPoint+OffsetNum+FrameLength >= SpeechLength
        Length = SpeechLength - SCPoint;
        So(i*Ss:i*Ss+Length) = Speech(SCPoint:SpeechLength);
        break;
    end
    for j = -OffsetNum:OffsetNum
        CoR(j+OffsetNum+1) = corr(So(i*Ss:i*Ss+L),Speech((SCPoint+j):(SCPoint+j+L))); % Calculate the corrlation coefficient
    end
    [MCorr,StPoint] = max(CoR);
    StPoint = StPoint + SCPoint - OffsetNum - 1;
	So(i*Ss:i*Ss+FrameLength-1) = So(i*Ss:i*Ss+FrameLength-1) + Speech(StPoint:(StPoint+FrameLength-1)).*Win(1:end);
%     if i == ceil(MaxFrameNum/4)
%         M = 25
%     end
%     if i == ceil(MaxFrameNum/2)
%         M = 50
%     end
%     if i == ceil(3*MaxFrameNum/4)
%         M = 75
%     end
%   Time Test
end
CutOff = find(So,1,'last');
So = So(1:CutOff);
end

