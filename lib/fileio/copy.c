#include <sys/stat.h>
#include <fcntl.h>
#include "tlpi_hdr.h"

#ifndef BUF_SIZE

#define BUF_SIZE 1024

#endif

int main(int argc, char *argv[])
{

  int inputFd, outputFd, openFlags;
  mode_t filePerms;
  ssize_t numRead;
  char buf[BUF_SIZE];

  if (argc != 3 || strcmp(argv[1], "--help") == 0)
  {
    usageErr("%s old-file new-file\n", argv[0]);
  }

  /** Open input and output files **/
  inputFd = open(argv[1], O_RDONLY);
  if (inputFd == -1)
  {
    errExit("opening file %s", argv[1]);
  }

  /* Transfer data util we encounter end of input or an error */

  while ((numRead = read(inputFd, buf, BUF_SIZE)) > 0)
  {
    if (write(outputFd, buf, numRead) != numRead)
    {
      fatal("couldn't write whole buffer ");
    }
  }

  if (numRead == -1)
  {
    errExit("read");
  }

  if (close(inputFd) == -1)
  {
    errExit("close input");
  }

  if (close(outputFd) == -1)
  {
    errExit("close output");
  }

  exit(EXIT_SUCCESS);
}
