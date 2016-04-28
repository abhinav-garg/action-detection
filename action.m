function action(fileName)
   vid = VideoReader(fileName);
   numFrames = get(vid, 'NumberOfFrames');
%    vidFrames = read(v); % Too expensive! Read one/two frame at a time
   for i = 1:10
      vidFrame_1 = read(vid, [i]);
      vidFrame_2 = read(vid, [i+1]);
      vidFrame_1 = vidFrame_1(:,:,1);   % Keep only one color component
      vidFrame_2 = vidFrame_2(:,:,1);   % Keep only one color component
   end
end