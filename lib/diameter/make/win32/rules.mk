#-*-makefile-*-   ; force emacs to enter makefile-mode
# ----------------------------------------------------
# %CopyrightBegin%
#
# Copyright Ericsson AB 2009-2011. All Rights Reserved.
#
# The contents of this file are subject to the Erlang Public License,
# Version 1.1, (the "License"); you may not use this file except in
# compliance with the License. You should have received a copy of the
# Erlang Public License along with this software. If not, it can be
# retrieved online at http://www.erlang.org/.
#
# Software distributed under the License is distributed on an "AS IS"
# basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
# the License for the specific language governing rights and limitations
# under the License.
#
# %CopyrightEnd%

.SUFFIXES: .erl .beam .yrl .hrl .xml .xmlsrc .html \
        .3 .1 .pdf .fo .el .elc

# ----------------------------------------------------
#       Common macros
# ----------------------------------------------------
DEFAULT_TARGETS = opt debug release release_docs clean docs


# Slash separated list of return values from $(origin VAR)
# that are untrusted - set default in this file instead.
# The list is not space separated since some return values
# contain space, and we want to use $(findstring ...) to
# search the list.
DUBIOUS_ORIGINS = /undefined/environment/


# # ----------------------------------------------------
# # TARGET definition
# # ----------------------------------------------------
# # TARGET = win32
# ifneq ($(OVERRIDE_TARGET),)
# ifneq ($(TARGET), $(OVERRIDE_TARGET))
# $(warning overriding $$(TARGET) = \
#         "$(TARGET)" \
#         with \
#         $$(OVERRIDE_TARGET) = \
#         "$(OVERRIDE_TARGET)")
# override TARGET := $(OVERRIDE_TARGET)
# endif
# endif
# 

# ----------------------------------------------------
#       Command macros
# ----------------------------------------------------
PREFIX          = /usr/local
INSTALL         = /usr/bin/install -c
INSTALL_DIR     = /usr/bin/install -c -d
INSTALL_PROGRAM = ${INSTALL}
INSTALL_SCRIPT  = ${INSTALL}
INSTALL_DATA    = ${INSTALL} -m 644


# ----------------------------------------------------
#       Erlang language section
# ----------------------------------------------------
ERL_ROOT_DIR = @ERLANG_ROOT_DIR@
ERL_LIB_DIR = @ERLANG_LIB_DIR@
DOCGEN_DIR = @ERLANG_LIB_DIR_erl_docgen@
TEST_SERVER_DIR = @ERLANG_LIB_VER_test_server@
EMULATOR = beam
ERL_COMPILE_FLAGS += +debug_info
ERLC_WFLAGS = -W
ERLC = $(ERL_ROOT_DIR)/bin/erlc $(ERLC_WFLAGS) $(ERLC_FLAGS)
ERL = $(ERL_ROOT_DIR)/bin/erl -boot start_clean
#ERLC = @ERLC@ $(ERLC_WFLAGS) $(ERLC_FLAGS)
#ERL = @ERL@ -boot start_clean

ifneq (,$(findstring $(origin EBIN),$(DUBIOUS_ORIGINS)))
EBIN = ../../ebin
endif

# Generated (non ebin) files...
ifneq (,$(findstring $(origin EGEN),$(DUBIOUS_ORIGINS)))
EGEN = .
endif

ifneq (,$(findstring $(origin ESRC),$(DUBIOUS_ORIGINS)))
ESRC = .
endif

$(EBIN)/%.beam: $(EGEN)/%.erl
	$(ERLC) $(ERL_COMPILE_FLAGS) -o$(EBIN) $<

$(EBIN)/%.beam: $(ESRC)/%.erl
	$(ERLC) $(ERL_COMPILE_FLAGS) -o$(EBIN) $<

.erl.beam:
	$(ERLC) $(ERL_COMPILE_FLAGS) -o$(dir $@) $<


#
# When .erl files are automatically created GNU make removes them if
# they were the result of a chain of implicit rules. To prevent this
# we say that all .erl files are "precious".
#
.PRECIOUS: %.erl %.fo


# ----------------------------------------------------
#       Documentation section
# ----------------------------------------------------
# export VSN

# TOPDOCDIR=../../../../doc

DOCDIR = ..

PDFDIR=$(DOCDIR)/pdf

HTMLDIR = $(DOCDIR)/html

MAN1DIR = $(DOCDIR)/man1
MAN2DIR = $(DOCDIR)/man2
MAN3DIR = $(DOCDIR)/man3
MAN4DIR = $(DOCDIR)/man4
MAN6DIR = $(DOCDIR)/man6
MAN9DIR = $(DOCDIR)/man9

# HTML & GIF files that always are generated and must be delivered
XML_COLL_FILES = $(XML_APPLICATION_FILES) $(XML_PART_FILES)
DEFAULT_HTML_FILES = \
	$(XML_COLL_FILES:%.xml=$(HTMLDIR)/%_frame.html) \
	$(XML_COLL_FILES:%.xml=$(HTMLDIR)/%_first.html) \
	$(XML_COLL_FILES:%.xml=$(HTMLDIR)/%_term.html) \
	$(XML_COLL_FILES:%.xml=$(HTMLDIR)/%_cite.html) \
	$(XML_APPLICATION_FILES:%.xml=$(HTMLDIR)/%_index.html) \
	$(XML_APPLICATION_FILES:%.xml=$(HTMLDIR)/%.kwc) \
	$(HTMLDIR)/index.html

