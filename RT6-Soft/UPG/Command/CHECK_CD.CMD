/*************************************************************/
/* CHECK_CD.CMD version 5.0.0                                */
/* Command script executed to check the quality of the CD.   */
/* If the quality is good, the script validate adequacy with */
/* the product (CD version).                                 */
/*************************************************************/

//! @li 2014/04/25 K. KOUEKA : Evo 7309 - cross upgrade merco
//!  ->  adding function "CompareConfigVersionOnly4_MERC_2009"
//! @li 2014/01/24 K. KOUEKA   : Update sorftware for Croos upgrde mercosur
//! @li 2013/01/28 K. KOUEKA   : update this file to allows cross update
//!   get file config version and update identifier with correct value
//! @li 2012/01/04 stymen      : Correction of defect 39766
//! @li 2011/10/18 stymen      : Evo 6177 - Coding of Cross upgrades


/*** TYPES ***/

typedef int   STATUS;
typedef int   BOOL;
typedef void *MODULE_ID;


/*** CONSTANTS ***/

#define TRUE     (1)
#define FALSE    (0)
#define PAUSE    (2)
#define OK       (0)
#define ERROR    (-1)
#define NULL     (void*) 0

#define MAX_PATH_LENGTH       200
#define MAX_VERSION_LENGTH     95
#define MAX_STRING_LENGTH      12

#define CHECK_CD_ERROR_CRC      2
#define CHECK_CD_ERROR_VERSION  4


/*** EXTERN FUNCTION DEFINITIONS ***/
int    logMsg (char *str,int p1,int p2,int p3,int p4,int p5,int p6);
STATUS strcpy (char* target, char* source);
STATUS strncpy (char* target, char* source, int n );
STATUS strcat (char* target, char* source);
int    strcmp (char* str1, char* str2);
int    strncmp(const char* s1, const char* s2, int n );
int    atoi (char * s);

// Logging
STATUS SetUpgradeLogging( int TRUEFALSE );
STATUS EnableHistoryHandler ( int TRUEFALSE );
STATUS AddUPGHistoryHeader(char *p_CDNum, char *p_TargetDrive, char *p_Action);
STATUS UPGLogMsg(char* str,int p1,int p2,int p3,int p4,int p5,int p6);

STATUS taskDelay (int ticks);
unsigned long tickGet (void);

STATUS GetFileVersion (char *l_pBynaryFileName, char *l_pVersion);
STATUS GetCDVersion(char *cdVersion);
STATUS GetConfigSystemVersion(unsigned char *p_pVersion);
STATUS UpdateFileConfigVersion20092010 (char *p_pConfigVersion,
                                char *p_pConfigVersion2009,
                                char *p_pConfigVersion2010,
                                int p_max_size);
STATUS CompareConfigVersionAlreadyIn_3WC (char* p_device_config_system_version,
                                    char* p_usb_upg_config_syst_vers);
STATUS CompareConfigVersionOnly4_EUR (char* p_device_config_system_version,
                                      char* p_usb_upg_config_syst_vers);

STATUS CompareConfigVersionOnly4_MERC_2010 (char* p_device_config_system_version,
                                      char* p_usb_upg_config_syst_vers);
STATUS CompareConfigVersionOnly4_MERC_2009 (char* p_device_config_system_version,
                                            char* p_usb_upg_config_syst_vers);


STATUS CompareConfigVersion (char* p_pConfigVersion,
                         char* p_pConfigVersion2009,
                         char* p_pConfigVersion2010);

typedef enum
{
  FROM_NORMAL = 0,
  FROM_NOTHING
} t_UPGType;


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//                                 WARNING
// This script is called from NORMAL MODE AND BOOTROM MODE
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/****************************** MAIN ******************************/
//  argv[0] = Script Name (/bd0/.....CMD)
//  argv[1] = p_Drive     (/bd0,...)
//  argv[2] = p_pUpgType  (NORMAL / BOOTROM)

