%% use data of U.S.
clear;
clc;

[datapart3]=xlsread("datapart3",2);
datapart3(any(isnan(datapart3)'),:)=[];

[clicks]=datapart3(1:end-1,1:10);
[dj]=datapart3(:,11:20);
[salary]=datapart3(1:end-1,21:30);
[factor]=datapart3(2:end,31:36);
[rmrf]=factor(:,1);
[smb]=factor(:,2);
[hml]=factor(:,3);
T_dj=size(dj,1);
%calculate the return for each day
retdj=[];
for i=2:T_dj
    retdj(i-1,:)=dj(i,:)./dj(i-1,:)-1;
end
retdj=retdj*100;
[tstat]=[];
[beta]=[];
[rsquared]=[];
for i=1:272
    lm_i=fitlm([log(clicks(i,:))',log(salary(i,:))'],retdj(i,:)');
    beta(i,:)=lm_i.Coefficients.Estimate';
    tstat(i,:)=lm_i.Coefficients.tStat';
    rsquared(i,:)=lm_i.Rsquared.Ordinary;
end
[alpha]=[];
[tstatnew]=[];
[rsquarednew]=[];
for i=1:10
    lm_i=fitlm([beta(:,2:3),rmrf,smb,hml],retdj(:,i));
    alpha(i,:)=lm_i.Coefficients.Estimate';
    tstatnew(i,:)=lm_i.Coefficients.tStat';
    rsquarednew(i,:)=lm_i.Rsquared.Ordinary;
end
covar=cov([log(clicks(:,1)),log(salary(:,1))]);

%% use data of North Amercia to tes the robustness
clear;
clc;

[datapart3]=xlsread("datapart3",4);
datapart3(any(isnan(datapart3)'),:)=[];

[clicks]=datapart3(1:end-1,1:10);
[dj]=datapart3(:,11:20);
[salary]=datapart3(1:end-1,21:30);
[factor]=datapart3(2:end,31:33);
[rmrf]=factor(:,1);
[smb]=factor(:,2);
[hml]=factor(:,3);
T_dj=size(dj,1);
%calculate the return for each day
retdj=[];
for i=2:T_dj
    retdj(i-1,:)=dj(i,:)./dj(i-1,:)-1;
end
retdj=retdj*100;
[tstat]=[];
[beta]=[];
[rsquared]=[];
for i=1:272
    lm_i=fitlm([log(clicks(i,:))',log(salary(i,:))'],retdj(i,:)');
    beta(i,:)=lm_i.Coefficients.Estimate';
    tstat(i,:)=lm_i.Coefficients.tStat';
    rsquared(i,:)=lm_i.Rsquared.Ordinary;
end
[alpha]=[];
[tstatnew]=[];
[rsquarednew]=[];
for i=1:10
    lm_i=fitlm([beta(:,2:3),rmrf,smb,hml],retdj(:,i));
    alpha(i,:)=lm_i.Coefficients.Estimate';
    tstatnew(i,:)=lm_i.Coefficients.tStat';
    rsquarednew(i,:)=lm_i.Rsquared.Ordinary;
end