//*********************************************************************
//
//  SYSTEM_UPGRADE.RNEG.CMD - Command script to upgrade from BootROM
//
//
//  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//
//  NOTE: Set values in UPGRADE FLAGS to enable or disable
//        upgrade sequences
//
//        1 = ENABLE
//        0 = DISABLE
//
//  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//
//*********************************************************************

//! @li 2014/05/19 K.KOUEKA   : Update OPT_SW_MERCO flag for Merc2.0, 2.5, 2.7, 2.8
//! @li 2014/04/30 K.KOUEKA : Evo 7309 - cross upgrade merco
//!   -> Manage F300 calibration for Other merco device
//! @li 2014/04/15 K.KOUEKA   : Setting up OPT_SW_MERCO flag
//! @li 2014/01/24 K KOUEKA   : Update F300 Management for Mercosur
//! @li 2013/11/25 K KOUEKA   : Correction of Defect ... - update F300 management
//! @li 2013/03/08 K KOUEKA   : Update Application upgrade process



/*** UPGRADE FLAGS ***/

#define FORCE_SOFTWARE_UPGRADE      0  // delete everything on /F/Application /SDC/Application and /SDC/Data_base
#define ENABLE_CRC_CHECK            1  // saves time if = 0
#define ENABLE_RECOVERY             0


/*** GLOBAL DEFINES ****/

// Upgrade types
typedef enum
{
  NORMAL = 0,
  BOOTROM,
  RECOVERY
}t_UPGType;

typedef int (*FUNCPTR)(char *sourcedrive, int reboot_at_end);

// Script Types
typedef int  STATUS;
typedef void DIR;
typedef int  BOOL;
typedef int  size_t;
typedef void FILE;
typedef void *MODULE_ID;

#define TRUE     (1)
#define FALSE    (0)
#define PAUSE    (2)
#define OK       (0)
#define ERROR    (-1)
#define NULL     (void*) 0

// Temporary
#define TOTAL_SIZE_OF_APPLI     70000000

// Constants
#define MAX_DRIVE_NAME_LENGTH   10
#define MAX_FILENAME_LENGTH     150
#define MAX_PATH_LENGTH         300
#define MAX_VERSION_LENGTH      95
#define MAX_CRC_LENGTH          20
#define MAX_QUESTION_LENGTH     50
#define MAX_DATE_CLOCK_LENGTH   100
#define MAX_INF_LINE_LENGTH     100
#define MAX_STRING_LENGTH       200

#define MODULE_NO_VERSION       "0000"

#define HDD_APPLI_PART          "/SDC"
#define TEMP_UPGRADE_DIR        "/UPG"
#define RECOVERY_FILE           "/recovery.lst"
#define BACKUP_DIR              "/SDC/BACKUP"
#define BACKUP_BR_DIR           "/SDC/BACKUP_BR/"
#define BACKUP_RENESAS_DIR      "/SDC/BACKUP_RENESAS/"
#define DATA_BASE_LOGO_DIR      "/Data_Base/Graphics/Logo/"
#define DAB_DIR                 "/Application/BlackFin/DAB/"
#define BOOTROM_DAT_FILE        "BOOTROM.DAT"
#define BOOTROM_DAT_FILE_INF    "BOOTROM.DAT.inf"
#define RENESAS_MOT_FILE        "FPComRNEG.mot"
#define RENESAS_MOT_FILE_INF    "FPComRNEG.mot.inf"

#define TURBOBOOT_ENTRY_FILE    "/SDI/Application/TurboBoot/EntryFunc.dat"
#define TURBOBOOT_DIRECTORY     "/SDI/Application/TurboBoot/"

#define UPG_SIRF_DIR            "/SIRF"

#define FSEARCH_TABLE_FILE      "/UPG/Table/table_upgrade_excl.dat"
#define DB_DWNL_FILE            "db_dwnl_ppc.out"

#define UNWANTED_FILES          "/UPG/Purge/UnwantedFiles.txt"
#define UNWANTED_DIRECTORIES    "/UPG/Purge/UnwantedDirectories.txt"

#define LOAD_NO_SYMBOLS             2
#define LOAD_LOCAL_SYMBOLS          4
#define LOAD_GLOBAL_SYMBOLS         8
#define LOAD_ALL_SYMBOLS           12

#define FLASHER_CHK_REPAIR          1
#define FLASHER_CHK_PARTDEVICE      2
#define FLASHER_CHK_PARTDEVICE_FAIL 3

#define UPG_SIRF_PATH_MAX_SIZE      10

#define UPG_DEFAULT_RNEG_TYPE     (2009)
#define UPG_RNEG_2010_TYPE        (2010)

// Drive letters
#define DRIVE_CDROM             "/D"
#define DRIVE_TFFS              "/F"
#define DRIVE_HDD               "/SDC"
#define DRIVE_NAV               "/SDH"
#define DRIVE_USER              "/SDI"


/*** SOFTWARE UPGRADE DEFINES ***/
typedef struct
{
  int   m_iIsNew;
  char  m_pVersion[MAX_VERSION_LENGTH];
  char  m_pFileName[MAX_PATH_LENGTH];
  char  m_pTargetPath[MAX_PATH_LENGTH];
  int   m_iSize;
} t_SoftUpgData;

#define MAX_APPLI_FILES         2000


/*** EXTERNAL UPGRADE DEFINES ***/

// Module IDs
typedef enum
{
  MODULE_ID_FP = 0,
  MODULE_ID_CT = 1,
  MODULE_ID_RADIO = 2,
  MODULE_ID_FP_LOADER = 3,
  MODULE_ID_WISMO = 4,
  MAX_MODULE_NUM
} t_ModuleId;


/*** EXTERN FUNCTION DECLARATIONS ***/

// File operations VxWorks
int    open (const char * name, int flags, int mode);
STATUS close (int fd);
char*  fgets(char * buf, size_t n, FILE * fp);
int    fputs(char * s, FILE * fp);
FILE*  fopen(char * file, char * mode );
int    fclose(FILE * fp);
int    feof(FILE * fp);
DIR*   opendir (char * dirName);
STATUS closedir (DIR *dir);
STATUS xdelete (const char * source);
STATUS mv(char * src, char * dest);

// String operations
STATUS strcpy (char* target, char* source);
STATUS strcat (char* target, char* source);

int    xcopy(char* src, char* dest);
int    strcmp (char* str1, char* str2);
int    strncmp (char* str1, char* str2, int n);
STATUS strlen (char* str);
char*  strstr(char* str, char* substr);
int    atoi(char * s);

// File operations builtins
STATUS UPGCopy (char* p_source, char* p_dest, int p_cut);
STATUS UPGDelete (char* p_file);
STATUS UPGMKDir (char* p_dir);
STATUS UPGMKDelete (char* p_dir);
int    SearchAndTargetFileExclu ( char *Filename,
                         char *Tablename,
                         char *Param[],
                         int   NbParams,
                         char *RootDir,
                         char *TargetDir );
STATUS GetSearchResult(int index , char *SearchResult, char *targetPath );
STATUS GetFileSize(char *file, int *size);
STATUS GetFileVersion (char *l_pBynaryFileName, char *l_pVersion);
STATUS ReadFileCRC(char *l_pBynaryFileName, char *l_pCRC);
STATUS CheckCRCFile (char *l_file);

// External upgrade built ins
STATUS StepBargraph(char *text, int index);
void   PrintTextL1 (const char * l_text);
void   PrintTextL2 (const char * l_text);
void   PrintTextL3 (const char * l_text);
void   PrintClearScreen (void);

// CD ROM
STATUS UPGCDEject(void);
STATUS LockCDEject(int TrueFalse);

// Boot flags
STATUS SetBootromUpgFlag(int stayInBootromUpg);
STATUS GetDBBootFPModuleVersionString (char *p_Version);

// Logging
STATUS SetUpgradeLogging( int TRUEFALSE );
STATUS EnableHistoryHandler ( int TRUEFALSE );
STATUS AddUPGHistoryHeader(char *p_CDNum, char *p_TargetDrive, char *p_Action);
STATUS AddUPGHistoryCommentary (char *p_Comment);

STATUS UPGLogMsg(char* str,int p1,int p2,int p3,int p4,int p5,int p6);

// Others VxWorks
unsigned long tickGet (void);
STATUS        taskDelay (int ticks);
int           logMsg (char* str,int p1,int p2,int p3,int p4,int p5,int p6);

// Other Builtins
STATUS SetCDVersion(char *cdVersion);
STATUS SetConfigSystemVersion(const unsigned char *p_pVersion);
STATUS GetConfigSystemVersion(unsigned char *p_pVersion);
STATUS GetCDVersion(char *cdVersion);
STATUS ComputeCRCFile(char *l_pFileName, char *l_pCRC);
STATUS FormatTffs(void);
STATUS MountCheckTffs(void);
STATUS Remove_Turbo_Boot_Info(void);
STATUS CheckAndRepair (char *);
STATUS CheckAndUnlockSD (void);

//OPT_SW_MERCO flag setting
STATUS CheckSetSwOptMerco(void);

// F300 Strategy
STATUS FPComRenesasSetCalibrationStatusToTrue (void);
STATUS FPComRenesasGetCalibrationStatus       (BOOL *p_answer);

/*** INTERN FUNCTION DECLARATION ***/
STATUS PrepareSoftUpg(t_SoftUpgData *p_pSoftUpgList,
                   char *p_pSourceDrive,
                   char *p_pRootDir,
                   char *p_pMask,
                   char *p_pTargetDrive,
                   char *p_pSearchParams[],
                   int   p_pNbSearchParams,
                   int p_iCheckVersion,
                   unsigned long *p_totalSize
                   );
STATUS PrepareSoftUpg_AbsolutePath ( t_SoftUpgData *p_pList,
                        char *p_pSourceDrive,
                        char *p_pRootDir,
                        char *p_pMask,
                        char *p_pTargetDrive,
                        char *p_pTargetPath,
                        char *p_pSearchParams[],
                        int   p_iNbSearchParams,
                        int   p_pCheckVersion,
                        unsigned long *p_pTotalSize
                      );
