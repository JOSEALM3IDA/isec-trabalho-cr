function greek_d()

clc;
clear all;
close all;

IMG_SCALE = 1/108; % 28x28

%% Escolha de rede

redeTreino = 51;    % Alterar o valor para a rede desejada
letra = 1;       % Alterar o valor para o caracter desejado

netFileStr = strcat('net', int2str(redeTreino), 'c3.mat')
net = load(netFileStr, 'net').net;

disp(net)

%% Testar rede com caracter dado

img = imread(sprintf('Pasta4\\%d.jpg', letra));
img = imresize(img, IMG_SCALE);
binarizedImg = imbinarize(img);
letraBW(:, 1) = reshape(binarizedImg, 1, []);

identity = eye(10);
letraTarget = identity(:, rem(letra, 10));

out = sim(net, letraBW);

r = 0;
for i = 1: size(out, 2)                % Para cada classificação:
    [~, b] = max(out(:, i));           % b guarda a linha onde encontrou valor mais alto da saída obtida
    [~, d] = max(letraTarget(:, i));  % d guarda a linha onde encontrou valor mais alto da saída desejada
    if b == d                           % Se estão na mesma linha, a classificação foi correta (incrementa 1)
      r = r+1;
    end
end

accuracy = r/size(out, 2);
fprintf('Precisão total de simulação para a pasta 1: %f\n', accuracy);

end