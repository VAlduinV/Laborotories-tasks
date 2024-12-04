function plasma_animation
    % Параметры
    res = [4, 4; 128, 128]; % Разрешение
    steps = 30;

    figure;
    colormap(copper(256));
    axis equal;

    for i = 1:steps
        [X, Y] = meshgrid(linspace(-1, 1, res(1, 1) + (res(2, 1) - res(1, 1)) * i/steps), ...
                          linspace(-1, 1, res(1, 2) + (res(2, 2) - res(1, 2)) * i/steps));
        Z = sin(10 * sqrt(X.^2 + Y.^2)) + cos(10 * X .* Y);

        imagesc(Z);
        title(['Step ', num2str(i)]);
        drawnow;

        pause(0.1); % Пауза в 0.1 секунды

        % Сохранение кадра
        frames(i) = getframe(gcf);
    end

    % Сохранение анимации
    v = VideoWriter('plasma_animation.avi');
    open(v);
    for i = 1:steps
        writeVideo(v, frames(i));
    end
    close(v);
end
