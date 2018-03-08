% ROBT 310 - Project 3
%
% Author: Anuar Maratkhan
% Date: 1 March 2018

close all ; clc; clear;

%% accomplished task
vid = VideoReader('robt310_proj3_expert_amaratkhan.avi');
frames = vid.NumberOfFrames;

output = VideoWriter('result.avi');
open(output);

% process the video
for i = 1:frames
   img = read(vid,i);
   img(:,:,1) = medfilt2(img(:,:,1));
   img(:,:,2) = medfilt2(img(:,:,2));
   img(:,:,3) = medfilt2(img(:,:,3));
   
   img(:,:,1) = frequency_noise(img(:,:,1));
   img(:,:,2) = frequency_noise(img(:,:,2));
   img(:,:,3) = frequency_noise(img(:,:,3));
   
   writeVideo(output,img);
end

close(output);

implay('result.avi');

%% development process
close all; clear;

vid = VideoReader('robt310_proj3_expert_amaratkhan.avi');
img = readFrame(vid);

% median filter
gray = rgb2gray(img);
median = medfilt2(gray);

% Fourier transform
f = fft2(median);

% remove spikes
f_shifted = fftshift(f);

% good representation of frequency domain
representation = log(abs(f_shifted));
figure(10); imshow(representation,[]); axis on; title('Frequency domain');

% thresholding (DC + spikes)
thresh = 10.9;
brightSpikes = representation > thresh;
figure(11); imshow(brightSpikes); axis on; title('Bright spikes with DC component');

brightSpikes(:,:) = 0;
% high spikes
brightSpikes(247:251,239:243) = 1;
brightSpikes(251:255,247:251) = 1;
brightSpikes(259:263,263:267) = 1;
brightSpikes(263:267,271:275) = 1;
% low spikes
brightSpikes(240:244,222:226) = 1;
brightSpikes(270:274,288:292) = 1;
brightSpikes(278:282,304:308) = 1;
% doubtful spikes
brightSpikes(253,245) = 1;
brightSpikes(253,246) = 1;
brightSpikes(254,245) = 1;

brightSpikes(261,268) = 1;
brightSpikes(261,269) = 1;
brightSpikes(260,269) = 1;

% smallest spikes
brightSpikes(240:244,222:226) = 1;
brightSpikes(270:274,288:292) = 1;

% % what the fuck am I doing
% brightSpikes(234,208) = 1;

% % anything else?
% brightSpikes(1:256,257) = 1;
% brightSpikes(258:512,257) = 1;
% 
% brightSpikes(257,1:256) = 1;
% brightSpikes(257,258:512) = 1;

% experiment #23
brightSpikes(241:245,224:228) = 1;
brightSpikes(242:246,226:230) = 1;
brightSpikes(243:247,228:232) = 1;
brightSpikes(244:248,231:235) = 1;
brightSpikes(245:249,234:238) = 1;
brightSpikes(246:250,237:241) = 1;

brightSpikes(264:268,273:277) = 1;
brightSpikes(265:269,275:279) = 1;
brightSpikes(266:270,278:282) = 1;
brightSpikes(267:271,280:284) = 1;
brightSpikes(268:272,283:287) = 1;
brightSpikes(269:273,285:289) = 1;

brightSpikes(271:275,290:294) = 1;
brightSpikes(272:276,292:296) = 1;
brightSpikes(273:277,294:298) = 1;
brightSpikes(274:278,296:300) = 1;
brightSpikes(275:279,298:302) = 1;
brightSpikes(276:280,300:304) = 1;
brightSpikes(277:281,302:306) = 1;

brightSpikes(248:252,241:245) = 1;
brightSpikes(249:253,243:247) = 1;
brightSpikes(250:254,245:249) = 1;

brightSpikes(260:264,265:269) = 1;
brightSpikes(261:265,267:271) = 1;
brightSpikes(262:266,269:273) = 1;

brightSpikes(252:256,249:253) = 1;
brightSpikes(253:257,251:255) = 1;

brightSpikes(257:261,259:263) = 1;
brightSpikes(258:262,261:265) = 1;

