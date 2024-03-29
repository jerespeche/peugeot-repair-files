/*  Command script executed prior to launch official script  */
/*  Used to synchronize builtins environment                 */
//*********************************************************************
//
//  FLASHER.ROM.RNEG.CMD - Command script to upgrade from BootROM
//
//
//
//*********************************************************************
//! @li 2014/04/30 K. KOUEKA : Evo 7309 - cross upgrade merco
//!  ->  adding fnts "GetConfigSystemVersion", "MoveLogFile", "IsItOfCIH_family"
//!  -> "MoveLogFileIfCIH_family"
//! @li 2013/04/03 K. KOUEKA   : Allow rebbot if MBR tag has been updated
//! @li 2013/03/03 K. KOUEKA   : Setting up SDcard Tag for cross update
//! @li 2013/02/22 K. KOUEKA   : Validation of RENESAS flashing for cross update
//! @li 2013/02/12 K. KOUEKA   : Validation of BootRom flashing for cross update


/*** TYPES ***/

typedef int  STATUS;
typedef int  BOOL;
typedef void *MODULE_ID;


/*** CONSTANTS ***/

#define TRUE                       (1)
#define FALSE                      (0)
#define O_RDONLY                   (0)
#define O_RDWR                     (2)
#define O_CREAT                    (0x0200)
#define PAUSE                      (2)
#define OK                         (0)
#define OK_MUST_BE_REBOOTED        (1)
#define ERROR                      (-1)
#define NULL                       (void*) 0
#define WATCH_DOG_15_MINUTES       (900)
#define WATCH_DOG_120_MINUTES      (7200)



#define LOAD_NO_SYMBOLS            (2)
#define LOAD_LOCAL_SYMBOLS         (4)
#define LOAD_GLOBAL_SYMBOLS        (8)
#define LOAD_ALL_SYMBOLS           (12)
#define UPG_TEXT_LEN               (48)
#define MAX_PATH_LENGTH            (200)
#define MAX_VERSION_LENGTH         (95)
#define UPG_CD_INF_FILE_NAME      "CD"
#define UPG_CONFIG_INF_FILE_NAME  "Config"
#define UPG_FP_MOT_PATH           "/Application/FP/"
#define UPG_FP_GATEWAY_PATH       "/UPG/Gateway/G_FP_com.CD"
#define UPG_BR_MOT_PATH           "/Application/Boot/"
#define UPG_BR_GATEWAY_PATH       "/UPG/Flasher/FLASHER.OUT.RNEG"

#define UPG_GPH_DRV_PATH          "/Application/BCM/gph/RNEG/DRV_GPH.gz"
#define UPG_SCRIPT                "/UPG/Command/SYSTEM_UPGRADE.RNEG.CMD"
#define UPG_RENESAS_MOT_FILE      "/FPComRNEG.mot"
#define UPG_NEW_BR_DAT_FILE       "/DG4/BOOTROM.DAT"
#define UPG_FILE_CAN_VERSION      "/F/CAN.version"
#define UPG_F_PARTITION           "/F"
#define UPG_FP_ID_2010            (0xFF)
#define UPG_RNEG_2010             "CAN2010"
#define UPG_RNEG_2009             "CAN2004"
#define UPG_DEFAULT_RNEG_TYPE     (2009)
#define UPG_RNEG_2010_TYPE        (2010)

#define MAX_RENESAS_STRING_VER    (10)

/*** EXTERN FUNCTION DEFINITIONS ***/

int EiC_ExeFile(int argc, char **argv);

STATUS GetConfigSystemVersion(unsigned char *p_pVersion);

// Specific version for RNEG (flasher_rom_rneg)
MODULE_ID LoadAndExecuteFile( const char*    p_root,
                           const char*   p_file_name,
                           int           p_ld_symb,
                           int           p_invalid,
                           unsigned int  p_delay,
                           BOOL          p_BUseParam,
                           int           p_param);
BOOL   IsFpInLoader (void);
STATUS LoadGPHDriver (const char *p_Drive, const char *p_DrvPath);

void   PrintTextL1 (const char * l_text);
void   PrintTextL2 (const char * l_text);
void   PrintTextL3 (const char * l_text);
void   PrintClearScreen (void);

int    GetHardRelease (void);
STATUS GetBootromVersion (char *p_pVersion);
STATUS RebootSystem (void);

STATUS GetFileVersion (char *l_pBynaryFileName, char *l_pVersion);
STATUS GetFileConfigVersion20092010 (char * l_pPath,
                              char * l_pMediaCONFIG_INFVersion,
                              char * l_pMediaCONFIG_INFVersion2009,
                              char * l_pMediaCONFIG_INFVersion2010);
STATUS CheckCRCFile (char *l_file);

STATUS FPComRenesasOpen (void);
STATUS FPComRenesasSetEOLMode (void);
STATUS FPComRenesasGetEOLSWId (char *p_SWId);
STATUS FPComRenesasSetLoaderMode (void);
STATUS FPComRenesasGetFPId (int * p_pFPId);
STATUS FPComRenesasGetAllId (int* p_pMBId, int* p_pDBId, int* p_pFPId);
STATUS FPComRenesasRebootAllEOL (void);
STATUS GatewayWaitForAllTerminations (void);
STATUS GatewayExecute(  char* p_Gateway, char* p_Flasher, char* p_StartFunction,
                      char* p_StatusFunc, char* p_DataFile1, char* p_DataFile2,
                      char* p_DataFileVersion, BOOL p_FromAppli, int p_GwId );
STATUS LaunchAndExecuteBootRomUpgrade ( char * l_pBR_GW_FilePath, char *l_pBR_Flasher_Path);

int    logMsg (char *str,int p1,int p2,int p3,int p4,int p5,int p6);

