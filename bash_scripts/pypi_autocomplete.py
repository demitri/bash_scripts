#!/usr/bin/env python

'''
This script prints a list of all available Python packages from http://pypi.python.org.
It is intended to be used with bash autocomplete.
'''

import os
import re
import sys
import time
import string
import argparse
import urllib.request

# --------
# argparse
# ---------------------------------------------------------
parser = argparse.ArgumentParser(description="List available Python packages from http://pypi.python.org.")
parser.add_argument('-i', '--case-insensitive',
					help = "case insensitive search",
					action="store_true",
					default=False)

group = parser.add_mutually_exclusive_group()
group.add_argument('-c', '--contains',
					help = "list packages that contain provided string",
					default=None)
group.add_argument('-s', '--starts-with',
					help = "list packages that start with provided string",
					default=None)

args = parser.parse_args()
# ---------------------------------------------------------

def package_list_from_url():
	# fetch list of PyPi packages
	response = urllib.request.urlopen('https://pypi.python.org/simple/') # simple list of all packages
	html = response.read().decode("utf-8")
	package_list = re.findall("'>([^<]+)</a>", html)
	return package_list

autocomplete_cache_directory = os.path.join(os.environ["HOME"], '.autocomplete_cache')
pypi_package_list_file = os.path.join(autocomplete_cache_directory, 'pypi_packages.txt')

if os.path.exists(autocomplete_cache_directory) == False:
	# create cache directory
	os.makedirs(autocomplete_cache_directory.as_posix())

package_list = None

if os.path.exists(pypi_package_list_file):
	
	# get age of file in seconds
	age = time.time() - os.stat(pypi_package_list_file).st_mtime
	if age < 60*60*24:
		with open(pypi_package_list_file) as f:
			package_list = f.read().split()
	else:
		pass
		# file is older than a day, refetch below

if package_list == None:
	package_list = package_list_from_url()	
	# write to cache
	with open(pypi_package_list_file, mode='w') as f:
		f.write("\n".join(package_list))

match_list = list()
if args.contains:
	for package in package_list:
		if args.case_insensitive:
			if args.contains.lower() in package.lower():
				match_list.append(package)
		else:
			if args.contains in package:
				match_list.append(package)
	
	print(" ".join(match_list))
	sys.exit(0)

elif args.starts_with:
	for package in package_list:
		if args.case_insensitive:
			if package.lower().startswith(args.starts_with.lower()):
				match_list.append(package)
		else:
			if package.startswith(args.starts_with):
				match_list.append(package)
	
	print(" ".join(match_list))
	sys.exit(0)
		
print(" ".join(package_list))





