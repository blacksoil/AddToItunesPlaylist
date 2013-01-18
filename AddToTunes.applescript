--Source: http://www.netstreamshifter.com/2009/05/quick-add-playin-track-to-itunes.html
-- Author: 

set currentApp to current application
tell currentApp
     activate
     set myList to the text returned of (display dialog "Enter playlist to add track to" default answer "")
end tell

--exit if they didn't enter anyting
if the myList is "" then return

--make sure itunes is running
set okflag to my itunes_is_running()

if okflag then
   set myMessage to ""
   tell application "iTunes"
   	set oldfi to fixed indexing
	    set fixed indexing to true
	    	set thisTrack to (get location of current track)
		    set dbid to (get database ID of current track)
		    	
				--see if the playlist exists
				      if exists user playlist myList then
				      	 	--do nothing for now
						     else
								make new user playlist with properties {name:myList}
								     end if
								     	 set currentList to playlist myList
									     
										--see if the track exists on the playlist
										      set currentIDs to {}
										      	  try
													if exists (track 1 of currentList) then -- if there are some tracks - at least one -- get their ids
													   	  	 copy (get database ID of every track of currentList) to currentIDs -- list
															      	   end if
																       on error errText number errnum
																       	  	if errText does not contain "Invalid index." then
																		   	   	error errstr number errnum
																				      	     end if
																					     	 end try
																						     
																						      --add the track to playlist or show error
																						      	    if currentIDs does not contain dbid then -- if id not already present add the track
																							       		  add thisTrack to currentList
																									      		set myMessage to " Track added to playlist " & myList
																											    else
																											      set myMessage to " Selected track already on playlist " & myList
																											      	  end if
																												      set fixed indexing to oldfi
																												      end tell
end if

--show our output message
-- Check if Growl is running:
tell application "System Events"
     set isRunning to ¬
     	 (count of ¬
	 	   (every process whose name is "GrowlHelperApp")) > 0
end tell

on itunes_is_running()
   tell application "System Events" to return (exists process "iTunes")
end itunes_is_running

--this is commented out because I found this to be too slow
--put the focus back on the app we were using before we called this script with quicksilver
--quicksilver became the frontmost app because it's what executed this script
--tell application "System Events"
-- keystroke tab using (command down)
-- set app_name to name of the first process whose frontmost is true
-- keystroke tab using (command down)
--return app_name
--end tell

