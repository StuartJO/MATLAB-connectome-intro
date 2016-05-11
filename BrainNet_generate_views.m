function BrainNet_generate_views(NodeFileName,EdgeFileName,SurfaceTemplatePath,OutputBaseFilename)

    % ------------------------------------------------------------------------------
    % Run the viewer using ICBM152 brain mesh:
    % ------------------------------------------------------------------------------
    
    if ~isempty(EdgeFileName)
        fprintf(1,'PLOTTING EDGES TOO!\n');
        BrainNet_MapCfg(SurfaceTemplatePath,NodeFileName,EdgeFileName, ...
                        'sag_options.mat',sprintf('%s_sagital.jpg',OutputBaseFilename));
        BrainNet_MapCfg(SurfaceTemplatePath,NodeFileName,EdgeFileName, ...
                        'ax_options.mat',sprintf('%s__axial.jpg',OutputBaseFilename));
        BrainNet_MapCfg(SurfaceTemplatePath,NodeFileName,EdgeFileName, ...
                        'cor_options.mat',sprintf('%s_coronal.jpg',OutputBaseFilename));        
    else
        OutputFileSag = sprintf('%s_sagital.jpg',OutputBaseFilename);
        BrainNet_MapCfg(SurfaceTemplatePath,NodeFileName, ...
                        'sag_options.mat',OutputFileSag);
        fprintf(1,'''%s'' saved!\n',OutputFileSag);
        OutputFileAx = sprintf('%s_axial.jpg',OutputBaseFilename);
        BrainNet_MapCfg(SurfaceTemplatePath,NodeFileName, ...
                        'ax_options.mat',OutputFileAx);
        fprintf(1,'''%s'' saved!\n',OutputFileAx);
        OutputFileCor = sprintf('%s_coronal.jpg',OutputBaseFilename);
        BrainNet_MapCfg(SurfaceTemplatePath,NodeFileName, ...
                        'cor_options.mat',OutputFileCor);
        fprintf(1,'''%s'' saved!\n',OutputFileCor);
    end
end