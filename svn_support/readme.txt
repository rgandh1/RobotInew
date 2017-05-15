This folder contains the general svnautocommit.sh script to commit the robotworkspaces content to the SVN repository.
Please be aware that the SVN repository's function in context of ROBOT Team Development essentially differs from the context of general JAVA Team Development.
Interpreting the repo's meaning for the robotworkspace in the same way as the repo's meaning for any Java project will lead to lots of troubles/conflicts.
Therefore the following diagramms should clearly depict the way how SVN has to be used for storing the robotworkspace. 


1. JAVA Team Development
   ======================

                    R/W               R/O
   -------------         ----------       -----------------------
   | Eclipse 1 | <-----> |        | ----> |     BuildServer     |
   -------------         |        |       -----------------------
   -------------         |        |       -----------------------
   | Eclipse 2 | <-----> |        | ----> | StatisticsGenerator |
   -------------         |  REPO  |       -----------------------
        .                |        |                  .
        .                |        |                  .
        .                |        |                  .
   -------------         |        |       -----------------------
   | Eclipse n | <-----> |        | ----> |       ?????         |
   -------------         ----------       -----------------------

   Repo's main funktionalities:
     1. Backup
     2. History of changes
     3. Merging changes done by different team members on different hosts
     4. Postprocessing/Deployment


2a. ROBOT Team Development - MISSINTERPRETED
    ========================================

                    R/W               R/O
    -------------         ----------  
    |   RIDE 1  | <-----> |        |  
    -------------         |        |  
    -------------         |        | 
    |   RIDE 2  | <-----> |        |        -----------------------
    -------------         |  REPO  | -----> |   AutomationServer  |
         .                |        |        -----------------------  
         .                |        |  
         .                |        |  
    -------------         |        |  
    |   RIDE n  | <-----> |        |  
    -------------         ----------   

    Repo's main funktionalities:
      1. Backup
      2. History of changes
      3. Merging changes done by different team members on different hosts
      4. Postprocessing/Deployment


2b. ROBOT Team Development - CORRECT
    ================================

                         R/W                      R/W
    ------------------         ----------------         ----------
    | WINSCP/RIDE    | <-----> |              |         |        |
    ------------------         |              |         |        |  
    ------------------         |              |         |        | 
    | WINSCP/NOTEPAD | <-----> |              |         |        |
    ------------------         |  Automation  | <-----> |  REPO  |
            .                  |  Server      |         |        |
            .                  |              |         |        |  
            .                  |              |         |        |  
    ------------------         |              |         |        |  
    | WINSCP/...     | <-----> |              |         |        |  
    ------------------         ----------------         ---------- 
  
    Repo's main funktionalities:
      1. Backup
      2. History

    There is no necessity for merging changes of different hosts directly into the repository, since the changes MUST be done on the AutomationServer ONLY.
    There is also no need to deploy the repo's content to any other host - the AutomationServer is DevelopmentServer and ProductionServer all in one.
    Reading the repo's content (svn update) is only needed in less frequent cases where some changes on the AutomationServer have to be reverted.
    
    
