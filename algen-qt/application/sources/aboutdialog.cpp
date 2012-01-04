/*
** This file is part of algen.
** Copyright (C) 2008 by Alan Wise (alanwise@users.sourceforge.net)
**
** This program is free software; you can redistribute it and/or modify
**   it under the terms of the GNU General Public License as published by
**   the Free Software Foundation; either version 2 of the License, or
**   (at your option) any later version.
**
** This program is distributed in the hope that it will be useful,
**   but WITHOUT ANY WARRANTY; without even the implied warranty of
**   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
**   GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
**   along with this program.  If not, see
**     <http://www.gnu.org/licenses/>,
**   or write to the
**     Free Software Foundation, Inc.,
**     59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
*/

/**
*** \file aboutdialog.cpp
***
*** \brief Implementation file for aboutdialog.h.
***
*** Implementation file for aboutdialog.h.
**/


/** Identifier for ABOUTDIALOG.cpp. **/
#define   ABOUTDIALOG_CPP


/****
*****
***** INCLUDES
*****
****/

#include  "aboutdialog.h"
#ifdef    DEBUG_ABOUTDIALOG_CPP
#ifndef   USE_DEBUGLOG
#define   USE_DEBUGLOG
#endif    /* USE_DEBUGLOG */
#endif    /* DEBUG_ABOUTDIALOG_CPP */
#include  "debuglog.h"

#include  "qalgen.h"
#include  "licenseagreement.h"


/****
*****
***** DEFINES
*****
****/


/****
*****
***** DATA TYPES
*****
****/


/****
*****
***** PROTOTYPES
*****
****/


/****
*****
***** DATA
*****
****/


/****
*****
***** VARIABLES
*****
****/


/****
*****
***** FUNCTIONS
*****
****/

ABOUTDIALOG_C::ABOUTDIALOG_C(QWidget *pParent)
    : QDialog(pParent)
{
  DEBUGLOG_Printf1("ABOUTDIALOG_C::ABOUTDIALOG_C(%p)",pParent);
  DEBUGLOG_Login();

  /* Set up the user interface. */
  setupUi(this);

  /* Set the data in the various widgets. */
  setWindowTitle("About "APPLICATION_DISPLAYNAMESTRING);
  m_pProgramNameVersionLabel->setText(
      APPLICATION_DISPLAYNAMESTRING" "APPLICATION_VERSIONSTRING);
  m_pProgramInformationEdit->setText(
      APPLICATION_DISPLAYNAMESTRING" "APPLICATION_DESCRIPTIONSTRING"\n");
  m_pProgramInformationEdit->append(APPLICATION_COPYRIGHTNOTICESTRING"\n");
  m_pProgramInformationEdit->append(
      "<a href=\""APPLICATION_WEBSITESTRING"\">"APPLICATION_WEBSITESTRING"</a>");
  m_pLicenseAgreementEdit->setText(f_pLicenseAgreement);

  DEBUGLOG_Logout();
  return;
}

ABOUTDIALOG_C::~ABOUTDIALOG_C(void)
{
  DEBUGLOG_Printf0("ABOUTDIALOG_C::~ABOUTDIALOG_C()");
  DEBUGLOG_Login();

  DEBUGLOG_Logout();
  return;
}


#undef    ABOUTDIALOG_CPP
