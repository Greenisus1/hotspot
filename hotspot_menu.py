import curses,shutil,subprocess
from pathlib import Path
from ui import put,run

def loop(s):
 msg=''
 while True:
  h,w=s.getmaxyx();s.erase();put(s,1,2,'H O T S P O T',curses.A_BOLD)
  if h<22 or w<76:put(s,3,2,'Resize to 76x22. Q exits.')
  else:
   lines=['NetworkManager clone mode and DietPi native hotspot are different.', 'nmcli: '+(shutil.which('nmcli') or 'missing - clone route disabled'), '', 'H: existing clone script help (read only)', 'R: review existing NetworkManager clone route', '', 'DietPi native setup needs Ethernet + a supported Wi-Fi adapter.', 'Run dietpi-software, select WiFi HotSpot and review installation.', 'Then dietpi-config > Networking Options: Adapters > WiFi for SSID/key.', 'It uses hostapd + isc-dhcp-server, not NetworkManager/dnsmasq.', '', 'Network changes can disconnect SSH. Use a local console.', 'No automatic manager installation or credential collection here.', 'Q exits.', '',msg]
   for i,line in enumerate(lines):put(s,3+i,2,line)
  s.refresh();k=s.getch()
  if k in (ord('q'),ord('Q')):return
  if h<22 or w<76:continue
  if k in (ord('r'),ord('R')):
   if not shutil.which('nmcli'):
    msg='No nmcli. No changes made; use DietPi guidance above.';continue
   curses.def_prog_mode();curses.endwin()
   try:
    print('Clone mode changes live networking and can disconnect SSH.')
    if input('Continue at a local console with recovery access? [y/N] ').lower()=='y':subprocess.run(['bash',str(Path(__file__).with_name('hotspot.sh'))])
    input('Press Enter to return...')
   finally:curses.reset_prog_mode();s.clearok(True)
  elif k in (ord('h'),ord('H')):
   curses.def_prog_mode();curses.endwin()
   try:subprocess.run(['bash',str(Path(__file__).with_name('hotspot.sh')),'--help']);input('Press Enter to return...')
   finally:curses.reset_prog_mode();s.clearok(True)
if __name__=='__main__':raise SystemExit(run(loop))
