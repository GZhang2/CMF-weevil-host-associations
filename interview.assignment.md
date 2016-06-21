# ContentMine Fellowship Interview Assignment
## (a) Use `getpapers` to download  papers related to my project, weevil host plant associations.
I downloaded 118 open access papers that contain both the terms 'Curculionidae' and 'host plant'. xml files were saved. Command:
> getpapers -q 'Curculionidae AND "host plant"' -o OUTPUTDIRECTORY -x

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

```for type in genus binomial genussp;
do
 	ami2-species --project PROJECTFOLDER -i scholarly.html --sp.species --sp.type $type;
done
```