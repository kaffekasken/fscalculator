        
classdef dcFunctions
    methods (Static)
        %% ========================================================================
        %--------------------------FUNCTIONS FOR DC--------------------------------
        %--------------------------------------------------------------------------
        %-----------------------------DC Skidpad-----------------------------------
        function [score] = dcSkidpadEventScore(yourTeamTime, bestTeamTime, penaltyDOO,...
            penaltyOC, penaltyUSS, bestTeamPenaltyDOO)
            % Takes input for a team's best time and the best team's time, 
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
            % Takes input for a team's time and the best team's time, penalties and
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
            % Takes input for a team's time and the best team's time, penalties and
            % returns a score. Uses FS2024 Rules
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
        %----------------------------DC Trackdrive---------------------------------
        function [score] = dcTrackdriveEventScore(yourTeamTime, completedLaps,...
            bestTeamTime, penaltyDOO, penaltyOC, penaltyUSS, bestTeamPenaltyDOO, bestTeamPenaltyOC)
            % Takes input for a team's time and the best team's time, penalties and
            % returns a score. Uses FS2024 Rules
            maxPoints = 200;
            
            yourTeamCorrectedTime = (yourTeamTime + 2*penaltyDOO + 10*penaltyOC);
            bestTeamCorrectedTime = (bestTeamTime + 2*bestTeamPenaltyDOO + 10*bestTeamPenaltyOC);
            
            if yourTeamCorrectedTime < bestTeamCorrectedTime
                score = maxPoints - 50*penaltyUSS;
            
            elseif yourTeamCorrectedTime < 2 * bestTeamCorrectedTime

                score = 0.75*maxPoints*(bestTeamCorrectedTime*2 / yourTeamCorrectedTime - 1)...
                    + 0.025*maxPoints*completedLaps - 50*penaltyUSS;

                if score <= 0
                    score = 0;
                end
            else
                score = 0;
            end
        end
    end
end