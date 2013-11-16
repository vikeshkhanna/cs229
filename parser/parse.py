# @author - Vikesh Khanna
# This file takes as input the data from FootballData.co.uk in csv format and extracts the following different csv files-
# teams - csv file with each team name. The row number of the team is important as it will be used as pointer in other matrices
# train - The training matrix csv. There are 2*(n+1) columns. Each n+1 columns is teamID and the n features we are capturing. (see legend)

import csv
import sys
import numpy as np
import scipy.io as io 
from utils import *

OUTFILE='data.mat'

def legend(legend_file):
	pass

def main(args):
	if len(args)<2:
		print("Usage: python parse.py <csv_file> <legend>")
		sys.exit(1)

	csvfile = args[0]
	legend_file = args[1]

	legend(legend_file)
	f = open(csvfile)
	reader = csv.reader(f)

	# Should match the Feature class elements
	header = reader.next()
		
	# team list
	teams = []

	# train matrix - 2*(n+1) rows. Each row is a match. First row is the team ID, n+1 features of home team, (1, n+1) features of the away team
	train = []

	for row in reader:
		features = {Constants.HOME : [], Constants.AWAY: []}
		outcome = None

		for i in range(len(row)):
			feature = row[i]
			field = header[i]

			if field == Features.HomeTeam or field == Features.AwayTeam:
				if feature not in teams:
					teams.append(feature)

			# Header contains the feature - Useful feature. Must.Take
			if field in Features.FMAP:
				# Find home or away
				location = Features.FMAP[field]
					
				if field==Features.HomeTeam or field==Features.AwayTeam:
					feature = teams.index(feature) + 1	
				else:
					feature = float(feature)
				
				# Add feature to the appropriate list
				features[location].append(feature)	
			
			elif field==Features.FTR:
				outcome = Features.FTR_MAP[feature]

		# Horizontally join the two lists	
		train.append(features[Constants.HOME] + features[Constants.AWAY] + [outcome])

	#Write to mat file
	np_teams = np.array(teams)
	np_train = np.array(train)
	np_dict = {'teams':np_teams, 'train':np_train}
	
	io.savemat(OUTFILE, np_dict)

if __name__=="__main__":
	main(sys.argv[1:])

