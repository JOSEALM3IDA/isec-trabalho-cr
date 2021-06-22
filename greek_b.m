function greek_b()

clc;
clear all;
close all;

IMG_SCALE = 0.25;

folderImg = dir('Pasta2\\letter_bnw_*.jpg');
imgFiles = natsort({folderImg.name});

letrasBW = zeros(3024 * 3024 * IMG_SCALE * IMG_SCALE, length(imgFiles));
letrasTarget = [];
letrasBWCol = 1;
for i=1:length(imgFiles)/10   
    for j=1:10
        img = imread(sprintf('Pasta2\\%s', char(imgFiles(((j - 1) * 10) + i))));
        img = imresize(img, IMG_SCALE);
        binarizedImg = imbinarize(img);
        letrasBW(:, letrasBWCol) = reshape(binarizedImg, 1, []);
        letrasBWCol = letrasBWCol + 1;
    end
    
    letrasTarget = [letrasTarget eye(10)];
end

% CRIAR E CONFIGURAR A REDE NEURONAL
% INDICAR: N? camadas escondidas e nos por camada escondida
% INDICAR: Funcao de treino: {'trainlm', 'trainbfg', traingd'}
% INDICAR: Funcoes de ativacao das camadas escondidas e de saida: {'purelin', 'logsig', 'tansig'}
% INDICAR: Divisao dos exemplos pelos conjuntos de treino, validacao e teste

% Mostra grafico simplificado (3D) com a distribuicao dos exemplos
% idx_setosa = strcmp(species, 'setosa');
% idx_virginica = strcmp(species, 'virginica');
% idx_versicolor = strcmp(species, 'versicolor');
% setosa = irisInputs([1:3], idx_setosa);
% virgin = irisInputs([1:3], idx_virginica);
% versi = irisInputs([1:3], idx_versicolor);
% scatter3(setosa(1,:), setosa(2,:),setosa(3,:));
% hold on;
% scatter3(virgin(1,:), virgin(2,:),virgin(3,:), 'rs');
% scatter3(versi(1,:), virgin(2,:),versi(3,:), 'gx');
% legend('setosa', 'virginica', 'versicolor')
% grid on
% rotate3d on

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

%view(net)

% TREINAR
[net,tr] = train(net, letrasBW, letrasTarget);

% disp(tr)

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
fprintf('Precisao total de treino %f\n', accuracy)

save net;

% SIMULAR
%imgFiles = dir('Pasta2\\letter_bnw_1.jpg');
%letrasSim = zeros(3024 * 3024 * 0.125 * 0.125, length(imgFiles));
%for i=1:length(imgFiles)
%    img = imread(sprintf('Pasta2\\%s', imgFiles(i).name));
%    img = imresize(img, 0.125);
%    binarizedImg = imbinarize(img);
%    letrasSim(:, 1) = reshape(binarizedImg, 1, []);
%end

%out = sim(net, letrasSim)
%[a b] = max(out(:, i))

% 
% 
% %VISUALIZAR DESEMPENHO
% 
% %plotconfusion(irisTargets, out) % Matriz de confusao
% 
% %plotperf(tr)         % Grafico com o desempenho da rede nos 3 conjuntos           
% 
% 
% %Calcula e mostra a percentagem de classificacoes corretas no total dos exemplos
% r=0;
% for i=1:size(out,2)               % Para cada classificacao  
%   [a b] = max(out(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
%   [c d] = max(irisTargets(:,i));  %d guarda a linha onde encontrou valor mais alto da saida desejada
%   if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
%       r = r+1;
%   end
% end
% 
% accuracy = r/size(out,2)*100;
% fprintf('Precisao total %f\n', accuracy)
% 
% 
% % SIMULAR A REDE APENAS NO CONJUNTO DE TESTE
% TInput = irisInputs(:, tr.testInd);
% TTargets = irisTargets(:, tr.testInd);
% 
% out = sim(net, TInput);
% 
% 
% %Calcula e mostra a percentagem de classificacoes corretas no conjunto de teste
% r=0;
% for i=1:size(tr.testInd,2)               % Para cada classificacao  
%   [a b] = max(out(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
%   [c d] = max(TTargets(:,i));  %d guarda a linha onde encontrou valor mais alto da saida desejada
%   if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
%       r = r+1;
%   end
% end
% accuracy = r/size(tr.testInd,2)*100;
% fprintf('Precisao teste %f\n', accuracy)


end