STATUS strcpy (char* target, char* source);
STATUS strcat (char* target, char* source);
int    strcmp (char* str1, char* str2);
int    strncmp(const char* s1, const char* s2, int n );
int    open (const char * name, int flags, int mode );
int read (int fd, char * buffer, int maxbytes);
int write (int fd, char * buffer, int maxbytes);

STATUS close (int fd);

STATUS ShowCDProblem(void);
STATUS ClearScreen(void);

void   SetRebootAfterScript( int truefalse);

STATUS taskDelay (int ticks);
STATUS GetCDVersion(char *cdVersion);
STATUS SetCDVersion(char *cdVersion);
STATUS SetDBBootFPModuleVersionString (char *p_Version);
STATUS GetDBBootFPModuleVersionString (char *p_Version);
STATUS LaunchWatchDog (int p_TimeInSecs);
STATUS SetUpgradeLogging( int TRUEFALSE );
STATUS EnableHistoryHandler ( int TRUEFALSE );
STATUS PartionningSD (void);

STATUS GetCANConfigFile(char* p_ile_path, int* p_file_path_L, char* p_can_ver);
STATUS SetCANConfigFile(char* p_ile_path, int* p_file_path_L, char* p_can_ver);
STATUS CheckRenesasConfig(void);
STATUS MoveLogFile(void);

int atoi(char * s);

int strlen (const char * s );

/*** Local Functions ***/
void WaitAndReboot(void);
void ErrorEndScript(void);
STATUS CheckAndUpgradeFP ( char *p_Drive,
                        char *p_pMediaCONFIG_INFVersion,
                        char *p_pMediaCONFIG_INFVersion2009,
                        char *p_pMediaCONFIG_INFVersion2010);

STATUS CheckAndUpgradeBR (char *p_Drive,
                        char *p_pMediaCONFIG_INFVersion,
                        char *p_pMediaCONFIG_INFVersion2009,
                        char *p_pMediaCONFIG_INFVersion2010);

STATUS CheckAndSetSDCardTag(int* p_mbr_updated);
STATUS OpenRenesasCOMandSetEOLMode(void);

STATUS CheckAndFlashBRifNecessary (char* p_BR_GW_filePath,
                              char* p_BR_Flasher_Path,
                              char* p_pMediaBR_INFVersion,
                              char* p_pBRVersion);
STATUS UpdateAndSaveCANfile(unsigned char p_FP_id);
STATUS GetRenesasProtoType(int* p_Renesas_vers);
void CompleteRenesasMotFilePath(char* p_Renesas_mot_file,
                                int p_Renesas_vers,
                                char* p_ConfigVersion2010,
                                char* p_ConfigVersion2009);

STATUS IsItOfCIH_family (void);
STATUS MoveLogFileIfCIH_family (void);



