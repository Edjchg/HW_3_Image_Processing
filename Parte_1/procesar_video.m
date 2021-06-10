function procesar_video(video_verde, video_fondo, video_resultado, tol)
  %Abriendo el video con fondo verde:
  video_objeto=VideoReader(video_verde);
  %Abriendo el video del fondo deseado:
  video_back=VideoReader(video_fondo);
  % Extrayendo la cantidad de frames que contiene el video:
  frames_vo = video_objeto.NumberOfFrames; 
  % Extrayendo la cantidad de frames que contiene el video:
  frames_vb = video_back.NumberOfFrames; 
  frames = 0;
  if frames_vo < frames_vb
    frames=frames_vo;
  elseif frames_vo > frames_vb
    frames= frames_vb;
  else
    frames=frames_vo;
  endif
  % Extrayendo la cantidad de filas que contiene el video:
  m=video_objeto.Height; 
  % Extrayendo la cantidad de columnas que contiene el video:
  n=video_objeto.Width;
  % Estableciendo el archivo que va a contener el video resultante: 
  video_result = VideoWriter(video_resultado);
  % Tomando memoria para almacenar el K esimo frame de vo:
  frame_k_vo=zeros(m,n,3);
  % Tomaando memoria para almacenar el k esimo frame de vb:
  frame_k_vb=zeros(m,n,3);
  % Tomando memoria para almacenar el resultado de croma para cada frame:
  resultado_croma=zeros(m,n,3);
  for k=1:frames
    %resultado_croma=croma(imresize(readFrame(video_objeto), 0.5), imresize(readFrame(video_back), 0.5), tol);
    % Calculando croma para los frames del video con fondo verde y el video
    %Con fondo deseado:
    resultado_croma=croma(readFrame(video_objeto), readFrame(video_back), tol);
    % Escribiendo cada frame del video resultante en disco:
    writeVideo(video_result, im2uint8(resultado_croma));
    k
  endfor
  % Cerrando los archivos que se habían abierto anteriormente:
  close(video_objeto);close(video_back);close(video_result);
  
endfunction