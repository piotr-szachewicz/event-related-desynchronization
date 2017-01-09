function [y] = postprocessing(x, window=50)

	printf('POSTPROCESSING!\n');
	printf('Input vector size:\n');
	size(x)
	min(x)
	max(x)
	printf('Du\n');

	y = x;

	for i=window+1:size(x,1)
		printf('i = %d\n', i);
		prev = x(i-window:i-1, :);
		h = histc(prev, [1,2,3,4]);

		[v,ind] = max(h);
		v = v ./ window;
		[v,ind];

		for j=1:length(v)
			if v(j) > 0.5;
				y(i, j) = ind(j);
			end
		end
	end

end

