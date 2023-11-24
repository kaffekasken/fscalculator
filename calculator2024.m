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
switch eventGroupChoice
    case mEventGroup
        disp('FSG2024 Score Calculator')

        msg = "Choose type of test";
        options = ["Skidpad" "Acceleration" "Autocross" "Endurance" "xxx"];
        eventChoice = menu(msg,options);

        eventMSkidpad         = 1;
        eventMAccel           = 2;
        eventMAutocross       = 3;
        eventMEndurance       = 4;
        xxx                   = 5;

%% ========================================================================
%------------------------MENU FOR DV EVENTS--------------------------------
%--------------------------------------------------------------------------
    case dvEventGroup
        disp('FSG2024 Score Calculator')

        msg = "Choose type of test";
        options = ["Skidpad" "Acceleration" "xxx" "xxx" "xxx"];
        eventChoice = menu(msg,options);

        eventDVSkidpad            = 1;
        eventDVAccel              = 2;
        xxx                       = 3;
        xxx                       = 4;
        xxx                       = 5;
%% ========================================================================
%---------------------------MENU FOR DC EVENTS-----------------------------
%--------------------------------------------------------------------------
    case dcEventGroup
        disp('FSG2024 Score Calculator')

        msg = "Choose type of test";
        options = ["Skidpad" "Acceleration" "Autocross" "xxx" "xxx"];
        eventChoice = menu(msg,options);

        eventDCSkidpad               = 1;
        eventDCAccel                 = 2;
        eventDCAutocross             = 3;
        xxx                          = 4;
        xxx                          = 5;
end
%% ========================================================================
%---------------------GUI USERINPUT FOR MANUAL-----------------------------
%--------------------------------------------------------------------------
switch eventGroupChoice
    case mEventGroup
        switch eventChoice
%------------------------Special case Manual Endurance---------------------
            case eventMEndurance
                prompt = {'Enter your total time', 'Enter the time for the longest lap',...
                    'Enter how many DOO´s', 'Enter how many OC´s', 'Enter how many USS´s',...
                    'Enter best total time of event',...
                    'Enter the time for the longest lap for the team with best total time',...
                    'Enter how many DOO´s', 'Enter how many OC´s'};
                dlgtitle = 'Event input';
                fieldsize = [1 45; 1 45; 1 45; 1 45; 1 45; 1 45; 1 45; 1 45; 1 45;];
                defaultinput = {'','','0','0','0','','','0','0'};
         
                userInput = inputdlg(prompt,dlgtitle,fieldsize,defaultinput);
         
                yourTeamTime                 = str2double(userInput{1});

                yourTeamExtraLongLap         = str2double(userInput{2}); 
         
                penaltyDOO                   = str2double(userInput{3});
         
                penaltyOC                    = str2double(userInput{4});
         
                penaltyUSS                   = str2double(userInput{5});
         
                bestTeamTime                 = str2double(userInput{6});
                
                bestTeamExtraLongLap         = str2double(userInput{7});

                bestTeamPenaltyDOO           = str2double(userInput{8});
         
                bestTeamPenaltyOC            = str2double(userInput{9});
%---------------------------Normal Manual GUI------------------------------
            otherwise
                prompt = {'Enter your time', 'Enter best time of event',...
                    'Enter how many DOO´s', 'Enter how many OC´s', 'Enter how many USS´s',...
                    'Enter how many DOO´s the best team got', 'Enter how many OC´s the best team got'};
                dlgtitle = 'Event input';
                fieldsize = [1 45; 1 45; 1 45; 1 45; 1 45; 1 45; 1 45;];
                defaultinput = {'','','0','0','0','0','0'};
         
                userInput = inputdlg(prompt,dlgtitle,fieldsize,defaultinput);
         
                yourTeamTime        = str2double(userInput{1});
         
                bestTeamTime        = str2double(userInput{2});
         
                penaltyDOO          = str2double(userInput{3});
         
                penaltyOC           = str2double(userInput{4});
         
                penaltyUSS          = str2double(userInput{5});
         
                bestTeamPenaltyDOO  = str2double(userInput{6});
         
                bestTeamPenaltyOC   = str2double(userInput{7});
        end
