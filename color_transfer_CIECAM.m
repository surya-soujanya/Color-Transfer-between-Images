
function color_transfer_CIECAM(S,T)
    figure;
    subplot(1,3,1)
    imshow(S)
    title('Source');
    
    subplot(1,3,2)
    imshow(T)
    title('Target');
        
    S = double(S)/255;
    T = double(T)/255;
    
    S = rgbtociecam(S);
    T = rgbtociecam(T);

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
    
    T = ciecamtorgb(T);
    subplot(1,3,3)
    imshow(T)
    title('Target image with color transfered from source image');
    imwrite(T,'outputcie.jpeg');
    
end
function im = rgbtociecam(I)
    
    R=I(:,:,1);
    G=I(:,:,2);
    B=I(:,:,3);
    
    L = 0.381 * R + 0.578 * G + 0.040 * B;
    M = 0.197 * R + 0.724 * G + 0.078 * B;
    S = 0.024 * R + 0.129 * G + 0.844 * B;
    
    A =  2.00 * L + 1.00 * M + 0.05 * S;
    C1 = 1.00 * L - 1.09 * M + 0.09 * S;
    C2 = 0.11 * L + 0.11 * M - 0.22 * S;
    
    im = cat(3,A,C1,C2);
    
end
function im = ciecamtorgb(I)
    
    A=I(:,:,1);
    C1=I(:,:,2);
    C2=I(:,:,3);
    
    R = 0.328 * A + 0.322 * C1 + 0.206 * C2;
    G = 0.328 * A - 0.635 * C1 - 0.185 * C2;
    B = 0.328 * A - 0.157 * C1 - 4.535 * C2;
    
    im = cat(3,R,G,B);
    
end


