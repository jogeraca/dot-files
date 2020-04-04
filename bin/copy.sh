
projectPath="/home/yoser/src/liftit/core/apps/admin/priv/gettext/"
cd $projectPath 
pwd
for i in `find  -type f -name "*.po"` 
do
	echo $dir
	dir=`echo $i | cut -dL -f1`
	echo $dir
	cd /tmp/po
	mkdir -p $dir
	echo "cp -R ${projectPath}${i} ${dir}"
	cp   "$projectPath$i" ${dir}
done
