%function TDPSOLAvocoder=TDPSOLAvocoder()
function kkk=TDPSOLAvocoder()

%setting parametres 
global parametre
parametre.TargetSignal='test_3ssingle.wav';    %wav file name to process
parametre.Output='Psignal.wav';                %file name for output
parametre.PitchScale=1;    %pitch scale parametre
parametre.TimeScale=1;     %time scale parametre
parametre.Cutoff=900;      %cut off frequency for lowpass

%data to present
global data
data.OutputSignal=[];   %final result
data.PitchMark=[];      %pitch mark information
data.Candidate=[];      %pitch mark candidate to be analyzed

[Input,fs]=audioread(parametre.TargetSignal);
Input=resample(Input, 160, 441);
fs=fs*160/441;
Input=Input-mean(Input);    %normalize the input signal

%signal process part
Input=Input.*fir1(48,parametre.Cutoff/fs,'low');   %Use lowpass to filter noise
PitchContour=PitchEstimate(Input,fs);   %Calculate PitchContour
kkk=PitchContour;
plot(kkk)
hold on
plot(Input)
%audiowrite(config.Output,data.OuputSignal,fs);


end