int main ( int argc, char **argv )
{
  STATUS l_script_status = OK;
  t_UPGType l_tUpgType = FROM_NOTHING;

  char l_pScriptFile[MAX_PATH_LENGTH];
  char l_pSourceDrive[MAX_PATH_LENGTH];
  char l_pUpgType[MAX_PATH_LENGTH];

  char l_pString[MAX_PATH_LENGTH];
  int  l_iFd = 0;
  char l_pSourcePath[MAX_PATH_LENGTH];
  MODULE_ID l_pModuleId = NULL;

  char l_pPath[MAX_PATH_LENGTH];

  char l_pOldCDVersion[MAX_VERSION_LENGTH];
  char l_pCDVersion[MAX_VERSION_LENGTH];

  char l_pConfigSystemVersion[MAX_VERSION_LENGTH];
  char l_pOldConfigSystemVersion[MAX_VERSION_LENGTH];
  int  l_FilesCountOnMedia = 0;

  //For Cross upgrade needs
  char l_pCDConfigSystemVersion[MAX_VERSION_LENGTH];
  char l_pCDConfigSystemVersion2009[MAX_VERSION_LENGTH];
  char l_pCDConfigSystemVersion2010[MAX_VERSION_LENGTH];


  /*** SCRIPT INITIALIZATION ***/
  SetUpgradeLogging( TRUE );
  EnableHistoryHandler( TRUE );

  strcpy ( l_pScriptFile, argv[0]);
  strcpy ( l_pSourceDrive, argv[1]);
  strcpy ( l_pUpgType, argv[2]);

  logMsg ( "!!!!!!!!!!!!!============================!!!!!!!!!!\n", 0, 0, 0, 0, 0, 0 );
  logMsg ( "!!!!!!!!!!!!!    CHECK_CD.CMD - Begin    !!!!!!!!!!\n", 0, 0, 0, 0, 0, 0 );
  logMsg ( "!!!!!!!!!!!!!============================!!!!!!!!!!\n", 0, 0, 0, 0, 0, 0 );

  if (   (0 == strcmp (l_pUpgType, "NORMAL"))
      || (0 == strcmp (l_pUpgType, "BOOTROM"))
     )
  {
    logMsg ( "CheckCD type is <%s>\n",l_pUpgType,0,0,0,0,0 );
    l_tUpgType = FROM_NORMAL;
  }
  else
  {
    logMsg ( "CheckCD type is <%s> !!!!\n",l_pUpgType,0,0,0,0,0 );
    l_tUpgType = FROM_NOTHING;
    l_script_status = ERROR;
  }

  //////////////////////////////////////////////////////////////////////////////
  // authorised CD ?
  //////////////////////////////////////////////////////////////////////////////

  // Get CD Version on the CD
  if ( OK == l_script_status)
  {
    strcpy ( l_pPath, l_pSourceDrive );
    strcat ( l_pPath, "/CD" );

    if ( ERROR == GetFileVersion ( l_pPath, l_pCDVersion ) )
    {
      logMsg ( "GetFileVersion error on %s\n", l_pPath, 0, 0, 0, 0, 0 );
      l_script_status = ERROR;
    }
    else
    {
      logMsg ( "CD version is %s\n", l_pCDVersion, 0, 0, 0, 0, 0 );
    }
  }

  // Get the COnfig version on the CD
  if (OK == l_script_status)
  {
    // Get CD Software Version
    strcpy ( l_pPath, l_pSourceDrive );
    strcat ( l_pPath, "/Config" );

    if ( ERROR == GetFileVersion ( l_pPath, l_pConfigSystemVersion ) )
    {
      logMsg ( "GetFileVersion error on %s\n", l_pPath, 0, 0, 0, 0, 0 );
      l_script_status = ERROR;
    }
    else
    {
      logMsg ( "CD Software version is %s\n", l_pConfigSystemVersion, 0, 0, 0, 0, 0 );
      //Call UpdateFileConfigVersion20092010.
      if ( ERROR == UpdateFileConfigVersion20092010 (l_pConfigSystemVersion,
                                                     l_pCDConfigSystemVersion2009,
                                                     l_pCDConfigSystemVersion2010,
                                                     MAX_VERSION_LENGTH)
         )
      {
        logMsg ("UpdateFileConfigVersion20092010 error; ConfigVersion='%s'\n",
                l_pConfigSystemVersion, 0, 0, 0, 0, 0 );
        logMsg ("UpdateFileConfigVersion20092010 error; ConfigVersion2009='%s'\n",
                l_pCDConfigSystemVersion2009, 0, 0, 0, 0, 0 );
        logMsg ("UpdateFileConfigVersion20092010 error; ConfigVersion2010='%s'\n",
                l_pCDConfigSystemVersion2010, 0, 0, 0, 0, 0 );
        l_script_status = ERROR;
      }
    }
  }

  // Get the CD Version on the DBBoot
  if ( OK == l_script_status )
  {
    if ( OK != GetCDVersion ( l_pOldCDVersion ) )
    {
      logMsg ( "GetCDVersion error on DBBoot\n",0,0,0,0,0,0 );
      l_script_status = ERROR;
    }
  }

  //Compare Config Version
  if ( OK == l_script_status )
  {
    if ( OK != CompareConfigVersion (l_pConfigSystemVersion,
                                     l_pCDConfigSystemVersion2009,
                                     l_pCDConfigSystemVersion2010) )
    {
      logMsg ( "CompareConfigVersion() Failed ***\n",0,0,0,0,0,0 );
      l_script_status = ERROR;
    }
  }

  // Compare CD version
  if ( OK == l_script_status )
  {
    if ( 0 == strcmp ( l_pOldCDVersion, "" ) )
    {
      // No CD version, so the upgrade is authorised
      logMsg ( "No CD version, so the upgrade is authorised\n", 0, 0, 0, 0, 0, 0 );
      l_script_status = OK;
    }
    else
    {
      if ( atoi ( l_pOldCDVersion ) > atoi ( l_pCDVersion ) )
      {
        logMsg ( "CDVersion error : actual version ( %s ) > new version(%s)\n",
                  l_pOldCDVersion, l_pCDVersion, 0, 0, 0, 0 );
        l_script_status = CHECK_CD_ERROR_VERSION;
      }
      else
      {
        logMsg ( "Actual version ( %s ) <= new version(%s)\n", l_pOldCDVersion, l_pCDVersion, 0, 0, 0, 0 );
      }
    }
  }

  SetUpgradeLogging (PAUSE);

  // Return OK   = 0  (Version OK, check Ok)
  // Error       = -1 (Check pb)
  // check verification failled = 2
  // bad version = 4

  logMsg ( "!!!!!!!!!!!!!============================!!!!!!!!!!\n", 0, 0, 0, 0, 0, 0 );
  logMsg ( "!!!!!!!!!!!!!     CHECK_CD.CMD - End     !!!!!!!!!!\n", 0, 0, 0, 0, 0, 0 );
  logMsg ( "!!!!!!!!!!!!!============================!!!!!!!!!!\n", 0, 0, 0, 0, 0, 0 );

  return (l_script_status);
}



