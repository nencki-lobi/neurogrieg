% List of open inputs
% fMRI model specification: Directory - cfg_files
% fMRI model specification: Scans - cfg_files
% fMRI model specification: Multiple conditions - cfg_files
% fMRI model specification: Multiple regressors - cfg_files
% fMRI model specification: Scans - cfg_files
% fMRI model specification: Multiple conditions - cfg_files
% fMRI model specification: Multiple regressors - cfg_files
% fMRI model specification: Scans - cfg_files
% fMRI model specification: Multiple conditions - cfg_files
% fMRI model specification: Multiple regressors - cfg_files

workdir = pwd;
basedir = fullfile(pwd, 'neurogrieg'); % git repo location
datadir = fullfile(pwd, 'ds-ngr/bids/derivatives'); % fmriprep dataset location
resdir = fullfile(pwd, 'ds-ngr/bids/results'); % output location

D = dir(fullfile(datadir,'sub-*'));
D = D([D.isdir]);

subjects = {D.name};
nrun = numel(subjects); % enter the number of runs here

jobfile = {fullfile(basedir, 'code/first-level/batch_stories_job.m')};

jobs = repmat(jobfile, 1, nrun);
inputs = cell(10, nrun);

for crun = 1:nrun

    sub = subjects{crun};

    mkdir(fullfile(resdir, sub, 'stories-model'))

    bold = 'space-MNI152NLin2009cAsym_desc-preproc_bold';

    inputs{1, crun} = {fullfile(resdir, sub, 'stories-model')}; % fMRI model specification: Directory - cfg_files
    
    inputs{2, crun} = {fullfile(datadir, sub, 'func', ['s6', sub, '_task-stories_run-01_', bold, '.nii'])}; % fMRI model specification: Scans - cfg_files
    inputs{3, crun} = {fullfile(basedir, 'code/first-level/multiple-conditions-stories', 'multiple-conditions-stories-R1.mat')}; % fMRI model specification: Multiple conditions - cfg_files
    inputs{4, crun} = {fullfile(resdir, sub, 'stats', [sub, '_task-stories_run-01_confounds.mat'])}; % fMRI model specification: Multiple regressors - cfg_files
    
    inputs{5, crun} = {fullfile(datadir, sub, 'func', ['s6', sub, '_task-stories_run-02_', bold, '.nii'])}; % fMRI model specification: Scans - cfg_files
    inputs{6, crun} = {fullfile(basedir, 'code/first-level/multiple-conditions-stories', 'multiple-conditions-stories-R2.mat')}; % fMRI model specification: Multiple conditions - cfg_files
    inputs{7, crun} = {fullfile(resdir, sub, 'stats', [sub, '_task-stories_run-02_confounds.mat'])}; % fMRI model specification: Multiple regressors - cfg_files
    
    inputs{8, crun} = {fullfile(datadir, sub, 'func', ['s6', sub, '_task-stories_run-03_', bold, '.nii'])}; % fMRI model specification: Scans - cfg_files
    inputs{9, crun} = {fullfile(basedir, 'code/first-level/multiple-conditions-stories', 'multiple-conditions-stories-R3.mat')}; % fMRI model specification: Multiple conditions - cfg_files
    inputs{10, crun} = {fullfile(resdir, sub, 'stats', [sub, '_task-stories_run-03_confounds.mat'])}; % fMRI model specification: Multiple regressors - cfg_files
end

spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});

cd(workdir)
clearvars -except workdir subjects inputs
