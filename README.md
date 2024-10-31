# nWirePhantom_UScalibration
Procedure and code for using an N-wire phantom and the fCal software to resolve the transformation between the ultrasound image and a marker coordinate system

# Instructions for Use

NWirePhantomTemplate contains the following information: 
- BkSettings: Necessary configuration files for the BK3500 US machine
- NdiToolDefinitions: A repository of commonly used marker files. For the intraoperative TORS study, the HoloTORSUS_V2.rom is used.
- fCal_X.X.stl: indicates the STL file used for visualization purposes in the fCal software. fCAL 2.1 is currently used, which is the 3D printed phantom
- PlusDeviceSet_fCal_14L3_NWirePhantomCalibration.xml: the xml configuration file used for fCal
- Probe and Stylus .STL files: Depending on the probe used, can select the appropriate model. The L14-5_38 is used for visualization purposes in this applicaiton


# Modifying the XML configuration file
This is the most important step in the calibration process. The key fields requiring modification are the ClipRectangleOrigin and the ClipRectangleSize, which indicate how the US frame is cropped. Your desired cropping will change depending on the US image settings (sector and depth), so be mindful about what the settings you want to calibrate to during the registration. 

# Performing the Registration 
1. Load the xml file into the fCal application and select "connect". If not connecting, make sure you computer's IPv4 settings are set to 10.0.0.4, the correct COM port for the NDI tracker is in the xml file, and you have the correct IP address of the US machine.
2. Check the capturing tab to make sure that the US image looks good. Specifically, check that the cropping produces the portion of image you want to do your analysis on.
3. The stylus calibration functionality does not work. Instead, use the stylus calibration function of the NDI tracker software if this has not been updated in a while. Once the stylus is calibrated, replace this transform in "StylusTip" To="Stylus" field in the xml file.
4. Perform the phantom calibration. This step is used to register the phantom tracker to the phantom coordinate system. If the phantom has not moved, this most likely has not changed. Regardless, you can perform this by ensuring the phantom marker is in view of the NDI tracker. Touch the different fiducials on the phantom following the directions in fCal to perform the registration.
5. Save the phantom calibration (if newly performed). For some reason the fCal software will crash if you redo the spatial calibration. Therefore, save the phantom calibration just in-case you need to redo the spatial calibration in the next step.
6. Submerge the phantom in a waterbath and position such that the phantom marker is in view of the NDI tracker.
7. Click on the "Start" in the Spatial Calibration tab. Move the transducer *very slowlyy* with the marker visible to the NDI tracker and the imaging plane coplanar to the face of the phantom that is longest. See notes on Troubleshooting if having trouble. You should probe a registration with submillimetre reprojection error. 
8. Save the file. Extract transform <Transform From="Image" To="Probe"> as the calibration transform.

# Troubleshooting
- If you are not finding any fiducial candidates during the spatial calibration then you most likely have changed the cropping parameters and the approximate ApproximateSpacingMmPerPixel field in the xml file is no longer accurate. Find the length of the transducer from its datasheet and divide this by the number of pixels (pixel width of your US image) and put this value into the ApproximateSpacingMmPerPixel field in the xml file.
- If you want to change the cropping, make sure to change the ClipRectangelOrigin and the ClipRectangleSize in both the <Segmentation> and the <DataSource> fields for the US.

# Additional Tools
The two files " NWirePhantomCalibration_5cm120sector " and " NWirePhantomCalibration_4cm120sector " are already cropped to the described depth and sector with the 14L3 probe. Note that these also have phantom calibrations and a spatial calibration present in these files, which is useful for seeing what they look like. 


PLUS CAD files: http://perk-software.cs.queensu.ca/plus/doc/nightly/modelcatalog/ 
