% optimal_wing_para_motion
%% ��һ���֡���������Լ���߽�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (1) ��򳤶Ⱥ�չ�ұȡ���R_wingeff,C_avereff��AR
% R_wingeff=3.004;      % ��Ч��򳤶�(mm)  
% C_avereff=0.8854;     % mm
% (2) ���Կ�����֪չ�ұ�, ������������ŵĳ���ò
% AR=R_wingeff/C_avereff;     %aspect ratio: AR=R^2/A_w;  �������Ϊ: AR=3.40158;  % Science������: AR=3.1519;
% C_avereff=R_wingeff/AR;     %mean chord length: C_aver=A_w/R=R^2/AR/R=R/AR; % C_aver=0.884mm;
% A_w=R_wingeff^2/AR;        %Area of wing: �������Ϊ: A_w=2.66mm^2;   %RJ Wood��Ƶĳ��: A_w=2.84345 mm^2 
% (3) �����ƫ����롪��xr
% xr=0.3289;                     % x-root offset  \mm
% xr_nd=xr/R_wingeff;      % x-root offset  ������չ��ƫ�þ���
% (4) Ťת���λ�á���C_maxy
% C_max_LtoT=C_lead_ymax-C_trail_ymin;       % C_max_LtoT =1.3018;
% x_0lb=0*C_max_LtoT;                                    % x_0lb=0;
% x_025=0.25*C_max_LtoT;                              % x_025=0.3255;
% x_0ub=0.5*C_max_LtoT;                                % x_0ub=0.6509;
% C_lead_ymax=max(f_x_lead2); % ���: C_lead_ymax=0.4644; k_leadmax=644;%ԭʼ��Ӭ���@���ǰԵ�㵽���������ߵľ���;@C_maxy=0;
% % C_maxylb =0.464385778290230;
% C_maxy25 =0.138924474377504;  % ��Գ���wing_model_88_yaxis��: ��122��; C_maxy =0.1389; 
% C_maxyub =-0.186536829535222; 
% C_maxy=C_maxylb;
% C_maxy=C_maxy25;
% C_maxy=C_maxyub;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% variable=[R_wingeff,C_avereff,xr,C_maxy];        % ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (5) ������Լ���߽硪�����������������R_wingeff, C_avereff, xr��x_0(Ťת��ǰԵ���ֵ��ľ���)
% nvars = 4;         % Number of variables 
% R_wingeff��[2,4]*10^(-3);
% C_avereff��[0.5,2]*10^(-3);
% xr��[0,2]*10^(-3);
%%%%%%%%%%%%%%%%%%%%%%%%%
% x_0��[0,0.5];  % Ťת���ǰԵ�������پ��롪��% ԭʼ��Ӭ��� R_wing=3.004;  C_aver=0.8854; 
% C_maxylb =0.464385778290230;                   % C_maxylb=0.4644;
% C_maxy25 =0.138924474377504;                  % C_maxy25=0.1389; 
% C_maxyub =-0.186536829535222;                % C_maxyub=-0.1865
%%%%%%%%%%%%%%%%%%%%%%%%%
% % variable=[R_wingeff,C_avereff,xr,C_maxy,f,phi_m,K,eta_m,C_eta,Phi_eta,eta_0];     % ����
% % f��[0,inf];  phi_m��[0,pi/2];  K��[0,1]; % eta_m��[0,pi]; C_eta��[0,inf];  Phi_eta��[-pi,pi]; eta_0��[eta_m-pi,pi-eta_m];
% eta_m=x(8);
% eta_0min=eta_m-pi;
% eta_0max=pi-eta_m;
% LB = [2, 0.5, 0, 0,0,0,0,0,0,-pi,eta_0min];            % Lower bound       % ��λ: mm & Ťת���ǰԵ�������پ���[0,0.5]
% UB = [4, 2, 2, 0.5,inf,pi/2,1,pi,inf,pi,eta_0max];   % Upper bound      % ��λ: mm & Ťת���ǰԵ�������پ���[0,0.5]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% �ڶ����֡���Ŀ�꺯�����������Բ���ʽԼ��-Hybrid-GA�Ż�
tic
% matlabpool open 12
% matlabpool open local1 12
ObjectiveFunction=@flight_range_opt_obj_function;  % fitness and constraint functions��������Ŀ�꺯��
nvars=10;   % Number of variables 
% % variable=[R_wingeff,C_avereff,xr,C_maxy,f,phi_m,K,eta_m,C_eta,Phi_eta,eta_0];     % ����
% % f��[0,inf];  phi_m��[0,pi/2];  K��[0,1]; % eta_m��[0,pi]; C_eta��[0,inf];  Phi_eta��[-pi,pi]; eta_0��[eta_m-pi,pi-eta_m];
% eta_m=x(8);
% eta_0min=eta_m-pi;
% eta_0max=pi-eta_m;
% LB = [2, 0.5, 0, 0,0,0,0,0,0,-pi,eta_0min];            % Lower bound       % ��λ: mm & Ťת���ǰԵ�������پ���[0,0.5]
% UB = [4, 2, 2, 0.5,inf,pi/2,1,pi,inf,pi,eta_0max];   % Upper bound      % ��λ: mm & Ťת���ǰԵ�������پ���[0,0.5]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% �������֡���nonlinear inequality constraints�������÷����Բ���ʽԼ��
% X_AspR=[R_wingeff,C_avereff,xr];               % AR=(R_wingeff+xr)/C_avereff; % AR��[2.5,3.5]
% ConstraintFunction=@aspectratio_constraint;  % ����չ�ұȶԱ���������Լ��
% NonLConstraint=@NonL_constraint;                    % ����Re��ŵ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ���Ĳ��֡�������Ŵ��㷨(Hybrid Function)-GA+fminsearch
% ԭʼ��Ӭ��� R_wing=3.004;  C_aver=0.8854;   
% C_lead_ymax =0.4644;  C_trail_ymin =-0.8374;  C_max_LtoT = 1.3018; @C_maxy=0;
% Ratio_leadmax=C_lead_ymax/C_max_LtoT; %Ratio_leadmax=0.4644/1.3018=0.356737; %��Գ���ͳ�����ߵ�Ťת�ᶨ����ǰԵ
% x_start=[3.004,0.8854,0.3289,0.356737]; % ��ʼֵ. % δ�Ż��Ĺ�Ӭ�����ò������������ͳ�����ߵ�Ťת�ᶨ����ǰԵ
% C_lead_ymax =0.3255;  C_trail_ymin =-0.9764;  C_max_LtoT =1.3018;
% Ratio_leadmax=C_lead_ymax/C_max_LtoT; %Ratio_leadmax=0.3255/1.3018=0.25;%���Ťת��λ�����ǰԵ������º�Ե��������0.25��ʱ
% x_start=[3.004,0.8854,0.3289,0.25];     % ��ʼֵ. % δ�Ż��Ĺ�Ӭ�����ò��������Ťת��λ�����ǰԵ������º�Ե��������0.25��ʱ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (1) �����Ŵ��㷨��С���Ż�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% options = gaoptimset('InitialPopulation',x_start);  % (1)�������С������Ĵμ���(1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% options = gaoptimset('PlotFcns',{@gaplotbestf,@gaplotmaxconstr},'Display','iter');  % (2)��������
% options = gaoptimset(options,'InitialPopulation',x_start,'TimeLimit',14400);  % (2)�������С������Ĵμ���(2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (2) ����Ŵ��㷨(Hybrid Function)-GA+fminsearch
% % �Զ���fminsearch��ת��fmincon�����������С���������á������Ĵμ���(3)
% options = gaoptimset('InitialPopulation',x_start,'TimeLimit',10800,'PlotFcns',{@gaplotbestf,@gaplotmaxconstr});
% % fminsearchOptions = optimset('algorithm','Nelder-Mead simplex direct search');
% % options=gaoptimset(options,'HybridFcn',{@fminsearch,x_start, fminsearchOptions}); 
% fminsearchOptions=optimset('Display','iter'); % fminsearch������Լ�������������С��
% options=gaoptimset(options,'HybridFcn',{@fminsearch,fminsearchOptions}); % fminsearch������Լ�������������С��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ����fminsearch�ֲ���������������
% options=gaoptimset('PopulationSize',200,'InitialPopulation',[],'TimeLimit',10800,'PlotFcns',{@gaplotbestf,@gaplotmaxconstr});
% options=gaoptimset('PopulationSize',100,'InitialPopulation',x_start,'TimeLimit',10800,'PlotFcns',{@gaplotbestf,@gaplotmaxconstr}); %����
% fminsearchoptions = optimset('Display','iter','TolCon',1e-10);% fminsearch������Լ�������������С�� %����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% options=gaoptimset('PopulationSize',100,'PlotFcns',{@gaplotbestf,@gaplotmaxconstr},'UseParallel','always');%���м��㡪������
% fminsearchoptions = optimset('Display','iter','TolCon',1e-10,'TolFun',1e-6,'UseParallel','always');%fminsearch����Լ�������������С�� %���м��㡪������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ����1���������ó�ʼֵ
% x=[45.4147,1.5696,1.8489,1.0385,-0.9685,-0.0463,3.5193,1.8689,1.3038,-0.0008]; % ��ʼ��Ⱥ1
% P_asterisk =6.9607;     L =1.0002;   delta =1.6715e-004;   penaltyfun1 =0.3343; 
% penaltyfun2 =4.5714;   AR =2.5807;   Re =126.7144;     penaltyfun5 =0;
% x=[45.4271,1.5679,1.8515,1.0364,-0.9666,-0.0470,3.5258,1.8657,1.3081,0.0122];  % ��ʼ��Ⱥ2
% P_asterisk =7.0267;   L =1.0000; delta =2.6792e-005;   penaltyfun1 =0.0536;
% penaltyfun2 =0;    AR =2.5909;   Re =126.6284;    penaltyfun5 =0;
% final_pop=x;  % options = gaoptimset('InitialPop', final_pop);
% options=gaoptimset('InitialPop', final_pop,'Display','iter','PopulationSize',100,'Generations',300,... 
% options=gaoptimset('Display','iter','PopulationSize',100,'Generations',200,...   % �ظ�����������������=200�޸�Ϊ����=5+10
%     'PlotFcns',{@gaplotbestf,@gaplotexpectation,@gaplotstopping,@gaplotbestindiv,@gaplotscores,@gaplotrange},...
%     'TolCon',1e-15,'TolFun',1e-15,'UseParallel','always'); %���м��㡪������
% ����2�������ó�ʼֵ
% % x_start=[2.5088,1.1424,0.7124,0.0458,108.5082,1.7828,3.0150,0.7854,1.0431,0.6109,0.0749];
% x_start=[3.1935,1.6054,2.1531,0.5000,1.2853,0.8770,0.6763,0.1370,1.5444,-2.0757,0.2672]; %20150315-hybrid_GA_fminsearch_WingM4_3-11����-���
% x_start=[1.1986111e+001,1.1832898e+0,1.0145707e+0,1.5707871e+0,4.9669778e+0, -1.2147904e+0,1.7114795e+001,9.1570992e+0,1.6498166e+001,3.5672155e-001];
% x_start=[1.3207146e+001,1.3089915,1.0145799,1.5707963e+0,4.8164265, -1.1674332,1.7437222e+001,6.3959039,1.4542260e+001,3.5661793e-001];
x_start=[12,57.5*pi/180,0.0001,45*pi/180,2.357,-pi/2,70,29.31,15,0.356737];
options=gaoptimset('Display','iter','PopulationSize',100,'Generations',200,...
'InitialPopulation',x_start,'PlotFcns',{@gaplotbestf,@gaplotexpectation,@gaplotstopping,@gaplotbestindiv,@gaplotscores,@gaplotrange},...
'TolCon',1e-15,'TolFun',1e-15,'UseParallel','always'); %���м��㡪������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fminsearchoptions =
% optimset('Display','iter','MaxFunEvals',14000,'TolCon',1e-10,'TolFun',1e-15,'UseParallel','always'); % ����feasible
fminsearchoptions=optimset('Display','iter-detailed','MaxFunEvals',2000,'MaxIter',2000,'TolX',1e-15,'TolFun',1e-15,'UseParallel','always'); % ��ʼ����1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fminsearch����Find minimum of unconstrained multivariable function using derivative-free method
options =gaoptimset(options,'Hybridfcn',{@fminsearch,fminsearchoptions}); % Ѱ����Լ���������Сֵ��������ȡ
% [x,fval,exitflag,output,population,scores]=ga(ObjectiveFunction,nvars,[],[],[],[],[],[],NonLConstraint,options)% ��������ȡ
[x,fval,exitflag,output,population,scores]=ga(ObjectiveFunction,nvars,[],[],[],[],[],[],[],options)
% matlabpool close
matlabpool close force local1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R_wing=x(7);   % mm
C_aver=x(8);    % mm
xr0=x(9);
R_wing1=R_wing*10^-3;  %   R_wing=3.004*10^-3;            % m
C_aver1=C_aver*10^-3;   %  C_aver=0.8854*10^-3;            % m
xr01= xr0*10^-3; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%
f=x(1);               % f=188.7;                  % Hz  
phi_aver=x(2);   % phi_aver = 1.1488;  % rad   % phi_aver*180/pi  % ans =65.8189;
PHI=2*phi_aver;
nu=1.48*10^-5;      % �����˶�ճ�� m^2/s
%%%%%%%%%%%%%%%%%%%%%%%%%%%
AR=(R_wing1+ xr01)/C_aver1
Re=(2*PHI*R_wing1*f*C_aver1)/(nu)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
optimal_variablex=x;
object_value=fval;
save('result_x.txt', 'optimal_variablex', '-ASCII')
save('result_fval.txt', 'object_value', '-ASCII')
output_1=[population,scores];
% xlswrite('D:\cal_result\WingM7_1_10variable_group_flight_range\population_scores.xlsx',output_1,'sheet1','A1:K100');
xlswrite('population_scores.xlsx',output_1,'sheet1','A1:K100');
elapsedTime =toc/3600;  
disp(['Caculation finished and the elapsedTime= ' num2str(elapsedTime ,'%5.4f') 'hours'])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%% �������֡���Ŀ�꺯���������߽硢���Ե�ʽ�ͷ����Բ���ʽԼ��-Hybrid-GA�Ż�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ����fminunc�ֲ���������������
% options = gaoptimset('InitialPopulation',x_start,'TimeLimit',14400,'PlotFcns', {@gaplotbestf,@gaplotstopping});
% fminuncOptions=optimset('Display','iter', 'LargeScale','off'); % fminunc������Լ�������������С��
% options=gaoptimset(options,'HybridFcn',{@fminunc, fminuncOptions});  % fminunc������Լ�������������С��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ����fmincon�ֲ������������С�������ܺá������Ĵμ���(4)
tic
matlabpool open 8
ObjectiveFunction=@morphology_para_opt_obj_function2;  % fitness and constraint functions��������Ŀ�꺯��
nvars=11;   % Number of variables 
LB =[150, 0, -pi, -pi/4, 0, -pi,-pi/4, 2, 0.5, 0, 0];              % Lower bound   % 11������
UB=[260, pi/2, pi, pi/4, pi/2, pi, pi/4, 4, 2, 2, 0.5];          % Upper bound   % 11������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% �������֡���nonlinear inequality constraints�������÷����Բ���ʽԼ��
% X_AspR=[R_wingeff,C_avereff,xr];               % AR=(R_wingeff+xr)/C_avereff; % AR��[2.5,3.5]
% ConstraintFunction=@aspectratio_constraint;  % ����չ�ұȶԱ���������Լ��
NonLConstraint=@NonL_constraint;                    % ����Re��ŵ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  A=[0, 0, 0, 0, 0, 0, 0, 1, -3.5, 1, 0; ...  % for R-3.5*C_aver+xr0<=0;  % XXX
%       0, 0, 0, 0, 0, 0, 0, -1, 2.5, -1, 0];    % for -R+2.5*C_aver-xr0<=0;  % XXX
 A=[0, 0, 0, 0, 0, 0, 0, 1, -3.5, 0, 0; ...  % for R-3.5*C_aver<=0;
      0, 0, 0, 0, 0, 0, 0, -1, 2.5, 0, 0];    % for -R+2.5*C_aver<=0;
 b=[0; 0];
x_start=[188.7,1.5400,2.8107,0, 0.9935,0.0114, 0, 2.5088,1.1424,0.7124,0.0458];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options = gaoptimset('Display','iter','PopulationSize',100,'InitialPopulation',x_start,'TimeLimit',10800,...
    'PlotFcns',{@gaplotbestf,@gaplotmaxconstr,@gaplotbestindiv,@gaplotstopping},'UseParallel','always');
% fminconOptions=optimset('Display','iter','TolCon',1e-10); % fmincon������Լ�������Զ������С�������㷨��ѡ��
fminconOptions=optimset('Display','iter','TolCon',1e-15,'TolFun',1e-15); % fmincon������Լ�������Զ������С�������㷨��ѡ��
% fminconOptions=optimset('Display','iter','Algorithm','active-set'); % fmincon������Լ�������Զ������С�������㷨ѡ��
options=gaoptimset(options,'HybridFcn',{@fmincon,fminconOptions}); % fmincon������Լ�������Զ������С��
[x,fval,exitflag,output,population,scores]=ga(ObjectiveFunction,nvars,A,b,[],[],LB,UB,NonLConstraint,options)
matlabpool close
toc
%%
% output_1=[population,scores];
% xlswrite('D:\kxj\WingM5_2_10variable_group\population_scores.xlsx',output_1,'sheet1','A1:L100');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Next we run the GA solver.
% [x,fval]=ga(ObjectiveFunction,nvars,[],[],[],[],LB,UB,[],options)
% output_1=[population,scores];
% xlswrite('D:\KXJ\hybrid_GA_fminsearch_WingM4_4_2\population_scores.xlsx',output_1,'sheet1','A1:L100');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%