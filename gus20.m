%% title('刹车从3到0每次减0.02');
% 获取表单信息
time=data.VarName1;
state=data.VarName2;
theo=data.VarName3;
real=data.VarName4;
gus=data.VarName5;
brake=data.VarName6;
speed=data.VarName7;
ss=data.VarName8;
time=time/1000;
%%

% 计算加速度

acc=[];
acc(1)=0;
for i=2:length(speed)
    acc(i,:)=(speed(i)-speed(i-1))/(time(i)-time(i-1))/3.6;
end
%%
minSpeed = min(speed);
minAcc = min(acc);

minGus = min(gus);


maxSpeed = max(speed);
maxAcc = max(acc);

maxGus = max(gus)


% 记录自动驾驶状态
state_record=[];       %存储状态数组
mar=state(1);          %标记mar为状态1
state_record(1)=1;     %数组第一个为1
for j=2:length(state)  %便利状态状态列表的长度
    if state(j)~=mar   %第一次遇到的状态如果是0 ， 那么就将在状态数组末尾添加第几次循环的数。
        state_record(end+1)=j;
        mar=state(j); %同时标记该数组状态，　一直遇到状态不同的情况为止，再次进入该ＩＦ循环
    end %if 语句结束
end %for 循环结束

if state_record(end)~=length(state)   % 如果状态数组末尾的数和状态的长度不一致
    state_record(end+1)=length(state);% 那么就将状态长度添加到状态数组的最后位置
end

state_time=[]; % 记录状态的时间
for i=1:length(state_record)
    state_time(i)=time(state_record(i));
end

%%
leftYMax = 30;
leftYMin = -5;
leftXMin = 6;
leftXMax = 18;

block_start=313;
block=889;
%%
figure(1);
ax=gca;
ax.XAxis.MinorTick='on';
ax.XAxis.MinorTickValues=0:2:56;  % 绘制 有数的刻度之间的小刻度， 其中绘制区间是0-20 每隔0.2绘制一个
%set(gca,'XMinorTick','on');
%set(gca,'ticklength',[0.1 1]);
set(gca,'xlim',[leftXMin leftXMax]);   % 设置横坐标区间0到12
set(gca,'ylim',[leftYMin leftYMax]); % 设置纵坐标区间-20到8

%plot 是绘图， 第一个参数time是横坐标， 第二个参数是纵坐标
%，其中time的（）里第一个是time数组指定索引的位置，第二个是结束索引的位置，第二个也是这样，'b'是颜色，有'r' ,'g','b'等选择
% linewidth 是线段的宽度，设置为1 ,marker 画出的图像关键点用的圆圈， 而MarkerIndices是指定间隔数组显示一个关键点
% 1:10 表示的是每隔10个数组就显示一个关键数据点
h1=plot(time(block_start:block),acc(block_start:block),'b','linewidth',2,'marker','o','MarkerIndices',1:10:block);
hold on; % 继续在原图上回执图线
h2=plot(time(block_start:block),speed(block_start:block),'r','linewidth',2,'marker','o','MarkerIndices',1:10:block);

yyaxis right 

h3=plot(time(block_start:block),gus(block_start:block),'g','linewidth',2,'marker','o','MarkerIndices',1:10:block);
ylabel('油门(%)');   % 纵坐标标签
set(gca,'ylim',[0 maxGus+5]); % 设置纵坐标区间-20到8
yyaxis left 

if state(1)==0 % 如果一开始状态为0，即为非自动驾驶状态 ，start 就等于2
    start=2;
else 
    start=1;  % 表示 是自动驾驶状态
end
% for k=start:2:length(state_time)-1
%     patch([state_time(k),state_time(k+1),state_time(k+1),state_time(k)],...
%         [0,0,-800,-800],'g','EdgeColor','w');
%     alpha(0.3);
% end 


ax=gca;
ax.XAxis.MinorTick='on';
xx = ((leftXMax - leftXMin)/100)-0.06;
ax.XAxis.MinorTickValues=leftXMin:xx:leftXMax;  % 绘制 有数的刻度之间的小刻度， 其中绘制区间是0-20 每隔0.2绘制一个
%set(gca,'XMinorTick','on');
%set(gca,'ticklength',[0.1 1]);
set(gca,'xlim',[leftXMin leftXMax]);   % 设置横坐标区间0到12
set(gca,'ylim',[leftYMin leftYMax]); % 设置纵坐标区间-20到8
ylabel('实时速度(km/s) (加速度m/s^2)');   % 纵坐标标签
xlabel('Time(s)');% 时间
set(gca,'FontSize',30); % 设置字体大小
%grid on;
legend([h1,h2,h3],'加速度', '速度','油门百分比'); 
title('20油门加速');