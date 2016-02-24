while read p; do
	dname="$(dirname $p)"
	sname="$(basename $dname)"
	echo "s:$sname/:./:g"
	find $p -type f -exec sed -i "s:$sname/:./:g" {} \;
	find $p -type f -exec sed -i "s:./::g" {} \;
done <md_files.txt
