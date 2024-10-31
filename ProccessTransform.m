Im2Probe = [0.0678713	0.00207247	0.0132883	-21.1617
        -0.00141489	-0.0659773	-0.000216517	-108.801
        0.0136067	0.000630788	-0.0663058	15.4167
        0	0	0	1];




scales = [norm(Im2Probe(1:3,1)) norm(Im2Probe(1:3,2)) norm(Im2Probe(1:3,3))]

orthogonality = [dot(Im2Probe(1:3,1), Im2Probe(1:3,2)) dot(Im2Probe(1:3,1), Im2Probe(1:3,3)) dot(Im2Probe(1:3,3), Im2Probe(1:3,2))]

ref = det([Im2Probe(1:3,1)/scales(1) Im2Probe(1:3,2)/scales(2) Im2Probe(1:3,3)/scales(3)])

probe_T_image = Im2Probe;
%% Evaluate anticipated depth of the registration
lengthOfCaptureWindow =  727; %pixels
widthOfCaptureWindow = 558 ; %pixels 
anticipatedMMperpixel = 38.4/558
%14L3 transducer image field is 38.4mm wide
%project points at each corner of the image 
p00 = [0,0,0]; p0L = [0,lengthOfCaptureWindow,0];
pW0 = [widthOfCaptureWindow,0,0]; pWL = [widthOfCaptureWindow, lengthOfCaptureWindow, 0];

proj = probe_T_image*[p00';1];
proj_00 = proj(1:3);
proj = probe_T_image*[p0L';1];
proj_0L = proj(1:3);
proj = probe_T_image*[pW0';1];
proj_W0 = proj(1:3);
proj = probe_T_image*[pWL';1];
proj_WL = proj(1:3);


projectedWidth = norm(proj_W0- proj_00)
projectedLength = norm(proj_0L - proj_00)

%% Rotations 
rotations_slicer = rotm2eul(Im2ProbeSLICER(1:3,1:3))*180/pi
rotations = rotm2eul(Im2Probe(1:3,1:3))*180/pi