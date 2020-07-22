
ROOTSYS=$(shell root-config --prefix)
CHECK_ROOT6 = $(shell echo "gROOT->GetVersion()" | root -l | grep -v Autoloading | grep -c "6\.")
ifeq ($(CHECK_ROOT6),1) 
#ROOT-CONFIG=$(ROOTSYS)/build/bin/root-config
ROOT-CONFIG=$(ROOTSYS)/bin/root-config
LIBFIASCO=libGCU.$(shell $(ROOT-CONFIG) --version | sed "s/\//./g")
else
ROOT-CONFIG=$(ROOTSYS)/bin/root-config
LIBFIASCO=libGCU.$(shell $(ROOT-CONFIG) --version | sed "s/\//./g")
endif


DOC_DIR=docs

######### ATTENZIONE AL -pipe.....
OPTIMIZE = -O3 -pipe  -fPIC
#OPTIMIZE += -fkeep-inline-functions
## c'e' un baco con gcc 3.2: con questo truccaccio sembra andare a posto...
#OPTIMIZE += $(shell  gcc -v 2>1 ; cat 1 | grep "version 3.2" >/dev/null && echo "-fschedule-insns"; rm -f 1)




#COMPILER = g++ -std=c++11 -Wall  -pipe 
COMPILER = g++  -Wall  -pipe 

#ROOT_INCLUDE  =/usr/include/root
ROOT_INCLUDE =$(shell $(ROOT-CONFIG) --incdir)
#ROOT_LIB      =/usr/lib
ROOT_LIB =$(shell $(ROOT-CONFIG) --libdir)
#ROOTCINT      =/usr/bin/rootcint
ROOTCINT =$(shell $(ROOT-CONFIG) --bindir)/rootcint

#uhal libraries include
CACTUS_ROOT = /opt/cactus

UHAL_LIB = $(CACTUS_ROOT)/lib/libcactus_uhal_uhal.so
#=======
#ROOT_INCLUDE  =$(shell $(ROOT-CONFIG) --incdir)
#ROOT_LIB      =$(shell $(ROOT-CONFIG) --libdir)
#ROOTCINT      =$(shell $(ROOT-CONFIG) --bindir)/rootcint

INCLUDE=-I$(ROOT_INCLUDE) -I. -I${CACTUS_ROOT}/include

# remove comment to use ARC SPLINE (libgsl0-dev  must be installed and
# root must be reconfigured to compile libMathMore)
# INCLUDE+= -DUSE_ARC_SPLINE

ROOTCINT_DEFINES = -I${CACTUS_ROOT}/include


## per usare questa funzione bisogna che il target COINCIDA col SOLO nome della classe.so
## ad esempio FSignal.so NON FSignal FSignal.c++ o altro, e che inoltre i vari
## file di link FSignal.h FSignal.cxx FSignalLinkDef.h siano ok.
## $@ rappresenta il target...
##
## togliere i "@" per vedere i comandi
##
define COMPILA
	@ - rm -f $(subst .so,,$@).so $(subst .so,,$@)Dict.cxx $(subst .so,,$@)Dict.h
	@ cat VuotoLinkDef.h | sed s/Vuoto/$(subst .so,,$@)/g > $(subst .so,,$@)LinkDef.h	

	@ echo "$(HOSTNAME): GCC      $(subst .so,,$@)"	
	 $(COMPILER) $(OPTIMIZE) $(INCLUDE) -c $(subst .so,,$@).cxx

	@ echo "$(HOSTNAME): ROOTCINT $(subst .so,,$@)"	
	@ $(ROOTCINT)  $(subst .so,,$@)Dict.cxx -c $(ROOTCINT_DEFINES) -p $(subst .so,,$@).h $(subst .so,,$@)LinkDef.h

	@ echo "$(HOSTNAME): GCC      $(subst .so,,$@)Dict"	
	@ $(COMPILER) $(OPTIMIZE) $(INCLUDE) -c $(subst .so,,$@)Dict.cxx

	@ echo "$(HOSTNAME): LD       $(subst .so,,$@).so"	
	@ $(COMPILER) $(OPTIMIZE) -L${CACTUS_ROOT}/lib  -lcactus_uhal_log -lcactus_uhal_grammars -lcactus_uhal_uhal -ldl -shared $(CAEN_LIB) $(CAEN_VMELIB)  -g $(subst .so,,$@).o $(subst .so,,$@)Dict.o -o $(subst .so,,$@).so 

	@ echo "$(HOSTNAME): ---> $(subst .so,,$@).so done."
	@ - rm -f $(subst .so,,$@)LinkDef.h $(subst .so,,$@)Dict.cxx $(subst .so,,$@)Dict.h\
		$(subst .so,,$@).cxx~  $(subst .so,,$@).h~ 