%---------------------Call to manual event functions-----------------------
        switch eventChoice
            case eventMSkidpad
                eventScores = mSkidpadEventScore(yourTeamTime, bestTeamTime, penaltyDOO, penaltyOC,...
                    penaltyUSS, bestTeamPenaltyDOO);

            case eventMAccel
                eventScores = mAccelEventScore(yourTeamTime, bestTeamTime, penaltyDOO, penaltyOC,...
                    penaltyUSS, bestTeamPenaltyDOO);
    
            case eventMAutocross
                eventScores = mAutocrossEventScore(yourTeamTime, bestTeamTime, penaltyDOO, penaltyOC,...
                    penaltyUSS, bestTeamPenaltyDOO, bestTeamPenaltyOC);
            case eventMEndurance
                eventScores = mEnduranceEventScore(yourTeamTime, yourTeamExtraLongLap, penaltyDOO, penaltyOC,...
                    penaltyUSS, bestTeamTime, bestTeamExtraLongLap, bestTeamPenaltyDOO, bestTeamPenaltyOC);
        end
%% ========================================================================
%------------------GUI USERINPUT FOR DV EVENTS-----------------------------
%--------------------------------------------------------------------------
    case dvEventGroup
        prompt = {'Enter your team´s best time (without penalties)', 'Enter your team´s ranking: ',...
                'Enter number of team´s who finished atleast one DV run without DNF or DQ: '};
        dlgtitle = 'Event input';
        fieldsize = [1 45; 1 45; 1 45;];
        defaultinput = {'','',''};
    
        userInput = inputdlg(prompt,dlgtitle,fieldsize,defaultinput);

        yourTeamTime        = str2double(userInput{1});
    
        yourTeamRanking     = str2double(userInput{2});
    
        numberTeams         = str2double(userInput{3});
%-------------------Call to DV event functions-----------------------------
        switch eventChoice
            case eventDVSkidpad
                eventScores = dvSkidpadEventScore(yourTeamTime, yourTeamRanking, numberTeams);

            case eventDVAccel
                eventScores = dvAccelEventScore(yourTeamTime, yourTeamRanking, numberTeams);
        end

%% ========================================================================
%-------------------GUI USERINPUT FOR DC EVENTS----------------------------
%--------------------------------------------------------------------------
     case dcEventGroup
         switch eventChoice
%--------------------------Special case Autocross--------------------------
             case eventDCAutocross
                 prompt = {'Enter your time for the 6 m/s lap',...
                     'Enter your time for the first run: ', ...
                     'Enter how many DOO´s for the first run',...
                     'Enter how many OC´s for the first run',...
                     'Enter how many USS´s for the first run',...
                     'Enter your time for the second run',...
                     'Enter how many DOO´s for the second run',...
                     'Enter how many OC´s for the second run',...
                     'Enter how many USS´s for the second run',...
                     ...
                     'Enter the best team´s time for the 6 m/s lap',...
                     'Enter the best team´s time for the first run',...
                     'Enter how many DOO´s for the first run',...
                     'Enter how many OC´s for the first run',...
                     'Enter how many USS´s for the first run',...
                     'Enter the best team´s time for the second run',...
                     'Enter how many DOO´s for the second run',...
                     'Enter how many OC´s for the second run',...
                     'Enter how many USS´s for the second run',...
                     };
                dlgtitle = 'Event input';
                fieldsize = [1 45; 1 45; 1 45; 1 45; 1 45; 1 45; 1 45;...
                    1 45; 1 45; 1 45; 1 45; 1 45; 1 45; 1 45; 1 45; 1 45;...
                    1 45; 1 45;];
                defaultinput = {'','','0','0','0','','0','0','0',...
                    '','','0','0','0','','0','0','0'};
                
                userInput = inputdlg(prompt,dlgtitle,fieldsize,defaultinput);
                
                timeSixMeterPerSecond = str2double(userInput{1});
                yourTeamTime1         = str2double(userInput{2});
                penaltyDOO1           = str2double(userInput{3});
                penaltyOC1            = str2double(userInput{4});
                penaltyUSS1           = str2double(userInput{5});
                yourTeamTime2         = str2double(userInput{6});
                penaltyDOO2           = str2double(userInput{7});
                penaltyOC2            = str2double(userInput{8});
                penaltyUSS2           = str2double(userInput{9});
                
                bestTeamTimeSixMeterPerSecond...
                                      = str2double(userInput{10});
                bestTeamTime1         = str2double(userInput{11});
                bestTeamPenaltyDOO1   = str2double(userInput{12});
                bestTeamPenaltyOC1    = str2double(userInput{13});
                bestTeamPenaltyUSS1   = str2double(userInput{14});
                bestTeamTime2         = str2double(userInput{15});
                bestTeamPenaltyDOO2   = str2double(userInput{16});
                bestTeamPenaltyOC2    = str2double(userInput{17});
                bestTeamPenaltyUSS2   = str2double(userInput{18});
