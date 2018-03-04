# README


Use background jobs to process csv files and save records to db.

Master branch:
  Process files with SmarterCSV without saving it. It'll throw errors if the csv file is malformated (e.g. containing escaped quotes). Deployed to Heroku

handle-serialized-json-in-file:
  Saves file to server. File is preprocessed to make it legal for SmarterCSV to process. Not deployed to Heroku.