STATUS UpdateFileConfigVersion20092010 (char *p_pConfigVersion,
                                        char *p_pConfigVersion2009,
                                        char *p_pConfigVersion2010,
                                        int p_max_size)
{
  STATUS l_retVal = ERROR;

  //treatement of char*
  l_retVal = strncpy(p_pConfigVersion2009, p_pConfigVersion, p_max_size);
  p_pConfigVersion2009[6] = '0';
  p_pConfigVersion2009[7] = '9';

  l_retVal = strncpy(p_pConfigVersion2010, p_pConfigVersion, p_max_size);
  p_pConfigVersion2010[6] = '1';
  p_pConfigVersion2010[7] = '0';

  logMsg ( "p_pConfigVersion2009= '%s'\n", p_pConfigVersion2009, 0, 0, 0, 0, 0 );
  logMsg ( "p_pConfigVersion2010= '%s'\n", p_pConfigVersion2010, 0, 0, 0, 0, 0 );

  return ( l_retVal );
}



STATUS CompareConfigVersion (char* p_pConfigVersion,
                             char* p_pConfigVersion2009,
                             char* p_pConfigVersion2010)
{

  char l_pOldConfigSystemVersion[MAX_VERSION_LENGTH];
  int  l_compare_result;
  STATUS l_ccv_retVal = ERROR;
  STATUS l_can_continue = ERROR;


  // Get the Config version on the DBBoot
  l_ccv_retVal = GetConfigSystemVersion ( (unsigned char*)l_pOldConfigSystemVersion );

  if (ERROR == l_ccv_retVal)
  {
    logMsg ( "GetConfigSystemVersion on DBBoot FAILED \n", 0, 0, 0, 0, 0, 0 );
    return (l_ccv_retVal);
  }

  logMsg (" Installed ConfigSystemVersion ='%s'\n\n", l_pOldConfigSystemVersion, 0, 0, 0, 0, 0 );


  l_can_continue  = OK;
  l_ccv_retVal    = ERROR;
  // Compare Config Version to "DEFAULT"
  if (OK == l_can_continue)
  {
    l_compare_result = strcmp (l_pOldConfigSystemVersion, "DEFAULT");
    if (0 == l_compare_result)
    {
      // No config version, so the upgrade is authorised
      logMsg ( "This upgrade is authorized : '%s' \n",l_pOldConfigSystemVersion , 0, 0, 0, 0, 0 );
      l_ccv_retVal = OK;
      //stop comparing data! Equality has been found
      l_can_continue = ERROR;
    }
  }

  // Compare Config Version to any other value

  // Compare Config Version of 2010 device from MERC
  if (OK == l_can_continue)
  {
    l_ccv_retVal = CompareConfigVersionOnly4_MERC_2010 (l_pOldConfigSystemVersion,
                                                        p_pConfigVersion);
    if (OK == l_ccv_retVal)
    {
      //stop comparing data! Equality has been found
      l_can_continue = ERROR;
    }
  }

  // Compare Config Version of 2009 device from MERCOSUR
  if (OK == l_can_continue)
  {
    l_ccv_retVal = CompareConfigVersionOnly4_MERC_2009 (l_pOldConfigSystemVersion,
                                                        p_pConfigVersion);
    if (OK == l_ccv_retVal)
    {
      //stop comparing data! Equality has been found
      l_can_continue = ERROR;
    }
  }

  // Compare Config Version to 2009 ou 2010 device only from EUR ("RNEG20XX_EUR")
  if (OK == l_can_continue)
  {
    l_ccv_retVal = CompareConfigVersionOnly4_EUR (l_pOldConfigSystemVersion,
                                                  p_pConfigVersion);
    if (OK == l_ccv_retVal)
    {
      //stop comparing data! Equality has been found
      l_can_continue = ERROR;
    }
  }


  // Compare Config Version already in "RNEG20XX_3WC"
  if (OK == l_can_continue)
  {
    l_ccv_retVal = CompareConfigVersionAlreadyIn_3WC (l_pOldConfigSystemVersion,
                                                      p_pConfigVersion);
    if (OK == l_ccv_retVal)
    {
      //stop comparing data! Equality has been found
      l_can_continue = ERROR;
    }
  }



  //finally
  if (ERROR == l_ccv_retVal)
  {
    // unknown config version, so the upgrade is not authorised
    logMsg ("ConfigSystemVersion error : \"%s\" != \"%s\"  \n",
            l_pOldConfigSystemVersion ,
            p_pConfigVersion,
            0, 0, 0, 0 );
  }

  return (l_ccv_retVal);

}





