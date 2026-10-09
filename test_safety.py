import unittest,subprocess,tempfile,pathlib,os
ROOT=pathlib.Path(__file__).resolve().parent
class Safety(unittest.TestCase):
 def test_missing_nmcli_no_password_or_changes(self):
  with tempfile.TemporaryDirectory() as d:
   p=subprocess.run(['/bin/bash',str(ROOT/'hotspot.sh'),'--ssid','sample'],env={**os.environ,'PATH':d},input='',capture_output=True,text=True,timeout=3)
   self.assertEqual(p.returncode,1);self.assertIn('No network changes made',p.stdout);self.assertNotIn('Wi-Fi password',p.stdout+p.stderr)
 def test_help_no_nmcli(self):
  with tempfile.TemporaryDirectory() as d:
   p=subprocess.run(['/bin/bash',str(ROOT/'hotspot.sh'),'--help'],env={**os.environ,'PATH':d},capture_output=True,text=True,timeout=3)
   self.assertEqual(p.returncode,0);self.assertIn('Usage:',p.stdout)
 def test_redacted_command_log(self):
  self.assertNotIn('${BASH_COMMAND}',(ROOT/'hotspot.sh').read_text())
 def test_menu_local_confirm(self):
  s=(ROOT/'hotspot_menu.py').read_text();self.assertIn('local console with recovery access?',s);self.assertIn("if not shutil.which('nmcli')",s)
 def test_no_auto_manager_install(self):
  for name in ['hotspot.sh','hotspot_menu.py','app-store.sh']:
   s=(ROOT/name).read_text();self.assertNotIn('apt install network-manager',s);self.assertNotIn('systemctl enable NetworkManager',s)
if __name__=='__main__':unittest.main()
