ML:0^first"J"$.Q.opt[.z.x]`ml
\d .ml

utl.fp:{x+/:y mmu z}
utl.rand:{$[0<type x;x[1]cut prd[x]?y;x?y]}[;1f]
utl.ohe:{@'[;u?y;:;1f](count each(x;u:distinct y))#0f}

utl.relu:0|
utl.dRelu:0 1@0<
utl.sig:1%1+exp neg@
utl.dSig:{utl.sig[x]*1-utl.sig x}
utl.softMax:{e%sum each e:exp x}

per.predict:{utl.sig utl.fp[x 1;x 0;y]}
per.genPerceptron:{[ep;i;o]	// i(nputs) o(utputs) w(eights) b(ias)
	w:count[i]?1f;b:rand 1f;
	ep per.trn[i;o]/(w;b)
	}

per.trn:{[i;o;z]
	w:z 0;b:z 1;
	p:utl.sig utl.fp[b;w;i];  // p(redictions)    
	0N!avg xexp[;2]e:p-o;                   // e(rror)
	dw:e*utl.dSig p;
	(w-sum dw*flip i;b-sum dw)
	}

net.predict:{utl.softMax utl.fp[x 3;;x 2]utl.sig utl.fp[x 1;y;x 0]}
net.genNeuralNet:{[ep;i;o;hn;lr]
	// ep(ochs) i(nput) o(utput) h(idden)n(eurons) l(earning)r(ate)
	// Generate random weights and biases
	wb:utl.rand each(count[first i],hn;hn;hn,c;c:count first o);
	ep net.trn[i;o;lr]/wb
	}

net.trn:{[i;o;lr;wb]
	// w(eight) b(ias) h(idden) o(utput)
	wh:wb 0;bh:wb 1;wo:wb 2;bo:wb 3;
	// Forward propagate
	zh:utl.fp[bh;i;wh];
	ah:utl.sig zh;
	ao:utl.softMax utl.fp[bo;ah;wo];
	0N!2 sum/neg o*log ao;
	// Back propagation
	e:ao-o;         	// e(rror)
	dwo:mmu[flip ah;e];
	dah:mmu[e;flip wo]*utl.dSig zh;
	dwh:mmu[flip i;dah];
	// Adjust weights and biases
	wb-lr*(dwh;sum dah;dwo;sum e)
	}

//Init
par.data:@[get;`:MLCommands;([]input:`$();output:())];
par.cmd:distinct par.data`output
par.words:distinct raze" "vs/:par.data`input
par.activate:9h$par.words in" "vs
	
par.trn:{[ep;lr]
	o:utl.ohe . value flip par.data;
	i:par.activate each par.data`input;
	hn:floor avg('[count;first])each(i;o);
	net.genNeuralNet[ep;i;o;hn;lr]
	}

par.init:{[ep;lr]
	if[not count par.data;ML::0;:"No training data"];
	wb:@[get;`:wb;{par.trn[y;z]}[;ep;lr]];
	par.wb:wb;
	par.predict:net.predict wb;
	par.getCmd:par.cmd{x?max x}first par.predict enlist par.activate@;
	}

\d .

if[ML;.ml.par.init[2000;0.001]];
