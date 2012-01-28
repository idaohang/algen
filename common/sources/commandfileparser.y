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
*** \file commandfileparser.y
***
*** \brief Command file parser.
***
*** Rules to convert command file tokens into data usable by the program.
**/


%{


/** Identifier for commandfileparser.y. **/
#define COMMANDFILEPARSER_Y


/****
*****
***** INCLUDES
*****
****/

#include  "commandfile.h"
#include  "messagelog.h"


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


%}


/*%debug*/
%defines
%name-prefix="commandfile_yy"
/* TODO: error recovery */
%parse-param { COMMANDFILE_T *pCommandFile }
%error-verbose
/*%verbose*/

%union {
  double Double;
  int Integer;
  char *pString;
  GUIDATA_T GUIData;
  int *pCoordinate;
  MEDIALIST_T *pMediaList;
  MEDIA_T *pMedia;
  COMMANDFILE_T *pCommandFile;
}

%token TOKEN_AEND
%token TOKEN_ALBUM
%token TOKEN_ALBUMS
%token TOKEN_ALGENFILE
%token TOKEN_CAPTION
%token TOKEN_CAPTIONFILE
%token TOKEN_CAPTIONTEXT
%token TOKEN_DATAFILE
%token TOKEN_DESCRIPTION
%token TOKEN_GEND
%token <GUIData> TOKEN_GUIDATA
%token TOKEN_HFLIP
%token TOKEN_HIDDEN
%token TOKEN_IEND
%token <pMedia> TOKEN_IMAGE
%token TOKEN_LOCATION
%token <pCoordinate> TOKEN_LOCATIONTEXT
%token <pMediaList> TOKEN_MEDIA
%token TOKEN_MEND
%token TOKEN_NONE
%token TOKEN_ROTATE
%token TOKEN_VFLIP

%token <Double> TOKEN_DOUBLE
%token <Integer> TOKEN_INTEGER
%token <pString> TOKEN_STRING

%type <pCommandFile> command
%type <pMediaList> mediastartcmd mediacmd
%type <GUIData> guidatacmd guidatastartcmd
%type <pMedia> imagecmd imagestartcmd
%type <pCoordinate> coordinate1 coordinate2 coordinate3


%%


commands:
  commands command
  | commands '\n'
  | command
  | '\n'
  ;

command:
  albumscmd
  {
  }
  | algenfilecmd
  {
  }
  | mediacmd
  {
    if (CommandFile_AppendMediaList(pCommandFile,$1)<0)
      YYABORT;
  }
  ;

albumscmd:
  albumsstartcmd TOKEN_AEND '\n'
  {
    MESSAGELOG_Todo("albumsstartcmd TOKEN_AEND");
  }
  ;

albumsstartcmd:
  albumsstartcmd '\n'
  {
  }
  | albumsstartcmd albumcmd
  {
    MESSAGELOG_Todo("albumsstartcmd albumcmd");
  }
  | TOKEN_ALBUMS '\n'
  {
    MESSAGELOG_Todo("TOKEN_ALBUMS");
  }
  ;

albumcmd:
  albumstartcmd TOKEN_AEND '\n'
  {
    MESSAGELOG_Todo("albumstartcmd TOKEN_AEND");
  }
  ;

albumstartcmd:
  albumstartcmd '\n'
  {
    MESSAGELOG_Todo("albumstartcmd");
  }
  | albumstartcmd TOKEN_DESCRIPTION TOKEN_STRING '\n'
  {
    MESSAGELOG_Todo("albumstartcmd TOKEN_DESCRIPTION TOKEN_STRING");
  }
  | albumstartcmd TOKEN_MEDIA TOKEN_STRING '\n'
  {
    MESSAGELOG_Todo("albumstartcmd TOKEN_MEDIA TOKEN_STRING");
  }
  | TOKEN_ALBUM TOKEN_STRING '\n'
  {
    MESSAGELOG_Todo("TOKEN_ALBUM TOKEN_STRING");
  }
  ;

algenfilecmd:
  TOKEN_ALGENFILE TOKEN_STRING '\n'
  {
    MESSAGELOG_Todo("TOKEN_ALGENFILE");
  }
  ;

mediacmd:
  mediastartcmd TOKEN_MEND '\n'
  {
  }
  ;

mediastartcmd:
  mediastartcmd '\n'
  {
    $$=$1;
  }
  | mediastartcmd imagecmd
  {
    if (MediaList_AppendMedia($1,$2)<0)
      YYABORT;
    $$=$1;
  }
  | TOKEN_MEDIA '\n'
  {
    if (MediaList_Initialize(&$$)<0)
      YYABORT;
  }
  ;

imagecmd:
  imagestartcmd TOKEN_IEND '\n'
  {
    $$=$1;
  }
  ;

