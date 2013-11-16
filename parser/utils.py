class Constants:
	HOME='Home'
	AWAY='Away'
	NONE='None'

class Features:
	FTHG='FTHG'
	FTAG='FTAG'
	HST='HST'
	AST='AST'
	HHW='HHW'
	AHW='AHW'
	HC='HC'
	AC='AC'
	FTR='FTR'
	HomeTeam='HomeTeam'
	AwayTeam='AwayTeam'
	
	# Map to tell the result. 1 - Home win, 2 - Away win,  3 - Draw
	FTR_MAP	 = {
		'H':1,
		'A':2,
		'D':3
	}

	# Map of which feature is home and which one is away
	FMAP = {
		FTHG: Constants.HOME,
		FTAG: Constants.AWAY,
	
		HST: Constants.HOME,
		AST: Constants.AWAY,

		HHW: Constants.HOME,
		AHW: Constants.AWAY,

		HC: Constants.HOME,
		AC: Constants.AWAY,
		
		HomeTeam: Constants.HOME,
		AwayTeam: Constants.AWAY
	}