STATUS InstallSoftList( t_SoftUpgData *p_pList,
                   unsigned long  p_totalSize,
                   t_UPGType      p_upgType,
                   unsigned long *p_completedSize,
                   BOOL           p_use_temp_names_for_recovery,
                   double        *l_CountFilesCopied,
                   double         l_CountFilesToBeCopied
                   );
STATUS SaveSoftUpgList(t_SoftUpgData *p_pList, char *ListFile);
STATUS SetOKInListFile(char *ListFile);
STATUS ValidateSoftChanges(t_SoftUpgData *p_pList);
int    FileExists(char *p_pPath);
STATUS CleanRecoveryFiles(t_SoftUpgData *p_pList);
STATUS EndUpgrade(char *p_SourceDrive);
STATUS PrepareDbDwnlUpg( t_SoftUpgData *p_list,
                         char *p_source_drive,
                         char *p_root,
                         unsigned long *p_totalSize);
void   CleanLine(char * p_pLine);
STATUS BackUpBR (char *pPath);
STATUS BackUpRenesas (char *pPath);
void   RemoveUnwantedFiles(char *p_SourceDrive);
void   RemoveUnwantedDirectories(char *p_SourceDrive);
STATUS CheckAndRepairSDs (void);
STATUS CleanPartitionsStatus (void);
void CheckAndCopySIRFdirIfExist(char* p_pSourceDrive);

STATUS GetFileConfigVersion20092010 (char * l_pPath,
                              char * l_pMediaCONFIG_INFVersion,
                              char * l_pMediaCONFIG_INFVersion2009,
                              char * l_pMediaCONFIG_INFVersion2010);
void   BuildUpgradePrep (int p_iRenesasVers,
                         char* p_path,
                         char* p_config_vers2009,
                         char* p_config_vers2010);
