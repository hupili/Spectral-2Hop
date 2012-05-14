%sample spectral technique

clear ;
close all ;

figure ; 

N = 100 ;
K = 2 ;

theta = linspace(0, 2 * pi, N) ;
C1X1 = 1 + cos(theta) + 0.1 * randn(1, N) ;
C1X2 = 1 + sin(theta) + 0.1 * randn(1, N) ;
scatter(C1X1, C1X2) ; hold on ;
theta = linspace(0, 2 * pi, 2*N) ;
C2X1 = 1 + 2 * cos(theta) + 0.1 * randn(1, 2*N) ;
C2X2 = 1 + 2 * sin(theta) + 0.1 * randn(1, 2*N) ;
scatter(C2X1, C2X2) ;
X = [C1X1', C1X2' ; C2X1', C2X2'] ;
print(gcf, '-dpng', '../plot/sc_sample_scatter.png') ;

figure ;

[idx, c] = kmeans(X, K) ;
plot(X(idx==1, 1), X(idx==1, 2), 'ob') ;
hold on ;
plot(X(idx==2, 1), X(idx==2, 2), 'or') ;
h = plot(c(1, 1), c(1, 2), '*b') ;
set(h, 'LineWidth', 20) ;
h = plot(c(2, 1), c(2, 2), '*r') ;
set(h, 'LineWidth', 20) ;
print(gcf, '-dpng', '../plot/sc_sample_kmeans.png') ;

figure ;
epsilon = 0.7 ;
D = dist(X') ;
A = double(D < epsilon) ;
gplot(A, X) ;
print(gcf, '-dpng', '../plot/sc_sample_adj.png') ;
figure ;
[V, Lambda] = eigs(A, K) ;
[idx, c] = kmeans(V, K) ;
plot(X(idx==1, 1), X(idx==1, 2), 'ob') ;
hold on ;
plot(X(idx==2, 1), X(idx==2, 2), 'or') ;
print(gcf, '-dpng', '../plot/sc_sample_sc.png') ;

figure ;
plot(V(idx==1, 1), V(idx==1, 2), 'ob') ;
hold on ;
plot(V(idx==2, 1), V(idx==2, 2), 'or') ;
print(gcf, '-dpng', '../plot/sc_sample_2d_embed.png') ;
% h = plot(c(1, 1), c(1, 2), '*b') ;
% set(h, 'LineWidth', 20) ;
% h = plot(c(2, 1), c(2, 2), '*r') ;
% set(h, 'LineWidth', 20) ;