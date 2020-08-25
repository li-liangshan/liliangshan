#include <stdarg.h>
#include "error_functions.h"
#include "tlpi_hdr.h"
#include "ename.c.inc"

#ifdef __GNUC__
__attribute__ ((__noreturn__))
#endif

static void terminate(Boolean useExit3)
{
  char *s;
  s = getenv("EF_DUMPCORE");
  if (s != NULL && *s != '\0')
  {
    abort();
  } else if (useExit3)
  {
    exit(EXIT_FAILURE);
  }
  else {
    _exit(EXIT_FAILURE);
  }

}
