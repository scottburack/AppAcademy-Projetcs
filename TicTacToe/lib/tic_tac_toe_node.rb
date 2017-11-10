require_relative 'tic_tac_toe'
require "byebug"

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end
  
  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def losing_node?(evaluator)
    #base case
    my_move? = (evaluator == self.next_mover_mark)
    if self.board.over? && (self.board.winner.nil? || self.board.winner == evaluator && my_move?)
      return false
    end 

    if evaluator == self.next_mover_mark
      return true if children.all? { |child| child.losing_node?(evaluator)}
    else
      return true if children.any? { |child| child.losing_node?(self.next_mover_mark)}
    end 
    false
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    result = []
    @board.rows.each_with_index do |row, i| 
      row.each_with_index do |position, j|
        if position.nil?
          dup_board = board.dup
          dup_board[[i, j]] = @next_mover_mark
          next_mover_mark == :x ? next_sym = :o : next_sym = :x
          result << TicTacToeNode.new(dup_board, next_sym, [i,j])
      #    debugger
        end
      end 
    end 
    result
  end
end
