pkg load image
pkg load signal

function yuv = rgb_to_yuv(rgb)
  rgb = im2double(rgb)*255;
  c = [
    0.299, 0.587, 0.114;
    -0.14713, -0.28886, 0.436;
    0.615, -0.51499, -0.10001;
  ];
  
  r = rgb(:,:,1); g = rgb(:,:,2); b = rgb(:,:,3);  
  yuv = zeros(size(rgb));
  
  yuv(:,:,1) = r*c(1,1) + g*c(1,2) + b*(c(1,3));
  yuv(:,:,2) = r*c(2,1) + g*c(2,2) + b*(c(2,3)) + 128;
  yuv(:,:,3) = r*c(3,1) + g*c(3,2) + b*(c(3,3)) + 128;
endfunction

function rgb = yuv_to_rgb(yuv)
  y = yuv(:,:,1);
  u = yuv(:,:,2) - 128;
  v = yuv(:,:,3) - 128;
  
  rgb = zeros(size(yuv)); 

  rgb(:,:,1) = y + 1.13983*v;
  rgb(:,:,2) = y - 0.39465*u - 0.58060*v;
  rgb(:,:,3) = y + 2.03211*u;  
  
  rgb = uint8(rgb);
endfunction

function res = do_dct(img)
  res = img;    
  res = im2double(res);
  
  for i = 1:3
    res(:,:,i) = blockproc(res(:,:,i), [8 8], @dct2);
  endfor
endfunction

function res = do_idct(img)
  res = img;
  res = apply_on_reshaped(res, @double);
  #res = im2double(res);
  
  for i = 1:3
    res(:,:,i) = blockproc(res(:,:,i), [8 8], @idct2);
  endfor
endfunction

function show_images(rows, columns, varargin)
  for i = 1:size(varargin)(2)
    subplot(rows, columns, i);
    imshow(varargin{i});
  endfor
endfunction

function r = apply_on_reshaped(m, f)
  rep = @(m) reshape(m, 1, []);
  derep = @(rm) reshape(rm, size(m));
  r = derep(f(rep(m)));
endfunction

function res = quantization(img, quality)
  res = img;
  R = 100-quality+1;
  Q = 1 + (transpose(0:7)*ones(1,8)+ones(8,1)*(0:7))*R;
    
  for i = 1:3
    res(:,:,i) = blockproc(res(:,:,i), [8 8], @(x) x./Q);
  endfor
  
  res = apply_on_reshaped(res, @int16);
endfunction

function res = dequantization(img, quality)
  res = img;
  R = 100-quality+1;
  Q = 1 + (transpose(0:7)*ones(1,8)+ones(8,1)*(0:7))*R;
    
  for i = 1:3
    res(:,:,i) = blockproc(res(:,:,i), [8 8], @(x) x.*Q);
  endfor
endfunction

function do_task(image, Q)
  steps = {
    @rgb_to_yuv 
    @do_dct
    @(img)quantization(img,Q)
    @(img)dequantization(img,Q) 
    @do_idct
    @yuv_to_rgb
  };
  
  base = compressed = image;
  for i = 1:size(steps)
    compressed = steps{i}(compressed);
  endfor
  
  show_images(1, 2, base, compressed);
endfunction

function click(ed)
  Q = str2num(get(ed, 'string'))
  
  if sum(size(Q) - ones(size(size(Q)))) != 0
    set(ed, 'string', 'no');
    return
  endif
  
  if Q < 1 || 100 < Q
    set(ed, 'string', 'no');
    return
  endif
  
  img_source = imread('s2_inft_lab7_img1.png');
  do_task(img_source, Q);
  
endfunction

fi = figure;
ed = uicontrol(fi, 'Style', 'edit',   
  'String', ' ', 
  'position', [0 0 60 30]
  );
  
bu = uicontrol(fi, 'Style', 'pushbutton', 
  'string', 'do things', 
  'position', [80 0 80 30],
  'callback', 'click(ed)'
  );