function BrainNetData(COG,Node_colour,Node_size,output_name,labels)

% This generates a .node file that can be read by BrainNetViewer
%
% Input:        
%           COG = A file of each nodes coordinates, where each row
%           corresponds to a node
%
%           Node_colour = a vector containing the values for each node
%           which will be used to colour the nodes (i.e. all nodes will a
%           value of 1 will be one colour, all nodes with a value of two
%           will be another colour etc)
%
%           Node_size = a vector containing the values that will control
%           how large the node is in BrainNetViewer. Larger values mean
%           larger nodes
%
%           output_name = this is a string of what you want to name the
%           .node file (note do not included the .node extension in the 
%           name)
%
%           labels = this variable is optional. Can either be a vector
%           containing the nodes number or a cell array with the nodes name 
%
%   Written by Stuart Oldham, 06/03/2016

if nargin < 5
    labels = 1:length(Node_colour);
end

if length(Node_colour) ~= length(Node_size)
    error('Node_colour and Node_size need to be the same length')
end

if size(COG,2) > 3
    error('COG should have 3 columns only, corresponding to a nodes x, y and z coordinates. Each row should be a different node') 
end

if size(COG,1) > length(Node_colour)
    error('COG either contains too many nodes or Node_colour/Node_size contain too few nodes')
elseif size(COG,1) < length(Node_colour)
    error('COG either contains too few nodes or Node_colour/Node_size contain too many nodes')
end

if isa(labels,'double')
    if ~isvector(labels)
        error('labels should be an array not a matrix')
    end
elseif iscell(labels)
    if ~isvector(labels)
        error('labels needs to be a cell along a single dimension')
    end
else
    error('labels needs to either be an array or a cell')
end

if length(labels) > length(Node_colour) 
    error('Either labels contains too many nodes or not enough nodes are in COG/Node_colour/Node_size')
elseif length(labels) < length(Node_colour) 
    error('Either labels either contains not enough nodes or too many nodes are in COG/Node_colour/Node_size') 
end

data = cell(length(Node_colour),6);

for i = 1:size(COG,1)
data{i,1} = COG(i,1);
data{i,2} = COG(i,2);
data{i,3} = COG(i,3);
end

for i = 1:length(Node_colour)
data{i,4} = Node_colour(i);
end

for i = 1:length(Node_size)
data{i,5} = Node_size(i);
end

if ~iscell(labels)
    formatSpec = '%f %f %f %d %d %d\n';
    for i = 1:length(labels)
        data{i,6} = labels(i);
    end   
elseif iscell(labels)
    formatSpec = '%f %f %f %d %d %s\n';
        for i = 1:length(labels)
            data{i,6} = labels{i};
        end
end

savename = sprintf('%s.node',output_name);

fileID = fopen(savename,'w');

[nrows] = size(data);

for row = 1:nrows
    fprintf(fileID,formatSpec,data{row,:});
end
fclose(fileID);
