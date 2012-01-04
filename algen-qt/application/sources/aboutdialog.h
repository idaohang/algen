/*
** This file is part of gpsview.
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
*** \file aboutdialog.h
***
*** \brief Displays the about dialog and processes its events.
***
*** This module provides the ability to display the about dialog and
***   processes signals sent by the widgets within the dialog.
**/


#ifndef   ABOUTDIALOG_H
#define   ABOUTDIALOG_H


/****
*****
***** INCLUDES
*****
****/

#include  "ui_aboutdialog.h"


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

/**
*** This class provides the ability to display the about dialog and
***   processes signals sent by the widgets within the dialog.
**/
class ABOUTDIALOG_C : public QDialog, public Ui::ABOUTDIALOGUI_C
{
  Q_OBJECT

  public:
    /**
    *** Initializes the class, and sets up the GUI.
    *** \param pParent
    ***   Pointer to parent widget.
    **/
    ABOUTDIALOG_C(QWidget *pParent=NULL);
    /**
    *** Uninitializes the class.
    **/
    ~ABOUTDIALOG_C(void);
};


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
***** PROTOTYPES
*****
****/


#endif    /* ABOUTDIALOG_H */