/*** MAIN ***/
// l_argv[0] = p_script_path;     => "UPG/Command/FLASHER.ROM.RNEG.CMD"
// l_argv[1] = (char *)p_Drive;
// l_argv[2] = UPG_TYPE_BOOTROM;
int main ( int argc, char **argv )
{
  STATUS  l_script_status = OK;
  STATUS l_Memory = OK;
  char   *l_pTab[3];
  char    l_pScriptFile [MAX_PATH_LENGTH];
  char    l_pSourceDrive[MAX_PATH_LENGTH];
  char    l_pUpgType    [MAX_PATH_LENGTH];
  int     l_fdSDC = ERROR;
  int     l_fdSDI = ERROR;
  int     l_fdSDH = ERROR;
  BOOL    l_bSDMustBePartionned = FALSE;

  int     l_iFd = 0;
  char    l_pSourcePath [MAX_PATH_LENGTH];
  MODULE_ID l_pModuleId = NULL;

  int     l_mbr_updated  = 0;
  // Working path...
  char    l_pPath                   [MAX_PATH_LENGTH];

  char    l_pMediaCD_INFVersion     [MAX_VERSION_LENGTH];
  char    l_pMediaCONFIG_INFVersion [MAX_VERSION_LENGTH];

  char    l_pOldCDVersion           [MAX_VERSION_LENGTH];

  char    l_pMediaCONFIG_INFVersion2009[MAX_VERSION_LENGTH];
  char    l_pMediaCONFIG_INFVersion2010[MAX_VERSION_LENGTH];

  SetUpgradeLogging (TRUE);
  EnableHistoryHandler (TRUE);

  l_pTab[0] = l_pScriptFile;
  l_pTab[1] = l_pSourceDrive;
  l_pTab[2] = l_pUpgType;

  // Here, the Media is OK.
  PrintTextL3 ("Keep engine running and do not remove media...");
  PrintTextL1 ("Loading...");


  if ( 0 == strcmp ( argv[2], "NORMAL") )
  {
    logMsg ( "\n\nFLASHER.ROM.RNEG : Loading upgrade script in Normal mode...\n\n",0,0,0,0,0,0 );
  }
  else if ( 0 == strcmp ( argv[2], "BOOTROM") )
  {
    logMsg ( "\n\nFLASHER.ROM.RNEG : Loading upgrade script in BootRom mode...\n\n",0,0,0,0,0,0 );
  }
  else if ( 0 == strcmp ( argv[2], "RECOVERY") )
  {
    logMsg ( "\n\nFLASHER.ROM.RNEG : Loading upgrade script in Recovery mode...\n\n",0,0,0,0,0,0 );
  }
  else
  {
    ErrorEndScript();
    SetUpgradeLogging (PAUSE);
    l_script_status = ERROR;
    // End of script...
    return (l_script_status);
  }

  // Read the version of the product on Media
  strcpy(l_pPath, argv[1]);
  strcat(l_pPath,UPG_CONFIG_INF_FILE_NAME);
  if (ERROR == GetFileConfigVersion20092010 (l_pPath,
                                              l_pMediaCONFIG_INFVersion,
                                              l_pMediaCONFIG_INFVersion2009,
                                              l_pMediaCONFIG_INFVersion2010))
  {
    logMsg ( "GetFileVersion error on %s\n",l_pPath,0,0,0,0,0 );
    ErrorEndScript();
    SetUpgradeLogging (PAUSE);
    l_script_status = ERROR;
    // End of script...
    return (l_script_status);
  }
  else
  {
    logMsg ( "==> Config version is %s\n",l_pMediaCONFIG_INFVersion,0,0,0,0,0 );
  }

  // Read the version of the Media on Media
  strcpy(l_pPath, argv[1] );
  strcat(l_pPath,UPG_CD_INF_FILE_NAME);
  if ( ERROR == GetFileVersion(l_pPath, l_pMediaCD_INFVersion) )
  {
    logMsg ( "GetFileVersion error on %s\n",l_pPath,0,0,0,0,0 );
    ErrorEndScript();
    SetUpgradeLogging (PAUSE);
    l_script_status = ERROR;
    // End of script...
    return (l_script_status);
  }
  else
  {
    logMsg ( "==> CD version is %s\n",l_pMediaCD_INFVersion,0,0,0,0,0 );
  }

  LaunchWatchDog (WATCH_DOG_15_MINUTES);

  // Check and upgrade the BR if needed !
  PrintTextL1 ( "Check BootRom version...");

  if (ERROR != l_script_status)
  {
    PrintTextL2 (" ");
    l_script_status = CheckAndUpgradeBR (argv[1],
                                         l_pMediaCONFIG_INFVersion,
                                         l_pMediaCONFIG_INFVersion2009,
                                         l_pMediaCONFIG_INFVersion2010);
    if (OK_MUST_BE_REBOOTED == l_script_status)
    {
      l_Memory = OK_MUST_BE_REBOOTED;
    }
  }

  // Check and upgrade the FP if needed !
  PrintTextL1 ( "Check Front Panel version...");
  if (   (OK == l_script_status)
      || (OK_MUST_BE_REBOOTED == l_Memory))
  {
    l_script_status = CheckAndUpgradeFP (argv[1],
                                         l_pMediaCONFIG_INFVersion,
                                         l_pMediaCONFIG_INFVersion2009,
                                         l_pMediaCONFIG_INFVersion2010);
    if (OK_MUST_BE_REBOOTED == l_script_status)
    {
      l_Memory = OK_MUST_BE_REBOOTED;
    }
  }

  if (OK_MUST_BE_REBOOTED == l_Memory)
  {
    SetUpgradeLogging (PAUSE);
    WaitAndReboot();
  }

  //SD or not ?
  l_fdSDC = open ("/SDC", O_RDWR, 0);
  l_fdSDI = open ("/SDI", O_RDWR, 0);
  l_fdSDH = open ("/SDH", O_RDWR, 0);

  if ((ERROR == l_fdSDC) || (ERROR == l_fdSDI) || (ERROR == l_fdSDH))
  {
    logMsg ( "==> ERROR for one or more SD partition : SDC (%d), SDI (%d), SDH (%d)\n",
              l_fdSDC, l_fdSDI, l_fdSDH, 0, 0, 0);
    PrintTextL1 ("Partitionning the SD...");
    l_bSDMustBePartionned = TRUE;
  }

  if (ERROR != l_fdSDC)
  {
    close (l_fdSDC);
  }
  if (ERROR != l_fdSDI)
  {
    close (l_fdSDI);
  }
  if (ERROR != l_fdSDH)
  {
    close (l_fdSDH);
  }

  if (TRUE == l_bSDMustBePartionned)
  {
    if (ERROR == PartionningSD ())
    {
      logMsg("==> ERROR during SD partitionning !!!\n",0,0,0,0,0,0);
      PrintTextL1 ("ERROR during SD partitionning !!!\n");
      SetUpgradeLogging (PAUSE);
      WaitAndReboot ();
    }
    else
    {
      logMsg("==> Partitions newly created !!! \n",0,0,0,0,0,0);
    }
  }

  PrintTextL1 ("Check and set MBR tag !!!\n");
  //call builtin CheckAndSetSDCardTag(); here
  if ( ERROR == CheckAndSetSDCardTag(&l_mbr_updated))
  {
    logMsg("==> ERROR When Setting MBR Tag !!!\n",0,0,0,0,0,0);
    PrintTextL1 ("ERROR When Setting MBR Tag !!!\n");
    SetUpgradeLogging (PAUSE);
    WaitAndReboot ();
  }
  else
  {
    if (1 == l_mbr_updated)
    {
      PrintTextL1 ("MBR tag has been Updated!!!\n");
      SetUpgradeLogging (PAUSE);
      MoveLogFileIfCIH_family();

      WaitAndReboot ();
    }
  }


  // Unload the old GPH driver and load the new one...
  LoadGPHDriver (argv[1], UPG_GPH_DRV_PATH);
  PrintClearScreen ();
  PrintTextL1 ("Loading Upgrade Application...");

  // Get the last used upgrade CD number
  if ( ERROR == GetCDVersion(l_pOldCDVersion) )
  {
    logMsg("WARNING: GetCDVersion error, assuming 0000\n",0,0,0,0,0,0);
    strcpy(l_pOldCDVersion, "0000");
  }
  logMsg( "==> CD version in DBBoot = %s\n" ,(char*)l_pOldCDVersion,0,0,0,0,0);

  // Launch script
  if ( OK == l_script_status )
  {
    strcpy ( l_pScriptFile, argv[1] );
    strcat ( l_pScriptFile, UPG_SCRIPT);

    strcpy ( l_pSourceDrive, argv[1] );
    strcpy ( l_pUpgType, argv[2] );

    LaunchWatchDog (WATCH_DOG_120_MINUTES);

    if ( 0 == strcmp ( argv[2], "NORMAL") )
    {
      if ( ERROR == EiC_ExeFile(1, l_pTab) )
      {
        logMsg ( "EiC_ExeFile error on %s\n", (char*)l_pScriptFile, 0,0,0,0,0 );
        ClearScreen();
        l_script_status = ERROR;
      }
    }
    else
    {
      if ( ERROR == EiC_ExeFile(3, l_pTab) )
      {
        logMsg ( "EiC_ExeFile error on %s\n", (char*)l_pScriptFile, 0,0,0,0,0 );
        ClearScreen();
        l_script_status = ERROR;
      }
    }
  }

  SetUpgradeLogging (PAUSE);

  PrintTextL1 ("Upgrade Application Ended...");

  return l_script_status;
}


