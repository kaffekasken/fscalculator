%##########################################################################
%###################-FSG SCORE CALCULATOR 2024-############################
%##########################################################################

% Importing classes containing score calculation functions
import manualFunctions.*;
import dvFunctions.*;
import dcFunctions.*;

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
        options = ["Skidpad" "Acceleration" "Autocross" "Endurance" "Efficiency"];
        eventChoice = menu(msg,options);

        eventMSkidpad         = 1;
        eventMAccel           = 2;
        eventMAutocross       = 3;
        eventMEndurance       = 4;
        eventMEfficiency      = 5;

%% ========================================================================
%------------------------MENU FOR DV EVENTS--------------------------------
%--------------------------------------------------------------------------
    case dvEventGroup
        disp('FSG2024 Score Calculator')

        msg = "Choose type of test";
        options = ["Skidpad" "Acceleration"];
        eventChoice = menu(msg,options);

        eventDVSkidpad            = 1;
        eventDVAccel              = 2;
%% ========================================================================
%---------------------------MENU FOR DC EVENTS-----------------------------
%--------------------------------------------------------------------------
    case dcEventGroup
        disp('FSG2024 Score Calculator')

        msg = "Choose type of test";
        options = ["Skidpad" "Acceleration" "Autocross" "Trackdrive"];
        eventChoice = menu(msg,options);

        eventDCSkidpad               = 1;
        eventDCAccel                 = 2;
        eventDCAutocross             = 3;
        eventDCTrackdrive            = 4;
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
%------------------------Special case Efficiency---------------------------
            case eventMEfficiency
                prompt = {'Enter your time without penalties (uncorrected time)',...
                    'Enter "true" if your team recieved points in the endurance event and "false" if you didn´t',...
                    'Your team´s measured voltage', 'Your team´s measured current',...
                    'Your team´s regenerated energy', 'The best team´s time without penalties (uncorrected time)',...
                    ['Enter the best team´s used energy (if it´s not provided leave it zero)'...
                    ' (or calculate it (voltage*current - 0.9*regenerated energy)'],...
                    ['Enter the best team´s efficiency factor / the lowest efficieny factor' ...
                    ' (leave it zero if it´s not provided)']};
                dlgtitle = 'Event input';
                fieldsize = [1 45; 1 45; 1 45; 1 45; 1 45; 1 45; 1 45; 1 45;];
                defaultinput = {'','true','','','','','0','0'};
         
                userInput = inputdlg(prompt,dlgtitle,fieldsize,defaultinput);
         
                yourTeamTime                    = str2double(userInput{1});

                teamRecievedPointsCheck         = strcmp(userInput{2},'true');

                measuredVoltage                 = str2double(userInput{3});

                measuredCurrent                 = str2double(userInput{4});

                regeneratedEnergy               = str2double(userInput{5});

                bestTeamTime                    = str2double(userInput{6});
                
                bestTeamEnergy                  = str2double(userInput{7});
                bestTeamEfficiency              = str2double(userInput{8});
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

            case eventMEfficiency
                eventScores = mEfficiencyEventScore(yourTeamTime,teamRecievedPointsCheck,...
                    measuredVoltage, measuredCurrent, regeneratedEnergy, bestTeamTime, ...
                        bestTeamEnergy, bestTeamEfficiency);
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
%--------------------------Special case Trackdrive-------------------------
             case eventDCTrackdrive
                 prompt = {'Enter your time', 'Enter amount of completed laps'...
                    'Enter best time of event', 'Enter how many DOO´s',...
                    'Enter how many OC´s', 'Enter how many USS´s',...
                    'Enter how many DOO´s the best team got',...
                    'Enter how many OC´s the best team got'};
                dlgtitle = 'Event input';
                fieldsize = [1 45; 1 45; 1 45; 1 45; 1 45; 1 45; 1 45; 1 45;];
                defaultinput = {'','','','0','0','0','0','0'};
                
                userInput = inputdlg(prompt,dlgtitle,fieldsize,defaultinput);
                
                yourTeamTime        = str2double(userInput{1});
                
                completedLaps       = str2double(userInput{2});
                
                bestTeamTime        = str2double(userInput{3});
                
                penaltyDOO          = str2double(userInput{4});
            
                penaltyOC           = str2double(userInput{5});
            
                penaltyUSS          = str2double(userInput{6});
            
                bestTeamPenaltyDOO  = str2double(userInput{7});
            
                bestTeamPenaltyOC   = str2double(userInput{8});
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
            case eventDCTrackdrive
                eventScores = dcTrackdriveEventScore(yourTeamTime, completedLaps,...
                    bestTeamTime, penaltyDOO, penaltyOC, penaltyUSS,...
                        bestTeamPenaltyDOO, bestTeamPenaltyOC);
        end
end
%% ========================================================================
%----------------------------PRINTS RESULTS--------------------------------
disp(round(eventScores,2))
