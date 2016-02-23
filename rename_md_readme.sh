while read p; do
	dname=`dirname $p`
	mv $p.md $dname/README.md
done <md_files.txt