STATUS CheckAndUpgradeBR (char *p_Drive,
                          char *p_pMediaCONFIG_INFVersion,
                          char *p_pMediaCONFIG_INFVersion2009,
                          char *p_pMediaCONFIG_INFVersion2010)
{
  STATUS  l_script_status = ERROR;
  STATUS  l_script_progress_status = OK;

  char    l_pMediaBR_INFVersion     [MAX_VERSION_LENGTH];
  char    l_pBRVersion              [MAX_VERSION_LENGTH];
  char    l_pBR_Flasher_Path        [MAX_PATH_LENGTH];
  char    l_pBR_GW_FilePath         [MAX_PATH_LENGTH];
  int  l_iMBid = 0;
  int  l_iDBid = 0;
  int  l_iFPid = 0;

  logMsg ( "\n\nBR CheckAndUpgradeBR\n\n", 0, 0, 0, 0, 0, 0 );

  if( IsFpInLoader())
  {
    logMsg ( "CheckAndUpgradeBR : IsFpInLoader() is true \n", 0, 0, 0, 0, 0, 0 );
    l_script_status = OK;
    //return OK
  }
  else
  {
    //
    //1- open Renesas Com and set EOL mode
    l_script_status = OpenRenesasCOMandSetEOLMode();
    if (OK == l_script_status)
    {
      logMsg ( "CheckAndUpgradeBR : OpenRenesasCOMandSetEOLMode Succed !!!\n",0,0,0,0,0,0 );
      //2- Get all ID
      l_script_status = FPComRenesasGetAllId (&l_iMBid, &l_iDBid, &l_iFPid);
    }

    if (OK == l_script_status)
    {
      logMsg ( "CheckAndUpgradeBR : FP_ComRenesasGetAllId Succed !!!\n",0,0,0,0,0,0 );
      logMsg ( "CheckAndUpgradeBR : GetAllId param received '%d' '%d' '%d'\n",
              l_iMBid, l_iDBid,l_iFPid, 0, 0, 0 );


//we have 2 bootrom use "l_iDBid" for distingo before building the path

      //3- Compute the BR file name.
      strcpy ( l_pBR_Flasher_Path, p_Drive);
      strcat ( l_pBR_Flasher_Path, UPG_BR_MOT_PATH);
      strcat ( l_pBR_Flasher_Path, p_pMediaCONFIG_INFVersion);
      strcat ( l_pBR_Flasher_Path, UPG_NEW_BR_DAT_FILE);
      logMsg ( "CheckAndUpgradeBR : BR file name '%s' \n", (int)l_pBR_Flasher_Path, 0, 0, 0, 0, 0 );

      //4- Check the BR quality
      l_script_status = CheckCRCFile(l_pBR_Flasher_Path);
    }

    //5- Read the BootRom version on the upgrade media
    if( OK == l_script_status)
    {
      logMsg ( "CheckAndUpgradeBR : CheckCRCFile Succed !!!\n",0,0,0,0,0,0 );
      l_script_status = GetFileVersion (l_pBR_Flasher_Path, l_pMediaBR_INFVersion);
    }

    //6- Read the version of the current BootRom
    if( OK == l_script_status)
    {
      logMsg ( "CheckAndUpgradeBR : GetFileVersion Succed !!!\n",0,0,0,0,0,0 );
      logMsg ( "==> BR version on media is '%s'\n", l_pMediaBR_INFVersion, 0, 0, 0, 0, 0 );
      l_script_status = GetBootromVersion (l_pBRVersion);
    }

    //7- Check BR and Flash if necessary
    if( OK == l_script_status)
    {
      logMsg ( "CheckAndUpgradeBR : GetBootromVersion Succed !!!\n",0,0,0,0,0,0 );
      logMsg ( "==> Current BR version is '%s'\n", l_pBRVersion, 0, 0, 0, 0, 0 );
      strcpy ( l_pBR_GW_FilePath, p_Drive);
      l_script_status = CheckAndFlashBRifNecessary (l_pBR_GW_FilePath,
                                                    l_pBR_Flasher_Path,
                                                    l_pMediaBR_INFVersion,
                                                    l_pBRVersion);
    }

    //8- leave if succes or Error
    if (OK == l_script_status)
    {
      // If Here, it's OK
      logMsg ( "\t CheckAndUpgradeBR : CheckAndFlashBRifNecessary Succed\n",0,0,0,0,0,0 );
      //save on F/CAN.version the version (2010 or 2009)
      UpdateAndSaveCANfile ((unsigned char) l_iFPid);
    }
    else if (OK_MUST_BE_REBOOTED == l_script_status)
    {
      // If Here, it's OK
      logMsg ( "\t CheckAndUpgradeBR : CheckAndFlashBRifNecessary Succed\n",0,0,0,0,0,0 );
      SetUpgradeLogging (PAUSE);
      //l_script_status = OK_MUST_BE_REBOOTED;

      //save on F/CAN.version the version (2010 or 2009)
      UpdateAndSaveCANfile ((unsigned char) l_iFPid);
    }
    else if (ERROR == l_script_status)   //only error case here
    {
      logMsg ( "CheckAndUpgradeBR : An error occured! Check the last success. !!!\n",0,0,0,0,0,0 );
      ErrorEndScript();
      // End of script..
    }

  }

  return (l_script_status);
}


