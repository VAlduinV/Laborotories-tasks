function [Es, Ed, SpM, A, S, Ns] = Ising2(Nspin, J, h, T, NTrial)
    % Налаштування початкових параметрів
    Ns = sqrt(Nspin); % розмір сторони решітки
    s = ones(Ns, Ns); % початкова конфігурація спінів
    Ensys = -J * Nspin; % початкова енергія системи
    Edemon = 4 * J * floor((T * Nspin - Ensys) / (4 * J));
    Es(1) = Ensys; Ed(1) = Edemon;
    S = s; k = 1;

    % Основний цикл моделювання
    for i = 1:NTrial
        Accept = 0;
        for j = 1:Nspin
            % Випадковий вибір вузла сітки
            Ix = randi(Ns); Iy = randi(Ns);

            % Граничні умови
            Left = mod(Ix - 2, Ns) + 1;
            Right = mod(Ix, Ns) + 1;
            Down = mod(Iy - 2, Ns) + 1;
            Up = mod(Iy, Ns) + 1;

            % Розрахунок зміни енергії
            de = 2 * s(Iy, Ix) * (-h + J * (s(Iy, Left) + s(Iy, Right) + s(Down, Ix) + s(Up, Ix)));
            if de <= Edemon
                s(Iy, Ix) = -s(Iy, Ix); 
                Accept = Accept + 1;
                Edemon = Edemon - de; 
                Ensys = Ensys + de;
            end
            k = k + 1; 
            Es(k) = Ensys; 
            Ed(k) = Edemon; 
            A(k - 1) = Accept;
            s1 = sum(s); 
            SpM(k) = sum(s1); 
            S = cat(3, S, s);
        end
    end
    A = A / NTrial;
end

% Виклик функції з заданими параметрами
Nspin = 64; % Число спінів системи
J = 1; % Константа обмінної взаємодії
h = 0; % Напруженість зовнішнього магнітного поля
T = 1.5; % Температура
NTrial = 100; % Кількість випробувань

[Es, Ed, SpM, A, S, Ns] = Ising2(Nspin, J, h, T, NTrial);

% Візуалізація миттєвих конфігурацій спінів
time_points = [10, 100, 500, 2000];
colors = lines(length(time_points)); % Генеруємо набір кольорів для кожного часу

for idx = 1:length(time_points)
    t = time_points(idx);
    figure; bar3(S(:, :, t)); 
    axis([0 Ns 0 Ns -1.5 1.5]); 
    colormap(jet); % Використовуємо кольорову карту 'jet'
    title(['Конфігурація системи в момент часу t=', num2str(t)]);
end

% Візуалізація миттєвих значень енергії системи
figure;
plot(1:length(Es), Es, 'Color', 'b', 'LineWidth', 1.5); grid on;
title('Залежність миттєвих значень енергії системи від часу');
xlabel('Час'); ylabel('Енергія');

% Візуалізація миттєвих значень енергії демона
figure;
plot(1:length(Ed), Ed, 'Color', 'r', 'LineWidth', 1.5); grid on;
title('Залежність миттєвих значень енергії демона від часу');
xlabel('Час'); ylabel('Енергія демона');

% Розрахунок фізичних величин
% Compute physical quantities
Emean = mean(Es) / Nspin; % Mean energy per spin
E2mean = mean(Es.^2) / Nspin; % Mean square energy per spin

SpMmean = mean(SpM) / Nspin; % Mean magnetization per spin
SpM2mean = mean(SpM.^2) / Nspin; % Mean square magnetization per spin

Cv = (E2mean - Emean^2) / (T^2); % Heat capacity
Chi = (SpM2mean - SpMmean^2) / T; % Magnetic susceptibility

% Display results
disp(['Середня енергія на спін: ', num2str(Emean)]);
disp(['Середня намагніченість на спін: ', num2str(SpMmean)]);
disp(['Теплоємність: ', num2str(Cv)]);
disp(['Магнітна сприйнятливість: ', num2str(Chi)]);
