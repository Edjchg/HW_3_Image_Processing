clc;clear;close all;

pkg load image
pkg load video

video_verde = "video_avion.mp4";
video_fondo = "video_cielo.mp4";
video_resultado = "video_croma.mp4";
tol = 0.6;

%Tomar cada frame, combinar el frame del video con fondo verde y el fondo, 
%tomar los bordes de la imagen y restaturarla:
procesar_video(video_verde, video_fondo, video_resultado, tol)