STATUS CheckAndUpgradeFP (char *p_Drive,
                          char *p_pMediaCONFIG_INFVersion,
                          char *p_pMediaCONFIG_INFVersion2009,
                          char *p_pMediaCONFIG_INFVersion2010)
{
  STATUS  l_script_status = OK;

  char    l_pMediaMOT_INFVersion    [MAX_VERSION_LENGTH];
  char    l_pFPVersion              [MAX_VERSION_LENGTH];
  char    l_pDBBootMOT_Version      [MAX_VERSION_LENGTH];
  char    l_pFP_MOT_FilePath        [MAX_PATH_LENGTH];
  char    l_pFP_GW_FilePath         [MAX_PATH_LENGTH];
  char    l_text1                   [UPG_TEXT_LEN];

  int   l_fd_renesas;
  int   l_iMB_id;
  int   l_iDB_id;
  int   l_iFP_id;
  int   l_iRenesasVersion = 2009;
  char  l_buffer[MAX_RENESAS_STRING_VER];

  logMsg ( "\n\nFP CheckAndUpgradeFP\n\n", 0, 0, 0, 0, 0, 0 );

  // Compute the FP file name.
  strcpy ( l_pFP_MOT_FilePath, p_Drive );
  strcat ( l_pFP_MOT_FilePath, UPG_FP_MOT_PATH);
  //strcat ( l_pFP_MOT_FilePath, p_pMediaCONFIG_INFVersion);
  //strcat ( l_pFP_MOT_FilePath, "/");

  // FP in loader mode ?
  if (TRUE == IsFpInLoader())
  {
    //
    logMsg ( "FP in Loader mode (flashing %s)\n", (int)p_pMediaCONFIG_INFVersion, 0, 0, 0, 0, 0 );
    strcpy ( l_text1, "FP in loader mode, flashing '" );
    strcat ( l_text1, p_pMediaCONFIG_INFVersion);
    strcat ( l_text1, "'");
    PrintTextL1 ( l_text1 );

    //compute the FP file Name
    //B.2- Get proto version 2010 or 2009
    GetRenesasProtoType(&l_iRenesasVersion); // doesn't matter if ERROR returned

    //B.3- Finalise the FP file name.
    CompleteRenesasMotFilePath (l_pFP_MOT_FilePath,
                                l_iRenesasVersion,
                                p_pMediaCONFIG_INFVersion2010,
                                p_pMediaCONFIG_INFVersion2009);

    //B.4- update the massage on Screen
    strcpy ( l_text1, "FP in loader mode, flashing '" );
    if ( UPG_RNEG_2010_TYPE == l_iRenesasVersion)
    {
      strcat ( l_text1, p_pMediaCONFIG_INFVersion2010);
    }
    else if ( UPG_RNEG_2010_TYPE == l_iRenesasVersion)
    {
      strcat ( l_text1, p_pMediaCONFIG_INFVersion2009);
    }
    else
    {
      strcat ( l_text1, p_pMediaCONFIG_INFVersion);
    }

    strcat ( l_text1, "'");
    PrintTextL1 ( l_text1 );
    logMsg ( "FP in Loader mode (flashing %s)\n", (int)l_text1, 0, 0, 0, 0, 0 );

    //B.5- Compute the FP GW file name.
    strcpy ( l_pFP_GW_FilePath, p_Drive);
    strcat ( l_pFP_GW_FilePath, UPG_FP_GATEWAY_PATH);

    logMsg ( "FP GW file and path : '%s'\n", (int)l_pFP_GW_FilePath, 0, 0, 0, 0, 0 );
    logMsg ( ".mot  file and path : '%s'\n", (int)l_pFP_MOT_FilePath, 0, 0, 0, 0, 0 );

    logMsg ( "CheckAndUpgradeFP : launching FP gateway \n",0,0,0,0,0,0 );
    //B.6- Run the FP Flasher with the good path and file.
    l_script_status = GatewayExecute (  l_pFP_GW_FilePath,      // p_Gateway
                                    "",                     // p_Flasher
                                    "LaunchUpgrade",        // p_StartFunction
                                    "GetGatewayStatus__Fv", // p_StatusFunc
                                    l_pFP_MOT_FilePath,     // Gateway : filename1
                                    "",                     // Gateway : filename2
                                    NULL,                   // Gateway : fileVersion
                                    FALSE,                  // Gateway : fromApplication
                                    0 );                   // Gateway : fpGwID
    if (OK == l_script_status)
    {
      logMsg ( "CheckAndUpgradeFP : GatewayExecute Succed !!!\n",0,0,0,0,0,0 );
      //B.7- wait for the end of the external upgrade
      l_script_status = GatewayWaitForAllTerminations();
      if ( ERROR == l_script_status )
      {
        PrintTextL1 ( "FP NOT flashed successfully...");
      }
    }

    if (OK == l_script_status)
    {
      logMsg ( "CheckAndUpgradeFP : GatewayWaitForAllTerminations Succed !!!\n",0,0,0,0,0,0 );
      //B.8- set FP Version into DB_Boot using GetFileVersion
      l_script_status = GetFileVersion(l_pFP_MOT_FilePath, l_pMediaMOT_INFVersion);

    }

//B.9
    if (OK == l_script_status)
    {
      logMsg ( "CheckAndUpgradeFP : GetFileVersion Succed !!!\n",0,0,0,0,0,0 );
      // Set the DBBoot...
      SetDBBootFPModuleVersionString (l_pMediaMOT_INFVersion);

      PrintTextL1 ( "FP flashed successfully...");
      l_script_status = OK_MUST_BE_REBOOTED;
      logMsg ( "CheckAndUpgradeFP : FP flashed successfully !!!\n",0,0,0,0,0,0 );
    }

    if ( ERROR == l_script_status)
    {
      PrintTextL1 ( "An error occured! Check the last success...");
      logMsg ("CheckAndUpgradeFP : An error occured! Check the last success \n",0,0,0,0,0,0);
    }

  }
  else // Verify the version of the FP...
  {

    //A.1- open Renesas Com and set EOL mode
    l_script_status = OpenRenesasCOMandSetEOLMode();
    if (OK == l_script_status)
    {
      logMsg ( "CheckAndUpgradeFP : OpenRenesasCOMandSetEOLMode Succed !!!\n",0,0,0,0,0,0 );
      //A.2- Get Renesas SW ID
      l_script_status = FPComRenesasGetEOLSWId (l_pFPVersion);
    }

    if (OK == l_script_status)
    {
      logMsg ( "CheckAndUpgradeFP : FPComRenesasGetEOLSWId Succed !!!\n",0,0,0,0,0,0 );
      logMsg ( "CheckAndUpgradeFP ==> FP version SW Id = %s\n", l_pFPVersion, 0, 0, 0, 0, 0 );
      //A.3- Get proto version 2010 or 2009
      GetRenesasProtoType(&l_iRenesasVersion); // doesn't matter if ERROR returned

      //A.4- Finalise the FP file name.
      CompleteRenesasMotFilePath (l_pFP_MOT_FilePath,
                                  l_iRenesasVersion,
                                  p_pMediaCONFIG_INFVersion2010,
                                  p_pMediaCONFIG_INFVersion2009);

      //A.5- Check CRC of Renesas Mot file
      l_script_status = CheckCRCFile( l_pFP_MOT_FilePath );
    }

    if( OK == l_script_status)
    {
      logMsg ( "CheckAndUpgradeFP : CheckCRCFile Succed !!!\n",0,0,0,0,0,0 );
      //A.6- Get new Renesas version (version of the mot file present .inf file)
      l_script_status = GetFileVersion(l_pFP_MOT_FilePath, l_pMediaMOT_INFVersion);
    }

    if( OK == l_script_status)
    {
      logMsg ( "CheckAndUpgradeFP : GetFileVersion Succed !!!\n",0,0,0,0,0,0 );
      logMsg ( "CheckAndUpgradeFP : New version '%s'\n",l_pMediaMOT_INFVersion,0,0,0,0,0 );
      //A.7- compare the version of the mot file

      // If version are differents, Set the FP in loader mode and reboot
      if (0 != strcmp (l_pMediaMOT_INFVersion, l_pFPVersion))
      {
        strcpy (l_text1, "Set FP in loader mode : v");
        strcat (l_text1, l_pFPVersion);
        strcat (l_text1, " to.v");
        strcat (l_text1, l_pMediaMOT_INFVersion);
        PrintTextL1 (l_text1);

        if (ERROR == FPComRenesasSetLoaderMode ())
        {
          logMsg ( "CheckAndUpgradeFP : FPComRenesasSetLoaderMode error !!!\n", 0, 0, 0, 0, 0, 0 );
        }
        SetUpgradeLogging (PAUSE);
        WaitAndReboot ();
      }
      else
      {
        logMsg ( "CheckAndUpgradeFP : Same versions detected, no upgrade needed.\n", 0, 0, 0, 0, 0, 0 );

        // Set the DBBoot if not OK...
        if ( OK == GetDBBootFPModuleVersionString (l_pDBBootMOT_Version))
        {
          if (0 != strcmp (l_pDBBootMOT_Version, l_pMediaMOT_INFVersion))
          {
            logMsg( "CheckAndUpgradeFP : Set DBBoot with .FP Version : %s\n",
                    (int)l_pMediaMOT_INFVersion, 0, 0, 0, 0, 0 );
            SetDBBootFPModuleVersionString (l_pMediaMOT_INFVersion);
          }
          else
          {
            logMsg ( "CheckAndUpgradeFP : DBBoot has been updated : DBBoot='%s'  MediaMot='%s'\n",
                     (int)l_pDBBootMOT_Version,
                     (int)l_pMediaMOT_INFVersion,
                     0, 0, 0, 0 );
          }
        }
        else
        {
          logMsg( "CheckAndUpgradeFP : GetDBBootFPModuleVersionString failed : %s\n",
                  (int)l_pDBBootMOT_Version, 0, 0, 0, 0, 0 );
        }

        logMsg ( "CheckAndUpgradeFP : Same versions detected, no upgrade needed.\n", 0, 0, 0, 0, 0, 0 );
        if( OK == CheckRenesasConfig ())  // Evo 6665
        {
          l_script_status = OK;
        }
        else
        {
          l_script_status = OK_MUST_BE_REBOOTED;
        }

      }
    }

    //close RENESAS Com




//////////////////////////ERROR ////////////////////////
    if (ERROR == l_script_status)
    {
      logMsg ( "CheckAndUpgradeFP : An error occured! Check the last success. !!!\n",0,0,0,0,0,0 );
      ErrorEndScript();
      // End of script...
    }
//////////////////////////ERROR ////////////////////////

  }

  return (l_script_status);
}

