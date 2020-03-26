clc;
clear all;
close all;
S = imread('input5_source.jpeg');
T = imread('input5_target.jpg');
color_transfer_lalphabeta(S,T);
color_transfer_RGB(S,T);
color_transfer_CIECAM(S,T);