imagestartcmd:
  imagestartcmd '\n'
  {
    $$=$1;
  }
  | imagestartcmd TOKEN_CAPTION TOKEN_NONE '\n'
  {
    if (Media_SetSelectedCaptionType($1,CAPTIONTYPE_NONE)<0)
      YYABORT;
    $$=$1;
  }
  | imagestartcmd TOKEN_CAPTION TOKEN_CAPTIONTEXT '\n'
  {
    if (Media_SetSelectedCaptionType($1,CAPTIONTYPE_TEXT)<0)
      YYABORT;
    $$=$1;
  }
  | imagestartcmd TOKEN_CAPTIONTEXT TOKEN_STRING '\n'
  {
    if (Media_SetCaptionData($1,CAPTIONTYPE_TEXT,$3)<0)
      YYABORT;
    $$=$1;
  }
  | imagestartcmd TOKEN_LOCATION TOKEN_NONE '\n'
  {
    MESSAGELOG_Todo("TOKEN_LOCATION TOKEN_NONE");
    $$=$1;
  }
  | imagestartcmd TOKEN_LOCATION TOKEN_LOCATIONTEXT '\n'
  {
    MESSAGELOG_Todo("TOKEN_LOCATION TOKEN_LOCATIONTEXT");
    $$=$1;
  }
  | imagestartcmd coordinate3 '\n'
  {
    MESSAGELOG_Todo("coordinate3");
    $$=$1;
  }
  | imagestartcmd coordinate2 '\n'
  {
    MESSAGELOG_Todo("coordinate2");
    $$=$1;
  }
  | imagestartcmd TOKEN_ROTATE TOKEN_INTEGER '\n'
  {
    if (($3%90)!=0)
      YYABORT;
    if (Media_SetRotation($1,$3)<0)
      YYABORT;
    $$=$1;
  }
  | imagestartcmd TOKEN_HFLIP TOKEN_INTEGER '\n'
  {
    if (Media_SetHorizontalFlipFlag($1,$3!=0)<0)
      YYABORT;
    $$=$1;
  }
  | imagestartcmd TOKEN_VFLIP TOKEN_INTEGER '\n'
  {
    if (Media_SetVerticalFlipFlag($1,$3!=0)<0)
      YYABORT;
    $$=$1;
  }
  | imagestartcmd guidatacmd
  {
    if (Media_SetGUIData($1,&$2)<0)
      YYABORT;
    $$=$1;
  }
  | TOKEN_IMAGE TOKEN_STRING '\n'
  {
    if ( (Media_Create(&$$)<0) || (Media_Initialize($$)<0) ||
        (Media_SetType($$,MEDIATYPE_IMAGE)<0) || (Media_SetPathname($$,$2)<0) )
      YYABORT;
  }
  ;

guidatacmd:
  guidatastartcmd TOKEN_GEND '\n'
  {
    $$=$1;
  }
  ;

guidatastartcmd:
  guidatastartcmd '\n'
  {
    $$=$1;
  }
  | guidatastartcmd TOKEN_HIDDEN '\n'
  {
    if (GUIData_SetHiddenFlag(&$$,!0)<0)
      YYABORT;
    $$=$1;
  }
  | TOKEN_GUIDATA '\n'
  {
    if (GUIData_Initialize(&$$)<0)
      YYABORT;
    $$=$1;
  }
  ;

coordinate3:
  coordinate2 ',' TOKEN_DOUBLE
  {
    MESSAGELOG_Todo("coordinate2 ',' TOKEN_DOUBLE");
    $$=$1;
  }
  | coordinate2 ',' TOKEN_INTEGER
  {
    MESSAGELOG_Todo("coordinate2 ',' TOKEN_INTEGER");
    $$=$1;
  }
  ;

coordinate2:
  coordinate1 ',' TOKEN_DOUBLE
  {
    MESSAGELOG_Todo("coordinate1 ',' TOKEN_DOUBLE");
    $$=$1;
  }
  | coordinate1 ',' TOKEN_INTEGER
  {
    MESSAGELOG_Todo("coordinate1 ',' TOKEN_INTEGER");
    $$=$1;
  }
  ;

coordinate1:
  TOKEN_LOCATIONTEXT TOKEN_STRING ',' TOKEN_DOUBLE
  {
    MESSAGELOG_Todo("TOKEN_LOCATIONTEXT TOKEN_STRING ',' TOKEN_DOUBLE");
    $$=$1;
  }
  |
  TOKEN_LOCATIONTEXT TOKEN_STRING ',' TOKEN_INTEGER
  {
    MESSAGELOG_Todo("TOKEN_LOCATIONTEXT TOKEN_STRING ',' TOKEN_INTEGER");
    $$=$1;
  }
  ;


%%


/****
*****
***** FUNCTIONS
*****
****/


#undef  COMMANDFILEPARSER_Y
