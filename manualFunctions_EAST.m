%% ========================================================================
%---------------------------FUNCTIONS FOR MANUAL---------------------------
%--------------------------------------------------------------------------
%----------------------------Manual skidpad--------------------------------
classdef manualFunctions_EAST
    methods (Static)
        function [score] = mSkidpadEventScore(yourTeamTime, bestTeamTime, penaltyDOO,...
            penaltyOC, penaltyUSS, bestTeamPenaltyDOO)
            % Takes input for a team's time and the best team's time, penalties and
            % returns a score. Uses FSG2024 Rules
            maxPoints = 75;

            if penaltyOC > 0 || penaltyUSS > 0
                score = 0;

            elseif yourTeamTime + 0.2*penaltyDOO < bestTeamTime + 0.2*bestTeamPenaltyDOO
                score = maxPoints;

            elseif penaltyOC == 0 && penaltyUSS == 0

                bestTeamTimeFactor = (bestTeamTime + 0.2*bestTeamPenaltyDOO)* 1.25;
                yourTeamTimeFactor = (yourTeamTime + 0.2*penaltyDOO);

                score = 71.5*(((bestTeamTimeFactor / yourTeamTimeFactor)^2 - 1)...
                        / 0.5625) + 3.5;

                if score <= 3.5
                    score = 3.5;
                end
            end
        end

        %-------------------------Manual Acceleration------------------------------
        function [score] = mAccelEventScore(yourTeamTime, bestTeamTime, penaltyDOO,...
            penaltyOC, penaltyUSS, bestTeamPenaltyDOO)
            % Takes input for a team's time and the best team's time, penalties and
            % returns a score. Uses FSG2024 Rules
            maxPoints = 75;

            if penaltyOC > 0 || penaltyUSS > 0
                score = 0;

            elseif yourTeamTime + 2*penaltyDOO < bestTeamTime + 2*bestTeamPenaltyDOO
                score = maxPoints;

            elseif penaltyOC == 0 && penaltyUSS == 0

                bestTeamTimeFactor = (bestTeamTime + 2*bestTeamPenaltyDOO)*1.5;
                yourTeamTimeFactor = (yourTeamTime + 2*penaltyDOO);

                score = 71.5*((bestTeamTimeFactor / yourTeamTimeFactor - 1)...
                        / 0.5) + 3.5;

                if score <= 3.5
                    score = 3.5;
                end
            end
        end

        %-------------------------Manual Autocross---------------------------------
        function [score] = mAutocrossEventScore(yourTeamTime, bestTeamTime, penaltyDOO,...
            penaltyOC, penaltyUSS, bestTeamPenaltyDOO, bestTeamPenaltyOC)
            % Takes input for a team's time and the best team's time, penalties and
            % returns a score. Uses FS2024 Rules
            maxPoints = 100;

            if penaltyUSS > 0
                score = 0;

            elseif yourTeamTime + 2*penaltyDOO + 10*penaltyOC < bestTeamTime + ...
                    2*bestTeamPenaltyDOO + 10*bestTeamPenaltyOC
                score = maxPoints;
            
            elseif penaltyUSS == 0

                bestTeamTimeFactor = (bestTeamTime + 2*bestTeamPenaltyDOO + 10*bestTeamPenaltyOC)*1.25;
                yourTeamTimeFactor = (yourTeamTime + 2*penaltyDOO + 10*penaltyOC);

                score = 95*((bestTeamTimeFactor / yourTeamTimeFactor - 1)...
                    / 0.25) + 5;

                if score <= 5
                    score = 5;
                end
            end
        end
        %-----------------------------M Endurance----------------------------------
        function [score] = mEnduranceEventScore(yourTeamTime, yourTeamExtraLongLap,...
            penaltyDOO, penaltyOC, penaltyUSS, bestTeamTime, bestTeamExtraLongLap,...
            bestTeamPenaltyDOO, bestTeamPenaltyOC)
            % Takes input for a team's time, the best team's time, the time for
            % the extra long laps, penalties and returns a score. Uses FS2024 Rules
            maxPoints = 325;
            
            yourTeamCorrectedTime = (yourTeamTime - yourTeamExtraLongLap + 2*penaltyDOO...
                + 10*penaltyOC);
            bestTeamCorrectedTime = (bestTeamTime - bestTeamExtraLongLap + 2*bestTeamPenaltyDOO...
                + 10*bestTeamPenaltyOC);
            
            if yourTeamCorrectedTime < bestTeamCorrectedTime
                score = maxPoints - 0*penaltyUSS;
            
            else

                score = 300*((bestTeamCorrectedTime*1.333 / yourTeamCorrectedTime - 1)...
                    / 0.333) + 25 - 0*penaltyUSS;

                if score <= 0.1*maxPoints && penaltyUSS == 0
                    score = 0.1*maxPoints;
                elseif score <= 0.1*maxPoints && penaltyUSS > 0 
                    score = 0;
                end
            end
        end
        %-----------------------------M Efficiency---------------------------------
        function [score] = mEfficiencyEventScore(yourTeamTime,teamRecievedPointsCheck,...
            measuredVoltage, measuredCurrent, regeneratedEnergy, bestTeamTime, ...
            bestTeamEnergy, bestTeamEfficiency)
            % Takes input for your team's uncorrected endurance time, information 
            % if the team recieved points in the endurance event, your team's 
            % measured voltage, current and regenerated energy and the best team's 
            % uncorrected endurance time and the best team's energy. 
            % Uses FS2024 rules
            maxPoints = 100;
            
            if teamRecievedPointsCheck ~= true
                score = 0;

            elseif yourTeamTime > bestTeamTime*1.333
                score = 0;
            
            elseif teamRecievedPointsCheck && yourTeamTime < bestTeamTime*1.333

                yourTeamEnergy = measuredVoltage*measuredCurrent - 0.9*regeneratedEnergy;

                yourTeamEfficiencyFactor = yourTeamTime^2 * yourTeamEnergy;
                
                if bestTeamEfficiency > 0 
                    minEfficiencyFactor = bestTeamEfficiency;

                    maxEfficiencyFactor = 1.5 * minEfficiencyFactor;

                elseif bestTeamEfficiency == 0
                    minEfficiencyFactor = bestTeamTime^2 * bestTeamEnergy;

                    maxEfficiencyFactor = 1.5 * minEfficiencyFactor;
                end
                
                score = maxPoints*((maxEfficiencyFactor - yourTeamEfficiencyFactor)...
                    /(maxEfficiencyFactor - minEfficiencyFactor));
            end
        end
    end
end