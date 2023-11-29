CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'
CPATH2='.:lib/junit-4.13.2.jar:lib/hamcrest-core-1.3.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

set -e 

if [[ -f ./student-submission/ListExamples.java ]]
then
	cp -r ./student-submission/* ./grading-area
	cp -r ./lib ./grading-area
	cp TestListExamples.java ./grading-area
	set +e
	cd grading-area
	javac -cp "$CPATH" *.java
	code=$?
        if [[ $code -ne 0 ]]
        then
                echo 'Compiled incorrectly! No points.'
		exit
	fi
	java -cp "$CPATH2" org.junit.runner.JUnitCore TestListExamples 
	code=$?
	if [[ $code -ne 0 ]]
	then
		echo 'Test Errored! No points.'
	else
		echo 'Tests Passed! Full points'
	fi

else
	echo ''
	echo 'Missing File(s)'
	exit
fi
