function [] = create_letters()
    initReckognizerConstants;

    letterSize = size(letters);

    fontNames = cellstr(fontNames);
    fontNamesSize = size(fontNames);

    if exist('schriften')==7
        rmdir('schriften','s');
    end
    mkdir('schriften');

    for letterIndex=1:letterSize(2)
        for fontNamesIndex=1:fontNamesSize()
            clf
            axis([0 100 0 100]);
            axis off;
            set(gcf, 'color', [1 1 1]);
            text(30,50,letters(letterIndex),'FontSize',180,'FontName',fontNames{fontNamesIndex});
            m = getframe;
            if exist(strcat('schriften/', fontNames{fontNamesIndex}))~=7
                mkdir('schriften', fontNames{fontNamesIndex});
            end
            imwrite(m.cdata, strcat('schriften/',fontNames{fontNamesIndex},'/',letters(letterIndex),'.png'));
        end
    end

    if exist('randomletters')==7
        rmdir('randomletters','s');
    end
    mkdir('randomletters');

    for i=1:numberOfRandomLetters
        clf
        axis([0 100 0 100]);
        axis off;
        set(gcf, 'color', [1 1 1]);
        randomLetter = letters(floor(rand * (letterSize(2)) + 1));
        randomFontName = fontNames{floor(rand * (fontNamesSize(1)) + 1)};
        text(round(10 + rand * 50),round(30 + rand * 40),randomLetter,'FontSize',round(40 + rand * 150),'FontName',randomFontName);
        m = getframe;
        n = 1;
        while exist(strcat('randomletters/',randomLetter,'_',int2str(n),'.png'))~=0
            n = n + 1;
        end
        imwrite(m.cdata, strcat('randomletters/',randomLetter,'_',int2str(n),'.png'));
    end
end