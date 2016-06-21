# ContentMine Fellowship Interview Assignment
## (a) Use `getpapers` to download  papers related to my project, weevil host plant associations.
I downloaded 118 open access papers that contain both the terms 'Curculionidae' and 'host plant'. xml files were saved. Command:
```bash
getpapers -q 'Curculionidae AND "host plant"' -o OUTPUTDIRECTORY -x
```
To check if the papers are useful, I selected 11 papers at random and checked if they contain host plant information and if that information is original, and the results are as follows 

| article #	 | contains host plant info?| info original?| 
| ---------- |:------------------------:|:-------------:|
| PMC2556394 | y                        | n             |
| PMC2890155 | n                        | -             |
| PMC3088325 | y                        | y             |
| PMC3322136 | n                        | -             |
| PMC3480431 | n                        | -             |
| PMC3800779 | n                        | -             |
| PMC3930711 | n                        | -             |
| PMC4062527 | y                        | y             |
| PMC4212853 | y                        | n             |
| PMC4415217 | n                        | -             |
| PMC4553632 | n                        | -             |

Four papers contain host plant information and two of these are original sources (or the host plant information is reported for the first time).

Some other observation. For the 118 papers, 103 have an .xml file and 15 do not have one. Why? xml not provided by journal?

I experimented with a query for 'aceae', which the ending of plant familiy names, e.g., Asteraceae and Fabaceae. I got 624 open access results. However, a query for 'weevil AND aceae' did not work and the following error was returned.

> error: Malformed or empty response from EuropePMC. Try running again. Perhaps your query is wrong.

## (b) Extract facets using Norm and AMI.
First use AMI to convert xml to html.

> norma --project PROJECTFOLDER -i fulltext.xml -o scholarly.html --transform nlm2html

Use AMI to extract species facets (genus, binomial and genussp), using a for-loop

```bash
for type in genus binomial genussp;
do
 	ami2-species --project PROJECTFOLDER -i scholarly.html --sp.species --sp.type $type;
done
```

Count the number of occurrences of 'results.xml' for each of the three types (genus, species, genussp) generated for the papers.
```bash
for type in genus binomial genussp;
do
	echo The number of papers with a results.xml file for $type is $(find PROJECTFOLDER/*/results/species/$type/results.xml | wc -l) >> facet.type.report;
done
```
Number of papers with results for each facet types.

Number of papers with a results.xml file for **genus** is 76.

Number of papers with a results.xml file for **binomial** is 98.

Number of papers with a results.xml file for **genussp** is 54.

Extract **sequence** (type **dna**) from papers. Other facets, disease, gene, chemical, drug do not apply to the papers I downloaded. Also, not sure if disease, chemical and drug are implemented. No ami2-disease/chemical/drug plugin options.
```bash
ami2-sequence --project PROJECTFOLDER -i scholarly.html --sq.sequence --sq.type dna
```

Two papers were found to have a 'result.xml' file for the **sequence** facet (type **dna**). Command used to count this number:
```bash
find PROJECTFOLDER/*/results/sequence/dna/results.xml | wc -l
```

Aggregate all results for facet type **dna**. 
```bash
ami2-sequence --project curculionide.hostplant --filter file\(\*\*/sequence/dna/results.xml\)xpath\(//result\) -o dnasnippets.xml
```

Aggregate all results for facet types **genus**, **binomial** and **genussp**.
```bash
for type in genus, binomial and gensussp;
do 
	ami2-species --project curculionide.hostplant --filter file\(\*\*/species/$type/results.xml\)xpath\(//result\) -o $type.snippets.xml;
done
```

Append the three aggregated species type xml files into a single xml file. 
```bash
cat binomial.snippets.xml genus.snippets.xml genussp.snippets.xml > species.all.snippets.xml
```

Extract lines containing the string "aceae", which is the ending of plant names.
```bash
grep aceae > species.all.aceae.xml
```


