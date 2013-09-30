us-code-sd
==========

XSL Translation for the US Code into StateDecoded
To translate the code:

1. Modify the Saxon location in `translate.sh` to your environment's location
2. Run `./translate.sh`
	- This will create all of the StateDecoded XML files in `./sd/`
	
Todo:

- Some files have translated without text bodies and some are repealed.  We need to add the repealed tag for repealed laws and find out why some don't have text sections