STATUS CompareConfigVersionAlreadyIn_3WC (char* p_device_config_system_version,
                                          char* p_usb_upg_config_syst_vers)
{
  char    l_pTmpConfSystVers[MAX_VERSION_LENGTH];
  int     l_cmp_result  = -1;
  STATUS  l_status      = ERROR;

  //init l_pTmpConfSystVers
  for (l_cmp_result = 0; l_cmp_result < MAX_VERSION_LENGTH; l_cmp_result++)
  {
    l_pTmpConfSystVers[l_cmp_result] = '\0';
  }

  strcpy (l_pTmpConfSystVers, p_device_config_system_version);
  //update tmp with XX
  l_pTmpConfSystVers[6] = 'X';
  l_pTmpConfSystVers[7] = 'X';

  logMsg ( "install version : \"%s\" \n", l_pTmpConfSystVers, 0, 0, 0, 0, 0 );

  //compare
  l_cmp_result = strncmp (p_usb_upg_config_syst_vers,
                          l_pTmpConfSystVers,
                          MAX_STRING_LENGTH);
  if(0 == l_cmp_result)
  {
    // known config version, so the upgrade is authorised
    logMsg ( "This upgrade is authorized from : \"%s\" to \"%s\"  \n",
             l_pTmpConfSystVers,
             p_usb_upg_config_syst_vers ,
             0, 0, 0, 0 );
    l_status = OK;
  }

  return (l_status);

}



