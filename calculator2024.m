%##########################################################################
%###################-FSG SCORE CALCULATOR 2024-############################
%##########################################################################
close all
clearvars
clc
%% ========================================================================
%-----------------------MENU FOR EVENT GROUP-------------------------------
%--------------------------------------------------------------------------
disp('FSG2024 Score Calculator')

msg = "Choose type of test";
options = ["Manual (M)" "Driverless (DV)" "Driverless Cup (DC)"];
eventGroupChoice = menu(msg,options);

mEventGroup             = 1;
dvEventGroup            = 2;
dcEventGroup            = 3;
%% ========================================================================
%-----------------------MENU FOR MANUAL EVENTS-----------------------------
%--------------------------------------------------------------------------
if eventGroupChoice == mEventGroup
    disp('FSG2024 Score Calculator')

    msg = "Choose type of test";
    options = ["Skidpad" "Acceleration" "Autocross" "xxx" "xxx"];
    eventChoice = menu(msg,options);

    eventMSkidpad         = 1;
    eventMAccel           = 2;
    eventMAutocross       = 3;
    xxx                   = 4;
    xxx                   = 5;
end
%% ========================================================================
%------------------------MENU FOR DV EVENTS--------------------------------
%--------------------------------------------------------------------------
if eventGroupChoice == dvEventGroup
    disp('FSG2024 Score Calculator')

    msg = "Choose type of test";
    options = ["Skidpad" "Acceleration" "xxx" "xxx" "xxx"];
    eventChoice = menu(msg,options);

    eventDVSkidpad            = 1;
    eventDVAccel              = 2;
    xxx                       = 3;
    xxx                       = 4;
    xxx                       = 5;
end
%% ========================================================================
%---------------------------MENU FOR DC EVENTS-----------------------------
%--------------------------------------------------------------------------
if eventGroupChoice == dcEventGroup
    disp('FSG2024 Score Calculator')

    msg = "Choose type of test";
    options = ["Skidpad" "Acceleration" "xxx" "xxx" "xxx"];
    eventChoice = menu(msg,options);

    eventDCSkidpad               = 1;
    eventDCAccel                 = 2;
    xxx                          = 3;
    xxx                          = 4;
    xxx                          = 5;
end
%% ========================================================================
%--------------GUI USERINPUT FOR MANUAL- AND DC EVENTS---------------------
%--------------------------------------------------------------------------
if eventGroupChoice ~= dvEventGroup
   prompt = {'Enter your time: ', 'Enter best time of event: ',...
       'Enter how many DOO´s', 'Enter how many OC´s', 'Enter how many USS´s',...
       'Enter how many DOO´s the best team got', 'Enter how many OC´s the best team got'};
   dlgtitle = 'Event input';
   fieldsize = [1 45; 1 45; 1 45; 1 45; 1 45; 1 45; 1 45;];
   defaultinput = {'','','0','0','0','0','0'};
    
   userInput = inputdlg(prompt,dlgtitle,fieldsize,defaultinput);
    
   yourTeamTime = str2double(userInput{1});
    
   bestTeamTime = str2double(userInput{2});

   penaltyDOO = str2double(userInput{3});

   penaltyOC = str2double(userInput{4});

   penaltyUSS = str2double(userInput{5});

   bestTeamPenaltyDOO = str2double(userInput{6});

   bestTeamPenaltyOC = str2double(userInput{7});
%% ========================================================================
%------------------GUI USERINPUT FOR DV EVENTS-----------------------------
%--------------------------------------------------------------------------
elseif eventGroupChoice == dvEventGroup
    prompt = {'Enter your team´s best time (without penalties)', 'Enter your team´s ranking: ',...
            'Enter number of team´s who finished atleast one DV run without DNF or DQ: '};
    dlgtitle = 'Event input';
    fieldsize = [1 45; 1 45; 1 45;];
    defaultinput = {'','', ''};
    
    userInput = inputdlg(prompt,dlgtitle,fieldsize,defaultinput);

    yourTeamTime = str2double(userInput{1});
    
    yourTeamRanking = str2double(userInput{2});
    
    numberTeams = str2double(userInput{3});
