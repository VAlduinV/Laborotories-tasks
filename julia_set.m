function julia_set
    % Параметри
    res = 1000; % Розділення 1000x1000
    c = -0.488679 - 0.56790i; % Початкова точка
    max_iter = 30; % Кількість ітерацій
    dl = 1.25; % Межа масштабування

    % Координати
    x = linspace(-dl, dl, res);
    y = linspace(-dl, dl, res);
    [X, Y] = meshgrid(x, y);
    Z = X + 1i * Y;

    % Генерація
    iter_map = zeros(size(Z));
    for k = 1:max_iter
        Z = Z.^2 + c;
        iter_map(abs(Z) > 2 & iter_map == 0) = k;
    end

    % Візуалізація
    colormap(copper(256));
    imagesc(x, y, iter_map);
    axis equal;
    title('Множина Жюліа');
    colorbar;
end
