// Generic unit test framework
\l logs/log.q
\d .tst

utl.true:{
	if[not -1 10h~type each(x;y);.log.err"utl.true: Incorrect argument types: ",", "sv string type each(x;y);:0b];
	if[not x;.log.err y];
	x
	}
utl.logTestInfo:{.log.out"Running ",string[x]," unit test(s)..."}
utl.nsFuncs:{x where 100=('[type;value])each x:` sv'x,'1_key x}
utl.testDic:{x!count[x]#0b}
utl.createTests:{y set utl.testDic utl.nsFuncs x}
utl.runTests:{x set f!utl.pex each f:key x}
utl.compVars:{raze(x;y)except\:x inter y}

utl.pex:{
	@[value x;[];
	{.log.err"Error running test: ",string[y],", error: ",x;0b}[;x]
	]}

utl.loadTests:{
	f:f where like[;"*.q"]f:key[x]except`tst.q;
	.log.out"Loading test files found: ",", "sv string f;
	system each"l ",/:(1_string x),/:"/",/:string f;
	}

utl.test:{
	t:` sv x,`tests;
	utl.createTests[x;t];
	utl.logTestInfo x;
	utl.logTestInfo count value t;
	utl.runTests t;
	utl.true[all value t;"Failing ",string[x]," tests: ",", "sv string where not value t];
	.log.out"Finished runnning ",string[x]," tests"
	}

utl.checkResults:{
	results:value each` sv/:x,'`tests;
	$[2 all/results;
		[.log.out"All unit tests passing";exit 0];
		[.log.err"Number of failed tests: ",string 2 sum/not results;exit 1]
	]}

utl.testVars:{
        k:key[x]except`;
        utl.true[k~y;string[x]," variable(s) not defined: ",", "sv string utl.compVars[k;y]]
        }

utl.testOutput:{
	out:x each y;
	utl.true[out~z;utl.outputDiff[x;out;z]]
	}

utl.outputDiff:{
	d:", "sv/:(y;z)@\:where not y~'z;
	string[x]," does not have expected output(s): expected: [",(d 0),"], got: [",(d 1),"]"
	}

utl.init:{
	utl.loadTests`:tests;
	modules:key[`.tst]except``utl;
	.log.out"Starting unit tests...";
	utl.test each modules;
	utl.checkResults modules
	}


utl.init[]

\d .