function seg = segment_image(I)
    % 讀取影像
    I0 = imread(I);
    
    % 轉換為雙精度數據，適合 K-means
    I_double = im2double(I0);
    
    % 取得影像尺寸
    [x, y, rgb] = size(I_double);
    
    % 重新排列影像數據，以便進行 K-means 分群
    pixel_values = reshape(I_double, x*y, rgb);
    
    % 設定 K 值 (群的數量)
    K = 5;
    
    % 進行 K-means 分群
    [idx, centroids] = kmeans(pixel_values, K, 'MaxIter', 200, 'Replicates', 3);
    
    % 生成分割後的影像
    segmented_image = reshape(centroids(idx, :), x, y, rgb);
    
    % 轉換為灰階
    NewI_2 = rgb2gray(segmented_image);
    
    % 高斯平滑
    g = fspecial('gaussian', 7, 1.5);
    I_g = uint8(conv2(NewI_2, g, 'same'));

    % 拉普拉斯濾波
    La = [-1,-1,-1;-1,8,-1;-1,-1,-1]/8;
    seg = conv2(I_g, La, 'same');

    % 邊緣檢測
    Canny1 = edge(NewI_2, 'canny');

    % 顯示結果
    figure,
    subplot(2,2,1), imshow(seg), title('Segmented Image')
    subplot(2,2,2), imshow(Canny1), title('Canny Edge Detection')
    subplot(2,2,3), imshow(I0), title('Original Image')
end
