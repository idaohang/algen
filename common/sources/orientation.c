/*
** This file is part of algen.
** Copyright (C) 2008-2011 by Alan Wise (alanwise@users.sourceforge.net)
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
*** \file orientation.c
***
*** \brief orientation.h implementation.
***
*** Implementation file for orientation.h.
**/


/** Identifier for orientation.c. **/
#define   ORIENTATION_C


/****
*****
***** INCLUDES
*****
****/

#include  "orientation.h"
#ifdef    DEBUG_ORIENTATION_C
#ifndef   USE_DEBUGLOG
#define   USE_DEBUGLOG
#endif    /* USE_DEBUGLOG */
#endif    /* DEBUG_ORIENTATION_C */
#include  "debuglog.h"

#include  <stdlib.h>


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

ERRORCODE_T Orientation_GetHorizontalFlipFlag(ORIENTATION_T *pOrientation)
{
  ERRORCODE_T ErrorCode;


  DEBUGLOG_Printf1("Orientation_GetHorizontalFlipFlag(%p)",pOrientation);
  DEBUGLOG_Login();

  /* Parameter checking. */
  if (pOrientation==NULL)
    ErrorCode=ERRORCODE_NULLPARAMETER;
  else
  {
    if (pOrientation->HorizontalFlipFlag==0)
      ErrorCode=ERRORCODE_FALSE;
    else
      ErrorCode=ERRORCODE_TRUE;
  }

  DEBUGLOG_Logout();
  return(ErrorCode);
}

ERRORCODE_T Orientation_GetRotation(ORIENTATION_T *pOrientation,int *pRotation)
{
  ERRORCODE_T ErrorCode;


  DEBUGLOG_Printf2("Orientation_GetRotation(%p,%p)",pOrientation,pRotation);
  DEBUGLOG_Login();

  /* Parameter checking. */
  if ( (pOrientation==NULL) || (pRotation==NULL) )
    ErrorCode=ERRORCODE_NULLPARAMETER;
  else
  {
    *pRotation=pOrientation->Rotation*90;
    if (*pRotation==270)
      *pRotation=-90;
    ErrorCode=ERRORCODE_SUCCESS;
  }

  DEBUGLOG_Logout();
  return(ErrorCode);
}

ERRORCODE_T Orientation_GetVerticalFlipFlag(ORIENTATION_T *pOrientation)
{
  ERRORCODE_T ErrorCode;


  DEBUGLOG_Printf1("Orientation_GetVerticalFlipFlag(%p,%d)",pOrientation);
  DEBUGLOG_Login();

  /* Parameter checking. */
  if (pOrientation==NULL)
    ErrorCode=ERRORCODE_NULLPARAMETER;
  else
  {
    if (pOrientation->VerticalFlipFlag==0)
      ErrorCode=ERRORCODE_FALSE;
    else
      ErrorCode=ERRORCODE_TRUE;
  }

  DEBUGLOG_Logout();
  return(ErrorCode);
}

ERRORCODE_T Orientation_SetHorizontalFlipFlag(
    ORIENTATION_T *pOrientation,BOOLEAN_T HFlipFlag)
{
  ERRORCODE_T ErrorCode;


  DEBUGLOG_Printf2(
      "Orientation_SetHorizontalFlipFlag(%p,%d)",pOrientation,HFlipFlag);
  DEBUGLOG_Login();

  /* Parameter checking. */
  if (pOrientation==NULL)
    ErrorCode=ERRORCODE_NULLPARAMETER;
  else
  {
    pOrientation->HorizontalFlipFlag=(HFlipFlag!=0);
    ErrorCode=ERRORCODE_SUCCESS;
  }

  DEBUGLOG_Logout();
  return(ErrorCode);
}

ERRORCODE_T Orientation_SetRotation(ORIENTATION_T *pOrientation,int Rotation)
{
  ERRORCODE_T ErrorCode;


  DEBUGLOG_Printf2("Orientation_SetRotation(%p,%p)",pOrientation,Rotation);
  DEBUGLOG_Login();

  /* Parameter checking. */
  if (pOrientation==NULL)
    ErrorCode=ERRORCODE_NULLPARAMETER;
  else
  {
    pOrientation->Rotation=(unsigned)((Rotation/90)&3);
    ErrorCode=ERRORCODE_SUCCESS;
  }

  DEBUGLOG_Logout();
  return(ErrorCode);
}

ERRORCODE_T Orientation_SetVerticalFlipFlag(
    ORIENTATION_T *pOrientation,BOOLEAN_T VFlipFlag)
{
  ERRORCODE_T ErrorCode;


  DEBUGLOG_Printf2(
      "Orientation_SetVerticalFlipFlag(%p,%d)",pOrientation,VFlipFlag);
  DEBUGLOG_Login();

  /* Parameter checking. */
  if (pOrientation==NULL)
    ErrorCode=ERRORCODE_NULLPARAMETER;
  else
  {
    pOrientation->VerticalFlipFlag=(VFlipFlag!=0);
    ErrorCode=ERRORCODE_SUCCESS;
  }

  DEBUGLOG_Logout();
  return(ErrorCode);
}


#undef    ORIENTATION_C