DEFAULT_GIF_FILES = $(HTMLDIR)/min_head.gif

#
# Flags & Commands
#
XSLTPROC = 
FOP = 

DOCGEN=$(DOCGEN_DIR)

$(MAN1DIR)/%.1:: %.xml
	date=`date +"%B %e %Y"`; \
	xsltproc --output "$@" --stringparam company "Ericsson AB" --stringparam docgen "$(DOCGEN)" --stringparam gendate "$$date" --stringparam appname "$(APPLICATION)" --stringparam appver "$(VSN)" --xinclude -path $(DOCGEN)/priv/docbuilder_dtd  -path $(DOCGEN)/priv/dtd_man_entities $(DOCGEN)/priv/xsl/db_man.xsl $<


$(MAN2DIR)/%.2:: %.xml
	date=`date +"%B %e %Y"`; \
	xsltproc --output "$@" --stringparam company "Ericsson AB" --stringparam docgen "$(DOCGEN)" --stringparam gendate "$$date" --stringparam appname "$(APPLICATION)" --stringparam appver "$(VSN)" --xinclude -path $(DOCGEN)/priv/docbuilder_dtd  -path $(DOCGEN)/priv/dtd_man_entities $(DOCGEN)/priv/xsl/db_man.xsl $<


$(MAN3DIR)/%.3:: %.xml
	date=`date +"%B %e %Y"`; \
	xsltproc --output "$@" --stringparam company "Ericsson AB" --stringparam docgen "$(DOCGEN)" --stringparam gendate "$$date" --stringparam appname "$(APPLICATION)" --stringparam appver "$(VSN)" --xinclude -path $(DOCGEN)/priv/docbuilder_dtd  -path $(DOCGEN)/priv/dtd_man_entities $(DOCGEN)/priv/xsl/db_man.xsl $<

# left for compatibility
$(MAN4DIR)/%.4:: %.xml
	date=`date +"%B %e %Y"`; \
	xsltproc --output "$@" --stringparam company "Ericsson AB" --stringparam docgen "$(DOCGEN)" --stringparam gendate "$$date" --stringparam appname "$(APPLICATION)" --stringparam appver "$(VSN)" --xinclude -path $(DOCGEN)/priv/docbuilder_dtd  -path $(DOCGEN)/priv/dtd_man_entities $(DOCGEN)/priv/xsl/db_man.xsl $<

$(MAN4DIR)/%.5:: %.xml
	date=`date +"%B %e %Y"`; \
	xsltproc --output "$@" --stringparam company "Ericsson AB" --stringparam docgen "$(DOCGEN)" --stringparam gendate "$$date" --stringparam appname "$(APPLICATION)" --stringparam appver "$(VSN)" --xinclude -path $(DOCGEN)/priv/docbuilder_dtd  -path $(DOCGEN)/priv/dtd_man_entities $(DOCGEN)/priv/xsl/db_man.xsl $<

# left for compatibility
$(MAN6DIR)/%.6:: %_app.xml
	date=`date +"%B %e %Y"`; \
	xsltproc --output "$@" --stringparam company "Ericsson AB" --stringparam docgen "$(DOCGEN)" --stringparam gendate "$$date" --stringparam appname "$(APPLICATION)" --stringparam appver "$(VSN)" --xinclude -path $(DOCGEN)/priv/docbuilder_dtd  -path $(DOCGEN)/priv/dtd_man_entities $(DOCGEN)/priv/xsl/db_man.xsl $<

$(MAN6DIR)/%.7:: %_app.xml
	date=`date +"%B %e %Y"`; \
	xsltproc --output "$@" --stringparam company "Ericsson AB" --stringparam docgen "$(DOCGEN)" --stringparam gendate "$$date" --stringparam appname "$(APPLICATION)" --stringparam appver "$(VSN)" --xinclude -path $(DOCGEN)/priv/docbuilder_dtd  -path $(DOCGEN)/priv/dtd_man_entities $(DOCGEN)/priv/xsl/db_man.xsl $<

$(MAN9DIR)/%.9:: %.xml
	date=`date +"%B %e %Y"`; \
	xsltproc --output "$@" --stringparam company "Ericsson AB" --stringparam docgen "$(DOCGEN)" --stringparam gendate "$$date" --stringparam appname "$(APPLICATION)" --stringparam appver "$(VSN)" --xinclude -path $(DOCGEN)/priv/docbuilder_dtd  -path $(DOCGEN)/priv/dtd_man_entities $(DOCGEN)/priv/xsl/db_man.xsl $<


.xmlsrc.xml:
	escript $(DOCGEN)/priv/bin/codeline_preprocessing.escript $< $@

.fo.pdf:
	$(FOP) -fo $< -pdf $@