endef
##########################################################
##########################################################
##
## per aggiungere una nuova classe basta metterla in questo elenco qui :-))
##
SHAREDS=FGCUControl.so FGCUDspBoard.so FGCUDsp.so


all:    
	@ echo "using ROOT found in $(ROOTSYS) ..."
#	@ ${MAKE} depend 
	@ echo "checking for 64bit cpus..."
	@- rm -f cpu64bit.h
	@- $(ROOT-CONFIG) --arch | grep  linuxx8664gcc >/dev/null && echo "#define CPU64BIT" > cpu64bit.h
	@ touch  -t 0001010000 cpu64bit.h
	@ ${MAKE} $(SHAREDS)  $(LIBFIASCO).so  
	@ ${MAKE} $(LIBFIASCO).rootmap 
#	-@ make docs
	@echo "per generare la documentazione: make docs"
	@ ls -l $(LIBFIASCO).so  
	@ echo " ################### Done.####################"


#	- @echo ">>>>>>> Controllo versione: " $(shell cat   $(subst .so,.h,$(SHAREDS))  $(subst .so,.cxx,$(SHAREDS)) > /tmp/version.C ; md5sum /tmp/version.C  | sed s/" .*"//g; rm -f /tmp/version.C)
	@echo

clean:
	- rm -f *~ $(SHAREDS) $(subst .so,.o,$(SHAREDS))  $(subst .so,Dict.o,$(SHAREDS))   $(subst .so,Dict.cxx,$(SHAREDS))   $(subst .so,Dict.h,$(SHAREDS)) x.o read_tape.o fftw_switch.h a.o FClasses_*.d dbedit_dsp.out FFilter.so $(LIBFIASCO).* *rootmap

#depend: FClasses_$(HOSTNAME).d

#FClasses_$(HOSTNAME).d: $(subst .so,.cxx,$(SHAREDS)) $(subst .so,.h,$(SHAREDS)) 
#	@echo "***** BUILDING DEPENDENCIES (out: FClasses_$(HOSTNAME).d) ***********"
#	- makedepend -f- -o.so  -- $(INCLUDE) --  $(subst .so,.cxx,$(SHAREDS)) > FClasses_$(HOSTNAME).d  2>/dev/null && echo "*****  makedepend ok *****"
#	- cat  FClasses_$(HOSTNAME).d | sed s/"c\.o"/so/g > a.d && mv a.d  FClasses_$(HOSTNAME).d

#-include FClasses_$(HOSTNAME).d

$(LIBFIASCO).so: $(SHAREDS)
	- rm -v libGCU.*.so
	@echo "$(HOSTNAME): LD       $(LIBFIASCO).so "
	@ $(COMPILER) -L${CACTUS_ROOT}/lib -lcactus_uhal_log -lcactus_uhal_grammars -lcactus_uhal_uhal -shared $(subst .so,.o,$(SHAREDS))  $(subst .so,Dict.o,$(SHAREDS)) -o $(LIBFIASCO).so 
	@ echo "$(HOSTNAME): ---> $(LIBFIASCO).so done."
	@ echo ""
	@echo "Generazione di FIASCO.h..."
	@ ./accapo.sh  $(subst .so,.h,$(SHAREDS)) | sed "s/^F/#include <F/g" | sed "s/^G/#include <G/g" | sed "s/^P/#include <P/g" | sed "s/\.h/\.h>/g" | grep -v libx | grep -v fftw.a > FIASCO.h
	@ echo "" >> FIASCO.h
	date > ZZZ_LastMakeDate.txt	

###################################################################################

$(LIBFIASCO).rootmap:
	- rm -f *.rootmap
	@  ./do_manymap $(LIBFIASCO) $(subst .so,,$(SHAREDS)) > $(LIBFIASCO).rootmap
# the next line needed to add libCAENDigitizer.so to the FCAENDigitizer line in rootmap

%.so: NAME=$(subst .so,,$@)
%.so:  %.cxx %.h
	$(COMPILA)
