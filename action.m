function action(vid)
   % Argument - the loaded video through vid = VideoReader(fileName); % Time-taking
   numFrames = get(vid, 'NumberOfFrames');
%    vidFrames = read(v); % Too expensive! Read one/two frame at a time
   for i = 1:100:1000
      vidFrame_1 = read(vid, i);
      vidFrame_2 = read(vid, i+100);
      vidFrame_1 = vidFrame_1(:,:,1);   % Keep only one color component
      vidFrame_2 = vidFrame_2(:,:,1);   % Keep only one color component
      [u,v] = LK(vidFrame_1, vidFrame_2);   % Find the optical flow (time-taking)
      subplot(2,2,1)
      subimage(vidFrame_1)
      title('Image 1'); 
      subplot(2,2,2)
      subimage(vidFrame_2)
      title('Image 2'); 
      subplot(2,2,3)
      subimage(sqrt(u.^2+v.^2))
      title('Magnitude of optical flow'); 
      subplot(2,2,4)
      [x,y] = meshgrid(1:10:size(vidFrame_1,2),1:10:size(vidFrame_1,1));
      quiver(x,y,u(1:10:size(vidFrame_1,1),1:10:size(vidFrame_1,2)),v(1:10:size(vidFrame_1,1),1:10:size(vidFrame_1,2)))
      title('Optical Flow'); 
      drawnow;
      disp('breakpoint');
   end
end