batterywidget = widget({ type = "textbox" })                                    
batterywidget.text = " | Battery | "                                            
batterywidgettimer = timer({ timeout = 5 })                                     
batterywidgettimer:add_signal("timeout",                                        
  function()                                                                    
    fh = assert(io.popen("acpi | cut -d, -f 2,3 -", "r"))                       
    batterywidget.text = " |" .. fh:read("*l") .. " | "                         
    fh:close()                                                                  
  end                                                                           
)                                                                               
batterywidgettimer:start()
