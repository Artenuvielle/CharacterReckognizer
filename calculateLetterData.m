function [ inputMatrix, outputMatrix ] = calculateLetterData( folder, filename )
%CALCULATELETTERDATA Summary of this function goes here
%   Detailed explanation goes here

    initReckognizerConstants;

    outputMatrix = zeros(size(letters));
    outputMatrix(letters == filename(1)) = 0.98;

    currentLetterPath = strcat(folder,filename);
    disp(strcat('Calculating ', 1, currentLetterPath,'...'))
    
    I = imread(currentLetterPath);
    letterMat=im2bw(I);
    letterMat=imcomplement(letterMat);
    
    aLetterMat = letterMat(any(letterMat'),any(letterMat));
    [height, width] = size(aLetterMat);
    %mid = [floor(height/2) floor(width/2)];

    featureCounter = 1;
    %disp('Height/Width:')
    inputMatrix(featureCounter) = height / width;
    %disp(inputMatrix(1))
    if inputMatrix(featureCounter) < minimumLetterResolution
        disp('Below minimum letter resolution. Exiting...');
        return;
    elseif inputMatrix(featureCounter) > maximumLetterResolution
        disp('Above maximum letter resolution. Exiting...');
        return;
    end

    featureCounter = featureCounter + 1;
    %disp('A:')
    inputMatrix(featureCounter) = sum(sum(aLetterMat)) / (height * width);
    %disp(inputMatrix(featureCounter));

    featureCounter = featureCounter + 1;
    %disp('U:')
    uLetterMat = bwperim(aLetterMat,8);
    inputMatrix(featureCounter) = sum(sum(uLetterMat)) / (height * width);
    %disp(inputMatrix(featureCounter));
    
    for featureGridNumber=1:size(featureGrid,1)
        currentGridRowNumber = featureGrid(featureGridNumber,1);
        currentGridRowSize = floor( height / currentGridRowNumber);
        currentGridColumnNumber = featureGrid(featureGridNumber,2);
        currentGridColumnSize = floor( width / currentGridColumnNumber);
        for currentGridRow=1:currentGridRowNumber
            y1 = (currentGridRow - 1) * currentGridRowSize + 1;
            y2 = currentGridRow * currentGridRowSize;
            if currentGridRow == currentGridRowNumber
                y2 = height;
            end
            for currentGridColumn=1:currentGridColumnNumber
                x1 = (currentGridColumn - 1) * currentGridColumnSize + 1;
                x2 = currentGridColumn * currentGridColumnSize;
                if currentGridColumn == currentGridColumnNumber
                    x2 = width;
                end
                letterGridCell = aLetterMat(y1:y2, x1:x2);
                letterGridCellSize = size(letterGridCell, 1) * size(letterGridCell, 2);
                
                featureCounter = featureCounter + 1;
                %disp(strcat('A ',int2str(featureCounter/2-1),':'))
                inputMatrix(featureCounter) = sum(sum(letterGridCell)) / (letterGridCellSize);
                %disp(inputMatrix(featureCounter));
                
                %featureCounter = featureCounter + 1;
                %disp(strcat('U ',int2str((featureCounter-1)/2-1),':'))
                %inputMatrix(featureCounter) = sum(sum(bwperim(letterGridCell,8))) / (letterGridCellSize);
                %disp(inputMatrix(featureCounter));
            end
        end
    end
end

