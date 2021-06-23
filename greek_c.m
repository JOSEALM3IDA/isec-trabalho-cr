function greek_c()

clc;
clear all;
close all;

IMG_SCALE = 0.25;

folderImg = dir('Pasta3\\letter_bnw_test_*.jpg');
imgFiles = natsort({folderImg.name});

letrasBW = zeros(3024 * 3024 * IMG_SCALE * IMG_SCALE, length(imgFiles));
letrasTarget = [];
letrasBWCol = 1;
for i=1:length(imgFiles)/10   
    for j=1:4
        img = imread(sprintf('Pasta3\\%s', char(imgFiles(((j - 1) * 10) + i))));
        img = imresize(img, IMG_SCALE);
        binarizedImg = imbinarize(img);
        letrasBW(:, letrasBWCol) = reshape(binarizedImg, 1, []);
        letrasBWCol = letrasBWCol + 1;
    end
    
    letrasTarget = [letrasTarget eye(4)];
end



% CARREGAR NET
net = load('net.mat', 'net');
disp(net);
% view(net)

out = sim(net, letrasBW)
r = 0;
for i=1:size(out,2)               % Para cada classificacao  
    [a b] = max(out(:,i));        %b guarda a linha onde encontrou valor mais alto da saida obtida
    [c d] = max(letrasTarget(:,i)); %d guarda a linha onde encontrou valor mais alto da saida desejada
    if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
      r = r+1;
    end
end

plotconfusion(letrasTarget, out)
%plotperf(tr)

accuracy = r/size(out,2);
fprintf('Precisao total %f\n', accuracy)

end

