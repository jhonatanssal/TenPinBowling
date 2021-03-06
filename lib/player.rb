# frozen_string_literal: true

# Player Class
class Player
  def initialize(name)
    @player = {}
    @player[:name] = name
    @player[:attempts] = 0
    @player[:pinfalls] = []
    @player[:totals] = []
  end

  # Name of the player
  def name
    @player[:name]
  end

  # Define value of last shot
  def last_shot(temparr, len2)
    last_with_two = (temparr[9] + temparr[10]) if len2 == 11
    last_with_three = (temparr[9] + temparr[10] + temparr[11]) if len2 == 12

    len2 == 11 ? last_with_two : last_with_three
  end

  # Set scores array for every player by turn
  def set_scores(arr, number_of_players, name)
    len = arr.length
    name = name.upcase
    temparr = []
    i = 0

    while i < len - 1
      if arr[i][0].upcase == name && arr[i + 1][0].upcase == name
        if arr[i][1].to_i == 10
          temparr << [arr[i][1]]
          i += 1
        else
          temparr << [arr[i][1], arr[i + 1][1]]
          i += 2
        end
      elsif arr[i][0].upcase == name && arr[i + 1][0].upcase != name
        temparr << [arr[i][1]]
        i += 1
      else
        i += 1
      end
    end
    temparr << [arr.last[1]] if len <= 15

    len2 = temparr.length
    first_nine = temparr[0..8]

    @player[:pinfalls] = len2 == 10 ? temparr : first_nine << last_shot(temparr, len2)
  end

  # Set total Score by turn
  def total_scores(scores)
    scores_array = scores.map { |x| x.map(&:to_i) }
    total = 0
    i = 0
    while i < scores_array.length - 1
      if scores_array[i][0] == 10
        num = scores_array[i + 1][1].nil? ? scores_array[i + 2][0].to_i : scores_array[i + 1][1].to_i
        total += 10 + scores_array[i + 1][0].to_i + num
      elsif scores_array[i].sum == 10
        total += scores_array[i].sum + scores_array[i + 1][0]
      else
        total += scores_array[i].sum
      end
      @player[:totals] << total
      i += 1
    end
    total += scores_array[-1].sum
    @player[:totals] << total
  end
end
