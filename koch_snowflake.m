function Snowflake(Lmax)
    % Функція для побудови кольорової сніжинки третього порядку
    % Lmax - порядок фракталу
    Axiom = '[F]+[F]+[F]+[F]+[F]+[F]'; % Аксіома
    Newf = 'F[+FF][-FF]FF[+F][-F]FF';  % Правило породження
    teta = pi/3;  % Кут обертання
    alpha = 0;    % Початковий кут
    p = [0; 0];   % Початкова точка
    CoordSnowflake(p, Lmax, Axiom, Newf, alpha, teta); % Виклик функції побудови
end

function CoordSnowflake(p, Lmax, Axiom, Newf, alpha, teta)
    % Функція для обчислення координат та побудови фракталу
    Rule = FractalString(Lmax, Axiom, Newf, 1, ''); % Генерація L-системи
    figure; hold on;
    set(gca, 'Color', [0.1, 0.1, 0.3]); % Фон графіку (темно-синій)
    M = length(Rule);
    x0 = p(1); y0 = p(2); % Початкові координати
    Stack = []; % Стек для збереження станів

    % Колір для сніжинки
    color = [0.8, 0.9, 1]; % Світло-блакитний
    
    for i = 1:M
        switch Rule(i)
            case 'F' % Крок вперед
                x1 = x0 + cos(alpha);
                y1 = y0 + sin(alpha);
                plot([x0, x1], [y0, y1], 'Color', color, 'LineWidth', 1.5); % Лінія з кольором
                x0 = x1; y0 = y1;
            case '+' % Поворот за годинниковою стрілкою
                alpha = alpha + teta;
            case '-' % Поворот проти годинникової стрілки
                alpha = alpha - teta;
            case '[' % Збереження стану
                Stack = [Stack; x0, y0, alpha];
            case ']' % Відновлення стану
                x0 = Stack(end, 1);
                y0 = Stack(end, 2);
                alpha = Stack(end, 3);
                Stack(end, :) = [];
        end
    end

    axis equal;
    set(gca, 'xtick', [], 'ytick', []); % Приховуємо осі
    set(gca, 'XColor', 'none', 'YColor', 'none');
    hold off;
end

function z = FractalString(Lmax, Axiom, Newf, n, tmp)
    % Рекурсивна функція для генерації L-системи
    if n > Lmax
        z = tmp;
    else
        if n == 1
            tmp = Axiom;
        else
            tmp = strrep(tmp, 'F', Newf);
        end
        z = FractalString(Lmax, Axiom, Newf, n + 1, tmp); % Рекурсія
    end
end

Snowflake(3)
