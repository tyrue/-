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

#==============================================================================
# Chainsawkitten's Disable F1, Alt+Enter, F12 v1.1
#------------------------------------------------------------------------------
# Disable the use of F1, Alt+Enter and F12 by registering a hook which consumes
# keypress events as well as setting the keyboard state.
#==============================================================================

module CskDisable
 # Whether to disable F1. 0 = enable, 1 = disable.
 DISABLE_F1 = 1
 
 # Whether to disable F12. 0 = enable, 1 = disable.
 DISABLE_F12 = 1
 
 # Whether to disable Alt+Enter. 0 = enable, 1 = disable.
 DISABLE_ALT_ENTER = 0
end

Win32API.new("System/F1AltEnterF12", "hook", "III", "").call(
 CskDisable::DISABLE_F1,
 CskDisable::DISABLE_F12,
 CskDisable::DISABLE_ALT_ENTER)
