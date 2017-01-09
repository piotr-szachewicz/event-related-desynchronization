function s = print_struct(str)

	s = '{';
	for [value, key] = str
		s = strcat(s, sprintf('%s:', key));
		if ischar(value)
			vs = sprintf('%s,',value);
		elseif isinteger(value)
			% but - isinteger(14) is false because 'numeric constants in Octave are double precision floating point values'
			vs = sprintf('%d,', value);
		elseif isnumeric(value)
			vs = sprintf('%f,', value);
		elseif ismatrix(value)
			vs = sprintf('%d, ', value);
			vs = strcat('[', vs, ']');
		elseif isstruct(value)
			vs = print_struct(value);
		end
		s = strcat(s, vs);
	end
	s = strcat(s, '}');	   

end
