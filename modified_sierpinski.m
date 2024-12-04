function modified_sierpinski
    % Афінні перетворення
    T1 = [0.5, 0, 0; 0, 0.5, 0; 0, 0, 1];
    T2 = [0.5, 0, 0.5; 0, 0.5, 0; 0, 0, 1];
    T3 = [0.5, 0, 0; 0, 0.5, 0.5; 0, 0, 1];

    transforms = {T1, T2, T3};
    points = [0, 0; 1, 0; 0.5, sqrt(3)/2; 0, 0]';

    figure;
    hold on;
    axis equal;
    axis off; % Вимкнення осей

    all_points = [];
    for i = 1:100 % Зменшено кількість ітерацій до n
        new_points = [];
        for T = transforms
            new_points = [new_points, T{1} * [points; ones(1, size(points, 2))]];
        end
        points = new_points(1:2, :);
        all_points = [all_points, points]; % Накопичення всіх точок
        
        if mod(i, 5) == 0 % Оновлення графіка кожні 5 ітерацій
            plot(all_points(1, :), all_points(2, :), 'b.', 'MarkerSize', 1);
            drawnow;
        end
    end

    % Фінальне малювання після завершення
    plot(all_points(1, :), all_points(2, :), 'b.', 'MarkerSize', 1);
    title('Оптимізований модифікований килим Серпінського');
    hold off;
end
