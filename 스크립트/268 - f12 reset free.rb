#=============================================================================
# ** Reset class (because it won't be defined until F12 is pressed otherwise)
#=============================================================================
class Reset < Exception
  
end
#=============================================================================
# ** Module Graphics
#=============================================================================
module Graphics
  class << self
    #-------------------------------------------------------------------------
    # * Aliases Graphics.update and Graphics.transition
    #-------------------------------------------------------------------------
    unless self.method_defined?(:zeriab_f12_removal_update)
      alias_method(:zeriab_f12_removal_update, :update)
      alias_method(:zeriab_f12_removal_transition, :transition)
    end
		
    def update(*args)
      done = false
      # Keep trying to do the update
      while !done
        begin
          zeriab_f12_removal_update(*args)
          done = true
        rescue Reset
          # Do nothing
        end
      end
    end
		
    def transition(*args)
      done = false
      # Keep trying to do the transition
      while !done
        begin
          zeriab_f12_removal_transition(*args)
          done = true
        rescue Reset
          # Do nothing
        end
      end
    end
  end
end