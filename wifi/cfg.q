//Fill in known MAC address dictionary
cfg:(!). flip(
	(`devices;([]MAC:`symbol$();name:();item:()));
	(`knownMAC;()!())
	)