end
%% ========================================================================
%---------------------------CALL TO FUNCTIONS------------------------------
%--------------------------------------------------------------------------
%---THE TRY STATEMENT'S ONLY USE IS SO THAT WE CAN HAVE ALL THE CALLS TO--- 
%---FUNCTIONS AT THE SAME PLACE--------------------------------------------
%--------------------------------------------------------------------------
%Call to manual event functions
try if eventChoice == eventMSkidpad
    eventScores = mSkidpadEventScore(yourTeamTime, bestTeamTime, penaltyDOO, penaltyOC,...
        penaltyUSS, bestTeamPenaltyDOO);

    elseif eventChoice == eventMAccel
        eventScores = mAccelEventScore(yourTeamTime, bestTeamTime, penaltyDOO, penaltyOC,...
            penaltyUSS, bestTeamPenaltyDOO);
    
    elseif eventChoice == eventMAutocross
        eventScores = mAutocrossEventScore(yourTeamTime, bestTeamTime, penaltyDOO, penaltyOC,...
            penaltyUSS, bestTeamPenaltyDOO, bestTeamPenaltyOC);
    end
end

%Call to DV event functions
try if eventChoice == eventDVSkidpad
    eventScores = dvSkidpadEventScore(yourTeamTime, yourTeamRanking, numberTeams);

    elseif eventChoice == eventDVAccel
    eventScores = dvAccelEventScore(yourTeamTime, yourTeamRanking, numberTeams);
    end
end

%Call to DC event functions
try if eventChoice == eventDCSkidpad
    eventScores = dcSkidpadEventScore(yourTeamTime, bestTeamTime, penaltyDOO,...
        penaltyOC, penaltyUSS, bestTeamPenaltyDOO);

    elseif eventChoice == eventDCAccel
        eventScores = dcAccelEventScore(yourTeamTime, bestTeamTime, penaltyDOO,...
            penaltyOC, penaltyUSS, bestTeamPenaltyDOO);
    end
end
%% ========================================================================
%----------------------------PRINTS RESULTS--------------------------------
disp(round(eventScores,2))
%% ========================================================================
%---------------------------FUNCTIONS FOR MANUAL---------------------------
%--------------------------------------------------------------------------
%----------------------------Manual skidpad--------------------------------
function [score] = mSkidpadEventScore(yourTeamTime, bestTeamTime, penaltyDOO,...
    penaltyOC, penaltyUSS, bestTeamPenaltyDOO)
    % takes input for a team's time and the best team's time, penalties and
    % returns a score. Uses FSG2024 Rules
    maxPoints = 50;

    if penaltyOC > 0 || penaltyUSS > 0
        score = 0;

    elseif yourTeamTime + 0.2*penaltyDOO < bestTeamTime + 0.2*bestTeamPenaltyDOO
        score = maxPoints;

    elseif penaltyOC == 0 && penaltyUSS == 0

        bestTeamTimeFactor = (bestTeamTime + 0.2*bestTeamPenaltyDOO)* 1.25;
        yourTeamTimeFactor = (yourTeamTime + 0.2*penaltyDOO);

        score = 0.95*maxPoints*(((bestTeamTimeFactor / yourTeamTimeFactor)^2 - 1)...
                / 0.5625) + 0.05*maxPoints;

        if score <= 0.05*maxPoints
            score = 0.05*maxPoints;
        end
    end
end

%-------------------------Manual Acceleration------------------------------
function [score] = mAccelEventScore(yourTeamTime, bestTeamTime, penaltyDOO,...
    penaltyOC, penaltyUSS, bestTeamPenaltyDOO)
    % takes input for a team's time and the best team's time, penalties and
    % returns a score. Uses FSG2024 Rules
    maxPoints = 50;

    if penaltyOC > 0 || penaltyUSS > 0
        score = 0;

    elseif yourTeamTime + 2*penaltyDOO < bestTeamTime + 2*bestTeamPenaltyDOO
        score = maxPoints;

    elseif penaltyOC == 0 && penaltyUSS == 0

        bestTeamTimeFactor = (bestTeamTime + 2*bestTeamPenaltyDOO)*1.5;
        yourTeamTimeFactor = (yourTeamTime + 2*penaltyDOO);

        score = 0.95*maxPoints*((bestTeamTimeFactor / yourTeamTimeFactor - 1)...
                / 0.5) + 0.05*maxPoints;

        if score <= 0.05*maxPoints
            score = 0.05*maxPoints;
        end
    end
end

