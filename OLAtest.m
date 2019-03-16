function ProcessWaveform=OLAtest(changerate)

%parametre setting
Filename='test_3ssingle.wav';   %Signal to process
[Waveform, Fs]=audioread( Filename );

Framelength=round( 0.2* Fs );      %20ms frame length
Hammingwindow=hamming( 0.015* Fs);    %hamming analyze window
Windowshift=round( 0.5 * 0.015 * Fs );    %window shifting rate

%Perform STFT and strech or compress the signal
Changedshift=round( changerate * Windowshift );
[ProcessWaveform, STFTsignal]=STFT( Waveform, Hammingwindow, Windowshift, Changedshift);
figure(1)
spectrogram(Waveform)
figure(2)
spectrogram(ProcessWaveform)
figure(3)
plot(Waveform)
figure(4)
plot(ProcessWaveform)
audiowrite('OLAPSignal.wav', ProcessWaveform, Fs)

end

function [ProcessWaveform,STFTsignal]=STFT(Waveform, Hammingwindow, Windowshift, ChangedShift)
[Waveformlength, ChannelNum]=size( Waveform );
FrameLength=length( Hammingwindow );
FrameNum=ceil((Waveformlength-FrameLength)/Windowshift)+1;
Zeronumber=(FrameNum-1)*Windowshift-(Waveformlength-FrameLength);
SWaveform=[Waveform;zeros(Zeronumber,ChannelNum)];
STFTsignal=zeros(FrameLength,FrameNum);
n=1;m=1;
for m=1:ChannelNum
    for n=1:FrameNum
        STFTsignal(:,n)=SWaveform((Windowshift*(n-1)+1):(Windowshift*(n-1)+FrameLength),m).*Hammingwindow;
    end
    ProcessWaveform(:,m)=Synthesiser(STFTsignal,ChangedShift);
end

end

function ProcessWaveform=Synthesiser(STFTsignal,ChangedShift)
[FrameLength,FrameNum]=size(STFTsignal);
Num=ChangedShift*(FrameNum-1)+FrameLength;
ProcessWaveform=zeros(Num,1);
for k=1:FrameNum
    ProcessWaveform((1+(k-1)*ChangedShift):(FrameLength+(k-1)*ChangedShift))=ProcessWaveform((1+(k-1)*ChangedShift):(FrameLength+(k-1)*ChangedShift))+STFTsignal(:,k);
end
%minus the overlapping part of processWaveform
ProcessWaveform((ChangedShift+1):FrameLength+(FrameNum-2)*ChangedShift)=0.5*ProcessWaveform((ChangedShift+1):FrameLength+(FrameNum-2)*ChangedShift);
end
