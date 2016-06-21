for type in genus binomial genussp;
do 
	ami2-species --project curculionidae.hostplant --filter file\(\*\*/species/$type/results.xml\)xpath\(//result\) -o $type.snippets.xml;
done
