


function color_transfer_lalphabeta(S,T);
    figure;
    subplot(1,3,1)
    imshow(S)
    title('Source');
    
    subplot(1,3,2)
    imshow(T)
    title('Target');
    
    imwrite(S,'source.jpeg');
    imwrite(T,'target.jpeg');
    
    S = double(S)/255;
    T = double(T)/255;
    
    S = rgbtolalphabeta(S);
    T = rgbtolalphabeta(T);
   
    
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
    
    
    T = lalphabetatorgb(T);
    
    subplot(1,3,3)
    imshow(T)
    title('Target image with color transfered from source image');
    imwrite(T,'outputlab.jpeg');
    
end
function im = rgbtolalphabeta(I)
    I = max(I,1/255);
    
    R=I(:,:,1);
    G=I(:,:,2);
    B=I(:,:,3);
    
    L = (0.381 * R) + (0.578 * G) + (0.040 * B);
    M = (0.197 * R) + (0.724 * G) + (0.078 * B);
    S = (0.024 * R) + (0.129 * G) + (0.844 * B);
    
    L = log10(L);
    M = log10(M);
    S = log10(S);
    
    l = ((1 / sqrt(3)) * L )+ ((1 / sqrt(3)) * M )+ ((1 / sqrt(3)) * S);
    alpha = ((1 / sqrt(6)) * L) +(( 1 / sqrt(6)) * M )- ((2 / sqrt(6)) * S);
    beta = ((1 / sqrt(2)) * L) - ((1 / sqrt(2)) * M) + (0 * S);
    
    im = cat(3,l,alpha,beta);
    
end
function im = lalphabetatorgb(I)
    
    l=I(:,:,1);
    alpha=I(:,:,2);
    beta=I(:,:,3);
    
    L = ((sqrt(3) / 3) * l) + ((sqrt(6) / 6) * alpha) + ((sqrt(2) / 2) * beta);
    M = ((sqrt(3) / 3) * l) + ((sqrt(6) / 6) * alpha) - ((sqrt(2) / 2) * beta);
    S = ((sqrt(3) / 3) * l) - ((sqrt(6) / 3) * alpha) - (0 * beta);
    
    L = 10.^L;
    M = 10.^M;
    S = 10.^S;
    
    R = ( 4.468 * L) - (3.587 * M) + (0.119 * S);
    G = (-1.219 * L) + (2.381 * M) - (0.162 * S);
    B = (0.0497 * L) - (0.244 * M) + (1.205 * S);
    
    im = cat(3,R,G,B);
    
end
