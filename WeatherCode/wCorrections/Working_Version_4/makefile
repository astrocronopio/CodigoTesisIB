#
# General Makefile
#
USER_SRCS = Bindatav1.cc MLFitv6.cc wCorrectionsv4_main.cc#$(wildcard *.cc)
#
# Executable names come from the .cc sources in this directory.
# Replace the wildcard expression with .cc file list if you do
# not want to compile all .cc files in this directory
#
EXE = $(patsubst %.cc,%, $(USER_SRCS))#$(patsubst %.cc,%, $(wildcard *.cc))
#
#############################################################

## You should not need to change anything below this line ###

.PHONY: all depend clean


ROOT_CXXFLAGS    = $(shell $(ROOTSYS)/bin/root-config --cflags)
ROOT_LDFLAGS     = $(shell $(ROOTSYS)/bin/root-config --ldflags)
ROOT_LDFLAGS    += $(shell $(ROOTSYS)/bin/root-config --libs)

all: $(EXE)

#%: %.cc
wCorrectionsv4_main: wCorrectionsv4_main.cc
	$(CXX) $^ Bindatav1 MLFitv6 $(ROOT_CXXFLAGS) $(ROOT_LDFLAGS) -lMinuit -o $@

Bindatav1: Bindatav1.cc Bindatav1.h
	$(CXX) -c Bindatav1.cc $(ROOT_CXXFLAGS) $(ROOT_LDFLAGS) -lMinuit -o $@

MLFitv6: MLFitv6.cc MLFitv6.h
	$(CXX) -c MLFitv6.cc $(ROOT_CXXFLAGS) $(ROOT_LDFLAGS) -lMinuit -o $@

#############################################################
# gcc can generate the dependency list

#depend: Make-depend	

#Make-depend: $(USER_SRCS)
#	$(CPP) $(ROOT_CXXFLAGS) -MM $^ > $@

clean:
#	- rm -f *.o  *.so *.ps core Make-depend $(EXE)
	- rm -f *.o  *.so $(EXE)

#-include Make-depend