module VoterRecord

function policy_compare(senator_a, senator_b, senator_map, vote_deviation) 
    return vote_deviation[senator_map[senator_a], senator_map[senator_b]]
end

function most_similar(senator, senator_map, vote_deviation)
end

function least_similar(senator, senator_map, vote_deviation)
end

function average(senator, senator_set, senator_map, vote_deviation)
end

function find_average_record(senator_set, senator_map, vote_deviation)
end

function bitter_rivals(vote_deviation)
end

function main()
    entry_array = readlines("voting_record_dump109.txt")
    senator_map = Dict()
    sen_vote_matrix = Array{Int64}(undef, 0, 46) 
    cnt = 1
    for entry in entry_array
        entry_info = split(entry, " ")
        senator_map[entry_info[1]] = cnt
        vote_list = map(x -> parse(Int64, x), entry_info[4:end])
        sen_vote_matrix = vcat(sen_vote_matrix, vote_list')
        cnt = cnt + 1
    end
    vote_deviation = sen_vote_matrix*sen_vote_matrix'
    print(policy_compare("Akaka", "Alexander", senator_map, vote_deviation))
end

main()

end # module
