while read p; do
	fname=`basename $p`
	mv $p.html $p/$fname.html
done <html_files.txt
