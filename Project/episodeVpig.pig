inputDialogues = LOAD 'hdfs:///user/episodeV_dialouges.txt' USING PigStorage('\t') AS (name:chararray, line:chararray);

ranked = RANK inputDialogues;

OnlyDialogues = FILTER ranked BY (rank_inputDialogues > 2);

groupByName = GROUP OnlyDialogues BY name;

names = FOREACH groupByName GENERATE $0 as name, COUNT($1) as no_of_lines;

namesOrdered = ORDER names BY no_of_lines DESC;

STORE namesOrdered INTO 'hdfs:///user/outputs/episodeVoutput' USING PigStorage('\t');
