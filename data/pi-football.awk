BEGIN{
	correct = 0;
	total = 0;
}
{
	ph = $8;
	pd = $9;
	pa = $10;
	result = $7;
	total += 1;
	
	if((ph>pd && ph>pa && result=="H") || 
		(pd>ph && pd>pa && result=="D") ||
		(pa>ph && pa>pd && result=="A"))
	{
		correct += 1;
	}
}
END{
	print "Total: " total;
	print "Correct: " correct;
	print "Accuracy: " correct/total;
}
