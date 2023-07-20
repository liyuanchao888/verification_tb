import subprocess
member = {
'user_name_xxxxx' : 'email_name@126.com'
		}
#output = subprocess.check_output('whoami',shell=True)
#name = output.decode().strip()
name='user_name_xxxxx'
subprocess.call('chmod 600 ~/.ssh/id_isa',shell=True)
subprocess.call('rm ~/.ssh/known_hosts',shell=True)
if name in member:
	print('git config --global user.email "{0}"'.format(member[name]))
subprocess.call('git config --global user.name "{0}"'.format(name),shell=True)
subprocess.call('git config --global user.email "{0}"'.format(member[name]),shell=True)
subprocess.call('ssh-keygen -t rsa -C "{0}"'.format(member[name]),shell=True)

#cp id_rsa.pub to github/gitlab ssh-key setting
