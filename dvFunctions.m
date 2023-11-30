classdef dvFunctions
    methods (Static)
        %% ========================================================================
        %----------------------------FUNCTIONS FOR DV------------------------------
        %--------------------------------------------------------------------------
        %------------------------------DV Skidpad----------------------------------
        function [score] = dvSkidpadEventScore(yourTeamTime, yourTeamRanking, numberTeams)
            % Takes input for a team's time, your ranking and the number of team's
            % with atleast one manual or DV run without DNF or DQ and returns a 
            % score. Uses FSG2024 Rules
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
            % Takes input for a team's time, your ranking and the number of team's
            % with atleast one manual or DV run without DNF or DQ and returns a 
            % score. Uses FSG2024 Rules
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
    end
end