clc;clear;close all;

pkg load image
pkg load video

video_verde = "video_avion.mp4";
video_fondo = "video_cielo.mp4";
video_resultado = "video_croma.mp4";
tol=0.333;

procesar_video(video_verde, video_fondo, video_resultado, tol)
