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
*** \file orientation.h
***
*** \brief Rotation and flip flags.
***
*** Rotation and flip flags for a media file.
**/


#ifndef   ORIENTATION_H
#define   ORIENTATION_H


/****
*****
***** INCLUDES
*****
****/

#include  "errorcode.h"
#include  "sysdefs.h"


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
*** \brief Rotation and flip flags.
***
*** Rotation and flip flags for a media file.
**/
typedef struct structORIENTATION
{
  unsigned int Rotation:2;            /**< Rotation divided by 90. **/
  unsigned int HorizontalFlipFlag:1;  /**< Horizontal flip (left/right). **/
  unsigned int VerticalFlipFlag:1;    /**< Vertical flip (up/down). **/
} ORIENTATION_T;


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

#ifdef  __cplusplus
extern "C" {
#endif  /* __cplusplus */

/**
*** Returns the value of the horizontal flip flag.
*** \param pOrientation
***   Pointer to orientation structure.
*** \return
***   >0 - Flipped.\n
***   =0 - Not flipped.\n
***   <0 - Failure.
**/
ERRORCODE_T Orientation_GetHorizontalFlipFlag(ORIENTATION_T *pOrientation);
/**
*** Returns the rotation.
*** \param pOrientation
***   Pointer to orientation structure.
*** \param pRotation
***   Pointer to storage for rotation.
*** \return
***   >0 - Flipped.\n
***   =0 - Not flipped.\n
***   <0 - Failure.
*** \retval
***   *pRotation - Rotation value in degrees (0, 90, 180, -90).
**/
ERRORCODE_T Orientation_GetRotation(ORIENTATION_T *pOrientation,int *pRotation);
/**
*** Returns the value of the vertical flip flag.
*** \param pOrientation
***   Pointer to orientation structure.
*** \return
***   >0 - Flipped.\n
***   =0 - Not flipped.\n
***   <0 - Failure.
**/
ERRORCODE_T Orientation_GetVerticalFlipFlag(ORIENTATION_T *pOrientation);
/**
*** Sets the value of the horizontal flip flag.
*** \param pOrientation
***   Pointer to orientation structure.
*** \param HFlipFlag
***   =0 - Not flipped.\n
***   !0 - Flipped.
*** \return
***   >0 - Success.\n
***   <0 - Failure.
**/
ERRORCODE_T Orientation_SetHorizontalFlipFlag(
    ORIENTATION_T *pOrientation,BOOLEAN_T HFlipFlag);
/**
*** Sets the rotation.
*** \param pOrientation
***   Pointer to orientation structure.
*** \param Rotation
***   Rotation in degrees (must be a multiple of 90).
*** \return
***   >0 - Success.\n
***   <0 - Failure.
**/
ERRORCODE_T Orientation_SetRotation(ORIENTATION_T *pOrientation,int Rotation);
/**
*** Sets the value of the vertical flip flag.
*** \param pOrientation
***   Pointer to orientation structure.
*** \param VFlipFlag
***   =0 - Not flipped.\n
***   !0 - Flipped.
*** \return
***   >0 - Success.\n
***   <0 - Failure.
**/
ERRORCODE_T Orientation_SetVerticalFlipFlag(
    ORIENTATION_T *pOrientation,BOOLEAN_T VFlipFlag);

#ifdef  __cplusplus
}
#endif  /* __cplusplus */


#endif    /* ORIENTATION_H */
