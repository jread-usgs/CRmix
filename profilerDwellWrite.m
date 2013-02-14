function profilerDwellWrite


clc
close all
fileInput = '2011\2011CrystalLake_SondeTable.dat';
varN   = 'doobs';
numRmv = 16;
fileOut   = ['Data/Crystal_1m_2011.' varN];

rootFolder = [getenv('USERPROFILE') '\Desktop\CRmix\Data\'];
delim  = ',';
sonVar = '%s %f %f %f %f %f %f %f %f';
varI = 7;
zI   = 3;
zInt = 1;
zOff = 0.5;

%% loop through vars

fID = fopen([rootFolder fileInput]);
heads= textscan(fID,'%s',(length(sonVar)+1)/3,...
    'HeaderLines',1,'Delimiter',delim);

heads{1} = regexprep(heads{1}, '"', '');
disp(['pivoting and writing ' heads{1}{varI} ' to ' fileOut]);
data = textscan(fID,sonVar,'HeaderLines',4,...
    'Delimiter',delim,'treatAsEmpty','"NAN"');
if strcmp(data{1}(end),'')
    data{1} = data{1}(1:end-1);
end
datesC = regexprep(data{1}, '"', '');
dates = datenum(datesC,'yyyy-mm-dd HH:MM');

[timeO,varO] = profilerToSurface(dates,data{zI},data{varI},zInt,zOff,numRmv);

plot(timeO,varO); pause(1)
gFileSave(fileOut,timeO, varO, varN, 1,'overwrite')

end

