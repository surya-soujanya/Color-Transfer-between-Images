
function color_transfer_RGB(S,T);
    figure;
    subplot(1,3,1)
    imshow(S)
    title('Source');
    
    subplot(1,3,2)
    imshow(T)
    title('Target');
    
    S = double(S)/255;
    T = double(T)/255;
    
    L_source=S(:,:,1); L_source=reshape(L_source,[],1);
    a_source=S(:,:,2); a_source=reshape(a_source,[],1);
    b_source=S(:,:,3); b_source=reshape(b_source,[],1);
    
    mean_LS=mean(L_source);
    mean_aS=mean(a_source);
    mean_bS=mean(b_source);
    
    sd_Ls=std(L_source);
    sd_as=std(a_source);
    sd_bs=std(b_source);
    
    L_target=T(:,:,1); L_target=reshape(L_target,[],1);
    a_target=T(:,:,2); a_target=reshape(a_target,[],1);
    b_target=T(:,:,3); b_target=reshape(b_target,[],1);
    
    mean_LT=mean(L_target);
    mean_aT=mean(a_target);
    mean_bT=mean(b_target);
    
    sd_Lt=std(L_target);
    sd_at=std(a_target);
    sd_bt=std(b_target);
    
    l = T(:,:,1)-mean_LT;
    a = T(:,:,2)-mean_aT;
    b = T(:,:,3)-mean_bT;
    
    T(:,:,1)=(l).*(sd_Ls/sd_Lt);
    T(:,:,2)=(a).*(sd_as/sd_at);
    T(:,:,3)=(b).*(sd_bs/sd_bt);
    
    T(:,:,1)= T(:,:,1)+mean_LS;
    T(:,:,2)= T(:,:,2)+mean_aS;
    T(:,:,3)= T(:,:,3)+mean_bS;
    
    subplot(1,3,3)
    imshow(T)
    title('Target image with color transfered from source image');
    imwrite(T,'outputrgb.jpeg');
    
end