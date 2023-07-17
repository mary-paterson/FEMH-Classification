parentDir='';
dataDir='TestSpecs';

imgsTest = imageDatastore(fullfile(parentDir,dataDir),...
    'IncludeSubfolders',true,...
    'LabelSource','foldernames');

[YPred,probs] = classify(trainedGN,imgsTest);
accuracy = mean(YPred==imgsTest.Labels);
disp(['GoogLeNet Accuracy: ',num2str(100*accuracy),'%'])

cm = confusionchart(imgsTest.Labels,YPred);

spec = (sum((YPred == 'Normal') & (imgsTest.Labels == 'Normal')))/sum(imgsTest.Labels == 'Normal');

sens = (sum((YPred ~= 'Normal') & (imgsTest.Labels ~= 'Normal')))/sum(imgsTest.Labels ~= 'Normal');

r_cancer = (sum((YPred == 'Cancer') & (imgsTest.Labels == 'Cancer')))/sum(imgsTest.Labels == 'Cancer');
r_phono = (sum((YPred == 'Phonotrauma') & (imgsTest.Labels == 'Phonotrauma')))/sum(imgsTest.Labels == 'Phonotrauma');
r_palsy = (sum((YPred == 'Vocal palsy') & (imgsTest.Labels == 'Vocal palsy')))/sum(imgsTest.Labels == 'Vocal palsy');

uar = (r_cancer+r_phono+r_palsy)/3;

disp(['GoogLeNet Sensitivity: ',num2str(100*sens),'%'])
disp(['GoogLeNet Specificity: ',num2str(100*spec),'%'])
disp(['GoogLeNet UAR: ',num2str(100*uar),'%'])