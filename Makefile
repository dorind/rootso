# does you project need linking with additional library?
LIB_INC = 
# example with lz4
#LIB_INC = -llz4

ROOTCFLAGS    = $(shell root-config --cflags)
ROOTLIBS      = $(shell root-config --libs)
CXX           = $(shell root-config --cxx)
CXXFLAGS      = -g -Wall -fPIC $(LIB_INC)

# set the cpp version as necessary
#CXXFLAGS += -std=c++11
#CXXFLAGS += -std=c++14
#CXXFLAGS += -std=c++17
#CXXFLAGS += -std=c++20

CXXFLAGS  += $(ROOTCFLAGS)
LDFLAGS   += $(ROOTLIBS)

# any additional includes?
INC =
#INC = path/to/include

PACKAGE = rootso
HEADERS = $(filter-out $(CURDIR)/LinkDef.h, $(wildcard $(CURDIR)/*.hpp))
SOURCES = $(wildcard $(CURDIR)/*.cpp) $(filter-out $(CURDIR)/*Dict.cxx, $(wildcard $(CURDIR)/*.cxx))
TARGET_LIB = $(PACKAGE).so
DICTIONARY = $(PACKAGE)Dict.cxx

# additional headers
#HEADERS += path/to/header.h or path/to/header.hpp
#SOURCES += path/to/src.cpp or path/to/src.cxx or path/to/src.cc

all: $(TARGET_LIB)

$(TARGET_LIB): $(SOURCES) $(DICTIONARY)
	@echo "  Building $(TARGET_LIB)..."
	@$(CXX) $(CXXFLAGS) $(INC) $(LDFLAGS) -shared -o $@ $^

$(DICTIONARY): $(HEADERS) LinkDef.h
	@echo "  Making dictionary for $(PACKAGE)..."
	@rootcling -f $@ $(INC) -rml $(TARGET_LIB) -rmf lib$(PACKAGE).rootmap -s $(TARGET_LIB) $^

clean:
	@echo "  Cleaning $(PACKAGE)..."
	@rm -f $(TARGET_LIB)
	@rm -f $(DICTIONARY)
	@rm -f $(DICTIONARY:%.cxx=%.h)
	@rm -f *rdict.pcm
	@rm -f *_tmp_*
	@rm -f *.rootmap
	@rm -f $(PACKAGE)

.PHONY: clean all



