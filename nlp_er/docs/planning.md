## Goal and requirements for the nlp_er healthcare project.

Primary goal:
1. Create a nlp entity recogonition model that can identify side effects of drugs.

Requirements:
1. Achieve a 80% accuracy.
2. Reduce file size.
3. Allow running from terminal.
4. Implement standard SE practices.


#### Detailed:
- er.py: Runs ER analysis and outputs.
	* Main
	* 
- data_check.py: Searches for data w/ correct extension. Cleans and formats data.
	* Main
	* search_for_data:
		> Checks for data dir. If missing, create.
		> Checks for files ending in '.txt'
		> Reads in each file.
	* clean_data
- lib.py: helper functions
	* 

Secondary goal:
1. Pull data from web only when needed. Looked up terms with API.