void ErrorEndScript(void)
{
  ShowCDProblem();
}

void WaitAndReboot(void)
{
  int   l_iCpt;
  char  l_text2 [UPG_TEXT_LEN];

  for (l_iCpt=5; l_iCpt>0; l_iCpt--)
  {
    strcpy (l_text2, "Reboot in   s");
    // WARNING, 10 is "in [x] s"
    l_text2[10] = '0'+l_iCpt;
    PrintTextL2 (l_text2);
    taskDelay (500);
  }

  RebootSystem ();
}


//open Renesas Com and set EOL mode
STATUS OpenRenesasCOMandSetEOLMode(void)
{
  STATUS  l_script_status = ERROR;

  // Open the com with the FP
  l_script_status = FPComRenesasOpen();
  if (OK == l_script_status)
  {
    //logMsg ( "OpenRenesasCOMandSetEOLMode : FPComRenesasOpen Succed !!!\n", 0,0,0,0,0,0 );
    // Switch the RNEG on EOL mode
    l_script_status = FPComRenesasSetEOLMode();
  }

  return (l_script_status);
}

//Check BR and flash proto if necessary
STATUS CheckAndFlashBRifNecessary(char* p_BR_GW_filePath,
                                  char* p_BR_Flasher_Path,
                                  char* p_pMediaBR_INFVersion,
                                  char* p_pBRVersion)
{
  STATUS  l_status = ERROR;
  char    l_pBR_GW_File_Path [MAX_PATH_LENGTH];


  // check If version are differents, then  Flash the BootRom
  if (0 == strcmp (p_pMediaBR_INFVersion, p_pBRVersion))
  {
    logMsg ( "\t CheckAndFlashBRifNecessary : BOOTROM Version : OK\n",0,0,0,0,0,0 );
    l_status = OK;
    //leave
  }
  else
  {
    //build path
    strcpy ( l_pBR_GW_File_Path, p_BR_GW_filePath);
    strcat ( l_pBR_GW_File_Path, UPG_BR_GATEWAY_PATH);

    logMsg ( "\t CheckAndFlashBRifNecessary : FP GW file and path : '%s'\n",
             (int)l_pBR_GW_File_Path, 0, 0, 0, 0, 0 );
    logMsg ( "\t CheckAndFlashBRifNecessary : DAT  file and path : '%s'\n",
             (int)p_BR_Flasher_Path, 0, 0, 0, 0, 0 );

    // Check the quality of the flasher
    l_status = CheckCRCFile( l_pBR_GW_File_Path );

    if (OK == l_status)
    {
      logMsg ( "\t CheckAndFlashBRifNecessary : CheckCRCFile Succed\n",0,0,0,0,0,0 );
      PrintTextL1 ( "Flashing the BootRom...");
      l_status = LaunchAndExecuteBootRomUpgrade (l_pBR_GW_File_Path,
                                                 p_BR_Flasher_Path);
    }

    if (OK == l_status)
    {
      // If Here, it's OK
      PrintTextL1 ( "BootRom successfully flashed");
      l_status = OK_MUST_BE_REBOOTED;
    }
  }

  return (l_status);

}


