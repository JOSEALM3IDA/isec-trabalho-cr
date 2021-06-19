function greek_a()


clc;
clear all;
close all;

IMG_SCALE = 0.25;

letrasBW = zeros(3024 * 3024 * IMG_SCALE * IMG_SCALE, 10);

for i=1:10
    img = imread(sprintf('Pasta1\\%d.jpg', i));
    img = imresize(img, IMG_SCALE);
    binarizedImg = imbinarize(img);
    letrasBW(:, i) = reshape(binarizedImg, 1, []);
end

letrasTarget = [eye(10)];


net = feedforwardnet([10]);

net.trainFcn = 'trainrp';
net.layers{1}.transferFcn = 'purelin';
net.layers{2}.transferFcn = 'purelin';
net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 1;
net.divideParam.valRatio = 0;
net.divideParam.testRatio = 0;

view(net)

% TREINAR
[net,tr] = train(net, letrasBW, letrasTarget);

disp(tr)

out = sim(net, letrasBW)
r = 0;
for i=1:size(out,2)
    [a b] = max(out(:,i));
    [c d] = max(letrasTarget(:,i));
    if b == d
      r = r+1;
    end
end


accuracy = r/size(out,2);
fprintf('Precisao total de treino %f\n', accuracy)

end

