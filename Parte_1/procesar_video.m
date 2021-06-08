function procesar_video(video_verde, video_fondo, video_resultado, tol)
  video_objeto=VideoReader(video_verde);
  video_back=VideoReader(video_fondo);
  frames_vo = video_objeto.NumberOfFrames; % Extrayendo la cantidad de frames que contiene el video.
  frames_vb = video_back.NumberOfFrames; % Extrayendo la cantidad de frames que contiene el video.
  frames = 0;
  if frames_vo < frames_vb
    frames=frames_vo;
  elseif frames_vo > frames_vb
    frames= frames_vb;
  else
    frames=frames_vo
  endif
  m=video_objeto.Height; % Extrayendo la cantidad de filas que contiene el video.
  n=video_objeto.Width; % Extrayendo la cantidad de columnas que contiene el video.
  video_result = VideoWriter(video_resultado);
  frame_k_vo=zeros(m,n,3);
  frame_k_vb=zeros(m,n,3);
  resultado_croma=zeros(m,n,3);
  for k=1:frames
    tic
    resultado_croma=croma(imresize(readFrame(video_objeto), 0.5), imresize(readFrame(video_back), 0.5), tol);
    writeVideo(video_result, im2uint8(resultado_croma));
    t1=toc
    k
  endfor
  close(video_objeto);close(video_back);close(video_result);
  
endfunction