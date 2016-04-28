function action(fileName)
   v = VideoReader(fileName);
   numFrames = get(v, 'NumberOfFrames');
%    vidFrames = read(v); % Too expensive! Read one/two frame at a time
   for i = 1:10
      vidFrame_1 = read(v, [i]);
      vidFrame_2 = read(v, [i+1]);
   end
end