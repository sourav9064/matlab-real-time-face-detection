% Real Time Multi Face Detection

clear all; %% clear all privious variables
clc;

faceDetector = vision.CascadeObjectDetector();
%Get the input device using image acquisition toolbox,resolution = 640x480 to improve performance
obj =imaq.VideoDevice('winvideo', 1, 'YUY2_640x480','ROI', [1 1 640 480]);
set(obj,'ReturnedColorSpace', 'rgb');
figure('menubar','none','tag','webcam');
while (true)
    frame=step(obj);
    bbox=step(faceDetector,frame);
   
    
    videoOut = insertObjectAnnotation(frame,'rectangle',bbox,'Face','Color',{'cyan'},'FontSize', 50);
    % blue, green, red, cyan, magenta, yellow, black, white
   
    imshow(videoOut,'border','tight');
    
    f=findobj('tag','webcam');
    
    if (isempty(f));
        [hueChannel,~,~] = rgb2hsv(frame);


hold off

% Release resources
release(obj);
        
        break
    end
    pause(0.05)
end
release(obj)
    