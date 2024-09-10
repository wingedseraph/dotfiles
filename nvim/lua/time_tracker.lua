-- time_tracker.lua
local TimeTracker = {}

TimeTracker.start_time = nil
TimeTracker.total_time = 0
TimeTracker.is_tracking = false

function TimeTracker.start()
   if not TimeTracker.is_tracking then
      TimeTracker.start_time = os.time()
      TimeTracker.is_tracking = true
   end
end

function TimeTracker.stop()
   if TimeTracker.is_tracking then
      local current_time = os.time()
      TimeTracker.total_time = TimeTracker.total_time + (current_time - TimeTracker.start_time)
      TimeTracker.is_tracking = false
   end
end

function TimeTracker.reset()
   TimeTracker.total_time = 0
   TimeTracker.start_time = nil
   TimeTracker.is_tracking = false
end

function TimeTracker.get_time(arg)
   if arg == true then
      local total_time = TimeTracker.total_time
      if TimeTracker.is_tracking then
         local current_time = os.time()
         total_time = total_time + (current_time - TimeTracker.start_time)
      end

      local hours = math.floor(total_time / 3600)
      local minutes = math.floor((total_time % 3600) / 60)

      return string.format("%d:%02d", hours, minutes)
   end
   if TimeTracker.is_tracking then
      local current_time = os.time()
      local session_time = TimeTracker.total_time + (current_time - TimeTracker.start_time)
      return os.date("!%X", session_time)
   else
      return os.date("!%X", TimeTracker.total_time)
   end
end

return TimeTracker
