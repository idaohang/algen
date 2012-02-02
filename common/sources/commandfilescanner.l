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
*** \file commandfilescanner.l
***
*** \brief Command file tokenizer.
***
*** Rules to convert a command file into tokens.
***
**/


%{


/** Identifier for commandfilescanner.l. **/
#define   COMMANDFILESCANNER_L


/****
*****
***** INCLUDES
*****
****/

#include  "commandfile.h"
#include  "commandfileparser.h"
#include  "messagelog.h"


/****
*****
***** DEFINES
*****
****/

/** How much memory to add when (re)allocating memory. **/
#define   MALLOC_GRANULARITY  (1024)


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

/**
*** Resets the string buffer.
*** \return
***   >0 - Success.\n
***   <0 - Failure.
**/
static ERRORCODE_T ResetBuffer(void);
/**
*** Copies a character to the end of the string buffer, reallocating memory
***   if the resulting size would exceed the buffer size.
*** \param Char
***   Character to append to string buffer.
*** \return
***   >0 - Success.\n
***   <0 - Failure.
**/
static ERRORCODE_T AppendCharacterToBuffer(char Char);
/**
*** Called when there is an error parsing the command file.
*** \param pCommandFile
***   Pointer to the command file with the error.
*** \param pErrorString
***   Pointer to error description string.
**/
void commandfile_yyerror(COMMANDFILE_T *pCommandFile,const char *pErrorString);


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

/** String buffer pointer. **/
static char *f_pBuffer;

/** String buffer size. **/
static size_t f_BufferSize;


%}


%option 8bit
%option case-insensitive
%option noinput
%option nounput
%option noyywrap
%option prefix="commandfile_yy"

%x STRING


%%


AEND                return(TOKEN_AEND);
ALBUM               return(TOKEN_ALBUM);
ALBUMS              return(TOKEN_ALBUMS);
CAPTION             return(TOKEN_CAPTION);
CAPTIONTEXT         return(TOKEN_CAPTIONTEXT);
COMMANDFILE         return(TOKEN_COMMANDFILE);
DATAFILE            return(TOKEN_DATAFILE);
DESCRIPTION         return(TOKEN_DESCRIPTION);
GEND                return(TOKEN_GEND);
GUIDATA             return(TOKEN_GUIDATA);
HFLIP               return(TOKEN_HFLIP);
HIDDEN              return(TOKEN_HIDDEN);
IEND                return(TOKEN_IEND);
IMAGE               return(TOKEN_IMAGE);
LOCATION            return(TOKEN_LOCATION);
LOCATIONTEXT        return(TOKEN_LOCATIONTEXT);
MEDIA               return(TOKEN_MEDIA);
MEND                return(TOKEN_MEND);
NONE                return(TOKEN_NONE);
ROTATE              return(TOKEN_ROTATE);
VFLIP               return(TOKEN_VFLIP);

\n                  {
                      yylineno++;
                      return(yytext[0]);
                    }
#[^\n]*             { }
[ \r\t]+            { }
\"                  {
                      BEGIN STRING;
                      if (ResetBuffer()!=ERRORCODE_SUCCESS)
                        commandfile_yyerror(NULL,"ResetBuffer() error.");
                    }
<STRING>\"          {
                      BEGIN 0;
                      commandfile_yylval.pString=f_pBuffer;
                      return(TOKEN_STRING);
                    }
<STRING>[^\n]       {
                      if (AppendCharacterToBuffer(*yytext)!=ERRORCODE_SUCCESS)
                        commandfile_yyerror(
                            NULL,"AppendCharacterToBuffer() error.");
                    }
[+\-]?[1-9]?[0-9]*  {
                      commandfile_yylval.Integer=atoi(yytext);
                      return(TOKEN_INTEGER);
                    }
[+\-]?[1-9]?[0-9]*\.[0-9]*  {
                              commandfile_yylval.Double=strtod(yytext,NULL);
                              return(TOKEN_DOUBLE);
                            }
.                   {
                      return(*yytext);
                    }


%%


/****
*****
***** FUNCTIONS
*****
****/

static ERRORCODE_T ResetBuffer(void)
{
  if (f_pBuffer!=NULL)
    *f_pBuffer='\0';

  return(ERRORCODE_SUCCESS);
}

static ERRORCODE_T AppendCharacterToBuffer(char Char)
{
  ERRORCODE_T ErrorCode;
  size_t Size;
  size_t MallocSize;
  char *pNewBuffer;

  ErrorCode=ERRORCODE_SUCCESS;

  if (f_pBuffer!=NULL)
    Size=strlen(f_pBuffer)+sizeof(Char);
  else
    Size=0;

  if (Size>=f_BufferSize)
  {
    MallocSize=((f_BufferSize/MALLOC_GRANULARITY)+1)*MALLOC_GRANULARITY;
    pNewBuffer=(char *)realloc(f_pBuffer,MallocSize);
    if (pNewBuffer==NULL)
      ErrorCode=ERRORCODE_LIBRARYFAILURE;
    else
    {
      f_pBuffer=pNewBuffer;
      f_BufferSize=MallocSize;
      if (Size==0)
        *f_pBuffer='\0';
    }
  }

  if (ErrorCode>0)
  {
    Size=strlen(f_pBuffer);
    *(f_pBuffer+Size)=Char;
    *(f_pBuffer+Size+1)='\0';
  }

  return(ErrorCode);
}

void commandfile_yyerror(COMMANDFILE_T *pCommandFile,const char *pErrorString)
{
  ERRORCODE_T ErrorCode;
  const char *pPathname;


  MESSAGELOG_Todo("commandfile_yyerror().");
  ErrorCode=CommandFile_GetPathnamePointer(pCommandFile,&pPathname);
  fprintf(
      stderr,"%s:%u:%s\n",pPathname,yylineno,pErrorString);

  /* Log any error. */
  MESSAGELOG_LogError(ErrorCode);

  return;
}


#undef    COMMANDFILESCANNER_L
