function [feat] = reshape_features(f)
    feat = reshape(f, [size(f,1), size(f,2)*size(f,3)])';
end


