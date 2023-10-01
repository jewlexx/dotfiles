import sys
import subprocess

args = sys.argv[1:];
args.insert(0,'code');

subprocess.run(args, shell=True,capture_output=True,text=True);

print(result.stdout)

exit(0)
