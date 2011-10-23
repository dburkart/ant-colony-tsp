function [ tour , distance] = do_tsp_tour( cities )
%do_tsp_tour
%   Takes in mxm adjacency matrix of cities, returns mx1 tour and distance

number_of_ants = 10;
number_of_cities = size(cities , 1);

pheromone_matrix = zeros(size(cities));

visited_cities = zeros([number_of_ants number_of_cities + 1]);

tour_distance = zeros([number_of_ants 1]);

%TODO Need to set this to the real value, see section III subsection D
initial_pheromone_level = 0.1

%TODO Generate starting posistions

for n = 2:number_of_cities:
    for k = 1:number_of_ants:
        %Get the city which is stored in the previous location, ie the
        %city we are in now
        current_city = visited_cites(k , n - 1);
        neighboring_adjacency = cities(current_city);
        
        
        %Need to calculate our next city here
        %TODO replace random search with actual search
        next_city = current_city;
        
        while size(find(visited_cities(k) == next_city)) > 0:
            next_city = round(rand(1) * number_of_cities);
        end
        
        visited_cities(k , n) = next_city;
        tour_distance = neighboring_adjacency(next_city);       
    end
   
    p = 0.1
   
    %Local updating step, update all pheremones between prev and current
    %city for all ants
    for k = 1:number_of_ants:
        previous_city = visited_cities(k , n - 1);
        current_city = visited_cities(k , n);
        
        current_pheromone = pheromone_matrix(previous_city , current_city);
        
        pheromone_matrix(previous_city , current_city) = (1 - p) * current_pheromone + p * initial_pheromone_level;
    end
        
end

for k = 1:number_of_ants:
    visited_cities(k , number_of_cities + 1) = visited_cities(k , 1);
    current_city = visited_cites(k , number_of_cities)
    
    %Calculate the distance between the current city and starting city
    tour_distance(k) = tour_distance(k) + cities(current_city  , visited_cites(k , 1);
end
              
[shortest_tour_distance , best_ant] = min(tour_distance)

tour = visited_cities(best_ant);
distance = shortest_tour_distance;

end