STATUS UpdateAndSaveCANfile(unsigned char p_FP_id)
{
  STATUS  l_file_status = ERROR;
  int l_fd_F_part = -1;
  int l_fd_can_file = -1;
  int l_nb_written = -1;
  int l_file_path_L = -1;
  int l_ind = 0;

  logMsg ("SaveOrUpdateCANfile ==> SAve '/F/CAN.version' \n",0,0, 0, 0, 0, 0);
  //check file and create it if not exist
//  l_fd_F_part = open (UPG_F_PARTITION, O_RDWR, 0);
//  if (0 < l_fd_F_part) //fd should be a positive value
  {
 //   close (l_fd_F_part);

    l_file_path_L = strlen(UPG_FILE_CAN_VERSION) + 1;
    logMsg ("SaveOrUpdateCANfile ==> strlen('/F/CAN.version') =%d \n",l_file_path_L,0, 0, 0, 0, 0);
    if (UPG_FP_ID_2010 == p_FP_id)
    {
      l_file_status = SetCANConfigFile (UPG_FILE_CAN_VERSION,
                                        &l_file_path_L,
                                        UPG_RNEG_2010);
    }
    else
    {
      l_file_status = SetCANConfigFile (UPG_FILE_CAN_VERSION,
                                        &l_file_path_L,
                                        UPG_RNEG_2009);
    }

    if( OK == l_file_status)
    {
      logMsg ( "SaveOrUpdateCANfile ==> Update '/F/CAN.version' file Succed \n",
              0, 0, 0, 0, 0, 0);
    }
    else
    {
      logMsg ( "SaveOrUpdateCANfile ==> ERROR to update '/F/CAN.version' file! \n",
              0, 0, 0, 0, 0, 0);
    }
  }
//  else
//  {
//    logMsg ("SaveOrUpdateCANfile ==> ERROR to access '/F' partition! fd=(%d),\n",
//            l_fd_F_part,
 //           0, 0, 0, 0, 0);
 // }


  return (l_file_status);
}


