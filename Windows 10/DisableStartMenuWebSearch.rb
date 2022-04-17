require 'win32/registry' 
require 'io/console'

#used to set a String value for a registry key 
def set_key_value(hive,key_path, key_name, key_value)
begin
    reg_key=hive.open(key_path, Win32::Registry::KEY_WRITE) 
    reg_key.write(key_name,Win32::Registry::REG_DWORD,key_value) 
    puts "Set key: #{key_path}\\#{key_name} to #{key_value}"
rescue Win32::Registry::Error 
    puts "Error setting key value:"
    return false
end 
true
end

set_key_value(Win32::Registry::HKEY_CURRENT_USER,"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Search","BingSearchEnabled", 0)
set_key_value(Win32::Registry::HKEY_CURRENT_USER,"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Search","AllowSearchToUseLocation", 0)
set_key_value(Win32::Registry::HKEY_CURRENT_USER,"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Search","CortanaConsent", 0)

#Restart explorer.exe
puts "Restarting explorer.exe"
system("cmd /c \"taskkill /f /im explorer.exe && start explorer\"")

print "Done. Press any key to close"
STDIN.getch