%%
clc;
clear;
close all;
%%
% 获取数据
time=table.VarName1;
state=table.VarName2;
theo=table.VarName3; 
real=table.VarName4;
gus=table.VarName5;
brake=table.VarName6;
speed=table.VarName7;
ss=table.VarName8;
time=time/1000;
%% 
% 计算加速度
acc=[];
acc(1)=0;
for i=2:length(speed)
    acc(i,:)=(speed(i)-speed(i-1))/(time(i)-time(i-1))/3.6;
end
%%
min1 = min(speed);
min2 = min(acc);
min3 = min(brake);

max1 = max(speed);
max2 = max(acc);
max3 = max(brake);

%%
% 记录自动驾驶状态
state_record=[];
mar=state(1);
state_record(1)=1;
for j=2:length(state)
    if state(j)~=mar
        state_record(end+1)=j;
        mar=state(j);
    end
end
if state_record(end)~=length(state)
    state_record(end+1)=length(state);
end
state_time=[];
for i=1:length(state_record)
    state_time(i)=time(state_record(i));
end

%%
figure(1);
hold on;
wire1_start = 0;
wire1_end = 12;
wire2_start = wire1_start;
wire2_end = wire1_end;                                                                                                                                                                             

title('刹车从0到3每次+0.02');
yyaxis left  
h1=plot(time(wire1_start:wire1_end),speed(wire1_start:wire1_end),'color','b','linestyle','-','linewidth',2);
%set(gca,'ylim',[0.35 0.7]); 
%set(gca,'yTick',0.35:0.035:0.7);
ylabel('实时速度(km/h)');
yyaxis right
h2=plot(time(wire2_start:wire2_end),acc(wire2_start:wire2_end),'color','r','linestyle','-','linewidth',2);
%set(gca,'ylim',[1 2]);
%set(gca,'yTick',1:0.1:2);
ylabel('加速度(m/s^2)');
leg=legend([h1,h2],'实时速度曲线', '实时加速度曲线');
xlabel('Time(s)');
%set(gca,'xTick',0:0.0005:0.006);
set(gca,'FontSize',30);
grid on;
%%
x=0:0.25:3;
figure(2);
hold on;
title('不同稀疏系数对可信任地标位置影响');
yyaxis left
h1=plot(x(100:end),a000,'color','b','linestyle','-','linewidth',2,'marker','o','MarkerFace','b');
set(gca,'ylim',[0.38 0.5]);
set(gca,'yTick',0.38:0.01:0.5);
ylabel('可信任地标平均位置误差(cm)');
yyaxis right
h2=plot(x,ade,'color','g','linestyle','-','linewidth',2,'marker','^','MarkerFace','g');
set(gca,'ylim',[0.38 0.5]);
set(gca,'yTick',0.38:0.01:0.5);
ylabel('平均定位误差(cm)');
leg=legend([h1,h2],'稀疏系数-可信任地标平均位置误差','稀疏系数-平均定位误差');
leg.FontSize=24;
xlabel('稀疏系数');
set(gca,'xlim',[0 3]);
set(gca,'xTick',0:0.25:3);
set(gca,'FontSize',20);
grid on;
%%
x=0.04:0.02:0.2;
figure(3);
hold on;
title('不同动态收紧吸收阈值初值对实验效果影响');
yyaxis left
h1=plot(x,a000,'color','b','linestyle','-','linewidth',2,'marker','o','MarkerFace','b');
%h2=plot(x,a001,'color','b','linestyle','-','linewidth',1,'marker','none');
% h3=plot(x,a002,'color','g','linestyle','-','linewidth',1,'marker','none');
% h4=plot(x,a003,'color','y','linestyle','-','linewidth',1,'marker','none');
% h5=plot(x,a004,'color','c','linestyle','-','linewidth',1,'marker','none');
set(gca,'ylim',[0.3 0.8]);
set(gca,'yTick',0.3:0.05:0.8);
ylabel('可信任地标平均位置误差(cm)');
yyaxis right
h2=plot(x,am000,'color','r','linestyle','-','linewidth',2,'marker','x','MarkerFace','r');
%plot(x,am001,'color','b','linestyle','--','linewidth',2,'marker','none');
% plot(x,am002,'color','g','linestyle','--','linewidth',2,'marker','none');
% plot(x,am003,'color','y','linestyle','--','linewidth',2,'marker','none');
% plot(x,am004,'color','c','linestyle','--','linewidth',2,'marker','none');
%plot(x,am005,'color','k','linestyle','--','linewidth',2,'marker','none');
set(gca,'ylim',[1 5]);
set(gca,'yTick',1:0.5:5);
ylabel('可信任地标最大位置误差(cm)');
leg=legend([h1,h2],'动态收紧吸收阈值初值-可信任地标平均位置误差', '动态收紧吸收阈值初值-可信任地标最大位置误差');
leg.FontSize=24;
xlabel('动态收紧吸收阈值初值(m)');
set(gca,'xTick',0.04:0.02:0.2);
set(gca,'FontSize',20);
grid on;
%%
x=0.2:0.05:0.6;
figure(2);
hold on;
title('不同淘汰权重阈值对实验效果影响');
yyaxis left
h1=plot(x,a000,'color','b','linestyle','-','linewidth',2,'marker','o','MarkerFace','b');
% set(gca,'ylim',[0.38 0.5]);
% set(gca,'yTick',0.38:0.01:0.5);
ylabel('可信任地标平均位置误差(cm)');
yyaxis right
h2=plot(x,ade,'color','g','linestyle','-','linewidth',2,'marker','^','MarkerFace','g');
% set(gca,'ylim',[0.38 0.5]);
% set(gca,'yTick',0.38:0.01:0.5);
ylabel('平均定位误差(cm)');
leg=legend([h1,h2],'淘汰权重阈值-可信任地标平均位置误差','淘汰权重阈值-平均定位误差');
leg.FontSize=24;
xlabel('淘汰权重阈值');
set(gca,'xlim',[0.2 0.6]);
set(gca,'xTick',0.2:0.05:0.6);
set(gca,'FontSize',20);
grid on;
%%
clc;
clear;
close all;
load('多条件对比3.mat');
clear_fail=0;
start=1;
while clear_fail~=1
    l=length(record_num450);
    for i=start:l
        if  record_num450(i).max_theory_de>0.04 | isempty(fieldnames(record_num450(i)))
            record_num450(i)=[];
            strt=i;
            break;
        end
    end
    if i>=l
        clear_fail=1;
    end
end
l=0;
for i=1:length(record_num450)
    if ~isempty(record_num450(i).max_theory_de)
        l=l+1;
    end
end
table.success=l/30+0.1;
table.ave_theory_de=sum([record_num450.ave_theory_de])/l;
table.ave_theory_ae=rad2deg(sum([record_num450.ave_theory_ae])/l);
% table.max_theory_de=sum([record_num450.max_theory_de])/l;
% table.max_theory_ae=sum([record_num450.max_theory_ae])/l;
table.ave_particle_de=sum([record_num450.ave_particle_de])/l;
table.ave_d=sum([record_num450.ave_d])/l;
table.time=sum([record_num450.time])/l;