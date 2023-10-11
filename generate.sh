if [ "$1" == "clean" ]
then 
	flutter clean
	flutter pub get
fi
dart pub run build_runner watch --delete-conflicting-outputs
export error=$?
if [ $error -ne 0 ]
then 
	dart pub run build_runner watch --delete-conflicting-outputs
fi
echo "Generate completed"