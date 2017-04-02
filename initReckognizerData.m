initReckognizerConstants;

inputMatrix = zeros(0,0);
outputMatrix = zeros(0,0);
columnIndex = 0;

fontFolders = dir('schriften/*');
fontFolderSize = size(fontFolders);
for fontFolderIndex=1:fontFolderSize(1)
    if fontFolders(fontFolderIndex).isdir == 1
        letterFiles = dir(strcat('schriften/',fontFolders(fontFolderIndex).name,'/*.png'));
        letterFilesSize = size(letterFiles);
        for letterFilesIndex=1:letterFilesSize(1)
            columnIndex = columnIndex + 1;
            [inputMatrix(columnIndex,:), outputMatrix(columnIndex,:)] = calculateLetterData(strcat('schriften/',fontFolders(fontFolderIndex).name,'/'),letterFiles(letterFilesIndex).name);
        end
    end
end

inputTestMatrix = zeros(0,0);
outputTestMatrix = zeros(0,0);
columnIndex = 0;

letterFiles = dir(strcat('randomletters/*.png'));
letterFilesSize = size(letterFiles);
for letterFilesIndex=1:letterFilesSize(1)
    columnIndex = columnIndex + 1;
    [inputTestMatrix(columnIndex,:), outputTestMatrix(columnIndex,:)] = calculateLetterData('randomletters/',letterFiles(letterFilesIndex).name);
end
