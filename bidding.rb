class Agent
  # This will already be implemented and is not part of this exercise
  def initialize; end

  # This will return the amount (integer) by which the agent wants to increase its bid
  # (i.e. how much they want to add onto their bid as it stands so far)
  # This will already be implemented and is not part of this exercise
  def get_bid_increase; end
end


class Bidding
  def initialize(agents)
    @agents = agents
    @withdraw_bid_data = []
    @bid_value = get_initial_bid
  end

  def run
    @active_bid_data = []
    @agents.each do |agent|
      if @bid_value <= agent_increase_bid_value(agent)
        set_max_bid_value(agent)
        @active_bid_data.push(agent)     
      else
        #Here we we are managing agent withdraw
        @withdraw_bid_data.push(agent)
      end
    end
    recall_bidding
  end

  private
  # Here we finialize the max bid
  def recall_bidding
    if @active_bid_data.length > 1 && !is_same_bid?
      @agents = @active_bid_data
      run
    else
      value = {}
      value[:bidding_value] = @bid_value
      value[:agent] = @active_bid_data
      if is_same_bid? && @active_bid_data.count > 1
        puts "Bidding ended here because multiple agents have same bid value" 
      end
      puts value
    end 
  end

  # Check is muliple agents have same bids because we need to end the bid in this case
  def is_same_bid?
    active_bids = @active_bid_data.map{|active_bid| active_bid[:bid]}.uniq
    active_bids.count == 1 && active_bids.last == @bid_value
  end

  # get_initial_bid fucntion always return get_initial_bid
  def get_initial_bid
    increase_bid_value 
  end

  def increase_bid_value
    Agent.new.get_bid_increase || 0
  end

  # set_max_bid_value function always set max bid while bidding is in process
  def set_max_bid_value(agent)
    @bid_value = agent_increase_bid_value(agent)
  end

  # agent_increase_bid_value function always return incremented bid value
  def agent_increase_bid_value(agent)
    agent[:bid] + (increase_bid_value)
  end
end



#Examples

# input_data = [{agent: 'test1', bid: 4}, {agent: 'test2', bid: 3}, {agent: 'tes3', bid: 5}]


# input_data = [{agent: 'tes1', bid: 44}, {agent: 'test2', bid: 44}, {agent: 'tes3', bid: 44}, {agent: 'test4', bid: 44}, {agent: 'test5', bid: 44}, {agent: 'test6', bid: 44}, {agent: 'test7', bid: 44}, {agent: 'test8', bid: 44}]

# input_data = [{agent: 'tes1', bid: 4}, {agent: 'test2', bid: 3}, {agent: 'tes3', bid: 5}, {agent: 'test4', bid: 2}, {agent: 'test5', bid: 8}, {agent: 'test6', bid: 7}, {agent: 'test7', bid: 10}, {agent: 'test8', bid: 15}, {agent: 'test9', bid: 120}]

input_data = [{agent: 'tes1', bid: 4}, {agent: 'test2', bid: 6}, {agent: 'tes3', bid: 5}, {agent: 'test4', bid: 6}]

bid_obj = Bidding.new(input_data)
bid_obj.run
