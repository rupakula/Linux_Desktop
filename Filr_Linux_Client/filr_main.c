#define FUSE_USE_VERSION 30
#define MAX_PASSWORD 80
#define FALSE 0
#define CURL_STATICLIB
#include <fuse.h>
#include <string.h>
#include <fcntl.h>
#include<syslog.h>
#include<stdio.h>
#include<sys/types.h>
#include<stdlib.h>
#include<sys/stat.h>
#include<string.h>
#include<errno.h>
#include<unistd.h>
#include<curl/curl.h>
#include <termios.h>
#include <stdio.h>

char fileread[255], *userid;
char *userid1,command[200];
int fa, fs,return_status=0,attempt=0;
char dirname[255], username[200], ipaddress[200],request1[100],resturl[200];
char *password1;
CURL *curl;

char* getFolderNamefromAbsolutePath(const char*,int);
char *getuserid(char*);
int executeCurl();
int Login();
char* getproperty(char *,char *);
ssize_t getpasswd (char **lineptr, size_t *n, FILE *stream);
size_t write_callback(void *ptr, size_t size, size_t nmemb, void *stream);
int getStatus(long,int);

static int
hello_readdir (const char *path, void *buf, fuse_fill_dir_t filler,
	       off_t offset, struct fuse_file_info *fi)
{
 



  return 0;

}

static int hello_write(const char *path, const char *buf, size_t size,
                     off_t offset, struct fuse_file_info *fi)
{
  
        return 0;

}
static int
hello_read (const char *path, char *buf, size_t size, off_t offset,
	    struct fuse_file_info *fi)
{
  return 0;
}

static int
hello_getattr (const char *path, struct stat *stbuf)
{
  
      return 0;
    }
    
  
  
 
static int
hello_access (const char *path, int mask)
{
  
  return 0;
}
static int
hello_mkdir (const char *path, mode_t mode)
{
return 0;
}
static int
hello_rmdir (const char *path, mode_t mode)
{
return 0;
}

static int
hello_create (const char *path, struct fuse_file_info *fi)
{

return 0;
}
static int
hello_unlink (const char *path)
{

return 0;
}
#ifdef HAVE_UTIMENSAT
static int hello_utimens(const char *path, const struct timespec ts[2])
{

        return 0;
}
#endif

static struct fuse_operations hello_oper = {
  .getattr = hello_getattr,
  .access = hello_access,
  .readdir = hello_readdir,
  .read = hello_read,
  .mkdir=hello_mkdir,  
   .rmdir=hello_rmdir,
    
    .create=hello_create,
   .unlink=hello_unlink,
  

#ifdef HAVE_UTIMENSAT
        .utimens        = hello_utimens,
#endif
   
};

int
main (int argc, char *argv[])
{

  FILE *fp2;
  int ret, sessionid, l;

  openlog ("Filr:", 0, LOG_USER);
//strcpy(ipaddress,"164.99.117.92");
//strcpy(username,"val1");
//strcpy(password,"novell");
 printf("Please enter the Filr Server IP address : ");
 gets(ipaddress);
 
  l = Login ();

  if (l!= 0)
    {
      syslog (LOG_INFO,"\nUnable to Login:\n");
      syslog (LOG_INFO, "Unable to Login to the server :\n");
      exit (1);
    }
  else
    {
      syslog(LOG_INFO,"\nWelcome %s\n", username);
      syslog (LOG_INFO, "Logged in succesfully as %s", username);
      fuse_main (argc, argv, &hello_oper, NULL);


    }
  return 0;
  fuse_main (argc, argv, &hello_oper, NULL);


}

int
Login ()
{
  
  int sessionid, return_status, login_status;
  FILE *fp = stdin;
  ssize_t nchr = 0;
  ssize_t mp=(ssize_t)MAX_PASSWORD;
  char password[MAX_PASSWORD];
  
  password1=password;
  syslog (LOG_INFO, "Logging in:\n");

  printf ("Enter the name :");
  gets (username);


  printf ("Enter the password:");
  fflush(stdout);
 
 
    printf ( " Enter password: ");
nchr = getpasswd (&password1, &mp, fp);
    printf("The username and  password entered are %s %s",username,password1);

  return executeCurl();
}
char* getFolderNamefromAbsolutePath(const char* abpath,int num)
{
return "hello";
}

