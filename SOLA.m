function So = SOLA(Speech,Rate,Fs)

FrameTime = 0.04; % 40ms
OffsetRate = 0.1;
FrameLength = ceil(FrameTime*Fs);
SpeechLength = length(Speech);
Win = hanning(FrameLength);
OffsetNum = ceil(OffsetRate*FrameLength);
Ss = ceil(0.5*FrameLength);
L = Ss;
FWin = [Win(1:Ss);ones(FrameLength-Ss,1)];
TWin = [Win(end-Ss+1:end);zeros(FrameLength-Ss,1)];
Sa = ceil(Rate*0.5*FrameLength); % Hold the Ss as half the FrameLength
MaxFrameNum = ceil(SpeechLength/(Sa-OffsetNum)); % The Maximum FrameNum

So = zeros(MaxFrameNum*FrameLength,1);
So(1:FrameLength) = Speech(1:FrameLength); % First Frame

for i = 1:MaxFrameNum-1
	SCPoint = i*Sa;
    if SCPoint+OffsetNum+FrameLength >= SpeechLength
        Length = SpeechLength - SCPoint;
        So(i*Ss:i*Ss+Length) = Speech(SCPoint:SpeechLength);
        break;
    end
    Xco = xcorr(Speech((SCPoint-OffsetNum):(SCPoint+OffsetNum+L)),So(i*Ss:i*Ss+L));
    [~,StPoint] = max(Xco(L+2*OffsetNum+1:L+4*OffsetNum+1));
    StPoint = StPoint + SCPoint - OffsetNum - 1;
    So(i*Ss:i*Ss+FrameLength-1) = So(i*Ss:i*Ss+FrameLength-1).*TWin(1:end) + Speech(StPoint:(StPoint+FrameLength-1)).*FWin(1:end);
end
CutOff = find(So,1,'last');
So = So(1:CutOff);
end 
