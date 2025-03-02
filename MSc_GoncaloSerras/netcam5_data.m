function ret = netcam5_data(dataId, options)
% Function that returns the dataset informations
%
% Arguments:
%           dataId - Identifier of the dataset (same as the folder name of
%                    the dataset);
%           options - options - This struct contains information like:
%                     dataset dir, image_name, etc;
% Return:
%           Returns a struct with the dataset ID, name, path, pan/ tilt
%           information, zoom, etc.

if nargin < 2
    options = [];
end
if nargin < 1
    dataId = 1;
end
if isnumeric(dataId)
    dataId = num2str(dataId);
end
if dataId(1)=='*'
    ret= netcam5_data_old( dataId(2:end) );
    return
end

ret = get_info(dataId, options);

return; % end of main function


function ret = get_info(dataId, options)

% get path into "p"
cfname= dbstack(1); cfname= cfname.file;
p= which(cfname); p= strrep(p,cfname,''); p= strrep(p,'\','/');

mydata = get_mydata(p);
ind = [];
for n = 1:size(mydata,1)
    % find dataset name or dataset folder
    if strcmp(dataId, mydata{n,1}) || strcmp(dataId, mydata{n,2})
        ind = n;
        break
    end
end
if isempty(ind)
    error(['dataset not found: ' dataId])
end

pname  = [p mydata{ind,2} '/'];
bfname = [pname mydata{ind,3}];
iRange =  mydata{ind,4};

ret= struct('dataId',dataId, 'pname',pname, ...
    'bfname',bfname, 'iRange',iRange );

return


function ret= netcam5_data_old( dataId )
% c:\msc\ptsurv2      Diogo Leite    (inclu�do pelo Lu�s Alves)    
% c:\msc\multitarget3 Lu�s Alves     inclu�do no addpathx_info.m  multitarget3_data_v2.m
% c:\msc\ptsurv3      Rodrigo Serra  inclu�do no addpathx_info.m  ptsurv3_data.m
% c:\msc\netcam5      Gon�alo Serras [directoria pr�pria]         netcam5_data.m
dataId2= dataId(1:2);
dataId3= dataId(3:end);

switch dataId2
    case 'RS', ret= ptsurv3_data( dataId3 );
    case 'LA', ret= multitarget3_data_v2( dataId3 );
    case 'DL', ret= ptsurv2_data( dataId3 ); %vtarget_data( dataId3 );
    otherwise
        error('inv old dataset Id');
end


function mydata = get_mydata(p)

% 1 dataId, 2 folder,  3 fname, 4 indexes range
% mydata= {
%     '1', 'PTZ_and_laser_calib/calib_img1', 'img%d.jpg', 1:50; ...
%     'vrml_1', '190600_vrml_chessboard/board_size_02_fov13', 'camara2_anim_%d.png', 1:7; ...
%     'vrml_2', '190600_vrml_chessboard/board_size_03_fov16', 'camara2_anim_%d.png', 1:7; ...
%     '2_off',  '191119_pantilt_laser01_exp2', '#%d Image Laser off.png', 1:832; ...
%     '2_on',   '191119_pantilt_laser01_exp2', '#%d Image Laser on.png',  1:832; ...
%     'roof_pos1_edge1', '200223_roof_edges\pos1_roofedge1', '#%d Image Laser on *.png', 1:102; ...
%     'roof_pos1_edge2', '200223_roof_edges\pos1_roofedge2', '#%d Image Laser on *.png', 1:102; ...
%     'roof_pos2_edge1', '200223_roof_edges\pos2_roofedge1', '#%d Image Laser on *.png', 1:102; ...
%     'roof_pos2_edge2', '200223_roof_edges\pos2_roofedge2', '#%d Image Laser on *.png', 1:85; ...
%     'survcam_chessboard',   '200224_survcam_calib/survcam_chessboard', 'Chessboard_surv%02d.jpg', 1:50; ...
%     'survcam_laser_off',    '200224_survcam_calib/laser_survcam', '#%04d SurveillanceCam Laser off.jpg', 1:3276; ...
%     'survcam_laser_on',     '200224_survcam_calib/laser_survcam', '#%04d SurveillanceCam Laser on.jpg',  1:3276; ...
%     'survcam_pantilt_laser_off',    '200224_survcam_calib/laser_pan_tilt', '#%04d Image Laser off.jpg',  1:3276; ...
%     'survcam_pantilt_laser_on',     '200224_survcam_calib/laser_pan_tilt', '#%04d Image Laser on*.jpg',  1:3276; ...
% };

mydata= {
    '1', 'PTZ_and_laser_calib/calib_img1', 'img%d.jpg', 2:50; ...
    '2', 'PTZ_and_laser_calib/calib_img2', 'img%d.jpg', 1:50; ...
    '3', 'PTZ_and_laser_calib/calib_img3', 'img%d.jpg', 1:50; ...
    '4', 'PTZ_and_laser_calib/calib_img4', 'img%d.jpg', 1:50; ...
    '5', 'PTZ_and_laser_calib/calib_img5', 'img%d.jpg', 1:50; ...
    '6', 'PTZ_and_laser_calib/calib_img6', 'img%d.jpg', 1:50; ...
    '7', 'PTZ_and_laser_calib/calib_img7', 'img%d.jpg', 1:50; ...
    '8', 'PTZ_and_laser_calib/calib_img8', 'img%d.jpg', 1:50; ...
    '9', 'PTZ_and_laser_calib/calib_img9', 'img%d.jpg', 1:50; ...
    
    'vrml_1', '190600_vrml_chessboard/board_size_02_fov13', 'camara2_anim_%d.png', 1:7; ...
    'vrml_2', '190600_vrml_chessboard/board_size_03_fov16', 'camara2_anim_%d.png', 1:7; ...
    
    'vrml_room_16', 'Room_Chessboard_VRMLCode_Images/fov16', 'main_camera_file_anim_%d.png', 1:7; ...
    'vrml_room_13', 'Room_Chessboard_VRMLCode_Images/fov13', 'main_camera_file_anim_%d.png', 1:7; ...
    'vrml_room_09', 'Room_Chessboard_VRMLCode_Images/fov09', 'main_camera_file_anim_%d.png', 1:7; ...
    'vrml_room_075', 'Room_Chessboard_VRMLCode_Images/fov075', 'main_camera_file_anim_%d.png', 1:7; ...
    'vrml_room_075_diff_position', 'Room_Chessboard_VRMLCode_Images/fov075_diff_position', 'main_camera_file_anim_%d.png', 1:7; ...
    
    'Pose1_FIXED_1m',  'Pose1/FIXED_1m_Pose1', 'FIXED_Pose1_1m_0000_img%d.jpg', 2:15; ...
    'Pose1_FIXED_1.5m',  'Pose1/FIXED_1.5m_Pose1', 'FIXED_Pose1_1.5m_0000_img%d.jpg', 1:15; ...
    'Pose1_FIXED_2m',  'Pose1/FIXED_2m_Pose1', 'FIXED_Pose1_2m_0000_img%d.jpg', 1:15; ...
    'Pose1_FIXED_2.5m',  'Pose1/FIXED_2.5m_Pose1', 'FIXED_Pose1_2.5m_0000_img%d.jpg', 1:15; ...
    'Pose1_FIXED_3m',  'Pose1/FIXED_3m_Pose1', 'FIXED_Pose1_3m_0000_img%d.jpg', 1:15; ...
    'Pose1_FIXED_3.5m',  'Pose1/FIXED_3.5m_Pose1', 'FIXED_Pose1_3.5m_0000_img%d.jpg', 1:15; ...
    'Pose1_FIXED_4m',  'Pose1/FIXED_4m_Pose1', 'FIXED_Pose1_4m_0000_img%d.jpg', 1:15; ...
    'Pose1_FIXED_4.5m',  'Pose1/FIXED_4.5m_Pose1', 'FIXED_Pose1_4.5m_0000_img%d.jpg', 1:15; ...
    'Pose1_FIXED_5m',  'Pose1/FIXED_5m_Pose1', 'FIXED_Pose1_5m_0000_img%d.jpg', 1:15; ...
    
    'Pose1_PTZ_1m_0000',  'Pose1/PTZ_1m_Pose1/0000', 'PTZ_Pose1_1m_0000_img%d.jpg', 3:15; ...
    'Pose1_PTZ_1.5m_0000',  'Pose1/PTZ_1.5m_Pose1/0000', 'PTZ_Pose1_1.5m_0000_img%d.jpg', 1:15; ...
    'Pose1_PTZ_1.5m_0230',  'Pose1/PTZ_1.5m_Pose1/0230', 'PTZ_Pose1_1.5m_0230_img%d.jpg', 1:15; ...
    'Pose1_PTZ_2m_0000',  'Pose1/PTZ_2m_Pose1/0000', 'PTZ_Pose1_2m_0000_img%d.jpg', 1:15; ...
    'Pose1_PTZ_2m_0230',  'Pose1/PTZ_2m_Pose1/0230', 'PTZ_Pose1_2m_0230_img%d.jpg', 1:15; ...
    'Pose1_PTZ_2m_0370',  'Pose1/PTZ_2m_Pose1/0370', 'PTZ_Pose1_2m_0370_img%d.jpg', 1:15; ...
    'Pose1_PTZ_2.5m_0000',  'Pose1/PTZ_2.5m_Pose1/0000', 'PTZ_Pose1_2.5m_0000_img%d.jpg', 1:15; ...
    'Pose1_PTZ_2.5m_0230',  'Pose1/PTZ_2.5m_Pose1/0230', 'PTZ_Pose1_2.5m_0230_img%d.jpg', 1:15; ...
    'Pose1_PTZ_2.5m_0370',  'Pose1/PTZ_2.5m_Pose1/0370', 'PTZ_Pose1_2.5m_0370_img%d.jpg', 1:15; ...
    'Pose1_PTZ_2.5m_0460',  'Pose1/PTZ_2.5m_Pose1/0460', 'PTZ_Pose1_2.5m_0460_img%d.jpg', 1:15; ...
    'Pose1_PTZ_3m_0000',  'Pose1/PTZ_3m_Pose1/0000', 'PTZ_Pose1_3m_0000_img%d.jpg', 1:15; ...
    'Pose1_PTZ_3m_0230',  'Pose1/PTZ_3m_Pose1/0230', 'PTZ_Pose1_3m_0230_img%d.jpg', 1:15; ...
    'Pose1_PTZ_3m_0370',  'Pose1/PTZ_3m_Pose1/0370', 'PTZ_Pose1_3m_0370_img%d.jpg', 1:15; ...
    'Pose1_PTZ_3m_0460',  'Pose1/PTZ_3m_Pose1/0460', 'PTZ_Pose1_3m_0460_img%d.jpg', 1:15; ...
    'Pose1_PTZ_3m_0520',  'Pose1/PTZ_3m_Pose1/0520', 'PTZ_Pose1_3m_0520_img%d.jpg', 1:15; ...
    'Pose1_PTZ_3.5m_0000',  'Pose1/PTZ_3.5m_Pose1/0000', 'PTZ_Pose1_3.5m_0000_img%d.jpg', 1:15; ...
    'Pose1_PTZ_3.5m_0230',  'Pose1/PTZ_3.5m_Pose1/0230', 'PTZ_Pose1_3.5m_0230_img%d.jpg', 1:15; ...
    'Pose1_PTZ_3.5m_0370',  'Pose1/PTZ_3.5m_Pose1/0370', 'PTZ_Pose1_3.5m_0370_img%d.jpg', 1:15; ...
    'Pose1_PTZ_3.5m_0460',  'Pose1/PTZ_3.5m_Pose1/0460', 'PTZ_Pose1_3.5m_0460_img%d.jpg', 1:15; ...
    'Pose1_PTZ_3.5m_0520',  'Pose1/PTZ_3.5m_Pose1/0520', 'PTZ_Pose1_3.5m_0520_img%d.jpg', 1:15; ...
    'Pose1_PTZ_3.5m_0570',  'Pose1/PTZ_3.5m_Pose1/0570', 'PTZ_Pose1_3.5m_0570_img%d.jpg', 1:15; ...
    'Pose1_PTZ_4m_0000',  'Pose1/PTZ_4m_Pose1/0000', 'PTZ_Pose1_4m_0000_img%d.jpg', 1:15; ...
    'Pose1_PTZ_4m_0230',  'Pose1/PTZ_4m_Pose1/0230', 'PTZ_Pose1_4m_0230_img%d.jpg', 1:15; ...
    'Pose1_PTZ_4m_0370',  'Pose1/PTZ_4m_Pose1/0370', 'PTZ_Pose1_4m_0370_img%d.jpg', 1:15; ...
    'Pose1_PTZ_4m_0460',  'Pose1/PTZ_4m_Pose1/0460', 'PTZ_Pose1_4m_0460_img%d.jpg', 1:15; ...
    'Pose1_PTZ_4m_0520',  'Pose1/PTZ_4m_Pose1/0520', 'PTZ_Pose1_4m_0520_img%d.jpg', 1:15; ...
    'Pose1_PTZ_4m_0570',  'Pose1/PTZ_4m_Pose1/0570', 'PTZ_Pose1_4m_0570_img%d.jpg', 1:15; ...
    'Pose1_PTZ_4m_0613',  'Pose1/PTZ_4m_Pose1/0613', 'PTZ_Pose1_4m_0613_img%d.jpg', 1:15; ...
    'Pose1_PTZ_4.5m_0000',  'Pose1/PTZ_4.5m_Pose1/0000', 'PTZ_Pose1_4.5m_0000_img%d.jpg', 1:15; ...
    'Pose1_PTZ_4.5m_0230',  'Pose1/PTZ_4.5m_Pose1/0230', 'PTZ_Pose1_4.5m_0230_img%d.jpg', 1:15; ...
    'Pose1_PTZ_4.5m_0370',  'Pose1/PTZ_4.5m_Pose1/0370', 'PTZ_Pose1_4.5m_0370_img%d.jpg', 1:15; ...
    'Pose1_PTZ_4.5m_0460',  'Pose1/PTZ_4.5m_Pose1/0460', 'PTZ_Pose1_4.5m_0460_img%d.jpg', 1:15; ...
    'Pose1_PTZ_4.5m_0520',  'Pose1/PTZ_4.5m_Pose1/0520', 'PTZ_Pose1_4.5m_0520_img%d.jpg', 1:15; ...
    'Pose1_PTZ_4.5m_0570',  'Pose1/PTZ_4.5m_Pose1/0570', 'PTZ_Pose1_4.5m_0570_img%d.jpg', 1:15; ...
    'Pose1_PTZ_4.5m_0613',  'Pose1/PTZ_4.5m_Pose1/0613', 'PTZ_Pose1_4.5m_0613_img%d.jpg', 1:15; ...
    'Pose1_PTZ_4.5m_0642',  'Pose1/PTZ_4.5m_Pose1/0642', 'PTZ_Pose1_4.5m_0642_img%d.jpg', 1:15; ...
    'Pose1_PTZ_5m_0000',  'Pose1/PTZ_5m_Pose1/0000', 'PTZ_Pose1_5m_0000_img%d.jpg', 1:15; ...
    'Pose1_PTZ_5m_0230',  'Pose1/PTZ_5m_Pose1/0230', 'PTZ_Pose1_5m_0230_img%d.jpg', 1:15; ...
    'Pose1_PTZ_5m_0370',  'Pose1/PTZ_5m_Pose1/0370', 'PTZ_Pose1_5m_0370_img%d.jpg', 1:15; ...
    'Pose1_PTZ_5m_0460',  'Pose1/PTZ_5m_Pose1/0460', 'PTZ_Pose1_5m_0460_img%d.jpg', 1:15; ...
    'Pose1_PTZ_5m_0520',  'Pose1/PTZ_5m_Pose1/0520', 'PTZ_Pose1_5m_0520_img%d.jpg', 1:15; ...
    'Pose1_PTZ_5m_0570',  'Pose1/PTZ_5m_Pose1/0570', 'PTZ_Pose1_5m_0570_img%d.jpg', 1:15; ...
    'Pose1_PTZ_5m_0613',  'Pose1/PTZ_5m_Pose1/0613', 'PTZ_Pose1_5m_0613_img%d.jpg', 1:15; ...
    'Pose1_PTZ_5m_0642',  'Pose1/PTZ_5m_Pose1/0642', 'PTZ_Pose1_5m_0642_img%d.jpg', 1:15; ...
    'Pose1_PTZ_5m_0673',  'Pose1/PTZ_5m_Pose1/0673', 'PTZ_Pose1_5m_0673_img%d.jpg', 1:15; ...
    
    
    'Pose2_FIXED_1m',  'Pose2/FIXED_1m_Pose2', 'FIXED_Pose2_1m_30__0000_img%d.jpg', 1:15; ...
    'Pose2_FIXED_1.5m',  'Pose2/FIXED_1.5m_Pose2', 'FIXED_Pose2_1.5m_30__0000_img%d.jpg', 1:15; ...
    'Pose2_FIXED_2m',  'Pose2/FIXED_2m_Pose2', 'FIXED_Pose2_2m_30__0000_img%d.jpg', 1:15; ...
    'Pose2_FIXED_2.5m',  'Pose2/FIXED_2.5m_Pose2', 'FIXED_Pose2_2.5m_30__0000_img%d.jpg', 1:15; ...
    'Pose2_FIXED_3m',  'Pose2/FIXED_3m_Pose2', 'FIXED_Pose2_3m_30__0000_img%d.jpg', 1:23; ...
    'Pose2_FIXED_3.5m',  'Pose2/FIXED_3.5m_Pose2', 'FIXED_Pose2_3.5m_30__0000_img%d.jpg', 1:18; ...
    'Pose2_FIXED_4m',  'Pose2/FIXED_4m_Pose2', 'FIXED_Pose2_4m_30__0000_img%d.jpg', 1:18; ...
    'Pose2_FIXED_4.5m',  'Pose2/FIXED_4.5m_Pose2', 'FIXED_Pose2_4.5m_30__0000_img%d.jpg', 1:18; ...
    'Pose2_FIXED_5m',  'Pose2/FIXED_5m_Pose2', 'FIXED_Pose2_5m_30__0000_img%d.jpg', 1:19; ...
    
    'Pose2_PTZ_1m_0000',  'Pose2/PTZ_1m_Pose2/0000', 'PTZ_Pose2_1m_30__0000_img%d.jpg', 1:15; ...
    'Pose2_PTZ_1m_0230',  'Pose2/PTZ_1m_Pose2/0230', 'PTZ_Pose2_1m_30__0230_img%d.jpg', 1:15; ...
    'Pose2_PTZ_1.5m_0000',  'Pose2/PTZ_1.5m_Pose2/0000', 'PTZ_Pose2_1.5m_30__0000_img%d.jpg', 1:15; ...
    'Pose2_PTZ_1.5m_0230',  'Pose2/PTZ_1.5m_Pose2/0230', 'PTZ_Pose2_1.5m_30__0230_img%d.jpg', 1:15; ...
    'Pose2_PTZ_1.5m_0370',  'Pose2/PTZ_1.5m_Pose2/0370', 'PTZ_Pose2_1.5m_30__0370_img%d.jpg', 1:15; ...
    'Pose2_PTZ_2m_0000',  'Pose2/PTZ_2m_Pose2/0000', 'PTZ_Pose2_2m_30__0000_img%d.jpg', 1:15; ...
    'Pose2_PTZ_2m_0230',  'Pose2/PTZ_2m_Pose2/0230', 'PTZ_Pose2_2m_30__0230_img%d.jpg', 1:15; ...
    'Pose2_PTZ_2m_0370',  'Pose2/PTZ_2m_Pose2/0370', 'PTZ_Pose2_2m_30__0370_img%d.jpg', 1:15; ...
    'Pose2_PTZ_2m_0460',  'Pose2/PTZ_2m_Pose2/0460', 'PTZ_Pose2_2m_30__0460_img%d.jpg', 1:15; ...
    'Pose2_PTZ_2.5m_0000',  'Pose2/PTZ_2.5m_Pose2/0000', 'PTZ_Pose2_2.5m_30__0000_img%d.jpg', 1:15; ...
    'Pose2_PTZ_2.5m_0230',  'Pose2/PTZ_2.5m_Pose2/0230', 'PTZ_Pose2_2.5m_30__0230_img%d.jpg', 1:15; ...
    'Pose2_PTZ_2.5m_0370',  'Pose2/PTZ_2.5m_Pose2/0370', 'PTZ_Pose2_2.5m_30__0370_img%d.jpg', 1:15; ...
    'Pose2_PTZ_2.5m_0460',  'Pose2/PTZ_2.5m_Pose2/0460', 'PTZ_Pose2_2.5m_30__0460_img%d.jpg', 1:15; ...
    'Pose2_PTZ_2.5m_0520',  'Pose2/PTZ_2.5m_Pose2/0520', 'PTZ_Pose2_2.5m_30__0520_img%d.jpg', 1:15; ...
    'Pose2_PTZ_3m_0000',  'Pose2/PTZ_3m_Pose2/0000', 'PTZ_Pose2_3m_30__0000_img%d.jpg', 1:18; ...
    'Pose2_PTZ_3m_0230',  'Pose2/PTZ_3m_Pose2/0230', 'PTZ_Pose2_3m_30__0230_img%d.jpg', 1:18; ...
    'Pose2_PTZ_3m_0370',  'Pose2/PTZ_3m_Pose2/0370', 'PTZ_Pose2_3m_30__0370_img%d.jpg', 1:18; ...
    'Pose2_PTZ_3m_0460',  'Pose2/PTZ_3m_Pose2/0460', 'PTZ_Pose2_3m_30__0460_img%d.jpg', 1:18; ...
    'Pose2_PTZ_3m_0520',  'Pose2/PTZ_3m_Pose2/0520', 'PTZ_Pose2_3m_30__0520_img%d.jpg', 1:18; ...
    'Pose2_PTZ_3m_0570',  'Pose2/PTZ_3m_Pose2/0570', 'PTZ_Pose2_3m_30__0570_img%d.jpg', 1:18; ...
    'Pose2_PTZ_3.5m_0000',  'Pose2/PTZ_3.5m_Pose2/0000', 'PTZ_Pose2_3.5m_30__0000_img%d.jpg', 1:18; ...
    'Pose2_PTZ_3.5m_0230',  'Pose2/PTZ_3.5m_Pose2/0230', 'PTZ_Pose2_3.5m_30__0230_img%d.jpg', 1:18; ...
    'Pose2_PTZ_3.5m_0370',  'Pose2/PTZ_3.5m_Pose2/0370', 'PTZ_Pose2_3.5m_30__0370_img%d.jpg', 1:18; ...
    'Pose2_PTZ_3.5m_0460',  'Pose2/PTZ_3.5m_Pose2/0460', 'PTZ_Pose2_3.5m_30__0460_img%d.jpg', 1:18; ...
    'Pose2_PTZ_3.5m_0520',  'Pose2/PTZ_3.5m_Pose2/0520', 'PTZ_Pose2_3.5m_30__0520_img%d.jpg', 1:18; ...
    'Pose2_PTZ_3.5m_0570',  'Pose2/PTZ_3.5m_Pose2/0570', 'PTZ_Pose2_3.5m_30__0570_img%d.jpg', 1:18; ...
    'Pose2_PTZ_3.5m_0613',  'Pose2/PTZ_3.5m_Pose2/0613', 'PTZ_Pose2_3.5m_30__0613_img%d.jpg', 1:18; ...
    'Pose2_PTZ_4m_0000',  'Pose2/PTZ_4m_Pose2/0000', 'PTZ_Pose2_4m_30__0000_img%d.jpg', 1:18; ...
    'Pose2_PTZ_4m_0230',  'Pose2/PTZ_4m_Pose2/0230', 'PTZ_Pose2_4m_30__0230_img%d.jpg', 1:18; ...
    'Pose2_PTZ_4m_0370',  'Pose2/PTZ_4m_Pose2/0370', 'PTZ_Pose2_4m_30__0370_img%d.jpg', 1:18; ...
    'Pose2_PTZ_4m_0460',  'Pose2/PTZ_4m_Pose2/0460', 'PTZ_Pose2_4m_30__0460_img%d.jpg', 1:18; ...
    'Pose2_PTZ_4m_0520',  'Pose2/PTZ_4m_Pose2/0520', 'PTZ_Pose2_4m_30__0520_img%d.jpg', 1:18; ...
    'Pose2_PTZ_4m_0570',  'Pose2/PTZ_4m_Pose2/0570', 'PTZ_Pose2_4m_30__0570_img%d.jpg', 1:18; ...
    'Pose2_PTZ_4m_0613',  'Pose2/PTZ_4m_Pose2/0613', 'PTZ_Pose2_4m_30__0613_img%d.jpg', 1:18; ...
    'Pose2_PTZ_4m_0642',  'Pose2/PTZ_4m_Pose2/0642', 'PTZ_Pose2_4m_30__0642_img%d.jpg', 1:18; ...
    'Pose2_PTZ_4.5m_0000',  'Pose2/PTZ_4.5m_Pose2/0000', 'PTZ_Pose2_4.5m_30__0000_img%d.jpg', 1:18; ...
    'Pose2_PTZ_4.5m_0230',  'Pose2/PTZ_4.5m_Pose2/0230', 'PTZ_Pose2_4.5m_30__0230_img%d.jpg', 1:18; ...
    'Pose2_PTZ_4.5m_0370',  'Pose2/PTZ_4.5m_Pose2/0370', 'PTZ_Pose2_4.5m_30__0370_img%d.jpg', 1:18; ...
    'Pose2_PTZ_4.5m_0460',  'Pose2/PTZ_4.5m_Pose2/0460', 'PTZ_Pose2_4.5m_30__0460_img%d.jpg', 1:18; ...
    'Pose2_PTZ_4.5m_0520',  'Pose2/PTZ_4.5m_Pose2/0520', 'PTZ_Pose2_4.5m_30__0520_img%d.jpg', 1:18; ...
    'Pose2_PTZ_4.5m_0570',  'Pose2/PTZ_4.5m_Pose2/0570', 'PTZ_Pose2_4.5m_30__0570_img%d.jpg', 1:18; ...
    'Pose2_PTZ_4.5m_0613',  'Pose2/PTZ_4.5m_Pose2/0613', 'PTZ_Pose2_4.5m_30__0613_img%d.jpg', 1:18; ...
    'Pose2_PTZ_4.5m_0642',  'Pose2/PTZ_4.5m_Pose2/0642', 'PTZ_Pose2_4.5m_30__0642_img%d.jpg', 1:18; ...
    'Pose2_PTZ_4.5m_0673',  'Pose2/PTZ_4.5m_Pose2/0673', 'PTZ_Pose2_4.5m_30__0673_img%d.jpg', 1:15; ...
    'Pose2_PTZ_5m_0000',  'Pose2/PTZ_5m_Pose2/0000', 'PTZ_Pose2_5m_30__0000_img%d.jpg', 1:19; ...
    'Pose2_PTZ_5m_0230',  'Pose2/PTZ_5m_Pose2/0230', 'PTZ_Pose2_5m_30__0230_img%d.jpg', 1:20; ...
    'Pose2_PTZ_5m_0370',  'Pose2/PTZ_5m_Pose2/0370', 'PTZ_Pose2_5m_30__0370_img%d.jpg', 1:20; ...
    'Pose2_PTZ_5m_0460',  'Pose2/PTZ_5m_Pose2/0460', 'PTZ_Pose2_5m_30__0460_img%d.jpg', 1:20; ...
    'Pose2_PTZ_5m_0520',  'Pose2/PTZ_5m_Pose2/0520', 'PTZ_Pose2_5m_30__0520_img%d.jpg', 1:20; ...
    'Pose2_PTZ_5m_0570',  'Pose2/PTZ_5m_Pose2/0570', 'PTZ_Pose2_5m_30__0570_img%d.jpg', 1:20; ...
    'Pose2_PTZ_5m_0613',  'Pose2/PTZ_5m_Pose2/0613', 'PTZ_Pose2_5m_30__0613_img%d.jpg', 1:20; ...
    'Pose2_PTZ_5m_0642',  'Pose2/PTZ_5m_Pose2/0642', 'PTZ_Pose2_5m_30__0642_img%d.jpg', 1:20; ...
    'Pose2_PTZ_5m_0673',  'Pose2/PTZ_5m_Pose2/0673', 'PTZ_Pose2_5m_30__0673_img%d.jpg', 1:18; ...
    
    
    'Pose3_FIXED_1m',  'Pose3/FIXED_1m_Pose3', 'FIXED_Pose3_1m_30__0000_img%d.jpg', 1:18; ...
    'Pose3_FIXED_1.5m',  'Pose3/FIXED_1.5m_Pose3', 'FIXED_Pose3_1.5m_30__0000_img%d.jpg', 1:18; ...
    'Pose3_FIXED_2m',  'Pose3/FIXED_2m_Pose3', 'FIXED_Pose3_2m_30__0000_img%d.jpg', 1:18; ...
    'Pose3_FIXED_2.5m',  'Pose3/FIXED_2.5m_Pose3', 'FIXED_Pose3_2.5m_30__0000_img%d.jpg', 1:18; ...
    'Pose3_FIXED_3m',  'Pose3/FIXED_3m_Pose3', 'FIXED_Pose3_3m_30__0000_img%d.jpg', 1:18; ...
    'Pose3_FIXED_3.5m',  'Pose3/FIXED_3.5m_Pose3', 'FIXED_Pose3_3.5m_30__0000_img%d.jpg', 1:18; ...
    'Pose3_FIXED_4m',  'Pose3/FIXED_4m_Pose3', 'FIXED_Pose3_4m_30__0000_img%d.jpg', 1:18; ...
    'Pose3_FIXED_4.5m',  'Pose3/FIXED_4.5m_Pose3', 'FIXED_Pose3_4.5m_30__0000_img%d.jpg', 1:15; ...
    'Pose3_FIXED_5m',  'Pose3/FIXED_5m_Pose3', 'FIXED_Pose3_5m_30__0000_img%d.jpg', 1:18; ...
    
    'Pose3_PTZ_1m_0000',  'Pose3/PTZ_1m_Pose3/0000', 'PTZ_Pose3_1m_30__0000_img%d.jpg', 1:18; ...
    'Pose3_PTZ_1.5m_0000',  'Pose3/PTZ_1.5m_Pose3/0000', 'PTZ_Pose3_1.5m_30__0000_img%d.jpg', 1:18; ...
    'Pose3_PTZ_1.5m_0230',  'Pose3/PTZ_1.5m_Pose3/0230', 'PTZ_Pose3_1.5m_30__0230_img%d.jpg', 1:15; ...
    'Pose3_PTZ_2m_0000',  'Pose3/PTZ_2m_Pose3/0000', 'PTZ_Pose3_2m_30__0000_img%d.jpg', 1:18; ...
    'Pose3_PTZ_2m_0230',  'Pose3/PTZ_2m_Pose3/0230', 'PTZ_Pose3_2m_30__0230_img%d.jpg', 1:18; ...
    'Pose3_PTZ_2m_0370',  'Pose3/PTZ_2m_Pose3/0370', 'PTZ_Pose3_2m_30__0370_img%d.jpg', 1:18; ...
    'Pose3_PTZ_2.5m_0000',  'Pose3/PTZ_2.5m_Pose3/0000', 'PTZ_Pose3_2.5m_30__0000_img%d.jpg', 1:18; ...
    'Pose3_PTZ_2.5m_0230',  'Pose3/PTZ_2.5m_Pose3/0230', 'PTZ_Pose3_2.5m_30__0230_img%d.jpg', 1:18; ...
    'Pose3_PTZ_2.5m_0370',  'Pose3/PTZ_2.5m_Pose3/0370', 'PTZ_Pose3_2.5m_30__0370_img%d.jpg', 1:18; ...
    'Pose3_PTZ_2.5m_0460',  'Pose3/PTZ_2.5m_Pose3/0460', 'PTZ_Pose3_2.5m_30__0460_img%d.jpg', 1:18; ...
    'Pose3_PTZ_3m_0000',  'Pose3/PTZ_3m_Pose3/0000', 'PTZ_Pose3_3m_30__0000_img%d.jpg', 1:18; ...
    'Pose3_PTZ_3m_0230',  'Pose3/PTZ_3m_Pose3/0230', 'PTZ_Pose3_3m_30__0230_img%d.jpg', 1:18; ...
    'Pose3_PTZ_3m_0370',  'Pose3/PTZ_3m_Pose3/0370', 'PTZ_Pose3_3m_30__0370_img%d.jpg', 1:18; ...
    'Pose3_PTZ_3m_0460',  'Pose3/PTZ_3m_Pose3/0460', 'PTZ_Pose3_3m_30__0460_img%d.jpg', 1:18; ...
    'Pose3_PTZ_3m_0520',  'Pose3/PTZ_3m_Pose3/0520', 'PTZ_Pose3_3m_30__0520_img%d.jpg', 1:18; ...
    'Pose3_PTZ_3.5m_0000',  'Pose3/PTZ_3.5m_Pose3/0000', 'PTZ_Pose3_3.5m_30__0000_img%d.jpg', 1:18; ...
    'Pose3_PTZ_3.5m_0230',  'Pose3/PTZ_3.5m_Pose3/0230', 'PTZ_Pose3_3.5m_30__0230_img%d.jpg', 1:18; ...
    'Pose3_PTZ_3.5m_0370',  'Pose3/PTZ_3.5m_Pose3/0370', 'PTZ_Pose3_3.5m_30__0370_img%d.jpg', 1:18; ...
    'Pose3_PTZ_3.5m_0460',  'Pose3/PTZ_3.5m_Pose3/0460', 'PTZ_Pose3_3.5m_30__0460_img%d.jpg', 1:18; ...
    'Pose3_PTZ_3.5m_0520',  'Pose3/PTZ_3.5m_Pose3/0520', 'PTZ_Pose3_3.5m_30__0520_img%d.jpg', 1:18; ...
    'Pose3_PTZ_3.5m_0570',  'Pose3/PTZ_3.5m_Pose3/0570', 'PTZ_Pose3_3.5m_30__0570_img%d.jpg', 1:18; ...
    'Pose3_PTZ_4m_0000',  'Pose3/PTZ_4m_Pose3/0000', 'PTZ_Pose3_4m_30__0000_img%d.jpg', 1:18; ...
    'Pose3_PTZ_4m_0230',  'Pose3/PTZ_4m_Pose3/0230', 'PTZ_Pose3_4m_30__0230_img%d.jpg', 1:18; ...
    'Pose3_PTZ_4m_0370',  'Pose3/PTZ_4m_Pose3/0370', 'PTZ_Pose3_4m_30__0370_img%d.jpg', 1:18; ...
    'Pose3_PTZ_4m_0460',  'Pose3/PTZ_4m_Pose3/0460', 'PTZ_Pose3_4m_30__0460_img%d.jpg', 1:18; ...
    'Pose3_PTZ_4m_0520',  'Pose3/PTZ_4m_Pose3/0520', 'PTZ_Pose3_4m_30__0520_img%d.jpg', 1:18; ...
    'Pose3_PTZ_4m_0570',  'Pose3/PTZ_4m_Pose3/0570', 'PTZ_Pose3_4m_30__0570_img%d.jpg', 1:18; ...
    'Pose3_PTZ_4m_0613',  'Pose3/PTZ_4m_Pose3/0613', 'PTZ_Pose3_4m_30__0613_img%d.jpg', 1:15; ...
    'Pose3_PTZ_4.5m_0000',  'Pose3/PTZ_4.5m_Pose3/0000', 'PTZ_Pose3_4.5m_30__0000_img%d.jpg', 1:15; ...
    'Pose3_PTZ_4.5m_0230',  'Pose3/PTZ_4.5m_Pose3/0230', 'PTZ_Pose3_4.5m_30__0230_img%d.jpg', 1:18; ...
    'Pose3_PTZ_4.5m_0370',  'Pose3/PTZ_4.5m_Pose3/0370', 'PTZ_Pose3_4.5m_30__0370_img%d.jpg', 1:18; ...
    'Pose3_PTZ_4.5m_0460',  'Pose3/PTZ_4.5m_Pose3/0460', 'PTZ_Pose3_4.5m_30__0460_img%d.jpg', 1:18; ...
    'Pose3_PTZ_4.5m_0520',  'Pose3/PTZ_4.5m_Pose3/0520', 'PTZ_Pose3_4.5m_30__0520_img%d.jpg', 1:18; ...
    'Pose3_PTZ_4.5m_0570',  'Pose3/PTZ_4.5m_Pose3/0570', 'PTZ_Pose3_4.5m_30__0570_img%d.jpg', 1:18; ...
    'Pose3_PTZ_4.5m_0613',  'Pose3/PTZ_4.5m_Pose3/0613', 'PTZ_Pose3_4.5m_30__0613_img%d.jpg', 1:18; ...
    'Pose3_PTZ_4.5m_0642',  'Pose3/PTZ_4.5m_Pose3/0642', 'PTZ_Pose3_4.5m_30__0642_img%d.jpg', 1:18; ...
    'Pose3_PTZ_5m_0000',  'Pose3/PTZ_5m_Pose3/0000', 'PTZ_Pose3_5m_30__0000_img%d.jpg', 1:18; ...
    'Pose3_PTZ_5m_0230',  'Pose3/PTZ_5m_Pose3/0230', 'PTZ_Pose3_5m_30__0230_img%d.jpg', 1:22; ...
    'Pose3_PTZ_5m_0370',  'Pose3/PTZ_5m_Pose3/0370', 'PTZ_Pose3_5m_30__0370_img%d.jpg', 1:22; ...
    'Pose3_PTZ_5m_0460',  'Pose3/PTZ_5m_Pose3/0460', 'PTZ_Pose3_5m_30__0460_img%d.jpg', 1:20; ...
    'Pose3_PTZ_5m_0520',  'Pose3/PTZ_5m_Pose3/0520', 'PTZ_Pose3_5m_30__0520_img%d.jpg', 1:20; ...
    'Pose3_PTZ_5m_0570',  'Pose3/PTZ_5m_Pose3/0570', 'PTZ_Pose3_5m_30__0570_img%d.jpg', 1:20; ...
    'Pose3_PTZ_5m_0613',  'Pose3/PTZ_5m_Pose3/0613', 'PTZ_Pose3_5m_30__0613_img%d.jpg', 1:20; ...
    'Pose3_PTZ_5m_0642',  'Pose3/PTZ_5m_Pose3/0642', 'PTZ_Pose3_5m_30__0642_img%d.jpg', 1:20; ...
    'Pose3_PTZ_5m_0673',  'Pose3/PTZ_5m_Pose3/0673', 'PTZ_Pose3_5m_30__0673_img%d.jpg', 1:20; ...
    
    
    'Pose4_FIXED_1m',  'Pose4/FIXED_1m_Pose4', 'FIXED_Pose4_1m_30__0000_img%d.jpg', 1:18; ...
    'Pose4_FIXED_1.5m',  'Pose4/FIXED_1.5m_Pose4', 'FIXED_Pose4_1.5m_30__0000_img%d.jpg', 1:18; ...
    'Pose4_FIXED_2m',  'Pose4/FIXED_2m_Pose4', 'FIXED_Pose4_2m_30__0000_img%d.jpg', 1:20; ...
    'Pose4_FIXED_2.5m',  'Pose4/FIXED_2.5m_Pose4', 'FIXED_Pose4_2.5m_30__0000_img%d.jpg', 1:18; ...
    'Pose4_FIXED_3m',  'Pose4/FIXED_3m_Pose4', 'FIXED_Pose4_3m_30__0000_img%d.jpg', 1:19; ...
    'Pose4_FIXED_3.5m',  'Pose4/FIXED_3.5m_Pose4', 'FIXED_Pose4_3.5m_30__0000_img%d.jpg', 1:19; ...
    'Pose4_FIXED_4m',  'Pose4/FIXED_4m_Pose4', 'FIXED_Pose4_4m_30__0000_img%d.jpg', 1:19; ...
    'Pose4_FIXED_4.5m',  'Pose4/FIXED_4.5m_Pose4', 'FIXED_Pose4_4.5m_30__0000_img%d.jpg', 1:19; ...
    'Pose4_FIXED_5m',  'Pose4/FIXED_5m_Pose4', 'FIXED_Pose4_5m_30__0000_img%d.jpg', 1:20; ...
    
    'Pose4_PTZ_1m_0000',  'Pose4/PTZ_1m_Pose4/0000', 'PTZ_Pose4_1m_30__0000_img%d.jpg', 1:18; ...
    'Pose4_PTZ_1.5m_0000',  'Pose4/PTZ_1.5m_Pose4/0000', 'PTZ_Pose4_1.5m_30__0000_img%d.jpg', 1:18; ...
    'Pose4_PTZ_1.5m_0230',  'Pose4/PTZ_1.5m_Pose4/0230', 'PTZ_Pose4_1.5m_30__0230_img%d.jpg', 1:20; ...
    'Pose4_PTZ_2m_0000',  'Pose4/PTZ_2m_Pose4/0000', 'PTZ_Pose4_2m_30__0000_img%d.jpg', 1:20; ...
    'Pose4_PTZ_2m_0230',  'Pose4/PTZ_2m_Pose4/0230', 'PTZ_Pose4_2m_30__0230_img%d.jpg', 1:18; ...
    'Pose4_PTZ_2m_0370',  'Pose4/PTZ_2m_Pose4/0370', 'PTZ_Pose4_2m_30__0370_img%d.jpg', 1:18; ...
    'Pose4_PTZ_2.5m_0000',  'Pose4/PTZ_2.5m_Pose4/0000', 'PTZ_Pose4_2.5m_30__0000_img%d.jpg', 1:18; ...
    'Pose4_PTZ_2.5m_0230',  'Pose4/PTZ_2.5m_Pose4/0230', 'PTZ_Pose4_2.5m_30__0230_img%d.jpg', 1:22; ...
    'Pose4_PTZ_2.5m_0370',  'Pose4/PTZ_2.5m_Pose4/0370', 'PTZ_Pose4_2.5m_30__0370_img%d.jpg', 1:23; ...
    'Pose4_PTZ_2.5m_0460',  'Pose4/PTZ_2.5m_Pose4/0460', 'PTZ_Pose4_2.5m_30__0460_img%d.jpg', 1:20; ...
    'Pose4_PTZ_3m_0000',  'Pose4/PTZ_3m_Pose4/0000', 'PTZ_Pose4_3m_30__0000_img%d.jpg', 1:19; ...
    'Pose4_PTZ_3m_0230',  'Pose4/PTZ_3m_Pose4/0230', 'PTZ_Pose4_3m_30__0230_img%d.jpg', 1:18; ...
    'Pose4_PTZ_3m_0370',  'Pose4/PTZ_3m_Pose4/0370', 'PTZ_Pose4_3m_30__0370_img%d.jpg', 1:20; ...
    'Pose4_PTZ_3m_0460',  'Pose4/PTZ_3m_Pose4/0460', 'PTZ_Pose4_3m_30__0460_img%d.jpg', 1:19; ...
    'Pose4_PTZ_3m_0520',  'Pose4/PTZ_3m_Pose4/0520', 'PTZ_Pose4_3m_30__0520_img%d.jpg', 1:19; ...
    'Pose4_PTZ_3.5m_0000',  'Pose4/PTZ_3.5m_Pose4/0000', 'PTZ_Pose4_3.5m_30__0000_img%d.jpg', 1:19; ...
    'Pose4_PTZ_3.5m_0230',  'Pose4/PTZ_3.5m_Pose4/0230', 'PTZ_Pose4_3.5m_30__0230_img%d.jpg', 1:20; ...
    'Pose4_PTZ_3.5m_0370',  'Pose4/PTZ_3.5m_Pose4/0370', 'PTZ_Pose4_3.5m_30__0370_img%d.jpg', 1:19; ...
    'Pose4_PTZ_3.5m_0460',  'Pose4/PTZ_3.5m_Pose4/0460', 'PTZ_Pose4_3.5m_30__0460_img%d.jpg', 1:19; ...
    'Pose4_PTZ_3.5m_0520',  'Pose4/PTZ_3.5m_Pose4/0520', 'PTZ_Pose4_3.5m_30__0520_img%d.jpg', 1:19; ...
    'Pose4_PTZ_3.5m_0570',  'Pose4/PTZ_3.5m_Pose4/0570', 'PTZ_Pose4_3.5m_30__0570_img%d.jpg', 1:19; ...
    'Pose4_PTZ_4m_0000',  'Pose4/PTZ_4m_Pose4/0000', 'PTZ_Pose4_4m_30__0000_img%d.jpg', 1:19; ...
    'Pose4_PTZ_4m_0230',  'Pose4/PTZ_4m_Pose4/0230', 'PTZ_Pose4_4m_30__0230_img%d.jpg', 1:19; ...
    'Pose4_PTZ_4m_0370',  'Pose4/PTZ_4m_Pose4/0370', 'PTZ_Pose4_4m_30__0370_img%d.jpg', 1:19; ...
    'Pose4_PTZ_4m_0460',  'Pose4/PTZ_4m_Pose4/0460', 'PTZ_Pose4_4m_30__0460_img%d.jpg', 1:19; ...
    'Pose4_PTZ_4m_0520',  'Pose4/PTZ_4m_Pose4/0520', 'PTZ_Pose4_4m_30__0520_img%d.jpg', 1:19; ...
    'Pose4_PTZ_4m_0570',  'Pose4/PTZ_4m_Pose4/0570', 'PTZ_Pose4_4m_30__0570_img%d.jpg', 1:19; ...
    'Pose4_PTZ_4m_0613',  'Pose4/PTZ_4m_Pose4/0613', 'PTZ_Pose4_4m_30__0613_img%d.jpg', 1:19; ...
    'Pose4_PTZ_4.5m_0000',  'Pose4/PTZ_4.5m_Pose4/0000', 'PTZ_Pose4_4.5m_30__0000_img%d.jpg', 1:19; ...
    'Pose4_PTZ_4.5m_0230',  'Pose4/PTZ_4.5m_Pose4/0230', 'PTZ_Pose4_4.5m_30__0230_img%d.jpg', 1:22; ...
    'Pose4_PTZ_4.5m_0370',  'Pose4/PTZ_4.5m_Pose4/0370', 'PTZ_Pose4_4.5m_30__0370_img%d.jpg', 1:20; ...
    'Pose4_PTZ_4.5m_0460',  'Pose4/PTZ_4.5m_Pose4/0460', 'PTZ_Pose4_4.5m_30__0460_img%d.jpg', 1:19; ...
    'Pose4_PTZ_4.5m_0520',  'Pose4/PTZ_4.5m_Pose4/0520', 'PTZ_Pose4_4.5m_30__0520_img%d.jpg', 1:20; ...
    'Pose4_PTZ_4.5m_0570',  'Pose4/PTZ_4.5m_Pose4/0570', 'PTZ_Pose4_4.5m_30__0570_img%d.jpg', 1:20; ...
    'Pose4_PTZ_4.5m_0613',  'Pose4/PTZ_4.5m_Pose4/0613', 'PTZ_Pose4_4.5m_30__0613_img%d.jpg', 1:20; ...
    'Pose4_PTZ_4.5m_0642',  'Pose4/PTZ_4.5m_Pose4/0642', 'PTZ_Pose4_4.5m_30__0642_img%d.jpg', 1:20; ...
    'Pose4_PTZ_5m_0000',  'Pose4/PTZ_5m_Pose4/0000', 'PTZ_Pose4_5m_30__0000_img%d.jpg', 1:20; ...
    'Pose4_PTZ_5m_0230',  'Pose4/PTZ_5m_Pose4/0230', 'PTZ_Pose4_5m_30__0230_img%d.jpg', 1:19; ...
    'Pose4_PTZ_5m_0370',  'Pose4/PTZ_5m_Pose4/0370', 'PTZ_Pose4_5m_30__0370_img%d.jpg', 1:20; ...
    'Pose4_PTZ_5m_0460',  'Pose4/PTZ_5m_Pose4/0460', 'PTZ_Pose4_5m_30__0460_img%d.jpg', 1:20; ...
    'Pose4_PTZ_5m_0520',  'Pose4/PTZ_5m_Pose4/0520', 'PTZ_Pose4_5m_30__0520_img%d.jpg', 1:20; ...
    'Pose4_PTZ_5m_0570',  'Pose4/PTZ_5m_Pose4/0570', 'PTZ_Pose4_5m_30__0570_img%d.jpg', 1:20; ...
    'Pose4_PTZ_5m_0613',  'Pose4/PTZ_5m_Pose4/0613', 'PTZ_Pose4_5m_30__0613_img%d.jpg', 1:20; ...
    'Pose4_PTZ_5m_0642',  'Pose4/PTZ_5m_Pose4/0642', 'PTZ_Pose4_5m_30__0642_img%d.jpg', 1:20; ...
    'Pose4_PTZ_5m_0673',  'Pose4/PTZ_5m_Pose4/0673', 'PTZ_Pose4_5m_30__0673_img%d.jpg', 1:20; ...
    
    
    'Pose5_FIXED_1m',  'Pose5/FIXED_1m_Pose5', 'FIXED_Pose5_1m_30__0000_img%d.jpg', 1:20; ...
    'Pose5_FIXED_1.5m',  'Pose5/FIXED_1.5m_Pose5', 'FIXED_Pose5_1.5m_30__0000_img%d.jpg', 1:20; ...
    'Pose5_FIXED_2m',  'Pose5/FIXED_2m_Pose5', 'FIXED_Pose5_2m_30__0000_img%d.jpg', 1:20; ...
    'Pose5_FIXED_2.5m',  'Pose5/FIXED_2.5m_Pose5', 'FIXED_Pose5_2.5m_30__0000_img%d.jpg', 1:20; ...
    'Pose5_FIXED_3m',  'Pose5/FIXED_3m_Pose5', 'FIXED_Pose5_3m_30__0000_img%d.jpg', 1:20; ...
    'Pose5_FIXED_3.5m',  'Pose5/FIXED_3.5m_Pose5', 'FIXED_Pose5_3.5m_30__0000_img%d.jpg', 1:20; ...
    'Pose5_FIXED_4m',  'Pose5/FIXED_4m_Pose5', 'FIXED_Pose5_4m_30__0000_img%d.jpg', 1:20; ...
    'Pose5_FIXED_4.5m',  'Pose5/FIXED_4.5m_Pose5', 'FIXED_Pose5_4.5m_30__0000_img%d.jpg', 1:15; ...
    'Pose5_FIXED_5m',  'Pose5/FIXED_5m_Pose5', 'FIXED_Pose5_5m_30__0000_img%d.jpg', 1:22; ...
    
    'Pose5_PTZ_1m_0000',  'Pose5/PTZ_1m_Pose5/0000', 'PTZ_Pose5_1m_30__0000_img%d.jpg', 1:20; ...
    'Pose5_PTZ_1.5m_0000',  'Pose5/PTZ_1.5m_Pose5/0000', 'PTZ_Pose5_1.5m_30__0000_img%d.jpg', 1:20; ...
    'Pose5_PTZ_1.5m_0230',  'Pose5/PTZ_1.5m_Pose5/0230', 'PTZ_Pose5_1.5m_30__0230_img%d.jpg', 1:20; ...
    'Pose5_PTZ_2m_0000',  'Pose5/PTZ_2m_Pose5/0000', 'PTZ_Pose5_2m_30__0000_img%d.jpg', 1:20; ...
    'Pose5_PTZ_2m_0230',  'Pose5/PTZ_2m_Pose5/0230', 'PTZ_Pose5_2m_30__0230_img%d.jpg', 1:20; ...
    'Pose5_PTZ_2m_0370',  'Pose5/PTZ_2m_Pose5/0370', 'PTZ_Pose5_2m_30__0370_img%d.jpg', 1:20; ...
    'Pose5_PTZ_2.5m_0000',  'Pose5/PTZ_2.5m_Pose5/0000', 'PTZ_Pose5_2.5m_30__0000_img%d.jpg', 1:20; ...
    'Pose5_PTZ_2.5m_0230',  'Pose5/PTZ_2.5m_Pose5/0230', 'PTZ_Pose5_2.5m_30__0230_img%d.jpg', 1:20; ...
    'Pose5_PTZ_2.5m_0370',  'Pose5/PTZ_2.5m_Pose5/0370', 'PTZ_Pose5_2.5m_30__0370_img%d.jpg', 1:20; ...
    'Pose5_PTZ_2.5m_0460',  'Pose5/PTZ_2.5m_Pose5/0460', 'PTZ_Pose5_2.5m_30__0460_img%d.jpg', 1:20; ...
    'Pose5_PTZ_3m_0000',  'Pose5/PTZ_3m_Pose5/0000', 'PTZ_Pose5_3m_30__0000_img%d.jpg', 1:20; ...
    'Pose5_PTZ_3m_0230',  'Pose5/PTZ_3m_Pose5/0230', 'PTZ_Pose5_3m_30__0230_img%d.jpg', 1:23; ...
    'Pose5_PTZ_3m_0370',  'Pose5/PTZ_3m_Pose5/0370', 'PTZ_Pose5_3m_30__0370_img%d.jpg', 1:20; ...
    'Pose5_PTZ_3m_0460',  'Pose5/PTZ_3m_Pose5/0460', 'PTZ_Pose5_3m_30__0460_img%d.jpg', 1:23; ...
    'Pose5_PTZ_3m_0520',  'Pose5/PTZ_3m_Pose5/0520', 'PTZ_Pose5_3m_30__0520_img%d.jpg', 1:20; ...
    'Pose5_PTZ_3.5m_0000',  'Pose5/PTZ_3.5m_Pose5/0000', 'PTZ_Pose5_3.5m_30__0000_img%d.jpg', 1:20; ...
    'Pose5_PTZ_3.5m_0230',  'Pose5/PTZ_3.5m_Pose5/0230', 'PTZ_Pose5_3.5m_30__0230_img%d.jpg', 1:20; ...
    'Pose5_PTZ_3.5m_0370',  'Pose5/PTZ_3.5m_Pose5/0370', 'PTZ_Pose5_3.5m_30__0370_img%d.jpg', 1:23; ...
    'Pose5_PTZ_3.5m_0460',  'Pose5/PTZ_3.5m_Pose5/0460', 'PTZ_Pose5_3.5m_30__0460_img%d.jpg', 1:22; ...
    'Pose5_PTZ_3.5m_0520',  'Pose5/PTZ_3.5m_Pose5/0520', 'PTZ_Pose5_3.5m_30__0520_img%d.jpg', 1:22; ...
    'Pose5_PTZ_3.5m_0570',  'Pose5/PTZ_3.5m_Pose5/0570', 'PTZ_Pose5_3.5m_30__0570_img%d.jpg', 1:22; ...
    'Pose5_PTZ_4m_0000',  'Pose5/PTZ_4m_Pose5/0000', 'PTZ_Pose5_4m_30__0000_img%d.jpg', 1:20; ...
    'Pose5_PTZ_4m_0230',  'Pose5/PTZ_4m_Pose5/0230', 'PTZ_Pose5_4m_30__0230_img%d.jpg', 1:20; ...
    'Pose5_PTZ_4m_0370',  'Pose5/PTZ_4m_Pose5/0370', 'PTZ_Pose5_4m_30__0370_img%d.jpg', 1:20; ...
    'Pose5_PTZ_4m_0460',  'Pose5/PTZ_4m_Pose5/0460', 'PTZ_Pose5_4m_30__0460_img%d.jpg', 1:20; ...
    'Pose5_PTZ_4m_0520',  'Pose5/PTZ_4m_Pose5/0520', 'PTZ_Pose5_4m_30__0520_img%d.jpg', 1:20; ...
    'Pose5_PTZ_4m_0570',  'Pose5/PTZ_4m_Pose5/0570', 'PTZ_Pose5_4m_30__0570_img%d.jpg', 1:20; ...
    'Pose5_PTZ_4m_0613',  'Pose5/PTZ_4m_Pose5/0613', 'PTZ_Pose5_4m_30__0613_img%d.jpg', 1:15; ...
    'Pose5_PTZ_4.5m_0000',  'Pose5/PTZ_4.5m_Pose5/0000', 'PTZ_Pose5_4.5m_30__0000_img%d.jpg', 1:15; ...
    'Pose5_PTZ_4.5m_0230',  'Pose5/PTZ_4.5m_Pose5/0230', 'PTZ_Pose5_4.5m_30__0230_img%d.jpg', 1:22; ...
    'Pose5_PTZ_4.5m_0370',  'Pose5/PTZ_4.5m_Pose5/0370', 'PTZ_Pose5_4.5m_30__0370_img%d.jpg', 1:22; ...
    'Pose5_PTZ_4.5m_0460',  'Pose5/PTZ_4.5m_Pose5/0460', 'PTZ_Pose5_4.5m_30__0460_img%d.jpg', 1:12; ...
    'Pose5_PTZ_4.5m_0520',  'Pose5/PTZ_4.5m_Pose5/0520', 'PTZ_Pose5_4.5m_30__0520_img%d.jpg', 1:22; ...
    'Pose5_PTZ_4.5m_0570',  'Pose5/PTZ_4.5m_Pose5/0570', 'PTZ_Pose5_4.5m_30__0570_img%d.jpg', 1:22; ...
    'Pose5_PTZ_4.5m_0613',  'Pose5/PTZ_4.5m_Pose5/0613', 'PTZ_Pose5_4.5m_30__0613_img%d.jpg', 1:22; ...
    'Pose5_PTZ_4.5m_0642',  'Pose5/PTZ_4.5m_Pose5/0642', 'PTZ_Pose5_4.5m_30__0642_img%d.jpg', 1:22; ...
    'Pose5_PTZ_5m_0000',  'Pose5/PTZ_5m_Pose5/0000', 'PTZ_Pose5_5m_30__0000_img%d.jpg', 1:22; ...
    'Pose5_PTZ_5m_0230',  'Pose5/PTZ_5m_Pose5/0230', 'PTZ_Pose5_5m_30__0230_img%d.jpg', 1:22; ...
    'Pose5_PTZ_5m_0370',  'Pose5/PTZ_5m_Pose5/0370', 'PTZ_Pose5_5m_30__0370_img%d.jpg', 1:22; ...
    'Pose5_PTZ_5m_0460',  'Pose5/PTZ_5m_Pose5/0460', 'PTZ_Pose5_5m_30__0460_img%d.jpg', 1:22; ...
    'Pose5_PTZ_5m_0520',  'Pose5/PTZ_5m_Pose5/0520', 'PTZ_Pose5_5m_30__0520_img%d.jpg', 1:22; ...
    'Pose5_PTZ_5m_0570',  'Pose5/PTZ_5m_Pose5/0570', 'PTZ_Pose5_5m_30__0570_img%d.jpg', 1:22; ...
    'Pose5_PTZ_5m_0613',  'Pose5/PTZ_5m_Pose5/0613', 'PTZ_Pose5_5m_30__0613_img%d.jpg', 1:22; ...
    'Pose5_PTZ_5m_0642',  'Pose5/PTZ_5m_Pose5/0642', 'PTZ_Pose5_5m_30__0642_img%d.jpg', 1:22; ...
    'Pose5_PTZ_5m_0673',  'Pose5/PTZ_5m_Pose5/0673', 'PTZ_Pose5_5m_30__0673_img%d.jpg', 1:22; ...
    };

% add data as a loop (is going to repeate dataId=1
% going to greate dataId  '11':'19'
for i=1:9
    istr= num2str(i);
    mydata{end+1,1}= ['1' istr];
    mydata{end,2}= ['PTZ_and_laser_calib/calib_img' istr];
    mydata{end,3}= 'img%d.jpg';
    mydata{end,4}= 1:50;
    if i==1, mydata{end,4}= 2:50; end
end

% mydata:
%     '1'     'PTZ_and_laser_cali�'    'img%d.jpg'    [1x50 double]
%     '11'    'PTZ_and_laser_cali�'    'img%d.jpg'    [1x49 double]
%     '12'    'PTZ_and_laser_cali�'    'img%d.jpg'    [1x50 double]
%     '13'    'PTZ_and_laser_cali�'    'img%d.jpg'    [1x50 double]
%     '14'    'PTZ_and_laser_cali�'    'img%d.jpg'    [1x50 double]
%     '15'    'PTZ_and_laser_cali�'    'img%d.jpg'    [1x50 double]
%     '16'    'PTZ_and_laser_cali�'    'img%d.jpg'    [1x50 double]
%     '17'    'PTZ_and_laser_cali�'    'img%d.jpg'    [1x50 double]
%     '18'    'PTZ_and_laser_cali�'    'img%d.jpg'    [1x50 double]
%     '19'    'PTZ_and_laser_cali�'    'img%d.jpg'    [1x50 double]

return