int executeCurl()
{ 
int command[500],buffer[100],*fname,*url,*request;
FILE *fp;
//CURL *curl;
CURLcode res;
int len=255;
struct stat stbuf1;
struct curl_slist *headers = NULL;
long http_code=0;
request=(char *)malloc(1024*sizeof(char *));
url=(char *)malloc(1024*sizeof(char *));
strcpy(request,"rest");
    curl_slist_append(headers, "Accept: application/json");
    curl_slist_append(headers, "Content-Type: application/json");
    curl_slist_append(headers, "charsets: utf-8");
 curl_global_init(CURL_GLOBAL_DEFAULT);
 
  curl = curl_easy_init();
  if(!curl)
  {
 syslog(LOG_INFO,"Intailizing Curl Failed.Hence exiting");
 exit(1);
}
  else {
    
syslog(LOG_INFO,"%s %s",username,password1);      
curl_easy_setopt(curl, CURLOPT_USERNAME,username );
  
curl_easy_setopt(curl, CURLOPT_PASSWORD, password1);
sprintf (url,
               "https://%s:8443/%s",ipaddress,request);
syslog(LOG_INFO,"The URL request sent is  %s",url);
    curl_easy_setopt(curl, CURLOPT_URL, url);
   // curl_easy_setopt(curl,CURLOPT_NOBODY ,1 );
 curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, FALSE);
curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers); 
curl_easy_setopt(curl,CURLOPT_SSL_VERIFYHOST ,FALSE);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);


 /* Perform the request, res will get the return code */ 
    res = curl_easy_perform(curl);
    /* Check for errors */ 
    if(res != CURLE_OK)
      fprintf(stderr, "curl_easy_perform() failed: %s\n",
              curl_easy_strerror(res));
      

curl_easy_getinfo (curl, CURLINFO_RESPONSE_CODE, &http_code);
return getStatus(http_code,res);
}
}
int getStatus(long http_code,int res)
{ 


    
      
if ((http_code == 200||http_code==204) && res != CURLE_ABORTED_BY_CALLBACK)
{
         return 0;
}
else if(http_code==403 && res != CURLE_ABORTED_BY_CALLBACK)
       {
        return -EPERM;
        }
        else if(http_code==404  && res != CURLE_ABORTED_BY_CALLBACK)
       {
         return 17;
       }
      else
       return 5;
 
    /* always cleanup */ 
    curl_easy_cleanup(curl);
  
 
  curl_global_cleanup();


}
size_t write_callback(void *ptr, size_t size, size_t nmemb, void *stream){
FILE *fp1=fopen("/tmp/header.json","ab+");
if(fp1==NULL)
{
syslog(LOG_INFO,"Opening the rest response file failed:\n");
exit(1);
}
    fprintf(fp1,"%s",ptr );
fclose(fp1);
}
char* getuserid(char* request)
{
return "hello";
}

char* getproperty(char *fname,char *attr)
{
return "hello";
}

ssize_t
getpasswd (char **lineptr, size_t *n, FILE *stream)
{
  struct termios old, new;
  int nread;

  /* Turn echoing off and fail if we can’t. */
  if (tcgetattr (fileno (stream), &old) != 0)
    return -1;
  new = old;
  new.c_lflag &= ~ECHO;
  if (tcsetattr (fileno (stream), TCSAFLUSH, &new) != 0)
    return -1;
 // printf("Please enter the password:\n");
  /* Read the password. */
  nread = getline (lineptr, n, stream);

  /* Restore terminal. */
  (void) tcsetattr (fileno (stream), TCSAFLUSH, &old);

  return (ssize_t)nread;
}

