function greek_d()

clc;
clear all;
close all;

IMG_SCALE = 1/108; % 28x28

%% Escolha de rede

redeTreino = 51;    % Alterar o valor para a rede desejada
letra = 1;       % Alterar o valor para o caracter desejado

netFileStr = strcat('net', int2str(redeTreino), 'c3.mat');
net = load(netFileStr, 'net').net;

%% Testar rede com caracter dado

img = imread(sprintf('Pasta4\\%d.jpg', letra));
img = imresize(img, IMG_SCALE);
binarizedImg = imbinarize(img);
letraBW(:, 1) = reshape(binarizedImg, 1, []);

identity = eye(10);
letraTarget = identity(:, rem(letra, 10));

out = sim(net, letraBW);

[~, b] = max(out(:, 1));      
[~, d] = max(letraTarget(:, 1));

%% Analisar resultado

possibleCharacters = ['α' 'β' 'γ' 'ε' 'η' 'θ' 'π' 'φ' 'ψ' 'ω'];

fprintf('Caracter correto: %c\n', possibleCharacters(d, 1));
fprintf('Caracter escolhido pela rede: %c\n', possibleCharacters(b, 1));

if (b == d)
    disp('Correto!');
else
    disp('Errado!');
end

end