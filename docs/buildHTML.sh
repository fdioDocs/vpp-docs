# Script that builds the .rst file into index.html in _builds/html,
# and then opens it in your browser (or your default html opening application).

# To run the script, inside the dir where this file is located, run:
# sh buildHTML.sh

current_dir=$PWD
i=0;

while [ ! -f conf.py ]
	do
		if [ $i -eq 5 ]
			then
				echo "Error: Could not find main dir where conf.py is located!" 1>&2; break
		else
			cd ..; i=$((i+1))
		fi
done


if [ ! -f "conf.py" ] || [ ! -f "index.rst" ] 
	then echo "Error: conf.py and/or index.rst not found. Did NOT build!" 1>&2; cd $current_dir
else
	make html; cd ./_build/html; open index.html;cd $current_dir
fi