% long run
brightSpikes(239:243,220:224) = 1;
brightSpikes(238:242,218:222) = 1;
brightSpikes(237:241,216:220) = 1;
brightSpikes(236:240,214:218) = 1;
brightSpikes(235:239,212:216) = 1;
brightSpikes(234:238,210:214) = 1;
brightSpikes(233:237,208:212) = 1;
brightSpikes(232:236,206:210) = 1;
brightSpikes(231:235:235,204:208) = 1;
brightSpikes(230:234,202:206) = 1;
brightSpikes(229:233,200:204) = 1;
brightSpikes(228:232,198:202) = 1;
brightSpikes(227:231,196:200) = 1;
brightSpikes(226:230,194:198) = 1;
brightSpikes(225:229,192:196) = 1;
brightSpikes(224:228,190:194) = 1;
brightSpikes(223:227,188:192) = 1;
brightSpikes(222:226,186:190) = 1;
brightSpikes(221:225,184:188) = 1;
brightSpikes(220:224,182:186) = 1;
brightSpikes(219:223,180:184) = 1;
brightSpikes(218:222,178:182) = 1;
brightSpikes(217:221,176:180) = 1;
brightSpikes(216:220,174:178) = 1;
brightSpikes(215:219,172:176) = 1;
brightSpikes(214:218,170:174) = 1;
brightSpikes(213:217,168:172) = 1;
brightSpikes(212:216,166:170) = 1;
brightSpikes(211:215,164:168) = 1;
brightSpikes(210:214,162:166) = 1;
brightSpikes(209:213,160:164) = 1;
brightSpikes(208:212,158:162) = 1;
brightSpikes(207:211,156:160) = 1;
brightSpikes(206:210,154:158) = 1;
brightSpikes(205:209,152:156) = 1;
brightSpikes(204:208,150:154) = 1;
brightSpikes(203:207,148:152) = 1;
brightSpikes(202:206,146:150) = 1;
brightSpikes(201:205,144:148) = 1;
brightSpikes(200:204,142:146) = 1;
brightSpikes(199:203,140:144) = 1;
brightSpikes(198:202,138:142) = 1;
brightSpikes(197:201,136:140) = 1;
brightSpikes(196:200,134:138) = 1;
brightSpikes(195:199,132:136) = 1;
brightSpikes(194:198,130:134) = 1;
brightSpikes(193:197,128:132) = 1;
brightSpikes(192:196,126:130) = 1;
brightSpikes(191:195,124:128) = 1;
brightSpikes(190:194,122:126) = 1;
brightSpikes(189:193,120:124) = 1;
brightSpikes(188:192,118:122) = 1;
brightSpikes(187:191,116:120) = 1;
brightSpikes(186:190,114:118) = 1;
brightSpikes(185:189,112:116) = 1;
brightSpikes(184:188,110:114) = 1;
brightSpikes(183:187,108:112) = 1;
brightSpikes(182:186,106:110) = 1;
brightSpikes(181:185,104:108) = 1;
brightSpikes(180:184,102:106) = 1;
brightSpikes(179:183,100:104) = 1;
brightSpikes(178:182,98:102) = 1;
brightSpikes(177:181,96:100) = 1;
brightSpikes(176:180,94:98) = 1;
brightSpikes(175:179,92:96) = 1;
brightSpikes(174:178,90:94) = 1;
brightSpikes(173:177,88:92) = 1;
brightSpikes(172:176,86:90) = 1;
brightSpikes(171:175,84:88) = 1;
brightSpikes(170:174,82:86) = 1;
brightSpikes(169:173,80:84) = 1;
brightSpikes(168:172,78:82) = 1;
brightSpikes(167:171,76:80) = 1;
brightSpikes(166:170,74:78) = 1;
brightSpikes(165:169,72:76) = 1;
brightSpikes(164:168,70:74) = 1;
brightSpikes(163:167,68:72) = 1;
brightSpikes(162:166,66:70) = 1;

% tired of hardcoding, will use loops
counter = 0;
for i = 281:360
    counter = counter+1;
    j = i+26+counter;
    brightSpikes(i-2:i+2,j-2:j+2) = 1;
end


























figure(12); imshow(brightSpikes); axis on; title('Bright spikes without DC component');

brightSpikes = 1 - brightSpikes;

imwrite(brightSpikes,'mask.png');

f_shifted = f_shifted.*brightSpikes;
figure(13); imshow(log(abs(f_shifted)),[]); axis on; title('Filtered');

% results
f = ifftshift(f_shifted);
filteredImage = real(ifft2(f));
filteredImage = uint8(filteredImage);
figure(21); imshowpair(median, filteredImage, 'montage');

fabs = 100*log(1+abs(fftshift(f)));

figure(42); mesh(fabs);







