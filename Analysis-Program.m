%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Equations for the Use of the Integration:        
%From https://www.youtube.com/watch?v=BoMO-Peobsw
%Find how to skip the headers:
%https://www.mathworks.com/matlabcentral/answers/422803-how-to-load-dat-file-without-header
%Something I found:
%https://stackoverflow.com/questions/26476467/calculating-displacement-using-accelerometer-and-gyroscope-mpu6050
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Program Used to Find the PGA, Velocity, and Displacement from Accelerometer
clear, clc, close all;

%% Initial Conditions
g = 981; %981 cm/s^2 since the data being used is cm/s^2.

%% Loading up the Data from the Text Files
%Text Files must be saved as (Tab Delimited)
M = importdata('GM1_AccTH_SDC2020.txt');
%M = importdata('GM2_AccTH_SDC2020.txt');
%M = importdata('PracticeTrial.txt');

%% Acceleration
time = M.data(:,1); %Time is obtained from the First Column of the Text File
Acc = M.data(:,2); %Acceleration is obtained from the Second Column of the Text File
n = length(time); %This records how long the actual length of the file is and
                  %is used for the FOR LOOPS


PGA = max(abs(Acc))/g ; %Finding the PGA from the absolute values of the acceleration.
fprintf('PEAK GROUND ACELERACTION \n     [%f g] \n',PGA);

subplot(3,1,1) %The subplot plots any amount of graphs in one window.
               %subplot(Row of graphs,Column of Graphs,Which Window It'll
               %be displayed in.)
plot(time,Acc)
title('Acceleration of Structure')
xlabel('Time (seconds)');
ylabel('Acceleration (cm/s^2)')
legend(['PGA= ',num2str(PGA),' ','g']);
grid minor;

%% Velocity
area=0; %Because the first point of all data will typically be at 0, the
        %initial values will contain the value of 0. As such, the for loop
        %can start at the second value and subtract from the first.
Vel(1) = Acc(1);
for i=2:n
    area=area+((Acc(i)+Acc(i-1))/2)*(time(i)-time(i-1)); %The area under 
                                                         %slope.
    Vel(i)=area;
end

MaxVel = max(abs(Vel)); %This finds the largest absolute value of the array.

subplot(3,1,2)
plot(time,Vel)
title('Velocity of the Structure')
xlabel('Time (seconds)');
ylabel('Velocity (cm/s)')
legend(['Max Vel= ',num2str(MaxVel),' ','cm/s']);
grid minor;

%% Displacement
area2=0;
Dis(1) = Vel(1);
for i=2:n
    area2=area2+((Vel(i)+Vel(i-1))/2)*(time(i)-time(i-1));
    Dis(i)=area2;                    
end

MaxDis = max(abs(Dis));

subplot(3,1,3)
plot(time,Dis)
title('Displacement of the Structure')
xlabel('Time (seconds)');
ylabel('Displacement (cm)')
legend(['Max Dis= ',num2str(MaxDis),' ','cm']);
grid minor;

%% Garbage

%ag = load('Prueba Full.txt'); %the load('Text.txt') will load up all the 
%the data from the text file.
%col1 = ag(:,1);
%col2 = ag(:,2);

% filename = 'Mag_9.csv';
% Array = xlsread(filename); %Reads the file in the Excel file
% n = length(Array); %Keep the length to plot the actual graph along the frequency
% % Separating the Array in to different columns
% col1 = Array(:,1); %Keeps the value for the first column (Time)
% col2 = Array(:,2); %This is a cryptic message. Who knows what it means (Acceleration)