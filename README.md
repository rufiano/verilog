# Репозиторий домашних заданий по сиситемотехнике электронно вычислительных средств
## 1 СЕМЕСТР <br />
## Задание №1 <br />
Реализовать КИХ фильтр, 3 отсчета, размерность коэффициентов 8 бит, знаковые числа.
Входные данные поступают каждые 10 тактов, размерность 8 бит, знаковые целые числа.
Допускается использовать один (два*) физический умножитель. Обосновать размерность
результата.

## Версия 1 - один физический умножитель. <br />
Файл с исходным кодом - zadanie1v1.v <br />

Входные данные: <br />

clk - тактовый сигнал; <br /> 
in_reg - флаг прихода новых данных; <br />
x - входные данные для обработки фильтром, поступают каждые 10 тактов; <br />
r1,r2,r3 - коэффициенты фильтра; <br />
r1 = 2; <br />
r2 = -4; <br />
r3 = 7; <br />

Выходные данные:  <br />
y = результат КИХ фильтра <br />
y = r1 * x1 + r2 * x2 + r3 * x3 <br />

Описание работы. <br />
Каждый такт in_reg входные данные с X перемещаются на переменные X1,X2,X3 для хранения. <br />

1. На вход x пришло x=**-3**. <br />
Переменные x1 = -3; x2,x3 = 0 <br />
Выход y = r1 * x1 = 2 * -3 = -6 <br />
   ![image](https://github.com/rufiano/verilog/assets/122745439/4bb612c1-2f51-4a2b-90e5-83ef2c65ff7e)


2. Через 10 тактов на вход X пришло значение **9**. <br />
Переменные x1 = 9; x2= -3; x3 = 0. <br /> 
Выход y = (r1 * x1) + (r2 * x2) = (2 * 9) + (-4 * -3) = 18 + 12 = 30 <br />
   ![image](https://github.com/rufiano/verilog/assets/122745439/24d2d57f-3512-40a1-af48-8cae3f5ea3ca)



3. Через 10 тактов на вход X пришло значение **4**. <br />
Переменные x1 = 4; x2= 9; x3 = -3. <br />
Выход y = (r1 * x1) + (r2 * x2) + (r3 * x3) = (2 * 4) + (-4 * 9) + (7 * -3) = 8 - 36 - 21 = -49 <br />
   ![image](https://github.com/rufiano/verilog/assets/122745439/84c763e4-8903-4768-ad93-40402ab8cba0)


4. Через 10 тактов на вход X пришло значение **-8**.<br />
Переменные x1 = -8; x2= 4; x3 = 9. <br />
Выход y = (r1 * x1) + (r2 * x2) + (r3 * x3) = (2 * -8) + (-4 * 4) + (7 * 9) = -16 - 16 + 63 = 31 <br />
   ![image](https://github.com/rufiano/verilog/assets/122745439/d6e66fa5-b232-4e9a-9bd3-2baf76d3c572)

## Версия 2 - два физических умножителя. <br />
Файл с исходным кодом - zadanie1v2.v <br />

Входные данные и выходные данные аналогичны 1 версии.
r1,r2,r3 - коэффициенты фильтра; <br />
r1 = 1; <br />
r2 = -9; <br />
r3 = 17; <br />

Описание программы <br />


1. На вход x пришло x=**-3**. <br />
Переменные x1 = -3; x2,x3 = 0 <br />
Выход y = r1 * x1 = 1 * -3 = -3 <br />
   ![image](https://github.com/rufiano/verilog/assets/122745439/4bb612c1-2f51-4a2b-90e5-83ef2c65ff7e)

2. Через 10 тактов пришло **9**, еще через 10 тактов **4**. <br />
Переменные x1 = 4; x2 = 9; x3 = -3 <br />
Выход y = (r1 * x1) + (r2 * x2) + (r3 * x3) = (1 * 4) + (-9 * 9) + (17 * -3) = 4 - 81 - 51 = -128 <br />
![image](https://github.com/rufiano/verilog/assets/122745439/2f03f68d-3819-469b-b308-1c2d69d87abf)

3. Через 10 тактов на вход x пришло -8 <br />
Переменные x1 = -8; x2 = 4; x3 = 9 <br />
Выход y = (r1 * x1) + (r2 * x2) + (r3 * x3) = (1 * -8) + (-9 * 4) + (17 * 9) = -8 - 36 + 153 = -128 <br />
![image](https://github.com/rufiano/verilog/assets/122745439/2f1c001f-a32d-483c-a26c-00ad659b539b)

## Задание №2 <br />
Реализовать комплексный умножитель.Доступен всего один физический модуль умножения
целых чисел. Входные данные поступают каждые 3 такта, размерность 8 бит, знаковые
целые числа.

Файл с исходным кодом - zadanie2.v <br />

Входные данные: <br />
clk - тактовый сигнал; <br />
in_reg - флаг данных; <br />

a1re - 1 вещественное слогаемое; <br />
a2re - 2 вещественное слогаемое; <br />
b1im - 1 мнимое слогаемое; <br />
b2im - 2 мнимое слогаемое. <br />

Выходные данные:  <br />
RealC - результат вещественной части; <br />
ImagC - результат мнимой части. <br />

Описание программы: <br />

Вычисление в коде выполнено по формуле: <br />
RealC = a2re * ( a1re + b1im ) -  b1im * ( a2re + b2im);  <br />
ImC = a2re * ( a1re + b1im ) + a1re * ( b2im - a2re); <br />

На вход поступают значения: <br />
a1re = -3 <br />
a2re = -10 <br />
b1im = 9 <br />
b2im = 4 <br />

Результат: <br />
(a1re + b1im) * (a2re + b2im) = ((a1re * a2re) - (b1im * b2im)) + ((a1re * b2im) + (b1im * a2re)) = RealC + ImagC <br />
(-3 + 9i) * (-10 + 4i) = ((-3 * -10) - (9i * 4i)) + ((-3 * 4i) + (9i * -10)) = 30 - 36 + (-12i) + (-90i) = -6 - 102i <br />
![image](https://github.com/rufiano/verilog/assets/122745439/2b801963-388f-4fd7-9591-f08969940818)

Через 3 такта на вход приходят: <br />
a1re = -8 <br />
a2re = -12 <br />
b1im = 5 <br />
b2im = 2 <br />

Результат: <br />
(a1re + b1im) * (a2re + b2im) = ((a1re * a2re) - (b1im * b2im)) + ((a1re * b2im) + (b1im * a2re)) = RealC + ImagC <br />
(-8 + 5i) * (-12 + 2i) = ((-8 * -12) - (5i * 2i)) + ((-8 * 2i) + (5i * -12)) = 96 - 10 + (-16i) + (-60i) = 86 - 76i <br />
![image](https://github.com/rufiano/verilog/assets/122745439/c92bf866-dd64-460b-b93d-c0b06adfb9a5)

## 2 СЕМЕСТР <br />
## Задание №3 <br />
Реализовать БИХ фильтр вида yk+1 = a * yk+b * xk+1. Размерность x, a, b составляет 8 бит,
знаковые целые числа. a, b известны заранее, в процессе работы не меняются.
Обосновать размерность результата.
Данные на вход поступают каждый такт. Операция умножения занимает два такта

Файл с исходным кодом - zad3.v <br />

Описание программы: <br />

Для вычисления  yk+1 = a * yk+b * xk+1 формула была преобразована к виду <br /> 
y(k) = a^3 * y(k - 3) + a^2 * b * x(k - 2) + a * b * x(k - 1) + b * x(k) <br />


Входные данные: <br />
clk - тактовый сигнал; <br />
in_reg - флаг данных; <br />
x - данные, поступающие каждый такт; <br />
ak - коэффициент a; <br />
bk - коэффициент b; <br />
ab - результат умножения a*b; <br />
a2b - результат a^2 * b; <br />
aaa - результат a^3; <br />

Демонстрация работы: <br />
![image](https://github.com/rufiano/verilog/assets/122745439/1419d13f-8534-4969-b8a9-2e4521f4eeae)

x1, x2 используются для задержки x и получения x(k-1), x(k-2) <br />
Результат b * x(k) рассчитывается в модуле multib, a * b * x(k - 1) в модуле multiab, a^2 * b * x(k - 2) в модуле multiaab, a1^3 * y(k - 3) в модуле multiaaa.
Полученные вычисления суммруются в переменную y.

На вход поступают данные x: x1 = -3, x2 = 9, x3=4, x4=-8, x5=11.  <br />
ak = 2;  <br />
bk = -4;  <br />
ab = -8;  <br />
a2b = -16;  <br />
aaa = 8;  <br />

y1 = b * x(1) = -4 * -3 = 12; <br />
y2 =a * b * x(1) + b * x(2) =-8 * -3 + -4 * 9 = -12; <br />
y3 =a^2 * b * x(1) + a * b * x(2) + b * x(3) = -16 * -3 + -8 * 9 + -4 * 4 = -40; <br />
y4 = a^3 * y(1) + a^2 * b * x(2) + a * b * x(3) + b * x(4) = 8 * 12 + -16 * 9 + -8 * 4 + -4 * -8 = -48; <br />
y5 = a^3 * y(2) + a^2 * b * x(3) + a * b * x(4) + b * x(5) = 8 * -12 + -16 * 4 + -8 * -8 + -4 * 11 = -140; <br />

## Задание №8 <br />
Реализовать FIFO очередь (глубиной 1024 слова) для передачи данных размерностью 8 бит
из домена одного тактового сигнала в другой домен. Тактовые сигналы асинхронны, для
перехода между доменами требуется 3 регистра для исключения метастабильности. 
а) Данные на вход поступают редко, очередь не переполняется.<br />
б) Данные на вход поступают часто, очередь может переполниться, показать <br />
корректную работу интерфейсов AXI-Stream.<br />

## Версия А - данные поступают редко, очередь не переполняется <br />
Файл с исходным кодом - zad8.1.v <br />

Описание программы: <br />
Входные данные:<br />
data_in[7:0], clk_wr, wr_en, r_en.<br />
Выходные данные:<br />
data_out[7:0], clk_r, empty, full.<br />
Память:<br />
mem[1023:0] <br />
point_wr/point_r - поинтеры записи/чтения для поднятия флага full/empty <br />
point_wr_rclk...reg/point_r_wrclk...reg - перетактируемые поинтеры для исключения метастабильности и случайного срабатывания <br />

Алгоритм: <br />
Данные записываются/считываются в массив mem при наличии разрешения на запись/чтение и отсутсвия сигнала full/empty. <br />

Full и empty взводится по комбинаторной логике. Для отслеживания перехода через ноль к поинтерам добавлен 11 бит. <br />
FULL = 1, если все биты (кроме старшего) поинтера чтения и поинтера записи совпадают, а старшие биты не равны. <br />
EMPTY = 1, если поинтеры равны.<br />
![image](https://github.com/rufiano/verilog/assets/122745439/9fdc5ddd-f37f-4259-bc2f-f736f5242a9e)
Данные в программу поступают каждый такт, очередь не переполняются. <br />
По данным на data_in, data_out видна работа FIFO. <br />
![image](https://github.com/rufiano/verilog/assets/122745439/0d14de4c-245d-4fed-a22e-f0a040dce631)
## Версия Б - данные поступают часто, очередь может переполняться <br />

Файл с исходным кодом - zad8.2.v <br />

Описание программы: <br />
Входные данные:<br />
data_in[7:0], clk_wr, wr_en, r_en.<br />
Выходные данные:<br />
data_out[7:0], clk_r, empty, full.<br />
Память:<br />
mem (для демонстрации переполнения, глубина массива уменьшена до 8) <br />
point_wr/point_r - поинтеры записи/чтения для поднятия флага full/empty <br />
point_wr_rclk...reg/point_r_wrclk...reg - перетактируемые поинтеры для исключения метастабильности и случайного срабатывания <br />

Алгоритм: <br />
Данные записываются/считываются в массив mem при наличии разрешения на запись/чтение и отсутсвия сигнала full/empty. <br />

Full и empty взводится по комбинаторной логике. Для отслеживания перехода через ноль к поинтерам добавлен 4 бит. <br />
FULL = 1, если все биты (кроме старшего) поинтера чтения и поинтера записи совпадают, а старшие биты не равны. <br />
EMPTY = 1, если поинтеры равны.<br />
![image](https://github.com/rufiano/verilog/assets/122745439/9fdc5ddd-f37f-4259-bc2f-f736f5242a9e)
Данные в программу поступают каждый такт, очередь переполняется после записи data_in = 8, на этом моменте возводится full, запись останавливается. FULL опускается по мере считывания данных. <br />
Так как для исключения метастабильности использованы 3 регистра, то сигнал empty опускается с задержкой.  <br />
