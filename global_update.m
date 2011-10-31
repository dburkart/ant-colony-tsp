function [ shortest_tour ] = global_update( cities )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    number_of_ants = 10;
    a = .1

    % find shortest tour
    [tour, distance] = do_tsp_tour(cities);
    tour_length = size(tour);
    
    for k = 1:tour_length
        previous_city = visited_cities(k , n - 1);
        current_city = visited_cities(k , n);
        
        current_pheromone = pheromone_matrix(previous_city , current_city);
        
        pheromone_matrix(previous_city , current_city) = (1 - a) * current_pheromone + a * power(distance, -1);
    end
    
    if end_condition
        shortest_tour = tour
    else
        global_update( cities )
    end

end