STATUS CompareConfigVersionOnly4_EUR (char* p_device_config_system_version,
                                      char* p_usb_upg_config_syst_vers)
{
  STATUS  l_ccv_stus      = ERROR;

  // Compare Config Version to 2009 ou 2010 device only from EUR ("RNEG20XX_EUR")

  if (   ('E' == p_device_config_system_version[9])
      && ('U' == p_device_config_system_version[10])
      && ('R' == p_device_config_system_version[11]))
  {
    // known config version, so the upgrade is authorised
    logMsg ( "This upgrade is authorized from : \"%s\" to \"%s\"  \n",
             p_device_config_system_version ,
             p_usb_upg_config_syst_vers,
             0, 0, 0, 0 );
    l_ccv_stus = OK;
  }
  return (l_ccv_stus);

}


STATUS CompareConfigVersionOnly4_MERC_2010 (char* p_device_config_system_version,
                                            char* p_usb_upg_config_syst_vers)
{
  STATUS l_status     = ERROR;

  // Compare Config Version of 2010 device from MERC

  if (   ('1' == p_device_config_system_version[6])
      && ('0' == p_device_config_system_version[7]))
  {

    if (   ('M' == p_device_config_system_version[9])
        && ('E' == p_device_config_system_version[10])
        && ('R' == p_device_config_system_version[11])
        && ('C' == p_device_config_system_version[12]))
    {

      // known config version, so the upgrade is authorised
      logMsg ( "This upgrade is authorized FROM : \"%s\" TO \"%s\" \n",
               p_device_config_system_version ,
               p_usb_upg_config_syst_vers,
               0, 0, 0, 0 );
      l_status = OK;
    }
  }
  return (l_status);

}


STATUS CompareConfigVersionOnly4_MERC_2009 (char* p_device_config_system_version,
                                            char* p_usb_upg_config_syst_vers)
{
  STATUS l_status     = ERROR;

  //for compliance (2.05-> RNEG2009_MERCO)
  //for compliance (2.07, 2.08 -> RNEG2009_MERCOSUR)
  // Compare Config Version of 2009 device from MERC "RNEG2009_MERCOSUR"

  if (   ('0' == p_device_config_system_version[6])
      && ('9' == p_device_config_system_version[7]))
  {

    if (   ('M' == p_device_config_system_version[9])
        && ('E' == p_device_config_system_version[10])
        && ('R' == p_device_config_system_version[11])
        && ('C' == p_device_config_system_version[12])
        && ('O' == p_device_config_system_version[13])
       )
    {

      // known config version, so the upgrade is authorised
      logMsg ( "This upgrade is authorized FROM : \"%s\" TO \"%s\" \n",
               p_device_config_system_version ,
               p_usb_upg_config_syst_vers,
               0, 0, 0, 0 );
      l_status = OK;
    }
  }
  return (l_status);

}



