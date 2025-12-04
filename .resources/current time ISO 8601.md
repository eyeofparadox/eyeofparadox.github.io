# Source - https://stackoverflow.com/a
# Posted by rom99
# Retrieved 2025-11-30, License - CC BY-SA 4.0



PowerShell 

• Open PowerShell and run the following command to get the current local time in ISO 8601 format: 

	•  Get-Date -Format "o"
2025-11-30T01:51:26.2795751-08:00

• To get the time in UTC (Coordinated Universal Time), use[2, 4]: 

	• (Get-Date).ToUniversalTime().ToString("o")

Changing regional settings 

• Go to Settings &gt; Time & language &gt; Region.  
• Under the Formats section, click Additional settings.  
• Navigate to the Date tab and select Short date.  
• Change the format to  and click Apply.  
• Note: The built-in regional settings may not provide a format that includes the full time component in a single, standardized ISO 8601 string. You may need to use PowerShell for a complete time format. [1, 2, 3]  

AI responses may include mistakes.

[1] https://superuser.com/questions/1623211/can-i-display-windows-toolbar-date-in-iso-8601-format  
[2] https://stackoverflow.com/questions/45689471/windows-iso-8601-timestamp  
[3] https://www.youtube.com/watch?v=kNlCqW_yXqg  
[4] https://stackoverflow.com/questions/71788574/how-to-get-time-in-current-time-zone-from-iso-8601-strings

(Get-Item FILENAME).LastWriteTime.ToString("yyyy-MM-ddTHH:mm:ssZ")

PowerShell
For specific scripting or automation, you can get a file's last modified time in ISO 8601 format using PowerShell commands:  
Open PowerShell and use the following command, which will output the date and time in a standard format that is generally ISO 8601 compatible:
``` powershell
(Get-Item FILENAME).LastWriteTime.ToString("yyyy-MM-ddTHH:mm:ssZ")
``` 
(Replace FILENAME with the actual path to your file. The Z indicates UTC time). 