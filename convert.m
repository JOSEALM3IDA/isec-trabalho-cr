function convert()
clc
clear all;
close all;
net = load('net46.mat', 'net').net;
disp(net)
save('net.mat', 'net');
end