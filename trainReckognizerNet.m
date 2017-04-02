initReckognizerConstants;

inputRanges = zeros(size(inputMatrix,2),2);
inputRanges(:,2) = 1;
inputRanges(1,1) = minimumLetterResolution;
inputRanges(1,2) = maximumLetterResolution;

net = newff(inputRanges,[60 10 size(letters,2)],{'logsig','purelin','logsig'},'trainlm');

%net.biasConnect(1) = 1;
%net.biasConnect(2) = 1;
net.trainParam.epochs = 500;
net.trainParam.goal = 1.e-10;

net.trainParam.lr   = 0.01; % Lernrate 0.01
net.trainParam.show = 100;   % Anzeige nach 100 Iterationen

% Abbruchbedingungen
net.trainParam.time     = inf;    % Trainigszeit in s: Inf
net.trainParam.min_grad = 1.e-10;      % Mindest-Grad.-Länge 1.e-10
net.trainParam.max_fail = 20;      % Overfitting-Vermeidung

net = train(net,inputMatrix',outputMatrix');
disp('Größter Fehler:')
disp(max(max(abs(outputMatrix' - sim(net,inputMatrix(:,:)')))))
disp('Durchschnittlicher Fehler:')
disp(mean(mean(outputMatrix' - sim(net,inputMatrix(:,:)'))))

disp('Größter Fehler (ungelernte Buchstaben):')
disp(max(max(abs(outputTestMatrix' - sim(net,inputTestMatrix(:,:)')))))
disp('Durchschnittlicher Fehler (ungelernte Buchstaben):')
disp(mean(mean(outputTestMatrix' - sim(net,inputTestMatrix(:,:)'))))