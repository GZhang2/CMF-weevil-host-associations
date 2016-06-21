#!/bin/bash
for type in genus binomial genussp;
do
	echo The number of papers with a results.xml file for $type is $(find curculionidae.hostplant/*/results/species/$type/results.xml | wc -l) >> facet.type.report;
done