%------------------------------Normal DC GUI-------------------------------
             otherwise
                prompt = {'Enter your time', 'Enter best time of event',...
                    'Enter how many DOO´s', 'Enter how many OC´s', 'Enter how many USS´s',...
                    'Enter how many DOO´s the best team got', 'Enter how many OC´s the best team got'};
                dlgtitle = 'Event input';
                fieldsize = [1 45; 1 45; 1 45; 1 45; 1 45; 1 45; 1 45;];
                defaultinput = {'','','0','0','0','0','0'};
                
                userInput = inputdlg(prompt,dlgtitle,fieldsize,defaultinput);
                
                yourTeamTime        = str2double(userInput{1});
                
                bestTeamTime        = str2double(userInput{2});
                
                penaltyDOO          = str2double(userInput{3});
            
                penaltyOC           = str2double(userInput{4});
            
                penaltyUSS          = str2double(userInput{5});
            
                bestTeamPenaltyDOO  = str2double(userInput{6});
            
                bestTeamPenaltyOC   = str2double(userInput{7});
         end


    
%--------------------Call to DC event functions----------------------------
        switch eventChoice
            case eventDCSkidpad
                eventScores = dcSkidpadEventScore(yourTeamTime, bestTeamTime, penaltyDOO,...
                    penaltyOC, penaltyUSS, bestTeamPenaltyDOO);

            case eventDCAccel
                eventScores = dcAccelEventScore(yourTeamTime, bestTeamTime, penaltyDOO,...
                    penaltyOC, penaltyUSS, bestTeamPenaltyDOO);

            case eventDCAutocross
                eventScores = dcAutocrossEventScore(timeSixMeterPerSecond,yourTeamTime1,...
                    penaltyDOO1, penaltyOC1, penaltyUSS1, yourTeamTime2, penaltyDOO2, ...
                    penaltyOC2, penaltyUSS2, bestTeamTimeSixMeterPerSecond, bestTeamTime1,...
                    bestTeamPenaltyDOO1, bestTeamPenaltyOC1, bestTeamPenaltyUSS1, bestTeamTime2, ...
                    bestTeamPenaltyDOO2, bestTeamPenaltyOC2, bestTeamPenaltyUSS2);
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
%-----------------------------M Endurance----------------------------------
function [score] = mEnduranceEventScore(yourTeamTime, yourTeamExtraLongLap,...
    penaltyDOO, penaltyOC, penaltyUSS, bestTeamTime, bestTeamExtraLongLap,...
    bestTeamPenaltyDOO, bestTeamPenaltyOC)
    %takes input for a team's time, the best team's time, the time for
    %the extra long laps, penalties and returns a score. Uses FS2024 Rules
    maxPoints = 250;
    
    yourTeamCorrectedTime = (yourTeamTime - yourTeamExtraLongLap + 2*penaltyDOO...
        + 10*penaltyOC);
    bestTeamCorrectedTime = (bestTeamTime - bestTeamExtraLongLap + 2*bestTeamPenaltyDOO...
        + 10*bestTeamPenaltyOC);
    
    if yourTeamCorrectedTime < bestTeamCorrectedTime
        score = maxPoints - 50*penaltyUSS;
    
    else

        score = 0.9*maxPoints*((bestTeamCorrectedTime*1.333 / yourTeamCorrectedTime - 1)...
            / 0.333) + 0.1*maxPoints - 50*penaltyUSS;

        if score <= 0.1*maxPoints && penaltyUSS == 0
            score = 0.1*maxPoints;
        elseif score <= 0.1*maxPoints && penaltyUSS > 0 
            score = 0;
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
%----------------------------DC Autocross----------------------------------
function [score] = dcAutocrossEventScore(timeSixMeterPerSecond,yourTeamTime1,...
    penaltyDOO1, penaltyOC1, penaltyUSS1, yourTeamTime2, penaltyDOO2, ...
    penaltyOC2, penaltyUSS2, bestTeamTimeSixMeterPerSecond, bestTeamTime1,...
    bestTeamPenaltyDOO1, bestTeamPenaltyOC1, bestTeamPenaltyUSS1, bestTeamTime2, ...
    bestTeamPenaltyDOO2, bestTeamPenaltyOC2, bestTeamPenaltyUSS2)
    %takes input for a team's time and the best team's time, penalties and
    %returns a score. Uses FS2024 Rules
    maxPoints = 100;
    
    yourTeamTime1Factor = yourTeamTime1 + 2*penaltyDOO1 + 10*penaltyOC1;
    yourTeamTime2Factor = yourTeamTime2 + 2*penaltyDOO2 + 10*penaltyOC2;

    bestTeamTime1Factor = bestTeamTime1 + 2*bestTeamPenaltyDOO1 + 10*bestTeamPenaltyOC1;
    bestTeamTime2Factor = bestTeamTime2 + 2*bestTeamPenaltyDOO2 + 10*bestTeamPenaltyOC2;

    if yourTeamTime1Factor > timeSixMeterPerSecond || penaltyUSS1 > 0
        yourTeamTime1Factor = timeSixMeterPerSecond;
    end
    
    if yourTeamTime2Factor > timeSixMeterPerSecond || penaltyUSS2 > 0
        yourTeamTime2Factor = timeSixMeterPerSecond;
    end
    
    if bestTeamTime1Factor > bestTeamTimeSixMeterPerSecond || bestTeamPenaltyUSS1 > 0
        bestTeamTime1Factor = bestTeamTimeSixMeterPerSecond;
    end
    
    if bestTeamTime2Factor > bestTeamTimeSixMeterPerSecond || bestTeamPenaltyUSS2 > 0
        bestTeamTime2Factor = bestTeamTimeSixMeterPerSecond;
    end
    
    yourTeamTimeTotal = min(yourTeamTime1Factor, ((yourTeamTime1Factor + yourTeamTime2Factor)/2));
    bestTeamTimeTotal = min(yourTeamTime1Factor, ((bestTeamTime1Factor + bestTeamTime2Factor)/2));
    
    if yourTeamTimeTotal <= bestTeamTimeTotal
        score = maxPoints;
    elseif yourTeamTimeTotal <= timeSixMeterPerSecond && yourTeamTimeTotal > 0
        score = 0.9*maxPoints*((timeSixMeterPerSecond - yourTeamTimeTotal)/...
            (timeSixMeterPerSecond - bestTeamTimeTotal)) + 0.1*maxPoints;
        if score <= 0.1*maxPoints
            score = 0.1*maxPoints;
        end
    elseif yourTeamTimeTotal == 0
        score = 0;
    end
end