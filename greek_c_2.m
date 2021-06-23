function greek_c_2()

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
    for j=1:10
        img = imread(sprintf('Pasta3\\%s', char(imgFiles(((j - 1) * 4) + i))));
        img = imresize(img, IMG_SCALE);
        binarizedImg = imbinarize(img);
        letrasBW(:, letrasBWCol) = reshape(binarizedImg, 1, []);
        letrasBWCol = letrasBWCol + 1;
    end
    
    letrasTarget = [letrasTarget eye(10)];
end

letrasTarget = flip(letrasTarget, 1);   % Todos os targets (excluindo da pasta 2) terão de ser flipped

%% Escolha de rede

redeTreino = 51;    % Alterar o valor para a rede desejada

switch redeTreino
    case 46
        %% Rede 46
        net = feedforwardnet([20 20 20 20 20 20]);

        net.trainFcn = 'trainscg';
        net.layers{1}.transferFcn = 'tansig';
        net.layers{2}.transferFcn = 'tansig';
        net.layers{3}.transferFcn = 'tansig';
        net.layers{4}.transferFcn = 'tansig';
        net.layers{5}.transferFcn = 'tansig';
        net.layers{6}.transferFcn = 'tansig';
        net.layers{7}.transferFcn = 'purelin';
        net.divideFcn = 'dividerand';
        net.divideParam.trainRatio = 0.5;
        net.divideParam.valRatio = 0;
        net.divideParam.testRatio = 0.5;
    
    case 50
        %% Rede 50
        net = feedforwardnet([20 20 20 20 20 20]);

        net.trainFcn = 'trainscg';
        net.layers{1}.transferFcn = 'tansig';
        net.layers{2}.transferFcn = 'logsig';
        net.layers{3}.transferFcn = 'purelin';
        net.layers{4}.transferFcn = 'tansig';
        net.layers{5}.transferFcn = 'tansig';
        net.layers{6}.transferFcn = 'logsig';
        net.layers{7}.transferFcn = 'purelin';
        net.divideFcn = 'dividerand';
        net.divideParam.trainRatio = 1;
        net.divideParam.valRatio = 0;
        net.divideParam.testRatio = 0;
        
    case 51
        %% Rede 51

        net = feedforwardnet([20 20 20 20 20 20]);

        net.trainFcn = 'trainscg';
        net.layers{1}.transferFcn = 'tansig';
        net.layers{2}.transferFcn = 'logsig';
        net.layers{3}.transferFcn = 'purelin';
        net.layers{4}.transferFcn = 'tansig';
        net.layers{5}.transferFcn = 'tansig';
        net.layers{6}.transferFcn = 'logsig';
        net.layers{7}.transferFcn = 'purelin';
        net.divideFcn = 'dividerand';
        net.divideParam.trainRatio = 0.9;
        net.divideParam.valRatio = 0.05;
        net.divideParam.testRatio = 0.05;
        
    otherwise
        disp('ERROR 404: NEURAL NETWORK NOT FOUND');
        return;
end
%% TREINAR REDE

%view(net)

% TREINAR
[net, ~] = train(net, letrasBW, letrasTarget);

out = sim(net, letrasBW);

r = 0;
for i = 1: size(out,2)                  % Para cada classificação:
    [~, b] = max(out(:,i));             % b guarda a linha onde encontrou valor mais alto da saída obtida
    [~, d] = max(letrasTarget(:,i));    % d guarda a linha onde encontrou valor mais alto da saída desejada
    if b == d                           % Se estão na mesma linha, a classificação foi correta (incrementa 1)
      r = r+1;
    end
end

plotconfusion(letrasTarget, out)
%plotperf(tr)

accuracy = r/size(out,2);
fprintf('Precisao total de treino %f\n', accuracy)

%% Testar rede com pasta 1

letrasBW = zeros(3024 * 3024 * IMG_SCALE * IMG_SCALE, 10);

for i = 1: 10
    img = imread(sprintf('Pasta1\\%d.jpg', i));
    img = imresize(img, IMG_SCALE);
    binarizedImg = imbinarize(img);
    letrasBW(:, i) = reshape(binarizedImg, 1, []);
