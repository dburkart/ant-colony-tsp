function [ shortest_tour ] = global_update( cities )
%global_update.m
%   Global update phase of TSP, update only edges belonging to best ant
    number_of_ants = 10;
    a = .1

    % find shortest tour
    [tour, distance] = do_tsp_tour(cities);
    tour_length = size(tour);
    
    % determine the best ant from shortest tour
    for k = 1:number_of_ants
        if size(find(visited_cities(k) == tour)) > 0
            best_ant = k
        end
    end
    
    for n = 2:tour_length
        previous_city = visited_cities(best_ant , n - 1);
        current_city = visited_cities(best_ant , n);
        
        current_pheromone = pheromone_matrix(previous_city , current_city);
        
        pheromone_matrix(previous_city , current_city) = (1 - a) * current_pheromone + a * power(distance, -1);
    end
    
    if end_condition
        shortest_tour = tour
    else
        global_update( cities )
    end

end