/****************************** MAIN ******************************/
//  argv[0] = Script Name (/bd0/.....CMD)
//  argv[1] = p_Drive     (/bd0,...)
//  argv[2] = p_pUpgType  (NORMAL / BOOTROM)
int main(int argc, char **argv)
{
  // Local variables for general purpose
  STATUS l_script_status = OK;
  STATUS l_set_calibration_status = ERROR;
  STATUS l_get_calibration_status = ERROR;
  char l_pSourceDrive[MAX_DRIVE_NAME_LENGTH];
  char l_pTargetDrive[MAX_DRIVE_NAME_LENGTH];
  char l_pSourceVersion[MAX_VERSION_LENGTH];
  char l_pTargetVersion[MAX_VERSION_LENGTH];
  char l_pDBBootMOT_Version[MAX_VERSION_LENGTH];

  int  l_i=0;
  double  l_CountFilesToBeCopied = 0;
  double  l_CountFilesCopied = 0;
  char l_pPath[MAX_PATH_LENGTH];
  char l_pSourcePath[MAX_PATH_LENGTH];
  char l_pTargetPath[MAX_PATH_LENGTH];
  char l_pCDVersion[MAX_VERSION_LENGTH];
  char l_pOldCDVersion[MAX_VERSION_LENGTH];
  char l_pConfigSystemVersion[MAX_VERSION_LENGTH];
  char l_pOldConfigSystemVersion[MAX_VERSION_LENGTH];
  char l_pQuestionText[MAX_QUESTION_LENGTH];
  int  l_iIsUpgRequired = FALSE;
  char l_pDummyPath[MAX_PATH_LENGTH];

  char l_pDateClock[MAX_DATE_CLOCK_LENGTH];

    // Software upgrade variables
  unsigned long l_lTotalSize = 0;
  unsigned long l_lCompletedSize = 0;
  char l_pString[MAX_PATH_LENGTH];
  DIR* l_pDir;
  t_SoftUpgData l_pSoftList[MAX_APPLI_FILES];
  t_SoftUpgData l_pTffsList[MAX_APPLI_FILES];
  int   l_iNbSearchParams = 0;
  char* l_pSearchParams[2];
  char  l_pSearchParam1[MAX_PATH_LENGTH];
  char  l_pSearchParam2[MAX_PATH_LENGTH];
  BOOL  l_enable_recovery = FALSE;
  BOOL  l_get_calibration_value = FALSE;
  char  l_tempString[MAX_STRING_LENGTH];

//For Cross upgrade needs
  char l_pCDConfigSystemVersion[MAX_VERSION_LENGTH];
  char l_pCDConfigSystemVersion2009[MAX_VERSION_LENGTH];
  char l_pCDConfigSystemVersion2010[MAX_VERSION_LENGTH];
  int  l_iMBid, l_iDBid, l_iFPid;
  int  l_iRenesasVersion=2010;
  int  l_iBootRom_Type=1;


  // External upgrade variables
  int l_iFromAppli = FALSE;
  char l_pVersion[MAX_VERSION_LENGTH];
  int l_FpInLoader = FALSE;

  // Bootrom upgrade variable
  int l_iFd = 0;
  MODULE_ID l_pModuleId = NULL;
  FUNCPTR l_pFuncPtr =NULL;

  // Spy file
  FILE *l_pSpyFile = NULL;

  l_pSearchParams[0] = l_pSearchParam1;
  l_pSearchParams[1] = l_pSearchParam2;

  /*** SCRIPT INITIALIZATION ***/

  SetUpgradeLogging (TRUE);
  EnableHistoryHandler (TRUE);

  UPGLogMsg ("*************************************************************\n",
             0,0,0,0,0,0);
  UPGLogMsg ("Script initialization +, Time = %ld\n",tickGet(),0,0,0,0,0);

  strcpy(l_pSourceDrive,argv[1]);
  UPGLogMsg ("Upgrade type is BOOTROM\n", 0, 0, 0, 0, 0, 0);

  //Get current target drive
  strcpy(l_pTargetDrive, DRIVE_HDD);

  UPGLogMsg ("Source drive is %s\n", l_pSourceDrive, 0, 0, 0, 0, 0);
  UPGLogMsg ("Target drive is %s\n", l_pTargetDrive, 0, 0, 0, 0, 0);

  //Get the last used upgrade CD number
  if (ERROR == GetConfigSystemVersion((unsigned char*)l_pOldConfigSystemVersion))
  {
    UPGLogMsg ("ERROR: GetConfigSystemVersion error\n", 0, 0, 0, 0, 0, 0);
  }

  UPGLogMsg ("Script initialization -, Time = %ld\n", tickGet(), 0, 0, 0, 0, 0);


  /*** MEDIA CHECK ***/
  if ( OK == l_script_status )
  {
    // Get CD Version
    strcpy (l_pPath, l_pSourceDrive);
    strcat (l_pPath, "/CD");

    if (ERROR == GetFileVersion (l_pPath, l_pCDVersion))
    {
      UPGLogMsg ("GetFileVersion error on %s\n", l_pPath, 0, 0, 0, 0, 0);
      l_script_status = ERROR;
      SetUpgradeLogging (PAUSE);
      EndUpgrade (l_pSourceDrive);
      return (l_script_status);
    }
    else
    {
      UPGLogMsg ("CD version is %s\n", l_pCDVersion, 0, 0, 0, 0, 0);
      AddUPGHistoryHeader (l_pCDVersion, l_pSourceDrive, "BOOTROM");
    }

    // Get CD Software Version
    strcpy (l_pPath,l_pSourceDrive);
    strcat (l_pPath,"/Config");

    if (ERROR == GetFileVersion (l_pPath, l_pConfigSystemVersion))
    {
      strcpy (l_tempString, "GetFileVersion error on ");
      strcat (l_tempString, l_pPath);
      AddUPGHistoryCommentary (l_tempString);
      UPGLogMsg ("%s\n", l_tempString, 0, 0, 0, 0, 0);
      l_script_status = ERROR;
      EndUpgrade (l_pSourceDrive);
      return (l_script_status);
    }
    else
    {
      UPGLogMsg ("CD Software version is '%s'\n", l_pConfigSystemVersion, 0, 0, 0, 0, 0);
    }
  }

  /*** CHECK PROTO TYPE ***/
  if (OK == l_script_status)
  {
    UPGLogMsg ( "main : call of FPComRenesasGetAllId \n", 0, 0, 0, 0, 0, 0 );
    l_script_status = FPComRenesasGetAllId (&l_iMBid, &l_iDBid, &l_iFPid);

//#define UPG_FP_ID_2010            (0xFF)
    if (255 == l_iFPid)
    {
      l_iRenesasVersion = UPG_RNEG_2010_TYPE; //2010;
    }
    else
    {
      l_iRenesasVersion = UPG_DEFAULT_RNEG_TYPE;  //2009;
    }

    l_iBootRom_Type = l_iDBid;
  }

  /*** PREPARE UPGRADE ***/
  UPGLogMsg ("****** Prepare upgrade +, Time = %ld ******\n", tickGet(), 0, 0, 0, 0, 0);

  PrintClearScreen();
  PrintTextL3 ("Keep engine running and do not remove media...");
  PrintTextL1 ("Upgrade preparation...");

  if (OK == l_script_status)
  {
    //Destroy and rebuild TFFS to avoid copy failure (fragmentation)
    UPGLogMsg ( "Deep format TFFS...\n",0,0,0,0,0,0 );
    if (ERROR == FormatTffs ())
    {
      strcpy (l_tempString, "Format TFFS: FAILED");
      AddUPGHistoryCommentary (l_tempString);
      UPGLogMsg ("%s\n", l_tempString, 0, 0, 0, 0, 0);
      l_script_status = ERROR;
    }
    else
    {
      UPGLogMsg ( "Format TFFS: OK\n",0,0,0,0,0,0 );
      UPGLogMsg ( "Mount and check TFFS\n",0,0,0,0,0,0 );
      if ( ERROR == MountCheckTffs())
      {
        AddUPGHistoryCommentary ("MountCheckTffs KO");
        UPGLogMsg ( "Mount and check KO\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      else
      {
        UPGLogMsg ( "Mount and check TFFS OK \n",0,0,0,0,0,0 );
      }
    }
  }

  // Check and repair each SD partition...
  if (OK == l_script_status)
  {
    CheckAndUnlockSD ();
    l_script_status = CheckAndRepairSDs ();
  }

  // SOFTWARE
  if ( OK == l_script_status )
  {
    if ( FORCE_SOFTWARE_UPGRADE == 1 )
    {
      xdelete("/SDC");
      xdelete("/SDI");
    }

    //check and add SIRF directory
    CheckAndCopySIRFdirIfExist(l_pSourceDrive);

    // Get CD Software Version
    strcpy ( l_pPath, l_pSourceDrive );
    strcat ( l_pPath, "/Config" );

    if ( ERROR == GetFileConfigVersion20092010 (l_pPath,
                                                l_pCDConfigSystemVersion,
                                                l_pCDConfigSystemVersion2009,
                                                l_pCDConfigSystemVersion2010) )
    {
      logMsg ( "GetFileConfigVersion20092010 error on %s\n", l_pPath, 0, 0, 0, 0, 0 );
      l_script_status = ERROR;
    }
    else
    {
      logMsg ( "CD Software version is %s\n", l_pConfigSystemVersion, 0, 0, 0, 0, 0 );
    }

    if ( OK == l_script_status )
    {
      StepBargraph( "CRC", 0 );

      // Normal application
      strcpy ( l_pSearchParams[0], "" );
      strcpy ( l_pSearchParams[1], "" );
      l_iNbSearchParams = 0;

      PrintTextL1 ("Upgrade preparation (BCMs)...");
      if ( ERROR == PrepareSoftUpg(l_pSoftList,l_pSourceDrive,
        "/Application/BCM","*.*",l_pTargetDrive,l_pSearchParams,l_iNbSearchParams,TRUE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      PrintTextL1 ("Upgrade preparation (ENGs)...");
      if ( ERROR == PrepareSoftUpg(l_pSoftList,l_pSourceDrive,
        "/Application/ENG","*.*",l_pTargetDrive,l_pSearchParams,l_iNbSearchParams,TRUE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      PrintTextL1 ("Upgrade preparation (MGRs)...");
      if ( ERROR == PrepareSoftUpg(l_pSoftList,l_pSourceDrive,
        "/Application/MGR","*.*",l_pTargetDrive,l_pSearchParams,l_iNbSearchParams,TRUE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      PrintTextL1 ("Upgrade preparation (MMIs)...");
      if ( ERROR == PrepareSoftUpg(l_pSoftList,l_pSourceDrive,
        "/Application/MMI","*.*",l_pTargetDrive,l_pSearchParams,l_iNbSearchParams,TRUE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      PrintTextL1 ("Upgrade preparation (TTS)...");
      if ( ERROR == PrepareSoftUpg(l_pSoftList,l_pSourceDrive,
        "/Application/TTS","*.*",l_pTargetDrive,l_pSearchParams,l_iNbSearchParams,TRUE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      PrintTextL1 ("Upgrade preparation (ASR)...");
      if ( ERROR == PrepareSoftUpg(l_pSoftList,l_pSourceDrive,
        "/Data_Base/ASR","*.*",l_pTargetDrive,l_pSearchParams,l_iNbSearchParams,TRUE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      PrintTextL1 ("Upgrade preparation (PTT)...");
      if ( ERROR == PrepareSoftUpg(l_pSoftList,l_pSourceDrive,
        "/Data_Base/PTT","*.*",l_pTargetDrive,l_pSearchParams,l_iNbSearchParams,TRUE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      PrintTextL1 ("Upgrade preparation (SND)...");
      if ( ERROR == PrepareSoftUpg(l_pSoftList,l_pSourceDrive,
        "/Data_Base/SND","*.*",l_pTargetDrive,l_pSearchParams,l_iNbSearchParams,TRUE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      PrintTextL1 ("Upgrade preparation (TTS)...");
      if ( ERROR == PrepareSoftUpg(l_pSoftList,l_pSourceDrive,
        "/Data_Base/TTS","*.*",l_pTargetDrive,l_pSearchParams,l_iNbSearchParams,TRUE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }

      PrintTextL1 ("Upgrade preparation (DAB)...");
      strcpy (l_pDummyPath, "/Application/BlackFin/DAB/");
      strcat (l_pDummyPath, l_pConfigSystemVersion);
      strcat (l_pDummyPath, "/");
      if ( ERROR == PrepareSoftUpg_AbsolutePath (l_pSoftList,l_pSourceDrive,
        l_pDummyPath,"*.*",l_pTargetDrive,DAB_DIR,l_pSearchParams,l_iNbSearchParams,TRUE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg_AbsolutePath ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      PrintTextL1 ("Upgrade preparation (Graphics)...");

      BuildUpgradePrep (l_iRenesasVersion,
                        l_pDummyPath,
                        l_pCDConfigSystemVersion2009,
                        l_pCDConfigSystemVersion2010);

      strcpy (l_pDummyPath, "/Data_Base/Graphics/Logo/");
      strcat (l_pDummyPath, l_pConfigSystemVersion);
      strcat (l_pDummyPath, "/");

      if ( ERROR == PrepareSoftUpg_AbsolutePath (l_pSoftList,l_pSourceDrive,
        l_pDummyPath,"*.*",l_pTargetDrive,DATA_BASE_LOGO_DIR,l_pSearchParams,l_iNbSearchParams,TRUE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg_AbsolutePath ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      if ( ERROR == PrepareSoftUpg(l_pSoftList,l_pSourceDrive,
        "/Data_Base/Graphics/AVR_IMG/","*.*",l_pTargetDrive,l_pSearchParams,l_iNbSearchParams,TRUE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      if ( ERROR == PrepareSoftUpg(l_pSoftList,l_pSourceDrive,
        "/Data_Base/Graphics/RNEG/","*.*",l_pTargetDrive,l_pSearchParams,l_iNbSearchParams,TRUE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      if ( ERROR == PrepareSoftUpg(l_pSoftList,l_pSourceDrive,
        "/Data_Base/Graphics/","*.xml",l_pTargetDrive,l_pSearchParams,l_iNbSearchParams,FALSE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      if ( ERROR == PrepareSoftUpg(l_pSoftList,l_pSourceDrive,
        "/Data_Base/Graphics/","*.gz",l_pTargetDrive,l_pSearchParams,l_iNbSearchParams,TRUE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      PrintTextL1 ("Upgrade preparation (ACL)...");
      if ( ERROR == PrepareSoftUpg(l_pTffsList,l_pSourceDrive,
        "/Application/ACL","*.*",DRIVE_TFFS,l_pSearchParams,l_iNbSearchParams,FALSE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      // Duplicate the content of flash drive on BACKUP_DIR
      if ( ERROR == PrepareSoftUpg(l_pSoftList,l_pSourceDrive,
        "/Application/ACL","*.*",BACKUP_DIR,l_pSearchParams,l_iNbSearchParams,TRUE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      PrintTextL1 ("Upgrade preparation (Boot)...");
      if ( ERROR == PrepareSoftUpg(l_pTffsList,l_pSourceDrive,
        "/Application/Boot","ssm_boot.out",DRIVE_TFFS,l_pSearchParams,l_iNbSearchParams,FALSE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      // Duplicate the content of flash drive on BACKUP_DIR
      if ( ERROR == PrepareSoftUpg(l_pSoftList,l_pSourceDrive,
        "/Application/Boot","ssm_boot.out",BACKUP_DIR,l_pSearchParams,l_iNbSearchParams,TRUE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      PrintTextL1 ("Upgrade preparation (BTL)...");
      if ( ERROR == PrepareSoftUpg(l_pTffsList,l_pSourceDrive,
        "/Application/BTL","*.*",DRIVE_TFFS,l_pSearchParams,l_iNbSearchParams,FALSE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      // Duplicate the content of flash drive on BACKUP_DIR
      if ( ERROR == PrepareSoftUpg(l_pSoftList,l_pSourceDrive,
        "/Application/BTL","*.*",BACKUP_DIR,l_pSearchParams,l_iNbSearchParams,TRUE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      PrintTextL1 ("Upgrade preparation (SSM)...");
      if ( ERROR == PrepareSoftUpg(l_pTffsList,l_pSourceDrive,
        "/Application/SSM","*.*",DRIVE_TFFS,l_pSearchParams,l_iNbSearchParams,FALSE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      // Duplicate the content of flash drive on BACKUP_DIR
      if ( ERROR == PrepareSoftUpg(l_pSoftList,l_pSourceDrive,
        "/Application/SSM","*.*",BACKUP_DIR,l_pSearchParams,l_iNbSearchParams,TRUE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      PrintTextL1 ("Upgrade preparation (CONFIGSYSTEM)...");
      if ( ERROR == PrepareSoftUpg(l_pTffsList,l_pSourceDrive,
        "/Data_Base/CONFIGSYSTEM","*.*",DRIVE_TFFS,l_pSearchParams,l_iNbSearchParams,FALSE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }
      // Duplicate the content of flash drive on BACKUP_DIR
      if ( ERROR == PrepareSoftUpg(l_pSoftList,l_pSourceDrive,
        "/Data_Base/CONFIGSYSTEM","*.*",BACKUP_DIR,l_pSearchParams,l_iNbSearchParams,TRUE,&l_lTotalSize) )
      {
        UPGLogMsg ( "PrepareSoftUpg ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }

      //Prepare DB DOWNLOAD install
      if ( OK == l_script_status )
      {
        PrintTextL1 ("Upgrade preparation (db_dwnl_ppc)...");
        UPGLogMsg ( "PrepareDbDwnlUpg\n",0,0,0,0,0,0 );
        if ( ERROR == PrepareDbDwnlUpg(l_pSoftList, l_pSourceDrive, "/db_dwnl_ppc", &l_lTotalSize) )
        {
          UPGLogMsg ( "PrepareDbDwnlUpg ERROR\n",0,0,0,0,0,0 );
          l_script_status = ERROR;
        }
      }

      StepBargraph( "CRC", 100 );
    }

    UPGLogMsg ( "Total file size to install %ld bytes\n",l_lTotalSize,0,0,0,0,0 );
  }
    UPGLogMsg ( "****** Prepare upgrade -, Time = %ld ******\n",tickGet(),0,0,0,0,0 );

  /*** SOFTWARE UPGRADE ***/

  // Counting all files to copy
  l_CountFilesToBeCopied = 0;
  for ( l_i=0; 0 != l_pSoftList[l_i].m_iSize; l_i++ )
  {
    l_CountFilesToBeCopied ++;
  }
  for ( l_i=0; 0 != l_pTffsList[l_i].m_iSize; l_i++ )
  {
    l_CountFilesToBeCopied ++;
  }
  l_CountFilesCopied = 0;

  UPGLogMsg ( "****** Software upgrade +, Time = %ld ******\n",tickGet(),0,0,0,0,0 );
  if ( OK == l_script_status )
  {
    // Install soft on /SDC
    if ( ERROR == InstallSoftList ( l_pSoftList, l_lTotalSize, BOOTROM,
                                    &l_lCompletedSize, l_enable_recovery,
                                    &l_CountFilesCopied, l_CountFilesToBeCopied) )
    {
      AddUPGHistoryCommentary ("Install l_pSoftList error");
      UPGLogMsg ( "Install l_pSoftList error\n",0,0,0,0,0,0 );
      l_script_status = ERROR;
    }
  }

  // Prepare recovery
  if ((ENABLE_RECOVERY == 1) && (OK == l_script_status))
  {
    // Clean old list file or create directory if do not exist
    UPGLogMsg ( "Prepare recovery\n",0,0,0,0,0,0 );
    strcpy(l_pString,l_pTargetDrive);
    strcat(l_pString,"/UPG");
    if ( NULL == ( l_pDir = opendir(l_pString)) )
    {
      UPGMKDir(l_pString);
      strcat(l_pString,RECOVERY_FILE);
    }
    else
    {
      closedir(l_pDir);
      strcat(l_pString,RECOVERY_FILE);
      xdelete(l_pString);
    }

    // Saves lists
    if ( ERROR == SaveSoftUpgList(l_pSoftList, l_pString) )
    {
      AddUPGHistoryCommentary ("SaveSoftUpgList error");
      UPGLogMsg ( "SaveSoftUpgList error\n",0,0,0,0,0,0 );
      l_script_status = ERROR;
    }
    // Set OK Flag in list file
    else if ( ERROR == SetOKInListFile(l_pString) )
    {
      AddUPGHistoryCommentary ("SetOKInListFile error");
      UPGLogMsg ( "SetOKInListFile error\n",0,0,0,0,0,0 );
      l_script_status = ERROR;
    }
    else
    {
    // !!! FAIL SAFE POINT !!! !!! FAIL SAFE POINT !!! !!! FAIL SAFE POINT !!!
      UPGLogMsg ( "------ REACHED FAIL SAFE POINT ------\n",0,0,0,0,0,0 );

      // Restart RT3EV in bootrom upg for recovery
      if ( ERROR == SetBootromUpgFlag(TRUE) )
      {
        AddUPGHistoryCommentary ("SetBootromUpgFlag ERROR");
        UPGLogMsg ( "SetBootromUpgFlag ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }

      // Validate changes (rename files)
      else if ( ERROR == ValidateSoftChanges(l_pSoftList) )
      {
        AddUPGHistoryCommentary ("ValidateSoftChanges ERROR");
        UPGLogMsg ( "ValidateSoftChanges ERROR\n",0,0,0,0,0,0 );
        l_script_status = ERROR;
      }

      if ( OK == l_script_status )
      {
        // Remove list file
        xdelete(l_pString);

        // Remove old files
        if ( ERROR == CleanRecoveryFiles(l_pSoftList) )
        {
          AddUPGHistoryCommentary ("CleanRecoveryFiles ERROR");
          UPGLogMsg("CleanRecoveryFiles ERROR\n",0,0,0,0,0,0);
          l_script_status = ERROR;
        }
      }
    }
  }

  if ( OK == l_script_status )
  {
    UPGLogMsg ( "****** Install Install Ecall on flash ****** \n",0,0,0,0,0,0 );
    // Install Ecall on flash
    if ( ERROR == InstallSoftList ( l_pTffsList, l_lTotalSize, BOOTROM,
                                    &l_lCompletedSize, FALSE,
                                    &l_CountFilesCopied, l_CountFilesToBeCopied) )
    {
      AddUPGHistoryCommentary ("Install l_pTffsList ERROR");
      UPGLogMsg ( "Install l_pTffsList ERROR\n",0,0,0,0,0,0 );
      l_script_status = ERROR;
    }

    if (OK == l_script_status)
    {
      UPGLogMsg ( "****** Backup BootRom ****** \n",0,0,0,0,0,0 );
      // Backup BootRom
      strcpy (l_tempString, l_pSourceDrive);
      strcat (l_tempString, "/Application/Boot/");
      strcat (l_tempString, l_pConfigSystemVersion);

      if (1 == l_iBootRom_Type)
      {
        //strcat (l_tempString, "/DG4_Before/");
        strcat (l_tempString, "/DG4/");
      }
      else if (2 == l_iBootRom_Type)
      {
        strcat (l_tempString, "/DG4/");
      }
      else
      {
        strcat (l_tempString, "/DG4/");
      }

      //strcat (l_tempString, "/DG4/");
      l_script_status = BackUpBR (l_tempString);
    }

    if (OK == l_script_status)
    {
      UPGLogMsg ( "****** Backup Renesas code ****** \n",0,0,0,0,0,0 );
      // Backup Renesas code
      strcpy (l_tempString, l_pSourceDrive);
      strcat (l_tempString, "/Application/FP/");

      if (UPG_DEFAULT_RNEG_TYPE == l_iRenesasVersion)
      {
        strcat (l_tempString, l_pCDConfigSystemVersion2009);
      }
      else
      {
        strcat (l_tempString, l_pCDConfigSystemVersion2010);
      }

      strcat (l_tempString, "/");
      l_script_status = BackUpRenesas (l_tempString);
    }

    UPGLogMsg ( "****** RemoveUnwantedFiles ****** \n",0,0,0,0,0,0 );
    RemoveUnwantedFiles (l_pSourceDrive);
    UPGLogMsg ( "****** RemoveUnwantedFiles ****** \n",0,0,0,0,0,0 );
    RemoveUnwantedDirectories (l_pSourceDrive);
  }

  UPGLogMsg ( "****** Software upgrade -, Time = %ld ******\n",tickGet(),0,0,0,0,0 );

  /*** TERMINATION ***/
  GetCDVersion (l_pOldCDVersion);

  if(OK == l_script_status)
  {
    if (OK == GetDBBootFPModuleVersionString (l_pDBBootMOT_Version))
    {
      strcpy (l_tempString, "FP Version : ");
      strcat (l_tempString, l_pDBBootMOT_Version);
      AddUPGHistoryCommentary (l_tempString);
      UPGLogMsg ("%s\n", l_tempString, 0, 0, 0, 0, 0);
    }
    else
    {
      l_script_status = ERROR;
      AddUPGHistoryCommentary ("Unable to read FP Version !!!");
    }

    // Set CD version on DBBoot
    strcpy (l_tempString, "SWITCHING FROM CD Version ");
    strcat (l_tempString, l_pOldCDVersion);
    strcat (l_tempString, " TO ");
    strcat (l_tempString, l_pCDVersion);
    AddUPGHistoryCommentary (l_tempString);
    UPGLogMsg ("%s\n", l_tempString, 0, 0, 0, 0, 0);
    SetCDVersion(l_pCDVersion);

    // Set Software version on DBBoot
    strcpy (l_tempString, "SWITCHING Software Version FROM ");
    strcat (l_tempString, l_pOldConfigSystemVersion);
    strcat (l_tempString, " TO ");

    if (UPG_DEFAULT_RNEG_TYPE == l_iRenesasVersion)
    {
      //l_pConfigSystemVersion = l_pCDConfigSystemVersion2009;
      strcat (l_tempString, l_pCDConfigSystemVersion2009);
    }
    else if (UPG_RNEG_2010_TYPE == l_iRenesasVersion)
    {
      //l_pConfigSystemVersion = l_pCDConfigSystemVersion2010;
      strcat (l_tempString, l_pCDConfigSystemVersion2010);
    }
    else
    {
      //l_pConfigSystemVersion = l_pCDConfigSystemVersion2009;
      strcat (l_tempString, l_pCDConfigSystemVersion2009);
    }

    //strcat (l_tempString, l_pConfigSystemVersion);
    AddUPGHistoryCommentary (l_tempString);

    if (ERROR == GetConfigSystemVersion((unsigned char*)l_pOldConfigSystemVersion))
    {
      UPGLogMsg ("ERROR: GetConfigSystemVersion error\n", 0, 0, 0, 0, 0, 0);
    }

    //EVO7314 - OPT_SW_MERCO update
    if ((0 == strcmp (l_pOldConfigSystemVersion, "RNEG2010_MERC_2_10")) ||
        (0 == strcmp (l_pOldConfigSystemVersion, "RNEG2009_MERCOSUR"))  ||
        (0 == strcmp (l_pOldConfigSystemVersion, "RNEG2009_MERCO")))
    {
      CheckSetSwOptMerco();
    }

    //Manage F300 calibration
    if( (0 == strcmp ( l_pOldConfigSystemVersion, "RNEG2010_EUROPE" ))     ||
        (0 == strcmp ( l_pOldConfigSystemVersion, "RNEG2010_EUROPE_2_1" )) ||
        (0 == strcmp ( l_pOldConfigSystemVersion, "RNEG2010_EUR_2_20" ))   ||
        (0 == strcmp ( l_pOldConfigSystemVersion, "RNEG2009_EUR_2_60" ))   ||
        (0 == strcmp ( l_pOldConfigSystemVersion, "RNEG2010_MERC_2_10" ))  ||
        (0 == strcmp ( l_pOldConfigSystemVersion, "RNEG2009_MERCOSUR" ))   ||
        (0 == strcmp ( l_pOldConfigSystemVersion, "RNEG2009_MERCO" ))
      )
    {
      l_set_calibration_status = FPComRenesasSetCalibrationStatusToTrue();
      if(OK == l_set_calibration_status)
      {
        l_get_calibration_status = FPComRenesasGetCalibrationStatus(&l_get_calibration_value);
        if (FALSE == l_get_calibration_value)
        {
          l_set_calibration_status = FPComRenesasSetCalibrationStatusToTrue();
          strcpy (l_tempString, "FPComRenesasGetCalibrationStatus returns FALSE");
          AddUPGHistoryCommentary (l_tempString);
        }
        else
        {
          strcpy (l_tempString, "FPComRenesasGetCalibrationStatus returns TRUE");
          AddUPGHistoryCommentary (l_tempString);
        }
      }
      else
      {
        l_set_calibration_status = FPComRenesasSetCalibrationStatusToTrue();
        l_get_calibration_status = FPComRenesasGetCalibrationStatus(&l_get_calibration_value);
        if (TRUE != l_get_calibration_value)
        {
          strcpy (l_tempString, "Second FPComRenesasGetCalibrationStatus returns FALSE");
          AddUPGHistoryCommentary (l_tempString);
          l_set_calibration_status = FPComRenesasSetCalibrationStatusToTrue();
        }
        else
        {
          strcpy (l_tempString, "Second FPComRenesasGetCalibrationStatus returns TRUE");
          AddUPGHistoryCommentary (l_tempString);
        }
      }
    }

    if (UPG_RNEG_2010_TYPE == l_iRenesasVersion)
    {
      //l_pConfigSystemVersion = l_pCDConfigSystemVersion2010;
      SetConfigSystemVersion((const unsigned char*)l_pCDConfigSystemVersion2010);
    }
    else
    {
      //l_pConfigSystemVersion = l_pCDConfigSystemVersion2009;
      SetConfigSystemVersion((const unsigned char*)l_pCDConfigSystemVersion2009);
    }

    UPGLogMsg("RemoveTurboBootInfo \n",0,0,0,0,0,0);
    if (OK == Remove_Turbo_Boot_Info())
    {
      UPGLogMsg("RemoveTurboBootInfo done\n",0,0,0,0,0,0);
    }
    else
    {
      UPGLogMsg("RemoveTurboBootInfo return ERROR !!!!\n",0,0,0,0,0,0);
    }

    // In all case, verification of the presence of TurboBoot
    if (TRUE == FileExists (TURBOBOOT_ENTRY_FILE))
    {
      UPGLogMsg("xdelete of TurboBoot\n",0,0,0,0,0,0);
      xdelete (TURBOBOOT_DIRECTORY);
      if (TRUE == FileExists (TURBOBOOT_ENTRY_FILE))
      {
        UPGLogMsg("TurboBoot already present after remove... definitive ERROR !\n",0,0,0,0,0,0);
        l_script_status = ERROR;
      }
    }
    else
    {
      UPGLogMsg("TurboBoot successfully removed by RemoveTurboBootInfo function.\n",0,0,0,0,0,0);
    }

    if (OK == CleanPartitionsStatus ())
    {
      UPGLogMsg("Partitions status cleaned !\n",0,0,0,0,0,0);
    }
    else
    {
      UPGLogMsg("Error while CleanPartitionsStatus !\n",0,0,0,0,0,0);
    }
  }


  if (OK == l_script_status)
  {
    SetBootromUpgFlag (FALSE);
    SetUpgradeLogging (FALSE);
    AddUPGHistoryCommentary ("-> UPGRADE COMPLETE !");
    UPGLogMsg("-> UPGRADE COMPLETE !\n",0,0,0,0,0,0);
  }
  else
  {
    // Stop logging
    SetUpgradeLogging (PAUSE);
    AddUPGHistoryCommentary ("-> UPGRADE ENDED WITH ERROR !");
    UPGLogMsg ("SCRIPT ERROR!\n", 0, 0, 0, 0, 0, 0);
  }

  EnableHistoryHandler (FALSE);
  EndUpgrade( l_pSourceDrive );

  return ( l_script_status );
}


/********************** INTERN FUNCTION DEFINITION **********************/

STATUS BackUpBR (char *pPath)
{
  char    l_TempPathBootRomOrg[MAX_PATH_LENGTH];
  char    l_TempPathBootRomDest[MAX_PATH_LENGTH];
  STATUS  l_Ret = OK;

  // BOOTROM.DAT in BACKUP_BR
  strcpy (l_TempPathBootRomOrg, pPath);
  strcat (l_TempPathBootRomOrg, BOOTROM_DAT_FILE);

  strcpy (l_TempPathBootRomDest, BACKUP_BR_DIR);
  strcat (l_TempPathBootRomDest, BOOTROM_DAT_FILE);
  l_Ret = UPGCopy (l_TempPathBootRomOrg, l_TempPathBootRomDest,FALSE);

  if (OK == l_Ret)
  {
    // BOOTROM.DAT.inf in BACKUP_BR
    strcpy (l_TempPathBootRomOrg, pPath);
    strcat (l_TempPathBootRomOrg, BOOTROM_DAT_FILE_INF);

    strcpy (l_TempPathBootRomDest, BACKUP_BR_DIR);
    strcat (l_TempPathBootRomDest, BOOTROM_DAT_FILE_INF);
    l_Ret = UPGCopy (l_TempPathBootRomOrg, l_TempPathBootRomDest,FALSE);
  }

  return (l_Ret);
}

STATUS BackUpRenesas (char *pPath)
{
  char    l_TempPathBootRomOrg[MAX_PATH_LENGTH];
  char    l_TempPathBootRomDest[MAX_PATH_LENGTH];
  STATUS  l_Ret = OK;

  // FPComRNEG.mot in BACKUP_RENESAS
  strcpy (l_TempPathBootRomOrg, pPath);
  strcat (l_TempPathBootRomOrg, RENESAS_MOT_FILE);

  strcpy (l_TempPathBootRomDest, BACKUP_RENESAS_DIR);
  strcat (l_TempPathBootRomDest, RENESAS_MOT_FILE);
  l_Ret = UPGCopy (l_TempPathBootRomOrg, l_TempPathBootRomDest,FALSE);

  if (OK == l_Ret)
  {
    // FPComRNEG.mot.inf in BACKUP_RENESAS
    strcpy (l_TempPathBootRomOrg, pPath);
    strcat (l_TempPathBootRomOrg, RENESAS_MOT_FILE_INF);

    strcpy (l_TempPathBootRomDest, BACKUP_RENESAS_DIR);
    strcat (l_TempPathBootRomDest, RENESAS_MOT_FILE_INF);
    l_Ret = UPGCopy (l_TempPathBootRomOrg, l_TempPathBootRomDest,FALSE);
  }

  return (l_Ret);
}

STATUS EndUpgrade(char *p_SourceDrive)
{
  char l_pPath[MAX_PATH_LENGTH];
  STATUS l_status = OK;

  // Clean temp directory
  UPGLogMsg(" Clean temp directory\n",0,0,0,0,0,0);
  strcpy ( l_pPath, DRIVE_HDD );
  strcat ( l_pPath, TEMP_UPGRADE_DIR );
  xdelete ( l_pPath );
  UPGMKDelete( l_pPath );

  return ( l_status );
}

STATUS PrepareSoftUpg_AbsolutePath (t_SoftUpgData *p_pList,
                                    char *p_pSourceDrive,
                                    char *p_pRootDir,
                                    char *p_pMask,
                                    char *p_pTargetDrive,
                                    char *p_pTargetPath,
                                    char *p_pSearchParams[],
                                    int   p_iNbSearchParams,
                                    int   p_pCheckVersion,
                                    unsigned long *p_pTotalSize
                                   )
{
  STATUS l_status = OK;

  int  l_bIsNew = FALSE;
  int  l_i;
  int  l_iCountInserted;
  BOOL l_bUpgRequired;

  char  l_pSearchRootDir[MAX_PATH_LENGTH];
  char  l_pTargetDir[MAX_PATH_LENGTH];
  char  l_pSearchResult[MAX_PATH_LENGTH];
  int   l_iNumSearchResult = 0;
  char  l_pTablePath[MAX_PATH_LENGTH];

  char l_pTargetPath[MAX_PATH_LENGTH];
  char l_pSourceVersion[MAX_VERSION_LENGTH];
  char l_pTargetVersion[MAX_VERSION_LENGTH];
  char l_pSourceCRC[MAX_CRC_LENGTH];
  char l_pTargetCRC[MAX_CRC_LENGTH];
  int  l_iSize;
  char l_pInfPath[MAX_PATH_LENGTH];
  char l_tempString[MAX_STRING_LENGTH];

  static long l_total_size_examined = 0;
  int l_percentage = 0;

  UPGLogMsg("PrepareUPGSoft +, Time = %ld\n",tickGet(),0,0,0,0,0);

  // Set counter of files inserted in list
  for(l_iCountInserted=0; (p_pList[l_iCountInserted].m_iSize) && (l_iCountInserted<MAX_APPLI_FILES); l_iCountInserted++);

  if ( MAX_APPLI_FILES == l_iCountInserted )
  {
    UPGLogMsg ( "FATAL ERROR: Too many files in list\n",0,0,0,0,0,0 );
    return(ERROR);
  }

  // Search all soft files on source drive
  strcpy ( l_pTablePath, p_pSourceDrive );
  strcat ( l_pTablePath, FSEARCH_TABLE_FILE );

  strcpy ( l_pSearchRootDir, p_pSourceDrive );
  strcat ( l_pSearchRootDir, p_pRootDir );

  strcpy ( l_pTargetDir, p_pTargetDrive );
  strcat ( l_pTargetDir, p_pTargetPath );

  UPGLogMsg ( "PrepareUPGSoft p_pSourceDrive='%s'\n",p_pSourceDrive,0,0,0,0,0 );

  l_iNumSearchResult = SearchAndTargetFileExclu ( p_pMask,
                                                  l_pTablePath,
                                                  p_pSearchParams,
                                                  p_iNbSearchParams,
                                                  l_pSearchRootDir,
                                                  l_pTargetDir );

  if ( 0 == l_iNumSearchResult )
  {
    UPGLogMsg ( "WARNING : %s 0 occurences found on %s\n",p_pMask,l_pSearchRootDir,0,0,0,0 );
  }

  // Process search result
  for (l_i=0; (l_i<l_iNumSearchResult) && (OK==l_status); l_i++)
  {
    l_bUpgRequired = FALSE;
    l_bIsNew = FALSE;
    l_pSourceVersion[0]='\0';

    if ( ERROR == GetSearchResult ( l_i , l_pSearchResult, l_pTargetPath ) )
    {
      AddUPGHistoryCommentary ("GetSearchResult ERROR");
      UPGLogMsg ( "GetSearchResult ERROR\n",0,0,0,0,0,0 );
      l_status = ERROR;
    }
    else
    {
      if ( strlen(l_pSearchResult) && (NULL == strstr(l_pSearchResult, ".inf" )) )
      {
        if ( FALSE == p_pCheckVersion )
        {
          if ( FALSE == FileExists(l_pTargetPath) )
          {
            l_bIsNew = TRUE;
          }
          l_bUpgRequired = TRUE;
          UPGLogMsg ( "<%s> will be installed (NO VERSION CHECK)\n",l_pTargetPath,0,0,0,0,0 );
        }
        else if ( ERROR == GetFileVersion( l_pSearchResult, l_pSourceVersion ) )
        {
          if ( FALSE == FileExists(l_pTargetPath) )
          {
            l_bIsNew = TRUE;
          }
          l_bUpgRequired = TRUE;
          UPGLogMsg ( "<%s> will be installed (NO VERSION CHECK)\n",l_pTargetPath,0,0,0,0,0 );
        }
        else if ( ERROR == GetFileVersion( l_pTargetPath, l_pTargetVersion ) )
        {
          if ( FALSE == FileExists(l_pTargetPath) )
          {
            l_bIsNew = TRUE;
          }
          l_bUpgRequired = TRUE;
          UPGLogMsg ( "<%s> will be installed (%s)\n",l_pTargetPath,l_pSourceVersion,0,0,0,0 );
        }
        else if ( strcmp(l_pSourceVersion,l_pTargetVersion) || (FORCE_SOFTWARE_UPGRADE == 1) )
        {
          l_bUpgRequired = TRUE;
          UPGLogMsg ( "<%s> need update from %s to %s\n",l_pTargetPath,l_pTargetVersion,l_pSourceVersion,0,0,0 );
        }
        // Also check CRCs in case of same version number
        else
        {
          if ( ERROR == ReadFileCRC( l_pSearchResult, l_pSourceCRC ) )
          {
            strcpy (l_tempString, "ERROR: Cannot read CRC of ");
            strcat (l_tempString, l_pSearchResult);
            AddUPGHistoryCommentary (l_tempString);
            UPGLogMsg ("%s\n", l_tempString, 0, 0, 0, 0, 0);
            l_status = ERROR;
          }
          else if ( ERROR == ReadFileCRC( l_pTargetPath, l_pTargetCRC ) )
          {
            l_bUpgRequired = TRUE;
            UPGLogMsg ( "WARNING: Cannot read CRC of %s\n",l_pTargetPath,0,0,0,0,0 );
            UPGLogMsg ( "<%s> will be installed (%s)\n",l_pTargetPath,l_pSourceVersion,0,0,0,0 );
          }
          else if ( strcmp( l_pSourceCRC, l_pTargetCRC ) )
          {
            l_bUpgRequired = TRUE;
            UPGLogMsg ( "<%s> CRC differs from source (%s to %s)\n",l_pTargetPath,l_pTargetCRC,l_pSourceCRC,0,0,0 );
            UPGLogMsg ( "File will be updated (%s)\n",l_pTargetVersion,0,0,0,0,0 );
          }
          // Also check file on HDD
          else if ( ERROR == CheckCRCFile( l_pTargetPath ) )
          {
            l_bUpgRequired = TRUE;
            UPGLogMsg ( "CheckCRCFile failed on <%s>\n",l_pTargetPath,0,0,0,0,0 );
            UPGLogMsg ( "<%s> will be installed (%s)\n",l_pTargetPath,l_pSourceVersion,0,0,0,0 );
          }
        }
      }
    }

    // Get file size
    if ( OK == l_status )
    {
      if ( ERROR == GetFileSize(l_pSearchResult, &l_iSize) )
      {
        strcpy (l_tempString, "GetFileSize ERROR on ");
        strcat (l_tempString, l_pSearchResult);
        AddUPGHistoryCommentary (l_tempString);
        UPGLogMsg ("%s\n", l_tempString, 0, 0, 0, 0, 0);
        l_status = ERROR;
      }
      else
      {
        l_total_size_examined += l_iSize;
        l_percentage = (int)((((long double)(l_total_size_examined)) / ((long double)TOTAL_SIZE_OF_APPLI))*100);
        StepBargraph( "CRC", l_percentage );
      }
    }

    // If the file needs an update
    if ( TRUE == l_bUpgRequired )
    {
      // Check file coherency
      if ( ( OK == l_status ) && ( ENABLE_CRC_CHECK == 1 ) )
      {
        strcpy ( l_pInfPath, l_pSearchResult );
        strcat ( l_pInfPath, ".inf" );

        if ( TRUE == FileExists ( l_pInfPath ) )
        {
          if ( ERROR == CheckCRCFile( l_pSearchResult ) )
          {
            strcpy (l_tempString, "FATAL ERROR : CheckCRCFile ERROR on ");
            strcat (l_tempString, l_pSearchResult);
            AddUPGHistoryCommentary (l_tempString);
            UPGLogMsg ("%s\n", l_tempString, 0, 0, 0, 0, 0);
            l_status = ERROR;
          }
        }
      }

      // Insert into soft upg list
      if ( OK == l_status )
      {
        p_pList[l_iCountInserted].m_iIsNew = l_bIsNew;
        p_pList[l_iCountInserted].m_iSize = l_iSize;
        *p_pTotalSize += l_iSize;
        strcpy (p_pList[l_iCountInserted].m_pFileName, l_pSearchResult);
        strcpy (p_pList[l_iCountInserted].m_pTargetPath, l_pTargetPath);
        strcpy (p_pList[l_iCountInserted].m_pVersion, l_pSourceVersion);
        l_iCountInserted++;

        // If there is an associated inf file, insert it in list
        if ( TRUE == FileExists(l_pInfPath) )
        {
          if ( TRUE == l_bIsNew )
          {
            UPGLogMsg ( "<%s.inf> will be installed\n",l_pTargetPath,0,0,0,0,0 );
          }
          else
          {
            UPGLogMsg ( "<%s.inf> will be updated\n",l_pTargetPath,0,0,0,0,0 );
          }
          p_pList[l_iCountInserted].m_iIsNew = l_bIsNew;
          if ( ERROR == GetFileSize(l_pInfPath, &l_iSize) )
          {
            strcpy (l_tempString, "GetFileSize ERROR on ");
            strcat (l_tempString, l_pInfPath);
            AddUPGHistoryCommentary (l_tempString);
            UPGLogMsg ("%s\n", l_tempString, 0, 0, 0, 0, 0);
            l_status = ERROR;
          }
          else
          {
            p_pList[l_iCountInserted].m_iSize = l_iSize;
            *p_pTotalSize += l_iSize;
            strcpy (p_pList[l_iCountInserted].m_pFileName, l_pSearchResult);
            strcat (p_pList[l_iCountInserted].m_pFileName, ".inf");
            strcpy (p_pList[l_iCountInserted].m_pTargetPath, l_pTargetPath);
            strcat (p_pList[l_iCountInserted].m_pTargetPath, ".inf");
            strcpy (p_pList[l_iCountInserted].m_pVersion, l_pSourceVersion);
            l_iCountInserted++;
          }
        }
      }
    }
  }

  UPGLogMsg("PrepareUPGSoft -, Time = %ld\n",tickGet(),0,0,0,0,0);

  return ( l_status ) ;
}


STATUS PrepareSoftUpg ( t_SoftUpgData *p_pList,
                        char *p_pSourceDrive,
                        char *p_pRootDir,
                        char *p_pMask,
                        char *p_pTargetDrive,
                        char *p_pSearchParams[],
                        int   p_iNbSearchParams,
                        int   p_pCheckVersion,
                        unsigned long *p_pTotalSize
                      )
{
  STATUS l_Status = OK;
  char l_pTargetPath[MAX_PATH_LENGTH];

  strcpy (l_pTargetPath, p_pRootDir);
  l_Status = PrepareSoftUpg_AbsolutePath ( p_pList,
                        p_pSourceDrive,
                        p_pRootDir,
                        p_pMask,
                        p_pTargetDrive,
                        l_pTargetPath,
                        p_pSearchParams,
                        p_iNbSearchParams,
                        p_pCheckVersion,
                        p_pTotalSize
                      );

  return (l_Status);
 }


STATUS InstallSoftList( t_SoftUpgData  *p_pList,
                        unsigned long   p_lTotalSize,
                        t_UPGType       p_tUpgType,
                        unsigned long  *p_pCompletedSize,
                        BOOL            p_use_temp_names_for_recovery,
                        double         *l_CountFilesCopied,
                        double          l_CountFilesToBeCopied
                      )
{
  STATUS        l_status = OK;
  STATUS        l_copyOK = ERROR;
  int           l_i;
  int           l_cpt;
  unsigned long l_lCompletedSize = *p_pCompletedSize;
  unsigned int  l_percentage = 0;
  char          l_target_path[MAX_PATH_LENGTH];
  char          l_actualCRC[MAX_PATH_LENGTH];
  char          l_readCRC[MAX_PATH_LENGTH];
  char          l_DummyString[MAX_STRING_LENGTH];
  int           l_CopyIntegrity = ERROR;
  int           l_retry = 0;

  EnableHistoryHandler (FALSE);

  //Go through file list
  for ( l_i=0; 0 != p_pList[l_i].m_iSize; l_i++ )
  {
    (*l_CountFilesCopied) ++;
    l_percentage = (unsigned int)(((*l_CountFilesCopied) / l_CountFilesToBeCopied)*100.0);
    StepBargraph ( "", l_percentage );

    //Try and retry to install
    l_CopyIntegrity = ERROR;
    for ( l_retry=0; (l_retry < 3) && (ERROR == l_CopyIntegrity); l_retry++)
    {
      //Construct the target path in case of recovery
      strcpy( l_target_path, p_pList[l_i].m_pTargetPath );
      if ( ( TRUE == p_use_temp_names_for_recovery ) &&
           ( NORMAL == p_tUpgType ) )
      {
        strcat( l_target_path, ".UPG" );
      }

      //File copy
      l_copyOK = UPGCopy( p_pList[l_i].m_pFileName, l_target_path, FALSE);
      //Retry 3 times in case of copy failure
      for( l_cpt=0; (l_cpt<3) && (OK != l_copyOK) ; l_cpt++)
      {
        l_copyOK = UPGCopy( p_pList[l_i].m_pFileName, l_target_path, FALSE);
      }

      if ( ERROR == l_copyOK )
      {
        strcpy (l_DummyString, "Error copying ");
        strcat (l_DummyString, p_pList[l_i].m_pFileName);
        EnableHistoryHandler (TRUE);
        AddUPGHistoryCommentary (l_DummyString);
        EnableHistoryHandler (FALSE);
        UPGLogMsg ( "%s\n",(char*)l_DummyString,0,0,0,0,0 );
        l_status = ERROR;
        break;
      }
      else
      {
        //Check that source and target CRC matches
        if( ( NULL == strstr( p_pList[l_i].m_pFileName, ".inf" ) ) &&
            ( NULL == strstr( p_pList[l_i].m_pFileName, ".ini" ) ) &&
            ( NULL == strstr( p_pList[l_i].m_pFileName, ".INI" ) ) )
        {
          //Compute target file CRC
          if ( ERROR == ComputeCRCFile(l_target_path,l_actualCRC) )
          {
            UPGLogMsg( "WARNING: Cannot compute CRC on file %s\n",(char*)l_target_path,0,0,0,0,0 );
            l_CopyIntegrity = OK;
          }
          else
          {
            //Read source file CRC
            if ( ERROR == ReadFileCRC(p_pList[l_i].m_pFileName, l_readCRC) )
            {
              UPGLogMsg( "WARNING: Cannot read CRC of file %s\n",(char*)p_pList[l_i].m_pFileName,0,0,0,0,0 );
              l_CopyIntegrity = OK;
            }
            else
            {
              //Compare
              if ( strcmp(l_readCRC, l_actualCRC) )
              {
                UPGLogMsg( "ERROR: CRC of file %s differs after copy (%s -> %s)\n",
                        (char*)l_target_path,(char*)l_readCRC,(char*)l_actualCRC,0,0,0 );
              }
              else
              {
                //Copy succeded
                l_CopyIntegrity = OK;

                //Progress bargraph
                l_lCompletedSize += p_pList[l_i].m_iSize;
              }
            }
          }
        }
        else
        {
          l_CopyIntegrity = OK;
        }
      }
    }

    if (ERROR == l_CopyIntegrity)
    {
      EnableHistoryHandler (TRUE);
      AddUPGHistoryCommentary ("FATAL COPY ERROR!!!\n");
      UPGLogMsg( "FATAL COPY ERROR!!!\n",0,0,0,0,0,0 );
      l_status = ERROR;
      break;
    }
  }

  EnableHistoryHandler (TRUE);
  if ( OK == l_status )
  {
    *p_pCompletedSize = l_lCompletedSize;
  }

  return ( l_status );
}


STATUS SaveSoftUpgList(t_SoftUpgData *p_pList, char *p_pFilePath)
{
  STATUS l_status = OK;
  FILE* l_pFile = NULL;
  int l_i;

  if ( NULL == (l_pFile = fopen(p_pFilePath , "a") ) )
  {
    UPGLogMsg ( "Error opening %s\n",p_pFilePath,0,0,0,0,0 );
    l_status = ERROR;
  }
  else
  {
    for (l_i=0; (l_i<MAX_APPLI_FILES)&&((p_pList[l_i].m_iSize)>0) ; l_i++)
    {
      if( TRUE == p_pList[l_i].m_iIsNew )
      {
        fputs("NEW\n", l_pFile);
      }
      else
      {
        fputs("UPDATE\n", l_pFile);
      }
      fputs(p_pList[l_i].m_pTargetPath, l_pFile);
      fputs("\n", l_pFile);
    }
    fclose( l_pFile );
  }

  return ( l_status );
}

STATUS SetOKInListFile(char* p_pFilePath)
{
  STATUS l_status = OK;
  FILE* l_pFile;

  if ( NULL == (l_pFile = fopen( p_pFilePath , "a" ) ) )
  {
    UPGLogMsg ( "Error opening %s\n",p_pFilePath,0,0,0,0,0 );
    l_status = ERROR;
  }
  else
  {
    fputs("OK\n", l_pFile);
    fclose( l_pFile );
  }

  return ( l_status );
}


STATUS ValidateSoftChanges(t_SoftUpgData *p_pList)
{
  STATUS l_status = OK;
  int l_i;
  char l_pPath[MAX_PATH_LENGTH];
  char l_pPathOLD[MAX_PATH_LENGTH];
  char l_pPathUPG[MAX_PATH_LENGTH];

  for(l_i=0; p_pList[l_i].m_iSize; l_i++)
  {
    strcpy ( l_pPath , p_pList[l_i].m_pTargetPath );
    strcpy ( l_pPathOLD , p_pList[l_i].m_pTargetPath );
    strcat ( l_pPathOLD , ".OLD" );
    strcpy ( l_pPathUPG , p_pList[l_i].m_pTargetPath );
    strcat ( l_pPathUPG , ".UPG" );

    if( FALSE == p_pList[l_i].m_iIsNew )
    {
      if ( ERROR == mv(l_pPath,l_pPathOLD) )
      {
        UPGLogMsg ( "ERROR mv %s %s\n",l_pPath,l_pPathOLD,0,0,0,0 );
      }
    }
    if ( ERROR == mv(l_pPathUPG,l_pPath) )
    {
      UPGLogMsg ( "ERROR mv %s %s\n",l_pPathUPG,l_pPath,0,0,0,0 );
    }
  }

  return ( l_status );
}


int FileExists(char *p_pPath)
{
  FILE* l_pFich = NULL;

  if ( NULL == ( l_pFich = fopen (p_pPath,"r") ) )
  {
    return(FALSE);
  }
  else
  {
    fclose(l_pFich);
    return(TRUE);
  }
}


void CheckAndCopySIRFdirIfExist(char* p_pSourceDrive)
{

  char l_input_SIRF_dir[UPG_SIRF_PATH_MAX_SIZE];
  char l_output_SIRF_dir[UPG_SIRF_PATH_MAX_SIZE];
  DIR* l_src_dir = NULL;
  DIR* l_dest_dir = NULL;
  int l_isSIRFexistOnNavDrive = -1;

  //initialize input and output dir
  strcpy (l_input_SIRF_dir, p_pSourceDrive);
  strcpy (l_output_SIRF_dir, DRIVE_NAV);
  //complete input and output dir by adding SIRF to the path
  strcat (l_input_SIRF_dir, UPG_SIRF_DIR);
  strcat (l_output_SIRF_dir, UPG_SIRF_DIR);

  //check the presence of SIRF on upgrade media.
  l_src_dir = opendir ((char *)l_input_SIRF_dir);
  if (NULL == l_src_dir)
  {
    //SIRF dir not found on upgrade media.
    UPGLogMsg ( "Cant read input dir\n input=%s \n",
                l_input_SIRF_dir,
                0,0,0,0,0 );
  }
  else  //SIRF dir not found on upgrade media.
  {
    //check the presence of SIRF on /SDH.
    l_dest_dir = opendir ((char *)l_output_SIRF_dir);
    if (NULL == l_dest_dir)
    {
      //dir does not exist so create it.
      if ( OK == UPGMKDir(l_output_SIRF_dir) )
      {
        //dir has been created
        l_isSIRFexistOnNavDrive = 0;
      }
      else
      {
        UPGLogMsg ( "ERROR Cant create output dir\n output=%s \n",
                l_output_SIRF_dir,
                0,0,0,0,0 );
      }

    }
    else
    {
      //dir already exist
      l_isSIRFexistOnNavDrive = 0;
      closedir(l_dest_dir);
      //delete dir
      xdelete(l_output_SIRF_dir);
    }

    if (0 == l_isSIRFexistOnNavDrive)
    {
      if (OK == xcopy(l_input_SIRF_dir, l_output_SIRF_dir))
      {
        UPGLogMsg ("xCopy\n input=%s \noutput=%s\nERROR\n",
                   l_input_SIRF_dir,l_output_SIRF_dir,0,0,0,0 );
      }
      else
      {
        UPGLogMsg ("ERROR xCopy\n input=%s \noutput=%s\nERROR",
                    l_input_SIRF_dir,
                    l_output_SIRF_dir,
                    0,0,0,0 );
      }
    }

    //close input dir
    closedir(l_src_dir);
  }

}



STATUS CleanRecoveryFiles(t_SoftUpgData *p_pList)
{
  STATUS l_status = OK;
  int l_i;
  char l_pPath[MAX_PATH_LENGTH];

  for( l_i=0; (l_i<MAX_APPLI_FILES) && (p_pList[l_i].m_iSize ) ; l_i++)
  {
    if ( FALSE == p_pList[l_i].m_iIsNew )
    {
      strcpy( l_pPath, p_pList[l_i].m_pTargetPath );
      strcat( l_pPath, ".OLD" );
      xdelete( l_pPath );
    }
  }

  return(l_status);
}


/* TO AVOID TIMEOUT ON GATEWAYS FROM CDROM */
STATUS GetFileName( char *p_pPath, char *p_pFileName )
{
  STATUS l_status = OK;

  int l_i = strlen(p_pPath);
  while ( l_i>0 )
  {
    if ( '/' == p_pPath[l_i] )
    {
      strcpy( p_pFileName, p_pPath+l_i+1 );
      break;
    }
    else
    {
      l_i--;
    }
  }

  return(l_status);
}



void   BuildUpgradePrep (int p_iRenesasVers,
                         char* p_path,
                         char* p_config_vers2009,
                         char* p_config_vers2010)
{

  if (2009 == p_iRenesasVers)
  {
    strcat (p_path, p_config_vers2009);
  }
  else if (2010 == p_iRenesasVers)
  {
    strcat (p_path, p_config_vers2010);
  }
  else
  {
    strcat (p_path, p_config_vers2010);
  }
  strcat (p_path, "/");

}



STATUS PrepareDbDwnlUpg( t_SoftUpgData *p_list,
                         char *p_source_drive,
                         char *p_root,
                         unsigned long *p_total_size)
{
  char l_source_path[MAX_PATH_LENGTH];
  char l_target_path[MAX_PATH_LENGTH];
  char l_source_version[MAX_VERSION_LENGTH];
  char l_target_version[MAX_VERSION_LENGTH];
  char l_tempString[MAX_STRING_LENGTH];
  STATUS l_status = OK;
  BOOL l_upg_required = FALSE;
  int l_is_new = FALSE;
  int l_size = 0;
  int l_i;
  int l_is_new;

  if ( TRUE == FileExists("/SDH/CD.INF") )
  {
     UPGDelete("/SDH/CD.INF");
     UPGLogMsg("/SDH/CD.INF has been deleted\n",0,0,0,0,0,0 );
  }

  strcpy( l_target_version ,"");

  UPGLogMsg ( "PrepareDbDwnlUpg +, Time = %ld\n",tickGet(),0,0,0,0,0 );

  //Compute source path
  strcpy( l_source_path, p_source_drive );
  if( NULL != p_root )
  {
    if ( strlen( p_root ) > 1 )
    {
      strcat( l_source_path, p_root );
    }
  }
  strcat( l_source_path, "/" );
  strcat( l_source_path, DB_DWNL_FILE );

  //Compute target path
  strcpy( l_target_path, DRIVE_NAV );
  strcat( l_target_path, "/" );
  strcat( l_target_path, DB_DWNL_FILE );

  //Get CD file version
  if (ERROR == GetFileVersion (l_source_path, l_source_version))
  {
    UPGLogMsg("PrepareDbDwnlUpg unable to check version of file '%s'\n",
              l_source_path,0,0,0,0,0);
    l_upg_required = TRUE;
  }
  else
  {
    //Check current target file integrity
    if ( OK == CheckCRCFile( l_target_path ) )
    {
      //Test versions
      if ( OK == GetFileVersion( l_target_path, l_target_version ) )
      {
        if ( atoi(l_source_version) > atoi(l_target_version) )
        {
          l_upg_required = TRUE;
        }
      }
      else
      {
        l_upg_required = TRUE;
      }
    }
    else
    {
      l_upg_required = TRUE;
    }
  }

  //if update required...
  if ( ( OK == l_status ) && ( TRUE == l_upg_required ) )
  {
    //check new file integrity
    if ( OK == CheckCRCFile ( l_source_path ) )
    {
      for ( l_i=0; (l_i<MAX_APPLI_FILES) && (p_list[l_i].m_iSize) ; l_i++ )
      {}

      if ( MAX_APPLI_FILES <= l_i+2 )
      {
        AddUPGHistoryCommentary ("PrepareDbDwnlUpg too much file in list");
        UPGLogMsg("PrepareDbDwnlUpg too much file in list\n",0,0,0,0,0,0);
        l_status = ERROR;
      }
      else
      {
        if ( OK == GetFileSize( l_source_path, &l_size) )
        {
          if ( FALSE == FileExists( l_target_path ) )
          {
            l_is_new = TRUE;
          }
          p_list[l_i].m_iIsNew = l_is_new;
          p_list[l_i].m_iSize = l_size;
          *p_total_size += l_size;
          strcpy (p_list[l_i].m_pFileName, l_source_path);
          strcpy (p_list[l_i].m_pTargetPath, l_target_path);
          strcpy (p_list[l_i].m_pVersion, l_source_version);
          l_i++;
          strcpy (p_list[l_i].m_pFileName, l_source_path);
          strcpy (p_list[l_i].m_pTargetPath, l_target_path);
          strcpy (p_list[l_i].m_pVersion, l_source_version);
          strcat (p_list[l_i].m_pFileName, ".inf");
          strcat (p_list[l_i].m_pTargetPath, ".inf");
          p_list[l_i].m_iSize = 100;
          l_i++;
          p_list[l_i].m_iSize = 0;

        }
        else
        {
          strcpy (l_tempString, "PrepareDbDwnlUpg unable to read the size of file ");
          strcat (l_tempString, l_source_path);
          AddUPGHistoryCommentary (l_tempString);
          UPGLogMsg ("%s\n", l_tempString, 0, 0, 0, 0, 0);
          l_status = ERROR;
        }
      }
    }
    else
    {
      strcpy (l_tempString, "PrepareDbDwnlUpg unable to check CRC of file ");
      strcat (l_tempString, l_source_path);
      AddUPGHistoryCommentary (l_tempString);
      UPGLogMsg ("%s\n", l_tempString, 0, 0, 0, 0, 0);
      l_status = ERROR;
    }
  }

  if ( OK == l_status )
  {
    if ( TRUE == l_upg_required )
    {
      if ( (TRUE == l_is_new) || (0==strlen(l_target_version)) )
      {
        UPGLogMsg("<%s> will be installed (%s)\n",
                  l_target_path, l_source_version, 0, 0, 0, 0);
      }
      else
      {
        UPGLogMsg("<%s> need update from %s to %s\n",
                  l_target_path, l_target_version, l_source_version, 0, 0, 0);
      }
    }
    else
    {
      if ( 0 != strlen ( l_target_version ) )
      {
        UPGLogMsg("<%s> is up to date (%s)\n",
                l_target_path, l_target_version, 0, 0, 0, 0);
      }
    }
  }

  UPGLogMsg ( "PrepareDbDwnlUpg - Time = %ld\n",tickGet(),0,0,0,0,0 );

  return ( l_status );
}

void CleanLine(char * p_pLine)
{
	int l_i;

	// remove eol
	l_i = strlen(p_pLine)-1;
	while(p_pLine[l_i] == '\n') l_i--;
	while(p_pLine[l_i] == '\r') l_i--;
	p_pLine[l_i+1]='\0';
}

void RemoveUnwantedFiles(char *p_pSourceDrive)
{
  STATUS l_status = OK;
  char l_filename[MAX_PATH_LENGTH];
  FILE *l_file = NULL;
  char l_line[MAX_INF_LINE_LENGTH];
  int l_counter = 0 ;

  //Get unwanted files to remove from target
  strcpy(l_filename,p_pSourceDrive);
  strcat(l_filename,"/");
  strcat(l_filename,UNWANTED_FILES);
  UPGLogMsg ( "l_filename %s\n",(int)l_filename,0,0,0,0,0 );

  if ( NULL == l_filename )
  {
    UPGLogMsg("RemoveUnwantedFiles: filename is NULL\n",0,0,0,0,0,0);
    l_status = ERROR ;
  }
  else
  {
    l_file = fopen ( (char*)l_filename, "r" );

    if ( NULL == l_file )
    {
      l_status = ERROR ;
      UPGLogMsg("RemoveUnwantedFiles: open %s ERROR\n",l_file,0,0,0,0,0);
    }
    else
    {
      while ( NULL != fgets(l_line, MAX_INF_LINE_LENGTH, l_file) )
      {
        UPGLogMsg("Remove file %s\n",l_line,0,0,0,0,0);
        CleanLine(l_line);
        UPGDelete( l_line );
        l_counter++;
      }
      fclose ( l_file );
    }
  }
}

void RemoveUnwantedDirectories(char *p_pSourceDrive)
{
  STATUS l_status = OK;
  char l_filename[MAX_PATH_LENGTH];
  FILE *l_file = NULL;
  char l_line[MAX_INF_LINE_LENGTH];
  int l_counter = 0 ;

  UPGLogMsg("\n*** \nRemoveUnwantedDirectories\n ****\n",l_file,0,0,0,0,0);
  //Get unwanted directories to remove from target
  strcpy(l_filename,p_pSourceDrive);
  strcat(l_filename,"/");
  strcat(l_filename,UNWANTED_DIRECTORIES);
  UPGLogMsg ( "l_filename %s\n",(int)l_filename,0,0,0,0,0 );

  if ( NULL == l_filename )
  {
    UPGLogMsg("RemoveUnwantedDirectories: filename is NULL\n",0,0,0,0,0,0);
    l_status = ERROR ;
  }
  else
  {
    l_file = fopen ( (char*)l_filename, "r" );

    if ( NULL == l_file )
    {
      l_status = ERROR ;
      UPGLogMsg("RemoveUnwantedDirectories: open %s ERROR\n",l_file,0,0,0,0,0);
    }
    else
    {
      while ( NULL != fgets(l_line, MAX_INF_LINE_LENGTH, l_file) )
      {
        CleanLine(l_line);
        UPGLogMsg("Remove dir %s\n",l_line,0,0,0,0,0);
        xdelete( l_line );
        UPGMKDelete( l_line );
        l_counter++;
      }
      fclose ( l_file );
    }
  }
}

STATUS CheckAndRepairSDs (void)
{
  STATUS l_Ret = OK;
  STATUS l_Status = OK;

  UPGLogMsg ("****** CheckAndRepairSDs +, Time = %ld ******\n", tickGet(), 0, 0, 0, 0, 0);
  UPGLogMsg ("****** Result : OK=0, REPAIRED = 1, FORMATED = 2, FAILED = 3\n", 0, 0, 0, 0, 0, 0);

  l_Status = CheckAndRepair (DRIVE_HDD);
  UPGLogMsg ("CheckAndRepairSD 'Appli', Result=%d, Time = %ld\n", l_Status, tickGet(), 0, 0, 0, 0);
  if (FLASHER_CHK_PARTDEVICE_FAIL == l_Status)
  {
    AddUPGHistoryCommentary ("CheckAndRepairSD 'Appli' Failed !");
    l_Ret = ERROR;
  }

  l_Status = CheckAndRepair (DRIVE_NAV);
  UPGLogMsg ("CheckAndRepairSD 'Nav',   Result=%d, Time = %ld\n", l_Status, tickGet(), 0, 0, 0, 0);
  if (FLASHER_CHK_PARTDEVICE_FAIL == l_Status)
  {
    AddUPGHistoryCommentary ("CheckAndRepairSD 'Nav' Failed !");
    l_Ret = ERROR;
  }

  l_Status = CheckAndRepair (DRIVE_USER);
  UPGLogMsg ("CheckAndRepairSD 'User',  Result=%d, Time = %ld\n", l_Status, tickGet(), 0, 0, 0, 0);
  if (FLASHER_CHK_PARTDEVICE_FAIL == l_Status)
  {
    AddUPGHistoryCommentary ("CheckAndRepairSD 'User' Failed !");
    l_Ret = ERROR;
  }


  UPGLogMsg ("****** CheckAndRepairSDs -, Time = %ld ******\n", (int)tickGet(), 0, 0, 0, 0, 0);

  return (l_Ret);
}