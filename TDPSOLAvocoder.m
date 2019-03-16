function kkk=TDPSOLAvocoder()

%setting parametres 
TargetSignal='test_3ssingle.wav';    %wav file name to process
Output='Psignal.wav';                %file name for output
PitchScale=1;    %pitch scale parametre
TimeScale=1;     %time scale parametre
Cutoff=900;      %cut off frequency for lowpass

%data to present
OutputSignal=[];   %final result

[Input,fs]=audioread( TargetSignal );
Input=Input-mean( Input );    %normalize the input signal

%signal process part
LPSignal=Input.*fir1( 48 , Cutoff/fs , 'low' );   %Use lowpass to filter noise
PitchContour=PitchEstimate( LPSignal , fs );   %Calculate PitchContour
kkk=PitchContour;
DisplayPitchContour=PitchContour /max( PitchContour );
plot(DisplayPitchContour)
hold on
plot(Input)
hold off
%audiowrite(config.Output,data.OuputSignal,fs);


end