%-------------------------Manual Autocross---------------------------------
function [score] = mAutocrossEventScore(yourTeamTime, bestTeamTime, penaltyDOO,...
    penaltyOC, penaltyUSS, bestTeamPenaltyDOO, bestTeamPenaltyOC)
    %takes input for a team's time and the best team's time, penalties and
    %returns a score. Uses FS2024 Rules
    maxPoints = 100;

    if penaltyUSS > 0
        score = 0;

    elseif yourTeamTime + 2*penaltyDOO + 10*penaltyOC < bestTeamTime + ...
            2*bestTeamPenaltyDOO + 10*bestTeamPenaltyOC
        score = maxPoints;
    
    elseif penaltyUSS == 0

        bestTeamTimeFactor = (bestTeamTime + 2*bestTeamPenaltyDOO + 10*bestTeamPenaltyOC)*1.25;
        yourTeamTimeFactor = (yourTeamTime + 2*penaltyDOO + 10*penaltyOC);

        score = 0.95*maxPoints*((bestTeamTimeFactor / yourTeamTimeFactor - 1)...
            / 0.25) + 0.05*maxPoints;

        if score <= 0.05*maxPoints
            score = 0.05*maxPoints;
        end
    end
end
%% ========================================================================
%----------------------------FUNCTIONS FOR DV------------------------------
%--------------------------------------------------------------------------
%------------------------------DV Skidpad----------------------------------
function [score] = dvSkidpadEventScore(yourTeamTime, yourTeamRanking, numberTeams)
    % takes input for a team's time, your ranking and the number of team's
    % with atleast one manual or DV run without DNF or DQ 
    % and returns a score
    % uses FSG2024 Rules
    maxPoints = 75;
    
    if round(yourTeamTime,3) <= 25
        score = maxPoints*((numberTeams+1-yourTeamRanking)/numberTeams);

        if score < 0
            score = 0;
        end

    elseif round(yourTeamTime,3) > 25
        score = 0;
    end
end

%-----------------------------DV Acceleration------------------------------
function [score] = dvAccelEventScore(yourTeamTime, yourTeamRanking, numberTeams)
    % takes input for a team's time, your ranking and the number of team's
    % with atleast one manual or DV run without DNF or DQ 
    % and returns a score
    % uses FSG2024 Rules
    maxPoints = 75;
    
    if round(yourTeamTime,3) <= 25
        score = maxPoints*((numberTeams+1-yourTeamRanking)/numberTeams);

        if score < 0
            score = 0;
        end

    elseif round(yourTeamTime,3) > 25
        score = 0;
    end
end

%% ========================================================================
%--------------------------FUNCTIONS FOR DC--------------------------------
%--------------------------------------------------------------------------
%-----------------------------DC Skidpad-----------------------------------
function [score] = dcSkidpadEventScore(yourTeamTime, bestTeamTime, penaltyDOO,...
    penaltyOC, penaltyUSS, bestTeamPenaltyDOO)
    % takes input for a team's best time and the best team's time, 
    % penalties and returns a score. Uses FSG2024 Rules
    maxPoints = 75;

    if penaltyOC > 0 || penaltyUSS > 0
        score = 0;

    elseif yourTeamTime + 0.2*penaltyDOO < bestTeamTime + 0.2*bestTeamPenaltyDOO
        score = maxPoints;

    elseif penaltyOC == 0 && penaltyUSS == 0
    
        bestTeamTimeFactor = (bestTeamTime + 0.2*bestTeamPenaltyDOO) * 1.5;
        yourTeamTimeFactor = (yourTeamTime + 0.2*penaltyDOO);

        score = 0.95*maxPoints*(((bestTeamTimeFactor / yourTeamTimeFactor)^2 - 1)...
            / 1.25) + 0.05*maxPoints;

        if score <= 0.05*maxPoints
            score = 0.05*maxPoints;
        end
    end
end

%-----------------------------DC Acceleration------------------------------
function [score] = dcAccelEventScore(yourTeamTime, bestTeamTime, penaltyDOO,...
    penaltyOC, penaltyUSS, bestTeamPenaltyDOO)
    % takes input for a team's time and the best team's time, penalties and
    % returns a score. Uses FSG2024 Rules
    maxPoints = 75;

    if penaltyOC > 0 || penaltyUSS > 0
        score = 0;

    elseif yourTeamTime + 2*penaltyDOO < bestTeamTime + 2*bestTeamPenaltyDOO
        score = maxPoints;

    elseif penaltyOC == 0 && penaltyUSS == 0

        bestTeamTimeFactor = (bestTeamTime + 2*bestTeamPenaltyDOO)*2;
        yourTeamTimeFactor = (yourTeamTime + 2*penaltyDOO);

        score = 0.95*maxPoints*(bestTeamTimeFactor / yourTeamTimeFactor - 1)... 
            + 0.05*maxPoints;

        if score <= 0.05*maxPoints
            score = 0.05*maxPoints;
        end
    end
end