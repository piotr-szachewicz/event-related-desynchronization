function plot_data(x, y, titles, y_axis_range = [], x_axis_label = 'seconds', y_axis_label = 'uV', number_of_columns = 1, x_ticks = [], y_ticks=[])

    clf; %clear figure
    graphics_toolkit ('gnuplot');

    N = size(y, 2); % number of data plots
    font_size = 8 

    for i = 1:N
        subplot(N, number_of_columns, i);
        p = plot(x, y(:, i));
        % legend(strcat(h.Label{1}, ' (after EOG reduction)'));
        if i == N || (number_of_columns == 2 && i == N-1)
            xlabel(strcat(y_axis_label, '/', x_axis_label),'fontsize', font_size);
        else
            set(gca, 'XTickLabel','')
        end

%        ylabel(y_axis_label, 'fontsize', font_size);
        ylabel(titles{i}, 'fontsize', font_size)
        if !isempty(y_axis_range)
            axis([x(1), x(end), y_axis_range(1), y_axis_range(2)]);
%            set(gca, 'YTick', [y_axis_range(1), y_axis_range(1)/2, 0, y_axis_range(2)/2, y_axis_range(2)])
        end

        if !isempty(x_ticks)
            set(gca,'xtick', x_ticks);
        end
        if !isempty(y_ticks)
            set(gca,'ytick', y_ticks);
        end

        set(gca, 'fontsize', font_size);

        tit = title('');
        pos = get(tit, 'position');

%        if i == 1 
%            text(pos(1)-3.5/number_of_columns, pos(2), y_axis_label, 'fontsize', font_size);
%        end
    end
end
