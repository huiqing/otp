#-*-makefile-*-   ; force emacs to enter makefile-mode
# ----------------------------------------------------
# %CopyrightBegin%
#
# Copyright Ericsson AB 2009-2010. All Rights Reserved.
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

# The version.
#
# Note that it is important that the version is
# explicitly expressed here. Some applications need to
# be able to check this value *before* configure has
# been run and generated otp_ded.mk
DED_MK_VSN = 1
# ----------------------------------------------------
# Variables needed for building Dynamic Erlang Drivers
# ----------------------------------------------------
DED_CC = cc.sh
DED_GCC = 
DED_LD = ld.sh
DED_LDFLAGS = -dll
DED__NOWARN_NOTHR_CFLAGS = -O2 -I/home/hl/otp_src_R15B01/erts/win32   -D_WIN32_WINNT=0x0500 -DWINVER=0x0500 -DERTS_MIXED_CYGWIN_VC
DED__NOTHR_CFLAGS =  -O2 -I/home/hl/otp_src_R15B01/erts/win32   -D_WIN32_WINNT=0x0500 -DWINVER=0x0500 -DERTS_MIXED_CYGWIN_VC
DED__NOWARN_CFLAGS =  -DUSE_THREADS -DWIN32_THREADS -O2 -I/home/hl/otp_src_R15B01/erts/win32   -D_WIN32_WINNT=0x0500 -DWINVER=0x0500 -DERTS_MIXED_CYGWIN_VC
DED_THR_DEFS = -DUSE_THREADS -DWIN32_THREADS -D_WIN32_WINNT=0x0500 -DWINVER=0x0500
DED_EMU_THR_DEFS =  -DUSE_THREADS -DWIN32_THREADS
DED_WARN_FLAGS = 
DED_CFLAGS =   -DUSE_THREADS -DWIN32_THREADS -O2 -I/home/hl/otp_src_R15B01/erts/win32   -D_WIN32_WINNT=0x0500 -DWINVER=0x0500 -DERTS_MIXED_CYGWIN_VC
DED_LIBS =  -lsocket -lmswsock
DED_EXT = dll
ERLANG_OSTYPE = win32
PRIVDIR = ../priv
OBJDIR = $(PRIVDIR)/obj/$(TARGET)
LIBDIR = $(PRIVDIR)/lib/$(TARGET)
DED_SYS_INCLUDE = -I/home/hl/otp_src_R15B01/erts/emulator/beam -I/home/hl/otp_src_R15B01/erts/include -I/home/hl/otp_src_R15B01/erts/include/win32 -I/home/hl/otp_src_R15B01/erts/include/internal -I/home/hl/otp_src_R15B01/erts/include/internal/win32 -I/home/hl/otp_src_R15B01/erts/emulator/sys/win32
DED_INCLUDES = $(DED_SYS_INCLUDE)
