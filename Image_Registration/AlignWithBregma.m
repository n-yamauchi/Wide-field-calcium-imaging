%% Align with bregma
function AlignedImage = AlignWithBregma(ImageMatrix, coordinate, Bregma_Ref)
    pixel_num = 512
%     Curr_bregma = [round(coordinate{1}(1)/4),round(coordinate{1}(2)/4)]; % coordinate is from 512*512 frame
    Curr_bregma = [round(coordinate{1}(1)/(pixel_num/128)),round(coordinate{1}(2)/(pixel_num/128))]; 
    ShiftPixel = Bregma_Ref - Curr_bregma;

    for curr_frame = 1:size(ImageMatrix,2)
        Temp_aligned = [];
        Temp_aligned = circshift(reshape(ImageMatrix(:,curr_frame),128,128),[ShiftPixel(2) ShiftPixel(1)]);
        AlignedImage(:,curr_frame) = Temp_aligned(:);
    end
end