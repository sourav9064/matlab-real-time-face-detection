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
   
    boxInserter  = vision.ShapeInserter('BorderColor','Custom',...
    'CustomBorderColor',[0 0 255]);
    videoOut = step(boxInserter, frame,bbox);
   
    imshow(videoOut,'border','tight');
    
    f=findobj('tag','webcam');
    
    if (isempty(f))
        [hueChannel,~,~] = rgb2hsv(frame);
% Display the Hue Channel data and draw the bounding box around the face.
figure, imshow(hueChannel), title('Hue channel data');
rectangle('Position',bbox,'EdgeColor','r','LineWidth',1)
hold off

% Release resources
release(obj);
release(videoPlayer);
        close(gcf)   
        break
    end
    pause(0.05)
end
release(obj)
    