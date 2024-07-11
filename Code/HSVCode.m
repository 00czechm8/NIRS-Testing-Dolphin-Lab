cd("C:\Users\mwreynol\OneDrive - Umich\Research\NIRS-Testing-Dolphin-Lab\Data\Photos-001")
images = dir("*_side.jpg");
images = string({images.name});
for i = 1:length(images)
    im = imread(images(i));
    rgb2hsv(im);
    brightness(i) = mean(mean(im(:,:,3)));
end
plot(heights,brightness)
xlabel("Shim Height [mm]")
ylabel("Mean Brightness [-]")