end

letrasTarget1 = [eye(10)];
letrasTarget1 = flip(letrasTarget1, 1);   % Todos os targets (excluindo da pasta 2) terão de ser flipped

out1 = sim(net, letrasBW);

r = 0;
for i = 1: size(out1, 2)                % Para cada classificação:
    [~, b] = max(out1(:, i));           % b guarda a linha onde encontrou valor mais alto da saída obtida
    [~, d] = max(letrasTarget1(:, i));  % d guarda a linha onde encontrou valor mais alto da saída desejada
    if b == d                           % Se estão na mesma linha, a classificação foi correta (incrementa 1)
      r = r+1;
    end
end

accuracy = r/size(out1, 2);
fprintf('Precisão total de simulação para a pasta 1: %f\n', accuracy);

%% Testar rede com pasta 2

folderImg = dir('Pasta2\\letter_bnw_*.jpg');
imgFiles = natsort({folderImg.name});

letrasBW = zeros(3024 * 3024 * IMG_SCALE * IMG_SCALE, length(imgFiles));
letrasTarget2 = [];
letrasBWCol = 1;

for i = 1: length(imgFiles) / 10   
    for j = 1: 10
        img = imread(sprintf('Pasta2\\%s', char(imgFiles(((j - 1) * 10) + i))));
        img = imresize(img, IMG_SCALE);
        binarizedImg = imbinarize(img);
        letrasBW(:, letrasBWCol) = reshape(binarizedImg, 1, []);
        letrasBWCol = letrasBWCol + 1;
    end
    
    letrasTarget2 = [letrasTarget2 eye(10)];
end

out2 = sim(net, letrasBW);

r = 0;
for i = 1: size(out2, 2)                % Para cada classificação:
    [~, b] = max(out2(:, i));           % b guarda a linha onde encontrou valor mais alto da saída obtida
    [~, d] = max(letrasTarget2(:, i));  % d guarda a linha onde encontrou valor mais alto da saída desejada
    if b == d                           % Se estão na mesma linha, a classificação foi correta (incrementa 1)
      r = r+1;
    end
end

accuracy = r/size(out2, 2);
fprintf('Precisão total de simulação para a pasta 2: %f\n', accuracy);

%% Testar rede com pasta 3

folderImg = dir('Pasta3\\letter_bnw_test_*.jpg');
imgFiles = natsort({folderImg.name});

letrasBW = zeros(3024 * 3024 * IMG_SCALE * IMG_SCALE, length(imgFiles));
letrasTarget3 = [];
letrasBWCol = 1;
for i=1:length(imgFiles)/10  
    for j=1:10
        img = imread(sprintf('Pasta3\\%s', char(imgFiles(((j - 1) * 4) + i))));
        img = imresize(img, IMG_SCALE);
        binarizedImg = imbinarize(img);
        letrasBW(:, letrasBWCol) = reshape(binarizedImg, 1, []);
        letrasBWCol = letrasBWCol + 1;
    end
    
    letrasTarget3 = [letrasTarget3 eye(10)];
end

letrasTarget3 = flip(letrasTarget3, 1);   % Todos os targets (excluindo da pasta 2) terão de ser flipped

out3 = sim(net, letrasBW);

r = 0;
for i = 1: size(out3, 2)                % Para cada classificação:
    [~, b] = max(out3(:, i));           % b guarda a linha onde encontrou valor mais alto da saída obtida
    [~, d] = max(letrasTarget3(:, i));  % d guarda a linha onde encontrou valor mais alto da saída desejada
    if b == d                           % Se estão na mesma linha, a classificação foi correta (incrementa 1)
      r = r+1;
    end
end

accuracy = r/size(out3, 2);
fprintf('Precisão total de simulação para a pasta 3: %f\n', accuracy);

%% Plotconfusion para todas as simulações

plotconfusion(letrasTarget1, out1, 'Pasta 1', letrasTarget2, out2, 'Pasta 2', letrasTarget3, out3, 'Pasta 3');

% Mudar tamanho da letra
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 6);

end

