module VoterRecord
using DataStructures

function policy_compare(senator_a, senator_b, senator_map, vote_deviation) 
    return vote_deviation[senator_map[senator_a], senator_map[senator_b]]
end

function most_similar(senator, senator_map, vote_deviation)
    max_similar = -5000
    sen_name = nothing
    senator_pos = senator_map[senator]

    i = 1
    while i < size(vote_deviation[senator_pos, :], 1)
        vote_diff = vote_deviation[senator_pos, i]
        if vote_diff > max_similar && vote_diff != vote_deviation[senator_pos, senator_pos]
            max_similar = vote_diff
            sen_name = iterate(senator_map, i)[1].first
        end
        i = i + 1;
    end
    return sen_name
end

function least_similar(senator, senator_map, vote_deviation)
    min_similar = 5000
    sen_name = nothing
    senator_pos = senator_map[senator]

    i = 1
    while i < size(vote_deviation[senator_pos, :], 1)
        vote_diff = vote_deviation[senator_pos, i]
        if vote_diff < min_similar
            min_similar = vote_diff
            sen_name = iterate(senator_map, i)[1].first
        end
        i = i + 1;
    end
    return sen_name
end

function main()
    entry_array = readlines("voting_record_dump109.txt")
    senator_map = OrderedDict{String, Int}()
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

    println(policy_compare("Akaka", "Alexander", senator_map, vote_deviation))
    println(most_similar("Chafee", senator_map, vote_deviation))
    println(least_similar("Santorum", senator_map, vote_deviation))
end

main()

end # module
