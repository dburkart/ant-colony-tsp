function [ tour , distance] = do_tsp_tour( cities )
%do_tsp_tour
%   Takes in mxm adjacency matrix of cities, returns mx1 tour and distance

    number_of_ants = 10;
    number_of_cities = size(cities , 1);

    pheromones = ones(size(cities));

    visited_cities = zeros([number_of_ants number_of_cities]);

    tour_distance = zeros([number_of_ants 1]);

    [nearest_neighbor_tour , nearest_neighbor_tour_distance] = do_nearest_neighbor_tour( cities )
    
    
    
    %Generate the ants original starting location
    visited_cities(: , 1) = floor(rand(1 , number_of_ants) * number_of_cities) + 1;

    
    initial_pheromone_level = 1 / (nearest_neighbor_tour_distance * number_of_cities);
    p = .1
    pheromones =  pheromones * initial_pheromone_level;
    
    %TODO Generate starting posistions

    for n = 2:number_of_cities
        for k = 1:number_of_ants
            %Get the city which is stored in the previous location, ie the
            %city we are in now
            current_city = visited_cities(k , n - 1);
            
            
                
            neighboring_adjacency = cities(current_city , :);
        
        
            %Need to calculate our next city here
            %TODO replace random search with actual search
            %next_city = current_city;
        
            
            %Keep generating randomly until 
            %while size(find(visited_cities(k , :) == next_city)) > 0
             %   next_city = floor(rand(1) * number_of_cities) + 1;
            %end
            neighboring_cities = 1:number_of_cities;
                      
            unvisited_cities = setdiff(neighboring_cities , visited_cities(k , :));
            
            [next_city , weight] = probability_between_cities(current_city , cities(current_city , :) , pheromones(current_city , :) , unvisited_cities);
        
            visited_cities(k , n) = next_city;
            tour_distance(k , 1) = tour_distance(k , 1) + neighboring_adjacency(next_city);       
        end
   
   
        %Local updating step, update all pheremones between prev and current
        %city for all ants
        for k = 1:number_of_ants
            previous_city = visited_cities(k , n - 1);
            current_city = visited_cities(k , n);
        
            current_pheromone = pheromones(previous_city , current_city);
        
            pheromones(previous_city , current_city) = (1 - p) * current_pheromone + p * initial_pheromone_level;
        end
        
    end

    for k = 1:number_of_ants
        visited_cities(k , number_of_cities + 1) = visited_cities(k , 1);
        current_city = visited_cities(k , number_of_cities);
    
        %Calculate the distance between the current city and starting city
        tour_distance(k , 1) = tour_distance(k  , 1) + cities(current_city  , visited_cities(k , 1));
    end
              
    [shortest_tour_distance , best_ant] = min(tour_distance)

    tour = visited_cities(best_ant , :);
    distance = shortest_tour_distance;

end

function [ max_city , max_weight] = probability_between_cities(city_r , cities_r , pheromones_r , unvisited_cities )
    b = .5;

    %distance = cities(city_r , city_s);
    %pheremone = pheremones(city_r , city_s);
    
    %city_weight = distance * pheremone ^ b;
    
    %unvisited_sum = 0
    
    max_weight = 0;
    
    max_city = unvisited_cities(1);
        
    for unvisited_city = unvisited_cities
        
        unvisited_distance = cities_r(unvisited_city);
        unvisited_pheromone = pheromones_r(unvisited_city);
        
        unvisited_weight = (1 / unvisited_distance) * unvisited_pheromone ^ b;
        
        if unvisited_weight > max_weight
            max_weight = unvisited_weight;
            max_city = unvisited_city;
        end
        
    end 
        
end

function [nn_tour , nn_tour_length] = do_nearest_neighbor_tour( cities )
    number_of_cities = size(cities , 1);
    
    current_city = 1;
    
    nn_tour = zeros(number_of_cities , 1);
    nn_tour_length = 0;
    
    for k = 1:(number_of_cities - 1)
        neighboring_cities = cities(current_city , :);
        neighboring_cities(current_city) = [];
        
        
        [nearest_distance , nearest_neighbor] = min(neighboring_cities);
        
        
        while size(find(nn_tour == nearest_neighbor) , 1)
            %We cant remove the nearest neighbor or the indices get messed
            %up, so we simply make it not the min
            neighboring_cities(nearest_neighbor) = intmax('uint32');
            [nearest_distance , nearest_neighbor] = min(neighboring_cities);
        end
        
        nn_tour(k) = nearest_neighbor;
        nn_tour_length = nn_tour_length + nearest_distance;
        
        current_city = nearest_neighbor;
    end
    
    nn_tour(number_of_cities) = 1;
    nn_tour_length = nn_tour_length + cities(current_city , 1);
    
    
end