STATUS GetRenesasProtoType(int* p_Renesas_vers)
{
  STATUS  l_file_status = ERROR;    //default value
  int l_fd = -1;  //file descriptor
  int l_nb_read = -1;
  char l_buf[MAX_RENESAS_STRING_VER];
  int l_file_path_L = strlen(UPG_FILE_CAN_VERSION) + 1;

  logMsg ("GetRenesasProtoType ==> strlen('/F/CAN.version') =%d \n",l_file_path_L,0, 0, 0, 0, 0);
  l_file_status = GetCANConfigFile(UPG_FILE_CAN_VERSION, &l_file_path_L, l_buf);

  //check if read data is valid
  if(OK == l_file_status)
  {
    logMsg ("GetRenesasProtoType ==> Read '/F/CAN.version'file Succed, (%s)\n",
            (int)l_buf, 0, 0, 0, 0, 0);
    if (OK == strncmp(UPG_RNEG_2010, l_buf, strlen(UPG_RNEG_2010)))
    {
      *p_Renesas_vers = UPG_RNEG_2010_TYPE;
      logMsg ("GetRenesasProtoType ==> UPG_RNEG_2010_TYPE \n",
            0, 0, 0, 0, 0, 0);
    }
     //otherwise invalid or valid 2009 default value
     logMsg ("GetRenesasProtoType ==> *p_Renesas_vers= '%d'\n",
            (*p_Renesas_vers), 0, 0, 0, 0, 0);
  }

  //Error Case
  if (ERROR == l_file_status)
  {
    //p_renesas_ver remains with default value
    //log error message
    logMsg ("GetRenesasProtoType ==> ERROR to access '/F' partition or '/F/CAN.version'file fd=(%d),\n",
            l_fd,
            0, 0, 0, 0, 0);
  }

  return (l_file_status);
}


void CompleteRenesasMotFilePath(char* p_Renesas_mot_file,
                                int p_Renesas_vers,
                                char* p_ConfigVersion2010,
                                char* p_ConfigVersion2009)
{
  logMsg ( "CompleteRenesasMotFilePath : uncomplete FP binary file and path : '%s'\n",
           (int)p_Renesas_mot_file,
              0, 0, 0, 0, 0 );

  if ( UPG_RNEG_2010_TYPE == p_Renesas_vers)
  {
    strcat ( p_Renesas_mot_file, p_ConfigVersion2010);
    logMsg ("CompleteRenesasMotFilePath : version ='%s'\n",
            (int)p_ConfigVersion2010, 0, 0, 0, 0, 0 );
  }
  else
  {
    strcat ( p_Renesas_mot_file, p_ConfigVersion2009);
    logMsg ("CompleteRenesasMotFilePath : version ='%s'\n",
            (int)p_ConfigVersion2009, 0, 0, 0, 0, 0 );
  }

  strcat ( p_Renesas_mot_file, UPG_RENESAS_MOT_FILE);
  logMsg ( "CompleteRenesasMotFilePath : FP binary file and path : '%s'\n",
           (int)p_Renesas_mot_file, 0, 0, 0, 0, 0 );

}




STATUS IsItOfCIH_family (void)
{
  char l_pOldConfigSystemVersion[MAX_VERSION_LENGTH];
  STATUS l_retVal = ERROR;

  // Get the Config version on the DBBoot
  l_retVal = GetConfigSystemVersion ( (unsigned char*)l_pOldConfigSystemVersion );

  if (ERROR == l_retVal)
  {
    logMsg ( "GetConfigSystemVersion on DBBoot FAILED \n", 0, 0, 0, 0, 0, 0 );
    return (l_retVal);
  }

  logMsg (" Installed ConfigSystemVersion ='%s'\n\n", l_pOldConfigSystemVersion, 0, 0, 0, 0, 0 );

  // Compare Config Version to "DEFAULT"
  if (OK == l_retVal)
  {
    //check the soft version
    if (0 == strcmp("RNEG2010_EUROPE", l_pOldConfigSystemVersion))
    {
      l_retVal = OK;
      logMsg ( "Move log file \n",0 , 0, 0, 0, 0, 0 );
    }
    else if (0 == strcmp("RNEG2010_EUROPE_2_1", l_pOldConfigSystemVersion))
    {
      l_retVal = OK;
      logMsg ( "Move log file \n",0 , 0, 0, 0, 0, 0 );
    }
    else if (0 == strcmp("RNEG2010_EUR_2_20", l_pOldConfigSystemVersion))
    {
      l_retVal = OK;
      logMsg ( "Move log file \n",0 , 0, 0, 0, 0, 0 );
    }
    else if (0 == strcmp("RNEG2010_EUR_2_30", l_pOldConfigSystemVersion))
    {
      l_retVal = OK;
      logMsg ( "Move log file \n",0 , 0, 0, 0, 0, 0 );
    }
    else if (0 == strcmp("RNEG2009_MERCO", l_pOldConfigSystemVersion))  //Merco 2.05
    {
      l_retVal = OK;
      logMsg ( "Move log file \n",0 , 0, 0, 0, 0, 0 );
    }
    else if (0 == strcmp("RNEG2009_MERCOSUR", l_pOldConfigSystemVersion))  //Merco 2.07,2.08
    {
      l_retVal = OK;
      logMsg ( "Move log file \n",0 , 0, 0, 0, 0, 0 );
    }
    else if (0 == strcmp("RNEG2010_MERC_2_10", l_pOldConfigSystemVersion)) //Merco 2.11
    {
      l_retVal = OK;
      logMsg ( "Move log file \n",0 , 0, 0, 0, 0, 0 );
    }
    else
    {
      l_retVal = ERROR;
      logMsg ( "DON'T MOVE log file \n",0 , 0, 0, 0, 0, 0 );
    }
  }

  return (l_retVal);

}



STATUS MoveLogFileIfCIH_family (void)
{

  STATUS l_retVal = ERROR;

  // Check if Config version on the DBBoot is of CIH
  l_retVal = IsItOfCIH_family ();

  if (ERROR == l_retVal)
  {
    logMsg ( "IsItOfCIH_family FAILED surely it is not of CIH family \n", 0, 0, 0, 0, 0, 0 );
    return (l_retVal);
  }

  logMsg ("Let's move Log file \n", 0, 0, 0, 0, 0, 0 );

  // Compare Config Version to "DEFAULT"
  if (OK == l_retVal)
  {
    l_retVal = MoveLogFile();
  }

  return (l_retVal);

}







